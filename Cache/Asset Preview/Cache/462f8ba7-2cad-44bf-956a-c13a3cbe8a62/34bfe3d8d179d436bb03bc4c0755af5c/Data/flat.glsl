//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
// Modified 04/24/2018
//-----------------------------------------------------------------------

#define SC_USE_USER_DEFINED_VS_MAIN

#include <std.glsl>
#include <std_vs.glsl>
#include <std_fs.glsl>
#include <std_texture.glsl>
#include "includes/blend_modes.glsl"
#include "includes/oit.glsl"

#ifndef saturate // HACK 05/15/2019: SAMPLETEX() uses saturate(), but core doesn't define it. This can be removed after Core 10.59.
#define saturate(A) clamp(A, 0.0, 1.0)
#endif


uniform vec4      baseColor;

#if !defined(NOTEXTURE)
DECLARE_TEXTURE(baseTex)
#endif

#if !defined(NOMASK)
DECLARE_TEXTURE(opacityTex)
#endif


varying vec4 varColor;


#ifdef VERTEX_SHADER

attribute vec4 color;

void main(void) {
    sc_Vertex_t v = sc_LoadVertexAttributes();
    varColor = color;
    sc_ProcessVertex(v);
}

#endif // VERTEX_SHADER


#ifdef FRAGMENT_SHADER

void main(void) {
    vec4 result = baseColor;

#ifdef ENABLE_VERTEX_COLOR_BASE
    result *= varColor;
#endif

#ifndef NOTEXTURE
    SAMPLE_TEX(baseTex, varTex0, 0.0);
    result *= baseTexSample;
#endif

#ifndef NOMASK
    SAMPLE_TEX(opacityTex, varTex1, 0.0);
    result.a *= opacityTexSample.r;
#endif

    // Blending
#ifdef sc_BlendMode_Custom
    result = applyCustomBlend(result);
#elif defined(sc_BlendMode_MultiplyOriginal)
    result.rgb = mix(vec3(1.0), result.rgb, result.a);
#elif defined(sc_BlendMode_Screen)
    result.rgb *= result.a;
#elif defined(sc_BlendMode_PremultipliedAlpha)
    result.rgb *= result.a;
#elif defined(sc_BlendMode_PremultipliedAlphaHardware)
    result.rgb *= baseColor.a;
#endif

    processOIT(result);
}

#endif //FRAGMENT SHADER
