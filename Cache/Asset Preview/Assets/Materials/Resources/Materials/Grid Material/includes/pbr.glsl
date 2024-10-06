//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef PBR_GLSL
#define PBR_GLSL

#include "importance_sampling.glsl"
#include "debug.glsl"
#include "utils.glsl"


#if defined(FRAGMENT_SHADER) || !defined(SCENARIUM)

// Depending on platform, some or all of the below functions must be defined by the client shader.
vec3 sampleSpecularEnvmapLod(vec3 R, float lod);
vec3 sampleRadiance(vec3 R);
vec3 calculateDiffuseIrradiance(vec3 N);


struct SurfaceProperties {
    vec3 albedo;
    float opacity;
    vec3 normal;
    float metallic;
    float roughness;
    vec3 emissive;
    vec3 ao;
    vec3 specularAo;
    vec3 bakedShadows;

    // Derived surface properties
    vec3 specColor;
};

struct LightingComponents {
    vec3 directDiffuse;
    vec3 directSpecular;
    vec3 indirectDiffuse;
    vec3 indirectSpecular;
    vec3 emitted;
    vec3 transmitted;
};

struct LightProperties {
    vec3 direction;
    vec3 color;
    float attenuation;
};

SurfaceProperties defaultSurfaceProperties() {
    SurfaceProperties surfaceProperties;

    surfaceProperties.albedo = vec3(0.0);
    surfaceProperties.opacity = 1.0;
    surfaceProperties.normal = vec3(0.0);
    surfaceProperties.metallic = 0.0;
    surfaceProperties.roughness = 0.0;
    surfaceProperties.emissive = vec3(0.0);
    surfaceProperties.ao = vec3(1.0);
    surfaceProperties.specularAo = vec3(1.0);
    surfaceProperties.bakedShadows = vec3(1.0);

    return surfaceProperties;
}

LightingComponents defaultLightingComponents() {
    LightingComponents lighting;

    lighting.directDiffuse = vec3(0.0);
    lighting.directSpecular = vec3(0.0);
    lighting.indirectDiffuse = vec3(1.0);
    lighting.indirectSpecular = vec3(0.0);
    lighting.emitted = vec3(0.0);
    lighting.transmitted = vec3(0.0);

    return lighting;
}

#if defined(ENABLE_LIGHTING) || !defined(SCENARIUM)

vec3 fresnelSchlickSub(float cosTheta, vec3 F0, vec3 fresnelMax) {
    float b = 1.0 - cosTheta;
    float b2 = b * b;
    float b5 = b2 * b2 * b;  // b5 = pow(1-cosTheta, 5);
    return F0 + (fresnelMax - F0) * b5;
}

vec3 fresnelSchlick(float cosTheta, vec3 F0) {
    return fresnelSchlickSub(cosTheta, F0, vec3(1.0));
}

float Dggx(float NdotH, float roughness) {
    float a = roughness * roughness;
    float a2 = a * a;
    float NdotH2 = NdotH * NdotH;
    float b = NdotH2 * (a2 - 1.0) + 1.0;
    float b2 = b * b;
    return a2 / b2;
}

float Gggx1(float NdotV, float roughness) {
    float k = roughness + 1.0;
    k = k * k * 0.125;
    return NdotV * (1.0 - k) + k;  // The NdotV and NdotL from the numerator of G cancel with the NdotV and NdotL in the denominator of the Cook Torrance BRDF. We take the reciprocal together in G.
}

float Gggx(float NdotL, float NdotV, float roughness) {
    // Schlick approximation of Smith G for GGX.
    return 1.0 / (Gggx1(NdotL, roughness) * Gggx1(NdotV, roughness));
}

vec3 calculateDirectDiffuse(SurfaceProperties surfaceProperties, vec3 L) {
    return vec3(saturate(dot(surfaceProperties.normal, L)));
}

vec3 calculateDirectSpecular(SurfaceProperties surfaceProperties, vec3 L, vec3 V) {
    float r = max(surfaceProperties.roughness, 0.03); // Make sure the tightest highlight is not infinitely small
    vec3 F0 = surfaceProperties.specColor;
    vec3 N = surfaceProperties.normal;
    vec3 H = normalize(L + V);
    float NdotL = saturate(dot(N, L));
    float NdotV = saturate(dot(N, V));
    float NdotH = saturate(dot(N, H));
    float VdotH = saturate(dot(V, H));

#if defined(DEVICE_IS_FAST)
    // Cook torrance Specular with GGX NDF. Note: the NdotL and NdotV from the denominator of Cook Torrance cancels with the numerator of G.
    // The pi disappears and the NdotL appears the same way it does in the diffuse lighting function (BRDF is modulated by NdotL to get actual lighting).
    return Dggx(NdotH, r) * Gggx(NdotL, NdotV, r) * 0.25 * NdotL * fresnelSchlick(VdotH, F0);
#else
    // Normalized Blinn-Phong
    float specPower = exp2(11.0 - 10.0 * r);  // Simplified based on: gloss = 1 - r
    return fresnelSchlick(VdotH, F0) * (specPower * 0.125 + 0.25) * pow(NdotH, specPower) * NdotL; // GPU_BUG_001 [STUDIO-9091] 09/27/2018 Mali 400: When using alpha test with direct specular light, the discarded pixels end up as opaque black. This workaround, of moving fresnel from the end of the equation to the beginning, sacrifices 4 MULs. We could reevaluate this in the future. If other surrounding code changes, the bug might go away without this hack.
#endif
}

LightingComponents accumulateLight(LightingComponents lighting, LightProperties light, SurfaceProperties surfaceProperties, vec3 V) {
    lighting.directDiffuse += calculateDirectDiffuse(surfaceProperties, light.direction) * light.color * light.attenuation;
    lighting.directSpecular += calculateDirectSpecular(surfaceProperties, light.direction, V) * light.color * light.attenuation;
    return lighting;
}

#ifndef SUBSTANCE

vec3 calculateIndirectDiffuse(SurfaceProperties surfaceProperties) {
    return calculateDiffuseIrradiance(surfaceProperties.normal);
}

#ifdef SCENARIUM
const float sc_RoughnessExponentInv = 1.0/1.5;
const float sc_MaxRoughnessMip = 5.0;
#endif

float calculateEnvMipFromRoughness(float roughness, DebugOptions debug) {
#ifdef SCENARIUM
    // Calculate the appropriate env map mip based on the roughness.
    // The curve is controlled by the exponent, to allocate the most appropriate amount of detail to each mip.
    // If the resulution is too low for a given convolution, it will look bad.
    // If the resolution is too high, you're not getting as many useful mip grades.
    // The maxRoughnessMip specifies which mip level contains the roughest convolution. This is usually not the last mip, as a single pixel can't represent the necessary variation in lighting.
    // In Scenarium we use an importance sampling convolver to render our env maps in lat-long format.
    // The tools that generate mips must match this roughnessExponentInv and maxRoughnessMip at bake time.
    // NOTE: in practice we hack the exponent (doesn't quite match the exponent used at bake time) to match the importance sampled reference better. It seems that due to the low-ish number of mips, a sharper mip often gets mixed in, and that effectively makes the roughness look sharper. This hack compensates a bit. Bottom of this page might also offer a clue to investigate: https://docs.knaldtech.com/doku.php?id=specular_lys
    float mip = saturate(pow(roughness, sc_RoughnessExponentInv)) * sc_MaxRoughnessMip;
#else
    // In Maya we use cubemaps convolved by Lys.
    // maxRoughnessMip must match the roughest mip as set in Lys.
    float gloss = 1.0 - roughness;
    float lysRoughness = 1.0 - gloss*gloss;  // Match the env map roughnes curve of Lys to proper GGX (not sure why Lys expects roughness to be the inverse of gloss squared, but this is the closest match I can get).
    const float maxRoughnessMip = 7.0;
    float mip = lysRoughness * maxRoughnessMip;
#endif

#ifdef DEBUG
    if (debug.envMip >= 0.0) {
        mip = debug.envMip;
    }
#endif

    return mip;
}

// Makes cubemap reflections behave closer to the reference, taking into account view vector dependence.
// Ie: correct for the fact that the env map is preconvolved assuming V == N, which does not hold in general.
// The idea came from Frostbite, but our version is much simplified and has less artifacts (ours doesn't warp reflections on smooth surfaces).
vec3 getSpecularDominantDir(vec3 N, vec3 R, float roughness, DebugOptions debug) {
#ifdef DEVICE_IS_FAST
#ifdef DEBUG
    if (debug.envBentNormal)
#endif
    {
        float lerpFactor = roughness * roughness * roughness;
        return normalize(mix(R, N, lerpFactor));
    }
#else // #ifdef DEVICE_IS_FAST
    return R;
#endif // #else // #ifdef DEVICE_IS_FAST
}

// Approximates the effects of fresnel and G for environment maps.
vec3 envBRDFApprox(SurfaceProperties surfaceProperties, float NdotV, DebugOptions debug) {
#ifdef DEVICE_IS_FAST
#ifdef DEBUG
    bool useBRDFApprox = debug.envBRDFApprox;
#else
    bool useBRDFApprox = true;
#endif
#else // #ifdef DEVICE_IS_FAST
    bool useBRDFApprox = false;
#endif // #else // #ifdef DEVICE_IS_FAST

    if (useBRDFApprox) {
        const vec4 c0 = vec4(-1.0, -0.0275, -0.572, 0.022);
        const vec4 c1 = vec4(1.0, 0.0425, 1.04, -0.04);
        vec4 r = surfaceProperties.roughness * c0 + c1;
        float a004 = min(r.x * r.x, exp2(-9.28 * NdotV)) * r.x + r.y;
        vec2 AB = vec2(-1.04, 1.04) * a004 + r.zw;
        return max(surfaceProperties.specColor * AB.x + AB.y, vec3(0.0));
    }
    else {
        // Do fresnel (F), but drive down the brightness at the edge as the roughness gets higher (G). Without this you get glowing edges on rough materials.
        vec3 fresnelMax = max(vec3(1.0 - surfaceProperties.roughness), surfaceProperties.specColor);
        return fresnelSchlickSub(NdotV, surfaceProperties.specColor, fresnelMax);
    }
}

// Calculates environment reflections
vec3 calculateIndirectSpecular(SurfaceProperties surfaceProperties, vec3 V, DebugOptions debug) {
#ifdef MAYA
    if (debug.envSamplingGroundTruth) {
        return calculateIndirectSpecularGroundTruth(surfaceProperties, V, debug);  // Allow to compare the results of environment mapping calculated below, versus the realtime importance sampled evaluation of the full BRDF.
    }
#endif

    vec3 N = surfaceProperties.normal;

#ifdef MAYA
    // Orient the envmap like Substance and Scenarium.
    N = vec3(-N.z, N.y, -N.x);
    V = vec3(-V.z, V.y, -V.x);
#endif

    vec3 R = reflect(-V, N);

    R = getSpecularDominantDir(N, R, surfaceProperties.roughness, debug);

    float mip = calculateEnvMipFromRoughness(surfaceProperties.roughness, debug);

    vec3 envmap = sampleSpecularEnvmapLod(R, mip);

#ifdef MAYA
    if (debug.envSampling) {
        envmap = prefilterEnvmap(surfaceProperties.roughness, R, debug);  // Allow to compare the results of the envmap sampled above, versus the realtime importance sampled reference.
    }
#endif

    return envmap * envBRDFApprox(surfaceProperties, abs(dot(N, V)), debug); // We use abs instead of saturate here to avoid over-brightening the back sides of normal map bumps, which would not be visible in real life. Saturate just clamps the brightness of fresnel on the back sides of bumps to full bright, whereas abs peaks and trails off, making the artifact slightly less offensive.
}
#endif // #ifndef SUBSTANCE

void deriveAlbedoAndSpecColorFromSurfaceProperties(in SurfaceProperties surfaceProperties, out vec3 albedo, out vec3 specColor, DebugOptions debug) {
#ifdef DEBUG
    if (debug.enableMetallic) {
        if (debug.fringelessMetallic) {
#endif
            // The classic way of blending between metals and dielectrics causes bright fringes at the transition.
            // This same blend in the specular model does not cause such finging, and we observe that the shading result is darker in the middle of the blend range in the specular model than in the metallic model.
            // Ie: the sum of the diffuse and specular lighting with the classic metallic blend is brighter than it should be in the middle of the blend range.
            // Knowing that the undesirable fringe is brighter than the reference, we ramp down the brightness of diffuse albedo and specular color faster by multiplying in an extra metallic term.
            // The result of this is quite close to the reference, though it's impossible to do "correct" material blending in the metallic model since diffuse and specular colors are confounded.
            specColor = mix(vec3(0.04), surfaceProperties.albedo*surfaceProperties.metallic, surfaceProperties.metallic);
            albedo = mix(surfaceProperties.albedo*(1.0-surfaceProperties.metallic), vec3(0.0), surfaceProperties.metallic);
#ifdef DEBUG
        } else {
            specColor = mix(vec3(0.04), surfaceProperties.albedo, surfaceProperties.metallic);
            albedo = mix(surfaceProperties.albedo, vec3(0.0), surfaceProperties.metallic);
        }
    } else {
        // If we're not in metallic mode but colored spec, there's nothing to derive. Pass through.
        specColor = surfaceProperties.specColor;
        albedo = surfaceProperties.albedo;
    }
#endif
}

// This function derives surface properties that were not in the input material data (ex: in a metallic material model, spec color, ie: F0, is derived from albedo and the matallic parameter).
SurfaceProperties calculateDerivedSurfaceProperties(SurfaceProperties surfaceProperties, DebugOptions debug) {
    deriveAlbedoAndSpecColorFromSurfaceProperties(surfaceProperties, surfaceProperties.albedo, surfaceProperties.specColor, debug);
    return surfaceProperties;
}

#endif  // #if defined(ENABLE_LIGHTING) || !defined(SCENARIUM)

// This function does the final logical combination of surface properties and lighting.
vec3 combineSurfacePropertiesWithLighting(SurfaceProperties surfaceProperties, LightingComponents lighting, bool enablePremultipliedAlpha) {
    vec3 diffuse = surfaceProperties.albedo * (lighting.directDiffuse + lighting.indirectDiffuse * surfaceProperties.ao);
    vec3 specular = lighting.directSpecular + lighting.indirectSpecular * surfaceProperties.specularAo;
    vec3 emitted = surfaceProperties.emissive;
    vec3 transmitted = lighting.transmitted;

    if (enablePremultipliedAlpha) {
        diffuse *= srgbToLinear(surfaceProperties.opacity);
    }

    vec3 result = diffuse + specular + emitted + transmitted;

    return result;
}

vec4 debugOutput(vec4 regularOutput, SurfaceProperties surfaceProperties, LightingComponents lighting, DebugOptions debug) {
    vec4 result = regularOutput;
    result.a = 1.0;

    if (debug.albedo) {
        result.xyz = surfaceProperties.albedo;
    } else if (debug.specColor) {
        result.xyz = surfaceProperties.specColor;
    } else if (debug.roughness) {
        result.xyz = vec3(srgbToLinear(surfaceProperties.roughness));
    } else if (debug.normal) {
        result.xyz = srgbToLinear(surfaceProperties.normal * 0.5 + 0.5);
    } else if (debug.ao) {
        result.xyz = surfaceProperties.ao;
    } else {
        result = regularOutput;
    }

    return result;
}

vec3 linearToneMapping(vec3 x) {
    // A curve that is mostly linear, but trails off in the shoulder region, so it avoids abrupt highlight clipping.
    float a = 1.8;  // Mid
    float b = 1.4;  // Toe
    float c = 0.5;  // Shoulder
    float d = 1.5;  // Mid

#ifdef GL_FRAGMENT_PRECISION_HIGH
    return (x * (a * x + b)) / (x * (a * x + c) + d);
#else
    return (x * (a * x + b)) / min(vec3(1000.0), (x * (a * x + c) + d));
#endif
}

vec3 acesToneMapping(vec3 x) {
    // Approximated ACES RRT + ODT curve.
    float a = 2.51;
    float b = 0.03;
    float c = 2.43;
    float d = 0.59;
    float e = 0.14;

#ifdef GL_FRAGMENT_PRECISION_HIGH
    return (x * (a * x + b)) / (x * (c * x + d) + e);
#else
    return (x * (a * x + b)) / min(vec3(1000.0), (x * (c * x + d) + e));
#endif
}

#endif  // #if defined(FRAGMENT_SHADER) || !defined(SCENARIUM)
#endif  // PBR_GLSL
