#version 430
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
//output uvec4 position_and_mask 0
//output uvec4 normal_and_more 1
//sampler sampler baseTexSmpSC 2:28
//sampler sampler detailNormalTexSmpSC 2:29
//sampler sampler intensityTextureSmpSC 2:30
//sampler sampler normalTexSmpSC 2:31
//sampler sampler opacityTexSmpSC 2:32
//sampler sampler sc_EnvmapDiffuseSmpSC 2:33
//sampler sampler sc_EnvmapSpecularSmpSC 2:34
//sampler sampler sc_OITCommonSampler 2:35
//sampler sampler sc_RayTracedAoTextureSmpSC 2:36
//sampler sampler sc_RayTracedDiffIndTextureSmpSC 2:37
//sampler sampler sc_RayTracedShadowTextureSmpSC 2:39
//sampler sampler sc_SSAOTextureSmpSC 2:40
//sampler sampler sc_ScreenTextureSmpSC 2:41
//sampler sampler sc_ShadowTextureSmpSC 2:42
//sampler sampler z_hitIdAndBarycentricSmp 2:44
//sampler sampler z_rayDirectionsSmpSC 2:45
//texture texture2D baseTex 2:3:2:28
//texture texture2D detailNormalTex 2:4:2:29
//texture texture2D intensityTexture 2:5:2:30
//texture texture2D normalTex 2:6:2:31
//texture texture2D opacityTex 2:7:2:32
//texture texture2D sc_EnvmapDiffuse 2:8:2:33
//texture texture2D sc_EnvmapSpecular 2:9:2:34
//texture texture2D sc_OITAlpha0 2:10:2:35
//texture texture2D sc_OITAlpha1 2:11:2:35
//texture texture2D sc_OITDepthHigh0 2:12:2:35
//texture texture2D sc_OITDepthHigh1 2:13:2:35
//texture texture2D sc_OITDepthLow0 2:14:2:35
//texture texture2D sc_OITDepthLow1 2:15:2:35
//texture texture2D sc_OITFilteredDepthBoundsTexture 2:16:2:35
//texture texture2D sc_OITFrontDepthTexture 2:17:2:35
//texture texture2D sc_RayTracedAoTexture 2:18:2:36
//texture texture2D sc_RayTracedDiffIndTexture 2:19:2:37
//texture texture2D sc_RayTracedShadowTexture 2:21:2:39
//texture texture2D sc_SSAOTexture 2:22:2:40
//texture texture2D sc_ScreenTexture 2:23:2:41
//texture texture2D sc_ShadowTexture 2:24:2:42
//texture utexture2D z_hitIdAndBarycentric 2:26:2:44
//texture texture2D z_rayDirections 2:27:2:45
//texture texture2DArray baseTexArrSC 2:46:2:28
//texture texture2DArray detailNormalTexArrSC 2:47:2:29
//texture texture2DArray intensityTextureArrSC 2:48:2:30
//texture texture2DArray normalTexArrSC 2:49:2:31
//texture texture2DArray opacityTexArrSC 2:50:2:32
//texture texture2DArray sc_EnvmapDiffuseArrSC 2:51:2:33
//texture texture2DArray sc_EnvmapSpecularArrSC 2:52:2:34
//texture texture2DArray sc_RayTracedAoTextureArrSC 2:53:2:36
//texture texture2DArray sc_RayTracedDiffIndTextureArrSC 2:54:2:37
//texture texture2DArray sc_RayTracedShadowTextureArrSC 2:56:2:39
//texture texture2DArray sc_ScreenTextureArrSC 2:57:2:41
//ssbo int layoutIndices 2:0:0 {
//uint _Triangles 0:[]:4
//}
//ssbo float layoutVertices 2:1:0 {
//float _Vertices 0:[]:4
//}
//ssbo float layoutVerticesPN 2:2:0 {
//float _VerticesPN 0:[]:4
//}
//SG_REFLECTION_END
#if defined VERTEX_SHADER
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_FLAG_IS_NORMAL_MAP detailNormalTex
NGS_BACKEND_SHADER_FLAGS_END__
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
#ifdef uv2
#undef uv2
#endif
#ifdef uv3
#undef uv3
#endif
struct sc_Vertex_t
{
vec4 position;
vec3 normal;
vec3 tangent;
vec2 texture0;
vec2 texture1;
};
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
#ifndef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#elif UseViewSpaceDepthVariant==1
#undef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
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
layout(binding=0,std430) readonly buffer layoutIndices
{
uint _Triangles[];
} layoutIndices_obj;
layout(binding=1,std430) readonly buffer layoutVertices
{
float _Vertices[];
} layoutVertices_obj;
layout(binding=2,std430) readonly buffer layoutVerticesPN
{
float _VerticesPN[];
} layoutVerticesPN_obj;
uniform vec4 sc_EnvmapDiffuseDims;
uniform vec4 sc_EnvmapSpecularDims;
uniform vec4 sc_ScreenTextureDims;
uniform bool receivesRayTracedReflections;
uniform bool isProxyMode;
uniform bool receivesRayTracedShadows;
uniform bool receivesRayTracedDiffuseIndirect;
uniform bool receivesRayTracedAo;
uniform vec4 sc_RayTracedReflectionTextureDims;
uniform vec4 sc_RayTracedShadowTextureDims;
uniform vec4 sc_RayTracedDiffIndTextureDims;
uniform vec4 sc_RayTracedAoTextureDims;
uniform bool noEarlyZ;
uniform vec4 z_rayDirectionsDims;
uniform mat4 sc_ModelMatrix;
uniform mat4 sc_ProjectorMatrix;
uniform vec4 sc_StereoClipPlanes[sc_NumStereoViews];
uniform vec4 sc_BoneMatrices[(sc_SkinBonesCount*3)+1];
uniform mat3 sc_SkinBonesNormalMatrices[sc_SkinBonesCount+1];
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
uniform vec4 baseTexDims;
uniform vec4 opacityTexDims;
uniform vec4 normalTexDims;
uniform vec4 detailNormalTexDims;
uniform float depthRef;
uniform int overrideTimeEnabled;
uniform float overrideTimeElapsed;
uniform vec4 sc_Time;
uniform float overrideTimeDelta;
uniform sc_PointLight_t sc_PointLights[sc_PointLightsCount+1];
uniform sc_DirectionalLight_t sc_DirectionalLights[sc_DirectionalLightsCount+1];
uniform sc_AmbientLight_t sc_AmbientLights[sc_AmbientLightsCount+1];
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
uniform vec4 sc_GeometryInfo;
uniform mat4 sc_ModelViewProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ViewProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewMatrixInverseArray[sc_NumStereoViews];
uniform mat3 sc_ViewNormalMatrixArray[sc_NumStereoViews];
uniform mat3 sc_ViewNormalMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ViewMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ModelMatrixInverse;
uniform mat3 sc_NormalMatrixInverse;
uniform mat4 sc_PrevFrameModelMatrix;
uniform mat4 sc_PrevFrameModelMatrixInverse;
uniform vec3 sc_LocalAabbMin;
uniform vec3 sc_LocalAabbMax;
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
uniform vec4 sc_RayTracedReflectionTextureSize;
uniform vec4 sc_RayTracedReflectionTextureView;
uniform vec4 sc_RayTracedShadowTextureSize;
uniform vec4 sc_RayTracedShadowTextureView;
uniform vec4 sc_RayTracedDiffIndTextureSize;
uniform vec4 sc_RayTracedDiffIndTextureView;
uniform vec4 sc_RayTracedAoTextureSize;
uniform vec4 sc_RayTracedAoTextureView;
uniform float receiver_mask;
uniform vec3 OriginNormalizationScale;
uniform vec3 OriginNormalizationScaleInv;
uniform vec3 OriginNormalizationOffset;
uniform int receiverId;
uniform int instance_id;
uniform int lray_triangles_last;
uniform bool has_animated_pn;
uniform int emitter_stride;
uniform int proxy_offset_position;
uniform int proxy_offset_normal;
uniform int proxy_offset_tangent;
uniform int proxy_offset_color;
uniform int proxy_offset_texture0;
uniform int proxy_offset_texture1;
uniform int proxy_offset_texture2;
uniform int proxy_offset_texture3;
uniform int proxy_format_position;
uniform int proxy_format_normal;
uniform int proxy_format_tangent;
uniform int proxy_format_color;
uniform int proxy_format_texture0;
uniform int proxy_format_texture1;
uniform int proxy_format_texture2;
uniform int proxy_format_texture3;
uniform vec4 z_rayDirectionsSize;
uniform vec4 z_rayDirectionsView;
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
uniform vec3 recolorRed;
uniform vec4 baseColor;
uniform vec4 baseTexSize;
uniform vec4 baseTexView;
uniform mat3 baseTexTransform;
uniform vec4 baseTexUvMinMax;
uniform vec4 baseTexBorderColor;
uniform vec2 uv2Scale;
uniform vec2 uv2Offset;
uniform vec2 uv3Scale;
uniform vec2 uv3Offset;
uniform vec3 recolorGreen;
uniform vec3 recolorBlue;
uniform vec4 opacityTexSize;
uniform vec4 opacityTexView;
uniform mat3 opacityTexTransform;
uniform vec4 opacityTexUvMinMax;
uniform vec4 opacityTexBorderColor;
uniform vec4 normalTexSize;
uniform vec4 normalTexView;
uniform mat3 normalTexTransform;
uniform vec4 normalTexUvMinMax;
uniform vec4 normalTexBorderColor;
uniform vec4 detailNormalTexSize;
uniform vec4 detailNormalTexView;
uniform mat3 detailNormalTexTransform;
uniform vec4 detailNormalTexUvMinMax;
uniform vec4 detailNormalTexBorderColor;
uniform float colorMultiplier;
uniform vec4 Port_Import_N042;
uniform float Port_Input1_N044;
uniform float Port_Import_N088;
uniform vec3 Port_Import_N089;
uniform vec4 Port_Import_N384;
uniform float Port_Import_N307;
uniform float Port_Import_N201;
uniform float Port_Import_N012;
uniform float Port_Import_N010;
uniform float Port_Import_N007;
uniform vec2 Port_Import_N008;
uniform vec2 Port_Import_N009;
uniform float Port_Speed_N022;
uniform vec2 Port_Import_N254;
uniform float Port_Import_N065;
uniform float Port_Import_N055;
uniform float Port_Import_N056;
uniform vec2 Port_Import_N000;
uniform vec2 Port_Import_N060;
uniform vec2 Port_Import_N061;
uniform float Port_Speed_N063;
uniform vec2 Port_Import_N255;
uniform vec4 Port_Default_N369;
uniform vec4 Port_Import_N092;
uniform vec3 Port_Import_N090;
uniform vec3 Port_Import_N091;
uniform vec3 Port_Import_N144;
uniform float Port_Value2_N073;
uniform vec4 Port_Import_N166;
uniform float Port_Import_N206;
uniform float Port_Import_N043;
uniform vec2 Port_Import_N151;
uniform vec2 Port_Import_N155;
uniform float Port_Default_N204;
uniform float Port_Import_N047;
uniform float Port_Input1_N002;
uniform float Port_Input2_N072;
uniform float Port_Import_N336;
uniform float Port_Import_N160;
uniform vec2 Port_Import_N167;
uniform vec2 Port_Import_N207;
uniform float Port_Strength1_N200;
uniform float Port_Import_N095;
uniform float Port_Import_N108;
uniform vec3 Port_Default_N113;
uniform float Port_Strength2_N200;
uniform vec3 Port_Emissive_N036;
uniform vec3 Port_AO_N036;
out float varClipDistance;
flat out int varStereoViewID;
in vec4 boneData;
in vec3 blendShape0Pos;
in vec3 blendShape0Normal;
in vec3 blendShape1Pos;
in vec3 blendShape1Normal;
in vec3 blendShape2Pos;
in vec3 blendShape2Normal;
in vec3 blendShape3Pos;
in vec3 blendShape4Pos;
in vec3 blendShape5Pos;
in vec4 position;
in vec3 normal;
in vec4 tangent;
in vec2 texture0;
in vec2 texture1;
out vec3 varPos;
out vec3 varNormal;
out vec4 varTangent;
out vec4 varPackedTex;
out vec4 varScreenPos;
out vec2 varScreenTexturePos;
out vec2 varShadowTex;
out float varViewSpaceDepth;
out vec4 varColor;
in vec4 color;
out vec4 PreviewVertexColor;
out float PreviewVertexSaved;
in vec3 positionNext;
in vec3 positionPrevious;
in vec4 strandProperties;
void sc_SetClipDistancePlatform(float dstClipDistance)
{
    #if sc_StereoRenderingMode==sc_StereoRendering_InstancedClipped&&sc_StereoRendering_IsClipDistanceEnabled
        gl_ClipDistance[0]=dstClipDistance;
    #endif
}
void sc_SetClipDistance(float dstClipDistance)
{
#if (sc_StereoRendering_IsClipDistanceEnabled==1)
{
sc_SetClipDistancePlatform(dstClipDistance);
}
#else
{
varClipDistance=dstClipDistance;
}
#endif
}
void sc_SetClipDistance(vec4 clipPosition)
{
#if (sc_StereoRenderingMode==1)
{
sc_SetClipDistance(dot(clipPosition,sc_StereoClipPlanes[sc_StereoViewID]));
}
#endif
}
void sc_SetClipPosition(vec4 clipPosition)
{
#if (sc_StereoRenderingMode>0)
{
varStereoViewID=sc_StereoViewID;
}
#endif
sc_SetClipDistance(clipPosition);
gl_Position=clipPosition;
}
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
void main()
{
if (isProxyMode)
{
sc_SetClipPosition(vec4(position.xy,depthRef+(1e-10*position.z),1.0+(1e-10*position.w)));
return;
}
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
vec3 l9_30=varPos;
vec3 l9_31=varNormal;
vec3 l9_32;
vec3 l9_33;
vec3 l9_34;
if (l9_27)
{
l9_34=varTangent.xyz;
l9_33=varNormal;
l9_32=varPos;
}
else
{
l9_34=varTangent.xyz;
l9_33=l9_31;
l9_32=l9_30;
}
varPos=l9_32;
varNormal=normalize(l9_33);
vec3 l9_35=normalize(l9_34);
varTangent=vec4(l9_35.x,l9_35.y,l9_35.z,varTangent.w);
varTangent.w=tangent.w;
#if (UseViewSpaceDepthVariant&&((sc_OITDepthGatherPass||sc_OITCompositingPass)||sc_OITDepthBoundsPass))
{
vec4 l9_36;
#if (sc_RenderingSpace==3)
{
l9_36=sc_ProjectionMatrixInverseArray[sc_GetStereoViewIndex()]*l9_17;
}
#else
{
vec4 l9_37;
#if (sc_RenderingSpace==2)
{
l9_37=sc_ViewMatrixArray[sc_GetStereoViewIndex()]*l9_17;
}
#else
{
vec4 l9_38;
#if (sc_RenderingSpace==1)
{
l9_38=sc_ModelViewMatrixArray[sc_GetStereoViewIndex()]*l9_17;
}
#else
{
l9_38=l9_17;
}
#endif
l9_37=l9_38;
}
#endif
l9_36=l9_37;
}
#endif
varViewSpaceDepth=-l9_36.z;
}
#endif
vec4 l9_39;
#if (sc_RenderingSpace==3)
{
l9_39=l9_17;
}
#else
{
vec4 l9_40;
#if (sc_RenderingSpace==4)
{
l9_40=(sc_ModelViewMatrixArray[sc_GetStereoViewIndex()]*l9_17)*vec4(1.0/sc_Camera.aspect,1.0,1.0,1.0);
}
#else
{
vec4 l9_41;
#if (sc_RenderingSpace==2)
{
l9_41=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPos,1.0);
}
#else
{
vec4 l9_42;
#if (sc_RenderingSpace==1)
{
l9_42=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPos,1.0);
}
#else
{
l9_42=vec4(0.0);
}
#endif
l9_41=l9_42;
}
#endif
l9_40=l9_41;
}
#endif
l9_39=l9_40;
}
#endif
varPackedTex=vec4(l9_28,l9_2);
#if (sc_ProjectiveShadowsReceiver)
{
vec4 l9_43;
#if (sc_RenderingSpace==1)
{
l9_43=sc_ModelMatrix*l9_17;
}
#else
{
l9_43=l9_17;
}
#endif
vec4 l9_44=sc_ProjectorMatrix*l9_43;
varShadowTex=((l9_44.xy/vec2(l9_44.w))*0.5)+vec2(0.5);
}
#endif
vec4 l9_45;
#if (sc_DepthBufferMode==1)
{
vec4 l9_46=l9_39;
l9_46.z=((log2(max(sc_Camera.clipPlanes.x,1.0+l9_39.w))*(2.0/log2(sc_Camera.clipPlanes.y+1.0)))-1.0)*l9_39.w;
l9_45=l9_46;
}
#else
{
l9_45=l9_39;
}
#endif
sc_SetClipPosition(l9_45);
}
#elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
#if SC_RT_RECEIVER_MODE
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_FLAG_IS_NORMAL_MAP detailNormalTex
NGS_BACKEND_SHADER_FLAGS_END__
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
vec4 VertexColor;
vec2 Surface_UVCoord0;
vec2 Surface_UVCoord1;
vec2 gScreenCoord;
vec3 VertexTangent_WorldSpace;
vec3 VertexNormal_WorldSpace;
vec3 VertexBinormal_WorldSpace;
};
#ifndef sc_StereoRenderingMode
#define sc_StereoRenderingMode 0
#endif
#ifndef sc_NumStereoViews
#define sc_NumStereoViews 1
#endif
#ifndef sc_BlendMode_AlphaTest
#define sc_BlendMode_AlphaTest 0
#elif sc_BlendMode_AlphaTest==1
#undef sc_BlendMode_AlphaTest
#define sc_BlendMode_AlphaTest 1
#endif
struct sc_Camera_t
{
vec3 position;
float aspect;
vec2 clipPlanes;
};
#ifndef ENABLE_STIPPLE_PATTERN_TEST
#define ENABLE_STIPPLE_PATTERN_TEST 0
#elif ENABLE_STIPPLE_PATTERN_TEST==1
#undef ENABLE_STIPPLE_PATTERN_TEST
#define ENABLE_STIPPLE_PATTERN_TEST 1
#endif
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef opacityTexHasSwappedViews
#define opacityTexHasSwappedViews 0
#elif opacityTexHasSwappedViews==1
#undef opacityTexHasSwappedViews
#define opacityTexHasSwappedViews 1
#endif
#ifndef opacityTexLayout
#define opacityTexLayout 0
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
#ifndef detailNormalTexHasSwappedViews
#define detailNormalTexHasSwappedViews 0
#elif detailNormalTexHasSwappedViews==1
#undef detailNormalTexHasSwappedViews
#define detailNormalTexHasSwappedViews 1
#endif
#ifndef detailNormalTexLayout
#define detailNormalTexLayout 0
#endif
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
vec3 ambientLight;
};
#ifndef sc_AmbientLightsCount
#define sc_AmbientLightsCount 0
#endif
struct sc_AmbientLight_t
{
vec3 color;
float intensity;
};
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
#ifndef ENABLE_RECOLOR
#define ENABLE_RECOLOR 0
#elif ENABLE_RECOLOR==1
#undef ENABLE_RECOLOR
#define ENABLE_RECOLOR 1
#endif
#ifndef ENABLE_BASE_TEX
#define ENABLE_BASE_TEX 0
#elif ENABLE_BASE_TEX==1
#undef ENABLE_BASE_TEX
#define ENABLE_BASE_TEX 1
#endif
#ifndef ENABLE_UV2
#define ENABLE_UV2 0
#elif ENABLE_UV2==1
#undef ENABLE_UV2
#define ENABLE_UV2 1
#endif
#ifndef ENABLE_UV2_ANIMATION
#define ENABLE_UV2_ANIMATION 0
#elif ENABLE_UV2_ANIMATION==1
#undef ENABLE_UV2_ANIMATION
#define ENABLE_UV2_ANIMATION 1
#endif
#ifndef NODE_13_DROPLIST_ITEM
#define NODE_13_DROPLIST_ITEM 0
#endif
#ifndef ENABLE_UV3
#define ENABLE_UV3 0
#elif ENABLE_UV3==1
#undef ENABLE_UV3
#define ENABLE_UV3 1
#endif
#ifndef ENABLE_UV3_ANIMATION
#define ENABLE_UV3_ANIMATION 0
#elif ENABLE_UV3_ANIMATION==1
#undef ENABLE_UV3_ANIMATION
#define ENABLE_UV3_ANIMATION 1
#endif
#ifndef NODE_49_DROPLIST_ITEM
#define NODE_49_DROPLIST_ITEM 0
#endif
#ifndef NODE_27_DROPLIST_ITEM
#define NODE_27_DROPLIST_ITEM 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef NODE_38_DROPLIST_ITEM
#define NODE_38_DROPLIST_ITEM 0
#endif
#ifndef ENABLE_OPACITY_TEX
#define ENABLE_OPACITY_TEX 0
#elif ENABLE_OPACITY_TEX==1
#undef ENABLE_OPACITY_TEX
#define ENABLE_OPACITY_TEX 1
#endif
#ifndef NODE_69_DROPLIST_ITEM
#define NODE_69_DROPLIST_ITEM 0
#endif
#ifndef SC_USE_UV_TRANSFORM_opacityTex
#define SC_USE_UV_TRANSFORM_opacityTex 0
#elif SC_USE_UV_TRANSFORM_opacityTex==1
#undef SC_USE_UV_TRANSFORM_opacityTex
#define SC_USE_UV_TRANSFORM_opacityTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_opacityTex
#define SC_SOFTWARE_WRAP_MODE_U_opacityTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_opacityTex
#define SC_SOFTWARE_WRAP_MODE_V_opacityTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_opacityTex
#define SC_USE_UV_MIN_MAX_opacityTex 0
#elif SC_USE_UV_MIN_MAX_opacityTex==1
#undef SC_USE_UV_MIN_MAX_opacityTex
#define SC_USE_UV_MIN_MAX_opacityTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_opacityTex
#define SC_USE_CLAMP_TO_BORDER_opacityTex 0
#elif SC_USE_CLAMP_TO_BORDER_opacityTex==1
#undef SC_USE_CLAMP_TO_BORDER_opacityTex
#define SC_USE_CLAMP_TO_BORDER_opacityTex 1
#endif
#ifndef ENABLE_NORMALMAP
#define ENABLE_NORMALMAP 0
#elif ENABLE_NORMALMAP==1
#undef ENABLE_NORMALMAP
#define ENABLE_NORMALMAP 1
#endif
#ifndef NODE_181_DROPLIST_ITEM
#define NODE_181_DROPLIST_ITEM 0
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
#ifndef ENABLE_DETAIL_NORMAL
#define ENABLE_DETAIL_NORMAL 0
#elif ENABLE_DETAIL_NORMAL==1
#undef ENABLE_DETAIL_NORMAL
#define ENABLE_DETAIL_NORMAL 1
#endif
#ifndef NODE_184_DROPLIST_ITEM
#define NODE_184_DROPLIST_ITEM 0
#endif
#ifndef SC_USE_UV_TRANSFORM_detailNormalTex
#define SC_USE_UV_TRANSFORM_detailNormalTex 0
#elif SC_USE_UV_TRANSFORM_detailNormalTex==1
#undef SC_USE_UV_TRANSFORM_detailNormalTex
#define SC_USE_UV_TRANSFORM_detailNormalTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_detailNormalTex
#define SC_SOFTWARE_WRAP_MODE_U_detailNormalTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_detailNormalTex
#define SC_SOFTWARE_WRAP_MODE_V_detailNormalTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_detailNormalTex
#define SC_USE_UV_MIN_MAX_detailNormalTex 0
#elif SC_USE_UV_MIN_MAX_detailNormalTex==1
#undef SC_USE_UV_MIN_MAX_detailNormalTex
#define SC_USE_UV_MIN_MAX_detailNormalTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_detailNormalTex
#define SC_USE_CLAMP_TO_BORDER_detailNormalTex 0
#elif SC_USE_CLAMP_TO_BORDER_detailNormalTex==1
#undef SC_USE_CLAMP_TO_BORDER_detailNormalTex
#define SC_USE_CLAMP_TO_BORDER_detailNormalTex 1
#endif
#ifndef sc_DepthOnly
#define sc_DepthOnly 0
#elif sc_DepthOnly==1
#undef sc_DepthOnly
#define sc_DepthOnly 1
#endif
#ifndef sc_SkinBonesCount
#define sc_SkinBonesCount 0
#endif
layout(binding=0,std430) readonly buffer layoutIndices
{
uint _Triangles[];
} layoutIndices_obj;
layout(binding=1,std430) readonly buffer layoutVertices
{
float _Vertices[];
} layoutVertices_obj;
layout(binding=2,std430) readonly buffer layoutVerticesPN
{
float _VerticesPN[];
} layoutVerticesPN_obj;
uniform vec4 sc_EnvmapDiffuseDims;
uniform vec4 sc_EnvmapSpecularDims;
uniform vec4 sc_ScreenTextureDims;
uniform bool receivesRayTracedReflections;
uniform bool isProxyMode;
uniform bool receivesRayTracedShadows;
uniform bool receivesRayTracedDiffuseIndirect;
uniform bool receivesRayTracedAo;
uniform vec4 sc_RayTracedReflectionTextureDims;
uniform vec4 sc_RayTracedShadowTextureDims;
uniform vec4 sc_RayTracedDiffIndTextureDims;
uniform vec4 sc_RayTracedAoTextureDims;
uniform bool noEarlyZ;
uniform vec4 z_rayDirectionsDims;
uniform vec4 sc_WindowToViewportTransform;
uniform mat4 sc_ProjectionMatrixArray[sc_NumStereoViews];
uniform float sc_ShadowDensity;
uniform vec4 sc_ShadowColor;
uniform float shaderComplexityValue;
uniform mat4 sc_ViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameModelMatrix;
uniform mat4 sc_ModelMatrixInverse;
uniform sc_Camera_t sc_Camera;
uniform vec3 OriginNormalizationOffset;
uniform vec3 OriginNormalizationScale;
uniform float receiver_mask;
uniform int receiverId;
uniform vec4 intensityTextureDims;
uniform float alphaTestThreshold;
uniform vec4 baseTexDims;
uniform vec4 opacityTexDims;
uniform vec4 normalTexDims;
uniform vec4 detailNormalTexDims;
uniform sc_LightEstimationData_t sc_LightEstimationData;
uniform vec3 sc_EnvmapRotation;
uniform vec4 sc_EnvmapSpecularSize;
uniform vec4 sc_EnvmapDiffuseSize;
uniform float sc_EnvmapExposure;
uniform vec3 sc_Sh[9];
uniform float sc_ShIntensity;
uniform sc_AmbientLight_t sc_AmbientLights[sc_AmbientLightsCount+1];
uniform sc_DirectionalLight_t sc_DirectionalLights[sc_DirectionalLightsCount+1];
uniform sc_PointLight_t sc_PointLights[sc_PointLightsCount+1];
uniform vec3 recolorRed;
uniform vec4 baseColor;
uniform vec2 uv2Scale;
uniform vec2 uv2Offset;
uniform float Port_Speed_N022;
uniform vec2 uv3Scale;
uniform vec2 uv3Offset;
uniform float Port_Speed_N063;
uniform mat3 baseTexTransform;
uniform vec4 baseTexUvMinMax;
uniform vec4 baseTexBorderColor;
uniform vec3 recolorGreen;
uniform vec3 recolorBlue;
uniform vec4 Port_Default_N369;
uniform float Port_Value2_N073;
uniform mat3 opacityTexTransform;
uniform vec4 opacityTexUvMinMax;
uniform vec4 opacityTexBorderColor;
uniform mat3 normalTexTransform;
uniform vec4 normalTexUvMinMax;
uniform vec4 normalTexBorderColor;
uniform mat3 detailNormalTexTransform;
uniform vec4 detailNormalTexUvMinMax;
uniform vec4 detailNormalTexBorderColor;
uniform vec3 Port_Default_N113;
uniform float Port_Strength1_N200;
uniform float Port_Strength2_N200;
uniform float colorMultiplier;
uniform int overrideTimeEnabled;
uniform float overrideTimeElapsed;
uniform vec4 sc_Time;
uniform float overrideTimeDelta;
uniform float Port_Default_N204;
uniform float Port_Input2_N072;
uniform vec3 Port_Emissive_N036;
uniform vec3 Port_AO_N036;
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
uniform mat4 sc_ModelMatrix;
uniform mat3 sc_NormalMatrix;
uniform mat3 sc_NormalMatrixInverse;
uniform mat4 sc_PrevFrameModelMatrixInverse;
uniform vec3 sc_LocalAabbMin;
uniform vec3 sc_LocalAabbMax;
uniform vec3 sc_WorldAabbMin;
uniform vec3 sc_WorldAabbMax;
uniform mat4 sc_ProjectorMatrix;
uniform float _sc_GetFramebufferColorInvalidUsageMarker;
uniform float sc_DisableFrustumCullingMarker;
uniform vec4 sc_BoneMatrices[(sc_SkinBonesCount*3)+1];
uniform mat3 sc_SkinBonesNormalMatrices[sc_SkinBonesCount+1];
uniform vec4 weights0;
uniform vec4 weights1;
uniform vec4 weights2;
uniform vec4 sc_StereoClipPlanes[sc_NumStereoViews];
uniform int sc_FallbackInstanceID;
uniform float _sc_framebufferFetchMarker;
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
uniform vec4 sc_RayTracedReflectionTextureSize;
uniform vec4 sc_RayTracedReflectionTextureView;
uniform vec4 sc_RayTracedShadowTextureSize;
uniform vec4 sc_RayTracedShadowTextureView;
uniform vec4 sc_RayTracedDiffIndTextureSize;
uniform vec4 sc_RayTracedDiffIndTextureView;
uniform vec4 sc_RayTracedAoTextureSize;
uniform vec4 sc_RayTracedAoTextureView;
uniform vec3 OriginNormalizationScaleInv;
uniform int instance_id;
uniform int lray_triangles_last;
uniform bool has_animated_pn;
uniform int emitter_stride;
uniform int proxy_offset_position;
uniform int proxy_offset_normal;
uniform int proxy_offset_tangent;
uniform int proxy_offset_color;
uniform int proxy_offset_texture0;
uniform int proxy_offset_texture1;
uniform int proxy_offset_texture2;
uniform int proxy_offset_texture3;
uniform int proxy_format_position;
uniform int proxy_format_normal;
uniform int proxy_format_tangent;
uniform int proxy_format_color;
uniform int proxy_format_texture0;
uniform int proxy_format_texture1;
uniform int proxy_format_texture2;
uniform int proxy_format_texture3;
uniform vec4 z_rayDirectionsSize;
uniform vec4 z_rayDirectionsView;
uniform float correctedIntensity;
uniform vec4 intensityTextureSize;
uniform vec4 intensityTextureView;
uniform mat3 intensityTextureTransform;
uniform vec4 intensityTextureUvMinMax;
uniform vec4 intensityTextureBorderColor;
uniform float reflBlurWidth;
uniform float reflBlurMinRough;
uniform float reflBlurMaxRough;
uniform int PreviewEnabled;
uniform int PreviewNodeID;
uniform vec4 baseTexSize;
uniform vec4 baseTexView;
uniform vec4 opacityTexSize;
uniform vec4 opacityTexView;
uniform vec4 normalTexSize;
uniform vec4 normalTexView;
uniform vec4 detailNormalTexSize;
uniform vec4 detailNormalTexView;
uniform vec4 Port_Import_N042;
uniform float Port_Input1_N044;
uniform float Port_Import_N088;
uniform vec3 Port_Import_N089;
uniform vec4 Port_Import_N384;
uniform float Port_Import_N307;
uniform float Port_Import_N201;
uniform float Port_Import_N012;
uniform float Port_Import_N010;
uniform float Port_Import_N007;
uniform vec2 Port_Import_N008;
uniform vec2 Port_Import_N009;
uniform vec2 Port_Import_N254;
uniform float Port_Import_N065;
uniform float Port_Import_N055;
uniform float Port_Import_N056;
uniform vec2 Port_Import_N000;
uniform vec2 Port_Import_N060;
uniform vec2 Port_Import_N061;
uniform vec2 Port_Import_N255;
uniform vec4 Port_Import_N092;
uniform vec3 Port_Import_N090;
uniform vec3 Port_Import_N091;
uniform vec3 Port_Import_N144;
uniform vec4 Port_Import_N166;
uniform float Port_Import_N206;
uniform float Port_Import_N043;
uniform vec2 Port_Import_N151;
uniform vec2 Port_Import_N155;
uniform float Port_Import_N047;
uniform float Port_Input1_N002;
uniform float Port_Import_N336;
uniform float Port_Import_N160;
uniform vec2 Port_Import_N167;
uniform vec2 Port_Import_N207;
uniform float Port_Import_N095;
uniform float Port_Import_N108;
uniform float depthRef;
uniform sampler2D baseTex;
uniform sampler2DArray baseTexArrSC;
uniform sampler2D opacityTex;
uniform sampler2DArray opacityTexArrSC;
uniform sampler2D normalTex;
uniform sampler2DArray normalTexArrSC;
uniform sampler2D detailNormalTex;
uniform sampler2DArray detailNormalTexArrSC;
flat in int varStereoViewID;
in vec2 varShadowTex;
in float varClipDistance;
layout(location=0) out uvec4 position_and_mask;
layout(location=1) out uvec4 normal_and_more;
in vec3 varPos;
in vec4 varColor;
in vec4 varPackedTex;
in vec4 varTangent;
in vec3 varNormal;
in vec4 varScreenPos;
in vec2 varScreenTexturePos;
in float varViewSpaceDepth;
in vec4 PreviewVertexColor;
in float PreviewVertexSaved;
int sc_GetStereoViewIndex()
{
int l9_0;
#if (sc_StereoRenderingMode==0)
{
l9_0=0;
}
#else
{
l9_0=varStereoViewID;
}
#endif
return l9_0;
}
void Node17_Switch(float Switch,vec2 Value0,vec2 Value1,vec2 Value2,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (NODE_13_DROPLIST_ITEM==0)
{
Value0=Globals.Surface_UVCoord0;
Result=Value0;
}
#else
{
#if (NODE_13_DROPLIST_ITEM==1)
{
Value1=Globals.Surface_UVCoord1;
Result=Value1;
}
#else
{
#if (NODE_13_DROPLIST_ITEM==2)
{
Value2=Globals.gScreenCoord;
Result=Value2;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
#endif
}
#endif
}
void Node122_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV2_ANIMATION)
{
vec2 param_5;
Node17_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_5,Globals);
Value1=((param_5*uv2Scale)+uv2Offset)+(uv2Offset*(Globals.gTimeElapsed*Port_Speed_N022));
Result=Value1;
}
#else
{
vec2 param_12;
Node17_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_12,Globals);
Default=(param_12*uv2Scale)+uv2Offset;
Result=Default;
}
#endif
}
void Node1_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV2)
{
vec2 param_3;
Node122_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value1=param_3;
Result=Value1;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
void Node59_Switch(float Switch,vec2 Value0,vec2 Value1,vec2 Value2,vec2 Value3,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (NODE_49_DROPLIST_ITEM==0)
{
Value0=Globals.Surface_UVCoord0;
Result=Value0;
}
#else
{
#if (NODE_49_DROPLIST_ITEM==1)
{
Value1=Globals.Surface_UVCoord1;
Result=Value1;
}
#else
{
#if (NODE_49_DROPLIST_ITEM==2)
{
Value2=Globals.gScreenCoord;
Result=Value2;
}
#else
{
#if (NODE_49_DROPLIST_ITEM==3)
{
vec2 param_3;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value3=param_3;
Result=Value3;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
#endif
}
#endif
}
#endif
}
void Node64_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV3_ANIMATION)
{
vec2 param_6;
Node59_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_6,Globals);
Value1=((param_6*uv3Scale)+uv3Offset)+(uv3Offset*(Globals.gTimeElapsed*Port_Speed_N063));
Result=Value1;
}
#else
{
vec2 param_14;
Node59_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_14,Globals);
Default=(param_14*uv3Scale)+uv3Offset;
Result=Default;
}
#endif
}
void Node24_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV3)
{
vec2 param_3;
Node64_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value1=param_3;
Result=Value1;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
void Node388_Switch(float Switch,vec2 Value0,vec2 Value1,vec2 Value2,vec2 Value3,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (NODE_27_DROPLIST_ITEM==0)
{
Value0=Globals.Surface_UVCoord0;
Result=Value0;
}
#else
{
#if (NODE_27_DROPLIST_ITEM==1)
{
Value1=Globals.Surface_UVCoord1;
Result=Value1;
}
#else
{
#if (NODE_27_DROPLIST_ITEM==2)
{
vec2 param_3;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value2=param_3;
Result=Value2;
}
#else
{
#if (NODE_27_DROPLIST_ITEM==3)
{
vec2 param_8;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),param_8,Globals);
Value3=param_8;
Result=Value3;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
#endif
}
#endif
}
#endif
}
int baseTexGetStereoViewIndex()
{
int l9_0;
#if (baseTexHasSwappedViews)
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
return texture(texsmp,sc_SamplingCoordsViewToGlobal(uv,renderingLayout,viewIndex).xy,bias);
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
vec4 sc_SampleView(vec2 texSize,vec2 uv,int renderingLayout,int viewIndex,float bias,sampler2DArray texsmp)
{
return texture(texsmp,sc_SamplingCoordsViewToGlobal(uv,renderingLayout,viewIndex),bias);
}
vec4 sc_SampleTextureBiasOrLevel(vec2 samplerDims,int renderingLayout,int viewIndex,vec2 uv,bool useUvTransform,mat3 uvTransform,ivec2 softwareWrapModes,bool useUvMinMax,vec4 uvMinMax,bool useClampToBorder,vec4 borderColor,float biasOrLevel,sampler2DArray texture_sampler_)
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
void Node369_If_else(float Bool1,vec4 Value1,vec4 Default,out vec4 Result,ssGlobals Globals)
{
#if (ENABLE_BASE_TEX)
{
vec2 param_6;
Node388_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_6,Globals);
vec2 l9_0=param_6;
vec4 l9_1;
#if (baseTexLayout==2)
{
l9_1=sc_SampleTextureBiasOrLevel(baseTexDims.xy,baseTexLayout,baseTexGetStereoViewIndex(),l9_0,(int(SC_USE_UV_TRANSFORM_baseTex)!=0),baseTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex),(int(SC_USE_UV_MIN_MAX_baseTex)!=0),baseTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0),baseTexBorderColor,0.0,baseTexArrSC);
}
#else
{
l9_1=sc_SampleTextureBiasOrLevel(baseTexDims.xy,baseTexLayout,baseTexGetStereoViewIndex(),l9_0,(int(SC_USE_UV_TRANSFORM_baseTex)!=0),baseTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex),(int(SC_USE_UV_MIN_MAX_baseTex)!=0),baseTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0),baseTexBorderColor,0.0,baseTex);
}
#endif
Value1=l9_1;
Result=Value1;
}
#else
{
Result=Default;
}
#endif
}
void Node80_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (ENABLE_RECOLOR)
{
vec4 param_3;
Node369_If_else(0.0,vec4(0.0),Port_Default_N369,param_3,Globals);
vec4 l9_0=baseColor*param_3;
Value1=((recolorRed*vec3(l9_0.x))+(recolorGreen*vec3(l9_0.y)))+(recolorBlue*vec3(l9_0.z));
Result=Value1;
}
#else
{
vec4 param_8;
Node369_If_else(0.0,vec4(0.0),Port_Default_N369,param_8,Globals);
Default=(baseColor*param_8).xyz;
Result=Default;
}
#endif
}
int opacityTexGetStereoViewIndex()
{
int l9_0;
#if (opacityTexHasSwappedViews)
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
int normalTexGetStereoViewIndex()
{
int l9_0;
#if (normalTexHasSwappedViews)
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
int detailNormalTexGetStereoViewIndex()
{
int l9_0;
#if (detailNormalTexHasSwappedViews)
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
void main()
{
#if (sc_DepthOnly)
{
return;
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
vec2 l9_3=(gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw;
vec2 l9_4;
#if (sc_StereoRenderingMode==1)
{
vec3 l9_5=vec3(l9_3,0.0);
l9_5.y=((2.0*l9_3.y)+float(sc_GetStereoViewIndex()))-1.0;
l9_4=l9_5.xy;
}
#else
{
l9_4=l9_3;
}
#endif
vec3 l9_6=normalize(varTangent.xyz);
vec3 l9_7=normalize(varNormal);
ssGlobals l9_8=ssGlobals(l9_1,l9_2,0.0,vec3(0.0),normalize(sc_Camera.position-varPos),varPos,varColor,varPackedTex.xy,varPackedTex.zw,l9_4,l9_6,l9_7,cross(l9_7,l9_6)*varTangent.w);
#if (NODE_38_DROPLIST_ITEM==1)
{
vec3 l9_9;
Node80_If_else(0.0,vec3(0.0),vec3(0.0),l9_9,l9_8);
}
#else
{
vec3 l9_10;
Node80_If_else(0.0,vec3(0.0),vec3(0.0),l9_10,l9_8);
}
#endif
vec4 param_3;
Node369_If_else(0.0,vec4(0.0),Port_Default_N369,param_3,l9_8);
vec4 l9_11=param_3;
float l9_12;
#if (ENABLE_OPACITY_TEX)
{
vec2 l9_13;
#if (NODE_69_DROPLIST_ITEM==0)
{
l9_13=varPackedTex.xy;
}
#else
{
vec2 l9_14;
#if (NODE_69_DROPLIST_ITEM==1)
{
l9_14=varPackedTex.zw;
}
#else
{
vec2 l9_15;
#if (NODE_69_DROPLIST_ITEM==2)
{
vec2 l9_16;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),l9_16,l9_8);
l9_15=l9_16;
}
#else
{
vec2 l9_17;
#if (NODE_69_DROPLIST_ITEM==3)
{
vec2 l9_18;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),l9_18,l9_8);
l9_17=l9_18;
}
#else
{
l9_17=varPackedTex.xy;
}
#endif
l9_15=l9_17;
}
#endif
l9_14=l9_15;
}
#endif
l9_13=l9_14;
}
#endif
vec4 l9_19;
#if (opacityTexLayout==2)
{
l9_19=sc_SampleTextureBiasOrLevel(opacityTexDims.xy,opacityTexLayout,opacityTexGetStereoViewIndex(),l9_13,(int(SC_USE_UV_TRANSFORM_opacityTex)!=0),opacityTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex),(int(SC_USE_UV_MIN_MAX_opacityTex)!=0),opacityTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0),opacityTexBorderColor,0.0,opacityTexArrSC);
}
#else
{
l9_19=sc_SampleTextureBiasOrLevel(opacityTexDims.xy,opacityTexLayout,opacityTexGetStereoViewIndex(),l9_13,(int(SC_USE_UV_TRANSFORM_opacityTex)!=0),opacityTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex),(int(SC_USE_UV_MIN_MAX_opacityTex)!=0),opacityTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0),opacityTexBorderColor,0.0,opacityTex);
}
#endif
l9_12=l9_19.x;
}
#else
{
l9_12=Port_Default_N204;
}
#endif
float l9_20;
#if (NODE_38_DROPLIST_ITEM==1)
{
l9_20=varColor.w;
}
#else
{
l9_20=Port_Input2_N072;
}
#endif
float l9_21=(baseColor*l9_11).w*l9_12;
float l9_22=l9_21*l9_20;
#if (ENABLE_NORMALMAP)
{
vec2 l9_23;
#if (NODE_181_DROPLIST_ITEM==0)
{
l9_23=varPackedTex.xy;
}
#else
{
vec2 l9_24;
#if (NODE_181_DROPLIST_ITEM==1)
{
l9_24=varPackedTex.zw;
}
#else
{
vec2 l9_25;
#if (NODE_181_DROPLIST_ITEM==2)
{
vec2 l9_26;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),l9_26,l9_8);
l9_25=l9_26;
}
#else
{
vec2 l9_27;
#if (NODE_181_DROPLIST_ITEM==3)
{
vec2 l9_28;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),l9_28,l9_8);
l9_27=l9_28;
}
#else
{
l9_27=varPackedTex.xy;
}
#endif
l9_25=l9_27;
}
#endif
l9_24=l9_25;
}
#endif
l9_23=l9_24;
}
#endif
#if (normalTexLayout==2)
{
}
#else
{
}
#endif
#if (ENABLE_DETAIL_NORMAL)
{
vec2 l9_29;
#if (NODE_184_DROPLIST_ITEM==0)
{
l9_29=varPackedTex.xy;
}
#else
{
vec2 l9_30;
#if (NODE_184_DROPLIST_ITEM==1)
{
l9_30=varPackedTex.zw;
}
#else
{
vec2 l9_31;
#if (NODE_184_DROPLIST_ITEM==2)
{
vec2 l9_32;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),l9_32,l9_8);
l9_31=l9_32;
}
#else
{
vec2 l9_33;
#if (NODE_184_DROPLIST_ITEM==3)
{
vec2 l9_34;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),l9_34,l9_8);
l9_33=l9_34;
}
#else
{
l9_33=varPackedTex.xy;
}
#endif
l9_31=l9_33;
}
#endif
l9_30=l9_31;
}
#endif
l9_29=l9_30;
}
#endif
#if (detailNormalTexLayout==2)
{
}
#else
{
}
#endif
}
#else
{
}
#endif
}
#else
{
}
#endif
float l9_35=clamp(l9_22,0.0,1.0);
#if (sc_BlendMode_AlphaTest)
{
if (l9_35<alphaTestThreshold)
{
discard;
}
}
#endif
#if (ENABLE_STIPPLE_PATTERN_TEST)
{
if (l9_35<((mod(dot(floor(mod(gl_FragCoord.xy,vec2(4.0))),vec2(4.0,1.0))*9.0,16.0)+1.0)/17.0))
{
discard;
}
}
#endif
}
#else // #if SC_RT_RECEIVER_MODE
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_FLAG_IS_NORMAL_MAP detailNormalTex
NGS_BACKEND_SHADER_FLAGS_END__
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
#ifdef uv2
#undef uv2
#endif
#ifdef uv3
#undef uv3
#endif
struct RayHitPayload
{
vec3 viewDirWS;
vec3 positionWS;
vec3 normalWS;
vec4 tangentWS;
vec4 color;
vec2 uv0;
vec2 uv1;
vec2 uv2;
vec2 uv3;
uvec2 id;
};
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
vec4 VertexColor;
vec2 Surface_UVCoord0;
vec2 Surface_UVCoord1;
vec2 gScreenCoord;
vec3 VertexTangent_WorldSpace;
vec3 VertexNormal_WorldSpace;
vec3 VertexBinormal_WorldSpace;
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
#ifndef sc_RayTracedShadowTextureHasSwappedViews
#define sc_RayTracedShadowTextureHasSwappedViews 0
#elif sc_RayTracedShadowTextureHasSwappedViews==1
#undef sc_RayTracedShadowTextureHasSwappedViews
#define sc_RayTracedShadowTextureHasSwappedViews 1
#endif
#ifndef sc_RayTracedShadowTextureLayout
#define sc_RayTracedShadowTextureLayout 0
#endif
#ifndef sc_RayTracedDiffIndTextureHasSwappedViews
#define sc_RayTracedDiffIndTextureHasSwappedViews 0
#elif sc_RayTracedDiffIndTextureHasSwappedViews==1
#undef sc_RayTracedDiffIndTextureHasSwappedViews
#define sc_RayTracedDiffIndTextureHasSwappedViews 1
#endif
#ifndef sc_RayTracedDiffIndTextureLayout
#define sc_RayTracedDiffIndTextureLayout 0
#endif
#ifndef sc_RayTracedAoTextureHasSwappedViews
#define sc_RayTracedAoTextureHasSwappedViews 0
#elif sc_RayTracedAoTextureHasSwappedViews==1
#undef sc_RayTracedAoTextureHasSwappedViews
#define sc_RayTracedAoTextureHasSwappedViews 1
#endif
#ifndef sc_RayTracedAoTextureLayout
#define sc_RayTracedAoTextureLayout 0
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
#ifndef sc_ProxyAlphaOne
#define sc_ProxyAlphaOne 0
#elif sc_ProxyAlphaOne==1
#undef sc_ProxyAlphaOne
#define sc_ProxyAlphaOne 1
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
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef opacityTexHasSwappedViews
#define opacityTexHasSwappedViews 0
#elif opacityTexHasSwappedViews==1
#undef opacityTexHasSwappedViews
#define opacityTexHasSwappedViews 1
#endif
#ifndef opacityTexLayout
#define opacityTexLayout 0
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
#ifndef detailNormalTexHasSwappedViews
#define detailNormalTexHasSwappedViews 0
#elif detailNormalTexHasSwappedViews==1
#undef detailNormalTexHasSwappedViews
#define detailNormalTexHasSwappedViews 1
#endif
#ifndef detailNormalTexLayout
#define detailNormalTexLayout 0
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
#ifndef ENABLE_RECOLOR
#define ENABLE_RECOLOR 0
#elif ENABLE_RECOLOR==1
#undef ENABLE_RECOLOR
#define ENABLE_RECOLOR 1
#endif
#ifndef ENABLE_BASE_TEX
#define ENABLE_BASE_TEX 0
#elif ENABLE_BASE_TEX==1
#undef ENABLE_BASE_TEX
#define ENABLE_BASE_TEX 1
#endif
#ifndef ENABLE_UV2
#define ENABLE_UV2 0
#elif ENABLE_UV2==1
#undef ENABLE_UV2
#define ENABLE_UV2 1
#endif
#ifndef ENABLE_UV2_ANIMATION
#define ENABLE_UV2_ANIMATION 0
#elif ENABLE_UV2_ANIMATION==1
#undef ENABLE_UV2_ANIMATION
#define ENABLE_UV2_ANIMATION 1
#endif
#ifndef NODE_13_DROPLIST_ITEM
#define NODE_13_DROPLIST_ITEM 0
#endif
#ifndef ENABLE_UV3
#define ENABLE_UV3 0
#elif ENABLE_UV3==1
#undef ENABLE_UV3
#define ENABLE_UV3 1
#endif
#ifndef ENABLE_UV3_ANIMATION
#define ENABLE_UV3_ANIMATION 0
#elif ENABLE_UV3_ANIMATION==1
#undef ENABLE_UV3_ANIMATION
#define ENABLE_UV3_ANIMATION 1
#endif
#ifndef NODE_49_DROPLIST_ITEM
#define NODE_49_DROPLIST_ITEM 0
#endif
#ifndef NODE_27_DROPLIST_ITEM
#define NODE_27_DROPLIST_ITEM 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef NODE_38_DROPLIST_ITEM
#define NODE_38_DROPLIST_ITEM 0
#endif
#ifndef ENABLE_OPACITY_TEX
#define ENABLE_OPACITY_TEX 0
#elif ENABLE_OPACITY_TEX==1
#undef ENABLE_OPACITY_TEX
#define ENABLE_OPACITY_TEX 1
#endif
#ifndef NODE_69_DROPLIST_ITEM
#define NODE_69_DROPLIST_ITEM 0
#endif
#ifndef SC_USE_UV_TRANSFORM_opacityTex
#define SC_USE_UV_TRANSFORM_opacityTex 0
#elif SC_USE_UV_TRANSFORM_opacityTex==1
#undef SC_USE_UV_TRANSFORM_opacityTex
#define SC_USE_UV_TRANSFORM_opacityTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_opacityTex
#define SC_SOFTWARE_WRAP_MODE_U_opacityTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_opacityTex
#define SC_SOFTWARE_WRAP_MODE_V_opacityTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_opacityTex
#define SC_USE_UV_MIN_MAX_opacityTex 0
#elif SC_USE_UV_MIN_MAX_opacityTex==1
#undef SC_USE_UV_MIN_MAX_opacityTex
#define SC_USE_UV_MIN_MAX_opacityTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_opacityTex
#define SC_USE_CLAMP_TO_BORDER_opacityTex 0
#elif SC_USE_CLAMP_TO_BORDER_opacityTex==1
#undef SC_USE_CLAMP_TO_BORDER_opacityTex
#define SC_USE_CLAMP_TO_BORDER_opacityTex 1
#endif
#ifndef ENABLE_NORMALMAP
#define ENABLE_NORMALMAP 0
#elif ENABLE_NORMALMAP==1
#undef ENABLE_NORMALMAP
#define ENABLE_NORMALMAP 1
#endif
#ifndef NODE_181_DROPLIST_ITEM
#define NODE_181_DROPLIST_ITEM 0
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
#ifndef ENABLE_DETAIL_NORMAL
#define ENABLE_DETAIL_NORMAL 0
#elif ENABLE_DETAIL_NORMAL==1
#undef ENABLE_DETAIL_NORMAL
#define ENABLE_DETAIL_NORMAL 1
#endif
#ifndef NODE_184_DROPLIST_ITEM
#define NODE_184_DROPLIST_ITEM 0
#endif
#ifndef SC_USE_UV_TRANSFORM_detailNormalTex
#define SC_USE_UV_TRANSFORM_detailNormalTex 0
#elif SC_USE_UV_TRANSFORM_detailNormalTex==1
#undef SC_USE_UV_TRANSFORM_detailNormalTex
#define SC_USE_UV_TRANSFORM_detailNormalTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_detailNormalTex
#define SC_SOFTWARE_WRAP_MODE_U_detailNormalTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_detailNormalTex
#define SC_SOFTWARE_WRAP_MODE_V_detailNormalTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_detailNormalTex
#define SC_USE_UV_MIN_MAX_detailNormalTex 0
#elif SC_USE_UV_MIN_MAX_detailNormalTex==1
#undef SC_USE_UV_MIN_MAX_detailNormalTex
#define SC_USE_UV_MIN_MAX_detailNormalTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_detailNormalTex
#define SC_USE_CLAMP_TO_BORDER_detailNormalTex 0
#elif SC_USE_CLAMP_TO_BORDER_detailNormalTex==1
#undef SC_USE_CLAMP_TO_BORDER_detailNormalTex
#define SC_USE_CLAMP_TO_BORDER_detailNormalTex 1
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
layout(binding=1,std430) readonly buffer layoutVertices
{
float _Vertices[];
} layoutVertices_obj;
layout(binding=2,std430) readonly buffer layoutVerticesPN
{
float _VerticesPN[];
} layoutVerticesPN_obj;
layout(binding=0,std430) readonly buffer layoutIndices
{
uint _Triangles[];
} layoutIndices_obj;
uniform vec4 sc_EnvmapDiffuseDims;
uniform vec4 sc_EnvmapSpecularDims;
uniform vec4 sc_ScreenTextureDims;
uniform bool receivesRayTracedReflections;
uniform bool isProxyMode;
uniform bool receivesRayTracedShadows;
uniform bool receivesRayTracedDiffuseIndirect;
uniform bool receivesRayTracedAo;
uniform vec4 sc_RayTracedReflectionTextureDims;
uniform vec4 sc_RayTracedShadowTextureDims;
uniform vec4 sc_RayTracedDiffIndTextureDims;
uniform vec4 sc_RayTracedAoTextureDims;
uniform bool noEarlyZ;
uniform vec4 z_rayDirectionsDims;
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
uniform int emitter_stride;
uniform int proxy_offset_position;
uniform int proxy_format_position;
uniform int proxy_offset_normal;
uniform int proxy_format_normal;
uniform int proxy_offset_tangent;
uniform int proxy_format_tangent;
uniform int proxy_offset_color;
uniform int proxy_format_color;
uniform int proxy_offset_texture0;
uniform int proxy_format_texture0;
uniform int proxy_offset_texture1;
uniform int proxy_format_texture1;
uniform int proxy_offset_texture2;
uniform int proxy_format_texture2;
uniform int proxy_offset_texture3;
uniform int proxy_format_texture3;
uniform int lray_triangles_last;
uniform int instance_id;
uniform bool has_animated_pn;
uniform mat4 sc_ModelMatrix;
uniform mat3 sc_NormalMatrix;
uniform vec4 intensityTextureDims;
uniform float correctedIntensity;
uniform mat3 intensityTextureTransform;
uniform vec4 intensityTextureUvMinMax;
uniform vec4 intensityTextureBorderColor;
uniform float alphaTestThreshold;
uniform vec4 baseTexDims;
uniform vec4 opacityTexDims;
uniform vec4 normalTexDims;
uniform vec4 detailNormalTexDims;
uniform sc_LightEstimationData_t sc_LightEstimationData;
uniform vec3 sc_EnvmapRotation;
uniform vec4 sc_EnvmapSpecularSize;
uniform vec4 sc_EnvmapDiffuseSize;
uniform float sc_EnvmapExposure;
uniform vec3 sc_Sh[9];
uniform float sc_ShIntensity;
uniform sc_AmbientLight_t sc_AmbientLights[sc_AmbientLightsCount+1];
uniform sc_DirectionalLight_t sc_DirectionalLights[sc_DirectionalLightsCount+1];
uniform sc_PointLight_t sc_PointLights[sc_PointLightsCount+1];
uniform vec3 recolorRed;
uniform vec4 baseColor;
uniform vec2 uv2Scale;
uniform vec2 uv2Offset;
uniform float Port_Speed_N022;
uniform vec2 uv3Scale;
uniform vec2 uv3Offset;
uniform float Port_Speed_N063;
uniform mat3 baseTexTransform;
uniform vec4 baseTexUvMinMax;
uniform vec4 baseTexBorderColor;
uniform vec3 recolorGreen;
uniform vec3 recolorBlue;
uniform vec4 Port_Default_N369;
uniform mat3 opacityTexTransform;
uniform vec4 opacityTexUvMinMax;
uniform vec4 opacityTexBorderColor;
uniform mat3 normalTexTransform;
uniform vec4 normalTexUvMinMax;
uniform vec4 normalTexBorderColor;
uniform mat3 detailNormalTexTransform;
uniform vec4 detailNormalTexUvMinMax;
uniform vec4 detailNormalTexBorderColor;
uniform vec3 Port_Default_N113;
uniform float Port_Strength1_N200;
uniform float Port_Strength2_N200;
uniform float colorMultiplier;
uniform int overrideTimeEnabled;
uniform float overrideTimeElapsed;
uniform vec4 sc_Time;
uniform float overrideTimeDelta;
uniform sc_Camera_t sc_Camera;
uniform float Port_Default_N204;
uniform float Port_Input2_N072;
uniform vec3 Port_Emissive_N036;
uniform vec3 Port_AO_N036;
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
uniform mat3 sc_NormalMatrixInverse;
uniform mat4 sc_PrevFrameModelMatrixInverse;
uniform vec3 sc_LocalAabbMin;
uniform vec3 sc_LocalAabbMax;
uniform vec3 sc_WorldAabbMin;
uniform vec3 sc_WorldAabbMax;
uniform mat4 sc_ProjectorMatrix;
uniform float sc_DisableFrustumCullingMarker;
uniform vec4 sc_BoneMatrices[(sc_SkinBonesCount*3)+1];
uniform mat3 sc_SkinBonesNormalMatrices[sc_SkinBonesCount+1];
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
uniform vec4 sc_RayTracedReflectionTextureSize;
uniform vec4 sc_RayTracedReflectionTextureView;
uniform vec4 sc_RayTracedShadowTextureSize;
uniform vec4 sc_RayTracedShadowTextureView;
uniform vec4 sc_RayTracedDiffIndTextureSize;
uniform vec4 sc_RayTracedDiffIndTextureView;
uniform vec4 sc_RayTracedAoTextureSize;
uniform vec4 sc_RayTracedAoTextureView;
uniform float receiver_mask;
uniform vec3 OriginNormalizationScale;
uniform vec3 OriginNormalizationScaleInv;
uniform vec3 OriginNormalizationOffset;
uniform int receiverId;
uniform vec4 z_rayDirectionsSize;
uniform vec4 z_rayDirectionsView;
uniform vec4 intensityTextureSize;
uniform vec4 intensityTextureView;
uniform float reflBlurWidth;
uniform float reflBlurMinRough;
uniform float reflBlurMaxRough;
uniform int PreviewNodeID;
uniform vec4 baseTexSize;
uniform vec4 baseTexView;
uniform vec4 opacityTexSize;
uniform vec4 opacityTexView;
uniform vec4 normalTexSize;
uniform vec4 normalTexView;
uniform vec4 detailNormalTexSize;
uniform vec4 detailNormalTexView;
uniform vec4 Port_Import_N042;
uniform float Port_Input1_N044;
uniform float Port_Import_N088;
uniform vec3 Port_Import_N089;
uniform vec4 Port_Import_N384;
uniform float Port_Import_N307;
uniform float Port_Import_N201;
uniform float Port_Import_N012;
uniform float Port_Import_N010;
uniform float Port_Import_N007;
uniform vec2 Port_Import_N008;
uniform vec2 Port_Import_N009;
uniform vec2 Port_Import_N254;
uniform float Port_Import_N065;
uniform float Port_Import_N055;
uniform float Port_Import_N056;
uniform vec2 Port_Import_N000;
uniform vec2 Port_Import_N060;
uniform vec2 Port_Import_N061;
uniform vec2 Port_Import_N255;
uniform vec4 Port_Import_N092;
uniform vec3 Port_Import_N090;
uniform vec3 Port_Import_N091;
uniform vec3 Port_Import_N144;
uniform vec4 Port_Import_N166;
uniform float Port_Import_N206;
uniform float Port_Import_N043;
uniform vec2 Port_Import_N151;
uniform vec2 Port_Import_N155;
uniform float Port_Import_N047;
uniform float Port_Input1_N002;
uniform float Port_Import_N336;
uniform float Port_Import_N160;
uniform vec2 Port_Import_N167;
uniform vec2 Port_Import_N207;
uniform float Port_Import_N095;
uniform float Port_Import_N108;
uniform float depthRef;
uniform usampler2D z_hitIdAndBarycentric;
uniform sampler2D z_rayDirections;
uniform sampler2D baseTex;
uniform sampler2DArray baseTexArrSC;
uniform sampler2D opacityTex;
uniform sampler2DArray opacityTexArrSC;
uniform sampler2D normalTex;
uniform sampler2DArray normalTexArrSC;
uniform sampler2D detailNormalTex;
uniform sampler2DArray detailNormalTexArrSC;
uniform sampler2D sc_SSAOTexture;
uniform sampler2D sc_ShadowTexture;
uniform sampler2D sc_RayTracedShadowTexture;
uniform sampler2DArray sc_RayTracedShadowTextureArrSC;
uniform sampler2D sc_EnvmapSpecular;
uniform sampler2DArray sc_EnvmapSpecularArrSC;
uniform sampler2D sc_EnvmapDiffuse;
uniform sampler2DArray sc_EnvmapDiffuseArrSC;
uniform sampler2D sc_RayTracedDiffIndTexture;
uniform sampler2DArray sc_RayTracedDiffIndTextureArrSC;
uniform sampler2D sc_ScreenTexture;
uniform sampler2DArray sc_ScreenTextureArrSC;
uniform sampler2D sc_RayTracedAoTexture;
uniform sampler2DArray sc_RayTracedAoTextureArrSC;
uniform sampler2D intensityTexture;
uniform sampler2DArray intensityTextureArrSC;
uniform sampler2D sc_OITFrontDepthTexture;
uniform sampler2D sc_OITDepthHigh0;
uniform sampler2D sc_OITDepthLow0;
uniform sampler2D sc_OITAlpha0;
uniform sampler2D sc_OITDepthHigh1;
uniform sampler2D sc_OITDepthLow1;
uniform sampler2D sc_OITAlpha1;
uniform sampler2D sc_OITFilteredDepthBoundsTexture;
flat in int varStereoViewID;
in vec2 varShadowTex;
in float varClipDistance;
in float varViewSpaceDepth;
in vec4 PreviewVertexColor;
in float PreviewVertexSaved;
in vec3 varPos;
in vec4 varColor;
in vec4 varPackedTex;
in vec4 varTangent;
in vec3 varNormal;
in vec4 varScreenPos;
in vec2 varScreenTexturePos;
int sc_GetStereoViewIndex()
{
int l9_0;
#if (sc_StereoRenderingMode==0)
{
l9_0=0;
}
#else
{
l9_0=varStereoViewID;
}
#endif
return l9_0;
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
vec3 interp_float3_animated(vec3 brc,ivec3 indices,int offset)
{
ivec3 l9_0=(indices*ivec3(6))+ivec3(offset);
int l9_1=l9_0.x;
int l9_2=l9_0.y;
int l9_3=l9_0.z;
return ((vec3(layoutVerticesPN_obj._VerticesPN[l9_1],layoutVerticesPN_obj._VerticesPN[l9_1+1],layoutVerticesPN_obj._VerticesPN[l9_1+2])*brc.x)+(vec3(layoutVerticesPN_obj._VerticesPN[l9_2],layoutVerticesPN_obj._VerticesPN[l9_2+1],layoutVerticesPN_obj._VerticesPN[l9_2+2])*brc.y))+(vec3(layoutVerticesPN_obj._VerticesPN[l9_3],layoutVerticesPN_obj._VerticesPN[l9_3+1],layoutVerticesPN_obj._VerticesPN[l9_3+2])*brc.z);
}
vec4 fetch_unorm_byte4(int offset)
{
uint l9_0=floatBitsToUint(layoutVertices_obj._Vertices[offset]);
return vec4(float(l9_0&255u),float((l9_0>>uint(8))&255u),float((l9_0>>uint(16))&255u),float((l9_0>>uint(24))&255u))/vec4(255.0);
}
RayHitPayload GetHitData(ivec2 screenPos)
{
ivec2 l9_0=screenPos;
uvec4 l9_1=texelFetch(z_hitIdAndBarycentric,l9_0,0);
uvec2 l9_2=l9_1.xy;
if (l9_1.x!=uint(instance_id))
{
return RayHitPayload(vec3(0.0),vec3(0.0),vec3(0.0),vec4(0.0),vec4(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),l9_2);
}
vec2 l9_3=unpackHalf2x16(l9_1.z|(l9_1.w<<uint(16)));
float l9_4=l9_3.x;
float l9_5=l9_3.y;
float l9_6=(1.0-l9_4)-l9_5;
vec3 l9_7=vec3(l9_6,l9_4,l9_5);
ivec2 l9_8=screenPos;
vec4 l9_9=texelFetch(z_rayDirections,l9_8,0);
float l9_10=l9_9.x;
float l9_11=l9_9.y;
float l9_12=(1.0-abs(l9_10))-abs(l9_11);
vec3 l9_13=vec3(l9_10,l9_11,l9_12);
float l9_14=clamp(-l9_12,0.0,1.0);
float l9_15;
if (l9_10>=0.0)
{
l9_15=-l9_14;
}
else
{
l9_15=l9_14;
}
float l9_16;
if (l9_11>=0.0)
{
l9_16=-l9_14;
}
else
{
l9_16=l9_14;
}
vec2 l9_17=vec2(l9_15,l9_16);
vec2 l9_18=l9_13.xy+l9_17;
uint l9_19=min(l9_1.y,uint(lray_triangles_last))*6u;
uint l9_20=l9_19&4294967292u;
uint l9_21=l9_20/4u;
uint l9_22=layoutIndices_obj._Triangles[l9_21];
uint l9_23=l9_21+1u;
uint l9_24=layoutIndices_obj._Triangles[l9_23];
uvec4 l9_25=(uvec4(l9_22,l9_22,l9_24,l9_24)&uvec4(65535u,4294967295u,65535u,4294967295u))>>uvec4(0u,16u,0u,16u);
ivec3 l9_26;
if (l9_19==l9_20)
{
l9_26=ivec3(l9_25.xyz);
}
else
{
l9_26=ivec3(l9_25.yzw);
}
vec3 l9_27;
if (has_animated_pn)
{
l9_27=interp_float3_animated(l9_7,l9_26,0);
}
else
{
int l9_28=(l9_26.x*emitter_stride)+proxy_offset_position;
int l9_29=(l9_26.y*emitter_stride)+proxy_offset_position;
int l9_30=(l9_26.z*emitter_stride)+proxy_offset_position;
vec3 l9_31;
if (proxy_format_position==5)
{
l9_31=((vec3(layoutVertices_obj._Vertices[l9_28],layoutVertices_obj._Vertices[l9_28+1],layoutVertices_obj._Vertices[l9_28+2])*l9_6)+(vec3(layoutVertices_obj._Vertices[l9_29],layoutVertices_obj._Vertices[l9_29+1],layoutVertices_obj._Vertices[l9_29+2])*l9_4))+(vec3(layoutVertices_obj._Vertices[l9_30],layoutVertices_obj._Vertices[l9_30+1],layoutVertices_obj._Vertices[l9_30+2])*l9_5);
}
else
{
vec3 l9_32;
if (proxy_format_position==6)
{
l9_32=((vec3(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_28])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_28+1])).x)*l9_6)+(vec3(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_29])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_29+1])).x)*l9_4))+(vec3(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_30])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_30+1])).x)*l9_5);
}
else
{
l9_32=vec3(1.0,0.0,0.0);
}
l9_31=l9_32;
}
l9_27=(sc_ModelMatrix*vec4(l9_31,1.0)).xyz;
}
vec3 l9_33;
if (proxy_offset_normal>0)
{
vec3 l9_34;
if (has_animated_pn)
{
l9_34=interp_float3_animated(l9_7,l9_26,3);
}
else
{
int l9_35=(l9_26.x*emitter_stride)+proxy_offset_normal;
int l9_36=(l9_26.y*emitter_stride)+proxy_offset_normal;
int l9_37=(l9_26.z*emitter_stride)+proxy_offset_normal;
vec3 l9_38;
if (proxy_format_normal==5)
{
l9_38=((vec3(layoutVertices_obj._Vertices[l9_35],layoutVertices_obj._Vertices[l9_35+1],layoutVertices_obj._Vertices[l9_35+2])*l9_6)+(vec3(layoutVertices_obj._Vertices[l9_36],layoutVertices_obj._Vertices[l9_36+1],layoutVertices_obj._Vertices[l9_36+2])*l9_4))+(vec3(layoutVertices_obj._Vertices[l9_37],layoutVertices_obj._Vertices[l9_37+1],layoutVertices_obj._Vertices[l9_37+2])*l9_5);
}
else
{
vec3 l9_39;
if (proxy_format_normal==6)
{
l9_39=((vec3(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_35])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_35+1])).x)*l9_6)+(vec3(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_36])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_36+1])).x)*l9_4))+(vec3(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_37])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_37+1])).x)*l9_5);
}
else
{
l9_39=vec3(1.0,0.0,0.0);
}
l9_38=l9_39;
}
l9_34=normalize(sc_NormalMatrix*l9_38);
}
l9_33=l9_34;
}
else
{
l9_33=vec3(1.0,0.0,0.0);
}
vec4 l9_40;
if ((!has_animated_pn)&&(proxy_offset_tangent>0))
{
int l9_41=(l9_26.x*emitter_stride)+proxy_offset_tangent;
int l9_42=(l9_26.y*emitter_stride)+proxy_offset_tangent;
int l9_43=(l9_26.z*emitter_stride)+proxy_offset_tangent;
vec4 l9_44;
if (proxy_format_tangent==5)
{
l9_44=((vec4(layoutVertices_obj._Vertices[l9_41],layoutVertices_obj._Vertices[l9_41+1],layoutVertices_obj._Vertices[l9_41+2],layoutVertices_obj._Vertices[l9_41+3])*l9_6)+(vec4(layoutVertices_obj._Vertices[l9_42],layoutVertices_obj._Vertices[l9_42+1],layoutVertices_obj._Vertices[l9_42+2],layoutVertices_obj._Vertices[l9_42+3])*l9_4))+(vec4(layoutVertices_obj._Vertices[l9_43],layoutVertices_obj._Vertices[l9_43+1],layoutVertices_obj._Vertices[l9_43+2],layoutVertices_obj._Vertices[l9_43+3])*l9_5);
}
else
{
vec4 l9_45;
if (proxy_format_tangent==6)
{
l9_45=((vec4(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_41])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_41+1])))*l9_6)+(vec4(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_42])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_42+1])))*l9_4))+(vec4(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_43])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_43+1])))*l9_5);
}
else
{
vec4 l9_46;
if (proxy_format_tangent==2)
{
l9_46=((fetch_unorm_byte4(l9_41)*l9_6)+(fetch_unorm_byte4(l9_42)*l9_4))+(fetch_unorm_byte4(l9_43)*l9_5);
}
else
{
l9_46=vec4(1.0,0.0,0.0,0.0);
}
l9_45=l9_46;
}
l9_44=l9_45;
}
l9_40=vec4(normalize(sc_NormalMatrix*l9_44.xyz),l9_44.w);
}
else
{
l9_40=vec4(1.0,0.0,0.0,1.0);
}
vec4 l9_47;
if (proxy_format_color>0)
{
int l9_48=(l9_26.x*emitter_stride)+proxy_offset_color;
int l9_49=(l9_26.y*emitter_stride)+proxy_offset_color;
int l9_50=(l9_26.z*emitter_stride)+proxy_offset_color;
vec4 l9_51;
if (proxy_format_color==5)
{
l9_51=((vec4(layoutVertices_obj._Vertices[l9_48],layoutVertices_obj._Vertices[l9_48+1],layoutVertices_obj._Vertices[l9_48+2],layoutVertices_obj._Vertices[l9_48+3])*l9_6)+(vec4(layoutVertices_obj._Vertices[l9_49],layoutVertices_obj._Vertices[l9_49+1],layoutVertices_obj._Vertices[l9_49+2],layoutVertices_obj._Vertices[l9_49+3])*l9_4))+(vec4(layoutVertices_obj._Vertices[l9_50],layoutVertices_obj._Vertices[l9_50+1],layoutVertices_obj._Vertices[l9_50+2],layoutVertices_obj._Vertices[l9_50+3])*l9_5);
}
else
{
vec4 l9_52;
if (proxy_format_color==6)
{
l9_52=((vec4(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_48])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_48+1])))*l9_6)+(vec4(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_49])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_49+1])))*l9_4))+(vec4(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_50])),unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_50+1])))*l9_5);
}
else
{
vec4 l9_53;
if (proxy_format_color==2)
{
l9_53=((fetch_unorm_byte4(l9_48)*l9_6)+(fetch_unorm_byte4(l9_49)*l9_4))+(fetch_unorm_byte4(l9_50)*l9_5);
}
else
{
l9_53=vec4(1.0,0.0,0.0,0.0);
}
l9_52=l9_53;
}
l9_51=l9_52;
}
l9_47=l9_51;
}
else
{
l9_47=vec4(0.0);
}
ivec3 l9_54=l9_26%ivec3(2);
vec2 l9_55=vec2(dot(l9_7,vec3(ivec3(1)-l9_54)),0.0);
vec2 l9_56;
if (proxy_format_texture0>0)
{
int l9_57=(l9_26.x*emitter_stride)+proxy_offset_texture0;
int l9_58=(l9_26.y*emitter_stride)+proxy_offset_texture0;
int l9_59=(l9_26.z*emitter_stride)+proxy_offset_texture0;
vec2 l9_60;
if (proxy_format_texture0==5)
{
l9_60=((vec2(layoutVertices_obj._Vertices[l9_57],layoutVertices_obj._Vertices[l9_57+1])*l9_6)+(vec2(layoutVertices_obj._Vertices[l9_58],layoutVertices_obj._Vertices[l9_58+1])*l9_4))+(vec2(layoutVertices_obj._Vertices[l9_59],layoutVertices_obj._Vertices[l9_59+1])*l9_5);
}
else
{
vec2 l9_61;
if (proxy_format_texture0==6)
{
l9_61=((unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_57]))*l9_6)+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_58]))*l9_4))+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_59]))*l9_5);
}
else
{
l9_61=vec2(1.0,0.0);
}
l9_60=l9_61;
}
l9_56=l9_60;
}
else
{
l9_56=l9_55;
}
vec2 l9_62;
if (proxy_format_texture1>0)
{
int l9_63=(l9_26.x*emitter_stride)+proxy_offset_texture1;
int l9_64=(l9_26.y*emitter_stride)+proxy_offset_texture1;
int l9_65=(l9_26.z*emitter_stride)+proxy_offset_texture1;
vec2 l9_66;
if (proxy_format_texture1==5)
{
l9_66=((vec2(layoutVertices_obj._Vertices[l9_63],layoutVertices_obj._Vertices[l9_63+1])*l9_6)+(vec2(layoutVertices_obj._Vertices[l9_64],layoutVertices_obj._Vertices[l9_64+1])*l9_4))+(vec2(layoutVertices_obj._Vertices[l9_65],layoutVertices_obj._Vertices[l9_65+1])*l9_5);
}
else
{
vec2 l9_67;
if (proxy_format_texture1==6)
{
l9_67=((unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_63]))*l9_6)+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_64]))*l9_4))+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_65]))*l9_5);
}
else
{
l9_67=vec2(1.0,0.0);
}
l9_66=l9_67;
}
l9_62=l9_66;
}
else
{
l9_62=l9_55;
}
vec2 l9_68;
if (proxy_format_texture2>0)
{
int l9_69=(l9_26.x*emitter_stride)+proxy_offset_texture2;
int l9_70=(l9_26.y*emitter_stride)+proxy_offset_texture2;
int l9_71=(l9_26.z*emitter_stride)+proxy_offset_texture2;
vec2 l9_72;
if (proxy_format_texture2==5)
{
l9_72=((vec2(layoutVertices_obj._Vertices[l9_69],layoutVertices_obj._Vertices[l9_69+1])*l9_6)+(vec2(layoutVertices_obj._Vertices[l9_70],layoutVertices_obj._Vertices[l9_70+1])*l9_4))+(vec2(layoutVertices_obj._Vertices[l9_71],layoutVertices_obj._Vertices[l9_71+1])*l9_5);
}
else
{
vec2 l9_73;
if (proxy_format_texture2==6)
{
l9_73=((unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_69]))*l9_6)+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_70]))*l9_4))+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_71]))*l9_5);
}
else
{
l9_73=vec2(1.0,0.0);
}
l9_72=l9_73;
}
l9_68=l9_72;
}
else
{
l9_68=l9_55;
}
vec2 l9_74;
if (proxy_format_texture3>0)
{
int l9_75=(l9_26.x*emitter_stride)+proxy_offset_texture3;
int l9_76=(l9_26.y*emitter_stride)+proxy_offset_texture3;
int l9_77=(l9_26.z*emitter_stride)+proxy_offset_texture3;
vec2 l9_78;
if (proxy_format_texture3==5)
{
l9_78=((vec2(layoutVertices_obj._Vertices[l9_75],layoutVertices_obj._Vertices[l9_75+1])*l9_6)+(vec2(layoutVertices_obj._Vertices[l9_76],layoutVertices_obj._Vertices[l9_76+1])*l9_4))+(vec2(layoutVertices_obj._Vertices[l9_77],layoutVertices_obj._Vertices[l9_77+1])*l9_5);
}
else
{
vec2 l9_79;
if (proxy_format_texture3==6)
{
l9_79=((unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_75]))*l9_6)+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_76]))*l9_4))+(unpackHalf2x16(floatBitsToUint(layoutVertices_obj._Vertices[l9_77]))*l9_5);
}
else
{
l9_79=vec2(1.0,0.0);
}
l9_78=l9_79;
}
l9_74=l9_78;
}
else
{
l9_74=l9_55;
}
return RayHitPayload(-normalize(vec3(l9_18.x,l9_18.y,l9_13.z)),l9_27,l9_33,l9_40,l9_47,l9_56,l9_62,l9_68,l9_74,l9_2);
}
void Node17_Switch(float Switch,vec2 Value0,vec2 Value1,vec2 Value2,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (NODE_13_DROPLIST_ITEM==0)
{
Value0=Globals.Surface_UVCoord0;
Result=Value0;
}
#else
{
#if (NODE_13_DROPLIST_ITEM==1)
{
Value1=Globals.Surface_UVCoord1;
Result=Value1;
}
#else
{
#if (NODE_13_DROPLIST_ITEM==2)
{
Value2=Globals.gScreenCoord;
Result=Value2;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
#endif
}
#endif
}
void Node122_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV2_ANIMATION)
{
vec2 param_5;
Node17_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_5,Globals);
Value1=((param_5*uv2Scale)+uv2Offset)+(uv2Offset*(Globals.gTimeElapsed*Port_Speed_N022));
Result=Value1;
}
#else
{
vec2 param_12;
Node17_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_12,Globals);
Default=(param_12*uv2Scale)+uv2Offset;
Result=Default;
}
#endif
}
void Node1_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV2)
{
vec2 param_3;
Node122_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value1=param_3;
Result=Value1;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
void Node59_Switch(float Switch,vec2 Value0,vec2 Value1,vec2 Value2,vec2 Value3,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (NODE_49_DROPLIST_ITEM==0)
{
Value0=Globals.Surface_UVCoord0;
Result=Value0;
}
#else
{
#if (NODE_49_DROPLIST_ITEM==1)
{
Value1=Globals.Surface_UVCoord1;
Result=Value1;
}
#else
{
#if (NODE_49_DROPLIST_ITEM==2)
{
Value2=Globals.gScreenCoord;
Result=Value2;
}
#else
{
#if (NODE_49_DROPLIST_ITEM==3)
{
vec2 param_3;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value3=param_3;
Result=Value3;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
#endif
}
#endif
}
#endif
}
void Node64_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV3_ANIMATION)
{
vec2 param_6;
Node59_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_6,Globals);
Value1=((param_6*uv3Scale)+uv3Offset)+(uv3Offset*(Globals.gTimeElapsed*Port_Speed_N063));
Result=Value1;
}
#else
{
vec2 param_14;
Node59_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_14,Globals);
Default=(param_14*uv3Scale)+uv3Offset;
Result=Default;
}
#endif
}
void Node24_If_else(float Bool1,vec2 Value1,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (ENABLE_UV3)
{
vec2 param_3;
Node64_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value1=param_3;
Result=Value1;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
void Node388_Switch(float Switch,vec2 Value0,vec2 Value1,vec2 Value2,vec2 Value3,vec2 Default,out vec2 Result,ssGlobals Globals)
{
#if (NODE_27_DROPLIST_ITEM==0)
{
Value0=Globals.Surface_UVCoord0;
Result=Value0;
}
#else
{
#if (NODE_27_DROPLIST_ITEM==1)
{
Value1=Globals.Surface_UVCoord1;
Result=Value1;
}
#else
{
#if (NODE_27_DROPLIST_ITEM==2)
{
vec2 param_3;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),param_3,Globals);
Value2=param_3;
Result=Value2;
}
#else
{
#if (NODE_27_DROPLIST_ITEM==3)
{
vec2 param_8;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),param_8,Globals);
Value3=param_8;
Result=Value3;
}
#else
{
Default=Globals.Surface_UVCoord0;
Result=Default;
}
#endif
}
#endif
}
#endif
}
#endif
}
int baseTexGetStereoViewIndex()
{
int l9_0;
#if (baseTexHasSwappedViews)
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
return texture(texsmp,sc_SamplingCoordsViewToGlobal(uv,renderingLayout,viewIndex).xy,bias);
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
vec4 sc_SampleView(vec2 texSize,vec2 uv,int renderingLayout,int viewIndex,float bias,sampler2DArray texsmp)
{
return texture(texsmp,sc_SamplingCoordsViewToGlobal(uv,renderingLayout,viewIndex),bias);
}
vec4 sc_SampleTextureBiasOrLevel(vec2 samplerDims,int renderingLayout,int viewIndex,vec2 uv,bool useUvTransform,mat3 uvTransform,ivec2 softwareWrapModes,bool useUvMinMax,vec4 uvMinMax,bool useClampToBorder,vec4 borderColor,float biasOrLevel,sampler2DArray texture_sampler_)
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
void Node369_If_else(float Bool1,vec4 Value1,vec4 Default,out vec4 Result,ssGlobals Globals)
{
#if (ENABLE_BASE_TEX)
{
vec2 param_6;
Node388_Switch(0.0,vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),param_6,Globals);
vec2 l9_0=param_6;
vec4 l9_1;
#if (baseTexLayout==2)
{
l9_1=sc_SampleTextureBiasOrLevel(baseTexDims.xy,baseTexLayout,baseTexGetStereoViewIndex(),l9_0,(int(SC_USE_UV_TRANSFORM_baseTex)!=0),baseTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex),(int(SC_USE_UV_MIN_MAX_baseTex)!=0),baseTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0),baseTexBorderColor,0.0,baseTexArrSC);
}
#else
{
l9_1=sc_SampleTextureBiasOrLevel(baseTexDims.xy,baseTexLayout,baseTexGetStereoViewIndex(),l9_0,(int(SC_USE_UV_TRANSFORM_baseTex)!=0),baseTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex),(int(SC_USE_UV_MIN_MAX_baseTex)!=0),baseTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0),baseTexBorderColor,0.0,baseTex);
}
#endif
Value1=l9_1;
Result=Value1;
}
#else
{
Result=Default;
}
#endif
}
void Node80_If_else(float Bool1,vec3 Value1,vec3 Default,out vec3 Result,ssGlobals Globals)
{
#if (ENABLE_RECOLOR)
{
vec4 param_3;
Node369_If_else(0.0,vec4(0.0),Port_Default_N369,param_3,Globals);
vec4 l9_0=baseColor*param_3;
Value1=((recolorRed*vec3(l9_0.x))+(recolorGreen*vec3(l9_0.y)))+(recolorBlue*vec3(l9_0.z));
Result=Value1;
}
#else
{
vec4 param_8;
Node369_If_else(0.0,vec4(0.0),Port_Default_N369,param_8,Globals);
Default=(baseColor*param_8).xyz;
Result=Default;
}
#endif
}
int opacityTexGetStereoViewIndex()
{
int l9_0;
#if (opacityTexHasSwappedViews)
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
int normalTexGetStereoViewIndex()
{
int l9_0;
#if (normalTexHasSwappedViews)
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
int detailNormalTexGetStereoViewIndex()
{
int l9_0;
#if (detailNormalTexHasSwappedViews)
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
return vec3(texture(sc_SSAOTexture,((l9_0.xyz/vec3(l9_0.w)).xy*0.5)+vec2(0.5)).x);
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
float Dggx(float NdotH,float roughness)
{
float l9_0=roughness;
float l9_1=roughness;
float l9_2=l9_0*l9_1;
float l9_3=l9_2*l9_2;
float l9_4=NdotH;
float l9_5=NdotH;
float l9_6=((l9_4*l9_5)*(l9_3-1.0))+1.0;
float l9_7;
if (isProxyMode)
{
l9_7=1e-07;
}
else
{
l9_7=9.9999999e-09;
}
return l9_3/((l9_6*l9_6)+l9_7);
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
vec4 l9_0;
#if (sc_EnvmapSpecularLayout==2)
{
l9_0=sc_SampleView(sc_EnvmapSpecularDims.xy,uv,sc_EnvmapSpecularLayout,viewIndex,bias,sc_EnvmapSpecularArrSC);
}
#else
{
l9_0=sc_SampleView(sc_EnvmapSpecularDims.xy,uv,sc_EnvmapSpecularLayout,viewIndex,bias,sc_EnvmapSpecular);
}
#endif
return l9_0;
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
int sc_EnvmapDiffuseGetStereoViewIndex()
{
int l9_0;
#if (sc_EnvmapDiffuseHasSwappedViews)
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
vec4 sampleRayTracedIndirectDiffuse()
{
if (receivesRayTracedDiffuseIndirect)
{
vec2 l9_0=(gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw;
int l9_1;
#if (sc_RayTracedDiffIndTextureHasSwappedViews)
{
l9_1=1-sc_GetStereoViewIndex();
}
#else
{
l9_1=sc_GetStereoViewIndex();
}
#endif
vec4 l9_2;
#if (sc_RayTracedDiffIndTextureLayout==2)
{
l9_2=sc_SampleView(sc_RayTracedDiffIndTextureDims.xy,l9_0,sc_RayTracedDiffIndTextureLayout,l9_1,0.0,sc_RayTracedDiffIndTextureArrSC);
}
#else
{
l9_2=sc_SampleView(sc_RayTracedDiffIndTextureDims.xy,l9_0,sc_RayTracedDiffIndTextureLayout,l9_1,0.0,sc_RayTracedDiffIndTexture);
}
#endif
return l9_2;
}
return vec4(0.0);
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
vec4 l9_0;
#if (sc_ScreenTextureLayout==2)
{
l9_0=sc_SampleView(sc_ScreenTextureDims.xy,uv,sc_ScreenTextureLayout,viewIndex,bias,sc_ScreenTextureArrSC);
}
#else
{
l9_0=sc_SampleView(sc_ScreenTextureDims.xy,uv,sc_ScreenTextureLayout,viewIndex,bias,sc_ScreenTexture);
}
#endif
return l9_0;
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
float sampleRayTracedAo()
{
if (receivesRayTracedAo)
{
vec2 l9_0=(gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw;
int l9_1;
#if (sc_RayTracedAoTextureHasSwappedViews)
{
l9_1=1-sc_GetStereoViewIndex();
}
#else
{
l9_1=sc_GetStereoViewIndex();
}
#endif
vec4 l9_2;
#if (sc_RayTracedAoTextureLayout==2)
{
l9_2=sc_SampleView(sc_RayTracedAoTextureDims.xy,l9_0,sc_RayTracedAoTextureLayout,l9_1,0.0,sc_RayTracedAoTextureArrSC);
}
#else
{
l9_2=sc_SampleView(sc_RayTracedAoTextureDims.xy,l9_0,sc_RayTracedAoTextureLayout,l9_1,0.0,sc_RayTracedAoTexture);
}
#endif
return l9_2.x;
}
return 0.0;
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
vec4 ngsCalculateLighting(vec3 albedo,float opacity,vec3 normal,vec3 position,vec3 viewDir,vec3 emissive,float metallic,float roughness,vec3 ao,vec3 specularAO)
{
float l9_0=opacity;
vec3 l9_1=ssSRGB_to_Linear(albedo);
vec3 l9_2=normal;
vec3 l9_3=normalize(l9_2);
vec3 l9_4=position;
vec3 l9_5=viewDir;
vec3 l9_6=ssSRGB_to_Linear(emissive);
float l9_7=metallic;
float l9_8=roughness;
vec3 l9_9=ao;
vec3 l9_10=specularAO;
vec3 l9_11;
#if (sc_SSAOEnabled)
{
l9_11=evaluateSSAO(l9_4);
}
#else
{
l9_11=l9_9;
}
#endif
vec3 l9_12=vec3(l9_7);
vec3 l9_13=mix(l9_1*(1.0-l9_7),vec3(0.0),l9_12);
SurfaceProperties l9_14=SurfaceProperties(l9_13,l9_0,l9_3,l9_4,l9_5,l9_7,l9_8,l9_6,l9_11,l9_10,vec3(1.0),mix(vec3(0.039999999),l9_1*l9_7,l9_12));
vec4 l9_15=vec4(1.0);
vec3 l9_16;
vec3 l9_17;
vec3 l9_18;
vec3 l9_19;
vec3 l9_20;
int l9_21;
vec3 l9_22;
#if (sc_DirectionalLightsCount>0)
{
vec3 l9_23;
vec3 l9_24;
vec3 l9_25;
vec3 l9_26;
vec3 l9_27;
int l9_28;
vec3 l9_29;
l9_29=vec3(1.0);
l9_28=0;
l9_27=vec3(0.0);
l9_26=vec3(0.0);
l9_25=vec3(0.0);
l9_24=vec3(0.0);
l9_23=vec3(0.0);
LightingComponents l9_30;
LightProperties l9_31;
SurfaceProperties l9_32;
vec3 l9_33;
int l9_34=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_34<sc_DirectionalLightsCount)
{
LightingComponents l9_35=accumulateLight(LightingComponents(l9_23,l9_24,l9_29,l9_27,l9_26,l9_25),LightProperties(sc_DirectionalLights[l9_34].direction,sc_DirectionalLights[l9_34].color.xyz,sc_DirectionalLights[l9_34].color.w*l9_15[(l9_28<3) ? l9_28 : 3]),l9_14,l9_5);
l9_29=l9_35.indirectDiffuse;
l9_28++;
l9_27=l9_35.indirectSpecular;
l9_26=l9_35.emitted;
l9_25=l9_35.transmitted;
l9_24=l9_35.directSpecular;
l9_23=l9_35.directDiffuse;
l9_34++;
continue;
}
else
{
break;
}
}
l9_22=l9_29;
l9_21=l9_28;
l9_20=l9_27;
l9_19=l9_26;
l9_18=l9_25;
l9_17=l9_24;
l9_16=l9_23;
}
#else
{
l9_22=vec3(1.0);
l9_21=0;
l9_20=vec3(0.0);
l9_19=vec3(0.0);
l9_18=vec3(0.0);
l9_17=vec3(0.0);
l9_16=vec3(0.0);
}
#endif
vec3 l9_36;
vec3 l9_37;
vec3 l9_38;
#if (sc_PointLightsCount>0)
{
vec3 l9_39;
vec3 l9_40;
vec3 l9_41;
vec3 l9_42;
vec3 l9_43;
vec3 l9_44;
l9_44=l9_22;
l9_43=l9_20;
l9_42=l9_19;
l9_41=l9_18;
l9_40=l9_17;
l9_39=l9_16;
int l9_45;
vec3 l9_46;
vec3 l9_47;
vec3 l9_48;
vec3 l9_49;
vec3 l9_50;
vec3 l9_51;
int l9_52=0;
int l9_53=l9_21;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_52<sc_PointLightsCount)
{
vec3 l9_54=sc_PointLights[l9_52].position-l9_4;
vec3 l9_55=normalize(l9_54);
float l9_56=l9_15[(l9_53<3) ? l9_53 : 3];
float l9_57=clamp((dot(l9_55,sc_PointLights[l9_52].direction)*sc_PointLights[l9_52].angleScale)+sc_PointLights[l9_52].angleOffset,0.0,1.0);
float l9_58=(sc_PointLights[l9_52].color.w*l9_56)*(l9_57*l9_57);
float l9_59;
if (sc_PointLights[l9_52].falloffEnabled)
{
l9_59=l9_58*computeDistanceAttenuation(length(l9_54),sc_PointLights[l9_52].falloffEndDistance);
}
else
{
l9_59=l9_58;
}
l9_45=l9_53+1;
LightingComponents l9_60=accumulateLight(LightingComponents(l9_39,l9_40,l9_44,l9_43,l9_42,l9_41),LightProperties(l9_55,sc_PointLights[l9_52].color.xyz,l9_59),l9_14,l9_5);
l9_46=l9_60.directDiffuse;
l9_47=l9_60.directSpecular;
l9_48=l9_60.indirectDiffuse;
l9_49=l9_60.indirectSpecular;
l9_50=l9_60.emitted;
l9_51=l9_60.transmitted;
l9_44=l9_48;
l9_53=l9_45;
l9_43=l9_49;
l9_42=l9_50;
l9_41=l9_51;
l9_40=l9_47;
l9_39=l9_46;
l9_52++;
continue;
}
else
{
break;
}
}
l9_38=l9_43;
l9_37=l9_41;
l9_36=l9_39;
}
#else
{
l9_38=l9_20;
l9_37=l9_18;
l9_36=l9_16;
}
#endif
vec3 l9_61;
#if (sc_ProjectiveShadowsReceiver)
{
vec3 l9_62;
#if (sc_ProjectiveShadowsReceiver)
{
vec2 l9_63=abs(varShadowTex-vec2(0.5));
vec4 l9_64=texture(sc_ShadowTexture,varShadowTex)*step(max(l9_63.x,l9_63.y),0.5);
l9_62=mix(vec3(1.0),mix(sc_ShadowColor.xyz,sc_ShadowColor.xyz*l9_64.xyz,vec3(sc_ShadowColor.w)),vec3(l9_64.w*sc_ShadowDensity));
}
#else
{
l9_62=vec3(1.0);
}
#endif
l9_61=l9_36*l9_62;
}
#else
{
l9_61=l9_36;
}
#endif
vec3 l9_65;
if (receivesRayTracedShadows)
{
vec2 l9_66=(gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw;
int l9_67;
#if (sc_RayTracedShadowTextureHasSwappedViews)
{
l9_67=1-sc_GetStereoViewIndex();
}
#else
{
l9_67=sc_GetStereoViewIndex();
}
#endif
vec4 l9_68;
#if (sc_RayTracedShadowTextureLayout==2)
{
l9_68=sc_SampleView(sc_RayTracedShadowTextureDims.xy,l9_66,sc_RayTracedShadowTextureLayout,l9_67,0.0,sc_RayTracedShadowTextureArrSC);
}
#else
{
l9_68=sc_SampleView(sc_RayTracedShadowTextureDims.xy,l9_66,sc_RayTracedShadowTextureLayout,l9_67,0.0,sc_RayTracedShadowTexture);
}
#endif
l9_65=l9_61*(vec3(1.0)-vec3(l9_68.x));
}
else
{
l9_65=l9_61;
}
vec3 l9_69;
#if ((sc_EnvLightMode==sc_AmbientLightMode_EnvironmentMap)||(sc_EnvLightMode==sc_AmbientLightMode_FromCamera))
{
float l9_70=-l9_3.z;
float l9_71=l9_3.x;
vec2 l9_72=vec2((((l9_71<0.0) ? (-1.0) : 1.0)*acos(clamp(l9_70/length(vec2(l9_71,l9_70)),-1.0,1.0)))-1.5707964,acos(l9_3.y))/vec2(6.2831855,3.1415927);
float l9_73=l9_72.x+(sc_EnvmapRotation.y/360.0);
vec2 l9_74=vec2(l9_73,1.0-l9_72.y);
l9_74.x=fract((l9_73+floor(l9_73))+1.0);
vec4 l9_75;
#if (sc_EnvLightMode==sc_AmbientLightMode_FromCamera)
{
vec2 l9_76;
#if ((SC_DEVICE_CLASS>=2)&&SC_GL_FRAGMENT_PRECISION_HIGH)
{
l9_76=calcSeamlessPanoramicUvsForSampling(l9_74,sc_EnvmapSpecularSize.xy,5.0);
}
#else
{
l9_76=l9_74;
}
#endif
l9_75=sc_EnvmapSpecularSampleViewIndexBias(l9_76,sc_EnvmapSpecularGetStereoViewIndex(),13.0);
}
#else
{
vec4 l9_77;
#if ((sc_MaxTextureImageUnits>8)&&sc_HasDiffuseEnvmap)
{
vec2 l9_78=calcSeamlessPanoramicUvsForSampling(l9_74,sc_EnvmapDiffuseSize.xy,0.0);
vec4 l9_79;
if (isProxyMode)
{
int l9_80=sc_EnvmapDiffuseGetStereoViewIndex();
vec4 l9_81;
#if (sc_CanUseTextureLod)
{
vec4 l9_82;
#if (sc_EnvmapDiffuseLayout==2)
{
vec3 l9_83=sc_SamplingCoordsViewToGlobal(l9_78,sc_EnvmapDiffuseLayout,l9_80);
vec4 l9_84;
#if (sc_CanUseTextureLod)
{
l9_84=textureLod(sc_EnvmapDiffuseArrSC,l9_83,0.0);
}
#else
{
l9_84=vec4(0.0);
}
#endif
l9_82=l9_84;
}
#else
{
l9_82=textureLod(sc_EnvmapDiffuse,sc_SamplingCoordsViewToGlobal(l9_78,sc_EnvmapDiffuseLayout,l9_80).xy,0.0);
}
#endif
l9_81=l9_82;
}
#else
{
l9_81=vec4(0.0);
}
#endif
l9_79=l9_81;
}
else
{
int l9_85=sc_EnvmapDiffuseGetStereoViewIndex();
vec4 l9_86;
#if (sc_EnvmapDiffuseLayout==2)
{
l9_86=sc_SampleView(sc_EnvmapDiffuseDims.xy,l9_78,sc_EnvmapDiffuseLayout,l9_85,-13.0,sc_EnvmapDiffuseArrSC);
}
#else
{
l9_86=sc_SampleView(sc_EnvmapDiffuseDims.xy,l9_78,sc_EnvmapDiffuseLayout,l9_85,-13.0,sc_EnvmapDiffuse);
}
#endif
l9_79=l9_86;
}
l9_77=l9_79;
}
#else
{
l9_77=sc_EnvmapSpecularSampleViewIndexBias(l9_74,sc_EnvmapSpecularGetStereoViewIndex(),13.0);
}
#endif
l9_75=l9_77;
}
#endif
l9_69=(l9_75.xyz*(1.0/l9_75.w))*sc_EnvmapExposure;
}
#else
{
vec3 l9_87;
#if (sc_EnvLightMode==sc_AmbientLightMode_SphericalHarmonics)
{
vec3 l9_88=-l9_3;
float l9_89=l9_88.x;
float l9_90=l9_88.y;
float l9_91=l9_88.z;
l9_87=(((((((sc_Sh[8]*0.42904299)*((l9_89*l9_89)-(l9_90*l9_90)))+((sc_Sh[6]*0.74312502)*(l9_91*l9_91)))+(sc_Sh[0]*0.88622701))-(sc_Sh[6]*0.24770799))+((((sc_Sh[4]*(l9_89*l9_90))+(sc_Sh[7]*(l9_89*l9_91)))+(sc_Sh[5]*(l9_90*l9_91)))*0.85808599))+((((sc_Sh[3]*l9_89)+(sc_Sh[1]*l9_90))+(sc_Sh[2]*l9_91))*1.0233279))*sc_ShIntensity;
}
#else
{
l9_87=vec3(0.0);
}
#endif
l9_69=l9_87;
}
#endif
vec3 l9_92;
if (receivesRayTracedDiffuseIndirect)
{
vec4 l9_93=sampleRayTracedIndirectDiffuse();
l9_92=mix(l9_69,l9_93.xyz,vec3(l9_93.w));
}
else
{
l9_92=l9_69;
}
vec3 l9_94;
#if (sc_AmbientLightsCount>0)
{
vec3 l9_95;
#if (sc_AmbientLightMode0==sc_AmbientLightMode_Constant)
{
l9_95=l9_92+(sc_AmbientLights[0].color*sc_AmbientLights[0].intensity);
}
#else
{
vec3 l9_96=l9_92;
l9_96.x=l9_92.x+(1e-06*sc_AmbientLights[0].color.x);
l9_95=l9_96;
}
#endif
l9_94=l9_95;
}
#else
{
l9_94=l9_92;
}
#endif
vec3 l9_97;
#if (sc_AmbientLightsCount>1)
{
vec3 l9_98;
#if (sc_AmbientLightMode1==sc_AmbientLightMode_Constant)
{
l9_98=l9_94+(sc_AmbientLights[1].color*sc_AmbientLights[1].intensity);
}
#else
{
vec3 l9_99=l9_94;
l9_99.x=l9_94.x+(1e-06*sc_AmbientLights[1].color.x);
l9_98=l9_99;
}
#endif
l9_97=l9_98;
}
#else
{
l9_97=l9_94;
}
#endif
vec3 l9_100;
#if (sc_AmbientLightsCount>2)
{
vec3 l9_101;
#if (sc_AmbientLightMode2==sc_AmbientLightMode_Constant)
{
l9_101=l9_97+(sc_AmbientLights[2].color*sc_AmbientLights[2].intensity);
}
#else
{
vec3 l9_102=l9_97;
l9_102.x=l9_97.x+(1e-06*sc_AmbientLights[2].color.x);
l9_101=l9_102;
}
#endif
l9_100=l9_101;
}
#else
{
l9_100=l9_97;
}
#endif
vec3 l9_103;
#if (sc_LightEstimation)
{
vec3 l9_104;
l9_104=sc_LightEstimationData.ambientLight;
vec3 l9_105;
int l9_106=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_106<sc_LightEstimationSGCount)
{
float l9_107=dot(sc_LightEstimationData.sg[l9_106].axis,l9_3);
float l9_108=exp(-sc_LightEstimationData.sg[l9_106].sharpness);
float l9_109=l9_108*l9_108;
float l9_110=1.0/sc_LightEstimationData.sg[l9_106].sharpness;
float l9_111=(1.0+(2.0*l9_109))-l9_110;
float l9_112=sqrt(1.0-l9_111);
float l9_113=0.36000001*l9_107;
float l9_114=(1.0/(4.0*0.36000001))*l9_112;
float l9_115=l9_113+l9_114;
float l9_116;
if (step(abs(l9_113),l9_114)>0.5)
{
l9_116=(l9_115*l9_115)/l9_112;
}
else
{
l9_116=clamp(l9_107,0.0,1.0);
}
l9_105=l9_104+((((sc_LightEstimationData.sg[l9_106].color/vec3(sc_LightEstimationData.sg[l9_106].sharpness))*6.2831855)*((l9_111*l9_116)+(((l9_108-l9_109)*l9_110)-l9_109)))/vec3(3.1415927));
l9_104=l9_105;
l9_106++;
continue;
}
else
{
break;
}
}
l9_103=l9_100+l9_104;
}
#else
{
l9_103=l9_100;
}
#endif
float l9_117;
vec3 l9_118;
vec3 l9_119;
vec3 l9_120;
#if (sc_BlendMode_ColoredGlass)
{
l9_120=vec3(0.0);
l9_119=vec3(0.0);
l9_118=ssSRGB_to_Linear(sc_GetFramebufferColor().xyz)*mix(vec3(1.0),l9_13,vec3(l9_0));
l9_117=1.0;
}
#else
{
l9_120=l9_65;
l9_119=l9_103;
l9_118=l9_37;
l9_117=l9_0;
}
#endif
bool l9_121;
#if (sc_BlendMode_PremultipliedAlpha)
{
l9_121=true;
}
#else
{
l9_121=false;
}
#endif
vec3 l9_122;
if (receivesRayTracedAo)
{
l9_122=l9_13*(l9_120+(l9_119*vec3(1.0-sampleRayTracedAo())));
}
else
{
l9_122=l9_13*(l9_120+(l9_119*l9_11));
}
vec3 l9_123=l9_38*l9_10;
vec3 l9_124;
if (l9_121)
{
l9_124=l9_122*srgbToLinear(l9_117);
}
else
{
l9_124=l9_122;
}
vec3 l9_125=l9_124+(vec3(0.0)+l9_123);
vec3 l9_126=(l9_125+l9_6)+l9_118;
float l9_127=l9_126.x;
vec4 l9_128=vec4(l9_127,l9_126.yz,l9_117);
vec4 l9_129;
#if (sc_IsEditor)
{
vec4 l9_130=l9_128;
l9_130.x=l9_127+((l9_11.x*l9_10.x)*9.9999997e-06);
l9_129=l9_130;
}
#else
{
l9_129=l9_128;
}
#endif
if (isProxyMode)
{
return l9_129;
}
vec4 l9_131;
#if (!sc_BlendMode_Multiply)
{
vec3 l9_132=l9_129.xyz*1.8;
vec3 l9_133=(l9_129.xyz*(l9_132+vec3(1.4)))/((l9_129.xyz*(l9_132+vec3(0.5)))+vec3(1.5));
l9_131=vec4(l9_133.x,l9_133.y,l9_133.z,l9_129.w);
}
#else
{
l9_131=l9_129;
}
#endif
vec3 l9_134=vec3(linearToSrgb(l9_131.x),linearToSrgb(l9_131.y),linearToSrgb(l9_131.z));
return vec4(l9_134.x,l9_134.y,l9_134.z,l9_131.w);
}
void sc_writeFragData0(vec4 col)
{
    sc_FragData0=col;
}
int intensityTextureGetStereoViewIndex()
{
int l9_0;
#if (intensityTextureHasSwappedViews)
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
float l9_48=pow(l9_47,1.0/correctedIntensity);
vec4 l9_49;
#if (intensityTextureLayout==2)
{
l9_49=sc_SampleTextureBiasOrLevel(intensityTextureDims.xy,intensityTextureLayout,intensityTextureGetStereoViewIndex(),vec2(l9_48,0.5),(int(SC_USE_UV_TRANSFORM_intensityTexture)!=0),intensityTextureTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture),(int(SC_USE_UV_MIN_MAX_intensityTexture)!=0),intensityTextureUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0),intensityTextureBorderColor,0.0,intensityTextureArrSC);
}
#else
{
l9_49=sc_SampleTextureBiasOrLevel(intensityTextureDims.xy,intensityTextureLayout,intensityTextureGetStereoViewIndex(),vec2(l9_48,0.5),(int(SC_USE_UV_TRANSFORM_intensityTexture)!=0),intensityTextureTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture),(int(SC_USE_UV_MIN_MAX_intensityTexture)!=0),intensityTextureUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0),intensityTextureBorderColor,0.0,intensityTexture);
}
#endif
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
vec3 l9_3;
vec3 l9_4;
vec3 l9_5;
vec2 l9_6;
vec2 l9_7;
vec2 l9_8;
vec4 l9_9;
vec3 l9_10;
vec3 l9_11;
if (isProxyMode)
{
RayHitPayload l9_12=GetHitData(ivec2(gl_FragCoord.xy));
vec3 l9_13=l9_12.positionWS;
vec3 l9_14=l9_12.normalWS;
vec4 l9_15=l9_12.tangentWS;
if (noEarlyZ)
{
if (l9_12.id.x!=uint(instance_id))
{
return;
}
}
vec4 l9_16=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(l9_13,1.0);
vec3 l9_17=l9_15.xyz;
l9_11=l9_12.viewDirWS;
l9_10=l9_13;
l9_9=l9_12.color;
l9_8=l9_12.uv0;
l9_7=l9_12.uv1;
l9_6=((l9_16.xy/vec2(l9_16.w))*0.5)+vec2(0.5);
l9_5=l9_17;
l9_4=l9_14;
l9_3=cross(l9_14,l9_17)*l9_15.w;
}
else
{
vec3 l9_18=normalize(varTangent.xyz);
vec3 l9_19=normalize(varNormal);
l9_11=normalize(sc_Camera.position-varPos);
l9_10=varPos;
l9_9=varColor;
l9_8=varPackedTex.xy;
l9_7=varPackedTex.zw;
l9_6=sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw);
l9_5=l9_18;
l9_4=l9_19;
l9_3=cross(l9_19,l9_18)*varTangent.w;
}
ssGlobals l9_20=ssGlobals(l9_1,l9_2,0.0,vec3(0.0),l9_11,l9_10,l9_9,l9_8,l9_7,l9_6,l9_5,l9_4,l9_3);
vec4 l9_21;
#if (NODE_38_DROPLIST_ITEM==1)
{
vec3 l9_22;
Node80_If_else(0.0,vec3(0.0),vec3(0.0),l9_22,l9_20);
l9_21=l9_9*vec4(l9_22.x,l9_22.y,l9_22.z,vec4(0.0).w);
}
#else
{
vec3 l9_23;
Node80_If_else(0.0,vec3(0.0),vec3(0.0),l9_23,l9_20);
l9_21=vec4(l9_23.x,l9_23.y,l9_23.z,vec4(0.0).w);
}
#endif
vec4 param_3;
Node369_If_else(0.0,vec4(0.0),Port_Default_N369,param_3,l9_20);
vec4 l9_24=param_3;
float l9_25;
#if (ENABLE_OPACITY_TEX)
{
vec2 l9_26;
#if (NODE_69_DROPLIST_ITEM==0)
{
l9_26=l9_8;
}
#else
{
vec2 l9_27;
#if (NODE_69_DROPLIST_ITEM==1)
{
l9_27=l9_7;
}
#else
{
vec2 l9_28;
#if (NODE_69_DROPLIST_ITEM==2)
{
vec2 l9_29;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),l9_29,l9_20);
l9_28=l9_29;
}
#else
{
vec2 l9_30;
#if (NODE_69_DROPLIST_ITEM==3)
{
vec2 l9_31;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),l9_31,l9_20);
l9_30=l9_31;
}
#else
{
l9_30=l9_8;
}
#endif
l9_28=l9_30;
}
#endif
l9_27=l9_28;
}
#endif
l9_26=l9_27;
}
#endif
vec4 l9_32;
#if (opacityTexLayout==2)
{
l9_32=sc_SampleTextureBiasOrLevel(opacityTexDims.xy,opacityTexLayout,opacityTexGetStereoViewIndex(),l9_26,(int(SC_USE_UV_TRANSFORM_opacityTex)!=0),opacityTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex),(int(SC_USE_UV_MIN_MAX_opacityTex)!=0),opacityTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0),opacityTexBorderColor,0.0,opacityTexArrSC);
}
#else
{
l9_32=sc_SampleTextureBiasOrLevel(opacityTexDims.xy,opacityTexLayout,opacityTexGetStereoViewIndex(),l9_26,(int(SC_USE_UV_TRANSFORM_opacityTex)!=0),opacityTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex),(int(SC_USE_UV_MIN_MAX_opacityTex)!=0),opacityTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0),opacityTexBorderColor,0.0,opacityTex);
}
#endif
l9_25=l9_32.x;
}
#else
{
l9_25=Port_Default_N204;
}
#endif
float l9_33;
#if (NODE_38_DROPLIST_ITEM==1)
{
l9_33=l9_9.w;
}
#else
{
l9_33=Port_Input2_N072;
}
#endif
float l9_34=(baseColor*l9_24).w*l9_25;
float l9_35=l9_34*l9_33;
vec3 l9_36;
#if (ENABLE_NORMALMAP)
{
mat3 l9_37=mat3(l9_5,l9_3,l9_4);
vec2 l9_38;
#if (NODE_181_DROPLIST_ITEM==0)
{
l9_38=l9_8;
}
#else
{
vec2 l9_39;
#if (NODE_181_DROPLIST_ITEM==1)
{
l9_39=l9_7;
}
#else
{
vec2 l9_40;
#if (NODE_181_DROPLIST_ITEM==2)
{
vec2 l9_41;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),l9_41,l9_20);
l9_40=l9_41;
}
#else
{
vec2 l9_42;
#if (NODE_181_DROPLIST_ITEM==3)
{
vec2 l9_43;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),l9_43,l9_20);
l9_42=l9_43;
}
#else
{
l9_42=l9_8;
}
#endif
l9_40=l9_42;
}
#endif
l9_39=l9_40;
}
#endif
l9_38=l9_39;
}
#endif
vec4 l9_44;
#if (normalTexLayout==2)
{
l9_44=sc_SampleTextureBiasOrLevel(normalTexDims.xy,normalTexLayout,normalTexGetStereoViewIndex(),l9_38,(int(SC_USE_UV_TRANSFORM_normalTex)!=0),normalTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_normalTex,SC_SOFTWARE_WRAP_MODE_V_normalTex),(int(SC_USE_UV_MIN_MAX_normalTex)!=0),normalTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_normalTex)!=0),normalTexBorderColor,0.0,normalTexArrSC);
}
#else
{
l9_44=sc_SampleTextureBiasOrLevel(normalTexDims.xy,normalTexLayout,normalTexGetStereoViewIndex(),l9_38,(int(SC_USE_UV_TRANSFORM_normalTex)!=0),normalTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_normalTex,SC_SOFTWARE_WRAP_MODE_V_normalTex),(int(SC_USE_UV_MIN_MAX_normalTex)!=0),normalTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_normalTex)!=0),normalTexBorderColor,0.0,normalTex);
}
#endif
vec3 l9_45;
#if (ENABLE_DETAIL_NORMAL)
{
vec2 l9_46;
#if (NODE_184_DROPLIST_ITEM==0)
{
l9_46=l9_8;
}
#else
{
vec2 l9_47;
#if (NODE_184_DROPLIST_ITEM==1)
{
l9_47=l9_7;
}
#else
{
vec2 l9_48;
#if (NODE_184_DROPLIST_ITEM==2)
{
vec2 l9_49;
Node1_If_else(0.0,vec2(0.0),vec2(0.0),l9_49,l9_20);
l9_48=l9_49;
}
#else
{
vec2 l9_50;
#if (NODE_184_DROPLIST_ITEM==3)
{
vec2 l9_51;
Node24_If_else(0.0,vec2(0.0),vec2(0.0),l9_51,l9_20);
l9_50=l9_51;
}
#else
{
l9_50=l9_8;
}
#endif
l9_48=l9_50;
}
#endif
l9_47=l9_48;
}
#endif
l9_46=l9_47;
}
#endif
vec4 l9_52;
#if (detailNormalTexLayout==2)
{
l9_52=sc_SampleTextureBiasOrLevel(detailNormalTexDims.xy,detailNormalTexLayout,detailNormalTexGetStereoViewIndex(),l9_46,(int(SC_USE_UV_TRANSFORM_detailNormalTex)!=0),detailNormalTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_detailNormalTex,SC_SOFTWARE_WRAP_MODE_V_detailNormalTex),(int(SC_USE_UV_MIN_MAX_detailNormalTex)!=0),detailNormalTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_detailNormalTex)!=0),detailNormalTexBorderColor,0.0,detailNormalTexArrSC);
}
#else
{
l9_52=sc_SampleTextureBiasOrLevel(detailNormalTexDims.xy,detailNormalTexLayout,detailNormalTexGetStereoViewIndex(),l9_46,(int(SC_USE_UV_TRANSFORM_detailNormalTex)!=0),detailNormalTexTransform,ivec2(SC_SOFTWARE_WRAP_MODE_U_detailNormalTex,SC_SOFTWARE_WRAP_MODE_V_detailNormalTex),(int(SC_USE_UV_MIN_MAX_detailNormalTex)!=0),detailNormalTexUvMinMax,(int(SC_USE_CLAMP_TO_BORDER_detailNormalTex)!=0),detailNormalTexBorderColor,0.0,detailNormalTex);
}
#endif
l9_45=((l9_52.xyz*1.9921875)-vec3(1.0)).xyz;
}
#else
{
l9_45=Port_Default_N113;
}
#endif
vec3 l9_53=mix(vec3(0.0,0.0,1.0),((l9_44.xyz*1.9921875)-vec3(1.0)).xyz,vec3(Port_Strength1_N200))+vec3(0.0,0.0,1.0);
vec3 l9_54=mix(vec3(0.0,0.0,1.0),l9_45,vec3(Port_Strength2_N200));
vec3 l9_55=l9_54*vec3(-1.0,-1.0,1.0);
vec3 l9_56=l9_37*normalize((l9_53*dot(l9_53,l9_55))-(l9_55*l9_53.z));
float l9_57=dot(l9_56,l9_56);
float l9_58;
if (l9_57>0.0)
{
l9_58=1.0/sqrt(l9_57);
}
else
{
l9_58=0.0;
}
l9_36=l9_56*l9_58;
}
#else
{
float l9_59=dot(l9_4,l9_4);
float l9_60;
if (l9_59>0.0)
{
l9_60=1.0/sqrt(l9_59);
}
else
{
l9_60=0.0;
}
l9_36=l9_4*l9_60;
}
#endif
vec3 l9_61;
#if (!sc_ProjectiveShadowsCaster)
{
l9_61=l9_36;
}
#else
{
l9_61=vec3(0.0);
}
#endif
float l9_62=clamp(l9_35,0.0,1.0);
#if (sc_BlendMode_AlphaTest)
{
if (l9_62<alphaTestThreshold)
{
discard;
}
}
#endif
#if (ENABLE_STIPPLE_PATTERN_TEST)
{
if (l9_62<((mod(dot(floor(mod(gl_FragCoord.xy,vec2(4.0))),vec2(4.0,1.0))*9.0,16.0)+1.0)/17.0))
{
discard;
}
}
#endif
vec3 l9_63=max(l9_21.xyz,vec3(0.0));
vec4 l9_64;
#if (sc_ProjectiveShadowsCaster)
{
l9_64=vec4(l9_63,l9_62);
}
#else
{
l9_64=ngsCalculateLighting(l9_63,l9_62,l9_61,l9_10,l9_11,Port_Emissive_N036,0.0,1.0,Port_AO_N036,vec3(1.0));
}
#endif
vec4 l9_65=max(l9_64,vec4(0.0));
vec4 l9_66=l9_65*vec4(colorMultiplier+1.0);
float l9_67=l9_65.w;
vec4 l9_68=vec4(l9_66.x,l9_66.y,l9_66.z,vec4(0.0).w);
l9_68.w=l9_67;
if (isProxyMode)
{
vec4 l9_69;
#if (sc_ProxyAlphaOne)
{
vec4 l9_70=l9_68;
l9_70.w=1.0;
l9_69=l9_70;
}
#else
{
l9_69=l9_68;
}
#endif
sc_writeFragData0(max(l9_69,vec4(0.0)));
return;
}
vec4 l9_71;
#if (sc_ProjectiveShadowsCaster)
{
float l9_72;
#if (((sc_BlendMode_Normal||sc_BlendMode_AlphaToCoverage)||sc_BlendMode_PremultipliedAlphaHardware)||sc_BlendMode_PremultipliedAlphaAuto)
{
l9_72=l9_67;
}
#else
{
float l9_73;
#if (sc_BlendMode_PremultipliedAlpha)
{
l9_73=clamp(l9_67*2.0,0.0,1.0);
}
#else
{
float l9_74;
#if (sc_BlendMode_AddWithAlphaFactor)
{
l9_74=clamp(dot(l9_68.xyz,vec3(l9_67)),0.0,1.0);
}
#else
{
float l9_75;
#if (sc_BlendMode_AlphaTest)
{
l9_75=1.0;
}
#else
{
float l9_76;
#if (sc_BlendMode_Multiply)
{
l9_76=(1.0-dot(l9_68.xyz,vec3(0.33333001)))*l9_67;
}
#else
{
float l9_77;
#if (sc_BlendMode_MultiplyOriginal)
{
l9_77=(1.0-clamp(dot(l9_68.xyz,vec3(1.0)),0.0,1.0))*l9_67;
}
#else
{
float l9_78;
#if (sc_BlendMode_ColoredGlass)
{
l9_78=clamp(dot(l9_68.xyz,vec3(1.0)),0.0,1.0)*l9_67;
}
#else
{
float l9_79;
#if (sc_BlendMode_Add)
{
l9_79=clamp(dot(l9_68.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
float l9_80;
#if (sc_BlendMode_AddWithAlphaFactor)
{
l9_80=clamp(dot(l9_68.xyz,vec3(1.0)),0.0,1.0)*l9_67;
}
#else
{
float l9_81;
#if (sc_BlendMode_Screen)
{
l9_81=dot(l9_68.xyz,vec3(0.33333001))*l9_67;
}
#else
{
float l9_82;
#if (sc_BlendMode_Min)
{
l9_82=1.0-clamp(dot(l9_68.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
float l9_83;
#if (sc_BlendMode_Max)
{
l9_83=clamp(dot(l9_68.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
l9_83=1.0;
}
#endif
l9_82=l9_83;
}
#endif
l9_81=l9_82;
}
#endif
l9_80=l9_81;
}
#endif
l9_79=l9_80;
}
#endif
l9_78=l9_79;
}
#endif
l9_77=l9_78;
}
#endif
l9_76=l9_77;
}
#endif
l9_75=l9_76;
}
#endif
l9_74=l9_75;
}
#endif
l9_73=l9_74;
}
#endif
l9_72=l9_73;
}
#endif
l9_71=vec4(mix(sc_ShadowColor.xyz,sc_ShadowColor.xyz*l9_68.xyz,vec3(sc_ShadowColor.w)),sc_ShadowDensity*l9_72);
}
#else
{
vec4 l9_84;
#if (sc_RenderAlphaToColor)
{
l9_84=vec4(l9_67);
}
#else
{
vec4 l9_85;
#if (sc_BlendMode_Custom)
{
vec3 l9_86=sc_GetFramebufferColor().xyz;
vec3 l9_87=mix(l9_86,definedBlend(l9_86,l9_68.xyz).xyz,vec3(l9_67));
vec4 l9_88=vec4(l9_87.x,l9_87.y,l9_87.z,vec4(0.0).w);
l9_88.w=1.0;
l9_85=l9_88;
}
#else
{
vec4 l9_89;
#if (sc_BlendMode_MultiplyOriginal)
{
l9_89=vec4(mix(vec3(1.0),l9_68.xyz,vec3(l9_67)),l9_67);
}
#else
{
vec4 l9_90;
#if (sc_BlendMode_Screen||sc_BlendMode_PremultipliedAlphaAuto)
{
float l9_91;
#if (sc_BlendMode_PremultipliedAlphaAuto)
{
l9_91=clamp(l9_67,0.0,1.0);
}
#else
{
l9_91=l9_67;
}
#endif
l9_90=vec4(l9_68.xyz*l9_91,l9_91);
}
#else
{
l9_90=l9_68;
}
#endif
l9_89=l9_90;
}
#endif
l9_85=l9_89;
}
#endif
l9_84=l9_85;
}
#endif
l9_71=l9_84;
}
#endif
vec4 l9_92;
if (PreviewEnabled==1)
{
vec4 l9_93;
if (((PreviewVertexSaved*1.0)!=0.0) ? true : false)
{
l9_93=PreviewVertexColor;
}
else
{
l9_93=vec4(0.0);
}
l9_92=l9_93;
}
else
{
l9_92=l9_71;
}
vec4 l9_94;
#if (sc_ShaderComplexityAnalyzer)
{
l9_94=vec4(shaderComplexityValue/255.0,0.0,0.0,1.0);
}
#else
{
l9_94=vec4(0.0);
}
#endif
vec4 l9_95;
if (l9_94.w>0.0)
{
l9_95=l9_94;
}
else
{
l9_95=l9_92;
}
vec4 l9_96=outputMotionVectorsIfNeeded(varPos,max(l9_95,vec4(0.0)));
vec4 l9_97=clamp(l9_96,vec4(0.0),vec4(1.0));
#if (sc_OITDepthBoundsPass)
{
#if (sc_OITDepthBoundsPass)
{
float l9_98=clamp(viewSpaceDepth()/1000.0,0.0,1.0);
sc_writeFragData0(vec4(max(0.0,1.0-(l9_98-0.0039215689)),min(1.0,l9_98+0.0039215689),0.0,0.0));
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
vec2 l9_99=sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw);
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture(sc_OITFrontDepthTexture,l9_99).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
int l9_100=encodeDepth(viewSpaceDepth(),texture(sc_OITFilteredDepthBoundsTexture,l9_99).xy);
float l9_101=packValue(l9_100);
int l9_108=int(l9_97.w*255.0);
float l9_109=packValue(l9_108);
sc_writeFragData0(vec4(packValue(l9_100),packValue(l9_100),packValue(l9_100),packValue(l9_100)));
sc_writeFragData1(vec4(l9_101,packValue(l9_100),packValue(l9_100),packValue(l9_100)));
sc_writeFragData2(vec4(l9_109,packValue(l9_108),packValue(l9_108),packValue(l9_108)));
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
vec2 l9_112=sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw);
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture(sc_OITFrontDepthTexture,l9_112).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
int l9_113[8];
int l9_114[8];
int l9_115=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_115<8)
{
l9_113[l9_115]=0;
l9_114[l9_115]=0;
l9_115++;
continue;
}
else
{
break;
}
}
int l9_116;
#if (sc_OITMaxLayers8)
{
l9_116=2;
}
#else
{
l9_116=1;
}
#endif
int l9_117=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_117<l9_116)
{
vec4 l9_118;
vec4 l9_119;
vec4 l9_120;
if (l9_117==0)
{
l9_120=texture(sc_OITAlpha0,l9_112);
l9_119=texture(sc_OITDepthLow0,l9_112);
l9_118=texture(sc_OITDepthHigh0,l9_112);
}
else
{
l9_120=vec4(0.0);
l9_119=vec4(0.0);
l9_118=vec4(0.0);
}
vec4 l9_121;
vec4 l9_122;
vec4 l9_123;
if (l9_117==1)
{
l9_123=texture(sc_OITAlpha1,l9_112);
l9_122=texture(sc_OITDepthLow1,l9_112);
l9_121=texture(sc_OITDepthHigh1,l9_112);
}
else
{
l9_123=l9_120;
l9_122=l9_119;
l9_121=l9_118;
}
if (any(notEqual(l9_121,vec4(0.0)))||any(notEqual(l9_122,vec4(0.0))))
{
int l9_124[8]=l9_113;
unpackValues(l9_121.w,l9_117,l9_124);
unpackValues(l9_121.z,l9_117,l9_124);
unpackValues(l9_121.y,l9_117,l9_124);
unpackValues(l9_121.x,l9_117,l9_124);
unpackValues(l9_122.w,l9_117,l9_124);
unpackValues(l9_122.z,l9_117,l9_124);
unpackValues(l9_122.y,l9_117,l9_124);
unpackValues(l9_122.x,l9_117,l9_124);
int l9_133[8]=l9_114;
unpackValues(l9_123.w,l9_117,l9_133);
unpackValues(l9_123.z,l9_117,l9_133);
unpackValues(l9_123.y,l9_117,l9_133);
unpackValues(l9_123.x,l9_117,l9_133);
}
l9_117++;
continue;
}
else
{
break;
}
}
vec4 l9_138=texture(sc_OITFilteredDepthBoundsTexture,l9_112);
vec2 l9_139=l9_138.xy;
int l9_140;
#if (sc_SkinBonesCount>0)
{
l9_140=encodeDepth(((1.0-l9_138.x)*1000.0)+getDepthOrderingEpsilon(),l9_139);
}
#else
{
l9_140=0;
}
#endif
int l9_141=encodeDepth(viewSpaceDepth(),l9_139);
vec4 l9_142;
l9_142=l9_97*l9_97.w;
vec4 l9_143;
int l9_144=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_144<8)
{
int l9_145=l9_113[l9_144];
int l9_146=l9_141-l9_140;
bool l9_147=l9_145<l9_146;
bool l9_148;
if (l9_147)
{
l9_148=l9_113[l9_144]>0;
}
else
{
l9_148=l9_147;
}
if (l9_148)
{
vec3 l9_149=l9_142.xyz*(1.0-(float(l9_114[l9_144])/255.0));
l9_143=vec4(l9_149.x,l9_149.y,l9_149.z,l9_142.w);
}
else
{
l9_143=l9_142;
}
l9_142=l9_143;
l9_144++;
continue;
}
else
{
break;
}
}
sc_writeFragData0(l9_142);
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
if (abs(gl_FragCoord.z-texture(sc_OITFrontDepthTexture,sc_ScreenCoordsGlobalToView((gl_FragCoord.xy*sc_WindowToViewportTransform.xy)+sc_WindowToViewportTransform.zw)).x)>getFrontLayerZTestEpsilon())
{
discard;
}
sc_writeFragData0(l9_97);
}
#endif
}
#else
{
sc_writeFragData0(l9_96);
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
#endif // #if SC_RT_RECEIVER_MODE
#endif // #elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
