//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------
#ifndef UBER_SURFACE_PROPERTIES_GLSL
#define UBER_SURFACE_PROPERTIES_GLSL

#include "pbr.glsl"
#include "utils.glsl"
#include <std_texture.glsl>


#ifdef FRAGMENT_SHADER


//-----------------------------------------------------------------------
// Local defines
//-----------------------------------------------------------------------
#if defined(ENABLE_UV3)
#define NUM_UVS 4
#elif defined(ENABLE_UV2)
#define NUM_UVS 3
#else
#define NUM_UVS 2
#endif

#ifdef DEVICE_IS_FAST
#define DEFAULT_MIP_BIAS 0.0
#else
#define DEFAULT_MIP_BIAS 1.0
#endif

#macro SAMPLE_TEX_UBER(NAME)
    SAMPLE_TEX(NAME, uvs[NAME##UV], DEFAULT_MIP_BIAS);
#endmacro


//-----------------------------------------------------------------------
// Uniforms
//-----------------------------------------------------------------------
DECLARE_TEXTURE(baseTex)
DECLARE_TEXTURE(opacityTex)
DECLARE_TEXTURE(detailTex)
DECLARE_TEXTURE(detailMaskTex)
DECLARE_TEXTURE(normalTex)
DECLARE_TEXTURE(normalMsbTex)
DECLARE_TEXTURE(normalLsbTex)
DECLARE_TEXTURE(detailNormalTex)
DECLARE_TEXTURE(materialParamsTex)
DECLARE_TEXTURE(emissiveTex)
DECLARE_TEXTURE(rimColorTex)
DECLARE_TEXTURE(reflectionTex)
DECLARE_TEXTURE(reflectionModulationTex)
DECLARE_TEXTURE(bakedShadowsTex)

uniform vec2 uv2Scale;
uniform vec2 uv2Offset;
uniform mat4 uv2Matrix;
uniform vec2 uv3Scale;
uniform vec2 uv3Offset;
uniform mat4 uv3Matrix;

uniform vec4 baseColor;
uniform float alphaTestThreshold;
uniform vec3 recolorRed;
uniform vec3 recolorGreen;
uniform vec3 recolorBlue;
uniform vec3 emissiveColor;
uniform float emissiveIntensity;
uniform float reflectionIntensity;
uniform vec3 rimColor;
uniform float rimIntensity;
uniform float rimExponent;
uniform float roughness;
uniform float metallic;
uniform float specularAoIntensity;
uniform float specularAoDarkening;


#ifdef ENABLE_STIPPLE_PATTERN_TEST
bool stipplePatternTest(highp float alpha) {
    vec2 localCoord = floor(mod(gl_FragCoord.xy, vec2(4.0)));
    float threshold = (mod(dot(localCoord, vec2(4.0, 1.0)) * 9.0, 16.0) + 1.0) / 17.0;

    return alpha >= threshold;
}
#endif // ENABLE_STIPPLE_PATTERN_TEST

vec3 overlayBlend(vec3 a, vec3 b) {
    vec3 isLess = vec3(lessThan(a, vec3(0.5)));
    return isLess * 2.0 * a * b + (1.0 - isLess) * (1.0 - 2.0 * (1.0-a) * (1.0-b));
}

vec3 detailNormalBlend(vec3 n1, vec3 n2) {
    // Reoriented normal mapping
    vec3 t = n1 + vec3(0.0, 0.0, 1.0);
    vec3 u = n2 * vec3(-1.0, -1.0, 1.0);
    return t*dot(t, u) - u*t.z;
}

vec3 fragNormal(vec2 uvs[NUM_UVS], float detailMask) {
#ifdef ENABLE_NORMALMAP

#ifdef ENABLE_HIGH_PRECISION_NORMALMAP
    SAMPLE_TEX_UBER(normalMsbTex);
    SAMPLE_TEX_UBER(normalLsbTex);
    vec4 msb = normalMsbTexSample;
    vec4 lsb = normalLsbTexSample;
    vec3 n;
    n.x = msb.x * (255.0 / 256.0 * 2.0) + lsb.x * (255.0 / 65536.0 * 2.0) - 1.0;
    n.y = msb.y * (255.0 / 256.0 * 2.0) + lsb.y * (255.0 / 65536.0 * 2.0) - 1.0;
    n.z = sqrt(1.0 - n.x * n.x - n.y * n.y);
#else // #ifdef ENABLE_HIGH_PRECISION_NORMALMAP
    SAMPLE_TEX_UBER(normalTex);
    vec3 n = normalTexSample.xyz * (255.0/128.0) - 1.0; // Make sure that RGB 128 actually maps to 0, otherwise there's no way to express straight up normals.
#endif // #else // #ifdef ENABLE_HIGH_PRECISION_NORMALMAP

#ifdef ENABLE_DETAIL_NORMAL
    SAMPLE_TEX_UBER(detailNormalTex);
    vec3 n2 = detailNormalTexSample.xyz * (255.0/128.0) - 1.0;
    n2 = mix(vec3(0.0, 0.0, 1.0), n2, detailMask);
    n = detailNormalBlend(n, n2);
#endif

#ifdef DEBUG
    n.xy *= vec2(DebugNormalIntensity);
#endif

    vec3 N = varNormal;
    vec3 T = varTangent;
    vec3 B = cross(N, T) * varBitangentSign;
    mat3 TBN = mat3(T, B, N);
    return normalize(TBN * n);

#else // #ifdef ENABLE_NORMALMAP

    return normalize(varNormal);

#endif // #else // #ifdef ENABLE_NORMALMAP
}

#macro CALCULATE_UV(INDEX)
#ifdef ENABLE_UV##INDEX
{
#if UV##INDEX##_SOURCE == SCREEN_UV
    uvs[INDEX] = varScreenTexturePos;
#elif UV##INDEX##_SOURCE == PROJECTED_UV
    vec4 projPos = uv##INDEX##Matrix * vec4(varPos, 1.0);
    uvs[INDEX] = (projPos.xy / projPos.w) * 0.5 + 0.5;
#else
    uvs[INDEX] = uvs[UV##INDEX##_SOURCE];
#endif

#ifdef ENABLE_UV##INDEX##_ANIMATION
    vec2 uvOffsetLocal = uv##INDEX##Offset * sc_TimeElapsed;
#else
    vec2 uvOffsetLocal = uv##INDEX##Offset;
#endif

    uvs[INDEX] = uvs[INDEX] * uv##INDEX##Scale + uvOffsetLocal;
}
#endif // #ifdef ENABLE_UV##INDEX
#endmacro // #macro CALCULATE_UV(INDEX)

void calculateUVs(out vec2 uvs[NUM_UVS]) {
    uvs[0] = varTex0;
    uvs[1] = varTex1;
    CALCULATE_UV(2);
    CALCULATE_UV(3);
}

SurfaceProperties setupSurfaceProperties(DebugOptions debug) {
    vec2 uvs[NUM_UVS];
    calculateUVs(uvs);

    vec3 V = normalize(sc_Camera.position - varPos);

    SurfaceProperties surfaceProperties = defaultSurfaceProperties();

    // Albedo
    vec4 albedo = baseColor;
#ifdef ENABLE_BASE_TEX
    SAMPLE_TEX_UBER(baseTex);
    albedo *= baseTexSample;
#endif
#ifdef ENABLE_RECOLOR
    albedo.rgb = albedo.r * recolorRed + albedo.g * recolorGreen + albedo.b * recolorBlue;
#endif
#ifdef ENABLE_DETAIL_MASK
    SAMPLE_TEX_UBER(detailMaskTex);
    float detailMask = detailMaskTexSample.r;
#else
    float detailMask = 1.0;
#endif
#ifdef ENABLE_DETAILMAP
    SAMPLE_TEX_UBER(detailTex);
    vec3 detail = detailTexSample.rgb;
    detail = mix(vec3(0.5), detail, detailMask);
    albedo.rgb = overlayBlend(detail, albedo.rgb); // Arguments reversed, so that 0.5 detail map results in no change to the albedo. Brighter brightens and darker darkens.
#endif
#ifdef ENABLE_VERTEX_COLOR_BASE
    albedo *= varColor;
#endif
    surfaceProperties.albedo = srgbToLinear(albedo.rgb);

    // Opacity
    surfaceProperties.opacity = albedo.a;
#if defined(ENABLE_OPACITY_TEX) && !defined(sc_BlendMode_Disabled)
    SAMPLE_TEX_UBER(opacityTex);
    surfaceProperties.opacity *= opacityTexSample.r;
#endif
#ifdef sc_BlendMode_Disabled
    surfaceProperties.opacity = 1.0; // Only necessary because on some hardware when alpha==0.0 we get a pure black result.
#endif

    // Alpha Test
#ifdef sc_BlendMode_AlphaTest
    if (surfaceProperties.opacity < alphaTestThreshold) {
        discard;
    }
#endif // #ifdef sc_BlendMode_AlphaTest
#ifdef ENABLE_STIPPLE_PATTERN_TEST
    if (stipplePatternTest(surfaceProperties.opacity) == false) {
        discard;
    }
#endif // ENABLE_STIPPLE_PATTERN_TEST

    // Normal
    surfaceProperties.normal = fragNormal(uvs, detailMask);

    // Emissive
#ifdef ENABLE_EMISSIVE
    SAMPLE_TEX_UBER(emissiveTex);
    surfaceProperties.emissive += emissiveTexSample.rgb;
#endif
#ifdef ENABLE_VERTEX_COLOR_EMISSIVE
    surfaceProperties.emissive += varColor.rgb;
#endif
#if defined(ENABLE_EMISSIVE) || defined(ENABLE_VERTEX_COLOR_EMISSIVE)
    surfaceProperties.emissive *= emissiveColor * emissiveIntensity;
    surfaceProperties.emissive = srgbToLinear(surfaceProperties.emissive);
#endif

    // Rim highlight (fake Fresnel)
#ifdef ENABLE_RIM_HIGHLIGHT
    vec3 rimCol = rimColor * rimIntensity;
#ifdef ENABLE_RIM_COLOR_TEX
    SAMPLE_TEX_UBER(rimColorTex);
    rimCol *= rimColorTexSample.rgb;
#endif // #ifdef ENABLE_RIM_COLOR_TEX
    float rimFactor = abs(dot(surfaceProperties.normal, V));
#ifndef ENABLE_RIM_INVERT
    rimFactor = 1.0 - rimFactor;
#endif
    surfaceProperties.emissive += pow(rimFactor, rimExponent) * srgbToLinear(rimCol);
#endif // #ifdef ENABLE_RIM_HIGHLIGHT

    // Simple reflection
#ifdef ENABLE_SIMPLE_REFLECTION
    vec3 R = reflect(V, surfaceProperties.normal);
    R.z = -R.z;
    vec2 uv = vec2(1.0) - calcSphericalTexCoordsFromDir(R);
    SAMPLE_TEX(reflectionTex, uv, DEFAULT_MIP_BIAS);
    vec3 reflectionColor = reflectionTexSample.rgb;
#ifdef ENABLE_REFLECTION_MODULATION_TEX
    SAMPLE_TEX_UBER(reflectionModulationTex);
    reflectionColor *= reflectionModulationTexSample.rgb;
#endif // #ifdef ENABLE_REFLECTION_MODULATION_TEX
    surfaceProperties.emissive += srgbToLinear(reflectionColor) * reflectionIntensity;
#endif

    // Lighting related surface properties
#ifdef ENABLE_LIGHTING

#ifdef ENABLE_SPECULAR_LIGHTING
    SAMPLE_TEX_UBER(materialParamsTex);
    surfaceProperties.roughness = materialParamsTexSample.g * roughness;
    surfaceProperties.metallic = materialParamsTexSample.r * metallic;
    surfaceProperties.ao = vec3(materialParamsTexSample.b);
#ifndef MOBILE
    // GPU_BUG_011 [STUDIO-13316] 08/07/2019 Nvidia Quadro: This compiler is broken and kills huge branches of code randomly,
    // which kills some uniforms. Need to hack this to make sure roughness slider doesn't disappear.
    surfaceProperties.metallic += SC_EPSILON * roughness;
#endif // #ifndef MOBILE
#endif // #ifdef ENABLE_SPECULAR_LIGHTING

    // AO
#ifdef ENABLE_VERTEX_COLOR_AO
    surfaceProperties.ao *= varColor.rgb;
#endif
#ifdef ENABLE_SPECULAR_AO
    vec3 dummyAlbedo;
    vec3 dummySpecColor;
    deriveAlbedoAndSpecColorFromSurfaceProperties(surfaceProperties, dummyAlbedo, dummySpecColor, debug); // Kind of hacky, but necessary to keep separation between material setup and lighting. Gets optimized away in practice, since calculateDerivedSurfaceProperties() does the same calculation below.
    vec3 specularAoColor = mix(dummySpecColor * dummySpecColor * (1.0 - specularAoDarkening), vec3(1.0), surfaceProperties.ao); // When specularAoDarkening is 0, we just saturate towards the specular color, rather than blending to black, which is a more natural representation of interreflections.
    surfaceProperties.specularAo = mix(vec3(1.0), specularAoColor, specularAoIntensity);
#endif

    // Baked Shadow
#ifdef ENABLE_BAKED_SHADOWS
    SAMPLE_TEX_UBER(bakedShadowsTex);
    surfaceProperties.bakedShadows = bakedShadowsTexSample.rgb;
#endif

#endif // #ifdef ENABLE_LIGHTING

    return surfaceProperties;
}

#endif // #ifdef FRAGMENT_SHADER
#endif // UBER_SURFACE_PROPERTIES_GLSL
