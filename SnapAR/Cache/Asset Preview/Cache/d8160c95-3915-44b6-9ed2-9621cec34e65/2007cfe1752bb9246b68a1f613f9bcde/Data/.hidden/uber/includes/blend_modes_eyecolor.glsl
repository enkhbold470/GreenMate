//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#pragma once

#include "uniforms.glsl"

#ifdef FRAGMENT_SHADER

#include "rgbhsl.glsl"

SPEC_CONST(bool) BLEND_MODE_REALISTIC = false;
SPEC_CONST(bool) BLEND_MODE_DIVISION = false;
SPEC_CONST(bool) BLEND_MODE_BRIGHT = false;
SPEC_CONST(bool) BLEND_MODE_FORGRAY = false;
SPEC_CONST(bool) BLEND_MODE_NOTBRIGHT = false;
SPEC_CONST(bool) BLEND_MODE_INTENSE = false;

float transformSingleColor(float original, float intMap, float target) {
    float result;
    if (BLEND_MODE_REALISTIC || BLEND_MODE_FORGRAY || BLEND_MODE_NOTBRIGHT) {
        result = original / pow((1.0 - target), intMap);
    } else if (BLEND_MODE_DIVISION) {
        result = original / (1.0 - target);
    } else if (BLEND_MODE_BRIGHT) {
        result = original / pow((1.0 - target), 2.0 - 2.0 * original);
    } else {
        result = 0.0; // HACK 05/20/2020: Should be a static assert
    }
    return result;
}

vec3 transformColor(float yValue, vec3 original, vec3 target, float weight, float intMap) {
    vec3 result;
    if (BLEND_MODE_INTENSE) {
        vec3 hslOrig = RGBToHSL(original);
        vec3 res;
        res.r = target.r; //hue
        res.g = target.g; //sat
        res.b = hslOrig.b; //light
        res = HSLToRGB(res);
        vec3 resColor = mix(original, res, weight);
        result = resColor;
    } else {
        vec3 tmpColor;
        tmpColor.r = transformSingleColor(yValue, intMap, target.r);
        tmpColor.g = transformSingleColor(yValue, intMap, target.g);
        tmpColor.b = transformSingleColor(yValue, intMap, target.b);
        tmpColor = clamp(tmpColor, 0.0, 1.0);
        vec3 resColor = mix(original, tmpColor, weight);
        result = resColor;
    }
    return result;
}

float unpack1(float inp, float mul) {
    return inp * mul;
}

float unpack2(vec2 inp, float mul) {
    return (inp[0] * 256.0 + inp[1]) / 257.0 * mul;
}

float unpack3(vec3 inp, float mul) {
    //    return (inp[0] * 256.0 * 256.0 * 255.0 + inp[1] * 256.0 * 255.0 + inp[2] * 255.0) / (256.0 * 256.0 * 256.0 - 1);
    //    256^3 - 1 == 255*(256 * 256 + 256 + 1)
    //    return (inp[0] * 256.0 * 256.0 + inp[1] * 256.0 + inp[2]) / (256.0 * 256.0 + 256.0 + 1);
    //    256.0^2 can be too big, let's divide num and denom by 256
    return (inp[0] * 256.0 + inp[1] + inp[2] / 256.0) / (256.0 + 1.0 + 1.0 / 256.0) * mul;
}

float getYValue(vec3 rgb) {
    return 0.299 * rgb.r + 0.587 * rgb.g + 0.114 * rgb.b;
}

vec3 eyeColorBlend(vec3 texColor, vec3 resColor)
{
    float newYValue = getYValue(texColor);

    float weight = 1.0;
    float fragmentCorrectedIntensity = pow(newYValue, 1.0 / correctedIntensity);
    vec3 intenseMapCompressed = SC_SAMPLE_TEX_R(intensityTexture, vec2(fragmentCorrectedIntensity, 0.5), 0.0).rgb;
    float intenseMapValue = unpack3(intenseMapCompressed, 16.0);

    if (BLEND_MODE_FORGRAY) {
        intenseMapValue = max(intenseMapValue, 1.0);
    }

    if (BLEND_MODE_NOTBRIGHT) {
        intenseMapValue = min(intenseMapValue, 1.0);
    }

    return transformColor(newYValue, texColor, resColor, weight, intenseMapValue);
}

#endif // #ifdef FRAGMENT_SHADER
