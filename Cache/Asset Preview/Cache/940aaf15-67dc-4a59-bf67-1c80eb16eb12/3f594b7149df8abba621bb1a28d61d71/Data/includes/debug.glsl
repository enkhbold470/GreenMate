//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef DEBUG_GLSL
#define DEBUG_GLSL

struct DebugOptions {
    bool enableMetallic;
    bool envBRDFApprox;
    bool envBentNormal;
    float envMip;
    bool envSampling;
    bool envSamplingGroundTruth;
    int envSamples;
    int envRandMod;
    int envRandSeed;
    bool fringelessMetallic;
    bool acesToneMapping;
    bool linearToneMapping;
    bool albedo;
    bool specColor;
    bool roughness;
    bool normal;
    bool ao;
    float directDiffuse;
    float directSpecular;
    float indirectDiffuse;
    float indirectSpecular;
};

DebugOptions defaultDebugOptions() {
    DebugOptions debug;
    
    debug.enableMetallic = true;
    debug.envBRDFApprox = true;
    debug.envBentNormal = true;
    debug.envMip = -1.0;
    debug.envSampling = false;
    debug.envSamplingGroundTruth = false;
#ifndef MOBILE
    debug.envSamples = 500;
    debug.envRandMod = 333;
    debug.envRandSeed = -1;
#endif
    debug.fringelessMetallic = true;
    debug.acesToneMapping = false;
    debug.linearToneMapping = false;
    debug.albedo = false;
    debug.specColor = false;
    debug.roughness = false;
    debug.normal = false;
    debug.directDiffuse = 1.0;
    debug.indirectDiffuse = 1.0;
    debug.directSpecular = 1.0;
    debug.indirectSpecular = 1.0;
    
    return debug;
}

#endif // DEBUG_GLSL
