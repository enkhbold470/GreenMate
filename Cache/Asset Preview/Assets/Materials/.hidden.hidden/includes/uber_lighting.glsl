//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------
#ifndef UBER_LIGHTING_GLSL
#define UBER_LIGHTING_GLSL

#include "pbr.glsl"
#include "envmap.glsl"
#include "spherical_harmonics.glsl"
#include "utils.glsl"


#ifdef FRAGMENT_SHADER
#ifdef ENABLE_LIGHTING

#define MAX_MIP_BIAS 13.0

uniform float envmapExposure;
uniform float envmapRotation;
uniform float reflBlurWidth;
uniform float reflBlurMinRough;
uniform float reflBlurMaxRough;


/////////////////////////////////////////////////////////////////////////////////////////////////////
// Ambient diffuse lighting

vec3 sampleDiffuseEnvmap(vec3 N) {
    vec2 uv = calcPanoramicTexCoordsFromDir(N, sc_EnvmapRotation.y);

#if sc_MaxTextureImageUnits > 8

    uv = calcSeamlessPanoramicUvsForSampling(uv, sc_EnvmapDiffuseSize.xy, 0.0);
    vec4 tex = texture2D(sc_EnvmapDiffuse, uv, -MAX_MIP_BIAS); // Must load the top mip, otherwise there will be a seam where the u coordinate wraps around from 1 to 0 in the panoramic mapping, because the derivatives get screwed up.

#else // #if sc_MaxTextureImageUnits > 8

    // If the hardware doesn't support more than 8 textures, don't sample the diffuse envmap, and emulate it with a low mip of the specular envmap.
    // This allows us to use one extra texture on the content side, since devices that support less textures will sample one less texture, and other devices are fine to sample more textures.
#ifdef GL_EXT_shader_texture_lod
    vec4 tex = texture2DLodEXT(sc_EnvmapSpecular, uv, sc_MaxRoughnessMip); // The max specular roughness equals diffuse convolution.
#else // #ifdef GL_EXT_shader_texture_lod
    vec4 tex = texture2D(sc_EnvmapSpecular, uv, sc_MaxRoughnessMip); // We are using simple mip bias here in the interest of performance, but all mips after sc_MaxRoughnessMip are diffuse convolutions anyway (even if low res).
#endif // #else // #ifdef GL_EXT_shader_texture_lod

#endif // #else // #if sc_MaxTextureImageUnits > 8

    return decodeRGBD(tex) * sc_EnvmapExposure;
}

vec3 calculateDiffuseIrradiance(vec3 N) {
    vec3 accumulatedLight = vec3(0.0);

    // Use environment light
#ifdef sc_EnvLightMode
#if sc_EnvLightMode == sc_AmbientLightMode_SphericalHarmonics
    accumulatedLight = evaluateSh(sc_Sh[0], sc_Sh[1], sc_Sh[2], sc_Sh[3], sc_Sh[4], sc_Sh[5], sc_Sh[6], sc_Sh[7], sc_Sh[8], -N) * sc_ShIntensity;
#elif sc_EnvLightMode == sc_AmbientLightMode_EnvironmentMap
    accumulatedLight = sampleDiffuseEnvmap(N);
#endif
#endif

    // Use ambient lights
#ifdef sc_AmbientLightsCount
#if sc_AmbientLightsCount > 0
#if sc_AmbientLightMode0==sc_AmbientLightMode_Constant
    accumulatedLight+=sc_AmbientLights[0].color * sc_AmbientLights[0].intensity;
#else
    accumulatedLight.r += SC_EPSILON * sc_AmbientLights[0].color.r; // HACK: 09/11/2018 Adreno drivers optimize out and rearrange array elements if no members are used, which breaks ambient light indexing. This is how we force it to not optimize.
#endif
#endif
#if sc_AmbientLightsCount > 1
#if sc_AmbientLightMode1==sc_AmbientLightMode_Constant
    accumulatedLight+=sc_AmbientLights[1].color * sc_AmbientLights[1].intensity;
#else
    accumulatedLight.r += SC_EPSILON * sc_AmbientLights[1].color.r;
#endif
#endif
#if sc_AmbientLightsCount > 2
#if sc_AmbientLightMode2==sc_AmbientLightMode_Constant
    accumulatedLight+=sc_AmbientLights[2].color * sc_AmbientLights[2].intensity;
#else
    accumulatedLight.r += SC_EPSILON * sc_AmbientLights[2].color.r;
#endif
#endif
#endif

    return accumulatedLight;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
// Ambient specular lighting

vec4 emulateTexture2DLod(sampler2D sampler, vec2 textureSize, vec2 uv, float lod) {
#if (__VERSION__ == 120)
    return texture2DLod(sampler, uv, lod);
#elif defined(GL_EXT_shader_texture_lod)
    return texture2DLodEXT(sampler, uv, lod);
#elif defined(GL_OES_standard_derivatives)
    vec2 texels = uv * textureSize;
    float dudx = dFdx(texels.x);
    float dvdx = dFdx(texels.y);
    float dudy = dFdy(texels.x);
    float dvdy = dFdy(texels.y);
    float rho = max(length(vec2(dudx, dvdx)), length(vec2(dudy, dvdy))); // OpenGL reference calculation
    float mu = max(abs(dudx), abs(dudy));
    float mv = max(abs(dvdx), abs(dvdy));
    float rho2 = max(mu, mv); // The allowed alternative OpoenGL reference calculation that seems to match the main reference best.
    float mip = log2(rho2);
    float bias = lod - mip;
    return texture2D(sampler, uv, bias);
#else
    #error Unsupported call to emulateTexture2DLod
#endif
}

vec4 sampleSpecularEnvTextureLod(vec2 uv, float lod) {
#if (__VERSION__ == 120) || defined(GL_EXT_shader_texture_lod) || defined(GL_OES_standard_derivatives)
	return emulateTexture2DLod(sc_EnvmapSpecular, sc_EnvmapSpecularSize.xy, uv, lod);
#else
    // If we don't have access to specific LODs, we fall back to blending between the pure glossy mip and the pure diffuse mip based on roughness.
    vec4 spec = texture2D(sc_EnvmapSpecular, uv, -MAX_MIP_BIAS);
    vec4 diff = texture2D(sc_EnvmapSpecular, uv, sc_MaxRoughnessMip);
    return mix(spec, diff, lod / sc_MaxRoughnessMip);
#endif
}

vec3 sampleSpecularEnvTextureLod(vec3 R, float lod) {
    vec2 uv = calcPanoramicTexCoordsFromDir(R, sc_EnvmapRotation.y);

#if defined(DEVICE_IS_FAST)
    // Seamless envmap lookup.
    // Since the seamless uv offset is specific per LOD, we can't use a trilinear filtered lookup directly.
    // We need to sample the two mips separately with the appropriate offset at each level, then blend manually.
    float lodFloor = floor(lod);
    float lodCeil = ceil(lod);
    float lodFrac = lod - lodFloor;

    vec2 uvFloor = calcSeamlessPanoramicUvsForSampling(uv, sc_EnvmapSpecularSize.xy, lodFloor);
    vec4 texFloor = sampleSpecularEnvTextureLod(uvFloor, lodFloor);

    vec2 uvCeil = calcSeamlessPanoramicUvsForSampling(uv, sc_EnvmapSpecularSize.xy, lodCeil);
    vec4 texCeil = sampleSpecularEnvTextureLod(uvCeil, lodCeil);

    vec4 tex = mix(texFloor, texCeil, lodFrac);
#else // ##if defined(DEVICE_IS_FAST)
    vec4 tex = sampleSpecularEnvTextureLod(uv, lod);
#endif // #else // ##if defined(DEVICE_IS_FAST)

    return decodeRGBD(tex);
}

vec3 sampleScreenTexture(vec2 uv, float lod)
{
#if defined(ENABLE_ENVMAP_FROM_CAMERA_ROUGHNESS) && defined(DEVICE_IS_FAST)
    const float maxRoughnessMipInv = 1.0/5.0;
    float r = lod * maxRoughnessMipInv;
    float reflectionRoughness = saturate((r - reflBlurMinRough) / (reflBlurMaxRough-reflBlurMinRough));
    vec2 pixelSize = vec2(1.0/720.0, 1.0/1280.0);
    vec3 blurred = vec3(0.0);
    const int NUM_SAMPLES = 5;
    vec2 offset = pixelSize * reflBlurWidth / float(NUM_SAMPLES) * reflectionRoughness;
    vec2 rnd = fract(uv * 1331711.0) - 0.5;
    //    uv += offset * rnd;
    uv -= offset * float(NUM_SAMPLES-1) * 0.5;
    for (int i = 0; i < NUM_SAMPLES; ++i) {
        for (int j = 0; j < NUM_SAMPLES; ++j) {
            blurred += texture2D(sc_ScreenTexture, uv + offset * vec2(i, j)).rgb;
        }
    }
    blurred *= 1.0 / float(NUM_SAMPLES * NUM_SAMPLES);
    return blurred;
#else // #if defined(ENABLE_ENVMAP_FROM_CAMERA_ROUGHNESS) && defined(DEVICE_IS_FAST)
    return texture2D(sc_ScreenTexture, uv).rgb;
#endif //#else // #if defined(ENABLE_ENVMAP_FROM_CAMERA_ROUGHNESS) && defined(DEVICE_IS_FAST)
}

vec3 sampleSpecularEnvmapLod(vec3 R, float lod) {
#ifdef ENABLE_ENVMAP_FROM_CAMERA

    R = (sc_ViewMatrix * vec4(R, 0.0)).xyz;
    vec2 uv = calculateEnvmapScreenToCube(R);
    return srgbToLinear(sampleScreenTexture(uv, lod));

#else // #ifdef ENABLE_ENVMAP_FROM_CAMERA

    vec3 res = sampleSpecularEnvTextureLod(R, lod) * sc_EnvmapExposure;

#ifndef MOBILE
    res += vec3(SC_EPSILON); // HACK 05/23/2018: Nvidia compiler messes up and kills specular AO without this.
#endif

    return res;

#endif // #else // #ifdef ENABLE_ENVMAP_FROM_CAMERA
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
// Evaluate lighting
// This function evaluates all lighting for a surface based on its surface properties and all the existing
// lighting in the environment (multiple lights, ambient, reflections, etc).

LightingComponents evaluateLighting(SurfaceProperties surfaceProperties, DebugOptions debug) {
    LightingComponents lighting = defaultLightingComponents();

    vec3 V = normalize(sc_Camera.position - varPos);

    int numLights = 0;
    vec4 bakedShadows = vec4(surfaceProperties.bakedShadows, 1.0);

#ifdef sc_DirectionalLightsCount
    // Directional lights
    for(int i = 0; i < sc_DirectionalLightsCount; ++i) {
        sc_DirectionalLight_t light = sc_DirectionalLights[i];
        LightProperties lightProperties;
        lightProperties.direction = light.direction;
        lightProperties.color = light.color.rgb;
        lightProperties.attenuation = light.color.a;
        lightProperties.attenuation *= bakedShadows[numLights < 3 ? numLights : 3];
        numLights++;
        lighting = accumulateLight(lighting, lightProperties, surfaceProperties, V);
    }
#endif // #ifdef sc_DirectionalLightsCount

#ifdef sc_PointLightsCount
    // Point lights
    for(int i = 0; i < sc_PointLightsCount; ++i) {
        sc_PointLight_t light = sc_PointLights[i];
        LightProperties lightProperties;
        lightProperties.direction = normalize(light.position - varPos);
        lightProperties.color = light.color.rgb;
        lightProperties.attenuation = light.color.a;
        lightProperties.attenuation *= bakedShadows[numLights < 3 ? numLights : 3];
        numLights++;
        lighting = accumulateLight(lighting, lightProperties, surfaceProperties, V);
    }
#endif // #ifdef sc_PointLightsCount

#ifdef sc_ProjectiveShadowsReceiver // TODO 2018/11/27: We should only shadow the light that is marked as "caster". To do it efficiently, we'd need to pass all light properties through defines and convert loops above to #-macro-s.
    vec3 shadowColor = evaluateShadow();
    lighting.directDiffuse *= shadowColor;
    lighting.directSpecular *= shadowColor;
#endif // sc_ProjectiveShadowsReceiver

#ifndef ENABLE_SPECULAR_LIGHTING
    lighting.directSpecular = vec3(0.0);
#endif

#ifndef ENABLE_DIFFUSE_LIGHTING
    lighting.directDiffuse = vec3(0.0);
#endif

    // Indirect diffuse
#ifdef ENABLE_DIFFUSE_LIGHTING
    lighting.indirectDiffuse = calculateIndirectDiffuse(surfaceProperties);
#else
    lighting.indirectDiffuse = vec3(0.0);
#endif

    // Indirect specular
#ifdef sc_EnvLightMode
#if sc_EnvLightMode == sc_AmbientLightMode_EnvironmentMap
    #define ENVMAP_IS_ENABLED
#endif
#endif
#if defined(ENABLE_SPECULAR_LIGHTING) && !defined(ENABLE_SIMPLE_REFLECTION) && (defined(ENVMAP_IS_ENABLED) || defined(ENABLE_ENVMAP_FROM_CAMERA))
    lighting.indirectSpecular = calculateIndirectSpecular(surfaceProperties, V, debug) + vec3(0.001);
#endif

    // Translucency
#ifdef ENABLE_TRANSLUCENCY_BROAD
#endif

#ifdef DEBUG
    // Debug sliders
    lighting.directDiffuse *= debug.directDiffuse;
    lighting.directSpecular *= debug.directSpecular;
    lighting.indirectDiffuse *= debug.indirectDiffuse;
    lighting.indirectSpecular *= debug.indirectSpecular;
#endif

    return lighting;
}

#endif // #ifdef ENABLE_LIGHTING
#endif // #ifdef FRAGMENT_SHADER

#endif // UBER_LIGHTING_GLSL
