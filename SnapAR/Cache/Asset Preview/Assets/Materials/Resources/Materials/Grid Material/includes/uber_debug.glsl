//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------
#ifndef UBER_DEBUG_GLSL
#define UBER_DEBUG_GLSL

#include "debug.glsl"


#ifdef FRAGMENT_SHADER

#ifdef DEBUG
uniform int DebugAlbedo;
uniform int DebugSpecColor;
uniform int DebugRoughness;
uniform int DebugNormal;
uniform int DebugAo;
uniform float DebugDirectDiffuse;
uniform float DebugDirectSpecular;
uniform float DebugIndirectDiffuse;
uniform float DebugIndirectSpecular;
uniform float DebugRoughnessOffset;
uniform float DebugRoughnessScale;
uniform float DebugNormalIntensity;
uniform int DebugEnvBRDFApprox;
uniform int DebugEnvBentNormal;
uniform float DebugEnvMip;
uniform int DebugFringelessMetallic;
uniform int DebugAcesToneMapping;
uniform int DebugLinearToneMapping;
#endif  // #ifdef DEBUG

DebugOptions setupDebugOptions() {
    DebugOptions debug = defaultDebugOptions();

#ifdef DEBUG
    debug.envMip = DebugEnvMip;
    debug.envBRDFApprox = bool(DebugEnvBRDFApprox);
    debug.envBentNormal = bool(DebugEnvBentNormal);
    debug.fringelessMetallic = bool(DebugFringelessMetallic);
    debug.acesToneMapping = bool(DebugAcesToneMapping);
    debug.linearToneMapping = bool(DebugLinearToneMapping);
    debug.albedo = bool(DebugAlbedo);
    debug.specColor = bool(DebugSpecColor);
    debug.roughness = bool(DebugRoughness);
    debug.normal = bool(DebugNormal);
    debug.ao = bool(DebugAo);
    debug.directDiffuse = DebugDirectDiffuse;
    debug.directSpecular = DebugDirectSpecular;
    debug.indirectDiffuse = DebugIndirectDiffuse;
    debug.indirectSpecular = DebugIndirectSpecular;
#endif  // #ifdef DEBUG

    return debug;
}

#endif  // #ifdef FRAGMENT_SHADER

#endif  // UBER_DEBUG_GLSL
