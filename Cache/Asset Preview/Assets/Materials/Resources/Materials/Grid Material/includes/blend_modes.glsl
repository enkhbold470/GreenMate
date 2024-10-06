//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef BLEND_MODES_GLSL
#define BLEND_MODES_GLSL

#include <std_fs.glsl>
#include "blend_modes_eyecolor.glsl"
#include "rgbhsl.glsl"

#ifdef FRAGMENT_SHADER
#ifdef sc_BlendMode_Custom

/*
 ** Contrast, saturation, brightness
 ** Code of this function is from TGM's shader pack
 ** http://irrlicht.sourceforge.net/phpBB2/viewtopic.php?t=21057
 */

// For all settings: 1.0 = 100% 0.5=50% 1.5 = 150%
vec3 ContrastSaturationBrightness(vec3 color, float brt, float sat, float con)
{
    // Increase or decrease theese values to adjust r, g and b color channels seperately
    const float AvgLumR = 0.5;
    const float AvgLumG = 0.5;
    const float AvgLumB = 0.5;

    const vec3 LumCoeff = vec3(0.2125, 0.7154, 0.0721);

    vec3 AvgLumin = vec3(AvgLumR, AvgLumG, AvgLumB);
    vec3 brtColor = color * brt;
    vec3 intensity = vec3(dot(brtColor, LumCoeff));
    vec3 satColor = mix(intensity, brtColor, sat);
    vec3 conColor = mix(AvgLumin, satColor, con);
    return conColor;
}


/*
 ** Float blending modes
 ** Adapted from here: http://www.nathanm.com/photoshop-blending-math/
 ** But I modified the HardMix (wrong condition), Overlay, SoftLight, ColorDodge, ColorBurn, VividLight, PinLight (inverted layers) ones to have correct results
 */

float BlendAddf(float base, float blend) {
    return min(base + blend, 1.0);
}
float BlendSubtractf(float base, float blend) {
    return max(base + blend - 1.0, 0.0);
}
float BlendLinearDodgef(float base, float blend) {
    return min(base + blend, 1.0);
}
float BlendLinearBurnf(float base, float blend) {
    return max(base + blend - 1.0, 0.0);
}
float BlendLightenf(float base, float blend) {
    return max(blend, base);
}
float BlendDarkenf(float base, float blend) {
    return min(blend, base);
}
float BlendScreenf(float base, float blend) {
    return (1.0 - ((1.0 - (base)) * (1.0 - (blend))));
}
float BlendOverlayf(float base, float blend) {
    return (base < 0.5 ? (2.0 * (base) * (blend)) : (1.0 - 2.0 * (1.0 - (base)) * (1.0 - (blend))));
}
float BlendSoftLightf(float base, float blend) {
    return ((1.0 - 2.0 * (blend))*(base)*(base) + 2.0 * (base) * (blend));
}
float BlendColorDodgef(float base, float blend) {
    return ((blend == 1.0) ? blend : min((base) / (1.0 - (blend)), 1.0));
}
float BlendColorBurnf(float base, float blend) {
    return ((blend == 0.0) ? blend : max((1.0 - ((1.0 - (base)) / (blend))), 0.0));
}
float BlendLinearLightf(float base, float blend) {
    if(blend < 0.5) {
        return BlendLinearBurnf(base, 2.0 * blend);
    }
    else {
        return BlendLinearDodgef(base, 2.0 * (blend - 0.5));
    }
}
float BlendVividLightf(float base, float blend) {
    if(blend < 0.5) {
        return BlendColorBurnf(base, 2.0 * blend);
    }
    else {
        return BlendColorDodgef(base, 2.0 * (blend - 0.5));
    }
}
float BlendPinLightf(float base, float blend) {
    if(blend < 0.5) {
        return BlendDarkenf(base, 2.0 * blend);
    }
    else {
        return BlendLightenf(base, 2.0 * (blend - 0.5));
    }
}
float BlendHardMixf(float base, float blend) {
    if(BlendVividLightf(base, blend) < 0.5) {
        return 0.0;
    }
    else {
        return 1.0;
    }
}
float BlendReflectf(float base, float blend) {
    return ((blend == 1.0) ? blend : min((base) * (base) / (1.0 - (blend)), 1.0));
}

//#define BlendLinearDodgef 			    BlendAddf
//#define BlendLinearBurnf 			        BlendSubtractf
//#define BlendAddf(base, blend) 		    min(base + blend, 1.0)
//#define BlendSubtractf(base, blend) 	    max(base + blend - 1.0, 0.0)
//#define BlendLightenf(base, blend) 		max(blend, base)
//#define BlendDarkenf(base, blend) 		min(blend, base)
//#define BlendLinearLightf(base, blend) 	(blend < 0.5 ? BlendLinearBurnf(base, (2.0 * (blend))) : BlendLinearDodgef(base, (2.0 * ((blend) - 0.5))))
//#define BlendScreenf(base, blend) 		(1.0 - ((1.0 - (base)) * (1.0 - (blend))))
//#define BlendOverlayf(base, blend) 	    (base < 0.5 ? (2.0 * (base) * (blend)) : (1.0 - 2.0 * (1.0 - (base)) * (1.0 - (blend))))
//#define BlendSoftLightf(base, blend) 	    ((1.0 - 2.0 * (blend))*(base)*(base) + 2.0 * (base) * (blend))
//#define BlendColorDodgef(base, blend) 	((blend == 1.0) ? blend : min((base) / (1.0 - (blend)), 1.0))
//#define BlendColorBurnf(base, blend) 	    ((blend == 0.0) ? blend : max((1.0 - ((1.0 - (base)) / (blend))), 0.0))
//#define BlendVividLightf(base, blend) 	((blend < 0.5) ? BlendColorBurnf(base, (2.0 * (blend))) : BlendColorDodgef(base, (2.0 * ((blend) - 0.5))))
//#define BlendPinLightf(base, blend) 	    ((blend < 0.5) ? BlendDarkenf(base, (2.0 * (blend))) : BlendLightenf(base, (2.0 *((blend) - 0.5))))
//#define BlendHardMixf(base, blend) 	    ((BlendVividLightf(base, blend) < 0.5) ? 0.0 : 1.0)
//#define BlendReflectf(base, blend) 		((blend == 1.0) ? blend : min((base) * (base) / (1.0 - (blend)), 1.0))

/*
 ** Vector3 blending modes
 */

// Component wise blending

#define BlendNormal(base, blend) 		(blend)
#define BlendLighten(base, blend)		(vec3(BlendLightenf(base.r, blend.r),BlendLightenf(base.g, blend.g),BlendLightenf(base.b, blend.b)))
#define BlendDarken(base, blend)		(vec3(BlendDarkenf(base.r, blend.r),BlendDarkenf(base.g, blend.g),BlendDarkenf(base.b, blend.b)))
#define BlendMultiply(base, blend) 		((base) * (blend))
#define BlendDivide(base, blend) 		((blend) / (base))
#define BlendAverage(base, blend) 		((base + blend) / 2.0)
#define BlendAdd(base, blend) 		    min(base + blend, vec3(1.0))
#define BlendSubtract(base, blend) 	    max(base + blend - vec3(1.0), vec3(0.0))
#define BlendDifference(base, blend) 	abs(base - (blend))
#define BlendNegation(base, blend) 	    (vec3(1.0) - abs(vec3(1.0) - (base) - (blend)))
#define BlendExclusion(base, blend) 	(base + blend - 2.0 * (base) * (blend))
#define BlendScreen(base, blend) 		vec3(BlendScreenf(base.r, blend.r), BlendScreenf(base.g, blend.g), BlendScreenf(base.b, blend.b))

#define BlendOverlay(base, blend) 		vec3(BlendOverlayf(base.r, blend.r), BlendOverlayf(base.g, blend.g), BlendOverlayf(base.b, blend.b))
#define BlendSoftLight(base, blend) 	vec3(BlendSoftLightf(base.r, blend.r),BlendSoftLightf(base.g, blend.g),BlendSoftLightf(base.b, blend.b))
#define BlendHardLight(base, blend) 	BlendOverlay(blend, base)
#define BlendColorDodge(base, blend) 	vec3(BlendColorDodgef(base.r, blend.r), BlendColorDodgef(base.g, blend.g), BlendColorDodgef(base.b, blend.b))
#define BlendColorBurn(base, blend) 	vec3(BlendColorBurnf(base.r, blend.r), BlendColorBurnf(base.g, blend.g), BlendColorBurnf(base.b, blend.b))
#define BlendLinearDodge(base, blend)	BlendAdd(base, blend)
#define BlendLinearBurn(base, blend)	BlendSubtract(base, blend)
// Linear Light is another contrast-increasing mode
// If the blend color is darker than midgray, Linear Light darkens the image by decreasing the brightness. If the blend color is lighter than midgray, the result is a brighter image due to increased brightness.
#define BlendLinearLight(base, blend) 	vec3(BlendLinearLightf(base.r, blend.r), BlendLinearLightf(base.g, blend.g), BlendLinearLightf(base.b, blend.b))
#define BlendVividLight(base, blend) 	vec3(BlendVividLightf(base.r, blend.r), BlendVividLightf(base.g, blend.g), BlendVividLightf(base.b, blend.b))
#define BlendPinLight(base, blend) 		vec3(BlendPinLightf(base.r, blend.r), BlendPinLightf(base.g, blend.g), BlendPinLightf(base.b, blend.b))
#define BlendHardMix(base, blend) 		vec3(BlendHardMixf(base.r, blend.r), BlendHardMixf(base.g, blend.g), BlendHardMixf(base.b, blend.b))
#define BlendReflect(base, blend) 		vec3(BlendReflectf(base.r, blend.r), BlendReflectf(base.g, blend.g), BlendReflectf(base.b, blend.b))
#define BlendGlow(base, blend) 		    BlendReflect(blend, base)
#define BlendPhoenix(base, blend) 		(min(base, blend) - max(base, blend) + vec3(1.0))
#define BlendOpacity(base, blend, F, O) 	(F(base, blend) * O + (blend) * (1.0 - O))


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


/*
 ** Gamma correction
 ** Details: http://blog.mouaif.org/2009/01/22/photoshop-gamma-correction-shader/
 */

#define GammaCorrection(color, gamma)								pow(color, 1.0 / gamma)

/*
 ** Levels control (input (+gamma), output)
 ** Details: http://blog.mouaif.org/2009/01/28/levels-control-shader/
 */

#define LevelsControlInputRange(color, minInput, maxInput)				min(max(color - vec3(minInput), vec3(0.0)) / (vec3(maxInput) - vec3(minInput)), vec3(1.0))
#define LevelsControlInput(color, minInput, gamma, maxInput)				GammaCorrection(LevelsControlInputRange(color, minInput, maxInput), gamma)
#define LevelsControlOutputRange(color, minOutput, maxOutput) 			mix(vec3(minOutput), vec3(maxOutput), color)
#define LevelsControl(color, minInput, gamma, maxInput, minOutput, maxOutput) 	LevelsControlOutputRange(LevelsControlInput(color, minInput, gamma, maxInput), minOutput, maxOutput)



#if   defined BLEND_MODE_NORMAL
#define definedBlend(a,b) BlendNormal(a,b)

#elif defined BLEND_MODE_LIGHTEN
#define definedBlend(a,b) BlendLighten(a,b)

#elif defined BLEND_MODE_DARKEN
#define definedBlend(a,b) BlendDarken(a,b)

#elif defined BLEND_MODE_MULTIPLY
#define definedBlend(a,b) BlendMultiply(a,b)

#elif defined BLEND_MODE_DIVIDE
#define definedBlend(a,b) BlendDivide(a,b)

#elif defined BLEND_MODE_AVERAGE
#define definedBlend(a,b) BlendAverage(a,b)

#elif defined BLEND_MODE_ADD
#define definedBlend(a,b) BlendAdd(a,b)

#elif defined BLEND_MODE_SUBTRACT
#define definedBlend(a,b) BlendSubtract(a,b)

#elif defined BLEND_MODE_DIFFERENCE
#define definedBlend(a,b) BlendDifference(a,b)

#elif defined BLEND_MODE_NEGATION
#define definedBlend(a,b) BlendNegation(a,b)

#elif defined BLEND_MODE_EXCLUSION
#define definedBlend(a,b) BlendExclusion(a,b)

#elif defined BLEND_MODE_SCREEN
#define definedBlend(a,b) BlendScreen(a,b)

#elif defined BLEND_MODE_OVERLAY
#define definedBlend(a,b) BlendOverlay(a,b)

#elif defined BLEND_MODE_SOFT_LIGHT
#define definedBlend(a,b) BlendSoftLight(a,b)

#elif defined BLEND_MODE_HARD_LIGHT
#define definedBlend(a,b) BlendHardLight(a,b)

#elif defined BLEND_MODE_COLOR_DODGE
#define definedBlend(a,b) BlendColorDodge(a,b)

#elif defined BLEND_MODE_COLOR_BURN
#define definedBlend(a,b) BlendColorBurn(a,b)

#elif defined BLEND_MODE_LINEAR_LIGHT
#define definedBlend(a,b) BlendLinearLight(a,b)

#elif defined BLEND_MODE_VIVID_LIGHT
#define definedBlend(a,b) BlendVividLight(a,b)

#elif defined BLEND_MODE_PIN_LIGHT
#define definedBlend(a,b) BlendPinLight(a,b)

#elif defined BLEND_MODE_HARD_MIX
#define definedBlend(a,b) BlendHardMix(a,b)

#elif defined BLEND_MODE_HARD_REFLECT
#define definedBlend(a,b) BlendReflect(a,b)

#elif defined BLEND_MODE_HARD_GLOW
#define definedBlend(a,b) BlendGlow(a,b)

#elif defined BLEND_MODE_HARD_PHOENIX
#define definedBlend(a,b) BlendPhoenix(a,b)

#elif defined BLEND_MODE_HUE
#define definedBlend(a,b) BlendHue(a,b)

#elif defined BLEND_MODE_SATURATION
#define definedBlend(a,b) BlendSaturation(a,b)

#elif defined BLEND_MODE_COLOR
#define definedBlend(a,b) BlendColor(a,b)

#elif defined BLEND_MODE_LUMINOSITY
#define definedBlend(a,b) BlendLuminosity(a,b)

#endif

#ifndef definedBlend
#error If you define sc_BlendMode_Custom, you must also define a BLEND_MODE_*!
#endif

vec4 applyCustomBlend(vec4 color) {
    vec4 result;
    vec3 framebuffer = getFramebufferColor().rgb;
    result.rgb = definedBlend(framebuffer, color.rgb);
    result.rgb = mix(framebuffer, result.rgb, color.a);
    result.a = 1.0;
    return result;
}

#endif // sc_BlendMode_Custom
#endif // FRAGMENT_SHADER

#endif //BLEND_MODES_GLSL
