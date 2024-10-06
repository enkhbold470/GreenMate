//-----------------------------------------------------------------------
// Copyright (c) 2020 Snap Inc.
//-----------------------------------------------------------------------

#ifndef OIT_GLSL
#define OIT_GLSL

#include "uniforms.glsl"

#ifdef FRAGMENT_SHADER

#define DepthsPerGatherPass 4
#define MaxOitDepthGatherPassCount 2
#define MaxDepths (MaxOitDepthGatherPassCount * DepthsPerGatherPass)
#define MAX_SCENE_DEPTH 1000.0 // todo this should be adjustable in some way.

// When using skinning on iOS specifically, multiple passes with the same vertex shader and geometry do not reliably
// produce the exact same depth outputs, resulting in shimmering artefacts, both when testing with z-equal test
// for 4+1 OIT mode, and when comparing depths encoded in the OIT depth buffers.
// To get around this we use different tolerances for depth comparisons when skinning present on a phone target.
// These epsilons were derived by testing with a representative scene.

// front layer z test is using non-normalized logarithmic z values, so this epsilon represents a greater distance in linear z depth.
// technically epsilon should be applied to linearized values but this value works well over typical depth ranges without going
// through the expense of linearization.
const highp float SkinnedFrontLayerZTestEpsilon = 5e-7;
// Epsilon in linear depth space. This will be converted to an integer epsilon based on the range of the scene at that pixel.
const highp float SkinnedDepthOrderingEpsilon   = 1e-3;

const highp float FrontLayerZTestEpsilon = 5e-8;
const highp float DepthOrderingEpsilon   = 0.0;

float getFrontLayerZTestEpsilon() {
    float result;
    if (sc_SkinBonesCount > 0) {
        result = SkinnedFrontLayerZTestEpsilon;
    } else {
        result = FrontLayerZTestEpsilon;
    }
    return result;
}

float getDepthOrderingEpsilon() {
    float result;
    if (sc_SkinBonesCount > 0) {
        result = SkinnedDepthOrderingEpsilon;
    } else {
        result = DepthOrderingEpsilon;
    }
    return result;
}

int encodeDepth(highp float depth, vec2 depthBounds) {
    // remap to depth bounds.
    highp float minDepth = (1.0 - depthBounds.x) * MAX_SCENE_DEPTH;
    highp float maxDepth = depthBounds.y * MAX_SCENE_DEPTH;
    highp float normalizedDepth = clamp((depth - minDepth) / (maxDepth - minDepth), 0.0, 1.0);
    return int(normalizedDepth * 65535.0);
}

vec2 sampleDepthBounds(vec2 screenUV) {
    return texture(sampler2D(sc_OITFilteredDepthBoundsTexture, sc_OITCommonSampler), vec2(screenUV.x, screenUV.y)).xy;
}

// Note: this is returning positive depth coordinates.
highp float viewSpaceDepth() {
    float result;
    if (UseViewSpaceDepthVariant && (sc_OITDepthGatherPass || sc_OITCompositingPass || sc_OITDepthBoundsPass)) {
        result = varViewSpaceDepth;
    } else {
        highp float m22 = sc_ProjectionMatrix[2][2];
        highp float m32 = sc_ProjectionMatrix[3][2];
        highp float clipSpaceDepth = sc_GetGlFragCoord().z * 2.0 - 1.0;
        result = m32 / (m22 + clipSpaceDepth);
    }
    return result;
}

void oitDepthPrepass() {
    sc_writeFragData0(vec4(1.0));
}

void oitWriteDepthBounds() {
    if (sc_OITDepthBoundsPass) {
        float normalizedDepth = clamp(viewSpaceDepth() / MAX_SCENE_DEPTH, 0.0, 1.0);
        // we are applying max operator to these terms.
        // first term is using complement to generate a min instead. A 1/255 offset is used as a safety buffer.
        // we are building loose bounds around the min/max depth for that pixel. We add -/+ 1 to the range to ensure we don't end up
        // with a bounds of size zero.
        float epsilon = 1.0 / 255.0;
        sc_writeFragData0(vec4(max(0.0, 1.0 - (normalizedDepth - epsilon)), min(1.0, normalizedDepth + epsilon), 0.0, 0.0));
    }
}

// Returns the two least significant bits from the value and shifts the value right by two bits.
float packValue(inout int value) {
    float result;
    // Used by depth gather pass only.
    if (sc_OITDepthGatherPass) {
        float lowOrderBits = floor(mod(float(value), 4.0));
        lowOrderBits = floor(lowOrderBits * 64.0);
        value = value / 4;
        result = lowOrderBits / 255.0;
    } else {
        result = 0.0;
    }
    return result;
}

void unpackValues(float channel, int passIndex, inout int values[MaxDepths]) {
    // Used by compositing pass only.
    if (sc_OITCompositingPass) {
        channel = floor(channel * 255.0 + 0.5);
        // least recent depth is in the lower order bits.
        for (int i = (passIndex + 1) * DepthsPerGatherPass - 1; i >= (passIndex * DepthsPerGatherPass); --i) {
            values[i] = values[i] * 4 + int(floor(mod(channel, 4.0)));
            channel = floor(channel / 4.0);
        }
    }
}

void oitDepthGather(vec4 materialColor) {
    if (sc_OITDepthGatherPass) {
        vec2 screenUV = getScreenUV();

        if (sc_OITMaxLayers4Plus1) {
            highp float frontDepth = texture(sampler2D(sc_OITFrontDepthTexture, sc_OITCommonSampler), screenUV).r;
            if ((sc_GetGlFragCoord().z - frontDepth) <= getFrontLayerZTestEpsilon()) {
                discard;
                return;
            }
        }

        vec2 depthBounds = sampleDepthBounds(screenUV);
        int depth = encodeDepth(viewSpaceDepth(), depthBounds);
        int alpha = int(materialColor.a * 255.0);

        vec4 depthLow;
        vec4 depthHigh;
        vec4 alphas;
        // note that depth variable is modified after returning from packValue().
        depthLow.r = packValue(depth); // lowest order bits are in red channel.
        depthLow.g = packValue(depth);
        depthLow.b = packValue(depth);
        depthLow.a = packValue(depth);
        depthHigh.r = packValue(depth);
        depthHigh.g = packValue(depth);
        depthHigh.b = packValue(depth);
        depthHigh.a = packValue(depth);
        alphas.r = packValue(alpha);
        alphas.g = packValue(alpha);
        alphas.b = packValue(alpha);
        alphas.a = packValue(alpha);

        sc_writeFragData0(depthHigh);
        sc_writeFragData1(depthLow);
        sc_writeFragData2(alphas);
        if (sc_OITMaxLayersVisualizeLayerCount) {
            sc_writeFragData2(vec4(1.0 / 255.0, 0.0, 0.0, 0.0));
        }
    }
}

int depthEpsilonToIntDepth(highp float range, vec2 depthBounds) {
    highp float minDepth = (1.0 - depthBounds.x) * MAX_SCENE_DEPTH;
    return encodeDepth(minDepth + range, depthBounds);
}

void oitCompositing(vec4 materialColor) {
    if (sc_OITCompositingPass)
    {
        vec2 screenUV = getScreenUV();
        if (sc_OITMaxLayers4Plus1) {
            highp float frontDepth = texture(sampler2D(sc_OITFrontDepthTexture, sc_OITCommonSampler), screenUV).r;
            if ((sc_GetGlFragCoord().z - frontDepth) <= getFrontLayerZTestEpsilon()) {
                discard;
                return;
            }
        }

        int depths[MaxDepths];
        int alphas[MaxDepths];
        for (int i = 0; i < MaxDepths; ++i) {
            depths[i] = 0;
            alphas[i] = 0;
        }

        int depthGatherPasses = 1;
        if (sc_OITMaxLayers8) {
            depthGatherPasses = 2;
        }
        for (int pass = 0; pass < depthGatherPasses; ++pass) {
            vec4 high;
            vec4 low;
            vec4 alpha;
            if (pass == 0) {
                high = texture(sampler2D(sc_OITDepthHigh0, sc_OITCommonSampler), screenUV);
                low = texture(sampler2D(sc_OITDepthLow0, sc_OITCommonSampler), screenUV);
                alpha = texture(sampler2D(sc_OITAlpha0, sc_OITCommonSampler), screenUV);
            }
            if (pass == 1) {
                high = texture(sampler2D(sc_OITDepthHigh1, sc_OITCommonSampler), screenUV);
                low = texture(sampler2D(sc_OITDepthLow1, sc_OITCommonSampler), screenUV);
                alpha = texture(sampler2D(sc_OITAlpha1, sc_OITCommonSampler), screenUV);
            }
            if (high != vec4(0.0) || low != vec4(0.0)) {
                // unpack high order bits first, in the reverse order they were packed.
                unpackValues(high.a, pass, depths);
                unpackValues(high.b, pass, depths);
                unpackValues(high.g, pass, depths);
                unpackValues(high.r, pass, depths);
                unpackValues(low.a, pass, depths);
                unpackValues(low.b, pass, depths);
                unpackValues(low.g, pass, depths);
                unpackValues(low.r, pass, depths);
                unpackValues(alpha.a, pass, alphas);
                unpackValues(alpha.b, pass, alphas);
                unpackValues(alpha.g, pass, alphas);
                unpackValues(alpha.r, pass, alphas);
            }
        }

        vec2 depthBounds = sampleDepthBounds(screenUV);
        int intDepthEpsilon = 0;
        if (sc_SkinBonesCount > 0) {
            intDepthEpsilon = depthEpsilonToIntDepth(getDepthOrderingEpsilon(), depthBounds);
        }

        int curDepth = encodeDepth(viewSpaceDepth(), depthBounds);
        vec4 finalColor = materialColor * materialColor.a;

        for (int i = 0; i < MaxDepths; ++i) {
            if (depths[i] < curDepth - intDepthEpsilon && depths[i] > 0) {
                finalColor.rgb *= (1.0 - float(alphas[i]) / 255.0);
            }
        }

        sc_writeFragData0(finalColor);
        if (sc_OITMaxLayersVisualizeLayerCount) {
            // Disable compositing pass for visualization mode.
            // todo(dfilionguay) compositing pass should never render in the first place.
            discard;
        }
    }
}

void oitFrontLayer(vec4 shaderOutputColor) {
    if (sc_OITFrontLayerPass) {
        vec2 screenUV = getScreenUV();
        highp float frontDepth = texture(sampler2D(sc_OITFrontDepthTexture, sc_OITCommonSampler), screenUV).r;
        if (abs(sc_GetGlFragCoord().z - frontDepth) > getFrontLayerZTestEpsilon()) {
            discard;
        } else {
            sc_writeFragData0(shaderOutputColor);
        }
    }
}

void processOIT(vec4 shaderOutputColor) {
#ifndef SC_BACKEND_LANGUAGE_METAL
    vec4 shaderOutputColorClamped = clamp(shaderOutputColor, 0.0, 1.0);
    if (sc_OITDepthBoundsPass) {
        oitWriteDepthBounds();
    } else if (sc_OITDepthPrepass) {
        oitDepthPrepass();
    } else if (sc_OITDepthGatherPass) {
        oitDepthGather(shaderOutputColorClamped);
    } else if (sc_OITCompositingPass) {
        oitCompositing(shaderOutputColorClamped);
    } else if (sc_OITFrontLayerPass) {
        oitFrontLayer(shaderOutputColorClamped);
    } else {
        sc_writeFragData0(shaderOutputColor);
    }
#endif // #ifndef SC_BACKEND_LANGUAGE_METAL
}

#endif // #ifdef FRAGMENT_SHADER

#endif // #ifndef OIT_GLSL
