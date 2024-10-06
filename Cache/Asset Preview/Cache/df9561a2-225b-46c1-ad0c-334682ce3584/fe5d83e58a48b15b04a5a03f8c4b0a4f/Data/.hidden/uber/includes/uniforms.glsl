//-----------------------------------------------------------------------
// Copyright (c) 2022 Snap Inc.
//-----------------------------------------------------------------------

#pragma once

// From blend_modes_eyecolor.glsl
uniform float     correctedIntensity;
DECLARE_TEXTURE(intensityTexture)

// From oit.glsl
uniform mediump texture2D sc_OITDepthHigh0;
uniform mediump texture2D sc_OITDepthLow0;
uniform mediump texture2D sc_OITAlpha0;
uniform mediump texture2D sc_OITDepthHigh1;
uniform mediump texture2D sc_OITDepthLow1;
uniform mediump texture2D sc_OITAlpha1;
uniform mediump texture2D sc_OITFilteredDepthBoundsTexture;
uniform mediump texture2D sc_OITFrontDepthTexture;
uniform mediump sampler sc_OITCommonSampler;

// From uber_lighting.glsl
uniform float reflBlurWidth;
uniform float reflBlurMinRough;
uniform float reflBlurMaxRough;
