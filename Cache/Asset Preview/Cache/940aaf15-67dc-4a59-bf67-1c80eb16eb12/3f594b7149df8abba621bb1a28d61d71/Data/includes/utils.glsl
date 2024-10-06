//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef UTILS_GLSL
#define UTILS_GLSL

#ifndef PI
#define PI 3.141592653589793238462643383279
#endif

#define SC_EPSILON 1e-6

#ifndef MAYA

float saturate(float value) {
    return clamp(value, 0.0, 1.0);
}

vec2 saturate(vec2 value) {
    return clamp(value, 0.0, 1.0);
}

vec3 saturate(vec3 value) {
    return clamp(value, 0.0, 1.0);
}

#endif  // #ifndef MAYA

#if defined(MAYA) || defined(SUBSTANCE)

float srgbToLinear(float x) {
    return x <= 0.04045 ? x * 0.0773993808 : pow((x + 0.055) / 1.055, 2.4);
}

float linearToSrgb(float x) {
    return x <= 0.0031308 ? 12.92 * x : 1.055 * pow(x, 0.41666) - 0.055;
}

#else  // #if defined(MAYA) || defined(SUBSTANCE)

float srgbToLinear(float x) {
#ifdef SC_ENABLE_SRGB_EMULATION_IN_SHADER
#ifdef DEVICE_IS_FAST
    return pow(x, 2.2);
#else 
    return x * x;
#endif
#else  // #ifdef SC_ENABLE_SRGB_EMULATION_IN_SHADER
    return x;
#endif  // #else  // #ifdef SC_ENABLE_SRGB_EMULATION_IN_SHADER
}

float linearToSrgb(float x) {
#ifdef SC_ENABLE_SRGB_EMULATION_IN_SHADER
#ifdef DEVICE_IS_FAST
    return pow(x, 1.0 / 2.2);
#else 
    return sqrt(x);
#endif
#else  // #ifdef SC_ENABLE_SRGB_EMULATION_IN_SHADER
    return x;
#endif  // #else  // #ifdef SC_ENABLE_SRGB_EMULATION_IN_SHADER
}

#endif  // #else  // #if defined(MAYA) || defined(SUBSTANCE)

vec3 srgbToLinear(vec3 color) {
    return vec3(srgbToLinear(color.r), srgbToLinear(color.g), srgbToLinear(color.b));
}

vec3 linearToSrgb(vec3 color) {
    return vec3(linearToSrgb(color.r), linearToSrgb(color.g), linearToSrgb(color.b));
}

#endif // UTILS_GLSL
