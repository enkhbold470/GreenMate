//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef BLEND_MODES_EYECOLOR_GLSL
#define BLEND_MODES_EYECOLOR_GLSL

#include "rgbhsl.glsl"


#ifdef BLEND_MODE_REALISTIC
#define COLOR_MODE 0
#endif

#ifdef BLEND_MODE_DIVISION
#define COLOR_MODE 1
#endif

#ifdef BLEND_MODE_BRIGHT
#define COLOR_MODE 2
#endif

#ifdef BLEND_MODE_FORGRAY
#define COLOR_MODE 3
#endif

#ifdef BLEND_MODE_NOTBRIGHT
#define COLOR_MODE 4
#endif

#ifdef BLEND_MODE_INTENSE
#define COLOR_MODE 5
#endif


#ifdef COLOR_MODE

uniform float     correctedIntensity;
uniform sampler2D intensityTexture;


#if COLOR_MODE == 0 || COLOR_MODE == 3 || COLOR_MODE == 4

float transformSingleColor(float original, float intMap, float target) {
    return original / pow((1.0 - target), intMap);
}

#endif
#if COLOR_MODE == 1

float transformSingleColor(float original, float intMap, float target) {
    return original / (1.0 - target);
}

#endif
#if COLOR_MODE == 2

float transformSingleColor(float original, float intMap, float target) {
    return original / pow((1.0 - target), 2.0 - 2.0 * original);
}

#endif

#if COLOR_MODE != 5

vec3 transformColor(float yValue, vec3 original, vec3 target, float weight, float intMap) {
    vec3 tmpColor;
    tmpColor.r = transformSingleColor(yValue, intMap, target.r);
    tmpColor.g = transformSingleColor(yValue, intMap, target.g);
    tmpColor.b = transformSingleColor(yValue, intMap, target.b);
    tmpColor = clamp(tmpColor, 0.0, 1.0);
    vec3 resColor = mix(original, tmpColor, weight);
    return resColor;
}

#endif

#if COLOR_MODE == 5

vec3 transformColor(float yValue, vec3 original, vec3 target, float weight, float intMap) {
    vec3 hslOrig = RGBToHSL(original);
    vec3 res;
    res.r = target.r; //hue
    res.g = target.g; //sat
    res.b = hslOrig.b; //light
    res = HSLToRGB(res);
    vec3 resColor = mix(original, res, weight);
    return resColor;
}

#endif

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
    vec3 intenseMapCompressed = texture2D(intensityTexture, vec2(fragmentCorrectedIntensity, 0.5)).rgb;
    float intenseMapValue = unpack3(intenseMapCompressed, 16.0);

#if COLOR_MODE == 3
    intenseMapValue = max(intenseMapValue, 1.0);
#endif
#if COLOR_MODE == 4
    intenseMapValue = min(intenseMapValue, 1.0);
#endif

    vec3 newColor = transformColor(newYValue, texColor, resColor, weight, intenseMapValue);
    return newColor;
}

#define definedBlend eyeColorBlend

#endif //COLOR_MODE

#endif //BLEND_MODES_EYECOLOR_GLSL
