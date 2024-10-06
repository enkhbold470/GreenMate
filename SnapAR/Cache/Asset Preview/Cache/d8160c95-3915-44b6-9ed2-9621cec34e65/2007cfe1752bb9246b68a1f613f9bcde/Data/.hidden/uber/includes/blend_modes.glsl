//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------
#pragma once

#ifdef FRAGMENT_SHADER

#include <std2_fs.glsl>
#include "blend_modes_eyecolor.glsl"
#include "rgbhsl.glsl"

SPEC_CONST(bool) BLEND_MODE_LIGHTEN = false;
SPEC_CONST(bool) BLEND_MODE_DARKEN = false;
SPEC_CONST(bool) BLEND_MODE_DIVIDE = false;
SPEC_CONST(bool) BLEND_MODE_AVERAGE = false;
SPEC_CONST(bool) BLEND_MODE_SUBTRACT = false;
SPEC_CONST(bool) BLEND_MODE_DIFFERENCE = false;
SPEC_CONST(bool) BLEND_MODE_NEGATION = false;
SPEC_CONST(bool) BLEND_MODE_EXCLUSION = false;
SPEC_CONST(bool) BLEND_MODE_OVERLAY = false;
SPEC_CONST(bool) BLEND_MODE_SOFT_LIGHT = false;
SPEC_CONST(bool) BLEND_MODE_HARD_LIGHT = false;
SPEC_CONST(bool) BLEND_MODE_COLOR_DODGE = false;
SPEC_CONST(bool) BLEND_MODE_COLOR_BURN = false;
SPEC_CONST(bool) BLEND_MODE_LINEAR_LIGHT = false;
SPEC_CONST(bool) BLEND_MODE_VIVID_LIGHT = false;
SPEC_CONST(bool) BLEND_MODE_PIN_LIGHT = false;
SPEC_CONST(bool) BLEND_MODE_HARD_MIX = false;
SPEC_CONST(bool) BLEND_MODE_HARD_REFLECT = false;
SPEC_CONST(bool) BLEND_MODE_HARD_GLOW = false;
SPEC_CONST(bool) BLEND_MODE_HARD_PHOENIX = false;
SPEC_CONST(bool) BLEND_MODE_HUE = false;
SPEC_CONST(bool) BLEND_MODE_SATURATION = false;
SPEC_CONST(bool) BLEND_MODE_COLOR = false;
SPEC_CONST(bool) BLEND_MODE_LUMINOSITY = false;

#define BlendLinearBurnf(base, blend) max(base + blend - 1.0, 0.0)
#define BlendLinearDodgef(base, blend) min(base + blend, 1.0)
#define BlendOverlayf(base, blend) (base < 0.5 ? (2.0 * (base) * (blend)) : (1.0 - 2.0 * (1.0 - (base)) * (1.0 - (blend))))
#define BlendColorDodgef(base, blend) ((blend == 1.0) ? blend : min((base) / (1.0 - (blend)), 1.0))
#define BlendColorBurnf(base, blend) ((blend == 0.0) ? blend : max((1.0 - ((1.0 - (base)) / (blend))), 0.0))
#define BlendLinearLightf(base, blend) ((blend < 0.5) ? BlendLinearBurnf(base, 2.0 * blend) : BlendLinearDodgef(base, 2.0 * (blend - 0.5)))
#define BlendVividLightf(base, blend) ((blend < 0.5) ? BlendColorBurnf(base, 2.0 * blend) : BlendColorDodgef(base, 2.0 * (blend - 0.5)))
#define BlendPinLightf(base, blend) ((blend < 0.5) ? min(base, 2.0 * blend) : max(base, 2.0 * (blend - 0.5)))
#define BlendHardMixf(base, blend) ((BlendVividLightf(base, blend) < 0.5) ? 0.0 : 1.0)
#define BlendReflectf(base, blend) ((blend == 1.0) ? blend : min((base) * (base) / (1.0 - (blend)), 1.0))

#define BlendOverlay(base, blend) vec3(BlendOverlayf(base.r, blend.r), BlendOverlayf(base.g, blend.g), BlendOverlayf(base.b, blend.b))
#define BlendReflect(base, blend) vec3(BlendReflectf(base.r, blend.r), BlendReflectf(base.g, blend.g), BlendReflectf(base.b, blend.b));

// Hue Blend mode creates the result color by combining the luminance and saturation of the base color with the hue of the blend color.
vec3 BlendHue(vec3 base, vec3 blend)
{
    vec3 baseHSL = RGBToHSL(base);
    return HSLToRGB(vec3(RGBToHSL(blend).r, baseHSL.g, baseHSL.b));
}

// Saturation Blend mode creates the result color by combining the luminance and hue of the base color with the saturation of the blend color.
vec3 BlendSaturation(vec3 base, vec3 blend)
{
    vec3 baseHSL = RGBToHSL(base);
    return HSLToRGB(vec3(baseHSL.r, RGBToHSL(blend).g, baseHSL.b));
}

// Color Mode keeps the brightness of the base color and applies both the hue and saturation of the blend color.
vec3 BlendColor(vec3 base, vec3 blend)
{
    vec3 blendHSL = RGBToHSL(blend);
    return HSLToRGB(vec3(blendHSL.r, blendHSL.g, RGBToHSL(base).b));
}

// Luminosity Blend mode creates the result color by combining the hue and saturation of the base color with the luminance of the blend color.
vec3 BlendLuminosity(vec3 base, vec3 blend)
{
    vec3 baseHSL = RGBToHSL(base);
    return HSLToRGB(vec3(baseHSL.r, baseHSL.g, RGBToHSL(blend).b));
}

vec3 definedBlend(vec3 a, vec3 b) {
    vec3 result;
    if (BLEND_MODE_LIGHTEN) {
        result = max(a, b);
    } else if (BLEND_MODE_DARKEN) {
        result = min(a, b);
    } else if (BLEND_MODE_DIVIDE) {
        result = b / a;
    } else if (BLEND_MODE_AVERAGE) {
        result = (a + b) * 0.5;
    } else if (BLEND_MODE_SUBTRACT) {
        result = max(a + b - vec3(1.0), vec3(0.0));
    } else if (BLEND_MODE_DIFFERENCE) {
        result = abs(a - b);
    } else if (BLEND_MODE_NEGATION) {
        result = (vec3(1.0) - abs(vec3(1.0) - a - b));
    } else if (BLEND_MODE_EXCLUSION) {
        result = (a + b - 2.0 * a * b);
    } else if (BLEND_MODE_OVERLAY) {
        result = BlendOverlay(a, b);
    } else if (BLEND_MODE_SOFT_LIGHT) {
        result = ((1.0 - 2.0 * b) * a * a + 2.0 * a * b);
    } else if (BLEND_MODE_HARD_LIGHT) {
        result = BlendOverlay(b, a);
    } else if (BLEND_MODE_COLOR_DODGE) {
        result = vec3(BlendColorDodgef(a.r, b.r), BlendColorDodgef(a.g, b.g), BlendColorDodgef(a.b, b.b));
    } else if (BLEND_MODE_COLOR_BURN) {
        result = vec3(BlendColorBurnf(a.r, b.r), BlendColorBurnf(a.g, b.g), BlendColorBurnf(a.b, b.b));
    } else if (BLEND_MODE_LINEAR_LIGHT) {
        result = vec3(BlendLinearLightf(a.r, b.r), BlendLinearLightf(a.g, b.g), BlendLinearLightf(a.b, b.b));
    } else if (BLEND_MODE_VIVID_LIGHT) {
        result = vec3(BlendVividLightf(a.r, b.r), BlendVividLightf(a.g, b.g), BlendVividLightf(a.b, b.b));
    } else if (BLEND_MODE_PIN_LIGHT) {
        result = vec3(BlendPinLightf(a.r, b.r), BlendPinLightf(a.g, b.g), BlendPinLightf(a.b, b.b));
    } else if (BLEND_MODE_HARD_MIX) {
        result = vec3(BlendHardMixf(a.r, b.r), BlendHardMixf(a.g, b.g), BlendHardMixf(a.b, b.b));
    } else if (BLEND_MODE_HARD_REFLECT) {
        result = BlendReflect(a, b);
    } else if (BLEND_MODE_HARD_GLOW) {
        result = BlendReflect(b, a);
    } else if (BLEND_MODE_HARD_PHOENIX) {
        result = (min(a, b) - max(a, b) + vec3(1.0));
    } else if (BLEND_MODE_HUE) {
        result = BlendHue(a, b);
    } else if (BLEND_MODE_SATURATION) {
        result = BlendSaturation(a, b);
    } else if (BLEND_MODE_COLOR) {
        result = BlendColor(a, b);
    } else if (BLEND_MODE_LUMINOSITY) {
        result = BlendLuminosity(a, b);
    } else {
        result = eyeColorBlend(a, b);
    }
    return result;
}

vec4 applyCustomBlend(vec4 color) {
    vec4 result;
    vec3 framebuffer = getFramebufferColor().rgb;
    result.rgb = definedBlend(framebuffer, color.rgb);
    result.rgb = mix(framebuffer, result.rgb, color.a);
    result.a = 1.0;
    return result;
}

#endif // #ifdef FRAGMENT_SHADER
