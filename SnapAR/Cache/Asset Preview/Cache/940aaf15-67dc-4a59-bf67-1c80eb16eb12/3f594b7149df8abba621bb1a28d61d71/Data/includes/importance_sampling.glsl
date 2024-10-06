//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef IMPORTANCE_SAMPLING_GLSL
#define IMPORTANCE_SAMPLING_GLSL

#include "debug.glsl"
#include "utils.glsl"


#ifdef ENABLE_IMPORTANCE_SAMPLING

vec3 sampleRadiance(vec3 R);
vec3 fresnelSchlick(float cosTheta, vec3 F0);

// Environment map filtering with importance sampling.
// Used for pre-convolving environment maps on the tool side.
// NOTE: importance sampling is not viable at runtime in production, but can be used as a ground truth debug aid.

//float radicalInverse_VdC(int bits) {
//    bits = (bits << 16) | (bits >> 16);
//    bits = ((bits & 0x55555555) << 1) | ((bits & 0xAAAAAAAA) >> 1);
//    bits = ((bits & 0x33333333) << 2) | ((bits & 0xCCCCCCCC) >> 2);
//    bits = ((bits & 0x0F0F0F0F) << 4) | ((bits & 0xF0F0F0F0) >> 4);
//    bits = ((bits & 0x00FF00FF) << 8) | ((bits & 0xFF00FF00) >> 8);
//    return float(bits) * 2.3283064365386963e-10; // / 0x100000000
//}

float radicalInverse(int n) {
    float val = 0.0;
    float invBase = 0.5;
    float invBi = invBase;
    while (n > 0) {
        int d_i = n - ((n / 2) * 2);
        val += d_i * invBi;
        n /= 2;
        invBi *= 0.5;
    }
    return val;
}

vec2 hammersley(int i, int N) {
    return vec2(float(i)/float(N), radicalInverse(i));
}

vec3 importanceSampleGGX(vec2 Xi, float roughness, vec3 N) {
    float a = roughness * roughness;
    float Phi = 2 * PI * Xi.x;
    float CosTheta = sqrt((1 - Xi.y) / (1 + (a*a - 1) * Xi.y));
    float SinTheta = sqrt(1 - CosTheta * CosTheta);
    vec3 H;
    H.x = SinTheta * cos(Phi);
    H.y = SinTheta * sin(Phi);
    H.z = CosTheta;
    vec3 UpVector = abs(N.z) < 0.999 ? vec3(0,0,1) : vec3(1,0,0);
    vec3 TangentX = normalize(cross(UpVector, N));
    vec3 TangentY = cross(N, TangentX);
    // Tangent to world space
    return TangentX * H.x + TangentY * H.y + N * H.z;
}

// Samples the environment map using the GGX disrtibution, but ignores G and F.
vec3 prefilterEnvmap(float roughness, vec3 R, DebugOptions debug) {
    vec3 N = R;
    vec3 V = R;
    vec3 totalColor = vec3(0.0);
    float totalWeight = 0.0;
    
    int randMod = debug.envRandMod; 
    int randSeed = debug.envRandSeed; // envRandSeed in combination with envRandMod can be used to split up a long random sequence of samples into multiple passes. emvRandMod would be the number of passes, and envRandSeed the pass index. This way we evenly cover the range of envNumSamples*envRandMod random samples in the Hammersley sequence.
    if (randSeed < 0) {
        // Randomize the Hammersley sequence per pixel.
        // We get a hash based on the reflection vector.
        // We then mod this and use it to select between randMod number of skip sequences
        randSeed = int((abs(R.x) + abs(R.y) + abs(R.z)) * 12345711.0);
        randSeed = int(mod(float(randSeed), float(randMod)));
    }
    
    int numSamples = int(debug.envSamples);
    for(int i = 0; i < numSamples; i++) {
        vec2 Xi = hammersley(i*randMod + randSeed, numSamples*randMod);
        vec3 H = importanceSampleGGX(Xi, roughness, N);
        vec3 L = 2 * dot(V, H) * H - V;
        
        float NoL = saturate(dot(N, L));
        
        if(NoL > 0) {
            vec3 IncidentLight = sampleRadiance(L) * NoL;
            totalColor += IncidentLight;
            totalWeight += NoL;
        }
    }
    return totalColor / totalWeight;
}

float gEnv1(vec3 N, vec3 V, float roughness) {
    // This version of G is different from our usual G.
    // UE4 remaps roughness to alpha = ((roughness+1)/2)^2 only for their G function to "reduce hotness" on analytical lights, so their version of G is not the true Schlick G.
    // This makes reflections too dark at glancing angles for image based lighting.
    // Below is the "true" Schlick G1.
    float alpha = roughness * roughness;
    float k = alpha * 0.5;
    float NdotV = saturate(dot(N, V));
    return NdotV * (1.0 - k) + k;  // The NdotV and NdotL from the numerator of G cancel with the NdotV and NdotL in the denominator of the Cook Torrance BRDF. We take the reciprocal together in G.
}

float gEnv(vec3 N, vec3 L, vec3 V, float roughness) {
    return 1.0 / (gEnv1(N, L, roughness) * gEnv1(N, V, roughness));
}

// Calculates a full importance sampled ground truth representation of environment mapping, taking into account the full BRDF, including F and G.
vec3 calculateIndirectSpecularGroundTruth(float roughness, vec3 specColor, vec3 N, vec3 V, DebugOptions debug) {  
#ifdef MAYA
    N = vec3(-N.z, N.y, -N.x);  // Orient the envmap like Substance.
    V = vec3(-V.z, V.y, -V.x);  // Orient the envmap like Substance.
#endif
    
    // Randomize the Hammersley sequence per pixel. Without this, there are coherent, splotchy artifacts. We prefer to replace this with incoherent noise to get a more unbiased ground truth approximation with less samples.
    // We get a hash based on the reflection vector. We then mod this and use it to select between randMod number of skip sequences (our full sequence length is numSamples * randMod and we select the skip sequence like this: i * randMod + rand).
    vec3 R = reflect(-V, N);
    int randMod = int(debug.envRandMod);
    int rand = int((abs(R.x) + abs(R.y) + abs(R.z)) * 12345711.0);
    rand = int(mod(float(rand), float(randMod)));
    
    vec3 totalColor = vec3(0.0);
    int numSamples = int(debug.envSamples);
    for(int i = 0; i < numSamples; i++) {
        vec2 Xi = hammersley(i * randMod + rand, numSamples * randMod);
        vec3 H = importanceSampleGGX(Xi, roughness, N);
        vec3 L = 2 * dot(V, H) * H - V;
        
        float NoL = saturate(dot(N, L));
        float NoH = saturate(dot(N, H));
        float VoH = saturate(dot(V, H));
        
        if(NoL > 0) {
            vec3 IncidentLight = sampleRadiance(L) * NoL;
            
            // Incident light = SampleColor * NoL
            // Microfacet specular = D*G*F / (4*NoL*NoV)
            // pdf = D * NoH / (4 * VoH)
            // (IncidentLight * D*G*F / 4)           / (D * NoH / (4 * VoH)) = IncidentLight * F * G * VoH / NoH        -- Is our version because our NoL NoV in G is already cancelled out with Cook Torrance (see calculateDirectSpecular()).
            totalColor += IncidentLight * gEnv(N, L, V, roughness) * VoH * (1.0 / NoH) * fresnelSchlick(VoH, specColor);
        }
    }
    return totalColor / numSamples;
}

#endif  // #ifdef ENABLE_IMPORTANCE_SAMPLING

#endif  // IMPORTANCE_SAMPLING_GLSL
