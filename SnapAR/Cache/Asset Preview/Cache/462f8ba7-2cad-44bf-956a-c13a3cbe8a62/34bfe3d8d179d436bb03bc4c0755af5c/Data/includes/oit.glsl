//-----------------------------------------------------------------------
// Copyright (c) 2020 Snap Inc.
//-----------------------------------------------------------------------

#ifndef OIT_GLSL
#define OIT_GLSL

#ifdef FRAGMENT_SHADER

#if defined(sc_OITEnabled)
uniform sampler2D sc_OITDepthHigh0;
uniform sampler2D sc_OITDepthLow0;
uniform sampler2D sc_OITAlpha0;

#if defined(sc_OITMaxLayers8)
#define OitDepthGatherPassCount 2
uniform sampler2D sc_OITDepthHigh1;
uniform sampler2D sc_OITDepthLow1;
uniform sampler2D sc_OITAlpha1;
#else
#define OitDepthGatherPassCount 1
#endif // #if defined(sc_OITMaxLayers8)

#define DepthsPerGatherPass 4
#define MaxDepths (OitDepthGatherPassCount * DepthsPerGatherPass)

#define MAX_SCENE_DEPTH 1000.0 // todo this should be adjustable in some way.

uniform sampler2D sc_OITFilteredDepthBoundsTexture;
#if defined(sc_OITMaxLayers4Plus1)
uniform highp sampler2D sc_OITFrontDepthTexture;
#endif // #if defined(sc_OITMaxLayers4Plus1)

// When using skinning on iOS specifically, multiple passes with the same vertex shader and geometry do not reliably
// produce the exact same depth outputs, resulting in shimmering artefacts, both when testing with z-equal test
// for 4+1 OIT mode, and when comparing depths encoded in the OIT depth buffers.
// To get around this we use different tolerances for depth comparisons when skinning present on a phone target.
// These epsilons were derived by testing with a representative scene.
#if defined(sc_SkinBonesCount)
// front layer z test is using non-normalized logarithmic z values, so this epsilon represents a greater distance in linear z depth.
// technically epsilon should be applied to linearized values but this value works well over typical depth ranges without going
// through the expense of linearization.
const highp float FrontLayerZTestEpsilon = 5e-7;
// Epsilon in linear depth space. This will be converted to an integer epsilon based on the range of the scene at that pixel.
const highp float DepthOrderingEpsilon   = 1e-3;
#else
const highp float FrontLayerZTestEpsilon = 5e-8;
// No linear epsilon. z values from the same pixel on different passes will map to the same integer depth.
#endif // #if defined(sc_SkinBonesCount)

int encodeDepth(highp float depth, vec2 depthBounds) {
    // remap to depth bounds.
    highp float minDepth = (1.0 - depthBounds.x) * MAX_SCENE_DEPTH;
    highp float maxDepth = depthBounds.y * MAX_SCENE_DEPTH;
    highp float normalizedDepth = clamp((depth - minDepth) / (maxDepth - minDepth), 0.0, 1.0);
    return int(normalizedDepth * 65535.0);
}

vec2 sampleDepthBounds(vec2 screenUV) {
    return texture2D(sc_OITFilteredDepthBoundsTexture, vec2(screenUV.x, screenUV.y)).xy;
}

// Note: this is returning positive depth coordinates.
highp float viewSpaceDepth() {
    #if defined(UseViewSpaceDepthVariant) && (defined(sc_OITDepthGatherPass) || defined(sc_OITCompositingPass) || defined(sc_OITDepthBoundsPass))
        return varViewSpaceDepth;
    #else
        highp float m22 = sc_ProjectionMatrix[2][2];
        highp float m32 = sc_ProjectionMatrix[3][2];
        highp float clipSpaceDepth = gl_FragCoord.z * 2.0 - 1.0;
        return m32 / (m22 + clipSpaceDepth);
    #endif
}

#if defined(sc_OITDepthPrepass)

void oitDepthPrepass() {
    sc_FragData0 = vec4(1.0);
}

#endif // #if defined(sc_OITDepthPrepass)

#if defined(sc_OITDepthBoundsPass)

void oitWriteDepthBounds() {
    float normalizedDepth = clamp(viewSpaceDepth() / MAX_SCENE_DEPTH, 0.0, 1.0);
    // we are applying max operator to these terms.
    // first term is using complement to generate a min instead. A 1/255 offset is used as a safety buffer.
    // we are building loose bounds around the min/max depth for that pixel. We add -/+ 1 to the range to ensure we don't end up
    // with a bounds of size zero.
    float epsilon = 1.0 / 255.0;
    sc_FragData0 = vec4(max(0.0, 1.0 - (normalizedDepth - epsilon)), min(1.0, normalizedDepth + epsilon), 0.0, 0.0);
}

#endif // #if defined(sc_OITDepthBoundsPass)

#if defined(sc_OITDepthGatherPass)

// returns the two least significant bits from the value and shifts the value right by two bits.
float packValue(inout int value) {
    float lowOrderBits = floor(mod(float(value), 4.0));
    lowOrderBits = floor(lowOrderBits * 64.0);
    value = value / 4;
    return lowOrderBits / 255.0;
}

void oitDepthGather(vec4 materialColor) {
    vec2 screenUV = getScreenTextureUV();

    #if defined(sc_OITMaxLayers4Plus1)
    highp float frontDepth = texture2D(sc_OITFrontDepthTexture, screenUV).r;
    if ((gl_FragCoord.z - frontDepth) <= FrontLayerZTestEpsilon) {
        discard;
        return;
    }
    #endif // #if defined(sc_OITMaxLayers4Plus1)

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

    sc_FragData0 = depthHigh;
    sc_FragData1 = depthLow;
    sc_FragData2 = alphas;

    #if defined(sc_OITMaxLayersVisualizeLayerCount)
        // Accumulate number of layers in alpha channel.
        sc_FragData2 = vec4(1.0 / 255.0, 0.0, 0.0, 0.0);
    #endif
}

#endif // #if defined(sc_OITDepthGatherPass)

#if defined(sc_OITCompositingPass)

void unpackValues(float channel, int passIndex, inout int values[MaxDepths]) {
    channel = floor(channel * 255.0 + 0.5);
    // least recent depth is in the lower order bits.
    for (int i = (passIndex + 1) * DepthsPerGatherPass - 1; i >= (passIndex * DepthsPerGatherPass); --i) {
        values[i] = values[i] * 4 + int(floor(mod(channel, 4.0)));
        channel = floor(channel / 4.0);
    }
}

int depthEpsilonToIntDepth(highp float range, vec2 depthBounds) {
    highp float minDepth = (1.0 - depthBounds.x) * MAX_SCENE_DEPTH;
    return encodeDepth(minDepth + range, depthBounds);
}

void oitCompositing(vec4 materialColor) {
    vec2 screenUV = getScreenTextureUV();
    #if defined(sc_OITMaxLayers4Plus1)
    highp float frontDepth = texture2D(sc_OITFrontDepthTexture, screenUV).r;
    if ((gl_FragCoord.z - frontDepth) <= FrontLayerZTestEpsilon) {
        discard;
        return;
    }
    #endif // #if defined(sc_OITMaxLayers4Plus1)

    int depths[MaxDepths];
    int alphas[MaxDepths];
    for (int i = 0; i < MaxDepths; ++i) {
        depths[i] = 0;
        alphas[i] = 0;
    }

    for (int pass = 0; pass < OitDepthGatherPassCount; ++pass) {
        vec4 high;
        vec4 low;
        vec4 alpha;
        if (pass == 0) {
            high = texture2D(sc_OITDepthHigh0, screenUV);
            low = texture2D(sc_OITDepthLow0, screenUV);
            alpha = texture2D(sc_OITAlpha0, screenUV);
        }
        #if defined(sc_OITMaxLayers8)
        if (pass == 1) {
            high = texture2D(sc_OITDepthHigh1, screenUV);
            low = texture2D(sc_OITDepthLow1, screenUV);
            alpha = texture2D(sc_OITAlpha1, screenUV);
        }
        #endif // #if defined(sc_OITMaxLayers8)
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
    #if defined(sc_SkinBonesCount)
    int intDepthEpsilon = depthEpsilonToIntDepth(DepthOrderingEpsilon, depthBounds);
    #else
    int intDepthEpsilon = 0;
    #endif // #if defined(sc_SkinBonesCount)

    int curDepth = encodeDepth(viewSpaceDepth(), depthBounds);
    vec4 finalColor = materialColor * materialColor.a;

    for (int i = 0; i < MaxDepths; ++i) {
        if (depths[i] < curDepth - intDepthEpsilon && depths[i] > 0) {
            finalColor.rgb *= (1.0 - float(alphas[i]) / 255.0);
        }
    }

    sc_FragData0 = finalColor;
    #if defined(sc_OITMaxLayersVisualizeLayerCount)
        // Disable compositing pass for visualization mode.
        // todo(dfilionguay) compositing pass should never render in the first place.
        discard;
    #endif
}

#endif // #if defined(sc_OITCompositingPass)

#if defined(sc_OITFrontLayerPass)

void oitFrontLayer(vec4 shaderOutputColor) {
    vec2 screenUV = getScreenTextureUV();
    highp float frontDepth = texture2D(sc_OITFrontDepthTexture, screenUV).r;
    if (abs(gl_FragCoord.z - frontDepth) > FrontLayerZTestEpsilon) {
        discard;
    } else {
        sc_FragData0 = shaderOutputColor;
    }
}

#endif // #if defined(sc_OITFrontLayerPass)

#endif // #if defined(sc_OITEnabled)

void processOIT(vec4 shaderOutputColor) {
    shaderOutputColor = clamp(shaderOutputColor, 0.0, 1.0);
#if defined(sc_OITDepthBoundsPass)
    oitWriteDepthBounds();
#elif defined(sc_OITDepthPrepass)
    oitDepthPrepass();
#elif defined(sc_OITDepthGatherPass)
    oitDepthGather(shaderOutputColor);
#elif defined(sc_OITCompositingPass)
    oitCompositing(shaderOutputColor);
#elif defined(sc_OITFrontLayerPass)
    oitFrontLayer(shaderOutputColor);
#else
   sc_FragData0 = shaderOutputColor;
#endif
}

#endif // #ifdef FRAGMENT_SHADER

#endif
