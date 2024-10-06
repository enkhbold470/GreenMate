//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef ENVMAP_GLSL
#define ENVMAP_GLSL

#include "utils.glsl"


#if defined(FRAGMENT_SHADER) || !defined(SCENARIUM)
#if defined(ENABLE_LIGHTING) || !defined(SCENARIUM)

vec4 encodeRGBD(vec3 rgb) {
    float maxRGB = max(1.0, (max(rgb.x, max(rgb.g, rgb.b))));
    float D = 1.0 / maxRGB;
    return vec4(rgb.rgb * D, D);
}

vec3 decodeRGBD(vec4 rgbd) {
    return rgbd.rgb * (1.0 / rgbd.a);
}

vec3 decodeRGBE(vec4 rgbe) {
    float f1 = exp2(rgbe.w * 255.0 - 128.0);
    return rgbe.xyz * vec3(f1);
}

vec2 calcSeamlessPanoramicUvsForConvolution(vec2 uv, vec2 topMipRes, float lod) {
    // Maps a range of (halftex, res-halftex) to (0, res).
    vec2 thisMipRes = max(vec2(1.0), topMipRes / vec2(exp2(lod)));
    return (uv * thisMipRes - 0.5) / (thisMipRes - 1.0);
}

vec2 calcSeamlessPanoramicUvsForSampling(vec2 uv, vec2 topMipRes, float lod) {
#ifdef DEVICE_IS_FAST
    // Maps a range of (0, res) to (halftex, res-halftex), ie: one texel narrower.
    // This makes sure that we only sample to the center of the border texels, as intended by the convolution.
    vec2 thisMipRes = max(vec2(1.0), topMipRes / vec2(exp2(lod)));
    return uv * (thisMipRes - 1.0) / thisMipRes + 0.5 / thisMipRes;
#else
    return uv;
#endif
}

float _atan2(float x, float y) {
    // This version of atan2 is faster on low-end devices like Galaxy S3.
    float signx = x < 0.0 ? -1.0 : 1.0;
    return signx * acos(clamp(y/length(vec2(x,y)), -1.0, 1.0));
}

vec2 calcPanoramicTexCoordsFromDir(vec3 reflDir, float rotationDegrees) {
    vec2 uv;
    uv.x = _atan2(reflDir.x, -reflDir.z) - PI/2.0; // Need to mirror the lookup, and rotate to match Substance.
    uv.y = acos(reflDir.y);
    uv = uv / vec2(2.0 * PI, PI);
    uv.y = 1.0 - uv.y;

    // Rotate the environment around the Y axis
    uv.x += rotationDegrees / 360.0;
    uv.x = fract(uv.x + floor(uv.x) + 1.0); // wrap the result to be between 0 and 1, otherwise the seamless uv lookup fails

    return uv;
}

vec3 calcDirFromPanoramicTexCoords(vec2 uv) {
    float a = 2.0 * PI * (uv.x);
    float b = PI * uv.y;

    float x = sin(a) * sin(b);
    float y = cos(b);
    float z = cos(a) * sin(b);

    return vec3(z, y, x);
}

vec2 calcAngularTexCoordsFromDir(vec3 V) {
    V = vec3(-V.z, V.y, -V.x);  // Rotate to match Lys panoramics.
    float r = 0.159154943*acos(V.z)/sqrt(V.x*V.x + V.y*V.y);
    float u = 0.5 + V.x * r;
    float v = 0.5 + V.y * r;
    return vec2(u, 1.0 - v);
}

vec2 calculateEnvmapScreenToCube(vec3 V)
{
    // Similar to cubemap lookup code, but modified to unwrap the half-cube to the screen, and mirror the half-cube in Z.
    V.z = abs(V.z);
    vec3 vAbs = abs(V);
    vec2 uv;
    if(vAbs.z >= vAbs.x && vAbs.z >= vAbs.y)
    {
        float ma = 0.5 / vAbs.z;
        uv = vec2(V.x, V.y) * ma;
        uv = uv * 0.5 + vec2(0.5);
    }
    else if(vAbs.y >= vAbs.x)
    {
        float ma = 0.5 / vAbs.y;
        uv = vec2(V.x, -V.z) * ma;
        uv.x = uv.x * mix(0.5, 1.0, 1.0 - abs(uv.y) * 2.0); // map the sides to trapezoids instead of 0.25x0.5 recrangles, to make sure that the edges match and there are no texture seams.
        uv.x += 0.5;
        uv.y *= 0.5;
        uv.y = abs(uv.y);
        if (V.y > 0.0) {
            uv.y = 1.0 - uv.y;
        }
    }
    else
    {
        float ma = 0.5 / vAbs.x;
        uv = vec2(V.x < 0.0 ? V.z : -V.z, V.y) * ma;
        uv.y = uv.y * mix(0.5, 1.0, 1.0 - abs(uv.x) * 2.0); // map the sides to trapezoids instead of 0.25x0.5 recrangles, to make sure that the edges match and there are no texture seams.
        uv.y += 0.5;
        uv.x *= 0.5;
        uv.x = abs(uv.x);
        if (V.x > 0.0) {
            uv.x = 1.0 - uv.x;
        }
    }
    return uv;
}

#endif  // #if defined(ENABLE_LIGHTING) || !defined(SCENARIUM)

vec2 calcSphericalTexCoordsFromDir(vec3 reflDir) {
    float m = 2.0 * sqrt(reflDir.x * reflDir.x + reflDir.y * reflDir.y + (reflDir.z + 1.0) * (reflDir.z + 1.0));
    vec2 reflTexCoord = reflDir.xy / m + 0.5;
    return reflTexCoord;
}

#endif  // #if defined(FRAGMENT_SHADER) || !defined(SCENARIUM)
#endif  // ENVMAP_GLSL
