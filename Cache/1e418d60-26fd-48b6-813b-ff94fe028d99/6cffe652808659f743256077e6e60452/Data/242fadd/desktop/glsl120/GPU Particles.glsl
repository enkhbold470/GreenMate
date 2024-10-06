//#include <required.glsl> // [HACK 4/6/2023] See SCC shader_merger.cpp
//SG_REFLECTION_BEGIN(100)
//attribute vec4 boneData 5
//attribute vec3 blendShape0Pos 6
//attribute vec3 blendShape0Normal 12
//attribute vec3 blendShape1Pos 7
//attribute vec3 blendShape1Normal 13
//attribute vec3 blendShape2Pos 8
//attribute vec3 blendShape2Normal 14
//attribute vec3 blendShape3Pos 9
//attribute vec3 blendShape4Pos 10
//attribute vec3 blendShape5Pos 11
//attribute vec4 position 0
//attribute vec3 normal 1
//attribute vec4 tangent 2
//attribute vec2 texture0 3
//attribute vec2 texture1 4
//attribute vec4 color 18
//attribute vec3 positionNext 15
//attribute vec3 positionPrevious 16
//attribute vec4 strandProperties 17
//sampler sampler colorRampTextureSmpSC 2:20
//sampler sampler intensityTextureSmpSC 2:21
//sampler sampler mainTextureSmpSC 2:22
//sampler sampler normalTexSmpSC 2:23
//sampler sampler sc_EnvmapDiffuseSmpSC 2:24
//sampler sampler sc_EnvmapSpecularSmpSC 2:25
//sampler sampler sc_OITCommonSampler 2:26
//sampler sampler sc_SSAOTextureSmpSC 2:27
//sampler sampler sc_ScreenTextureSmpSC 2:28
//sampler sampler sc_ShadowTextureSmpSC 2:29
//sampler sampler sizeRampTextureSmpSC 2:31
//sampler sampler velRampTextureSmpSC 2:32
//texture texture2D colorRampTexture 2:0:2:20
//texture texture2D intensityTexture 2:1:2:21
//texture texture2D mainTexture 2:2:2:22
//texture texture2D normalTex 2:3:2:23
//texture texture2D sc_EnvmapDiffuse 2:4:2:24
//texture texture2D sc_EnvmapSpecular 2:5:2:25
//texture texture2D sc_OITAlpha0 2:6:2:26
//texture texture2D sc_OITAlpha1 2:7:2:26
//texture texture2D sc_OITDepthHigh0 2:8:2:26
//texture texture2D sc_OITDepthHigh1 2:9:2:26
//texture texture2D sc_OITDepthLow0 2:10:2:26
//texture texture2D sc_OITDepthLow1 2:11:2:26
//texture texture2D sc_OITFilteredDepthBoundsTexture 2:12:2:26
//texture texture2D sc_OITFrontDepthTexture 2:13:2:26
//texture texture2D sc_SSAOTexture 2:14:2:27
//texture texture2D sc_ScreenTexture 2:15:2:28
//texture texture2D sc_ShadowTexture 2:16:2:29
//texture texture2D sizeRampTexture 2:18:2:31
//texture texture2D velRampTexture 2:19:2:32
//SG_REFLECTION_END
#if defined VERTEX_SHADER
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_BACKEND_SHADER_FLAGS_END__
#endif
#define SC_DISABLE_FRUSTUM_CULLING
#define SC_ENABLE_INSTANCED_RENDERING
#ifdef ALIGNTOX
#undef ALIGNTOX
#endif
#ifdef ALIGNTOY
#undef ALIGNTOY
#endif
#ifdef ALIGNTOZ
#undef ALIGNTOZ
#endif
#ifdef CENTER_BBOX
#undef CENTER_BBOX
#endif
#define sc_StereoRendering_Disabled 0
#define sc_StereoRendering_InstancedClipped 1
#define sc_StereoRendering_Multiview 2
#ifdef GL_ES
    #define SC_GLES_VERSION_20 2000
    #define SC_GLES_VERSION_30 3000
    #define SC_GLES_VERSION_31 3100
    #define SC_GLES_VERSION_32 3200
#endif
#ifdef VERTEX_SHADER
    #define scOutPos(clipPosition) gl_Position=clipPosition
    #define MAIN main
#endif
#ifdef SC_ENABLE_INSTANCED_RENDERING
    #ifndef sc_EnableInstancing
        #define sc_EnableInstancing 1
    #endif
#endif
#define mod(x,y) (x-y*floor((x+1e-6)/y))
#if defined(GL_ES)&&(__VERSION__<300)&&!defined(GL_OES_standard_derivatives)
#define dFdx(A) (A)
#define dFdy(A) (A)
#define fwidth(A) (A)
#endif
#if __VERSION__<300
#define isinf(x) (x!=0.0&&x*2.0==x ? true : false)
#define isnan(x) (x>0.0||x<0.0||x==0.0 ? false : true)
#endif
#ifdef sc_EnableFeatureLevelES3
    #ifdef sc_EnableStereoClipDistance
        #if defined(GL_APPLE_clip_distance)
            #extension GL_APPLE_clip_distance : require
        #elif defined(GL_EXT_clip_cull_distance)
            #extension GL_EXT_clip_cull_distance : require
        #else
            #error Clip distance is requested but not supported by this device.
        #endif
    #endif
#else
    #ifdef sc_EnableStereoClipDistance
        #error Clip distance is requested but not supported by this device.
    #endif
#endif
#ifdef sc_EnableFeatureLevelES3
    #ifdef VERTEX_SHADER
        #define attribute in
        #define varying out
    #endif
    #ifdef FRAGMENT_SHADER
        #define varying in
    #endif
    #define gl_FragColor sc_FragData0
    #define texture2D texture
    #define texture2DLod textureLod
    #define texture2DLodEXT textureLod
    #define textureCubeLodEXT textureLod
    #define sc_CanUseTextureLod 1
#else
    #ifdef FRAGMENT_SHADER
        #if defined(GL_EXT_shader_texture_lod)
            #extension GL_EXT_shader_texture_lod : require
            #define sc_CanUseTextureLod 1
            #define texture2DLod texture2DLodEXT
        #endif
    #endif
#endif
#if defined(sc_EnableMultiviewStereoRendering)
    #define sc_StereoRenderingMode sc_StereoRendering_Multiview
    #define sc_NumStereoViews 2
    #extension GL_OVR_multiview2 : require
    #ifdef VERTEX_SHADER
        #ifdef sc_EnableInstancingFallback
            #define sc_GlobalInstanceID (sc_FallbackInstanceID*2+gl_InstanceID)
        #else
            #define sc_GlobalInstanceID gl_InstanceID
        #endif
        #define sc_LocalInstanceID sc_GlobalInstanceID
        #define sc_StereoViewID int(gl_ViewID_OVR)
    #endif
#elif defined(sc_EnableInstancedClippedStereoRendering)
    #ifndef sc_EnableInstancing
        #error Instanced-clipped stereo rendering requires enabled instancing.
    #endif
    #ifndef sc_EnableStereoClipDistance
        #define sc_StereoRendering_IsClipDistanceEnabled 0
    #else
        #define sc_StereoRendering_IsClipDistanceEnabled 1
    #endif
    #define sc_StereoRenderingMode sc_StereoRendering_InstancedClipped
    #define sc_NumStereoClipPlanes 1
    #define sc_NumStereoViews 2
    #ifdef VERTEX_SHADER
        #ifdef sc_EnableInstancingFallback
            #define sc_GlobalInstanceID (sc_FallbackInstanceID*2+gl_InstanceID)
        #else
            #define sc_GlobalInstanceID gl_InstanceID
        #endif
        #ifdef sc_EnableFeatureLevelES3
            #define sc_LocalInstanceID (sc_GlobalInstanceID/2)
            #define sc_StereoViewID (sc_GlobalInstanceID%2)
        #else
            #define sc_LocalInstanceID int(sc_GlobalInstanceID/2.0)
            #define sc_StereoViewID int(mod(sc_GlobalInstanceID,2.0))
        #endif
    #endif
#else
    #define sc_StereoRenderingMode sc_StereoRendering_Disabled
#endif
#ifdef VERTEX_SHADER
    #ifdef sc_EnableInstancing
        #ifdef GL_ES
            #if defined(sc_EnableFeatureLevelES2)&&!defined(GL_EXT_draw_instanced)
                #define gl_InstanceID (0)
            #endif
        #else
            #if defined(sc_EnableFeatureLevelES2)&&!defined(GL_EXT_draw_instanced)&&!defined(GL_ARB_draw_instanced)&&!defined(GL_EXT_gpu_shader4)
                #define gl_InstanceID (0)
            #endif
        #endif
        #ifdef GL_ARB_draw_instanced
            #extension GL_ARB_draw_instanced : require
            #define gl_InstanceID gl_InstanceIDARB
        #endif
        #ifdef GL_EXT_draw_instanced
            #extension GL_EXT_draw_instanced : require
            #define gl_InstanceID gl_InstanceIDEXT
        #endif
        #ifndef sc_InstanceID
            #define sc_InstanceID gl_InstanceID
        #endif
        #ifndef sc_GlobalInstanceID
            #ifdef sc_EnableInstancingFallback
                #define sc_GlobalInstanceID (sc_FallbackInstanceID)
                #define sc_LocalInstanceID (sc_FallbackInstanceID)
            #else
                #define sc_GlobalInstanceID gl_InstanceID
                #define sc_LocalInstanceID gl_InstanceID
            #endif
        #endif
    #endif
#endif
#ifdef VERTEX_SHADER
    #if (__VERSION__<300)&&!defined(GL_EXT_gpu_shader4)
        #define gl_VertexID (0)
    #endif
#endif
#ifndef GL_ES
        #extension GL_EXT_gpu_shader4 : enable
    #extension GL_ARB_shader_texture_lod : enable
    #ifndef texture2DLodEXT
        #define texture2DLodEXT texture2DLod
    #endif
    #ifndef sc_CanUseTextureLod
    #define sc_CanUseTextureLod 1
    #endif
    #define precision
    #define lowp
    #define mediump
    #define highp
    #define sc_FragmentPrecision
#endif
#ifdef sc_EnableFeatureLevelES3
    #define sc_CanUseSampler2DArray 1
#endif
#if defined(sc_EnableFeatureLevelES2)&&defined(GL_ES)
    #ifdef FRAGMENT_SHADER
        #ifdef GL_OES_standard_derivatives
            #extension GL_OES_standard_derivatives : require
            #define sc_CanUseStandardDerivatives 1
        #endif
    #endif
    #ifdef GL_EXT_texture_array
        #extension GL_EXT_texture_array : require
        #define sc_CanUseSampler2DArray 1
    #else
        #define sc_CanUseSampler2DArray 0
    #endif
#endif
#ifdef GL_ES
    #ifdef sc_FramebufferFetch
        #if defined(GL_EXT_shader_framebuffer_fetch)
            #extension GL_EXT_shader_framebuffer_fetch : require
        #elif defined(GL_ARM_shader_framebuffer_fetch)
            #extension GL_ARM_shader_framebuffer_fetch : require
        #else
            #error Framebuffer fetch is requested but not supported by this device.
        #endif
    #endif
    #ifdef GL_FRAGMENT_PRECISION_HIGH
        #define sc_FragmentPrecision highp
    #else
        #define sc_FragmentPrecision mediump
    #endif
    #ifdef FRAGMENT_SHADER
        precision highp int;
        precision highp float;
    #endif
#endif
#ifdef VERTEX_SHADER
    #ifdef sc_EnableMultiviewStereoRendering
        layout(num_views=sc_NumStereoViews) in;
    #endif
#endif
#if __VERSION__>100
    #define SC_INT_FALLBACK_FLOAT int
    #define SC_INTERPOLATION_FLAT flat
    #define SC_INTERPOLATION_CENTROID centroid
#else
    #define SC_INT_FALLBACK_FLOAT float
    #define SC_INTERPOLATION_FLAT
    #define SC_INTERPOLATION_CENTROID
#endif
#ifndef sc_NumStereoViews
    #define sc_NumStereoViews 1
#endif
#ifndef sc_CanUseSampler2DArray
    #define sc_CanUseSampler2DArray 0
#endif
    #if __VERSION__==100||defined(SCC_VALIDATION)
        #define sampler2DArray vec2
        #define sampler3D vec3
        #define samplerCube vec4
        vec4 texture3D(vec3 s,vec3 uv)                       { return vec4(0.0); }
        vec4 texture3D(vec3 s,vec3 uv,float bias)           { return vec4(0.0); }
        vec4 texture3DLod(vec3 s,vec3 uv,float bias)        { return vec4(0.0); }
        vec4 texture3DLodEXT(vec3 s,vec3 uv,float lod)      { return vec4(0.0); }
        vec4 texture2DArray(vec2 s,vec3 uv)                  { return vec4(0.0); }
        vec4 texture2DArray(vec2 s,vec3 uv,float bias)      { return vec4(0.0); }
        vec4 texture2DArrayLod(vec2 s,vec3 uv,float lod)    { return vec4(0.0); }
        vec4 texture2DArrayLodEXT(vec2 s,vec3 uv,float lod) { return vec4(0.0); }
        vec4 textureCube(vec4 s,vec3 uv)                     { return vec4(0.0); }
        vec4 textureCube(vec4 s,vec3 uv,float lod)          { return vec4(0.0); }
        vec4 textureCubeLod(vec4 s,vec3 uv,float lod)       { return vec4(0.0); }
        vec4 textureCubeLodEXT(vec4 s,vec3 uv,float lod)    { return vec4(0.0); }
        #if defined(VERTEX_SHADER)||!sc_CanUseTextureLod
            #define texture2DLod(s,uv,lod)      vec4(0.0)
            #define texture2DLodEXT(s,uv,lod)   vec4(0.0)
        #endif
    #elif __VERSION__>=300
        #define texture3D texture
        #define textureCube texture
        #define texture2DArray texture
        #define texture2DLod textureLod
        #define texture3DLod textureLod
        #define texture2DLodEXT textureLod
        #define texture3DLodEXT textureLod
        #define textureCubeLod textureLod
        #define textureCubeLodEXT textureLod
        #define texture2DArrayLod textureLod
        #define texture2DArrayLodEXT textureLod
    #endif
    #ifndef sc_TextureRenderingLayout_Regular
        #define sc_TextureRenderingLayout_Regular 0
        #define sc_TextureRenderingLayout_StereoInstancedClipped 1
        #define sc_TextureRenderingLayout_StereoMultiview 2
    #endif
    #define depthToGlobal   depthScreenToViewSpace
    #define depthToLocal    depthViewToScreenSpace
    #ifndef quantizeUV
        #define quantizeUV sc_QuantizeUV
        #define sc_platformUVFlip sc_PlatformFlipV
        #define sc_PlatformFlipUV sc_PlatformFlipV
    #endif
    #ifndef sc_texture2DLod
        #define sc_texture2DLod sc_InternalTextureLevel
        #define sc_textureLod sc_InternalTextureLevel
        #define sc_textureBias sc_InternalTextureBiasOrLevel
        #define sc_texture sc_InternalTexture
    #endif
struct sc_Vertex_t
{
vec4 position;
vec3 normal;
vec3 tangent;
vec2 texture0;
vec2 texture1;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
vec2 Surface_UVCoord0;
vec4 VertexColor;
vec3 SurfacePosition_ObjectSpace;
vec3 VertexNormal_WorldSpace;
vec3 VertexNormal_ObjectSpace;
float gInstanceID;
};
#ifndef sc_CanUseTextureLod
#define sc_CanUseTextureLod 0
#elif sc_CanUseTextureLod==1
#undef sc_CanUseTextureLod
#define sc_CanUseTextureLod 1
#endif
#ifndef sc_StereoRenderingMode
#define sc_StereoRenderingMode 0
#endif
#ifndef sc_StereoViewID
#define sc_StereoViewID 0
#endif
#ifndef sc_RenderingSpace
#define sc_RenderingSpace -1
#endif
#ifndef sc_StereoRendering_IsClipDistanceEnabled
#define sc_StereoRendering_IsClipDistanceEnabled 0
#endif
#ifndef sc_NumStereoViews
#define sc_NumStereoViews 1
#endif
#ifndef sc_SkinBonesCount
#define sc_SkinBonesCount 0
#endif
#ifndef sc_VertexBlending
#define sc_VertexBlending 0
#elif sc_VertexBlending==1
#undef sc_VertexBlending
#define sc_VertexBlending 1
#endif
#ifndef sc_VertexBlendingUseNormals
#define sc_VertexBlendingUseNormals 0
#elif sc_VertexBlendingUseNormals==1
#undef sc_VertexBlendingUseNormals
#define sc_VertexBlendingUseNormals 1
#endif
struct sc_Camera_t
{
vec3 position;
float aspect;
vec2 clipPlanes;
};
#ifndef sc_IsEditor
#define sc_IsEditor 0
#elif sc_IsEditor==1
#undef sc_IsEditor
#define sc_IsEditor 1
#endif
#ifndef SC_DISABLE_FRUSTUM_CULLING
#define SC_DISABLE_FRUSTUM_CULLING 0
#elif SC_DISABLE_FRUSTUM_CULLING==1
#undef SC_DISABLE_FRUSTUM_CULLING
#define SC_DISABLE_FRUSTUM_CULLING 1
#endif
#ifndef sc_DepthBufferMode
#define sc_DepthBufferMode 0
#endif
#ifndef sc_ProjectiveShadowsReceiver
#define sc_ProjectiveShadowsReceiver 0
#elif sc_ProjectiveShadowsReceiver==1
#undef sc_ProjectiveShadowsReceiver
#define sc_ProjectiveShadowsReceiver 1
#endif
#ifndef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 0
#elif sc_OITDepthGatherPass==1
#undef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 1
#endif
#ifndef sc_OITCompositingPass
#define sc_OITCompositingPass 0
#elif sc_OITCompositingPass==1
#undef sc_OITCompositingPass
#define sc_OITCompositingPass 1
#endif
#ifndef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 0
#elif sc_OITDepthBoundsPass==1
#undef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 1
#endif
#ifndef SC_DEVICE_CLASS
#define SC_DEVICE_CLASS -1
#endif
#ifndef SC_GL_FRAGMENT_PRECISION_HIGH
#define SC_GL_FRAGMENT_PRECISION_HIGH 0
#elif SC_GL_FRAGMENT_PRECISION_HIGH==1
#undef SC_GL_FRAGMENT_PRECISION_HIGH
#define SC_GL_FRAGMENT_PRECISION_HIGH 1
#endif
#ifndef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#elif UseViewSpaceDepthVariant==1
#undef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#endif
#ifndef velRampTextureHasSwappedViews
#define velRampTextureHasSwappedViews 0
#elif velRampTextureHasSwappedViews==1
#undef velRampTextureHasSwappedViews
#define velRampTextureHasSwappedViews 1
#endif
#ifndef velRampTextureLayout
#define velRampTextureLayout 0
#endif
#ifndef sizeRampTextureHasSwappedViews
#define sizeRampTextureHasSwappedViews 0
#elif sizeRampTextureHasSwappedViews==1
#undef sizeRampTextureHasSwappedViews
#define sizeRampTextureHasSwappedViews 1
#endif
#ifndef sizeRampTextureLayout
#define sizeRampTextureLayout 0
#endif
#ifndef MESHTYPE
#define MESHTYPE 0
#endif
#ifndef INILOCATION
#define INILOCATION 0
#elif INILOCATION==1
#undef INILOCATION
#define INILOCATION 1
#endif
#ifndef BOXSPAWN
#define BOXSPAWN 0
#elif BOXSPAWN==1
#undef BOXSPAWN
#define BOXSPAWN 1
#endif
#ifndef SPHERESPAWN
#define SPHERESPAWN 0
#elif SPHERESPAWN==1
#undef SPHERESPAWN
#define SPHERESPAWN 1
#endif
#ifndef NOISE
#define NOISE 0
#elif NOISE==1
#undef NOISE
#define NOISE 1
#endif
#ifndef SNOISE
#define SNOISE 0
#elif SNOISE==1
#undef SNOISE
#define SNOISE 1
#endif
#ifndef VELRAMP
#define VELRAMP 0
#elif VELRAMP==1
#undef VELRAMP
#define VELRAMP 1
#endif
#ifndef SC_USE_UV_TRANSFORM_velRampTexture
#define SC_USE_UV_TRANSFORM_velRampTexture 0
#elif SC_USE_UV_TRANSFORM_velRampTexture==1
#undef SC_USE_UV_TRANSFORM_velRampTexture
#define SC_USE_UV_TRANSFORM_velRampTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_velRampTexture
#define SC_SOFTWARE_WRAP_MODE_U_velRampTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_velRampTexture
#define SC_SOFTWARE_WRAP_MODE_V_velRampTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_velRampTexture
#define SC_USE_UV_MIN_MAX_velRampTexture 0
#elif SC_USE_UV_MIN_MAX_velRampTexture==1
#undef SC_USE_UV_MIN_MAX_velRampTexture
#define SC_USE_UV_MIN_MAX_velRampTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_velRampTexture
#define SC_USE_CLAMP_TO_BORDER_velRampTexture 0
#elif SC_USE_CLAMP_TO_BORDER_velRampTexture==1
#undef SC_USE_CLAMP_TO_BORDER_velRampTexture
#define SC_USE_CLAMP_TO_BORDER_velRampTexture 1
#endif
#ifndef SIZEMINMAX
#define SIZEMINMAX 0
#elif SIZEMINMAX==1
#undef SIZEMINMAX
#define SIZEMINMAX 1
#endif
#ifndef SIZERAMP
#define SIZERAMP 0
#elif SIZERAMP==1
#undef SIZERAMP
#define SIZERAMP 1
#endif
#ifndef SC_USE_UV_TRANSFORM_sizeRampTexture
#define SC_USE_UV_TRANSFORM_sizeRampTexture 0
#elif SC_USE_UV_TRANSFORM_sizeRampTexture==1
#undef SC_USE_UV_TRANSFORM_sizeRampTexture
#define SC_USE_UV_TRANSFORM_sizeRampTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture
#define SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture
#define SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sizeRampTexture
#define SC_USE_UV_MIN_MAX_sizeRampTexture 0
#elif SC_USE_UV_MIN_MAX_sizeRampTexture==1
#undef SC_USE_UV_MIN_MAX_sizeRampTexture
#define SC_USE_UV_MIN_MAX_sizeRampTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sizeRampTexture
#define SC_USE_CLAMP_TO_BORDER_sizeRampTexture 0
#elif SC_USE_CLAMP_TO_BORDER_sizeRampTexture==1
#undef SC_USE_CLAMP_TO_BORDER_sizeRampTexture
#define SC_USE_CLAMP_TO_BORDER_sizeRampTexture 1
#endif
#ifndef FORCE
#define FORCE 0
#elif FORCE==1
#undef FORCE
#define FORCE 1
#endif
#ifndef VELOCITYDIR
#define VELOCITYDIR 0
#elif VELOCITYDIR==1
#undef VELOCITYDIR
#define VELOCITYDIR 1
#endif
#ifndef IGNOREVEL
#define IGNOREVEL 0
#elif IGNOREVEL==1
#undef IGNOREVEL
#define IGNOREVEL 1
#endif
#ifndef IGNORETRANSFORMSCALE
#define IGNORETRANSFORMSCALE 0
#elif IGNORETRANSFORMSCALE==1
#undef IGNORETRANSFORMSCALE
#define IGNORETRANSFORMSCALE 1
#endif
#ifndef rotationSpace
#define rotationSpace 0
#endif
#ifndef SCREENFADE
#define SCREENFADE 0
#elif SCREENFADE==1
#undef SCREENFADE
#define SCREENFADE 1
#endif
#ifndef EXTERNALTIME
#define EXTERNALTIME 0
#elif EXTERNALTIME==1
#undef EXTERNALTIME
#define EXTERNALTIME 1
#endif
#ifndef WORLDPOSSEED
#define WORLDPOSSEED 0
#elif WORLDPOSSEED==1
#undef WORLDPOSSEED
#define WORLDPOSSEED 1
#endif
#ifndef LIFETIMEMINMAX
#define LIFETIMEMINMAX 0
#elif LIFETIMEMINMAX==1
#undef LIFETIMEMINMAX
#define LIFETIMEMINMAX 1
#endif
#ifndef INSTANTSPAWN
#define INSTANTSPAWN 0
#elif INSTANTSPAWN==1
#undef INSTANTSPAWN
#define INSTANTSPAWN 1
#endif
#ifndef sc_PointLightsCount
#define sc_PointLightsCount 0
#endif
#ifndef sc_DirectionalLightsCount
#define sc_DirectionalLightsCount 0
#endif
#ifndef sc_AmbientLightsCount
#define sc_AmbientLightsCount 0
#endif
struct sc_PointLight_t
{
bool falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
vec3 direction;
vec3 position;
vec4 color;
};
struct sc_DirectionalLight_t
{
vec3 direction;
vec4 color;
};
struct sc_AmbientLight_t
{
vec3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
vec3 color;
float sharpness;
vec3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
vec3 ambientLight;
};
uniform vec4 sc_EnvmapDiffuseDims;
uniform vec4 sc_EnvmapSpecularDims;
uniform vec4 sc_ScreenTextureDims;
uniform mat4 sc_ModelMatrix;
uniform mat4 sc_ProjectorMatrix;
uniform vec4 sc_StereoClipPlanes[sc_NumStereoViews];
uniform vec4 sc_BoneMatrices[((sc_SkinBonesCount*3)+1)];
uniform mat3 sc_SkinBonesNormalMatrices[(sc_SkinBonesCount+1)];
uniform vec4 weights0;
uniform vec4 weights1;
uniform mat4 sc_ViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewMatrixArray[sc_NumStereoViews];
uniform sc_Camera_t sc_Camera;
uniform mat4 sc_ProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ViewMatrixArray[sc_NumStereoViews];
uniform float sc_DisableFrustumCullingMarker;
uniform mat3 sc_NormalMatrix;
uniform vec2 sc_TAAJitterOffset;
uniform vec4 intensityTextureDims;
uniform int PreviewEnabled;
uniform vec4 velRampTextureDims;
uniform vec4 sizeRampTextureDims;
uniform vec4 colorRampTextureDims;
uniform vec4 mainTextureDims;
uniform vec4 normalTexDims;
uniform mat3 velRampTextureTransform;
uniform vec4 velRampTextureUvMinMax;
uniform vec4 velRampTextureBorderColor;
uniform mat3 sizeRampTextureTransform;
uniform vec4 sizeRampTextureUvMinMax;
uniform vec4 sizeRampTextureBorderColor;
uniform mat4 sc_ViewMatrixInverseArray[sc_NumStereoViews];
uniform vec3 sc_LocalAabbMin;
uniform vec3 sc_LocalAabbMax;
uniform vec4 sc_GeometryInfo;
uniform float timeGlobal;
uniform float externalTimeInput;
uniform float externalSeed;
uniform float lifeTimeConstant;
uniform vec2 lifeTimeMinMax;
uniform float spawnDuration;
uniform vec3 spawnLocation;
uniform vec3 spawnBox;
uniform vec3 spawnSphere;
uniform vec3 noiseMult;
uniform vec3 noiseFrequency;
uniform vec3 sNoiseMult;
uniform vec3 sNoiseFrequency;
uniform vec3 velocityMin;
uniform vec3 velocityMax;
uniform vec3 velocityDrag;
uniform vec2 sizeStart;
uniform vec3 sizeStart3D;
uniform vec2 sizeEnd;
uniform vec3 sizeEnd3D;
uniform vec2 sizeStartMin;
uniform vec3 sizeStartMin3D;
uniform vec2 sizeStartMax;
uniform vec3 sizeStartMax3D;
uniform vec2 sizeEndMin;
uniform vec3 sizeEndMin3D;
uniform vec2 sizeEndMax;
uniform vec3 sizeEndMax3D;
uniform float sizeSpeed;
uniform float gravity;
uniform vec3 localForce;
uniform float sizeVelScale;
uniform bool ALIGNTOX;
uniform bool ALIGNTOY;
uniform bool ALIGNTOZ;
uniform vec2 rotationRandomX;
uniform vec2 rotationRateX;
uniform vec2 randomRotationY;
uniform vec2 rotationRateY;
uniform vec2 rotationRandom;
uniform vec2 randomRotationZ;
uniform vec2 rotationRate;
uniform vec2 rotationRateZ;
uniform float rotationDrag;
uniform bool CENTER_BBOX;
uniform float fadeDistanceVisible;
uniform float fadeDistanceInvisible;
uniform float Port_Input1_N119;
uniform vec2 Port_Input1_N138;
uniform vec2 Port_Input1_N139;
uniform vec2 Port_Input1_N140;
uniform vec2 Port_Input1_N144;
uniform float Port_Input1_N069;
uniform float Port_Input1_N068;
uniform float Port_Input1_N110;
uniform int overrideTimeEnabled;
uniform float overrideTimeElapsed;
uniform vec4 sc_Time;
uniform float overrideTimeDelta;
uniform mat4 sc_ModelMatrixInverse;
uniform sc_PointLight_t sc_PointLights[(sc_PointLightsCount+1)];
uniform sc_DirectionalLight_t sc_DirectionalLights[(sc_DirectionalLightsCount+1)];
uniform sc_AmbientLight_t sc_AmbientLights[(sc_AmbientLightsCount+1)];
uniform sc_LightEstimationData_t sc_LightEstimationData;
uniform vec4 sc_EnvmapDiffuseSize;
uniform vec4 sc_EnvmapDiffuseView;
uniform vec4 sc_EnvmapSpecularSize;
uniform vec4 sc_EnvmapSpecularView;
uniform vec3 sc_EnvmapRotation;
uniform float sc_EnvmapExposure;
uniform vec3 sc_Sh[9];
uniform float sc_ShIntensity;
uniform vec4 sc_UniformConstants;
uniform mat4 sc_ModelViewProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ViewProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewMatrixInverseArray[sc_NumStereoViews];
uniform mat3 sc_ViewNormalMatrixArray[sc_NumStereoViews];
uniform mat3 sc_ViewNormalMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat3 sc_NormalMatrixInverse;
uniform mat4 sc_PrevFrameModelMatrix;
uniform mat4 sc_PrevFrameModelMatrixInverse;
uniform vec3 sc_WorldAabbMin;
uniform vec3 sc_WorldAabbMax;
uniform vec4 sc_WindowToViewportTransform;
uniform float sc_ShadowDensity;
uniform vec4 sc_ShadowColor;
uniform float _sc_GetFramebufferColorInvalidUsageMarker;
uniform float shaderComplexityValue;
uniform vec4 weights2;
uniform int sc_FallbackInstanceID;
uniform float _sc_framebufferFetchMarker;
uniform float strandWidth;
uniform float strandTaper;
uniform vec4 sc_StrandDataMapTextureSize;
uniform float clumpInstanceCount;
uniform float clumpRadius;
uniform float clumpTipScale;
uniform float hairstyleInstanceCount;
uniform float hairstyleNoise;
uniform vec4 sc_ScreenTextureSize;
uniform vec4 sc_ScreenTextureView;
uniform float correctedIntensity;
uniform vec4 intensityTextureSize;
uniform vec4 intensityTextureView;
uniform mat3 intensityTextureTransform;
uniform vec4 intensityTextureUvMinMax;
uniform vec4 intensityTextureBorderColor;
uniform float reflBlurWidth;
uniform float reflBlurMinRough;
uniform float reflBlurMaxRough;
uniform int PreviewNodeID;
uniform float alphaTestThreshold;
uniform vec4 velRampTextureSize;
uniform vec4 velRampTextureView;
uniform vec4 sizeRampTextureSize;
uniform vec4 sizeRampTextureView;
uniform vec3 colorStart;
uniform vec3 colorEnd;
uniform vec3 colorMinStart;
uniform vec3 colorMinEnd;
uniform vec3 colorMaxStart;
uniform vec3 colorMaxEnd;
uniform float alphaStart;
uniform float alphaEnd;
uniform float alphaMinStart;
uniform float alphaMinEnd;
uniform float alphaMaxStart;
uniform float alphaMaxEnd;
uniform float alphaDissolveMult;
uniform float numValidFrames;
uniform vec2 gridSize;
uniform float flipBookSpeedMult;
uniform float flipBookRandomStart;
uniform vec4 colorRampTextureSize;
uniform vec4 colorRampTextureView;
uniform mat3 colorRampTextureTransform;
uniform vec4 colorRampTextureUvMinMax;
uniform vec4 colorRampTextureBorderColor;
uniform vec4 colorRampMult;
uniform vec4 mainTextureSize;
uniform vec4 mainTextureView;
uniform mat3 mainTextureTransform;
uniform vec4 mainTextureUvMinMax;
uniform vec4 mainTextureBorderColor;
uniform vec4 normalTexSize;
uniform vec4 normalTexView;
uniform mat3 normalTexTransform;
uniform vec4 normalTexUvMinMax;
uniform vec4 normalTexBorderColor;
uniform float metallic;
uniform float roughness;
uniform float Port_Input1_N154;
uniform vec3 Port_Default_N167;
uniform vec3 Port_Emissive_N014;
uniform vec3 Port_AO_N014;
uniform vec3 Port_SpecularAO_N014;
uniform sampler2D velRampTexture;
uniform sampler2D sizeRampTexture;
varying float varClipDistance;
varying float varStereoViewID;
attribute vec4 boneData;
attribute vec3 blendShape0Pos;
attribute vec3 blendShape0Normal;
attribute vec3 blendShape1Pos;
attribute vec3 blendShape1Normal;
attribute vec3 blendShape2Pos;
attribute vec3 blendShape2Normal;
attribute vec3 blendShape3Pos;
attribute vec3 blendShape4Pos;
attribute vec3 blendShape5Pos;
attribute vec4 position;
attribute vec3 normal;
attribute vec4 tangent;
attribute vec2 texture0;
attribute vec2 texture1;
varying vec3 varPos;
varying vec3 varNormal;
varying vec4 varTangent;
varying vec4 varPackedTex;
varying vec4 varScreenPos;
varying vec2 varScreenTexturePos;
varying vec2 varShadowTex;
varying float varViewSpaceDepth;
varying vec4 varColor;
attribute vec4 color;
varying vec4 Interpolator0;
varying vec4 Interpolator1;
varying vec4 PreviewVertexColor;
varying float PreviewVertexSaved;
varying float Interpolator_gInstanceID;
attribute vec3 positionNext;
attribute vec3 positionPrevious;
attribute vec4 strandProperties;
bool N111_ENABLE_ALIGNTOX;
bool N111_ENABLE_ALIGNTOY;
bool N111_ENABLE_ALIGNTOZ;
bool N111_ENABLE_CENTER_IN_BBOX;
bool N111_MESHTYPE_QUAD;
vec3 N111_particleSeedIn;
float N111_globalSeedIn;
float N111_dieTrigger;
vec4 N111_timeValuesIn;
vec3 N111_positionObjectSpace;
vec3 N111_normalObjectSpace;
bool N111_ENABLE_INILOCATION;
vec3 N111_spawnLocation;
bool N111_ENABLE_BOXSPAWN;
vec3 N111_spawnBox;
bool N111_ENABLE_SPHERESPAWN;
vec3 N111_spawnSphere;
bool N111_ENABLE_NOISE;
vec3 N111_noiseMult;
vec3 N111_noiseFrequency;
bool N111_ENABLE_SNOISE;
vec3 N111_sNoiseMult;
vec3 N111_sNoiseFrequency;
bool N111_ENABLE_VELRAMP;
vec3 N111_velocityMin;
vec3 N111_velocityMax;
vec3 N111_velocityDrag;
vec3 N111_sizeStart;
vec3 N111_sizeEnd;
bool N111_ENABLE_SIZEMINMAX;
vec3 N111_sizeStartMin;
vec3 N111_sizeStartMax;
vec3 N111_sizeEndMin;
vec3 N111_sizeEndMax;
float N111_sizeSpeed;
bool N111_ENABLE_SIZERAMP;
float N111_gravity;
bool N111_ENABLE_FORCE;
vec3 N111_localForce;
bool N111_ENABLE_ALIGNTOVEL;
float N111_sizeVelScale;
bool N111_ENABLE_IGNOREVEL;
bool N111_ENABLE_IGNORETRANSFORMSCALE;
vec2 N111_rotationRandomX;
vec2 N111_rotationRateX;
vec2 N111_rotationRandomY;
vec2 N111_rotationRateY;
vec2 N111_rotationRandomZ;
vec2 N111_rotationRateZ;
float N111_rotationDrag;
bool N111_WORLDSPACE;
bool N111_WORLDFORCE;
bool N111_ENABLE_SCREENFADE;
float N111_fadeDistanceVisible;
float N111_fadeDistanceInvisible;
vec3 N111_particleSeed;
float N111_globalSeed;
vec4 N111_timeValues;
float N111_nearCameraFade;
vec3 N111_position;
vec3 N111_normal;
float N111_EPSILON;
float N111_PI;
float N173_timeGlobal;
bool N173_ENABLE_EXTERNALTIME;
float N173_externalTime;
bool N173_ENABLE_WORLDPOSSEED;
float N173_externalSeed;
bool N173_ENABLE_LIFETIMEMINMAX;
float N173_lifeTimeConstant;
vec2 N173_lifeTimeMinMax;
bool N173_ENABLE_INSTANTSPAWN;
float N173_spawnDuration;
vec3 N173_particleSeed;
float N173_globalSeed;
float N173_dieTrigger;
vec4 N173_timeValues;
ssGlobals tempGlobals;
void blendTargetShapeWithNormal(inout sc_Vertex_t v,vec3 position_1,vec3 normal_1,float weight)
{
vec3 l9_0=v.position.xyz+(position_1*weight);
v=sc_Vertex_t(vec4(l9_0.x,l9_0.y,l9_0.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
v.normal+=(normal_1*weight);
}
int sc_GetBoneIndex(int index)
{
int l9_0;
#if (sc_SkinBonesCount>0)
{
l9_0=int(boneData[index]);
}
#else
{
l9_0=0;
}
#endif
return l9_0;
}
void sc_GetBoneMatrix(int index,out vec4 m0,out vec4 m1,out vec4 m2)
{
int l9_0=3*index;
m0=sc_BoneMatrices[l9_0];
m1=sc_BoneMatrices[l9_0+1];
m2=sc_BoneMatrices[l9_0+2];
}
vec3 skinVertexPosition(int i,vec4 v)
{
vec3 l9_0;
#if (sc_SkinBonesCount>0)
{
vec4 param_1;
vec4 param_2;
vec4 param_3;
sc_GetBoneMatrix(i,param_1,param_2,param_3);
l9_0=vec3(dot(v,param_1),dot(v,param_2),dot(v,param_3));
}
#else
{
l9_0=v.xyz;
}
#endif
return l9_0;
}
int sc_GetLocalInstanceID()
{
#ifdef sc_LocalInstanceID
    return sc_LocalInstanceID;
#else
    return 0;
#endif
}
void Node6_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (EXTERNALTIME)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node8_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (WORLDPOSSEED)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node0_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (LIFETIMEMINMAX)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node11_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (INSTANTSPAWN)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node173_Particle_Seed_Time_and_Spawn(float timeGlobal_1,float ENABLE_EXTERNALTIME,float externalTime,float ENABLE_WORLDPOSSEED,float externalSeed_1,float ENABLE_LIFETIMEMINMAX,float lifeTimeConstant_1,vec2 lifeTimeMinMax_1,float ENABLE_INSTANTSPAWN,float spawnDuration_1,out vec3 particleSeed,out float globalSeed,out float dieTrigger,out vec4 timeValues,ssGlobals Globals)
{
tempGlobals=Globals;
particleSeed=vec3(0.0);
globalSeed=0.0;
dieTrigger=0.0;
timeValues=vec4(0.0);
N173_timeGlobal=timeGlobal_1;
N173_ENABLE_EXTERNALTIME=(int(EXTERNALTIME)!=0);
N173_externalTime=externalTime;
N173_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED)!=0);
N173_externalSeed=externalSeed_1;
N173_ENABLE_LIFETIMEMINMAX=(int(LIFETIMEMINMAX)!=0);
N173_lifeTimeConstant=lifeTimeConstant_1;
N173_lifeTimeMinMax=lifeTimeMinMax_1;
N173_ENABLE_INSTANTSPAWN=(int(INSTANTSPAWN)!=0);
N173_spawnDuration=spawnDuration_1;
float l9_0;
if (N173_ENABLE_WORLDPOSSEED)
{
l9_0=length(vec4(1.0)*sc_ModelMatrix);
}
else
{
l9_0=0.0;
}
N173_globalSeed=N173_externalSeed+l9_0;
float l9_1=float(sc_GetLocalInstanceID());
N173_particleSeed=floor(fract(sin(vec3(0.457831,0.62343299,0.97625297)*dot(vec2(mod(l9_1,2000.0),floor(l9_1/2000.0))/vec2(2000.0),vec2(0.38253,0.42662001)))*vec3(479.371,389.53101,513.03497))*10000.0)*9.9999997e-05;
float l9_2=N173_particleSeed.y;
float l9_3=N173_globalSeed;
float l9_4=N173_particleSeed.z;
float l9_5=N173_globalSeed;
float l9_6=N173_lifeTimeConstant;
vec2 l9_7;
if (N173_ENABLE_LIFETIMEMINMAX)
{
l9_7=N173_lifeTimeMinMax;
}
else
{
l9_7=vec2(l9_6);
}
float l9_8=tempGlobals.gTimeElapsed;
float l9_9;
if (N173_ENABLE_EXTERNALTIME)
{
l9_9=N173_externalTime;
}
else
{
l9_9=l9_8;
}
float l9_10;
if (N173_ENABLE_INSTANTSPAWN)
{
l9_10=N173_timeGlobal*l9_9;
}
else
{
l9_10=fract(((l9_9*N173_timeGlobal)*(1.0/l9_7.y))+fract((l9_2*12.12358)+l9_3))*l9_7.y;
}
float l9_11=l9_10/max(l9_7.x,0.0099999998);
float l9_12=l9_10/max(l9_7.y,0.0099999998);
float l9_13=mix(l9_11,l9_12,fract((l9_4*3.5358)+l9_5));
float l9_14;
if (!N173_ENABLE_INSTANTSPAWN)
{
float l9_15;
if (N173_spawnDuration>0.0)
{
float l9_16;
if ((l9_9-N173_spawnDuration)>=l9_10)
{
l9_16=1.0;
}
else
{
l9_16=0.0;
}
l9_15=l9_16;
}
else
{
l9_15=0.0;
}
l9_14=l9_15;
}
else
{
l9_14=0.0;
}
N173_dieTrigger=1.0;
if ((l9_13+l9_14)>0.99989998)
{
N173_dieTrigger=0.0;
}
N173_timeValues=vec4(l9_7,l9_10,clamp(l9_13,0.0,1.0));
particleSeed=N173_particleSeed;
globalSeed=N173_globalSeed;
dieTrigger=N173_dieTrigger;
timeValues=N173_timeValues;
}
void Node15_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (INILOCATION)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node17_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (BOXSPAWN)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node19_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (SPHERESPAWN)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node43_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (NOISE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node44_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (SNOISE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node38_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (VELRAMP)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node70_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Value1=vec3(sizeStart,0.0);
Result=Value1;
}
#else
{
Default=sizeStart3D;
Result=Default;
}
#endif
}
void Node121_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Value1=vec3(sizeEnd,0.0);
Result=Value1;
}
#else
{
Default=sizeEnd3D;
Result=Default;
}
#endif
}
void Node99_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (SIZEMINMAX)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node124_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Value1=vec3(sizeStartMin,0.0);
Result=Value1;
}
#else
{
Default=sizeStartMin3D;
Result=Default;
}
#endif
}
void Node123_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Value1=vec3(sizeStartMax,0.0);
Result=Value1;
}
#else
{
Default=sizeStartMax3D;
Result=Default;
}
#endif
}
void Node125_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Value1=vec3(sizeEndMin,0.0);
Result=Value1;
}
#else
{
Default=sizeEndMin3D;
Result=Default;
}
#endif
}
void Node126_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Value1=vec3(sizeEndMax,0.0);
Result=Value1;
}
#else
{
Default=sizeEndMax3D;
Result=Default;
}
#endif
}
void Node102_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (SIZERAMP)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node108_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (FORCE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node47_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (VELOCITYDIR)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node109_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (IGNOREVEL)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node174_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (IGNORETRANSFORMSCALE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node138_Conditional(float Input0,vec2 Input1,vec2 Input2,out vec2 Output,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Output=Input1;
}
#else
{
Input2=rotationRandomX;
Output=Input2;
}
#endif
}
void Node139_Conditional(float Input0,vec2 Input1,vec2 Input2,out vec2 Output,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Output=Input1;
}
#else
{
Input2=rotationRateX;
Output=Input2;
}
#endif
}
void Node140_Conditional(float Input0,vec2 Input1,vec2 Input2,out vec2 Output,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Output=Input1;
}
#else
{
Input2=randomRotationY;
Output=Input2;
}
#endif
}
void Node144_Conditional(float Input0,vec2 Input1,vec2 Input2,out vec2 Output,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Output=Input1;
}
#else
{
Input2=rotationRateY;
Output=Input2;
}
#endif
}
void Node135_Conditional(float Input0,vec2 Input1,vec2 Input2,out vec2 Output,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Input1=rotationRandom;
Output=Input1;
}
#else
{
Input2=randomRotationZ;
Output=Input2;
}
#endif
}
void Node137_Conditional(float Input0,vec2 Input1,vec2 Input2,out vec2 Output,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Input1=rotationRate;
Output=Input1;
}
#else
{
Input2=rotationRateZ;
Output=Input2;
}
#endif
}
void Node110_Conditional(float Input0,float Input1,float Input2,out float Output,ssGlobals Globals)
{
#if (MESHTYPE==0)
{
Output=Input1;
}
#else
{
Input2=float(CENTER_BBOX);
Output=Input2;
}
#endif
}
void Node175_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (SCREENFADE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
float ssPow(float A,float B)
{
float l9_0;
if (A<=0.0)
{
l9_0=0.0;
}
else
{
l9_0=pow(A,B);
}
return l9_0;
}
vec3 N111_sineNoise(vec3 N111_noiseFrequency_1,vec3 N111_noiseMult_1,vec3 random,float time)
{
return (vec3(sin(time*N111_noiseFrequency_1.x),sin(time*N111_noiseFrequency_1.y),sin(time*N111_noiseFrequency_1.z))*N111_noiseMult_1)*random;
}
float N111_sNoise(vec2 v)
{
vec2 l9_0=floor(v+vec2(dot(v,vec2(0.36602542))));
vec2 l9_1=(v-l9_0)+vec2(dot(l9_0,vec2(0.21132487)));
float l9_2=l9_1.x;
float l9_3=l9_1.y;
bvec2 l9_4=bvec2(l9_2>l9_3);
vec2 l9_5=vec2(l9_4.x ? vec2(1.0,0.0).x : vec2(0.0,1.0).x,l9_4.y ? vec2(1.0,0.0).y : vec2(0.0,1.0).y);
vec4 l9_6=l9_1.xyxy+vec4(0.21132487,0.21132487,-0.57735026,-0.57735026);
vec2 l9_7=l9_6.xy-l9_5;
vec4 l9_8=vec4(l9_7.x,l9_7.y,l9_6.z,l9_6.w);
vec2 l9_9=mod(l9_0,vec2(289.0));
vec3 l9_10=vec3(l9_9.y)+vec3(0.0,l9_5.y,1.0);
vec3 l9_11=(mod(((l9_10*34.0)+vec3(1.0))*l9_10,vec3(289.0))+vec3(l9_9.x))+vec3(0.0,l9_5.x,1.0);
vec2 l9_12=l9_7.xy;
vec2 l9_13=l9_6.zw;
vec3 l9_14=max(vec3(0.5)-vec3(dot(l9_1,l9_1),dot(l9_12,l9_12),dot(l9_13,l9_13)),vec3(0.0));
vec3 l9_15=l9_14*l9_14;
vec3 l9_16=(fract(mod(((l9_11*34.0)+vec3(1.0))*l9_11,vec3(289.0))*vec3(0.024390243))*2.0)-vec3(1.0);
vec3 l9_17=abs(l9_16)-vec3(0.5);
vec3 l9_18=l9_16-floor(l9_16+vec3(0.5));
vec3 l9_19=vec3(0.0);
l9_19.x=(l9_18.x*l9_2)+(l9_17.x*l9_3);
vec2 l9_20=(l9_18.yz*l9_8.xz)+(l9_17.yz*l9_8.yw);
return 130.0*dot((l9_15*l9_15)*(vec3(1.7928429)-(((l9_18*l9_18)+(l9_17*l9_17))*0.85373473)),vec3(l9_19.x,l9_20.x,l9_20.y));
}
vec3 N111_simplexNoise(float randX,float randY,float randZ,vec3 N111_sNoiseFrequency_1,vec3 N111_sNoiseMult_1,vec3 random,float time)
{
return (vec3(N111_sNoise(vec2(randX*time,N111_sNoiseFrequency_1.x)),N111_sNoise(vec2(randY*time,N111_sNoiseFrequency_1.y)),N111_sNoise(vec2(randZ*time,N111_sNoiseFrequency_1.z)))*N111_sNoiseMult_1)*random;
}
vec3 ssPow(vec3 A,vec3 B)
{
float l9_0;
if (A.x<=0.0)
{
l9_0=0.0;
}
else
{
l9_0=pow(A.x,B.x);
}
float l9_1;
if (A.y<=0.0)
{
l9_1=0.0;
}
else
{
l9_1=pow(A.y,B.y);
}
float l9_2;
if (A.z<=0.0)
{
l9_2=0.0;
}
else
{
l9_2=pow(A.z,B.z);
}
return vec3(l9_0,l9_1,l9_2);
}
int sc_GetStereoViewIndex()
{
int l9_0;
#if (sc_StereoRenderingMode==0)
{
l9_0=0;
}
#else
{
l9_0=sc_StereoViewID;
}
#endif
return l9_0;
}
int velRampTextureGetStereoViewIndex()
{
int l9_0;
#if (velRampTextureHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
void sc_SoftwareWrapEarly(inout float uv,int softwareWrapMode)
{
if (softwareWrapMode==1)
{
uv=fract(uv);
}
else
{
if (softwareWrapMode==2)
{
float l9_0=fract(uv);
uv=mix(l9_0,1.0-l9_0,clamp(step(0.25,fract((uv-l9_0)*0.5)),0.0,1.0));
}
}
}
void sc_ClampUV(inout float value,float minValue,float maxValue,bool useClampToBorder,inout float clampToBorderFactor)
{
float l9_0=clamp(value,minValue,maxValue);
float l9_1=step(abs(value-l9_0),9.9999997e-06);
clampToBorderFactor*=(l9_1+((1.0-float(useClampToBorder))*(1.0-l9_1)));
value=l9_0;
}
vec2 sc_TransformUV(vec2 uv,bool useUvTransform,mat3 uvTransform)
{
if (useUvTransform)
{
uv=vec2((uvTransform*vec3(uv,1.0)).xy);
}
return uv;
}
void sc_SoftwareWrapLate(inout float uv,int softwareWrapMode,bool useClampToBorder,inout float clampToBorderFactor)
{
if ((softwareWrapMode==0)||(softwareWrapMode==3))
{
sc_ClampUV(uv,0.0,1.0,useClampToBorder,clampToBorderFactor);
}
}
vec3 sc_SamplingCoordsViewToGlobal(vec2 uv,int renderingLayout,int viewIndex)
{
vec3 l9_0;
if (renderingLayout==0)
{
l9_0=vec3(uv,0.0);
}
else
{
vec3 l9_1;
if (renderingLayout==1)
{
l9_1=vec3(uv.x,(uv.y*0.5)+(0.5-(float(viewIndex)*0.5)),0.0);
}
else
{
l9_1=vec3(uv,float(viewIndex));
}
l9_0=l9_1;
}
return l9_0;
}
vec4 sc_InternalTextureLevel(vec2 texSize,vec2 uv,float level_,sampler2D texsmp)
{
vec4 l9_0;
#if (sc_CanUseTextureLod)
{
l9_0=texture2DLod(texsmp,uv,level_);
}
#else
{
l9_0=vec4(0.0);
}
#endif
return l9_0;
}
vec4 sc_SampleViewLevel(vec2 texSize,vec2 uv,int renderingLayout,int viewIndex,float level_,sampler2D texsmp)
{
return sc_InternalTextureLevel(texSize,sc_SamplingCoordsViewToGlobal(uv,renderingLayout,viewIndex).xy,level_,texsmp);
}
vec4 sc_SampleTextureLevel(vec2 samplerDims,int renderingLayout,int viewIndex,vec2 uv,bool useUvTransform,mat3 uvTransform,ivec2 softwareWrapModes,bool useUvMinMax,vec4 uvMinMax,bool useClampToBorder,vec4 borderColor,float level_,sampler2D texture_sampler_)
{
bool l9_0=useClampToBorder;
bool l9_1=useUvMinMax;
bool l9_2=l9_0&&(!l9_1);
sc_SoftwareWrapEarly(uv.x,softwareWrapModes.x);
sc_SoftwareWrapEarly(uv.y,softwareWrapModes.y);
float l9_3;
if (useUvMinMax)
{
bool l9_4=useClampToBorder;
bool l9_5;
if (l9_4)
{
l9_5=softwareWrapModes.x==3;
}
else
{
l9_5=l9_4;
}
float param_8=1.0;
sc_ClampUV(uv.x,uvMinMax.x,uvMinMax.z,l9_5,param_8);
float l9_6=param_8;
bool l9_7=useClampToBorder;
bool l9_8;
if (l9_7)
{
l9_8=softwareWrapModes.y==3;
}
else
{
l9_8=l9_7;
}
float param_13=l9_6;
sc_ClampUV(uv.y,uvMinMax.y,uvMinMax.w,l9_8,param_13);
l9_3=param_13;
}
else
{
l9_3=1.0;
}
uv=sc_TransformUV(uv,useUvTransform,uvTransform);
float param_20=l9_3;
sc_SoftwareWrapLate(uv.x,softwareWrapModes.x,l9_2,param_20);
sc_SoftwareWrapLate(uv.y,softwareWrapModes.y,l9_2,param_20);
float l9_9=param_20;
vec4 l9_10=sc_SampleViewLevel(samplerDims,uv,renderingLayout,viewIndex,level_,texture_sampler_);
vec4 l9_11;
if (useClampToBorder)
{
l9_11=mix(borderColor,l9_10,vec4(l9_9));
}
else
{
l9_11=l9_10;
}
return l9_11;
}
vec4 N111_velRampTexture_sample(vec2 coords)
{
return sc_SampleTextureLevel(velRampTextureDims.xy,velRampTextureLayout,velRampTextureGetStereoViewIndex(),coords,(int(SC_USE_UV_TRANSFORM_velRampTexture)!=0),velRampTextureTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture,SC_SOFTWARE_WRAP_MODE_V_velRampTexture),(int(SC_USE_UV_MIN_MAX_velRampTexture)!=0),velRampTextureUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_velRampTexture)!=0),velRampTextureBorderColor,0.0,velRampTexture);
}
vec3 N111_pVelocity(vec3 velRange,float localTime,vec3 N111_velocityDrag_1,vec3 noiseXYZValue,float normTime)
{
vec3 l9_0=ssPow(vec3(localTime,localTime,localTime),N111_velocityDrag_1);
vec3 l9_1=velRange;
vec3 l9_2=noiseXYZValue;
vec3 l9_3;
if (N111_ENABLE_VELRAMP)
{
vec4 l9_4=N111_velRampTexture_sample((tempGlobals.Surface_UVCoord0/vec2(10000.0,1.0))+vec2(floor(normTime*10000.0)/10000.0,0.0));
vec3 l9_5=velRange;
vec3 l9_6=noiseXYZValue;
vec3 l9_7;
#if (!((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH))
{
l9_7=velRange*l9_0;
}
#else
{
l9_7=(l9_5+l9_6)*l9_4.xyz;
}
#endif
l9_3=l9_7;
}
else
{
l9_3=(l9_1+l9_2)*l9_0;
}
return l9_3;
}
mat3 N111_transposeMatrix(mat4 matrix)
{
return mat3(vec3(matrix[0].x,matrix[1].x,matrix[2].x),vec3(matrix[0].y,matrix[1].y,matrix[2].y),vec3(matrix[0].z,matrix[1].z,matrix[2].z));
}
int sizeRampTextureGetStereoViewIndex()
{
int l9_0;
#if (sizeRampTextureHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
vec4 N111_sizeRampTexture_sample(vec2 coords)
{
return sc_SampleTextureLevel(sizeRampTextureDims.xy,sizeRampTextureLayout,sizeRampTextureGetStereoViewIndex(),coords,(int(SC_USE_UV_TRANSFORM_sizeRampTexture)!=0),sizeRampTextureTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture),(int(SC_USE_UV_MIN_MAX_sizeRampTexture)!=0),sizeRampTextureUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture)!=0),sizeRampTextureBorderColor,0.0,sizeRampTexture);
}
vec3 N111_pSize3D(float random1,float random2,float normTime,float N111_sizeSpeed_1)
{
vec3 l9_0=N111_sizeStart;
vec3 l9_1=N111_sizeEnd;
float l9_2=ssPow(normTime,N111_sizeSpeed_1);
vec3 l9_3;
vec3 l9_4;
if (N111_ENABLE_SIZEMINMAX)
{
l9_4=mix(N111_sizeEndMin,N111_sizeEndMax,vec3(random2));
l9_3=mix(N111_sizeStartMin,N111_sizeStartMax,vec3(random1));
}
else
{
l9_4=l9_1;
l9_3=l9_0;
}
vec3 l9_5=mix(l9_3,l9_4,vec3(l9_2));
vec3 l9_6;
if (N111_ENABLE_SIZERAMP)
{
vec4 l9_7=N111_sizeRampTexture_sample((tempGlobals.Surface_UVCoord0/vec2(10000.0,1.0))+vec2(ceil(normTime*10000.0)/10000.0,0.0));
vec3 l9_8;
#if (!((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH))
{
l9_8=vec3(1.0);
}
#else
{
l9_8=l9_7.xyz;
}
#endif
l9_6=l9_8*l9_3;
}
else
{
l9_6=l9_5;
}
return l9_6;
}
vec2 N111_pSize(float random1,float random2,float normTime,float N111_sizeSpeed_1)
{
float l9_0=ssPow(normTime,N111_sizeSpeed_1);
vec2 l9_1;
vec2 l9_2;
if (N111_ENABLE_SIZEMINMAX)
{
l9_2=mix(N111_sizeEndMin.xy,N111_sizeEndMax.xy,vec2(random2));
l9_1=mix(N111_sizeStartMin.xy,N111_sizeStartMax.xy,vec2(random1));
}
else
{
l9_2=N111_sizeEnd.xy;
l9_1=N111_sizeStart.xy;
}
vec2 l9_3=mix(l9_1,l9_2,vec2(l9_0));
vec2 l9_4;
if (N111_ENABLE_SIZERAMP)
{
vec4 l9_5=N111_sizeRampTexture_sample((tempGlobals.Surface_UVCoord0/vec2(10000.0,1.0))+vec2(ceil(normTime*10000.0)/10000.0,0.0));
vec2 l9_6;
#if (!((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH))
{
l9_6=vec2(1.0);
}
#else
{
l9_6=l9_5.xy;
}
#endif
l9_4=l9_6*l9_1;
}
else
{
l9_4=l9_3;
}
return l9_4;
}
void Node111_Vertex_Shader_Particles(float MESHTYPE_QUAD,vec3 particleSeedIn,float globalSeedIn,float dieTrigger,vec4 timeValuesIn,vec3 positionObjectSpace,vec3 normalObjectSpace,float ENABLE_INILOCATION,vec3 spawnLocation_1,float ENABLE_BOXSPAWN,vec3 spawnBox_1,float ENABLE_SPHERESPAWN,vec3 spawnSphere_1,float ENABLE_NOISE,vec3 noiseMult_1,vec3 noiseFrequency_1,float ENABLE_SNOISE,vec3 sNoiseMult_1,vec3 sNoiseFrequency_1,float ENABLE_VELRAMP,vec3 velocityMin_1,vec3 velocityMax_1,vec3 velocityDrag_1,vec3 sizeStart_1,vec3 sizeEnd_1,float ENABLE_SIZEMINMAX,vec3 sizeStartMin_1,vec3 sizeStartMax_1,vec3 sizeEndMin_1,vec3 sizeEndMax_1,float sizeSpeed_1,float ENABLE_SIZERAMP,float gravity_1,float ENABLE_FORCE,vec3 localForce_1,float ENABLE_ALIGNTOVEL,float sizeVelScale_1,float ENABLE_IGNOREVEL,float ENABLE_IGNORETRANSFORMSCALE,float ENABLE_ALIGNTOX,float ENABLE_ALIGNTOY,float ENABLE_ALIGNTOZ,vec2 rotationRandomX_1,vec2 rotationRateX_1,vec2 rotationRandomY,vec2 rotationRateY_1,vec2 rotationRandomZ,vec2 rotationRateZ_1,float rotationDrag_1,float WORLDSPACE,float WORLDFORCE,float ENABLE_CENTER_IN_BBOX,float ENABLE_SCREENFADE,float fadeDistanceVisible_1,float fadeDistanceInvisible_1,out vec3 particleSeed,out float globalSeed,out vec4 timeValues,out float nearCameraFade,out vec3 position_1,out vec3 normal_1,ssGlobals Globals)
{
tempGlobals=Globals;
particleSeed=vec3(0.0);
globalSeed=0.0;
timeValues=vec4(0.0);
nearCameraFade=0.0;
position_1=vec3(0.0);
normal_1=vec3(0.0);
N111_MESHTYPE_QUAD=MESHTYPE==0;
N111_particleSeedIn=particleSeedIn;
N111_globalSeedIn=globalSeedIn;
N111_dieTrigger=dieTrigger;
N111_timeValuesIn=timeValuesIn;
N111_positionObjectSpace=positionObjectSpace;
N111_normalObjectSpace=normalObjectSpace;
N111_ENABLE_INILOCATION=(int(INILOCATION)!=0);
N111_spawnLocation=spawnLocation_1;
N111_ENABLE_BOXSPAWN=(int(BOXSPAWN)!=0);
N111_spawnBox=spawnBox_1;
N111_ENABLE_SPHERESPAWN=(int(SPHERESPAWN)!=0);
N111_spawnSphere=spawnSphere_1;
N111_ENABLE_NOISE=(int(NOISE)!=0);
N111_noiseMult=noiseMult_1;
N111_noiseFrequency=noiseFrequency_1;
N111_ENABLE_SNOISE=(int(SNOISE)!=0);
N111_sNoiseMult=sNoiseMult_1;
N111_sNoiseFrequency=sNoiseFrequency_1;
N111_ENABLE_VELRAMP=(int(VELRAMP)!=0);
N111_velocityMin=velocityMin_1;
N111_velocityMax=velocityMax_1;
N111_velocityDrag=velocityDrag_1;
N111_sizeStart=sizeStart_1;
N111_sizeEnd=sizeEnd_1;
N111_ENABLE_SIZEMINMAX=(int(SIZEMINMAX)!=0);
N111_sizeStartMin=sizeStartMin_1;
N111_sizeStartMax=sizeStartMax_1;
N111_sizeEndMin=sizeEndMin_1;
N111_sizeEndMax=sizeEndMax_1;
N111_sizeSpeed=sizeSpeed_1;
N111_ENABLE_SIZERAMP=(int(SIZERAMP)!=0);
N111_gravity=gravity_1;
N111_ENABLE_FORCE=(int(FORCE)!=0);
N111_localForce=localForce_1;
N111_ENABLE_ALIGNTOVEL=(int(VELOCITYDIR)!=0);
N111_sizeVelScale=sizeVelScale_1;
N111_ENABLE_IGNOREVEL=(int(IGNOREVEL)!=0);
N111_ENABLE_IGNORETRANSFORMSCALE=(int(IGNORETRANSFORMSCALE)!=0);
N111_ENABLE_ALIGNTOX=ENABLE_ALIGNTOX!=0.0;
N111_ENABLE_ALIGNTOY=ENABLE_ALIGNTOY!=0.0;
N111_ENABLE_ALIGNTOZ=ENABLE_ALIGNTOZ!=0.0;
N111_rotationRandomX=rotationRandomX_1;
N111_rotationRateX=rotationRateX_1;
N111_rotationRandomY=rotationRandomY;
N111_rotationRateY=rotationRateY_1;
N111_rotationRandomZ=rotationRandomZ;
N111_rotationRateZ=rotationRateZ_1;
N111_rotationDrag=rotationDrag_1;
N111_WORLDSPACE=rotationSpace==1;
N111_WORLDFORCE=rotationSpace==2;
N111_ENABLE_CENTER_IN_BBOX=ENABLE_CENTER_IN_BBOX!=0.0;
N111_ENABLE_SCREENFADE=(int(SCREENFADE)!=0);
N111_fadeDistanceVisible=fadeDistanceVisible_1;
N111_fadeDistanceInvisible=fadeDistanceInvisible_1;
N111_particleSeed=N111_particleSeedIn;
N111_globalSeed=N111_globalSeedIn;
float l9_0=N111_particleSeed.x;
float l9_1=N111_particleSeed.y;
float l9_2=N111_particleSeed.z;
float l9_3=N111_globalSeed;
vec3 l9_4=N111_particleSeed;
float l9_5=N111_globalSeed;
float l9_6=N111_EPSILON;
float l9_7=ssPow(fract(N111_particleSeed.x+N111_globalSeed),0.33333334);
float l9_8=N111_particleSeed.x;
float l9_9=N111_globalSeed;
float l9_10=fract((l9_8*334.59122)+l9_9)-0.5;
float l9_11=N111_particleSeed.y;
float l9_12=N111_globalSeed;
float l9_13=fract((l9_11*41.231232)+l9_12)-0.5;
float l9_14=N111_particleSeed.z;
float l9_15=N111_globalSeed;
float l9_16=fract((l9_14*18.984529)+l9_15);
float l9_17=N111_particleSeed.x;
float l9_18=N111_globalSeed;
float l9_19=fract((l9_17*654.15588)+l9_18);
float l9_20=N111_particleSeed.y;
float l9_21=N111_globalSeed;
float l9_22=fract((l9_20*45.722408)+l9_21);
vec3 l9_23=vec3(l9_19,l9_22,l9_16);
vec3 l9_24=(l9_23-vec3(0.5))*2.0;
float l9_25=N111_particleSeed.z;
float l9_26=N111_globalSeed;
float l9_27=fract((l9_25*15.32451)+l9_26);
vec4 l9_28=N111_timeValuesIn;
float l9_29=N111_timeValuesIn.z;
float l9_30=N111_timeValuesIn.w;
vec3 l9_31;
if (N111_ENABLE_INILOCATION)
{
l9_31=N111_spawnLocation;
}
else
{
l9_31=vec3(0.0);
}
vec3 l9_32;
if (N111_ENABLE_BOXSPAWN)
{
l9_32=N111_spawnBox*(fract((vec3(l9_0,l9_1,l9_2)*3048.28)+vec3(l9_3))-vec3(0.5));
}
else
{
l9_32=vec3(0.0);
}
vec3 l9_33;
if (N111_ENABLE_SPHERESPAWN)
{
l9_33=N111_spawnSphere*((normalize((fract((l9_4*374.57129)+vec3(l9_5))-vec3(0.5))+vec3(l9_6))*l9_7)/vec3(2.0));
}
else
{
l9_33=vec3(0.0);
}
vec3 l9_34=l9_31+l9_33;
vec3 l9_35=l9_34+l9_32;
vec3 l9_36;
if (N111_ENABLE_NOISE)
{
l9_36=vec3(0.0)+N111_sineNoise(N111_noiseFrequency,N111_noiseMult,l9_24,l9_30);
}
else
{
l9_36=vec3(0.0);
}
vec3 l9_37;
if (N111_ENABLE_SNOISE)
{
l9_37=l9_36+N111_simplexNoise(l9_16,l9_19,l9_22,N111_sNoiseFrequency,N111_sNoiseMult,l9_24,l9_29);
}
else
{
l9_37=l9_36;
}
float l9_38=N111_gravity;
float l9_39=((l9_38/2.0)*l9_29)*l9_29;
vec3 l9_40=vec3(0.0,l9_39,0.0);
vec3 l9_41;
if (N111_ENABLE_FORCE)
{
l9_41=((N111_localForce/vec3(2.0))*l9_29)*l9_29;
}
else
{
l9_41=vec3(0.0);
}
vec3 l9_42=N111_velocityMin;
vec3 l9_43=N111_velocityMax;
vec3 l9_44=N111_velocityMin;
vec3 l9_45;
if (N111_ENABLE_VELRAMP)
{
l9_45=mix(N111_velocityMin,N111_velocityMax,l9_23);
}
else
{
l9_45=l9_42+(((l9_24+vec3(1.0))/vec3(2.0))*(l9_43-l9_44));
}
vec3 l9_46=N111_pVelocity(l9_45,l9_29,N111_velocityDrag,l9_37,l9_30);
float l9_47=length(sc_ModelMatrix[0].xyz);
float l9_48=length(sc_ModelMatrix[1].xyz);
float l9_49=length(sc_ModelMatrix[2].xyz);
vec3 l9_50=vec3(l9_47,l9_48,l9_49);
vec3 l9_51=(l9_46+l9_40)+l9_41;
mat3 l9_52=N111_transposeMatrix(sc_ModelMatrix);
vec3 l9_53;
if (N111_WORLDFORCE)
{
l9_53=((l9_46*N111_transposeMatrix(sc_ModelMatrix))+l9_40)+l9_41;
}
else
{
l9_53=l9_51*l9_52;
}
vec3 l9_54;
if (N111_WORLDSPACE)
{
l9_54=((l9_46*l9_50)+l9_40)+l9_41;
}
else
{
l9_54=l9_53;
}
vec3 l9_55=(sc_ModelMatrix*vec4(l9_35,1.0)).xyz+l9_54;
float l9_56=N111_rotationRandomZ.x;
float l9_57=N111_rotationRandomZ.y;
float l9_58=ssPow(1.0-l9_30,N111_rotationDrag);
float l9_59=N111_rotationRateZ.x;
float l9_60=N111_rotationRateZ.y;
float l9_61=N111_PI;
float l9_62=(((mix(l9_59,l9_60,l9_27)*l9_58)*l9_30)*2.0)+mix(l9_56,l9_57,l9_27);
float l9_63=l9_61*(l9_62-0.5);
float l9_64;
if (N111_ENABLE_SCREENFADE)
{
vec3 l9_65=sc_Camera.position-l9_55;
float l9_66=(N111_fadeDistanceInvisible+N111_EPSILON)*(N111_fadeDistanceInvisible+N111_EPSILON);
float l9_67=N111_fadeDistanceVisible*N111_fadeDistanceVisible;
N111_nearCameraFade=smoothstep(min(l9_66,l9_67),max(l9_66,l9_67),dot(l9_65,l9_65));
float l9_68;
if (l9_66>l9_67)
{
l9_68=1.0-N111_nearCameraFade;
}
else
{
l9_68=N111_nearCameraFade;
}
N111_nearCameraFade=l9_68;
float l9_69;
if (N111_nearCameraFade<=N111_EPSILON)
{
l9_69=0.0;
}
else
{
l9_69=1.0;
}
l9_64=l9_69;
}
else
{
l9_64=1.0;
}
if (N111_MESHTYPE_QUAD)
{
vec3 l9_70=-sc_ViewMatrixInverseArray[sc_GetStereoViewIndex()][1].xyz;
vec3 l9_71;
vec3 l9_72;
if (N111_ENABLE_ALIGNTOX)
{
l9_72=vec3(0.0,1.0,0.0);
l9_71=vec3(0.0,0.0,1.0);
}
else
{
l9_72=l9_70;
l9_71=normalize(cross(sc_ViewMatrixInverseArray[sc_GetStereoViewIndex()][2].xyz,l9_70));
}
vec3 l9_73;
vec3 l9_74;
if (N111_ENABLE_ALIGNTOY)
{
l9_74=vec3(0.0,0.0,1.0);
l9_73=vec3(1.0,0.0,0.0);
}
else
{
l9_74=l9_72;
l9_73=l9_71;
}
vec3 l9_75;
vec3 l9_76;
if (N111_ENABLE_ALIGNTOZ)
{
l9_76=vec3(0.0,1.0,0.0);
l9_75=vec3(1.0,0.0,0.0);
}
else
{
l9_76=l9_74;
l9_75=l9_73;
}
float l9_77=cos(l9_63);
float l9_78=sin(l9_63);
vec3 l9_79=l9_75*l9_77;
vec3 l9_80=l9_76*l9_78;
vec3 l9_81=l9_75*(-l9_78);
vec3 l9_82=l9_76*l9_77;
vec3 l9_83;
vec3 l9_84;
float l9_85;
if (N111_ENABLE_ALIGNTOVEL)
{
vec3 l9_86=l9_54+l9_40;
vec3 l9_87=l9_86+l9_41;
float l9_88=N111_EPSILON;
vec3 l9_89=normalize(l9_87+vec3(l9_88));
vec3 l9_90=l9_54*(l9_29-0.0099999998);
vec3 l9_91=l9_54*(l9_29+0.0099999998);
float l9_92;
if (N111_ENABLE_IGNOREVEL)
{
l9_92=max(N111_sizeVelScale,N111_EPSILON);
}
else
{
float l9_93=length(l9_91-l9_90);
float l9_94=N111_sizeVelScale;
float l9_95;
if (N111_ENABLE_IGNORETRANSFORMSCALE)
{
l9_95=(l9_93/l9_47)*N111_sizeVelScale;
}
else
{
l9_95=l9_93*l9_94;
}
l9_92=l9_95;
}
l9_85=l9_92;
l9_84=l9_89;
l9_83=normalize(cross(l9_89,sc_ViewMatrixInverseArray[sc_GetStereoViewIndex()][2].xyz));
}
else
{
l9_85=1.0;
l9_84=l9_79+l9_80;
l9_83=l9_81+l9_82;
}
vec2 l9_96=(((tempGlobals.Surface_UVCoord0-vec2(0.5))*(N111_dieTrigger*l9_64))*N111_pSize(l9_10,l9_13,l9_30,N111_sizeSpeed))*l9_47;
N111_position=(l9_55+(l9_83*l9_96.x))+(l9_84*(l9_96.y*l9_85));
N111_normal=sc_ViewMatrixInverseArray[sc_GetStereoViewIndex()][2].xyz;
}
else
{
N111_position=N111_positionObjectSpace;
if (N111_ENABLE_CENTER_IN_BBOX)
{
N111_position-=((sc_LocalAabbMax+sc_LocalAabbMin)/vec3(2.0));
}
N111_position=(N111_position*l9_50)*N111_pSize3D(l9_10,l9_13,l9_30,N111_sizeSpeed);
if ((N111_dieTrigger<0.5)||(l9_64<0.5))
{
N111_position.x=2.1474836e+09;
}
mat3 l9_97;
if (((N111_ENABLE_ALIGNTOVEL||N111_ENABLE_ALIGNTOX)||N111_ENABLE_ALIGNTOY)||N111_ENABLE_ALIGNTOZ)
{
mat3 l9_98;
if (N111_ENABLE_ALIGNTOZ)
{
l9_98=mat3(vec3(1.0,0.0,0.0),vec3(0.0,1.0,0.0),vec3(0.0,0.0,1.0));
}
else
{
vec3 l9_99;
if (N111_ENABLE_ALIGNTOX)
{
l9_99=vec3(1.0,0.0,0.0);
}
else
{
l9_99=vec3(0.0);
}
vec3 l9_100;
if (N111_ENABLE_ALIGNTOY)
{
l9_100=vec3(0.0,1.0,0.0);
}
else
{
l9_100=l9_99;
}
vec3 l9_101;
if (N111_ENABLE_ALIGNTOVEL)
{
float l9_102=l9_29-0.001;
vec3 l9_103=N111_pVelocity(l9_45,l9_102,N111_velocityDrag,l9_37,l9_30-0.001);
vec3 l9_104=l9_40;
l9_104.y=l9_39-(((N111_gravity/2.0)*l9_102)*l9_102);
vec3 l9_105;
if (N111_ENABLE_FORCE)
{
l9_105=l9_41-(((N111_localForce/vec3(2.0))*l9_102)*l9_102);
}
else
{
l9_105=l9_41;
}
vec3 l9_106;
if (N111_WORLDFORCE)
{
l9_106=(((l9_46-l9_103)*N111_transposeMatrix(sc_ModelMatrix))+l9_104)+l9_105;
}
else
{
vec3 l9_107;
if (N111_WORLDSPACE)
{
l9_107=((l9_46-l9_103)+l9_104)+l9_105;
}
else
{
l9_107=(((l9_46-l9_103)+l9_105)+l9_104)*N111_transposeMatrix(sc_ModelMatrix);
}
l9_106=l9_107;
}
l9_101=normalize(l9_106+vec3(N111_EPSILON));
}
else
{
l9_101=l9_100;
}
vec3 l9_108=cross(l9_101,vec3(0.0,0.0,1.0));
vec3 l9_109=normalize(l9_108);
float l9_110=length(l9_108);
float l9_111=1.0-l9_101.z;
float l9_112=l9_109.x;
float l9_113=l9_111*l9_112;
float l9_114=l9_109.y;
float l9_115=l9_113*l9_114;
float l9_116=l9_109.z;
float l9_117=l9_116*l9_110;
float l9_118=l9_111*l9_116;
float l9_119=l9_118*l9_112;
float l9_120=l9_114*l9_110;
float l9_121=l9_111*l9_114;
float l9_122=l9_121*l9_116;
float l9_123=l9_112*l9_110;
l9_98=mat3(vec3((l9_113*l9_112)+l9_101.z,l9_115-l9_117,l9_119+l9_120),vec3(l9_115+l9_117,(l9_121*l9_114)+l9_101.z,l9_122-l9_123),vec3(l9_119-l9_120,l9_122+l9_123,(l9_118*l9_116)+l9_101.z));
}
float l9_124=cos(l9_63);
float l9_125=sin(l9_63);
mat3 l9_126=l9_98*mat3(vec3(l9_124,-l9_125,0.0),vec3(l9_125,l9_124,0.0),vec3(0.0,0.0,1.0));
if (N111_ENABLE_ALIGNTOVEL&&(!N111_ENABLE_IGNOREVEL))
{
N111_position.z*=(length((l9_54*(l9_29+0.0099999998))-(l9_54*(l9_29-0.0099999998)))*max(N111_sizeVelScale,0.1));
}
l9_97=l9_126;
}
else
{
float l9_127=fract((N111_particleSeed.x*92.653008)+N111_globalSeed);
float l9_128=fract((N111_particleSeed.y*6.7557559)+N111_globalSeed);
float l9_129=N111_PI*((((mix(N111_rotationRateX.x,N111_rotationRateX.y,l9_127)*l9_58)*l9_30)*2.0)+mix(N111_rotationRandomX.x,N111_rotationRandomX.y,l9_127));
float l9_130=N111_PI*((((mix(N111_rotationRateY.x,N111_rotationRateY.y,l9_128)*l9_58)*l9_30)*2.0)+mix(N111_rotationRandomY.x,N111_rotationRandomY.y,l9_128));
float l9_131=N111_PI*l9_62;
float l9_132=cos(l9_129);
float l9_133=sin(l9_129);
float l9_134=cos(l9_130);
float l9_135=sin(l9_130);
float l9_136=cos(l9_131);
float l9_137=sin(l9_131);
float l9_138=l9_133*l9_135;
float l9_139=l9_132*l9_135;
l9_97=mat3(vec3(l9_134*l9_136,(l9_132*l9_137)+(l9_138*l9_136),(l9_133*l9_137)-(l9_139*l9_136)),vec3((-l9_134)*l9_137,(l9_132*l9_136)-(l9_138*l9_137),(l9_133*l9_136)+(l9_139*l9_137)),vec3(l9_135,(-l9_133)*l9_134,l9_132*l9_134));
}
mat3 l9_140;
if ((!N111_WORLDSPACE)&&(!N111_ENABLE_ALIGNTOVEL))
{
l9_140=mat3(sc_ModelMatrix[0].xyz/vec3(l9_47),sc_ModelMatrix[1].xyz/vec3(l9_48),sc_ModelMatrix[2].xyz/vec3(l9_49))*l9_97;
}
else
{
l9_140=l9_97;
}
N111_position=l9_140*N111_position;
N111_normal=normalize(l9_140*N111_normalObjectSpace);
N111_position+=l9_55;
}
N111_timeValues=vec4(l9_28.xy,l9_29,l9_30);
particleSeed=N111_particleSeed;
globalSeed=N111_globalSeed;
timeValues=N111_timeValues;
nearCameraFade=N111_nearCameraFade;
position_1=N111_position;
normal_1=N111_normal;
}
void sc_SetClipDistancePlatform(float dstClipDistance)
{
    #if sc_StereoRenderingMode==sc_StereoRendering_InstancedClipped&&sc_StereoRendering_IsClipDistanceEnabled
        gl_ClipDistance[0]=dstClipDistance;
    #endif
}
void Interpolate_N179(ssGlobals Globals)
{
float param;
Node6_Bool_Parameter(param,Globals);
float param_2;
Node8_Bool_Parameter(param_2,Globals);
float param_4;
Node0_Bool_Parameter(param_4,Globals);
float param_6;
Node11_Bool_Parameter(param_6,Globals);
vec3 param_18;
float param_19;
float param_20;
vec4 param_21;
Node173_Particle_Seed_Time_and_Spawn(timeGlobal,param,externalTimeInput,param_2,externalSeed,param_4,lifeTimeConstant,lifeTimeMinMax,param_6,spawnDuration,param_18,param_19,param_20,param_21,Globals);
float param_23;
Node15_Bool_Parameter(param_23,Globals);
float param_25;
Node17_Bool_Parameter(param_25,Globals);
float param_27;
Node19_Bool_Parameter(param_27,Globals);
float param_29;
Node43_Bool_Parameter(param_29,Globals);
float param_31;
Node44_Bool_Parameter(param_31,Globals);
float param_33;
Node38_Bool_Parameter(param_33,Globals);
vec3 param_38;
Node70_If_else(0.0,vec3(0.0),vec3(0.0),param_38,Globals);
vec3 param_43;
Node121_If_else(0.0,vec3(0.0),vec3(0.0),param_43,Globals);
float param_45;
Node99_Bool_Parameter(param_45,Globals);
vec3 param_50;
Node124_If_else(0.0,vec3(0.0),vec3(0.0),param_50,Globals);
vec3 param_55;
Node123_If_else(0.0,vec3(0.0),vec3(0.0),param_55,Globals);
vec3 param_60;
Node125_If_else(0.0,vec3(0.0),vec3(0.0),param_60,Globals);
vec3 param_65;
Node126_If_else(0.0,vec3(0.0),vec3(0.0),param_65,Globals);
float param_67;
Node102_Bool_Parameter(param_67,Globals);
float param_69;
Node108_Bool_Parameter(param_69,Globals);
float param_71;
Node47_Bool_Parameter(param_71,Globals);
float param_73;
Node109_Bool_Parameter(param_73,Globals);
float param_75;
Node174_Bool_Parameter(param_75,Globals);
vec2 param_80;
Node138_Conditional(1.0,Port_Input1_N138,vec2(0.0),param_80,Globals);
vec2 param_85;
Node139_Conditional(1.0,Port_Input1_N139,vec2(0.0),param_85,Globals);
vec2 param_90;
Node140_Conditional(1.0,Port_Input1_N140,vec2(0.0),param_90,Globals);
vec2 param_95;
Node144_Conditional(1.0,Port_Input1_N144,vec2(0.0),param_95,Globals);
vec2 param_100;
Node135_Conditional(1.0,vec2(1.0),vec2(0.0),param_100,Globals);
vec2 param_105;
Node137_Conditional(1.0,vec2(1.0),vec2(0.0),param_105,Globals);
float l9_0=float(rotationSpace);
float param_110;
Node110_Conditional(1.0,Port_Input1_N110,0.0,param_110,Globals);
float param_112;
Node175_Bool_Parameter(param_112,Globals);
vec3 param_169;
float param_170;
vec4 param_171;
float param_172;
vec3 param_173;
vec3 param_174;
Node111_Vertex_Shader_Particles(float(float(MESHTYPE)==Port_Input1_N119),param_18,param_19,param_20,param_21,Globals.SurfacePosition_ObjectSpace,Globals.VertexNormal_ObjectSpace,param_23,spawnLocation,param_25,spawnBox,param_27,spawnSphere,param_29,noiseMult,noiseFrequency,param_31,sNoiseMult,sNoiseFrequency,param_33,velocityMin,velocityMax,velocityDrag,param_38,param_43,param_45,param_50,param_55,param_60,param_65,sizeSpeed,param_67,gravity,param_69,localForce,param_71,sizeVelScale,param_73,param_75,float(ALIGNTOX),float(ALIGNTOY),float(ALIGNTOZ),param_80,param_85,param_90,param_95,param_100,param_105,rotationDrag,float(l9_0==Port_Input1_N069),float(l9_0==Port_Input1_N068),param_110,param_112,fadeDistanceVisible,fadeDistanceInvisible,param_169,param_170,param_171,param_172,param_173,param_174,Globals);
Interpolator0.x=param_172;
}
void Interpolate_N169(ssGlobals Globals)
{
float param;
Node6_Bool_Parameter(param,Globals);
float param_2;
Node8_Bool_Parameter(param_2,Globals);
float param_4;
Node0_Bool_Parameter(param_4,Globals);
float param_6;
Node11_Bool_Parameter(param_6,Globals);
vec3 param_18;
float param_19;
float param_20;
vec4 param_21;
Node173_Particle_Seed_Time_and_Spawn(timeGlobal,param,externalTimeInput,param_2,externalSeed,param_4,lifeTimeConstant,lifeTimeMinMax,param_6,spawnDuration,param_18,param_19,param_20,param_21,Globals);
float param_23;
Node15_Bool_Parameter(param_23,Globals);
float param_25;
Node17_Bool_Parameter(param_25,Globals);
float param_27;
Node19_Bool_Parameter(param_27,Globals);
float param_29;
Node43_Bool_Parameter(param_29,Globals);
float param_31;
Node44_Bool_Parameter(param_31,Globals);
float param_33;
Node38_Bool_Parameter(param_33,Globals);
vec3 param_38;
Node70_If_else(0.0,vec3(0.0),vec3(0.0),param_38,Globals);
vec3 param_43;
Node121_If_else(0.0,vec3(0.0),vec3(0.0),param_43,Globals);
float param_45;
Node99_Bool_Parameter(param_45,Globals);
vec3 param_50;
Node124_If_else(0.0,vec3(0.0),vec3(0.0),param_50,Globals);
vec3 param_55;
Node123_If_else(0.0,vec3(0.0),vec3(0.0),param_55,Globals);
vec3 param_60;
Node125_If_else(0.0,vec3(0.0),vec3(0.0),param_60,Globals);
vec3 param_65;
Node126_If_else(0.0,vec3(0.0),vec3(0.0),param_65,Globals);
float param_67;
Node102_Bool_Parameter(param_67,Globals);
float param_69;
Node108_Bool_Parameter(param_69,Globals);
float param_71;
Node47_Bool_Parameter(param_71,Globals);
float param_73;
Node109_Bool_Parameter(param_73,Globals);
float param_75;
Node174_Bool_Parameter(param_75,Globals);
vec2 param_80;
Node138_Conditional(1.0,Port_Input1_N138,vec2(0.0),param_80,Globals);
vec2 param_85;
Node139_Conditional(1.0,Port_Input1_N139,vec2(0.0),param_85,Globals);
vec2 param_90;
Node140_Conditional(1.0,Port_Input1_N140,vec2(0.0),param_90,Globals);
vec2 param_95;
Node144_Conditional(1.0,Port_Input1_N144,vec2(0.0),param_95,Globals);
vec2 param_100;
Node135_Conditional(1.0,vec2(1.0),vec2(0.0),param_100,Globals);
vec2 param_105;
Node137_Conditional(1.0,vec2(1.0),vec2(0.0),param_105,Globals);
float l9_0=float(rotationSpace);
float param_110;
Node110_Conditional(1.0,Port_Input1_N110,0.0,param_110,Globals);
float param_112;
Node175_Bool_Parameter(param_112,Globals);
vec3 param_169;
float param_170;
vec4 param_171;
float param_172;
vec3 param_173;
vec3 param_174;
Node111_Vertex_Shader_Particles(float(float(MESHTYPE)==Port_Input1_N119),param_18,param_19,param_20,param_21,Globals.SurfacePosition_ObjectSpace,Globals.VertexNormal_ObjectSpace,param_23,spawnLocation,param_25,spawnBox,param_27,spawnSphere,param_29,noiseMult,noiseFrequency,param_31,sNoiseMult,sNoiseFrequency,param_33,velocityMin,velocityMax,velocityDrag,param_38,param_43,param_45,param_50,param_55,param_60,param_65,sizeSpeed,param_67,gravity,param_69,localForce,param_71,sizeVelScale,param_73,param_75,float(ALIGNTOX),float(ALIGNTOY),float(ALIGNTOZ),param_80,param_85,param_90,param_95,param_100,param_105,rotationDrag,float(l9_0==Port_Input1_N069),float(l9_0==Port_Input1_N068),param_110,param_112,fadeDistanceVisible,fadeDistanceInvisible,param_169,param_170,param_171,param_172,param_173,param_174,Globals);
Interpolator0.y=param_171.x;
Interpolator0.z=param_171.y;
Interpolator0.w=param_171.z;
Interpolator1.x=param_171.w;
}
void main()
{
N111_ENABLE_ALIGNTOX=false;
N111_ENABLE_ALIGNTOY=false;
N111_ENABLE_ALIGNTOZ=false;
N111_ENABLE_CENTER_IN_BBOX=false;
N111_MESHTYPE_QUAD=false;
N111_particleSeedIn=vec3(0.0);
N111_globalSeedIn=0.0;
N111_dieTrigger=0.0;
N111_timeValuesIn=vec4(0.0);
N111_positionObjectSpace=vec3(0.0);
N111_normalObjectSpace=vec3(0.0);
N111_ENABLE_INILOCATION=false;
N111_spawnLocation=vec3(0.0);
N111_ENABLE_BOXSPAWN=false;
N111_spawnBox=vec3(0.0);
N111_ENABLE_SPHERESPAWN=false;
N111_spawnSphere=vec3(0.0);
N111_ENABLE_NOISE=false;
N111_noiseMult=vec3(0.0);
N111_noiseFrequency=vec3(0.0);
N111_ENABLE_SNOISE=false;
N111_sNoiseMult=vec3(0.0);
N111_sNoiseFrequency=vec3(0.0);
N111_ENABLE_VELRAMP=false;
N111_velocityMin=vec3(0.0);
N111_velocityMax=vec3(0.0);
N111_velocityDrag=vec3(0.0);
N111_sizeStart=vec3(0.0);
N111_sizeEnd=vec3(0.0);
N111_ENABLE_SIZEMINMAX=false;
N111_sizeStartMin=vec3(0.0);
N111_sizeStartMax=vec3(0.0);
N111_sizeEndMin=vec3(0.0);
N111_sizeEndMax=vec3(0.0);
N111_sizeSpeed=0.0;
N111_ENABLE_SIZERAMP=false;
N111_gravity=0.0;
N111_ENABLE_FORCE=false;
N111_localForce=vec3(0.0);
N111_ENABLE_ALIGNTOVEL=false;
N111_sizeVelScale=0.0;
N111_ENABLE_IGNOREVEL=false;
N111_ENABLE_IGNORETRANSFORMSCALE=false;
N111_rotationRandomX=vec2(0.0);
N111_rotationRateX=vec2(0.0);
N111_rotationRandomY=vec2(0.0);
N111_rotationRateY=vec2(0.0);
N111_rotationRandomZ=vec2(0.0);
N111_rotationRateZ=vec2(0.0);
N111_rotationDrag=0.0;
N111_WORLDSPACE=false;
N111_WORLDFORCE=false;
N111_ENABLE_SCREENFADE=false;
N111_fadeDistanceVisible=0.0;
N111_fadeDistanceInvisible=0.0;
N111_particleSeed=vec3(0.0);
N111_globalSeed=0.0;
N111_timeValues=vec4(0.0);
N111_nearCameraFade=0.0;
N111_position=vec3(0.0);
N111_normal=vec3(0.0);
N111_EPSILON=1e-06;
N111_PI=3.1415927;
N173_timeGlobal=0.0;
N173_ENABLE_EXTERNALTIME=false;
N173_externalTime=0.0;
N173_ENABLE_WORLDPOSSEED=false;
N173_externalSeed=0.0;
N173_ENABLE_LIFETIMEMINMAX=false;
N173_lifeTimeConstant=0.0;
N173_lifeTimeMinMax=vec2(0.0);
N173_ENABLE_INSTANTSPAWN=false;
N173_spawnDuration=0.0;
N173_particleSeed=vec3(0.0);
N173_globalSeed=0.0;
N173_dieTrigger=0.0;
N173_timeValues=vec4(0.0);
PreviewVertexColor=vec4(0.5);
PreviewVertexSaved=0.0;
vec4 l9_0;
#if (sc_IsEditor&&SC_DISABLE_FRUSTUM_CULLING)
{
vec4 l9_1=position;
l9_1.x=position.x+sc_DisableFrustumCullingMarker;
l9_0=l9_1;
}
#else
{
l9_0=position;
}
#endif
vec2 l9_2;
vec2 l9_3;
vec3 l9_4;
vec3 l9_5;
vec4 l9_6;
#if (sc_VertexBlending)
{
vec2 l9_7;
vec2 l9_8;
vec3 l9_9;
vec3 l9_10;
vec4 l9_11;
#if (sc_VertexBlendingUseNormals)
{
sc_Vertex_t l9_12=sc_Vertex_t(l9_0,normal,tangent.xyz,texture0,texture1);
blendTargetShapeWithNormal(l9_12,blendShape0Pos,blendShape0Normal,weights0.x);
blendTargetShapeWithNormal(l9_12,blendShape1Pos,blendShape1Normal,weights0.y);
blendTargetShapeWithNormal(l9_12,blendShape2Pos,blendShape2Normal,weights0.z);
l9_11=l9_12.position;
l9_10=l9_12.normal;
l9_9=l9_12.tangent;
l9_8=l9_12.texture0;
l9_7=l9_12.texture1;
}
#else
{
vec3 l9_14=(((((l9_0.xyz+(blendShape0Pos*weights0.x)).xyz+(blendShape1Pos*weights0.y)).xyz+(blendShape2Pos*weights0.z)).xyz+(blendShape3Pos*weights0.w)).xyz+(blendShape4Pos*weights1.x)).xyz+(blendShape5Pos*weights1.y);
l9_11=vec4(l9_14.x,l9_14.y,l9_14.z,l9_0.w);
l9_10=normal;
l9_9=tangent.xyz;
l9_8=texture0;
l9_7=texture1;
}
#endif
l9_6=l9_11;
l9_5=l9_10;
l9_4=l9_9;
l9_3=l9_8;
l9_2=l9_7;
}
#else
{
l9_6=l9_0;
l9_5=normal;
l9_4=tangent.xyz;
l9_3=texture0;
l9_2=texture1;
}
#endif
vec3 l9_15;
vec3 l9_16;
vec4 l9_17;
#if (sc_SkinBonesCount>0)
{
vec4 l9_18;
#if (sc_SkinBonesCount>0)
{
vec4 l9_19=vec4(1.0,fract(boneData.yzw));
vec4 l9_20=l9_19;
l9_20.x=1.0-dot(l9_19.yzw,vec3(1.0));
l9_18=l9_20;
}
#else
{
l9_18=vec4(0.0);
}
#endif
int l9_21=sc_GetBoneIndex(0);
int l9_22=sc_GetBoneIndex(1);
int l9_23=sc_GetBoneIndex(2);
int l9_24=sc_GetBoneIndex(3);
vec3 l9_25=(((skinVertexPosition(l9_21,l9_6)*l9_18.x)+(skinVertexPosition(l9_22,l9_6)*l9_18.y))+(skinVertexPosition(l9_23,l9_6)*l9_18.z))+(skinVertexPosition(l9_24,l9_6)*l9_18.w);
l9_17=vec4(l9_25.x,l9_25.y,l9_25.z,l9_6.w);
l9_16=((((sc_SkinBonesNormalMatrices[l9_21]*l9_5)*l9_18.x)+((sc_SkinBonesNormalMatrices[l9_22]*l9_5)*l9_18.y))+((sc_SkinBonesNormalMatrices[l9_23]*l9_5)*l9_18.z))+((sc_SkinBonesNormalMatrices[l9_24]*l9_5)*l9_18.w);
l9_15=((((sc_SkinBonesNormalMatrices[l9_21]*l9_4)*l9_18.x)+((sc_SkinBonesNormalMatrices[l9_22]*l9_4)*l9_18.y))+((sc_SkinBonesNormalMatrices[l9_23]*l9_4)*l9_18.z))+((sc_SkinBonesNormalMatrices[l9_24]*l9_4)*l9_18.w);
}
#else
{
l9_17=l9_6;
l9_16=l9_5;
l9_15=l9_4;
}
#endif
#if (sc_RenderingSpace==3)
{
varPos=vec3(0.0);
varNormal=l9_16;
varTangent=vec4(l9_15.x,l9_15.y,l9_15.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==4)
{
varPos=vec3(0.0);
varNormal=l9_16;
varTangent=vec4(l9_15.x,l9_15.y,l9_15.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==2)
{
varPos=l9_17.xyz;
varNormal=l9_16;
varTangent=vec4(l9_15.x,l9_15.y,l9_15.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==1)
{
varPos=(sc_ModelMatrix*l9_17).xyz;
varNormal=sc_NormalMatrix*l9_16;
vec3 l9_26=sc_NormalMatrix*l9_15;
varTangent=vec4(l9_26.x,l9_26.y,l9_26.z,varTangent.w);
}
#endif
}
#endif
}
#endif
}
#endif
bool l9_27=PreviewEnabled==1;
vec2 l9_28;
if (l9_27)
{
vec2 l9_29=l9_3;
l9_29.x=1.0-l9_3.x;
l9_28=l9_29;
}
else
{
l9_28=l9_3;
}
varColor=color;
bool l9_30=overrideTimeEnabled==1;
float l9_31;
if (l9_30)
{
l9_31=overrideTimeElapsed;
}
else
{
l9_31=sc_Time.x;
}
float l9_32;
if (l9_30)
{
l9_32=overrideTimeDelta;
}
else
{
l9_32=sc_Time.y;
}
vec4 l9_33=varColor;
vec3 l9_34=(sc_ModelMatrixInverse*vec4(varPos,1.0)).xyz;
vec3 l9_35=varNormal;
vec3 l9_36=normalize((sc_ModelMatrixInverse*vec4(l9_35,0.0)).xyz);
float l9_37=float(sc_GetLocalInstanceID())+0.5;
float l9_38=float(float(MESHTYPE)==Port_Input1_N119);
ssGlobals l9_39=ssGlobals(l9_31,l9_32,0.0,l9_28,l9_33,l9_34,l9_35,l9_36,l9_37);
float param;
Node6_Bool_Parameter(param,l9_39);
float param_2;
Node8_Bool_Parameter(param_2,l9_39);
float param_4;
Node0_Bool_Parameter(param_4,l9_39);
float param_6;
Node11_Bool_Parameter(param_6,l9_39);
vec3 param_18;
float param_19;
float param_20;
vec4 param_21;
Node173_Particle_Seed_Time_and_Spawn(timeGlobal,param,externalTimeInput,param_2,externalSeed,param_4,lifeTimeConstant,lifeTimeMinMax,param_6,spawnDuration,param_18,param_19,param_20,param_21,l9_39);
float param_23;
Node15_Bool_Parameter(param_23,l9_39);
float param_25;
Node17_Bool_Parameter(param_25,l9_39);
float param_27;
Node19_Bool_Parameter(param_27,l9_39);
float param_29;
Node43_Bool_Parameter(param_29,l9_39);
float param_31;
Node44_Bool_Parameter(param_31,l9_39);
float param_33;
Node38_Bool_Parameter(param_33,l9_39);
vec3 param_38;
Node70_If_else(0.0,vec3(0.0),vec3(0.0),param_38,l9_39);
vec3 param_43;
Node121_If_else(0.0,vec3(0.0),vec3(0.0),param_43,l9_39);
float param_45;
Node99_Bool_Parameter(param_45,l9_39);
vec3 param_50;
Node124_If_else(0.0,vec3(0.0),vec3(0.0),param_50,l9_39);
vec3 param_55;
Node123_If_else(0.0,vec3(0.0),vec3(0.0),param_55,l9_39);
vec3 param_60;
Node125_If_else(0.0,vec3(0.0),vec3(0.0),param_60,l9_39);
vec3 param_65;
Node126_If_else(0.0,vec3(0.0),vec3(0.0),param_65,l9_39);
float param_67;
Node102_Bool_Parameter(param_67,l9_39);
float param_69;
Node108_Bool_Parameter(param_69,l9_39);
float param_71;
Node47_Bool_Parameter(param_71,l9_39);
float param_73;
Node109_Bool_Parameter(param_73,l9_39);
float param_75;
Node174_Bool_Parameter(param_75,l9_39);
float l9_40=float(ALIGNTOX);
float l9_41=float(ALIGNTOY);
float l9_42=float(ALIGNTOZ);
vec2 param_80;
Node138_Conditional(1.0,Port_Input1_N138,vec2(0.0),param_80,l9_39);
vec2 param_85;
Node139_Conditional(1.0,Port_Input1_N139,vec2(0.0),param_85,l9_39);
vec2 param_90;
Node140_Conditional(1.0,Port_Input1_N140,vec2(0.0),param_90,l9_39);
vec2 param_95;
Node144_Conditional(1.0,Port_Input1_N144,vec2(0.0),param_95,l9_39);
vec2 param_100;
Node135_Conditional(1.0,vec2(1.0),vec2(0.0),param_100,l9_39);
vec2 param_105;
Node137_Conditional(1.0,vec2(1.0),vec2(0.0),param_105,l9_39);
float l9_43=float(rotationSpace);
float l9_44=float(l9_43==Port_Input1_N069);
float l9_45=float(l9_43==Port_Input1_N068);
float param_110;
Node110_Conditional(1.0,Port_Input1_N110,0.0,param_110,l9_39);
float param_112;
Node175_Bool_Parameter(param_112,l9_39);
vec3 param_169;
float param_170;
vec4 param_171;
float param_172;
vec3 param_173;
vec3 param_174;
Node111_Vertex_Shader_Particles(l9_38,param_18,param_19,param_20,param_21,l9_34,l9_36,param_23,spawnLocation,param_25,spawnBox,param_27,spawnSphere,param_29,noiseMult,noiseFrequency,param_31,sNoiseMult,sNoiseFrequency,param_33,velocityMin,velocityMax,velocityDrag,param_38,param_43,param_45,param_50,param_55,param_60,param_65,sizeSpeed,param_67,gravity,param_69,localForce,param_71,sizeVelScale,param_73,param_75,l9_40,l9_41,l9_42,param_80,param_85,param_90,param_95,param_100,param_105,rotationDrag,l9_44,l9_45,param_110,param_112,fadeDistanceVisible,fadeDistanceInvisible,param_169,param_170,param_171,param_172,param_173,param_174,l9_39);
vec3 l9_46=param_173;
float param_176;
Node6_Bool_Parameter(param_176,l9_39);
float param_178;
Node8_Bool_Parameter(param_178,l9_39);
float param_180;
Node0_Bool_Parameter(param_180,l9_39);
float param_182;
Node11_Bool_Parameter(param_182,l9_39);
vec3 param_194;
float param_195;
float param_196;
vec4 param_197;
Node173_Particle_Seed_Time_and_Spawn(timeGlobal,param_176,externalTimeInput,param_178,externalSeed,param_180,lifeTimeConstant,lifeTimeMinMax,param_182,spawnDuration,param_194,param_195,param_196,param_197,l9_39);
float param_199;
Node15_Bool_Parameter(param_199,l9_39);
float param_201;
Node17_Bool_Parameter(param_201,l9_39);
float param_203;
Node19_Bool_Parameter(param_203,l9_39);
float param_205;
Node43_Bool_Parameter(param_205,l9_39);
float param_207;
Node44_Bool_Parameter(param_207,l9_39);
float param_209;
Node38_Bool_Parameter(param_209,l9_39);
vec3 param_214;
Node70_If_else(0.0,vec3(0.0),vec3(0.0),param_214,l9_39);
vec3 param_219;
Node121_If_else(0.0,vec3(0.0),vec3(0.0),param_219,l9_39);
float param_221;
Node99_Bool_Parameter(param_221,l9_39);
vec3 param_226;
Node124_If_else(0.0,vec3(0.0),vec3(0.0),param_226,l9_39);
vec3 param_231;
Node123_If_else(0.0,vec3(0.0),vec3(0.0),param_231,l9_39);
vec3 param_236;
Node125_If_else(0.0,vec3(0.0),vec3(0.0),param_236,l9_39);
vec3 param_241;
Node126_If_else(0.0,vec3(0.0),vec3(0.0),param_241,l9_39);
float param_243;
Node102_Bool_Parameter(param_243,l9_39);
float param_245;
Node108_Bool_Parameter(param_245,l9_39);
float param_247;
Node47_Bool_Parameter(param_247,l9_39);
float param_249;
Node109_Bool_Parameter(param_249,l9_39);
float param_251;
Node174_Bool_Parameter(param_251,l9_39);
vec2 param_256;
Node138_Conditional(1.0,Port_Input1_N138,vec2(0.0),param_256,l9_39);
vec2 param_261;
Node139_Conditional(1.0,Port_Input1_N139,vec2(0.0),param_261,l9_39);
vec2 param_266;
Node140_Conditional(1.0,Port_Input1_N140,vec2(0.0),param_266,l9_39);
vec2 param_271;
Node144_Conditional(1.0,Port_Input1_N144,vec2(0.0),param_271,l9_39);
vec2 param_276;
Node135_Conditional(1.0,vec2(1.0),vec2(0.0),param_276,l9_39);
vec2 param_281;
Node137_Conditional(1.0,vec2(1.0),vec2(0.0),param_281,l9_39);
float param_286;
Node110_Conditional(1.0,Port_Input1_N110,0.0,param_286,l9_39);
float param_288;
Node175_Bool_Parameter(param_288,l9_39);
vec3 param_345;
float param_346;
vec4 param_347;
float param_348;
vec3 param_349;
vec3 param_350;
Node111_Vertex_Shader_Particles(l9_38,param_194,param_195,param_196,param_197,l9_34,l9_36,param_199,spawnLocation,param_201,spawnBox,param_203,spawnSphere,param_205,noiseMult,noiseFrequency,param_207,sNoiseMult,sNoiseFrequency,param_209,velocityMin,velocityMax,velocityDrag,param_214,param_219,param_221,param_226,param_231,param_236,param_241,sizeSpeed,param_243,gravity,param_245,localForce,param_247,sizeVelScale,param_249,param_251,l9_40,l9_41,l9_42,param_256,param_261,param_266,param_271,param_276,param_281,rotationDrag,l9_44,l9_45,param_286,param_288,fadeDistanceVisible,fadeDistanceInvisible,param_345,param_346,param_347,param_348,param_349,param_350,l9_39);
vec3 l9_47=param_350;
vec3 l9_48;
vec3 l9_49;
vec3 l9_50;
if (l9_27)
{
l9_50=varTangent.xyz;
l9_49=varNormal;
l9_48=varPos;
}
else
{
l9_50=varTangent.xyz;
l9_49=l9_47;
l9_48=l9_46;
}
varPos=l9_48;
varNormal=normalize(l9_49);
vec3 l9_51=normalize(l9_50);
varTangent=vec4(l9_51.x,l9_51.y,l9_51.z,varTangent.w);
varTangent.w=tangent.w;
#if (UseViewSpaceDepthVariant&&((sc_OITDepthGatherPass||sc_OITCompositingPass)||sc_OITDepthBoundsPass))
{
vec4 l9_52;
#if (sc_RenderingSpace==3)
{
l9_52=sc_ProjectionMatrixInverseArray[sc_GetStereoViewIndex()]*l9_17;
}
#else
{
vec4 l9_53;
#if (sc_RenderingSpace==2)
{
l9_53=sc_ViewMatrixArray[sc_GetStereoViewIndex()]*l9_17;
}
#else
{
vec4 l9_54;
#if (sc_RenderingSpace==1)
{
l9_54=sc_ModelViewMatrixArray[sc_GetStereoViewIndex()]*l9_17;
}
#else
{
l9_54=l9_17;
}
#endif
l9_53=l9_54;
}
#endif
l9_52=l9_53;
}
#endif
varViewSpaceDepth=-l9_52.z;
}
#endif
vec4 l9_55;
#if (sc_RenderingSpace==3)
{
l9_55=l9_17;
}
#else
{
vec4 l9_56;
#if (sc_RenderingSpace==4)
{
l9_56=(sc_ModelViewMatrixArray[sc_GetStereoViewIndex()]*l9_17)*vec4(1.0/sc_Camera.aspect,1.0,1.0,1.0);
}
#else
{
vec4 l9_57;
#if (sc_RenderingSpace==2)
{
l9_57=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPos,1.0);
}
#else
{
vec4 l9_58;
#if (sc_RenderingSpace==1)
{
l9_58=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPos,1.0);
}
#else
{
l9_58=vec4(0.0);
}
#endif
l9_57=l9_58;
}
#endif
l9_56=l9_57;
}
#endif
l9_55=l9_56;
}
#endif
varPackedTex=vec4(l9_28,l9_2);
#if (sc_ProjectiveShadowsReceiver)
{
vec4 l9_59;
#if (sc_RenderingSpace==1)
{
l9_59=sc_ModelMatrix*l9_17;
}
#else
{
l9_59=l9_17;
}
#endif
vec4 l9_60=sc_ProjectorMatrix*l9_59;
varShadowTex=((l9_60.xy/vec2(l9_60.w))*0.5)+vec2(0.5);
}
#endif
vec4 l9_61;
#if (sc_DepthBufferMode==1)
{
vec4 l9_62=l9_55;
l9_62.z=((log2(max(sc_Camera.clipPlanes.x,1.0+l9_55.w))*(2.0/log2(sc_Camera.clipPlanes.y+1.0)))-1.0)*l9_55.w;
l9_61=l9_62;
}
#else
{
l9_61=l9_55;
}
#endif
#if (sc_StereoRenderingMode>0)
{
varStereoViewID=float(sc_StereoViewID);
}
#endif
#if (sc_StereoRenderingMode==1)
{
float l9_63=dot(l9_61,sc_StereoClipPlanes[sc_StereoViewID]);
#if (sc_StereoRendering_IsClipDistanceEnabled==1)
{
sc_SetClipDistancePlatform(l9_63);
}
#else
{
varClipDistance=l9_63;
}
#endif
}
#endif
gl_Position=l9_61;
Interpolator_gInstanceID=l9_37;
Interpolate_N179(l9_39);
Interpolate_N169(l9_39);
}
#elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_BACKEND_SHADER_FLAGS_END__
#endif
#define SC_DISABLE_FRUSTUM_CULLING
#define SC_ENABLE_INSTANCED_RENDERING
#ifdef ALIGNTOX
#undef ALIGNTOX
#endif
#ifdef ALIGNTOY
#undef ALIGNTOY
#endif
#ifdef ALIGNTOZ
#undef ALIGNTOZ
#endif
#ifdef CENTER_BBOX
#undef CENTER_BBOX
#endif
#define sc_StereoRendering_Disabled 0
#define sc_StereoRendering_InstancedClipped 1
#define sc_StereoRendering_Multiview 2
#ifdef GL_ES
    #define SC_GLES_VERSION_20 2000
    #define SC_GLES_VERSION_30 3000
    #define SC_GLES_VERSION_31 3100
    #define SC_GLES_VERSION_32 3200
#endif
#ifdef VERTEX_SHADER
    #define scOutPos(clipPosition) gl_Position=clipPosition
    #define MAIN main
#endif
#ifdef SC_ENABLE_INSTANCED_RENDERING
    #ifndef sc_EnableInstancing
        #define sc_EnableInstancing 1
    #endif
#endif
#define mod(x,y) (x-y*floor((x+1e-6)/y))
#if defined(GL_ES)&&(__VERSION__<300)&&!defined(GL_OES_standard_derivatives)
#define dFdx(A) (A)
#define dFdy(A) (A)
#define fwidth(A) (A)
#endif
#if __VERSION__<300
#define isinf(x) (x!=0.0&&x*2.0==x ? true : false)
#define isnan(x) (x>0.0||x<0.0||x==0.0 ? false : true)
#endif
#ifdef sc_EnableFeatureLevelES3
    #ifdef sc_EnableStereoClipDistance
        #if defined(GL_APPLE_clip_distance)
            #extension GL_APPLE_clip_distance : require
        #elif defined(GL_EXT_clip_cull_distance)
            #extension GL_EXT_clip_cull_distance : require
        #else
            #error Clip distance is requested but not supported by this device.
        #endif
    #endif
#else
    #ifdef sc_EnableStereoClipDistance
        #error Clip distance is requested but not supported by this device.
    #endif
#endif
#ifdef sc_EnableFeatureLevelES3
    #ifdef VERTEX_SHADER
        #define attribute in
        #define varying out
    #endif
    #ifdef FRAGMENT_SHADER
        #define varying in
    #endif
    #define gl_FragColor sc_FragData0
    #define texture2D texture
    #define texture2DLod textureLod
    #define texture2DLodEXT textureLod
    #define textureCubeLodEXT textureLod
    #define sc_CanUseTextureLod 1
#else
    #ifdef FRAGMENT_SHADER
        #if defined(GL_EXT_shader_texture_lod)
            #extension GL_EXT_shader_texture_lod : require
            #define sc_CanUseTextureLod 1
            #define texture2DLod texture2DLodEXT
        #endif
    #endif
#endif
#if defined(sc_EnableMultiviewStereoRendering)
    #define sc_StereoRenderingMode sc_StereoRendering_Multiview
    #define sc_NumStereoViews 2
    #extension GL_OVR_multiview2 : require
    #ifdef VERTEX_SHADER
        #ifdef sc_EnableInstancingFallback
            #define sc_GlobalInstanceID (sc_FallbackInstanceID*2+gl_InstanceID)
        #else
            #define sc_GlobalInstanceID gl_InstanceID
        #endif
        #define sc_LocalInstanceID sc_GlobalInstanceID
        #define sc_StereoViewID int(gl_ViewID_OVR)
    #endif
#elif defined(sc_EnableInstancedClippedStereoRendering)
    #ifndef sc_EnableInstancing
        #error Instanced-clipped stereo rendering requires enabled instancing.
    #endif
    #ifndef sc_EnableStereoClipDistance
        #define sc_StereoRendering_IsClipDistanceEnabled 0
    #else
        #define sc_StereoRendering_IsClipDistanceEnabled 1
    #endif
    #define sc_StereoRenderingMode sc_StereoRendering_InstancedClipped
    #define sc_NumStereoClipPlanes 1
    #define sc_NumStereoViews 2
    #ifdef VERTEX_SHADER
        #ifdef sc_EnableInstancingFallback
            #define sc_GlobalInstanceID (sc_FallbackInstanceID*2+gl_InstanceID)
        #else
            #define sc_GlobalInstanceID gl_InstanceID
        #endif
        #ifdef sc_EnableFeatureLevelES3
            #define sc_LocalInstanceID (sc_GlobalInstanceID/2)
            #define sc_StereoViewID (sc_GlobalInstanceID%2)
        #else
            #define sc_LocalInstanceID int(sc_GlobalInstanceID/2.0)
            #define sc_StereoViewID int(mod(sc_GlobalInstanceID,2.0))
        #endif
    #endif
#else
    #define sc_StereoRenderingMode sc_StereoRendering_Disabled
#endif
#ifdef VERTEX_SHADER
    #ifdef sc_EnableInstancing
        #ifdef GL_ES
            #if defined(sc_EnableFeatureLevelES2)&&!defined(GL_EXT_draw_instanced)
                #define gl_InstanceID (0)
            #endif
        #else
            #if defined(sc_EnableFeatureLevelES2)&&!defined(GL_EXT_draw_instanced)&&!defined(GL_ARB_draw_instanced)&&!defined(GL_EXT_gpu_shader4)
                #define gl_InstanceID (0)
            #endif
        #endif
        #ifdef GL_ARB_draw_instanced
            #extension GL_ARB_draw_instanced : require
            #define gl_InstanceID gl_InstanceIDARB
        #endif
        #ifdef GL_EXT_draw_instanced
            #extension GL_EXT_draw_instanced : require
            #define gl_InstanceID gl_InstanceIDEXT
        #endif
        #ifndef sc_InstanceID
            #define sc_InstanceID gl_InstanceID
        #endif
        #ifndef sc_GlobalInstanceID
            #ifdef sc_EnableInstancingFallback
                #define sc_GlobalInstanceID (sc_FallbackInstanceID)
                #define sc_LocalInstanceID (sc_FallbackInstanceID)
            #else
                #define sc_GlobalInstanceID gl_InstanceID
                #define sc_LocalInstanceID gl_InstanceID
            #endif
        #endif
    #endif
#endif
#ifdef VERTEX_SHADER
    #if (__VERSION__<300)&&!defined(GL_EXT_gpu_shader4)
        #define gl_VertexID (0)
    #endif
#endif
#ifndef GL_ES
        #extension GL_EXT_gpu_shader4 : enable
    #extension GL_ARB_shader_texture_lod : enable
    #ifndef texture2DLodEXT
        #define texture2DLodEXT texture2DLod
    #endif
    #ifndef sc_CanUseTextureLod
    #define sc_CanUseTextureLod 1
    #endif
    #define precision
    #define lowp
    #define mediump
    #define highp
    #define sc_FragmentPrecision
#endif
#ifdef sc_EnableFeatureLevelES3
    #define sc_CanUseSampler2DArray 1
#endif
#if defined(sc_EnableFeatureLevelES2)&&defined(GL_ES)
    #ifdef FRAGMENT_SHADER
        #ifdef GL_OES_standard_derivatives
            #extension GL_OES_standard_derivatives : require
            #define sc_CanUseStandardDerivatives 1
        #endif
    #endif
    #ifdef GL_EXT_texture_array
        #extension GL_EXT_texture_array : require
        #define sc_CanUseSampler2DArray 1
    #else
        #define sc_CanUseSampler2DArray 0
    #endif
#endif
#ifdef GL_ES
    #ifdef sc_FramebufferFetch
        #if defined(GL_EXT_shader_framebuffer_fetch)
            #extension GL_EXT_shader_framebuffer_fetch : require
        #elif defined(GL_ARM_shader_framebuffer_fetch)
            #extension GL_ARM_shader_framebuffer_fetch : require
        #else
            #error Framebuffer fetch is requested but not supported by this device.
        #endif
    #endif
    #ifdef GL_FRAGMENT_PRECISION_HIGH
        #define sc_FragmentPrecision highp
    #else
        #define sc_FragmentPrecision mediump
    #endif
    #ifdef FRAGMENT_SHADER
        precision highp int;
        precision highp float;
    #endif
#endif
#ifdef VERTEX_SHADER
    #ifdef sc_EnableMultiviewStereoRendering
        layout(num_views=sc_NumStereoViews) in;
    #endif
#endif
#if __VERSION__>100
    #define SC_INT_FALLBACK_FLOAT int
    #define SC_INTERPOLATION_FLAT flat
    #define SC_INTERPOLATION_CENTROID centroid
#else
    #define SC_INT_FALLBACK_FLOAT float
    #define SC_INTERPOLATION_FLAT
    #define SC_INTERPOLATION_CENTROID
#endif
#ifndef sc_NumStereoViews
    #define sc_NumStereoViews 1
#endif
#ifndef sc_CanUseSampler2DArray
    #define sc_CanUseSampler2DArray 0
#endif
    #if __VERSION__==100||defined(SCC_VALIDATION)
        #define sampler2DArray vec2
        #define sampler3D vec3
        #define samplerCube vec4
        vec4 texture3D(vec3 s,vec3 uv)                       { return vec4(0.0); }
        vec4 texture3D(vec3 s,vec3 uv,float bias)           { return vec4(0.0); }
        vec4 texture3DLod(vec3 s,vec3 uv,float bias)        { return vec4(0.0); }
        vec4 texture3DLodEXT(vec3 s,vec3 uv,float lod)      { return vec4(0.0); }
        vec4 texture2DArray(vec2 s,vec3 uv)                  { return vec4(0.0); }
        vec4 texture2DArray(vec2 s,vec3 uv,float bias)      { return vec4(0.0); }
        vec4 texture2DArrayLod(vec2 s,vec3 uv,float lod)    { return vec4(0.0); }
        vec4 texture2DArrayLodEXT(vec2 s,vec3 uv,float lod) { return vec4(0.0); }
        vec4 textureCube(vec4 s,vec3 uv)                     { return vec4(0.0); }
        vec4 textureCube(vec4 s,vec3 uv,float lod)          { return vec4(0.0); }
        vec4 textureCubeLod(vec4 s,vec3 uv,float lod)       { return vec4(0.0); }
        vec4 textureCubeLodEXT(vec4 s,vec3 uv,float lod)    { return vec4(0.0); }
        #if defined(VERTEX_SHADER)||!sc_CanUseTextureLod
            #define texture2DLod(s,uv,lod)      vec4(0.0)
            #define texture2DLodEXT(s,uv,lod)   vec4(0.0)
        #endif
    #elif __VERSION__>=300
        #define texture3D texture
        #define textureCube texture
        #define texture2DArray texture
        #define texture2DLod textureLod
        #define texture3DLod textureLod
        #define texture2DLodEXT textureLod
        #define texture3DLodEXT textureLod
        #define textureCubeLod textureLod
        #define textureCubeLodEXT textureLod
        #define texture2DArrayLod textureLod
        #define texture2DArrayLodEXT textureLod
    #endif
    #ifndef sc_TextureRenderingLayout_Regular
        #define sc_TextureRenderingLayout_Regular 0
        #define sc_TextureRenderingLayout_StereoInstancedClipped 1
        #define sc_TextureRenderingLayout_StereoMultiview 2
    #endif
    #define depthToGlobal   depthScreenToViewSpace
    #define depthToLocal    depthViewToScreenSpace
    #ifndef quantizeUV
        #define quantizeUV sc_QuantizeUV
        #define sc_platformUVFlip sc_PlatformFlipV
        #define sc_PlatformFlipUV sc_PlatformFlipV
    #endif
    #ifndef sc_texture2DLod
        #define sc_texture2DLod sc_InternalTextureLevel
        #define sc_textureLod sc_InternalTextureLevel
        #define sc_textureBias sc_InternalTextureBiasOrLevel
        #define sc_texture sc_InternalTexture
    #endif
#if sc_ExporterVersion<224
#define MAIN main
#endif
    #ifndef sc_FramebufferFetch
    #define sc_FramebufferFetch 0
    #elif sc_FramebufferFetch==1
    #undef sc_FramebufferFetch
    #define sc_FramebufferFetch 1
    #endif
    #if !defined(GL_ES)&&__VERSION__<420
        #ifdef FRAGMENT_SHADER
            #define sc_FragData0 gl_FragData[0]
            #define sc_FragData1 gl_FragData[1]
            #define sc_FragData2 gl_FragData[2]
            #define sc_FragData3 gl_FragData[3]
        #endif
        mat4 getFragData() { return mat4(vec4(0.0),vec4(0.0),vec4(0.0),vec4(0.0)); }
        #define gl_LastFragData (getFragData())
        #if sc_FramebufferFetch
            #error Framebuffer fetch is requested but not supported by this device.
        #endif
    #elif defined(sc_EnableFeatureLevelES3)
        #if sc_FragDataCount>=1
            #define sc_DeclareFragData0(StorageQualifier) layout(location=0) StorageQualifier sc_FragmentPrecision vec4 sc_FragData0
        #endif
        #if sc_FragDataCount>=2
            #define sc_DeclareFragData1(StorageQualifier) layout(location=1) StorageQualifier sc_FragmentPrecision vec4 sc_FragData1
        #endif
        #if sc_FragDataCount>=3
            #define sc_DeclareFragData2(StorageQualifier) layout(location=2) StorageQualifier sc_FragmentPrecision vec4 sc_FragData2
        #endif
        #if sc_FragDataCount>=4
            #define sc_DeclareFragData3(StorageQualifier) layout(location=3) StorageQualifier sc_FragmentPrecision vec4 sc_FragData3
        #endif
        #ifndef sc_DeclareFragData0
            #define sc_DeclareFragData0(_) const vec4 sc_FragData0=vec4(0.0)
        #endif
        #ifndef sc_DeclareFragData1
            #define sc_DeclareFragData1(_) const vec4 sc_FragData1=vec4(0.0)
        #endif
        #ifndef sc_DeclareFragData2
            #define sc_DeclareFragData2(_) const vec4 sc_FragData2=vec4(0.0)
        #endif
        #ifndef sc_DeclareFragData3
            #define sc_DeclareFragData3(_) const vec4 sc_FragData3=vec4(0.0)
        #endif
        #if sc_FramebufferFetch
            #ifdef GL_EXT_shader_framebuffer_fetch
                sc_DeclareFragData0(inout);
                sc_DeclareFragData1(inout);
                sc_DeclareFragData2(inout);
                sc_DeclareFragData3(inout);
                mediump mat4 getFragData() { return mat4(sc_FragData0,sc_FragData1,sc_FragData2,sc_FragData3); }
                #define gl_LastFragData (getFragData())
            #elif defined(GL_ARM_shader_framebuffer_fetch)
                sc_DeclareFragData0(out);
                sc_DeclareFragData1(out);
                sc_DeclareFragData2(out);
                sc_DeclareFragData3(out);
                mediump mat4 getFragData() { return mat4(gl_LastFragColorARM,vec4(0.0),vec4(0.0),vec4(0.0)); }
                #define gl_LastFragData (getFragData())
            #endif
        #else
            #ifdef sc_EnableFeatureLevelES3
                sc_DeclareFragData0(out);
                sc_DeclareFragData1(out);
                sc_DeclareFragData2(out);
                sc_DeclareFragData3(out);
                mediump mat4 getFragData() { return mat4(vec4(0.0),vec4(0.0),vec4(0.0),vec4(0.0)); }
                #define gl_LastFragData (getFragData())
            #endif
        #endif
    #elif defined(sc_EnableFeatureLevelES2)
        #define sc_FragData0 gl_FragColor
        mediump mat4 getFragData() { return mat4(vec4(0.0),vec4(0.0),vec4(0.0),vec4(0.0)); }
    #else
        #define sc_FragData0 gl_FragColor
        mediump mat4 getFragData() { return mat4(vec4(0.0),vec4(0.0),vec4(0.0),vec4(0.0)); }
    #endif
struct SurfaceProperties
{
vec3 albedo;
float opacity;
vec3 normal;
vec3 positionWS;
vec3 viewDirWS;
float metallic;
float roughness;
vec3 emissive;
vec3 ao;
vec3 specularAo;
vec3 bakedShadows;
vec3 specColor;
};
struct LightingComponents
{
vec3 directDiffuse;
vec3 directSpecular;
vec3 indirectDiffuse;
vec3 indirectSpecular;
vec3 emitted;
vec3 transmitted;
};
struct LightProperties
{
vec3 direction;
vec3 color;
float attenuation;
};
struct sc_SphericalGaussianLight_t
{
vec3 color;
float sharpness;
vec3 axis;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
vec3 BumpedNormal;
vec3 ViewDirWS;
vec3 PositionWS;
vec3 VertexTangent_WorldSpace;
vec3 VertexNormal_WorldSpace;
vec3 VertexBinormal_WorldSpace;
vec2 Surface_UVCoord0;
vec2 Surface_UVCoord1;
float gInstanceID;
};
#ifndef sc_CanUseStandardDerivatives
#define sc_CanUseStandardDerivatives 0
#elif sc_CanUseStandardDerivatives==1
#undef sc_CanUseStandardDerivatives
#define sc_CanUseStandardDerivatives 1
#endif
#ifndef sc_CanUseTextureLod
#define sc_CanUseTextureLod 0
#elif sc_CanUseTextureLod==1
#undef sc_CanUseTextureLod
#define sc_CanUseTextureLod 1
#endif
#ifndef sc_StereoRenderingMode
#define sc_StereoRenderingMode 0
#endif
#ifndef sc_EnvmapDiffuseHasSwappedViews
#define sc_EnvmapDiffuseHasSwappedViews 0
#elif sc_EnvmapDiffuseHasSwappedViews==1
#undef sc_EnvmapDiffuseHasSwappedViews
#define sc_EnvmapDiffuseHasSwappedViews 1
#endif
#ifndef sc_EnvmapDiffuseLayout
#define sc_EnvmapDiffuseLayout 0
#endif
#ifndef sc_EnvmapSpecularHasSwappedViews
#define sc_EnvmapSpecularHasSwappedViews 0
#elif sc_EnvmapSpecularHasSwappedViews==1
#undef sc_EnvmapSpecularHasSwappedViews
#define sc_EnvmapSpecularHasSwappedViews 1
#endif
#ifndef sc_EnvmapSpecularLayout
#define sc_EnvmapSpecularLayout 0
#endif
#ifndef sc_ScreenTextureHasSwappedViews
#define sc_ScreenTextureHasSwappedViews 0
#elif sc_ScreenTextureHasSwappedViews==1
#undef sc_ScreenTextureHasSwappedViews
#define sc_ScreenTextureHasSwappedViews 1
#endif
#ifndef sc_ScreenTextureLayout
#define sc_ScreenTextureLayout 0
#endif
#ifndef sc_NumStereoViews
#define sc_NumStereoViews 1
#endif
#ifndef sc_BlendMode_Normal
#define sc_BlendMode_Normal 0
#elif sc_BlendMode_Normal==1
#undef sc_BlendMode_Normal
#define sc_BlendMode_Normal 1
#endif
#ifndef sc_BlendMode_AlphaToCoverage
#define sc_BlendMode_AlphaToCoverage 0
#elif sc_BlendMode_AlphaToCoverage==1
#undef sc_BlendMode_AlphaToCoverage
#define sc_BlendMode_AlphaToCoverage 1
#endif
#ifndef sc_BlendMode_PremultipliedAlphaHardware
#define sc_BlendMode_PremultipliedAlphaHardware 0
#elif sc_BlendMode_PremultipliedAlphaHardware==1
#undef sc_BlendMode_PremultipliedAlphaHardware
#define sc_BlendMode_PremultipliedAlphaHardware 1
#endif
#ifndef sc_BlendMode_PremultipliedAlphaAuto
#define sc_BlendMode_PremultipliedAlphaAuto 0
#elif sc_BlendMode_PremultipliedAlphaAuto==1
#undef sc_BlendMode_PremultipliedAlphaAuto
#define sc_BlendMode_PremultipliedAlphaAuto 1
#endif
#ifndef sc_BlendMode_PremultipliedAlpha
#define sc_BlendMode_PremultipliedAlpha 0
#elif sc_BlendMode_PremultipliedAlpha==1
#undef sc_BlendMode_PremultipliedAlpha
#define sc_BlendMode_PremultipliedAlpha 1
#endif
#ifndef sc_BlendMode_AddWithAlphaFactor
#define sc_BlendMode_AddWithAlphaFactor 0
#elif sc_BlendMode_AddWithAlphaFactor==1
#undef sc_BlendMode_AddWithAlphaFactor
#define sc_BlendMode_AddWithAlphaFactor 1
#endif
#ifndef sc_BlendMode_AlphaTest
#define sc_BlendMode_AlphaTest 0
#elif sc_BlendMode_AlphaTest==1
#undef sc_BlendMode_AlphaTest
#define sc_BlendMode_AlphaTest 1
#endif
#ifndef sc_BlendMode_Multiply
#define sc_BlendMode_Multiply 0
#elif sc_BlendMode_Multiply==1
#undef sc_BlendMode_Multiply
#define sc_BlendMode_Multiply 1
#endif
#ifndef sc_BlendMode_MultiplyOriginal
#define sc_BlendMode_MultiplyOriginal 0
#elif sc_BlendMode_MultiplyOriginal==1
#undef sc_BlendMode_MultiplyOriginal
#define sc_BlendMode_MultiplyOriginal 1
#endif
#ifndef sc_BlendMode_ColoredGlass
#define sc_BlendMode_ColoredGlass 0
#elif sc_BlendMode_ColoredGlass==1
#undef sc_BlendMode_ColoredGlass
#define sc_BlendMode_ColoredGlass 1
#endif
#ifndef sc_BlendMode_Add
#define sc_BlendMode_Add 0
#elif sc_BlendMode_Add==1
#undef sc_BlendMode_Add
#define sc_BlendMode_Add 1
#endif
#ifndef sc_BlendMode_Screen
#define sc_BlendMode_Screen 0
#elif sc_BlendMode_Screen==1
#undef sc_BlendMode_Screen
#define sc_BlendMode_Screen 1
#endif
#ifndef sc_BlendMode_Min
#define sc_BlendMode_Min 0
#elif sc_BlendMode_Min==1
#undef sc_BlendMode_Min
#define sc_BlendMode_Min 1
#endif
#ifndef sc_BlendMode_Max
#define sc_BlendMode_Max 0
#elif sc_BlendMode_Max==1
#undef sc_BlendMode_Max
#define sc_BlendMode_Max 1
#endif
#ifndef sc_ProjectiveShadowsReceiver
#define sc_ProjectiveShadowsReceiver 0
#elif sc_ProjectiveShadowsReceiver==1
#undef sc_ProjectiveShadowsReceiver
#define sc_ProjectiveShadowsReceiver 1
#endif
#ifndef sc_StereoRendering_IsClipDistanceEnabled
#define sc_StereoRendering_IsClipDistanceEnabled 0
#endif
#ifndef sc_ShaderComplexityAnalyzer
#define sc_ShaderComplexityAnalyzer 0
#elif sc_ShaderComplexityAnalyzer==1
#undef sc_ShaderComplexityAnalyzer
#define sc_ShaderComplexityAnalyzer 1
#endif
#ifndef sc_UseFramebufferFetchMarker
#define sc_UseFramebufferFetchMarker 0
#elif sc_UseFramebufferFetchMarker==1
#undef sc_UseFramebufferFetchMarker
#define sc_UseFramebufferFetchMarker 1
#endif
#ifndef sc_FramebufferFetch
#define sc_FramebufferFetch 0
#elif sc_FramebufferFetch==1
#undef sc_FramebufferFetch
#define sc_FramebufferFetch 1
#endif
#ifndef sc_IsEditor
#define sc_IsEditor 0
#elif sc_IsEditor==1
#undef sc_IsEditor
#define sc_IsEditor 1
#endif
#ifndef sc_GetFramebufferColorInvalidUsageMarker
#define sc_GetFramebufferColorInvalidUsageMarker 0
#elif sc_GetFramebufferColorInvalidUsageMarker==1
#undef sc_GetFramebufferColorInvalidUsageMarker
#define sc_GetFramebufferColorInvalidUsageMarker 1
#endif
#ifndef sc_BlendMode_Software
#define sc_BlendMode_Software 0
#elif sc_BlendMode_Software==1
#undef sc_BlendMode_Software
#define sc_BlendMode_Software 1
#endif
#ifndef sc_SSAOEnabled
#define sc_SSAOEnabled 0
#elif sc_SSAOEnabled==1
#undef sc_SSAOEnabled
#define sc_SSAOEnabled 1
#endif
#ifndef sc_MotionVectorsPass
#define sc_MotionVectorsPass 0
#elif sc_MotionVectorsPass==1
#undef sc_MotionVectorsPass
#define sc_MotionVectorsPass 1
#endif
#ifndef SC_DEVICE_CLASS
#define SC_DEVICE_CLASS -1
#endif
#ifndef SC_GL_FRAGMENT_PRECISION_HIGH
#define SC_GL_FRAGMENT_PRECISION_HIGH 0
#elif SC_GL_FRAGMENT_PRECISION_HIGH==1
#undef SC_GL_FRAGMENT_PRECISION_HIGH
#define SC_GL_FRAGMENT_PRECISION_HIGH 1
#endif
#ifndef intensityTextureHasSwappedViews
#define intensityTextureHasSwappedViews 0
#elif intensityTextureHasSwappedViews==1
#undef intensityTextureHasSwappedViews
#define intensityTextureHasSwappedViews 1
#endif
#ifndef intensityTextureLayout
#define intensityTextureLayout 0
#endif
#ifndef BLEND_MODE_REALISTIC
#define BLEND_MODE_REALISTIC 0
#elif BLEND_MODE_REALISTIC==1
#undef BLEND_MODE_REALISTIC
#define BLEND_MODE_REALISTIC 1
#endif
#ifndef BLEND_MODE_FORGRAY
#define BLEND_MODE_FORGRAY 0
#elif BLEND_MODE_FORGRAY==1
#undef BLEND_MODE_FORGRAY
#define BLEND_MODE_FORGRAY 1
#endif
#ifndef BLEND_MODE_NOTBRIGHT
#define BLEND_MODE_NOTBRIGHT 0
#elif BLEND_MODE_NOTBRIGHT==1
#undef BLEND_MODE_NOTBRIGHT
#define BLEND_MODE_NOTBRIGHT 1
#endif
#ifndef BLEND_MODE_DIVISION
#define BLEND_MODE_DIVISION 0
#elif BLEND_MODE_DIVISION==1
#undef BLEND_MODE_DIVISION
#define BLEND_MODE_DIVISION 1
#endif
#ifndef BLEND_MODE_BRIGHT
#define BLEND_MODE_BRIGHT 0
#elif BLEND_MODE_BRIGHT==1
#undef BLEND_MODE_BRIGHT
#define BLEND_MODE_BRIGHT 1
#endif
#ifndef BLEND_MODE_INTENSE
#define BLEND_MODE_INTENSE 0
#elif BLEND_MODE_INTENSE==1
#undef BLEND_MODE_INTENSE
#define BLEND_MODE_INTENSE 1
#endif
#ifndef SC_USE_UV_TRANSFORM_intensityTexture
#define SC_USE_UV_TRANSFORM_intensityTexture 0
#elif SC_USE_UV_TRANSFORM_intensityTexture==1
#undef SC_USE_UV_TRANSFORM_intensityTexture
#define SC_USE_UV_TRANSFORM_intensityTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_intensityTexture
#define SC_SOFTWARE_WRAP_MODE_U_intensityTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_intensityTexture
#define SC_SOFTWARE_WRAP_MODE_V_intensityTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_intensityTexture
#define SC_USE_UV_MIN_MAX_intensityTexture 0
#elif SC_USE_UV_MIN_MAX_intensityTexture==1
#undef SC_USE_UV_MIN_MAX_intensityTexture
#define SC_USE_UV_MIN_MAX_intensityTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_intensityTexture
#define SC_USE_CLAMP_TO_BORDER_intensityTexture 0
#elif SC_USE_CLAMP_TO_BORDER_intensityTexture==1
#undef SC_USE_CLAMP_TO_BORDER_intensityTexture
#define SC_USE_CLAMP_TO_BORDER_intensityTexture 1
#endif
#ifndef BLEND_MODE_LIGHTEN
#define BLEND_MODE_LIGHTEN 0
#elif BLEND_MODE_LIGHTEN==1
#undef BLEND_MODE_LIGHTEN
#define BLEND_MODE_LIGHTEN 1
#endif
#ifndef BLEND_MODE_DARKEN
#define BLEND_MODE_DARKEN 0
#elif BLEND_MODE_DARKEN==1
#undef BLEND_MODE_DARKEN
#define BLEND_MODE_DARKEN 1
#endif
#ifndef BLEND_MODE_DIVIDE
#define BLEND_MODE_DIVIDE 0
#elif BLEND_MODE_DIVIDE==1
#undef BLEND_MODE_DIVIDE
#define BLEND_MODE_DIVIDE 1
#endif
#ifndef BLEND_MODE_AVERAGE
#define BLEND_MODE_AVERAGE 0
#elif BLEND_MODE_AVERAGE==1
#undef BLEND_MODE_AVERAGE
#define BLEND_MODE_AVERAGE 1
#endif
#ifndef BLEND_MODE_SUBTRACT
#define BLEND_MODE_SUBTRACT 0
#elif BLEND_MODE_SUBTRACT==1
#undef BLEND_MODE_SUBTRACT
#define BLEND_MODE_SUBTRACT 1
#endif
#ifndef BLEND_MODE_DIFFERENCE
#define BLEND_MODE_DIFFERENCE 0
#elif BLEND_MODE_DIFFERENCE==1
#undef BLEND_MODE_DIFFERENCE
#define BLEND_MODE_DIFFERENCE 1
#endif
#ifndef BLEND_MODE_NEGATION
#define BLEND_MODE_NEGATION 0
#elif BLEND_MODE_NEGATION==1
#undef BLEND_MODE_NEGATION
#define BLEND_MODE_NEGATION 1
#endif
#ifndef BLEND_MODE_EXCLUSION
#define BLEND_MODE_EXCLUSION 0
#elif BLEND_MODE_EXCLUSION==1
#undef BLEND_MODE_EXCLUSION
#define BLEND_MODE_EXCLUSION 1
#endif
#ifndef BLEND_MODE_OVERLAY
#define BLEND_MODE_OVERLAY 0
#elif BLEND_MODE_OVERLAY==1
#undef BLEND_MODE_OVERLAY
#define BLEND_MODE_OVERLAY 1
#endif
#ifndef BLEND_MODE_SOFT_LIGHT
#define BLEND_MODE_SOFT_LIGHT 0
#elif BLEND_MODE_SOFT_LIGHT==1
#undef BLEND_MODE_SOFT_LIGHT
#define BLEND_MODE_SOFT_LIGHT 1
#endif
#ifndef BLEND_MODE_HARD_LIGHT
#define BLEND_MODE_HARD_LIGHT 0
#elif BLEND_MODE_HARD_LIGHT==1
#undef BLEND_MODE_HARD_LIGHT
#define BLEND_MODE_HARD_LIGHT 1
#endif
#ifndef BLEND_MODE_COLOR_DODGE
#define BLEND_MODE_COLOR_DODGE 0
#elif BLEND_MODE_COLOR_DODGE==1
#undef BLEND_MODE_COLOR_DODGE
#define BLEND_MODE_COLOR_DODGE 1
#endif
#ifndef BLEND_MODE_COLOR_BURN
#define BLEND_MODE_COLOR_BURN 0
#elif BLEND_MODE_COLOR_BURN==1
#undef BLEND_MODE_COLOR_BURN
#define BLEND_MODE_COLOR_BURN 1
#endif
#ifndef BLEND_MODE_LINEAR_LIGHT
#define BLEND_MODE_LINEAR_LIGHT 0
#elif BLEND_MODE_LINEAR_LIGHT==1
#undef BLEND_MODE_LINEAR_LIGHT
#define BLEND_MODE_LINEAR_LIGHT 1
#endif
#ifndef BLEND_MODE_VIVID_LIGHT
#define BLEND_MODE_VIVID_LIGHT 0
#elif BLEND_MODE_VIVID_LIGHT==1
#undef BLEND_MODE_VIVID_LIGHT
#define BLEND_MODE_VIVID_LIGHT 1
#endif
#ifndef BLEND_MODE_PIN_LIGHT
#define BLEND_MODE_PIN_LIGHT 0
#elif BLEND_MODE_PIN_LIGHT==1
#undef BLEND_MODE_PIN_LIGHT
#define BLEND_MODE_PIN_LIGHT 1
#endif
#ifndef BLEND_MODE_HARD_MIX
#define BLEND_MODE_HARD_MIX 0
#elif BLEND_MODE_HARD_MIX==1
#undef BLEND_MODE_HARD_MIX
#define BLEND_MODE_HARD_MIX 1
#endif
#ifndef BLEND_MODE_HARD_REFLECT
#define BLEND_MODE_HARD_REFLECT 0
#elif BLEND_MODE_HARD_REFLECT==1
#undef BLEND_MODE_HARD_REFLECT
#define BLEND_MODE_HARD_REFLECT 1
#endif
#ifndef BLEND_MODE_HARD_GLOW
#define BLEND_MODE_HARD_GLOW 0
#elif BLEND_MODE_HARD_GLOW==1
#undef BLEND_MODE_HARD_GLOW
#define BLEND_MODE_HARD_GLOW 1
#endif
#ifndef BLEND_MODE_HARD_PHOENIX
#define BLEND_MODE_HARD_PHOENIX 0
#elif BLEND_MODE_HARD_PHOENIX==1
#undef BLEND_MODE_HARD_PHOENIX
#define BLEND_MODE_HARD_PHOENIX 1
#endif
#ifndef BLEND_MODE_HUE
#define BLEND_MODE_HUE 0
#elif BLEND_MODE_HUE==1
#undef BLEND_MODE_HUE
#define BLEND_MODE_HUE 1
#endif
#ifndef BLEND_MODE_SATURATION
#define BLEND_MODE_SATURATION 0
#elif BLEND_MODE_SATURATION==1
#undef BLEND_MODE_SATURATION
#define BLEND_MODE_SATURATION 1
#endif
#ifndef BLEND_MODE_COLOR
#define BLEND_MODE_COLOR 0
#elif BLEND_MODE_COLOR==1
#undef BLEND_MODE_COLOR
#define BLEND_MODE_COLOR 1
#endif
#ifndef BLEND_MODE_LUMINOSITY
#define BLEND_MODE_LUMINOSITY 0
#elif BLEND_MODE_LUMINOSITY==1
#undef BLEND_MODE_LUMINOSITY
#define BLEND_MODE_LUMINOSITY 1
#endif
#ifndef sc_SkinBonesCount
#define sc_SkinBonesCount 0
#endif
#ifndef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#elif UseViewSpaceDepthVariant==1
#undef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#endif
#ifndef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 0
#elif sc_OITDepthGatherPass==1
#undef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 1
#endif
#ifndef sc_OITCompositingPass
#define sc_OITCompositingPass 0
#elif sc_OITCompositingPass==1
#undef sc_OITCompositingPass
#define sc_OITCompositingPass 1
#endif
#ifndef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 0
#elif sc_OITDepthBoundsPass==1
#undef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 1
#endif
#ifndef sc_OITMaxLayers4Plus1
#define sc_OITMaxLayers4Plus1 0
#elif sc_OITMaxLayers4Plus1==1
#undef sc_OITMaxLayers4Plus1
#define sc_OITMaxLayers4Plus1 1
#endif
#ifndef sc_OITMaxLayersVisualizeLayerCount
#define sc_OITMaxLayersVisualizeLayerCount 0
#elif sc_OITMaxLayersVisualizeLayerCount==1
#undef sc_OITMaxLayersVisualizeLayerCount
#define sc_OITMaxLayersVisualizeLayerCount 1
#endif
#ifndef sc_OITMaxLayers8
#define sc_OITMaxLayers8 0
#elif sc_OITMaxLayers8==1
#undef sc_OITMaxLayers8
#define sc_OITMaxLayers8 1
#endif
#ifndef sc_OITFrontLayerPass
#define sc_OITFrontLayerPass 0
#elif sc_OITFrontLayerPass==1
#undef sc_OITFrontLayerPass
#define sc_OITFrontLayerPass 1
#endif
#ifndef sc_OITDepthPrepass
#define sc_OITDepthPrepass 0
#elif sc_OITDepthPrepass==1
#undef sc_OITDepthPrepass
#define sc_OITDepthPrepass 1
#endif
#ifndef ENABLE_STIPPLE_PATTERN_TEST
#define ENABLE_STIPPLE_PATTERN_TEST 0
#elif ENABLE_STIPPLE_PATTERN_TEST==1
#undef ENABLE_STIPPLE_PATTERN_TEST
#define ENABLE_STIPPLE_PATTERN_TEST 1
#endif
#ifndef sc_ProjectiveShadowsCaster
#define sc_ProjectiveShadowsCaster 0
#elif sc_ProjectiveShadowsCaster==1
#undef sc_ProjectiveShadowsCaster
#define sc_ProjectiveShadowsCaster 1
#endif
#ifndef sc_RenderAlphaToColor
#define sc_RenderAlphaToColor 0
#elif sc_RenderAlphaToColor==1
#undef sc_RenderAlphaToColor
#define sc_RenderAlphaToColor 1
#endif
#ifndef sc_BlendMode_Custom
#define sc_BlendMode_Custom 0
#elif sc_BlendMode_Custom==1
#undef sc_BlendMode_Custom
#define sc_BlendMode_Custom 1
#endif
#ifndef colorRampTextureHasSwappedViews
#define colorRampTextureHasSwappedViews 0
#elif colorRampTextureHasSwappedViews==1
#undef colorRampTextureHasSwappedViews
#define colorRampTextureHasSwappedViews 1
#endif
#ifndef colorRampTextureLayout
#define colorRampTextureLayout 0
#endif
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef normalTexHasSwappedViews
#define normalTexHasSwappedViews 0
#elif normalTexHasSwappedViews==1
#undef normalTexHasSwappedViews
#define normalTexHasSwappedViews 1
#endif
#ifndef normalTexLayout
#define normalTexLayout 0
#endif
#ifndef sc_EnvLightMode
#define sc_EnvLightMode 0
#endif
#ifndef sc_AmbientLightMode_EnvironmentMap
#define sc_AmbientLightMode_EnvironmentMap 0
#endif
#ifndef sc_AmbientLightMode_FromCamera
#define sc_AmbientLightMode_FromCamera 0
#endif
#ifndef sc_LightEstimation
#define sc_LightEstimation 0
#elif sc_LightEstimation==1
#undef sc_LightEstimation
#define sc_LightEstimation 1
#endif
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
vec3 ambientLight;
};
#ifndef sc_LightEstimationSGCount
#define sc_LightEstimationSGCount 0
#endif
#ifndef sc_MaxTextureImageUnits
#define sc_MaxTextureImageUnits 0
#endif
#ifndef sc_HasDiffuseEnvmap
#define sc_HasDiffuseEnvmap 0
#elif sc_HasDiffuseEnvmap==1
#undef sc_HasDiffuseEnvmap
#define sc_HasDiffuseEnvmap 1
#endif
#ifndef sc_AmbientLightMode_SphericalHarmonics
#define sc_AmbientLightMode_SphericalHarmonics 0
#endif
#ifndef sc_AmbientLightsCount
#define sc_AmbientLightsCount 0
#endif
#ifndef sc_AmbientLightMode0
#define sc_AmbientLightMode0 0
#endif
#ifndef sc_AmbientLightMode_Constant
#define sc_AmbientLightMode_Constant 0
#endif
struct sc_AmbientLight_t
{
vec3 color;
float intensity;
};
#ifndef sc_AmbientLightMode1
#define sc_AmbientLightMode1 0
#endif
#ifndef sc_AmbientLightMode2
#define sc_AmbientLightMode2 0
#endif
#ifndef sc_DirectionalLightsCount
#define sc_DirectionalLightsCount 0
#endif
struct sc_DirectionalLight_t
{
vec3 direction;
vec4 color;
};
#ifndef sc_PointLightsCount
#define sc_PointLightsCount 0
#endif
struct sc_PointLight_t
{
bool falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
vec3 direction;
vec3 position;
vec4 color;
};
#ifndef PBR
#define PBR 0
#elif PBR==1
#undef PBR
#define PBR 1
#endif
#ifndef COLORMINMAX
#define COLORMINMAX 0
#elif COLORMINMAX==1
#undef COLORMINMAX
#define COLORMINMAX 1
#endif
#ifndef COLORMONOMIN
#define COLORMONOMIN 0
#elif COLORMONOMIN==1
#undef COLORMONOMIN
#define COLORMONOMIN 1
#endif
#ifndef ALPHAMINMAX
#define ALPHAMINMAX 0
#elif ALPHAMINMAX==1
#undef ALPHAMINMAX
#define ALPHAMINMAX 1
#endif
#ifndef ALPHADISSOLVE
#define ALPHADISSOLVE 0
#elif ALPHADISSOLVE==1
#undef ALPHADISSOLVE
#define ALPHADISSOLVE 1
#endif
#ifndef PREMULTIPLIEDCOLOR
#define PREMULTIPLIEDCOLOR 0
#elif PREMULTIPLIEDCOLOR==1
#undef PREMULTIPLIEDCOLOR
#define PREMULTIPLIEDCOLOR 1
#endif
#ifndef BLACKASALPHA
#define BLACKASALPHA 0
#elif BLACKASALPHA==1
#undef BLACKASALPHA
#define BLACKASALPHA 1
#endif
#ifndef SCREENFADE
#define SCREENFADE 0
#elif SCREENFADE==1
#undef SCREENFADE
#define SCREENFADE 1
#endif
#ifndef FLIPBOOK
#define FLIPBOOK 0
#elif FLIPBOOK==1
#undef FLIPBOOK
#define FLIPBOOK 1
#endif
#ifndef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 0
#elif SC_USE_UV_TRANSFORM_mainTexture==1
#undef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_mainTexture
#define SC_SOFTWARE_WRAP_MODE_U_mainTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_mainTexture
#define SC_SOFTWARE_WRAP_MODE_V_mainTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 0
#elif SC_USE_UV_MIN_MAX_mainTexture==1
#undef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 0
#elif SC_USE_CLAMP_TO_BORDER_mainTexture==1
#undef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 1
#endif
#ifndef FLIPBOOKBLEND
#define FLIPBOOKBLEND 0
#elif FLIPBOOKBLEND==1
#undef FLIPBOOKBLEND
#define FLIPBOOKBLEND 1
#endif
#ifndef FLIPBOOKBYLIFE
#define FLIPBOOKBYLIFE 0
#elif FLIPBOOKBYLIFE==1
#undef FLIPBOOKBYLIFE
#define FLIPBOOKBYLIFE 1
#endif
#ifndef COLORRAMP
#define COLORRAMP 0
#elif COLORRAMP==1
#undef COLORRAMP
#define COLORRAMP 1
#endif
#ifndef SC_USE_UV_TRANSFORM_colorRampTexture
#define SC_USE_UV_TRANSFORM_colorRampTexture 0
#elif SC_USE_UV_TRANSFORM_colorRampTexture==1
#undef SC_USE_UV_TRANSFORM_colorRampTexture
#define SC_USE_UV_TRANSFORM_colorRampTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_colorRampTexture
#define SC_SOFTWARE_WRAP_MODE_U_colorRampTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_colorRampTexture
#define SC_SOFTWARE_WRAP_MODE_V_colorRampTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_colorRampTexture
#define SC_USE_UV_MIN_MAX_colorRampTexture 0
#elif SC_USE_UV_MIN_MAX_colorRampTexture==1
#undef SC_USE_UV_MIN_MAX_colorRampTexture
#define SC_USE_UV_MIN_MAX_colorRampTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_colorRampTexture
#define SC_USE_CLAMP_TO_BORDER_colorRampTexture 0
#elif SC_USE_CLAMP_TO_BORDER_colorRampTexture==1
#undef SC_USE_CLAMP_TO_BORDER_colorRampTexture
#define SC_USE_CLAMP_TO_BORDER_colorRampTexture 1
#endif
#ifndef NORANDOFFSET
#define NORANDOFFSET 0
#elif NORANDOFFSET==1
#undef NORANDOFFSET
#define NORANDOFFSET 1
#endif
#ifndef BASETEXTURE
#define BASETEXTURE 0
#elif BASETEXTURE==1
#undef BASETEXTURE
#define BASETEXTURE 1
#endif
#ifndef WORLDPOSSEED
#define WORLDPOSSEED 0
#elif WORLDPOSSEED==1
#undef WORLDPOSSEED
#define WORLDPOSSEED 1
#endif
#ifndef NORMALTEX
#define NORMALTEX 0
#elif NORMALTEX==1
#undef NORMALTEX
#define NORMALTEX 1
#endif
#ifndef SC_USE_UV_TRANSFORM_normalTex
#define SC_USE_UV_TRANSFORM_normalTex 0
#elif SC_USE_UV_TRANSFORM_normalTex==1
#undef SC_USE_UV_TRANSFORM_normalTex
#define SC_USE_UV_TRANSFORM_normalTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_normalTex
#define SC_SOFTWARE_WRAP_MODE_U_normalTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_normalTex
#define SC_SOFTWARE_WRAP_MODE_V_normalTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_normalTex
#define SC_USE_UV_MIN_MAX_normalTex 0
#elif SC_USE_UV_MIN_MAX_normalTex==1
#undef SC_USE_UV_MIN_MAX_normalTex
#define SC_USE_UV_MIN_MAX_normalTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_normalTex
#define SC_USE_CLAMP_TO_BORDER_normalTex 0
#elif SC_USE_CLAMP_TO_BORDER_normalTex==1
#undef SC_USE_CLAMP_TO_BORDER_normalTex
#define SC_USE_CLAMP_TO_BORDER_normalTex 1
#endif
#ifndef MESHTYPE
#define MESHTYPE 0
#endif
#ifndef sc_DepthOnly
#define sc_DepthOnly 0
#elif sc_DepthOnly==1
#undef sc_DepthOnly
#define sc_DepthOnly 1
#endif
struct sc_Camera_t
{
vec3 position;
float aspect;
vec2 clipPlanes;
};
uniform vec4 sc_EnvmapDiffuseDims;
uniform vec4 sc_EnvmapSpecularDims;
uniform vec4 sc_ScreenTextureDims;
uniform vec4 sc_WindowToViewportTransform;
uniform mat4 sc_ProjectionMatrixArray[sc_NumStereoViews];
uniform float sc_ShadowDensity;
uniform vec4 sc_ShadowColor;
uniform float shaderComplexityValue;
uniform float _sc_framebufferFetchMarker;
uniform float _sc_GetFramebufferColorInvalidUsageMarker;
uniform mat4 sc_ViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameModelMatrix;
uniform mat4 sc_ModelMatrixInverse;
uniform vec4 intensityTextureDims;
uniform float correctedIntensity;
uniform mat3 intensityTextureTransform;
uniform vec4 intensityTextureUvMinMax;
uniform vec4 intensityTextureBorderColor;
uniform float alphaTestThreshold;
uniform vec4 velRampTextureDims;
uniform vec4 sizeRampTextureDims;
uniform vec4 colorRampTextureDims;
uniform vec4 mainTextureDims;
uniform vec4 normalTexDims;
uniform sc_LightEstimationData_t sc_LightEstimationData;
uniform vec3 sc_EnvmapRotation;
uniform vec4 sc_EnvmapSpecularSize;
uniform vec4 sc_EnvmapDiffuseSize;
uniform float sc_EnvmapExposure;
uniform vec3 sc_Sh[9];
uniform float sc_ShIntensity;
uniform sc_AmbientLight_t sc_AmbientLights[(sc_AmbientLightsCount+1)];
uniform sc_DirectionalLight_t sc_DirectionalLights[(sc_DirectionalLightsCount+1)];
uniform sc_PointLight_t sc_PointLights[(sc_PointLightsCount+1)];
uniform mat3 mainTextureTransform;
uniform vec4 mainTextureUvMinMax;
uniform vec4 mainTextureBorderColor;
uniform mat3 colorRampTextureTransform;
uniform vec4 colorRampTextureUvMinMax;
uniform vec4 colorRampTextureBorderColor;
uniform mat4 sc_ModelMatrix;
uniform vec3 colorStart;
uniform vec3 colorEnd;
uniform vec3 colorMinStart;
uniform vec3 colorMinEnd;
uniform vec3 colorMaxStart;
uniform vec3 colorMaxEnd;
uniform float alphaStart;
uniform float alphaEnd;
uniform float alphaMinStart;
uniform float alphaMinEnd;
uniform float alphaMaxStart;
uniform float alphaMaxEnd;
uniform float alphaDissolveMult;
uniform float numValidFrames;
uniform vec2 gridSize;
uniform float flipBookSpeedMult;
uniform float flipBookRandomStart;
uniform vec4 colorRampTextureSize;
uniform vec4 colorRampMult;
uniform float externalSeed;
uniform mat3 normalTexTransform;
uniform vec4 normalTexUvMinMax;
uniform vec4 normalTexBorderColor;
uniform float metallic;
uniform float roughness;
uniform vec3 Port_Default_N167;
uniform vec3 Port_Emissive_N014;
uniform vec3 Port_AO_N014;
uniform vec3 Port_SpecularAO_N014;
uniform int overrideTimeEnabled;
uniform float overrideTimeElapsed;
uniform vec4 sc_Time;
uniform float overrideTimeDelta;
uniform sc_Camera_t sc_Camera;
uniform int PreviewEnabled;
uniform vec4 sc_EnvmapDiffuseView;
uniform vec4 sc_EnvmapSpecularView;
uniform vec4 sc_UniformConstants;
uniform vec4 sc_GeometryInfo;
uniform mat4 sc_ModelViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ViewProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewMatrixInverseArray[sc_NumStereoViews];
uniform mat3 sc_ViewNormalMatrixArray[sc_NumStereoViews];
uniform mat3 sc_ViewNormalMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ViewMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ViewMatrixInverseArray[sc_NumStereoViews];
uniform mat3 sc_NormalMatrix;
uniform mat3 sc_NormalMatrixInverse;
uniform mat4 sc_PrevFrameModelMatrixInverse;
uniform vec3 sc_LocalAabbMin;
uniform vec3 sc_LocalAabbMax;
uniform vec3 sc_WorldAabbMin;
uniform vec3 sc_WorldAabbMax;
uniform mat4 sc_ProjectorMatrix;
uniform float sc_DisableFrustumCullingMarker;
uniform vec4 sc_BoneMatrices[((sc_SkinBonesCount*3)+1)];
uniform mat3 sc_SkinBonesNormalMatrices[(sc_SkinBonesCount+1)];
uniform vec4 weights0;
uniform vec4 weights1;
uniform vec4 weights2;
uniform vec4 sc_StereoClipPlanes[sc_NumStereoViews];
uniform int sc_FallbackInstanceID;
uniform vec2 sc_TAAJitterOffset;
uniform float strandWidth;
uniform float strandTaper;
uniform vec4 sc_StrandDataMapTextureSize;
uniform float clumpInstanceCount;
uniform float clumpRadius;
uniform float clumpTipScale;
uniform float hairstyleInstanceCount;
uniform float hairstyleNoise;
uniform vec4 sc_ScreenTextureSize;
uniform vec4 sc_ScreenTextureView;
uniform vec4 intensityTextureSize;
uniform vec4 intensityTextureView;
uniform float reflBlurWidth;
uniform float reflBlurMinRough;
uniform float reflBlurMaxRough;
uniform int PreviewNodeID;
uniform float timeGlobal;
uniform float externalTimeInput;
uniform float lifeTimeConstant;
uniform vec2 lifeTimeMinMax;
uniform float spawnDuration;
uniform vec3 spawnLocation;
uniform vec3 spawnBox;
uniform vec3 spawnSphere;
uniform vec3 noiseMult;
uniform vec3 noiseFrequency;
uniform vec3 sNoiseMult;
uniform vec3 sNoiseFrequency;
uniform vec3 velocityMin;
uniform vec3 velocityMax;
uniform vec3 velocityDrag;
uniform vec4 velRampTextureSize;
uniform vec4 velRampTextureView;
uniform mat3 velRampTextureTransform;
uniform vec4 velRampTextureUvMinMax;
uniform vec4 velRampTextureBorderColor;
uniform vec2 sizeStart;
uniform vec3 sizeStart3D;
uniform vec2 sizeEnd;
uniform vec3 sizeEnd3D;
uniform vec2 sizeStartMin;
uniform vec3 sizeStartMin3D;
uniform vec2 sizeStartMax;
uniform vec3 sizeStartMax3D;
uniform vec2 sizeEndMin;
uniform vec3 sizeEndMin3D;
uniform vec2 sizeEndMax;
uniform vec3 sizeEndMax3D;
uniform float sizeSpeed;
uniform vec4 sizeRampTextureSize;
uniform vec4 sizeRampTextureView;
uniform mat3 sizeRampTextureTransform;
uniform vec4 sizeRampTextureUvMinMax;
uniform vec4 sizeRampTextureBorderColor;
uniform float gravity;
uniform vec3 localForce;
uniform float sizeVelScale;
uniform bool ALIGNTOX;
uniform bool ALIGNTOY;
uniform bool ALIGNTOZ;
uniform vec2 rotationRandomX;
uniform vec2 rotationRateX;
uniform vec2 randomRotationY;
uniform vec2 rotationRateY;
uniform vec2 rotationRandom;
uniform vec2 randomRotationZ;
uniform vec2 rotationRate;
uniform vec2 rotationRateZ;
uniform float rotationDrag;
uniform bool CENTER_BBOX;
uniform float fadeDistanceVisible;
uniform float fadeDistanceInvisible;
uniform vec4 colorRampTextureView;
uniform vec4 mainTextureSize;
uniform vec4 mainTextureView;
uniform vec4 normalTexSize;
uniform vec4 normalTexView;
uniform float Port_Input1_N119;
uniform vec2 Port_Input1_N138;
uniform vec2 Port_Input1_N139;
uniform vec2 Port_Input1_N140;
uniform vec2 Port_Input1_N144;
uniform float Port_Input1_N069;
uniform float Port_Input1_N068;
uniform float Port_Input1_N110;
uniform float Port_Input1_N154;
uniform sampler2D mainTexture;
uniform sampler2D colorRampTexture;
uniform sampler2D normalTex;
uniform sampler2D sc_SSAOTexture;
uniform sampler2D sc_ShadowTexture;
uniform sampler2D sc_EnvmapSpecular;
uniform sampler2D sc_EnvmapDiffuse;
uniform sampler2D sc_ScreenTexture;
uniform sampler2D intensityTexture;
uniform sampler2D sc_OITFrontDepthTexture;
uniform sampler2D sc_OITDepthHigh0;
uniform sampler2D sc_OITDepthLow0;
uniform sampler2D sc_OITAlpha0;
uniform sampler2D sc_OITDepthHigh1;
uniform sampler2D sc_OITDepthLow1;
uniform sampler2D sc_OITAlpha1;
uniform sampler2D sc_OITFilteredDepthBoundsTexture;
varying float varStereoViewID;
varying vec2 varShadowTex;
varying float varClipDistance;
varying float varViewSpaceDepth;
varying vec4 Interpolator0;
varying vec4 Interpolator1;
varying vec4 PreviewVertexColor;
varying float PreviewVertexSaved;
varying vec3 varPos;
varying vec4 varTangent;
varying vec3 varNormal;
varying vec4 varPackedTex;
varying float Interpolator_gInstanceID;
varying vec4 varScreenPos;
varying vec2 varScreenTexturePos;
varying vec4 varColor;
vec3 N2_colorStart;
vec3 N2_colorEnd;
bool N2_ENABLE_COLORMINMAX;
vec3 N2_colorMinStart;
vec3 N2_colorMinEnd;
vec3 N2_colorMaxStart;
vec3 N2_colorMaxEnd;
bool N2_ENABLE_COLORMONOMIN;
float N2_alphaStart;
float N2_alphaEnd;
bool N2_ENABLE_ALPHAMINMAX;
float N2_alphaMinStart;
float N2_alphaMinEnd;
float N2_alphaMaxStart;
float N2_alphaMaxEnd;
bool N2_ENABLE_ALPHADISSOLVE;
float N2_alphaDissolveMult;
bool N2_ENABLE_PREMULTIPLIEDCOLOR;
bool N2_ENABLE_BLACKASALPHA;
bool N2_ENABLE_SCREENFADE;
float N2_nearCameraFade;
bool N2_ENABLE_FLIPBOOK;
float N2_numValidFrames;
vec2 N2_gridSize;
float N2_flipBookSpeedMult;
float N2_flipBookRandomStart;
bool N2_ENABLE_FLIPBOOKBLEND;
bool N2_ENABLE_FLIPBOOKBYLIFE;
bool N2_ENABLE_COLORRAMP;
vec2 N2_texSize;
vec4 N2_colorRampMult;
bool N2_ENABLE_NORANDOFFSET;
bool N2_ENABLE_BASETEXTURE;
vec4 N2_timeValuesIn;
bool N2_ENABLE_WORLDPOSSEED;
float N2_externalSeed;
vec3 N2_particleSeed;
float N2_globalSeed;
vec4 N2_timeValues;
vec4 N2_result;
vec2 N2_uv;
ssGlobals tempGlobals;
void Node77_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (COLORMINMAX)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node106_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (COLORMONOMIN)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node84_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (ALPHAMINMAX)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node72_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (ALPHADISSOLVE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node75_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (PREMULTIPLIEDCOLOR)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node74_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (BLACKASALPHA)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node175_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (SCREENFADE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node62_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (FLIPBOOK)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node92_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (FLIPBOOKBLEND)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node91_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (FLIPBOOKBYLIFE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node29_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (COLORRAMP)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node60_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (NORANDOFFSET)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node28_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (BASETEXTURE)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
void Node8_Bool_Parameter(out float Output,ssGlobals Globals)
{
#if (WORLDPOSSEED)
{
Output=1.001;
}
#else
{
Output=0.001;
}
#endif
Output-=0.001;
}
int sc_GetStereoViewIndex()
{
int l9_0;
#if (sc_StereoRenderingMode==0)
{
l9_0=0;
}
#else
{
l9_0=int(varStereoViewID);
}
#endif
return l9_0;
}
int mainTextureGetStereoViewIndex()
{
int l9_0;
#if (mainTextureHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
void sc_SoftwareWrapEarly(inout float uv,int softwareWrapMode)
{
if (softwareWrapMode==1)
{
uv=fract(uv);
}
else
{
if (softwareWrapMode==2)
{
float l9_0=fract(uv);
uv=mix(l9_0,1.0-l9_0,clamp(step(0.25,fract((uv-l9_0)*0.5)),0.0,1.0));
}
}
}
void sc_ClampUV(inout float value,float minValue,float maxValue,bool useClampToBorder,inout float clampToBorderFactor)
{
float l9_0=clamp(value,minValue,maxValue);
float l9_1=step(abs(value-l9_0),9.9999997e-06);
clampToBorderFactor*=(l9_1+((1.0-float(useClampToBorder))*(1.0-l9_1)));
value=l9_0;
}
vec2 sc_TransformUV(vec2 uv,bool useUvTransform,mat3 uvTransform)
{
if (useUvTransform)
{
uv=vec2((uvTransform*vec3(uv,1.0)).xy);
}
return uv;
}
void sc_SoftwareWrapLate(inout float uv,int softwareWrapMode,bool useClampToBorder,inout float clampToBorderFactor)
{
if ((softwareWrapMode==0)||(softwareWrapMode==3))
{
sc_ClampUV(uv,0.0,1.0,useClampToBorder,clampToBorderFactor);
}
}
vec3 sc_SamplingCoordsViewToGlobal(vec2 uv,int renderingLayout,int viewIndex)
{
vec3 l9_0;
if (renderingLayout==0)
{
l9_0=vec3(uv,0.0);
}
else
{
vec3 l9_1;
if (renderingLayout==1)
{
l9_1=vec3(uv.x,(uv.y*0.5)+(0.5-(float(viewIndex)*0.5)),0.0);
}
else
{
l9_1=vec3(uv,float(viewIndex));
}
l9_0=l9_1;
}
return l9_0;
}
vec4 sc_SampleView(vec2 texSize,vec2 uv,int renderingLayout,int viewIndex,float bias,sampler2D texsmp)
{
return texture2D(texsmp,sc_SamplingCoordsViewToGlobal(uv,renderingLayout,viewIndex).xy,bias);
}
vec4 sc_SampleTextureBiasOrLevel(vec2 samplerDims,int renderingLayout,int viewIndex,vec2 uv,bool useUvTransform,mat3 uvTransform,ivec2 softwareWrapModes,bool useUvMinMax,vec4 uvMinMax,bool useClampToBorder,vec4 borderColor,float biasOrLevel,sampler2D texture_sampler_)
{
bool l9_0=useClampToBorder;
bool l9_1=useUvMinMax;
bool l9_2=l9_0&&(!l9_1);
sc_SoftwareWrapEarly(uv.x,softwareWrapModes.x);
sc_SoftwareWrapEarly(uv.y,softwareWrapModes.y);
float l9_3;
if (useUvMinMax)
{
bool l9_4=useClampToBorder;
bool l9_5;
if (l9_4)
{
l9_5=softwareWrapModes.x==3;
}
else
{
l9_5=l9_4;
}
float param_8=1.0;
sc_ClampUV(uv.x,uvMinMax.x,uvMinMax.z,l9_5,param_8);
float l9_6=param_8;
bool l9_7=useClampToBorder;
bool l9_8;
if (l9_7)
{
l9_8=softwareWrapModes.y==3;
}
else
{
l9_8=l9_7;
}
float param_13=l9_6;
sc_ClampUV(uv.y,uvMinMax.y,uvMinMax.w,l9_8,param_13);
l9_3=param_13;
}
else
{
l9_3=1.0;
}
uv=sc_TransformUV(uv,useUvTransform,uvTransform);
float param_20=l9_3;
sc_SoftwareWrapLate(uv.x,softwareWrapModes.x,l9_2,param_20);
sc_SoftwareWrapLate(uv.y,softwareWrapModes.y,l9_2,param_20);
float l9_9=param_20;
vec4 l9_10=sc_SampleView(samplerDims,uv,renderingLayout,viewIndex,biasOrLevel,texture_sampler_);
vec4 l9_11;
if (useClampToBorder)
{
l9_11=mix(borderColor,l9_10,vec4(l9_9));
}
else
{
l9_11=l9_10;
}
return l9_11;
}
vec4 N2_mainTexture_sample(vec2 coords)
{
return sc_SampleTextureBiasOrLevel(mainTextureDims.xy,mainTextureLayout,mainTextureGetStereoViewIndex(),coords,(int(SC_USE_UV_TRANSFORM_mainTexture)!=0),mainTextureTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture),(int(SC_USE_UV_MIN_MAX_mainTexture)!=0),mainTextureUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0),mainTextureBorderColor,0.0,mainTexture);
}
int colorRampTextureGetStereoViewIndex()
{
int l9_0;
#if (colorRampTextureHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
vec4 N2_colorRampTexture_sample(vec2 coords)
{
return sc_SampleTextureBiasOrLevel(colorRampTextureDims.xy,colorRampTextureLayout,colorRampTextureGetStereoViewIndex(),coords,(int(SC_USE_UV_TRANSFORM_colorRampTexture)!=0),colorRampTextureTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture,SC_SOFTWARE_WRAP_MODE_V_colorRampTexture),(int(SC_USE_UV_MIN_MAX_colorRampTexture)!=0),colorRampTextureUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_colorRampTexture)!=0),colorRampTextureBorderColor,0.0,colorRampTexture);
}
void N2_main()
{
float l9_0;
if (N2_ENABLE_WORLDPOSSEED)
{
l9_0=length(vec4(1.0)*sc_ModelMatrix);
}
else
{
l9_0=0.0;
}
N2_globalSeed=N2_externalSeed+l9_0;
float l9_1=float(int(tempGlobals.gInstanceID));
N2_particleSeed=floor(fract(sin(vec3(0.457831,0.62343299,0.97625297)*dot(vec2(mod(l9_1,2000.0),floor(l9_1/2000.0))/vec2(2000.0),vec2(0.38253,0.42662001)))*vec3(479.371,389.53101,513.03497))*10000.0)*9.9999997e-05;
float l9_2=N2_particleSeed.x;
float l9_3=N2_particleSeed.y;
float l9_4=N2_particleSeed.z;
float l9_5=N2_globalSeed;
vec3 l9_6;
if (N2_ENABLE_COLORMONOMIN)
{
l9_6=fract((vec3(l9_2)*27.21883)+vec3(N2_globalSeed));
}
else
{
l9_6=fract((vec3(l9_2,l9_3,l9_4)*27.21883)+vec3(l9_5));
}
float l9_7=N2_particleSeed.x;
float l9_8=N2_globalSeed;
float l9_9=fract((l9_7*3121.3333)+l9_8);
float l9_10=N2_particleSeed.y;
float l9_11=N2_globalSeed;
float l9_12=N2_particleSeed.z;
float l9_13=N2_globalSeed;
float l9_14=N2_timeValuesIn.w;
vec3 l9_15;
vec3 l9_16;
if (N2_ENABLE_COLORMINMAX)
{
l9_16=mix(N2_colorMinEnd,N2_colorMaxEnd,l9_6);
l9_15=mix(N2_colorMinStart,N2_colorMaxStart,l9_6);
}
else
{
l9_16=N2_colorEnd;
l9_15=N2_colorStart;
}
float l9_17;
float l9_18;
if (N2_ENABLE_ALPHAMINMAX)
{
l9_18=mix(N2_alphaMinEnd,N2_alphaMaxEnd,l9_9);
l9_17=mix(N2_alphaMinStart,N2_alphaMaxStart,l9_9);
}
else
{
l9_18=N2_alphaEnd;
l9_17=N2_alphaStart;
}
vec3 l9_19=mix(l9_15,l9_16,vec3(l9_14));
float l9_20=mix(l9_17,l9_18,l9_14);
vec2 l9_21=tempGlobals.Surface_UVCoord0;
float l9_22=N2_timeValuesIn.x;
float l9_23=N2_timeValuesIn.y;
float l9_24=N2_timeValuesIn.z;
float l9_25;
if (N2_ENABLE_FLIPBOOKBYLIFE)
{
l9_25=N2_timeValuesIn.z/mix(max(l9_22,0.0099999998),max(l9_23,0.0099999998),fract((l9_12*3.5358)+l9_13));
}
else
{
l9_25=l9_24;
}
float l9_26=N2_flipBookRandomStart;
vec2 l9_27=N2_gridSize;
vec2 l9_28=l9_21/l9_27;
float l9_29=N2_flipBookSpeedMult;
float l9_30=l9_25*l9_29;
float l9_31=N2_numValidFrames;
float l9_32=mod(l9_30+mix(0.0,l9_26,fract((l9_10*13.2234)+l9_11)),l9_31);
float l9_33=N2_gridSize.x;
float l9_34=N2_gridSize.x;
float l9_35=N2_gridSize.y;
float l9_36=N2_gridSize.y;
float l9_37=N2_numValidFrames;
float l9_38=mod(l9_32+1.0,l9_37);
float l9_39=N2_gridSize.x;
float l9_40=N2_gridSize.x;
float l9_41=N2_gridSize.y;
vec2 l9_42=l9_28+vec2(floor(l9_32)*(1.0/l9_33),mod(floor((-l9_32)/l9_34),l9_35)*(1.0/l9_36));
vec4 l9_43;
if (N2_ENABLE_FLIPBOOKBLEND)
{
l9_43=mix(N2_mainTexture_sample(l9_42),N2_mainTexture_sample(l9_28+vec2(floor(l9_38)*(1.0/l9_39),floor((-l9_38)*(1.0/l9_40))*(1.0/l9_41))),vec4(fract(l9_32)));
}
else
{
l9_43=N2_mainTexture_sample(l9_42);
}
float l9_44=N2_texSize.x;
float l9_45=N2_texSize.x;
float l9_46=ceil(l9_14*l9_44)/l9_45;
float l9_47;
if (N2_ENABLE_NORANDOFFSET)
{
l9_47=l9_46+(tempGlobals.Surface_UVCoord0.x/N2_texSize.x);
}
else
{
l9_47=l9_46;
}
vec4 l9_48=N2_colorRampTexture_sample(vec2(l9_47,0.5));
vec4 l9_49=N2_colorRampMult;
vec4 l9_50;
if (N2_ENABLE_BASETEXTURE)
{
vec4 l9_51=N2_mainTexture_sample(tempGlobals.Surface_UVCoord0);
N2_uv=tempGlobals.Surface_UVCoord0;
vec4 l9_52;
if (N2_ENABLE_FLIPBOOK)
{
N2_uv=l9_42;
l9_52=l9_43;
}
else
{
l9_52=l9_51;
}
l9_50=l9_52;
}
else
{
l9_50=vec4(1.0);
}
vec4 l9_53;
if (N2_ENABLE_COLORRAMP)
{
vec4 l9_54;
#if (!(!((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)))
{
l9_54=l9_48*l9_49;
}
#else
{
l9_54=vec4(1.0);
}
#endif
l9_53=l9_54;
}
else
{
l9_53=vec4(1.0);
}
N2_result=(l9_50*vec4(l9_19,l9_20))*l9_53;
if (N2_ENABLE_SCREENFADE)
{
N2_result.w*=N2_nearCameraFade;
}
if (N2_ENABLE_ALPHADISSOLVE)
{
N2_result.w=clamp(N2_result.w-(l9_14*N2_alphaDissolveMult),0.0,1.0);
}
if (N2_ENABLE_BLACKASALPHA)
{
N2_result.w=length(N2_result.xyz);
}
if (N2_ENABLE_PREMULTIPLIEDCOLOR)
{
vec3 l9_55=N2_result.xyz*N2_result.w;
N2_result=vec4(l9_55.x,l9_55.y,l9_55.z,N2_result.w);
}
N2_timeValues=N2_timeValuesIn;
}
void Node2_Pixel_Shader_Particles(vec3 colorStart_1,vec3 colorEnd_1,float ENABLE_COLORMINMAX,vec3 colorMinStart_1,vec3 colorMinEnd_1,vec3 colorMaxStart_1,vec3 colorMaxEnd_1,float ENABLE_COLORMONOMIN,float alphaStart_1,float alphaEnd_1,float ENABLE_ALPHAMINMAX,float alphaMinStart_1,float alphaMinEnd_1,float alphaMaxStart_1,float alphaMaxEnd_1,float ENABLE_ALPHADISSOLVE,float alphaDissolveMult_1,float ENABLE_PREMULTIPLIEDCOLOR,float ENABLE_BLACKASALPHA,float ENABLE_SCREENFADE,float nearCameraFade,float ENABLE_FLIPBOOK,float numValidFrames_1,vec2 gridSize_1,float flipBookSpeedMult_1,float flipBookRandomStart_1,float ENABLE_FLIPBOOKBLEND,float ENABLE_FLIPBOOKBYLIFE,float ENABLE_COLORRAMP,vec2 texSize,vec4 colorRampMult_1,float ENABLE_NORANDOFFSET,float ENABLE_BASETEXTURE,vec4 timeValuesIn,float ENABLE_WORLDPOSSEED,float externalSeed_1,out vec3 particleSeed,out float globalSeed,out vec4 timeValues,out vec4 result,out vec2 uv,ssGlobals Globals)
{
tempGlobals=Globals;
particleSeed=vec3(0.0);
globalSeed=0.0;
timeValues=vec4(0.0);
result=vec4(0.0);
uv=vec2(0.0);
N2_colorStart=colorStart_1;
N2_colorEnd=colorEnd_1;
N2_ENABLE_COLORMINMAX=(int(COLORMINMAX)!=0);
N2_colorMinStart=colorMinStart_1;
N2_colorMinEnd=colorMinEnd_1;
N2_colorMaxStart=colorMaxStart_1;
N2_colorMaxEnd=colorMaxEnd_1;
N2_ENABLE_COLORMONOMIN=(int(COLORMONOMIN)!=0);
N2_alphaStart=alphaStart_1;
N2_alphaEnd=alphaEnd_1;
N2_ENABLE_ALPHAMINMAX=(int(ALPHAMINMAX)!=0);
N2_alphaMinStart=alphaMinStart_1;
N2_alphaMinEnd=alphaMinEnd_1;
N2_alphaMaxStart=alphaMaxStart_1;
N2_alphaMaxEnd=alphaMaxEnd_1;
N2_ENABLE_ALPHADISSOLVE=(int(ALPHADISSOLVE)!=0);
N2_alphaDissolveMult=alphaDissolveMult_1;
N2_ENABLE_PREMULTIPLIEDCOLOR=(int(PREMULTIPLIEDCOLOR)!=0);
N2_ENABLE_BLACKASALPHA=(int(BLACKASALPHA)!=0);
N2_ENABLE_SCREENFADE=(int(SCREENFADE)!=0);
N2_nearCameraFade=nearCameraFade;
N2_ENABLE_FLIPBOOK=(int(FLIPBOOK)!=0);
N2_numValidFrames=numValidFrames_1;
N2_gridSize=gridSize_1;
N2_flipBookSpeedMult=flipBookSpeedMult_1;
N2_flipBookRandomStart=flipBookRandomStart_1;
N2_ENABLE_FLIPBOOKBLEND=(int(FLIPBOOKBLEND)!=0);
N2_ENABLE_FLIPBOOKBYLIFE=(int(FLIPBOOKBYLIFE)!=0);
N2_ENABLE_COLORRAMP=(int(COLORRAMP)!=0);
N2_texSize=texSize;
N2_colorRampMult=colorRampMult_1;
N2_ENABLE_NORANDOFFSET=(int(NORANDOFFSET)!=0);
N2_ENABLE_BASETEXTURE=(int(BASETEXTURE)!=0);
N2_timeValuesIn=timeValuesIn;
N2_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED)!=0);
N2_externalSeed=externalSeed_1;
N2_main();
particleSeed=N2_particleSeed;
globalSeed=N2_globalSeed;
timeValues=N2_timeValues;
result=N2_result;
uv=N2_uv;
}
vec3 ssSRGB_to_Linear(vec3 value)
{
vec3 l9_0;
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
l9_0=vec3(pow(value.x,2.2),pow(value.y,2.2),pow(value.z,2.2));
}
#else
{
l9_0=value*value;
}
#endif
return l9_0;
}
vec3 evaluateSSAO(vec3 positionWS)
{
#if (sc_SSAOEnabled)
{
vec4 l9_0=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(positionWS,1.0);
return vec3(texture2D(sc_SSAOTexture,((l9_0.xyz/vec3(l9_0.w)).xy*0.5)+vec2(0.5)).x);
}
#else
{
return vec3(1.0);
}
#endif
}
vec3 fresnelSchlickSub(float cosTheta,vec3 F0,vec3 fresnelMax)
{
float l9_0=1.0-cosTheta;
float l9_1=l9_0*l9_0;
return F0+((fresnelMax-F0)*((l9_1*l9_1)*l9_0));
}
float Dggx(float NdotH,float roughness_1)
{
float l9_0=roughness_1*roughness_1;
float l9_1=l9_0*l9_0;
float l9_2=((NdotH*NdotH)*(l9_1-1.0))+1.0;
return l9_1/((l9_2*l9_2)+9.9999999e-09);
}
vec3 calculateDirectSpecular(SurfaceProperties surfaceProperties,vec3 L,vec3 V)
{
float l9_0=surfaceProperties.roughness;
float l9_1=max(l9_0,0.029999999);
vec3 l9_2=surfaceProperties.specColor;
vec3 l9_3=surfaceProperties.normal;
vec3 l9_4=L;
vec3 l9_5=V;
vec3 l9_6=normalize(l9_4+l9_5);
vec3 l9_7=L;
float l9_8=clamp(dot(l9_3,l9_7),0.0,1.0);
vec3 l9_9=V;
float l9_10=clamp(dot(l9_3,l9_6),0.0,1.0);
vec3 l9_11=V;
float l9_12=clamp(dot(l9_11,l9_6),0.0,1.0);
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
float l9_13=l9_1+1.0;
float l9_14=(l9_13*l9_13)*0.125;
float l9_15=1.0-l9_14;
return fresnelSchlickSub(l9_12,l9_2,vec3(1.0))*(((Dggx(l9_10,l9_1)*(1.0/(((l9_8*l9_15)+l9_14)*((clamp(dot(l9_3,l9_9),0.0,1.0)*l9_15)+l9_14))))*0.25)*l9_8);
}
#else
{
float l9_16=exp2(11.0-(10.0*l9_1));
return ((fresnelSchlickSub(l9_12,l9_2,vec3(1.0))*((l9_16*0.125)+0.25))*pow(l9_10,l9_16))*l9_8;
}
#endif
}
LightingComponents accumulateLight(LightingComponents lighting,LightProperties light,SurfaceProperties surfaceProperties,vec3 V)
{
lighting.directDiffuse+=((vec3(clamp(dot(surfaceProperties.normal,light.direction),0.0,1.0))*light.color)*light.attenuation);
lighting.directSpecular+=((calculateDirectSpecular(surfaceProperties,light.direction,V)*light.color)*light.attenuation);
return lighting;
}
float computeDistanceAttenuation(float distanceToLight,float falloffEndDistance)
{
float l9_0=distanceToLight;
float l9_1=distanceToLight;
float l9_2=l9_0*l9_1;
if (falloffEndDistance==0.0)
{
return 1.0/l9_2;
}
return max(min(1.0-((l9_2*l9_2)/pow(falloffEndDistance,4.0)),1.0),0.0)/l9_2;
}
vec2 calcPanoramicTexCoordsFromDir(vec3 reflDir,float rotationDegrees)
{
float l9_0=-reflDir.z;
vec2 l9_1=vec2((((reflDir.x<0.0) ? (-1.0) : 1.0)*acos(clamp(l9_0/length(vec2(reflDir.x,l9_0)),-1.0,1.0)))-1.5707964,acos(reflDir.y))/vec2(6.2831855,3.1415927);
float l9_2=l9_1.x+(rotationDegrees/360.0);
vec2 l9_3=vec2(l9_2,1.0-l9_1.y);
l9_3.x=fract((l9_2+floor(l9_2))+1.0);
return l9_3;
}
int sc_EnvmapSpecularGetStereoViewIndex()
{
int l9_0;
#if (sc_EnvmapSpecularHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
vec4 sc_EnvmapSpecularSampleViewIndexBias(vec2 uv,int viewIndex,float bias)
{
return sc_SampleView(sc_EnvmapSpecularDims.xy,uv,sc_EnvmapSpecularLayout,viewIndex,bias,sc_EnvmapSpecular);
}
vec2 calcSeamlessPanoramicUvsForSampling(vec2 uv,vec2 topMipRes,float lod)
{
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
vec2 l9_0=max(vec2(1.0),topMipRes/vec2(exp2(lod)));
return ((uv*(l9_0-vec2(1.0)))/l9_0)+(vec2(0.5)/l9_0);
}
#else
{
return uv;
}
#endif
}
vec3 getSpecularDominantDir(vec3 N,vec3 R,float roughness_1)
{
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
return normalize(mix(R,N,vec3((roughness_1*roughness_1)*roughness_1)));
}
#else
{
return R;
}
#endif
}
float sc_InternalCalculateSampleBias(vec2 texSize,vec2 uv,float level_)
{
float l9_0;
#if (sc_CanUseStandardDerivatives)
{
vec2 l9_1=uv*texSize;
float l9_2=l9_1.x;
float l9_3=l9_1.y;
l9_0=level_-log2(max(max(abs(dFdx(l9_2)),abs(dFdy(l9_2))),max(abs(dFdx(l9_3)),abs(dFdy(l9_3)))));
}
#else
{
l9_0=0.0;
}
#endif
return l9_0;
}
vec4 sc_InternalTextureLevel(vec2 texSize,vec2 uv,float level_,sampler2D texsmp)
{
vec4 l9_0;
#if (sc_CanUseTextureLod)
{
l9_0=texture2DLod(texsmp,uv,level_);
}
#else
{
vec4 l9_1;
#if (sc_CanUseStandardDerivatives)
{
l9_1=texture2D(texsmp,uv,sc_InternalCalculateSampleBias(texSize,uv,level_));
}
#else
{
l9_1=vec4(0.0);
}
#endif
l9_0=l9_1;
}
#endif
return l9_0;
}
vec4 sc_SampleViewLevel(vec2 texSize,vec2 uv,int renderingLayout,int viewIndex,float level_,sampler2D texsmp)
{
return sc_InternalTextureLevel(texSize,sc_SamplingCoordsViewToGlobal(uv,renderingLayout,viewIndex).xy,level_,texsmp);
}
vec4 sc_EnvmapSpecularSampleViewIndexLevel(vec2 uv,int viewIndex,float level_)
{
vec4 l9_0;
#if (sc_CanUseTextureLod)
{
l9_0=sc_SampleViewLevel(sc_EnvmapSpecularDims.xy,uv,sc_EnvmapSpecularLayout,viewIndex,level_,sc_EnvmapSpecular);
}
#else
{
l9_0=vec4(0.0);
}
#endif
return l9_0;
}
vec3 envBRDFApprox(SurfaceProperties surfaceProperties,float NdotV)
{
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
vec4 l9_0=(vec4(-1.0,-0.0275,-0.57200003,0.022)*surfaceProperties.roughness)+vec4(1.0,0.0425,1.04,-0.039999999);
float l9_1=l9_0.x;
vec2 l9_2=(vec2(-1.04,1.04)*((min(l9_1*l9_1,exp2((-9.2799997)*NdotV))*l9_1)+l9_0.y))+l9_0.zw;
return max((surfaceProperties.specColor*l9_2.x)+vec3(l9_2.y),vec3(0.0));
}
#else
{
return fresnelSchlickSub(NdotV,surfaceProperties.specColor,max(vec3(1.0-surfaceProperties.roughness),surfaceProperties.specColor));
}
#endif
}
vec2 sc_SamplingCoordsGlobalToView(vec3 uvi,int renderingLayout,int viewIndex)
{
if (renderingLayout==1)
{
uvi.y=((2.0*uvi.y)+float(viewIndex))-1.0;
}
return uvi.xy;
}
vec2 sc_ScreenCoordsGlobalToView(vec2 uv)
{
vec2 l9_0;
#if (sc_StereoRenderingMode==1)
{
l9_0=sc_SamplingCoordsGlobalToView(vec3(uv,0.0),1,sc_GetStereoViewIndex());
}
#else
{
l9_0=uv;
}
#endif
return l9_0;
}
int sc_ScreenTextureGetStereoViewIndex()
{
int l9_0;
#if (sc_ScreenTextureHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
vec4 sc_ScreenTextureSampleViewIndexBias(vec2 uv,int viewIndex,float bias)
{
return sc_SampleView(sc_ScreenTextureDims.xy,uv,sc_ScreenTextureLayout,viewIndex,bias,sc_ScreenTexture);
}
vec4 sc_readFragData0_Platform()
{
    return getFragData()[0];
}
vec4 sc_readFragData0()
{
vec4 l9_0=sc_readFragData0_Platform();
vec4 l9_1;
#if (sc_UseFramebufferFetchMarker)
{
vec4 l9_2=l9_0;
l9_2.x=l9_0.x+_sc_framebufferFetchMarker;
l9_1=l9_2;
}
#else
{
l9_1=l9_0;
}
#endif
return l9_1;
}
vec4 sc_GetFramebufferColor()
{
vec4 l9_0;
#if (sc_FramebufferFetch)
{
l9_0=sc_readFragData0();
}
#else
{
l9_0=sc_ScreenTextureSampleViewIndexBias(sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw),sc_ScreenTextureGetStereoViewIndex(),0.0);
}
#endif
vec4 l9_1;
#if (((sc_IsEditor&&sc_GetFramebufferColorInvalidUsageMarker)&&(!sc_BlendMode_Software))&&(!sc_BlendMode_ColoredGlass))
{
vec4 l9_2=l9_0;
l9_2.x=l9_0.x+_sc_GetFramebufferColorInvalidUsageMarker;
l9_1=l9_2;
}
#else
{
l9_1=l9_0;
}
#endif
return l9_1;
}
float srgbToLinear(float x)
{
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
return pow(x,2.2);
}
#else
{
return x*x;
}
#endif
}
float linearToSrgb(float x)
{
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
return pow(x,0.45454547);
}
#else
{
return sqrt(x);
}
#endif
}
void Node153_If_else(float Bool1,vec4 Value1,vec4 Default,out vec4 Result,ssGlobals Globals)
{
#if ((MESHTYPE==1)&&PBR)
{
float param;
Node77_Bool_Parameter(param,Globals);
float param_2;
Node106_Bool_Parameter(param_2,Globals);
float param_4;
Node84_Bool_Parameter(param_4,Globals);
float param_6;
Node72_Bool_Parameter(param_6,Globals);
float param_8;
Node75_Bool_Parameter(param_8,Globals);
float param_10;
Node74_Bool_Parameter(param_10,Globals);
float param_12;
Node175_Bool_Parameter(param_12,Globals);
float param_14;
Node62_Bool_Parameter(param_14,Globals);
float param_16;
Node92_Bool_Parameter(param_16,Globals);
float param_18;
Node91_Bool_Parameter(param_18,Globals);
float param_20;
Node29_Bool_Parameter(param_20,Globals);
float param_22;
Node60_Bool_Parameter(param_22,Globals);
float param_24;
Node28_Bool_Parameter(param_24,Globals);
vec4 l9_0=vec4(Interpolator0.y,Interpolator0.z,Interpolator0.w,Interpolator1.x);
float param_26;
Node8_Bool_Parameter(param_26,Globals);
vec3 param_64;
float param_65;
vec4 param_66;
vec4 param_67;
vec2 param_68;
Node2_Pixel_Shader_Particles(colorStart,colorEnd,param,colorMinStart,colorMinEnd,colorMaxStart,colorMaxEnd,param_2,alphaStart,alphaEnd,param_4,alphaMinStart,alphaMinEnd,alphaMaxStart,alphaMaxEnd,param_6,alphaDissolveMult,param_8,param_10,param_12,Interpolator0.x,param_14,numValidFrames,gridSize,flipBookSpeedMult,flipBookRandomStart,param_16,param_18,param_20,colorRampTextureSize.xy,colorRampMult,param_22,param_24,l9_0,param_26,externalSeed,param_64,param_65,param_66,param_67,param_68,Globals);
vec4 l9_1=param_67;
ssGlobals l9_2=Globals;
vec3 l9_3;
#if (NORMALTEX)
{
float l9_4;
Node77_Bool_Parameter(l9_4,l9_2);
float l9_5;
Node106_Bool_Parameter(l9_5,l9_2);
float l9_6;
Node84_Bool_Parameter(l9_6,l9_2);
float l9_7;
Node72_Bool_Parameter(l9_7,l9_2);
float l9_8;
Node75_Bool_Parameter(l9_8,l9_2);
float l9_9;
Node74_Bool_Parameter(l9_9,l9_2);
float l9_10;
Node175_Bool_Parameter(l9_10,l9_2);
float l9_11;
Node62_Bool_Parameter(l9_11,l9_2);
float l9_12;
Node92_Bool_Parameter(l9_12,l9_2);
float l9_13;
Node91_Bool_Parameter(l9_13,l9_2);
float l9_14;
Node29_Bool_Parameter(l9_14,l9_2);
float l9_15;
Node60_Bool_Parameter(l9_15,l9_2);
float l9_16;
Node28_Bool_Parameter(l9_16,l9_2);
float l9_17;
Node8_Bool_Parameter(l9_17,l9_2);
vec3 l9_18;
float l9_19;
vec4 l9_20;
vec4 l9_21;
vec2 l9_22;
Node2_Pixel_Shader_Particles(colorStart,colorEnd,l9_4,colorMinStart,colorMinEnd,colorMaxStart,colorMaxEnd,l9_5,alphaStart,alphaEnd,l9_6,alphaMinStart,alphaMinEnd,alphaMaxStart,alphaMaxEnd,l9_7,alphaDissolveMult,l9_8,l9_9,l9_10,Interpolator0.x,l9_11,numValidFrames,gridSize,flipBookSpeedMult,flipBookRandomStart,l9_12,l9_13,l9_14,colorRampTextureSize.xy,colorRampMult,l9_15,l9_16,l9_0,l9_17,externalSeed,l9_18,l9_19,l9_20,l9_21,l9_22,l9_2);
vec2 l9_23=l9_22;
int l9_24;
#if (normalTexHasSwappedViews)
{
l9_24=1-sc_GetStereoViewIndex();
}
#else
{
l9_24=sc_GetStereoViewIndex();
}
#endif
l9_3=((sc_SampleTextureBiasOrLevel(normalTexDims.xy,normalTexLayout,l9_24,l9_23,(int(SC_USE_UV_TRANSFORM_normalTex)!=0),normalTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_normalTex,SC_SOFTWARE_WRAP_MODE_V_normalTex),(int(SC_USE_UV_MIN_MAX_normalTex)!=0),normalTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_normalTex)!=0),normalTexBorderColor,0.0,normalTex).xyz*1.9921875)-vec3(1.0)).xyz;
}
#else
{
l9_3=Port_Default_N167;
}
#endif
vec3 l9_25;
#if (!sc_ProjectiveShadowsCaster)
{
l9_25=mat3(Globals.VertexTangent_WorldSpace,Globals.VertexBinormal_WorldSpace,Globals.VertexNormal_WorldSpace)*l9_3;
}
#else
{
l9_25=Globals.BumpedNormal;
}
#endif
float l9_26=clamp(l9_1.w,0.0,1.0);
#if (sc_BlendMode_AlphaTest)
{
if (l9_26<alphaTestThreshold)
{
discard;
}
}
#endif
#if (ENABLE_STIPPLE_PATTERN_TEST)
{
if (l9_26<((mod(dot(floor(mod(gl_FragCoord.xy,vec2(4.0))),vec2(4.0,1.0))*9.0,16.0)+1.0)/17.0))
{
discard;
}
}
#endif
vec3 l9_27=max(l9_1.xyz,vec3(0.0));
vec4 l9_28;
#if (sc_ProjectiveShadowsCaster)
{
l9_28=vec4(l9_27,l9_26);
}
#else
{
float l9_29=clamp(metallic,0.0,1.0);
float l9_30=clamp(roughness,0.0,1.0);
vec3 l9_31=ssSRGB_to_Linear(l9_27);
vec3 l9_32=normalize(l9_25);
vec3 l9_33=ssSRGB_to_Linear(Port_Emissive_N014);
vec3 l9_34;
#if (sc_SSAOEnabled)
{
l9_34=evaluateSSAO(Globals.PositionWS);
}
#else
{
l9_34=Port_AO_N014;
}
#endif
vec3 l9_35=vec3(l9_29);
vec3 l9_36=mix(vec3(0.039999999),l9_31*l9_29,l9_35);
vec3 l9_37=mix(l9_31*(1.0-l9_29),vec3(0.0),l9_35);
SurfaceProperties l9_38=SurfaceProperties(l9_37,l9_26,l9_32,Globals.PositionWS,Globals.ViewDirWS,l9_29,l9_30,l9_33,l9_34,Port_SpecularAO_N014,vec3(1.0),l9_36);
vec4 l9_39=vec4(1.0);
vec3 l9_40;
vec3 l9_41;
vec3 l9_42;
vec3 l9_43;
int l9_44;
vec3 l9_45;
vec3 l9_46;
#if (sc_DirectionalLightsCount>0)
{
vec3 l9_47;
vec3 l9_48;
vec3 l9_49;
vec3 l9_50;
int l9_51;
vec3 l9_52;
vec3 l9_53;
l9_53=vec3(1.0);
l9_52=vec3(0.0);
l9_51=0;
l9_50=vec3(0.0);
l9_49=vec3(0.0);
l9_48=vec3(0.0);
l9_47=vec3(0.0);
LightingComponents l9_54;
LightProperties l9_55;
SurfaceProperties l9_56;
vec3 l9_57;
int l9_58=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_58<sc_DirectionalLightsCount)
{
LightingComponents l9_59=accumulateLight(LightingComponents(l9_47,l9_48,l9_53,l9_52,l9_50,l9_49),LightProperties(sc_DirectionalLights[l9_58].direction,sc_DirectionalLights[l9_58].color.xyz,sc_DirectionalLights[l9_58].color.w*l9_39[(l9_51<3) ? l9_51 : 3]),l9_38,Globals.ViewDirWS);
l9_53=l9_59.indirectDiffuse;
l9_52=l9_59.indirectSpecular;
l9_51++;
l9_50=l9_59.emitted;
l9_49=l9_59.transmitted;
l9_48=l9_59.directSpecular;
l9_47=l9_59.directDiffuse;
l9_58++;
continue;
}
else
{
break;
}
}
l9_46=l9_53;
l9_45=l9_52;
l9_44=l9_51;
l9_43=l9_50;
l9_42=l9_49;
l9_41=l9_48;
l9_40=l9_47;
}
#else
{
l9_46=vec3(1.0);
l9_45=vec3(0.0);
l9_44=0;
l9_43=vec3(0.0);
l9_42=vec3(0.0);
l9_41=vec3(0.0);
l9_40=vec3(0.0);
}
#endif
vec3 l9_60;
vec3 l9_61;
vec3 l9_62;
#if (sc_PointLightsCount>0)
{
vec3 l9_63;
vec3 l9_64;
vec3 l9_65;
vec3 l9_66;
vec3 l9_67;
vec3 l9_68;
l9_68=l9_46;
l9_67=l9_45;
l9_66=l9_43;
l9_65=l9_42;
l9_64=l9_41;
l9_63=l9_40;
int l9_69;
vec3 l9_70;
vec3 l9_71;
vec3 l9_72;
vec3 l9_73;
vec3 l9_74;
vec3 l9_75;
int l9_76=0;
int l9_77=l9_44;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_76<sc_PointLightsCount)
{
vec3 l9_78=sc_PointLights[l9_76].position-Globals.PositionWS;
vec3 l9_79=normalize(l9_78);
float l9_80=l9_39[(l9_77<3) ? l9_77 : 3];
float l9_81=clamp((dot(l9_79,sc_PointLights[l9_76].direction)*sc_PointLights[l9_76].angleScale)+sc_PointLights[l9_76].angleOffset,0.0,1.0);
float l9_82=(sc_PointLights[l9_76].color.w*l9_80)*(l9_81*l9_81);
float l9_83;
if (sc_PointLights[l9_76].falloffEnabled)
{
l9_83=l9_82*computeDistanceAttenuation(length(l9_78),sc_PointLights[l9_76].falloffEndDistance);
}
else
{
l9_83=l9_82;
}
l9_69=l9_77+1;
LightingComponents l9_84=accumulateLight(LightingComponents(l9_63,l9_64,l9_68,l9_67,l9_66,l9_65),LightProperties(l9_79,sc_PointLights[l9_76].color.xyz,l9_83),l9_38,Globals.ViewDirWS);
l9_70=l9_84.directDiffuse;
l9_71=l9_84.directSpecular;
l9_72=l9_84.indirectDiffuse;
l9_73=l9_84.indirectSpecular;
l9_74=l9_84.emitted;
l9_75=l9_84.transmitted;
l9_68=l9_72;
l9_67=l9_73;
l9_77=l9_69;
l9_66=l9_74;
l9_65=l9_75;
l9_64=l9_71;
l9_63=l9_70;
l9_76++;
continue;
}
else
{
break;
}
}
l9_62=l9_65;
l9_61=l9_64;
l9_60=l9_63;
}
#else
{
l9_62=l9_42;
l9_61=l9_41;
l9_60=l9_40;
}
#endif
vec3 l9_85;
vec3 l9_86;
#if (sc_ProjectiveShadowsReceiver)
{
vec3 l9_87;
#if (sc_ProjectiveShadowsReceiver)
{
vec2 l9_88=abs(varShadowTex-vec2(0.5));
vec4 l9_89=texture2D(sc_ShadowTexture,varShadowTex)*step(max(l9_88.x,l9_88.y),0.5);
l9_87=mix(vec3(1.0),mix(sc_ShadowColor.xyz,sc_ShadowColor.xyz*l9_89.xyz,vec3(sc_ShadowColor.w)),vec3(l9_89.w*sc_ShadowDensity));
}
#else
{
l9_87=vec3(1.0);
}
#endif
l9_86=l9_60*l9_87;
l9_85=l9_61*l9_87;
}
#else
{
l9_86=l9_60;
l9_85=l9_61;
}
#endif
vec3 l9_90;
#if ((sc_EnvLightMode==sc_AmbientLightMode_EnvironmentMap)||(sc_EnvLightMode==sc_AmbientLightMode_FromCamera))
{
vec2 l9_91=calcPanoramicTexCoordsFromDir(l9_32,sc_EnvmapRotation.y);
vec4 l9_92;
#if (sc_EnvLightMode==sc_AmbientLightMode_FromCamera)
{
vec2 l9_93;
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
l9_93=calcSeamlessPanoramicUvsForSampling(l9_91,sc_EnvmapSpecularSize.xy,5.0);
}
#else
{
l9_93=l9_91;
}
#endif
l9_92=sc_EnvmapSpecularSampleViewIndexBias(l9_93,sc_EnvmapSpecularGetStereoViewIndex(),13.0);
}
#else
{
vec4 l9_94;
#if ((sc_MaxTextureImageUnits>8)&&sc_HasDiffuseEnvmap)
{
vec2 l9_95=calcSeamlessPanoramicUvsForSampling(l9_91,sc_EnvmapDiffuseSize.xy,0.0);
int l9_96;
#if (sc_EnvmapDiffuseHasSwappedViews)
{
l9_96=1-sc_GetStereoViewIndex();
}
#else
{
l9_96=sc_GetStereoViewIndex();
}
#endif
l9_94=sc_SampleView(sc_EnvmapDiffuseDims.xy,l9_95,sc_EnvmapDiffuseLayout,l9_96,-13.0,sc_EnvmapDiffuse);
}
#else
{
l9_94=sc_EnvmapSpecularSampleViewIndexBias(l9_91,sc_EnvmapSpecularGetStereoViewIndex(),13.0);
}
#endif
l9_92=l9_94;
}
#endif
l9_90=(l9_92.xyz*(1.0/l9_92.w))*sc_EnvmapExposure;
}
#else
{
vec3 l9_97;
#if (sc_EnvLightMode==sc_AmbientLightMode_SphericalHarmonics)
{
vec3 l9_98=-l9_32;
float l9_99=l9_98.x;
float l9_100=l9_98.y;
float l9_101=l9_98.z;
l9_97=(((((((sc_Sh[8]*0.42904299)*((l9_99*l9_99)-(l9_100*l9_100)))+((sc_Sh[6]*0.74312502)*(l9_101*l9_101)))+(sc_Sh[0]*0.88622701))-(sc_Sh[6]*0.24770799))+((((sc_Sh[4]*(l9_99*l9_100))+(sc_Sh[7]*(l9_99*l9_101)))+(sc_Sh[5]*(l9_100*l9_101)))*0.85808599))+((((sc_Sh[3]*l9_99)+(sc_Sh[1]*l9_100))+(sc_Sh[2]*l9_101))*1.0233279))*sc_ShIntensity;
}
#else
{
l9_97=vec3(0.0);
}
#endif
l9_90=l9_97;
}
#endif
vec3 l9_102;
#if (sc_AmbientLightsCount>0)
{
vec3 l9_103;
#if (sc_AmbientLightMode0==sc_AmbientLightMode_Constant)
{
l9_103=l9_90+(sc_AmbientLights[0].color*sc_AmbientLights[0].intensity);
}
#else
{
vec3 l9_104=l9_90;
l9_104.x=l9_90.x+(1e-06*sc_AmbientLights[0].color.x);
l9_103=l9_104;
}
#endif
l9_102=l9_103;
}
#else
{
l9_102=l9_90;
}
#endif
vec3 l9_105;
#if (sc_AmbientLightsCount>1)
{
vec3 l9_106;
#if (sc_AmbientLightMode1==sc_AmbientLightMode_Constant)
{
l9_106=l9_102+(sc_AmbientLights[1].color*sc_AmbientLights[1].intensity);
}
#else
{
vec3 l9_107=l9_102;
l9_107.x=l9_102.x+(1e-06*sc_AmbientLights[1].color.x);
l9_106=l9_107;
}
#endif
l9_105=l9_106;
}
#else
{
l9_105=l9_102;
}
#endif
vec3 l9_108;
#if (sc_AmbientLightsCount>2)
{
vec3 l9_109;
#if (sc_AmbientLightMode2==sc_AmbientLightMode_Constant)
{
l9_109=l9_105+(sc_AmbientLights[2].color*sc_AmbientLights[2].intensity);
}
#else
{
vec3 l9_110=l9_105;
l9_110.x=l9_105.x+(1e-06*sc_AmbientLights[2].color.x);
l9_109=l9_110;
}
#endif
l9_108=l9_109;
}
#else
{
l9_108=l9_105;
}
#endif
vec3 l9_111;
#if (sc_LightEstimation)
{
vec3 l9_112;
l9_112=sc_LightEstimationData.ambientLight;
vec3 l9_113;
int l9_114=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_114<sc_LightEstimationSGCount)
{
float l9_115=dot(sc_LightEstimationData.sg[l9_114].axis,l9_32);
float l9_116=exp(-sc_LightEstimationData.sg[l9_114].sharpness);
float l9_117=l9_116*l9_116;
float l9_118=1.0/sc_LightEstimationData.sg[l9_114].sharpness;
float l9_119=(1.0+(2.0*l9_117))-l9_118;
float l9_120=sqrt(1.0-l9_119);
float l9_121=0.36000001*l9_115;
float l9_122=(1.0/(4.0*0.36000001))*l9_120;
float l9_123=l9_121+l9_122;
float l9_124;
if (step(abs(l9_121),l9_122)>0.5)
{
l9_124=(l9_123*l9_123)/l9_120;
}
else
{
l9_124=clamp(l9_115,0.0,1.0);
}
l9_113=l9_112+((((sc_LightEstimationData.sg[l9_114].color/vec3(sc_LightEstimationData.sg[l9_114].sharpness))*6.2831855)*((l9_119*l9_124)+(((l9_116-l9_117)*l9_118)-l9_117)))/vec3(3.1415927));
l9_112=l9_113;
l9_114++;
continue;
}
else
{
break;
}
}
l9_111=l9_108+l9_112;
}
#else
{
l9_111=l9_108;
}
#endif
vec3 l9_125;
#if ((sc_EnvLightMode==sc_AmbientLightMode_EnvironmentMap)||(sc_EnvLightMode==sc_AmbientLightMode_FromCamera))
{
float l9_126=clamp(pow(l9_30,0.66666669),0.0,1.0)*5.0;
vec2 l9_127=calcPanoramicTexCoordsFromDir(getSpecularDominantDir(l9_32,reflect(-Globals.ViewDirWS,l9_32),l9_30),sc_EnvmapRotation.y);
vec4 l9_128;
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
float l9_129=floor(l9_126);
float l9_130=ceil(l9_126);
l9_128=mix(sc_EnvmapSpecularSampleViewIndexLevel(calcSeamlessPanoramicUvsForSampling(l9_127,sc_EnvmapSpecularSize.xy,l9_129),sc_EnvmapSpecularGetStereoViewIndex(),l9_129),sc_EnvmapSpecularSampleViewIndexLevel(calcSeamlessPanoramicUvsForSampling(l9_127,sc_EnvmapSpecularSize.xy,l9_130),sc_EnvmapSpecularGetStereoViewIndex(),l9_130),vec4(l9_126-l9_129));
}
#else
{
l9_128=sc_EnvmapSpecularSampleViewIndexLevel(l9_127,sc_EnvmapSpecularGetStereoViewIndex(),l9_126);
}
#endif
l9_125=vec3(0.0)+((((l9_128.xyz*(1.0/l9_128.w))*sc_EnvmapExposure)+vec3(1e-06))*envBRDFApprox(l9_38,abs(dot(l9_32,Globals.ViewDirWS))));
}
#else
{
l9_125=vec3(0.0);
}
#endif
vec3 l9_131;
#if (sc_LightEstimation)
{
float l9_132=clamp(l9_30*l9_30,0.0099999998,1.0);
vec3 l9_133;
l9_133=sc_LightEstimationData.ambientLight*l9_36;
int l9_134=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_134<sc_LightEstimationSGCount)
{
float l9_135=l9_132*l9_132;
vec3 l9_136=reflect(-Globals.ViewDirWS,l9_32);
float l9_137=dot(l9_32,Globals.ViewDirWS);
float l9_138=(2.0/l9_135)/(4.0*max(l9_137,9.9999997e-05));
float l9_139=length((l9_136*l9_138)+(sc_LightEstimationData.sg[l9_134].axis*sc_LightEstimationData.sg[l9_134].sharpness));
float l9_140=clamp(dot(l9_32,l9_136),0.0,1.0);
float l9_141=clamp(l9_137,0.0,1.0);
float l9_142=1.0-l9_135;
l9_133+=((((((((vec3(1.0/(3.1415927*l9_135))*exp((l9_139-l9_138)-sc_LightEstimationData.sg[l9_134].sharpness))*sc_LightEstimationData.sg[l9_134].color)*6.2831855)*(1.0-exp((-2.0)*l9_139)))/vec3(l9_139))*((1.0/(l9_140+sqrt(l9_135+((l9_142*l9_140)*l9_140))))*(1.0/(l9_141+sqrt(l9_135+((l9_142*l9_141)*l9_141))))))*(l9_36+((vec3(1.0)-l9_36)*pow(1.0-clamp(dot(l9_136,normalize(l9_136+Globals.ViewDirWS)),0.0,1.0),5.0))))*l9_140);
l9_134++;
continue;
}
else
{
break;
}
}
l9_131=l9_125+l9_133;
}
#else
{
l9_131=l9_125;
}
#endif
float l9_143;
vec3 l9_144;
vec3 l9_145;
vec3 l9_146;
#if (sc_BlendMode_ColoredGlass)
{
l9_146=vec3(0.0);
l9_145=vec3(0.0);
l9_144=ssSRGB_to_Linear(sc_GetFramebufferColor().xyz)*mix(vec3(1.0),l9_37,vec3(l9_26));
l9_143=1.0;
}
#else
{
l9_146=l9_86;
l9_145=l9_111;
l9_144=l9_62;
l9_143=l9_26;
}
#endif
bool l9_147;
#if (sc_BlendMode_PremultipliedAlpha)
{
l9_147=true;
}
#else
{
l9_147=false;
}
#endif
vec3 l9_148=l9_145*l9_34;
vec3 l9_149=l9_146+l9_148;
vec3 l9_150=l9_37*l9_149;
vec3 l9_151=l9_131*Port_SpecularAO_N014;
vec3 l9_152=l9_85+l9_151;
vec3 l9_153;
if (l9_147)
{
l9_153=l9_150*srgbToLinear(l9_143);
}
else
{
l9_153=l9_150;
}
vec3 l9_154=l9_153+l9_152;
vec3 l9_155=(l9_154+l9_33)+l9_144;
float l9_156=l9_155.x;
vec4 l9_157=vec4(l9_156,l9_155.yz,l9_143);
vec4 l9_158;
#if (sc_IsEditor)
{
vec4 l9_159=l9_157;
l9_159.x=l9_156+((l9_34.x*Port_SpecularAO_N014.x)*9.9999997e-06);
l9_158=l9_159;
}
#else
{
l9_158=l9_157;
}
#endif
vec4 l9_160;
#if (!sc_BlendMode_Multiply)
{
vec3 l9_161=l9_158.xyz*1.8;
vec3 l9_162=(l9_158.xyz*(l9_161+vec3(1.4)))/((l9_158.xyz*(l9_161+vec3(0.5)))+vec3(1.5));
l9_160=vec4(l9_162.x,l9_162.y,l9_162.z,l9_158.w);
}
#else
{
l9_160=l9_158;
}
#endif
vec3 l9_163=vec3(linearToSrgb(l9_160.x),linearToSrgb(l9_160.y),linearToSrgb(l9_160.z));
l9_28=vec4(l9_163.x,l9_163.y,l9_163.z,l9_160.w);
}
#endif
Value1=max(l9_28,vec4(0.0));
Result=Value1;
}
#else
{
float param_70;
Node77_Bool_Parameter(param_70,Globals);
float param_72;
Node106_Bool_Parameter(param_72,Globals);
float param_74;
Node84_Bool_Parameter(param_74,Globals);
float param_76;
Node72_Bool_Parameter(param_76,Globals);
float param_78;
Node75_Bool_Parameter(param_78,Globals);
float param_80;
Node74_Bool_Parameter(param_80,Globals);
float param_82;
Node175_Bool_Parameter(param_82,Globals);
float param_84;
Node62_Bool_Parameter(param_84,Globals);
float param_86;
Node92_Bool_Parameter(param_86,Globals);
float param_88;
Node91_Bool_Parameter(param_88,Globals);
float param_90;
Node29_Bool_Parameter(param_90,Globals);
float param_92;
Node60_Bool_Parameter(param_92,Globals);
float param_94;
Node28_Bool_Parameter(param_94,Globals);
float param_96;
Node8_Bool_Parameter(param_96,Globals);
vec3 param_134;
float param_135;
vec4 param_136;
vec4 param_137;
vec2 param_138;
Node2_Pixel_Shader_Particles(colorStart,colorEnd,param_70,colorMinStart,colorMinEnd,colorMaxStart,colorMaxEnd,param_72,alphaStart,alphaEnd,param_74,alphaMinStart,alphaMinEnd,alphaMaxStart,alphaMaxEnd,param_76,alphaDissolveMult,param_78,param_80,param_82,Interpolator0.x,param_84,numValidFrames,gridSize,flipBookSpeedMult,flipBookRandomStart,param_86,param_88,param_90,colorRampTextureSize.xy,colorRampMult,param_92,param_94,vec4(Interpolator0.y,Interpolator0.z,Interpolator0.w,Interpolator1.x),param_96,externalSeed,param_134,param_135,param_136,param_137,param_138,Globals);
Default=param_137;
Result=Default;
}
#endif
}
float transformSingleColor(float original,float intMap,float target)
{
#if ((BLEND_MODE_REALISTIC||BLEND_MODE_FORGRAY)||BLEND_MODE_NOTBRIGHT)
{
return original/pow(1.0-target,intMap);
}
#else
{
#if (BLEND_MODE_DIVISION)
{
return original/(1.0-target);
}
#else
{
#if (BLEND_MODE_BRIGHT)
{
return original/pow(1.0-target,2.0-(2.0*original));
}
#endif
}
#endif
}
#endif
return 0.0;
}
vec3 RGBtoHCV(vec3 rgb)
{
vec4 l9_0;
if (rgb.y<rgb.z)
{
l9_0=vec4(rgb.zy,-1.0,0.66666669);
}
else
{
l9_0=vec4(rgb.yz,0.0,-0.33333334);
}
vec4 l9_1;
if (rgb.x<l9_0.x)
{
l9_1=vec4(l9_0.xyw,rgb.x);
}
else
{
l9_1=vec4(rgb.x,l9_0.yzx);
}
float l9_2=l9_1.x-min(l9_1.w,l9_1.y);
return vec3(abs(((l9_1.w-l9_1.y)/((6.0*l9_2)+1e-07))+l9_1.z),l9_2,l9_1.x);
}
vec3 RGBToHSL(vec3 rgb)
{
vec3 l9_0=RGBtoHCV(rgb);
float l9_1=l9_0.y;
float l9_2=l9_0.z-(l9_1*0.5);
return vec3(l9_0.x,l9_1/((1.0-abs((2.0*l9_2)-1.0))+1e-07),l9_2);
}
vec3 HUEtoRGB(float hue)
{
return clamp(vec3(abs((6.0*hue)-3.0)-1.0,2.0-abs((6.0*hue)-2.0),2.0-abs((6.0*hue)-4.0)),vec3(0.0),vec3(1.0));
}
vec3 HSLToRGB(vec3 hsl)
{
return ((HUEtoRGB(hsl.x)-vec3(0.5))*((1.0-abs((2.0*hsl.z)-1.0))*hsl.y))+vec3(hsl.z);
}
vec3 transformColor(float yValue,vec3 original,vec3 target,float weight,float intMap)
{
#if (BLEND_MODE_INTENSE)
{
return mix(original,HSLToRGB(vec3(target.x,target.y,RGBToHSL(original).z)),vec3(weight));
}
#else
{
return mix(original,clamp(vec3(transformSingleColor(yValue,intMap,target.x),transformSingleColor(yValue,intMap,target.y),transformSingleColor(yValue,intMap,target.z)),vec3(0.0),vec3(1.0)),vec3(weight));
}
#endif
}
vec3 definedBlend(vec3 a,vec3 b)
{
#if (BLEND_MODE_LIGHTEN)
{
return max(a,b);
}
#else
{
#if (BLEND_MODE_DARKEN)
{
return min(a,b);
}
#else
{
#if (BLEND_MODE_DIVIDE)
{
return b/a;
}
#else
{
#if (BLEND_MODE_AVERAGE)
{
return (a+b)*0.5;
}
#else
{
#if (BLEND_MODE_SUBTRACT)
{
return max((a+b)-vec3(1.0),vec3(0.0));
}
#else
{
#if (BLEND_MODE_DIFFERENCE)
{
return abs(a-b);
}
#else
{
#if (BLEND_MODE_NEGATION)
{
return vec3(1.0)-abs((vec3(1.0)-a)-b);
}
#else
{
#if (BLEND_MODE_EXCLUSION)
{
return (a+b)-((a*2.0)*b);
}
#else
{
#if (BLEND_MODE_OVERLAY)
{
float l9_0;
if (a.x<0.5)
{
l9_0=(2.0*a.x)*b.x;
}
else
{
l9_0=1.0-((2.0*(1.0-a.x))*(1.0-b.x));
}
float l9_1;
if (a.y<0.5)
{
l9_1=(2.0*a.y)*b.y;
}
else
{
l9_1=1.0-((2.0*(1.0-a.y))*(1.0-b.y));
}
float l9_2;
if (a.z<0.5)
{
l9_2=(2.0*a.z)*b.z;
}
else
{
l9_2=1.0-((2.0*(1.0-a.z))*(1.0-b.z));
}
return vec3(l9_0,l9_1,l9_2);
}
#else
{
#if (BLEND_MODE_SOFT_LIGHT)
{
return (((vec3(1.0)-(b*2.0))*a)*a)+((a*2.0)*b);
}
#else
{
#if (BLEND_MODE_HARD_LIGHT)
{
float l9_3;
if (b.x<0.5)
{
l9_3=(2.0*b.x)*a.x;
}
else
{
l9_3=1.0-((2.0*(1.0-b.x))*(1.0-a.x));
}
float l9_4;
if (b.y<0.5)
{
l9_4=(2.0*b.y)*a.y;
}
else
{
l9_4=1.0-((2.0*(1.0-b.y))*(1.0-a.y));
}
float l9_5;
if (b.z<0.5)
{
l9_5=(2.0*b.z)*a.z;
}
else
{
l9_5=1.0-((2.0*(1.0-b.z))*(1.0-a.z));
}
return vec3(l9_3,l9_4,l9_5);
}
#else
{
#if (BLEND_MODE_COLOR_DODGE)
{
float l9_6;
if (b.x==1.0)
{
l9_6=b.x;
}
else
{
l9_6=min(a.x/(1.0-b.x),1.0);
}
float l9_7;
if (b.y==1.0)
{
l9_7=b.y;
}
else
{
l9_7=min(a.y/(1.0-b.y),1.0);
}
float l9_8;
if (b.z==1.0)
{
l9_8=b.z;
}
else
{
l9_8=min(a.z/(1.0-b.z),1.0);
}
return vec3(l9_6,l9_7,l9_8);
}
#else
{
#if (BLEND_MODE_COLOR_BURN)
{
float l9_9;
if (b.x==0.0)
{
l9_9=b.x;
}
else
{
l9_9=max(1.0-((1.0-a.x)/b.x),0.0);
}
float l9_10;
if (b.y==0.0)
{
l9_10=b.y;
}
else
{
l9_10=max(1.0-((1.0-a.y)/b.y),0.0);
}
float l9_11;
if (b.z==0.0)
{
l9_11=b.z;
}
else
{
l9_11=max(1.0-((1.0-a.z)/b.z),0.0);
}
return vec3(l9_9,l9_10,l9_11);
}
#else
{
#if (BLEND_MODE_LINEAR_LIGHT)
{
float l9_12;
if (b.x<0.5)
{
l9_12=max((a.x+(2.0*b.x))-1.0,0.0);
}
else
{
l9_12=min(a.x+(2.0*(b.x-0.5)),1.0);
}
float l9_13;
if (b.y<0.5)
{
l9_13=max((a.y+(2.0*b.y))-1.0,0.0);
}
else
{
l9_13=min(a.y+(2.0*(b.y-0.5)),1.0);
}
float l9_14;
if (b.z<0.5)
{
l9_14=max((a.z+(2.0*b.z))-1.0,0.0);
}
else
{
l9_14=min(a.z+(2.0*(b.z-0.5)),1.0);
}
return vec3(l9_12,l9_13,l9_14);
}
#else
{
#if (BLEND_MODE_VIVID_LIGHT)
{
float l9_15;
if (b.x<0.5)
{
float l9_16;
if ((2.0*b.x)==0.0)
{
l9_16=2.0*b.x;
}
else
{
l9_16=max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_15=l9_16;
}
else
{
float l9_17;
if ((2.0*(b.x-0.5))==1.0)
{
l9_17=2.0*(b.x-0.5);
}
else
{
l9_17=min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_15=l9_17;
}
float l9_18;
if (b.y<0.5)
{
float l9_19;
if ((2.0*b.y)==0.0)
{
l9_19=2.0*b.y;
}
else
{
l9_19=max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_18=l9_19;
}
else
{
float l9_20;
if ((2.0*(b.y-0.5))==1.0)
{
l9_20=2.0*(b.y-0.5);
}
else
{
l9_20=min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_18=l9_20;
}
float l9_21;
if (b.z<0.5)
{
float l9_22;
if ((2.0*b.z)==0.0)
{
l9_22=2.0*b.z;
}
else
{
l9_22=max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_21=l9_22;
}
else
{
float l9_23;
if ((2.0*(b.z-0.5))==1.0)
{
l9_23=2.0*(b.z-0.5);
}
else
{
l9_23=min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_21=l9_23;
}
return vec3(l9_15,l9_18,l9_21);
}
#else
{
#if (BLEND_MODE_PIN_LIGHT)
{
float l9_24;
if (b.x<0.5)
{
l9_24=min(a.x,2.0*b.x);
}
else
{
l9_24=max(a.x,2.0*(b.x-0.5));
}
float l9_25;
if (b.y<0.5)
{
l9_25=min(a.y,2.0*b.y);
}
else
{
l9_25=max(a.y,2.0*(b.y-0.5));
}
float l9_26;
if (b.z<0.5)
{
l9_26=min(a.z,2.0*b.z);
}
else
{
l9_26=max(a.z,2.0*(b.z-0.5));
}
return vec3(l9_24,l9_25,l9_26);
}
#else
{
#if (BLEND_MODE_HARD_MIX)
{
float l9_27;
if (b.x<0.5)
{
float l9_28;
if ((2.0*b.x)==0.0)
{
l9_28=2.0*b.x;
}
else
{
l9_28=max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_27=l9_28;
}
else
{
float l9_29;
if ((2.0*(b.x-0.5))==1.0)
{
l9_29=2.0*(b.x-0.5);
}
else
{
l9_29=min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_27=l9_29;
}
bool l9_30=l9_27<0.5;
float l9_31;
if (b.y<0.5)
{
float l9_32;
if ((2.0*b.y)==0.0)
{
l9_32=2.0*b.y;
}
else
{
l9_32=max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_31=l9_32;
}
else
{
float l9_33;
if ((2.0*(b.y-0.5))==1.0)
{
l9_33=2.0*(b.y-0.5);
}
else
{
l9_33=min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_31=l9_33;
}
bool l9_34=l9_31<0.5;
float l9_35;
if (b.z<0.5)
{
float l9_36;
if ((2.0*b.z)==0.0)
{
l9_36=2.0*b.z;
}
else
{
l9_36=max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_35=l9_36;
}
else
{
float l9_37;
if ((2.0*(b.z-0.5))==1.0)
{
l9_37=2.0*(b.z-0.5);
}
else
{
l9_37=min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_35=l9_37;
}
return vec3(l9_30 ? 0.0 : 1.0,l9_34 ? 0.0 : 1.0,(l9_35<0.5) ? 0.0 : 1.0);
}
#else
{
#if (BLEND_MODE_HARD_REFLECT)
{
float l9_38;
if (b.x==1.0)
{
l9_38=b.x;
}
else
{
l9_38=min((a.x*a.x)/(1.0-b.x),1.0);
}
float l9_39;
if (b.y==1.0)
{
l9_39=b.y;
}
else
{
l9_39=min((a.y*a.y)/(1.0-b.y),1.0);
}
float l9_40;
if (b.z==1.0)
{
l9_40=b.z;
}
else
{
l9_40=min((a.z*a.z)/(1.0-b.z),1.0);
}
return vec3(l9_38,l9_39,l9_40);
}
#else
{
#if (BLEND_MODE_HARD_GLOW)
{
float l9_41;
if (a.x==1.0)
{
l9_41=a.x;
}
else
{
l9_41=min((b.x*b.x)/(1.0-a.x),1.0);
}
float l9_42;
if (a.y==1.0)
{
l9_42=a.y;
}
else
{
l9_42=min((b.y*b.y)/(1.0-a.y),1.0);
}
float l9_43;
if (a.z==1.0)
{
l9_43=a.z;
}
else
{
l9_43=min((b.z*b.z)/(1.0-a.z),1.0);
}
return vec3(l9_41,l9_42,l9_43);
}
#else
{
#if (BLEND_MODE_HARD_PHOENIX)
{
return (min(a,b)-max(a,b))+vec3(1.0);
}
#else
{
#if (BLEND_MODE_HUE)
{
return HSLToRGB(vec3(RGBToHSL(b).x,RGBToHSL(a).yz));
}
#else
{
#if (BLEND_MODE_SATURATION)
{
vec3 l9_44=RGBToHSL(a);
return HSLToRGB(vec3(l9_44.x,RGBToHSL(b).y,l9_44.z));
}
#else
{
#if (BLEND_MODE_COLOR)
{
return HSLToRGB(vec3(RGBToHSL(b).xy,RGBToHSL(a).z));
}
#else
{
#if (BLEND_MODE_LUMINOSITY)
{
return HSLToRGB(vec3(RGBToHSL(a).xy,RGBToHSL(b).z));
}
#else
{
vec3 l9_45=a;
vec3 l9_46=b;
float l9_47=((0.29899999*l9_45.x)+(0.58700001*l9_45.y))+(0.114*l9_45.z);
int l9_48;
#if (intensityTextureHasSwappedViews)
{
l9_48=1-sc_GetStereoViewIndex();
}
#else
{
l9_48=sc_GetStereoViewIndex();
}
#endif
vec4 l9_49=sc_SampleTextureBiasOrLevel(intensityTextureDims.xy,intensityTextureLayout,l9_48,vec2(pow(l9_47,1.0/correctedIntensity),0.5),(int(SC_USE_UV_TRANSFORM_intensityTexture)!=0),intensityTextureTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture),(int(SC_USE_UV_MIN_MAX_intensityTexture)!=0),intensityTextureUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0),intensityTextureBorderColor,0.0,intensityTexture);
float l9_50=((((l9_49.x*256.0)+l9_49.y)+(l9_49.z/256.0))/257.00391)*16.0;
float l9_51;
#if (BLEND_MODE_FORGRAY)
{
l9_51=max(l9_50,1.0);
}
#else
{
l9_51=l9_50;
}
#endif
float l9_52;
#if (BLEND_MODE_NOTBRIGHT)
{
l9_52=min(l9_51,1.0);
}
#else
{
l9_52=l9_51;
}
#endif
return transformColor(l9_47,l9_45,l9_46,1.0,l9_52);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
vec4 outputMotionVectorsIfNeeded(vec3 surfacePosWorldSpace,vec4 finalColor)
{
#if (sc_MotionVectorsPass)
{
vec4 l9_0=vec4(surfacePosWorldSpace,1.0);
vec4 l9_1=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*l9_0;
vec4 l9_2=((sc_PrevFrameViewProjectionMatrixArray[sc_GetStereoViewIndex()]*sc_PrevFrameModelMatrix)*sc_ModelMatrixInverse)*l9_0;
vec2 l9_3=((l9_1.xy/vec2(l9_1.w)).xy-(l9_2.xy/vec2(l9_2.w)).xy)*0.5;
float l9_4=floor(((l9_3.x*5.0)+0.5)*65535.0);
float l9_5=floor(l9_4*0.00390625);
float l9_6=floor(((l9_3.y*5.0)+0.5)*65535.0);
float l9_7=floor(l9_6*0.00390625);
return vec4(l9_5/255.0,(l9_4-(l9_5*256.0))/255.0,l9_7/255.0,(l9_6-(l9_7*256.0))/255.0);
}
#else
{
return finalColor;
}
#endif
}
void sc_writeFragData0(vec4 col)
{
    sc_FragData0=col;
}
float getFrontLayerZTestEpsilon()
{
#if (sc_SkinBonesCount>0)
{
return 5e-07;
}
#else
{
return 5.0000001e-08;
}
#endif
}
void unpackValues(float channel,int passIndex,inout int values[8])
{
#if (sc_OITCompositingPass)
{
channel=floor((channel*255.0)+0.5);
int l9_0=((passIndex+1)*4)-1;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_0>=(passIndex*4))
{
values[l9_0]=(values[l9_0]*4)+int(floor(mod(channel,4.0)));
channel=floor(channel/4.0);
l9_0--;
continue;
}
else
{
break;
}
}
}
#endif
}
float getDepthOrderingEpsilon()
{
#if (sc_SkinBonesCount>0)
{
return 0.001;
}
#else
{
return 0.0;
}
#endif
}
int encodeDepth(float depth,vec2 depthBounds)
{
float l9_0=(1.0-depthBounds.x)*1000.0;
return int(clamp((depth-l9_0)/((depthBounds.y*1000.0)-l9_0),0.0,1.0)*65535.0);
}
float viewSpaceDepth()
{
#if (UseViewSpaceDepthVariant&&((sc_OITDepthGatherPass||sc_OITCompositingPass)||sc_OITDepthBoundsPass))
{
return varViewSpaceDepth;
}
#else
{
return sc_ProjectionMatrixArray[sc_GetStereoViewIndex()][3].z/(sc_ProjectionMatrixArray[sc_GetStereoViewIndex()][2].z+((gl_FragCoord.z*2.0)-1.0));
}
#endif
}
float packValue(inout int value)
{
#if (sc_OITDepthGatherPass)
{
int l9_0=value;
value/=4;
return floor(floor(mod(float(l9_0),4.0))*64.0)/255.0;
}
#else
{
return 0.0;
}
#endif
}
void sc_writeFragData1(vec4 col)
{
#if sc_FragDataCount>=2
    sc_FragData1=col;
#endif
}
void sc_writeFragData2(vec4 col)
{
#if sc_FragDataCount>=3
    sc_FragData2=col;
#endif
}
void main()
{
N2_colorStart=vec3(0.0);
N2_colorEnd=vec3(0.0);
N2_ENABLE_COLORMINMAX=false;
N2_colorMinStart=vec3(0.0);
N2_colorMinEnd=vec3(0.0);
N2_colorMaxStart=vec3(0.0);
N2_colorMaxEnd=vec3(0.0);
N2_ENABLE_COLORMONOMIN=false;
N2_alphaStart=0.0;
N2_alphaEnd=0.0;
N2_ENABLE_ALPHAMINMAX=false;
N2_alphaMinStart=0.0;
N2_alphaMinEnd=0.0;
N2_alphaMaxStart=0.0;
N2_alphaMaxEnd=0.0;
N2_ENABLE_ALPHADISSOLVE=false;
N2_alphaDissolveMult=0.0;
N2_ENABLE_PREMULTIPLIEDCOLOR=false;
N2_ENABLE_BLACKASALPHA=false;
N2_ENABLE_SCREENFADE=false;
N2_nearCameraFade=0.0;
N2_ENABLE_FLIPBOOK=false;
N2_numValidFrames=0.0;
N2_gridSize=vec2(0.0);
N2_flipBookSpeedMult=0.0;
N2_flipBookRandomStart=0.0;
N2_ENABLE_FLIPBOOKBLEND=false;
N2_ENABLE_FLIPBOOKBYLIFE=false;
N2_ENABLE_COLORRAMP=false;
N2_texSize=vec2(0.0);
N2_colorRampMult=vec4(0.0);
N2_ENABLE_NORANDOFFSET=false;
N2_ENABLE_BASETEXTURE=false;
N2_timeValuesIn=vec4(0.0);
N2_ENABLE_WORLDPOSSEED=false;
N2_externalSeed=0.0;
N2_particleSeed=vec3(0.0);
N2_globalSeed=0.0;
N2_timeValues=vec4(0.0);
N2_result=vec4(0.0);
N2_uv=vec2(0.0);
#if (sc_DepthOnly)
{
return;
}
#endif
#if ((sc_StereoRenderingMode==1)&&(sc_StereoRendering_IsClipDistanceEnabled==0))
{
if (varClipDistance<0.0)
{
discard;
}
}
#endif
bool l9_0=overrideTimeEnabled==1;
float l9_1;
if (l9_0)
{
l9_1=overrideTimeElapsed;
}
else
{
l9_1=sc_Time.x;
}
float l9_2;
if (l9_0)
{
l9_2=overrideTimeDelta;
}
else
{
l9_2=sc_Time.y;
}
vec3 l9_3=normalize(varTangent.xyz);
vec3 l9_4=normalize(varNormal);
vec4 param_3;
Node153_If_else(0.0,vec4(0.0),vec4(0.0),param_3,ssGlobals(l9_1,l9_2,0.0,vec3(0.0),normalize(sc_Camera.position-varPos),varPos,l9_3,l9_4,cross(l9_4,l9_3)*varTangent.w,varPackedTex.xy,varPackedTex.zw,Interpolator_gInstanceID));
vec4 l9_5=param_3;
vec4 l9_6;
#if (sc_ProjectiveShadowsCaster)
{
float l9_7;
#if (((sc_BlendMode_Normal||sc_BlendMode_AlphaToCoverage)||sc_BlendMode_PremultipliedAlphaHardware)||sc_BlendMode_PremultipliedAlphaAuto)
{
l9_7=l9_5.w;
}
#else
{
float l9_8;
#if (sc_BlendMode_PremultipliedAlpha)
{
l9_8=clamp(l9_5.w*2.0,0.0,1.0);
}
#else
{
float l9_9;
#if (sc_BlendMode_AddWithAlphaFactor)
{
l9_9=clamp(dot(l9_5.xyz,vec3(l9_5.w)),0.0,1.0);
}
#else
{
float l9_10;
#if (sc_BlendMode_AlphaTest)
{
l9_10=1.0;
}
#else
{
float l9_11;
#if (sc_BlendMode_Multiply)
{
l9_11=(1.0-dot(l9_5.xyz,vec3(0.33333001)))*l9_5.w;
}
#else
{
float l9_12;
#if (sc_BlendMode_MultiplyOriginal)
{
l9_12=(1.0-clamp(dot(l9_5.xyz,vec3(1.0)),0.0,1.0))*l9_5.w;
}
#else
{
float l9_13;
#if (sc_BlendMode_ColoredGlass)
{
l9_13=clamp(dot(l9_5.xyz,vec3(1.0)),0.0,1.0)*l9_5.w;
}
#else
{
float l9_14;
#if (sc_BlendMode_Add)
{
l9_14=clamp(dot(l9_5.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
float l9_15;
#if (sc_BlendMode_AddWithAlphaFactor)
{
l9_15=clamp(dot(l9_5.xyz,vec3(1.0)),0.0,1.0)*l9_5.w;
}
#else
{
float l9_16;
#if (sc_BlendMode_Screen)
{
l9_16=dot(l9_5.xyz,vec3(0.33333001))*l9_5.w;
}
#else
{
float l9_17;
#if (sc_BlendMode_Min)
{
l9_17=1.0-clamp(dot(l9_5.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
float l9_18;
#if (sc_BlendMode_Max)
{
l9_18=clamp(dot(l9_5.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
l9_18=1.0;
}
#endif
l9_17=l9_18;
}
#endif
l9_16=l9_17;
}
#endif
l9_15=l9_16;
}
#endif
l9_14=l9_15;
}
#endif
l9_13=l9_14;
}
#endif
l9_12=l9_13;
}
#endif
l9_11=l9_12;
}
#endif
l9_10=l9_11;
}
#endif
l9_9=l9_10;
}
#endif
l9_8=l9_9;
}
#endif
l9_7=l9_8;
}
#endif
l9_6=vec4(mix(sc_ShadowColor.xyz,sc_ShadowColor.xyz*l9_5.xyz,vec3(sc_ShadowColor.w)),sc_ShadowDensity*l9_7);
}
#else
{
vec4 l9_19;
#if (sc_RenderAlphaToColor)
{
l9_19=vec4(l9_5.w);
}
#else
{
vec4 l9_20;
#if (sc_BlendMode_Custom)
{
vec3 l9_21=sc_GetFramebufferColor().xyz;
vec3 l9_22=mix(l9_21,definedBlend(l9_21,l9_5.xyz).xyz,vec3(l9_5.w));
vec4 l9_23=vec4(l9_22.x,l9_22.y,l9_22.z,vec4(0.0).w);
l9_23.w=1.0;
l9_20=l9_23;
}
#else
{
vec4 l9_24;
#if (sc_BlendMode_MultiplyOriginal)
{
l9_24=vec4(mix(vec3(1.0),l9_5.xyz,vec3(l9_5.w)),l9_5.w);
}
#else
{
vec4 l9_25;
#if (sc_BlendMode_Screen||sc_BlendMode_PremultipliedAlphaAuto)
{
float l9_26;
#if (sc_BlendMode_PremultipliedAlphaAuto)
{
l9_26=clamp(l9_5.w,0.0,1.0);
}
#else
{
l9_26=l9_5.w;
}
#endif
l9_25=vec4(l9_5.xyz*l9_26,l9_26);
}
#else
{
l9_25=l9_5;
}
#endif
l9_24=l9_25;
}
#endif
l9_20=l9_24;
}
#endif
l9_19=l9_20;
}
#endif
l9_6=l9_19;
}
#endif
vec4 l9_27;
if (PreviewEnabled==1)
{
vec4 l9_28;
if (((PreviewVertexSaved*1.0)!=0.0) ? true : false)
{
l9_28=PreviewVertexColor;
}
else
{
l9_28=vec4(0.0);
}
l9_27=l9_28;
}
else
{
l9_27=l9_6;
}
vec4 l9_29;
#if (sc_ShaderComplexityAnalyzer)
{
l9_29=vec4(shaderComplexityValue/255.0,0.0,0.0,1.0);
}
#else
{
l9_29=vec4(0.0);
}
#endif
vec4 l9_30;
if (l9_29.w>0.0)
{
l9_30=l9_29;
}
else
{
l9_30=l9_27;
}
vec4 l9_31=outputMotionVectorsIfNeeded(varPos,max(l9_30,vec4(0.0)));
vec4 l9_32=clamp(l9_31,vec4(0.0),vec4(1.0));
#if (sc_OITDepthBoundsPass)
{
#if (sc_OITDepthBoundsPass)
{
float l9_33=clamp(viewSpaceDepth()/1000.0,0.0,1.0);
sc_writeFragData0(vec4(max(0.0,1.0-(l9_33-0.0039215689)),min(1.0,l9_33+0.0039215689),0.0,0.0));
}
#endif
}
#else
{
#if (sc_OITDepthPrepass)
{
sc_writeFragData0(vec4(1.0));
}
#else
{
#if (sc_OITDepthGatherPass)
{
#if (sc_OITDepthGatherPass)
{
vec2 l9_34=sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw);
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture2D(sc_OITFrontDepthTexture,l9_34).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
int l9_35=encodeDepth(viewSpaceDepth(),texture2D(sc_OITFilteredDepthBoundsTexture,l9_34).xy);
float l9_36=packValue(l9_35);
int l9_43=int(l9_32.w*255.0);
float l9_44=packValue(l9_43);
sc_writeFragData0(vec4(packValue(l9_35),packValue(l9_35),packValue(l9_35),packValue(l9_35)));
sc_writeFragData1(vec4(l9_36,packValue(l9_35),packValue(l9_35),packValue(l9_35)));
sc_writeFragData2(vec4(l9_44,packValue(l9_43),packValue(l9_43),packValue(l9_43)));
#if (sc_OITMaxLayersVisualizeLayerCount)
{
sc_writeFragData2(vec4(0.0039215689,0.0,0.0,0.0));
}
#endif
}
#endif
}
#else
{
#if (sc_OITCompositingPass)
{
#if (sc_OITCompositingPass)
{
vec2 l9_47=sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw);
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture2D(sc_OITFrontDepthTexture,l9_47).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
int l9_48[8];
int l9_49[8];
int l9_50=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_50<8)
{
l9_48[l9_50]=0;
l9_49[l9_50]=0;
l9_50++;
continue;
}
else
{
break;
}
}
int l9_51;
#if (sc_OITMaxLayers8)
{
l9_51=2;
}
#else
{
l9_51=1;
}
#endif
int l9_52=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_52<l9_51)
{
vec4 l9_53;
vec4 l9_54;
vec4 l9_55;
if (l9_52==0)
{
l9_55=texture2D(sc_OITAlpha0,l9_47);
l9_54=texture2D(sc_OITDepthLow0,l9_47);
l9_53=texture2D(sc_OITDepthHigh0,l9_47);
}
else
{
l9_55=vec4(0.0);
l9_54=vec4(0.0);
l9_53=vec4(0.0);
}
vec4 l9_56;
vec4 l9_57;
vec4 l9_58;
if (l9_52==1)
{
l9_58=texture2D(sc_OITAlpha1,l9_47);
l9_57=texture2D(sc_OITDepthLow1,l9_47);
l9_56=texture2D(sc_OITDepthHigh1,l9_47);
}
else
{
l9_58=l9_55;
l9_57=l9_54;
l9_56=l9_53;
}
if (any(notEqual(l9_56,vec4(0.0)))||any(notEqual(l9_57,vec4(0.0))))
{
int l9_59[8]=l9_48;
unpackValues(l9_56.w,l9_52,l9_59);
unpackValues(l9_56.z,l9_52,l9_59);
unpackValues(l9_56.y,l9_52,l9_59);
unpackValues(l9_56.x,l9_52,l9_59);
unpackValues(l9_57.w,l9_52,l9_59);
unpackValues(l9_57.z,l9_52,l9_59);
unpackValues(l9_57.y,l9_52,l9_59);
unpackValues(l9_57.x,l9_52,l9_59);
int l9_68[8]=l9_49;
unpackValues(l9_58.w,l9_52,l9_68);
unpackValues(l9_58.z,l9_52,l9_68);
unpackValues(l9_58.y,l9_52,l9_68);
unpackValues(l9_58.x,l9_52,l9_68);
}
l9_52++;
continue;
}
else
{
break;
}
}
vec4 l9_73=texture2D(sc_OITFilteredDepthBoundsTexture,l9_47);
vec2 l9_74=l9_73.xy;
int l9_75;
#if (sc_SkinBonesCount>0)
{
l9_75=encodeDepth(((1.0-l9_73.x)*1000.0)+getDepthOrderingEpsilon(),l9_74);
}
#else
{
l9_75=0;
}
#endif
int l9_76=encodeDepth(viewSpaceDepth(),l9_74);
vec4 l9_77;
l9_77=l9_32*l9_32.w;
vec4 l9_78;
int l9_79=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_79<8)
{
int l9_80=l9_48[l9_79];
int l9_81=l9_76-l9_75;
bool l9_82=l9_80<l9_81;
bool l9_83;
if (l9_82)
{
l9_83=l9_48[l9_79]>0;
}
else
{
l9_83=l9_82;
}
if (l9_83)
{
vec3 l9_84=l9_77.xyz*(1.0-(float(l9_49[l9_79])/255.0));
l9_78=vec4(l9_84.x,l9_84.y,l9_84.z,l9_77.w);
}
else
{
l9_78=l9_77;
}
l9_77=l9_78;
l9_79++;
continue;
}
else
{
break;
}
}
sc_writeFragData0(l9_77);
#if (sc_OITMaxLayersVisualizeLayerCount)
{
discard;
}
#endif
}
#endif
}
#else
{
#if (sc_OITFrontLayerPass)
{
#if (sc_OITFrontLayerPass)
{
if (abs(gl_FragCoord.z-texture2D(sc_OITFrontDepthTexture,sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw)).x)>getFrontLayerZTestEpsilon())
{
discard;
}
sc_writeFragData0(l9_32);
}
#endif
}
#else
{
sc_writeFragData0(l9_31);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif // #elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
