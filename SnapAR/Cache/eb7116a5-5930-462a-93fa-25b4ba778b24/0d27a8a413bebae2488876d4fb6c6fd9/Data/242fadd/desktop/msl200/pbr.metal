#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_BACKEND_SHADER_FLAGS_END__
#endif
namespace SNAP_VS {
int sc_GetStereoViewIndex()
{
    return 0;
}
}
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
    #ifndef sc_SampleTexture
        #define sc_SampleTexture sc_SampleTextureBiasOrLevel
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
//SG_REFLECTION_BEGIN(200)
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
//output vec4 FragColor0 0
//output vec4 FragColor1 1
//output vec4 FragColor2 2
//output vec4 FragColor3 3
//output uvec4 position_and_mask 0
//output uvec4 normal_and_more 1
//sampler sampler baseTexSmpSC 2:28
//sampler sampler intensityTextureSmpSC 2:29
//sampler sampler materialParamsTexSmpSC 2:30
//sampler sampler normalTexSmpSC 2:31
//sampler sampler sc_EnvmapDiffuseSmpSC 2:32
//sampler sampler sc_EnvmapSpecularSmpSC 2:33
//sampler sampler sc_RayTracedAoTextureSmpSC 2:35
//sampler sampler sc_RayTracedDiffIndTextureSmpSC 2:36
//sampler sampler sc_RayTracedReflectionTextureSmpSC 2:37
//sampler sampler sc_RayTracedShadowTextureSmpSC 2:38
//sampler sampler sc_SSAOTextureSmpSC 2:39
//sampler sampler sc_ScreenTextureSmpSC 2:40
//sampler sampler sc_ShadowTextureSmpSC 2:41
//sampler sampler z_hitIdAndBarycentricSmp 2:43
//sampler sampler z_rayDirectionsSmpSC 2:44
//texture texture2D baseTex 2:4:2:28
//texture texture2D intensityTexture 2:5:2:29
//texture texture2D materialParamsTex 2:6:2:30
//texture texture2D normalTex 2:7:2:31
//texture texture2D sc_EnvmapDiffuse 2:8:2:32
//texture texture2D sc_EnvmapSpecular 2:9:2:33
//texture texture2D sc_RayTracedAoTexture 2:18:2:35
//texture texture2D sc_RayTracedDiffIndTexture 2:19:2:36
//texture texture2D sc_RayTracedReflectionTexture 2:20:2:37
//texture texture2D sc_RayTracedShadowTexture 2:21:2:38
//texture texture2D sc_SSAOTexture 2:22:2:39
//texture texture2D sc_ScreenTexture 2:23:2:40
//texture texture2D sc_ShadowTexture 2:24:2:41
//texture utexture2D z_hitIdAndBarycentric 2:26:2:43
//texture texture2D z_rayDirections 2:27:2:44
//ubo float sc_BonesUBO 2:3:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:45:4832 {
//sc_PointLight_t sc_PointLights 0:[3]:80
//bool sc_PointLights.falloffEnabled 0
//float sc_PointLights.falloffEndDistance 4
//float sc_PointLights.negRcpFalloffEndDistance4 8
//float sc_PointLights.angleScale 12
//float sc_PointLights.angleOffset 16
//float3 sc_PointLights.direction 32
//float3 sc_PointLights.position 48
//float4 sc_PointLights.color 64
//sc_DirectionalLight_t sc_DirectionalLights 240:[3]:32
//float3 sc_DirectionalLights.direction 0
//float4 sc_DirectionalLights.color 16
//sc_AmbientLight_t sc_AmbientLights 336:[3]:32
//float3 sc_AmbientLights.color 0
//float sc_AmbientLights.intensity 16
//sc_LightEstimationData_t sc_LightEstimationData 432
//sc_SphericalGaussianLight_t sc_LightEstimationData.sg 0:[12]:48
//float3 sc_LightEstimationData.sg.color 0
//float sc_LightEstimationData.sg.sharpness 16
//float3 sc_LightEstimationData.sg.axis 32
//float3 sc_LightEstimationData.ambientLight 576
//float4 sc_EnvmapDiffuseSize 1024
//float4 sc_EnvmapDiffuseDims 1040
//float4 sc_EnvmapDiffuseView 1056
//float4 sc_EnvmapSpecularSize 1072
//float4 sc_EnvmapSpecularDims 1088
//float4 sc_EnvmapSpecularView 1104
//float3 sc_EnvmapRotation 1120
//float sc_EnvmapExposure 1136
//float3 sc_Sh 1152:[9]:16
//float sc_ShIntensity 1296
//float4 sc_Time 1312
//float4 sc_UniformConstants 1328
//float4 sc_GeometryInfo 1344
//float4x4 sc_ModelViewProjectionMatrixArray 1360:[2]:64
//float4x4 sc_ModelViewProjectionMatrixInverseArray 1488:[2]:64
//float4x4 sc_ViewProjectionMatrixArray 1616:[2]:64
//float4x4 sc_ViewProjectionMatrixInverseArray 1744:[2]:64
//float4x4 sc_ModelViewMatrixArray 1872:[2]:64
//float4x4 sc_ModelViewMatrixInverseArray 2000:[2]:64
//float3x3 sc_ViewNormalMatrixArray 2128:[2]:48
//float3x3 sc_ViewNormalMatrixInverseArray 2224:[2]:48
//float4x4 sc_ProjectionMatrixArray 2320:[2]:64
//float4x4 sc_ProjectionMatrixInverseArray 2448:[2]:64
//float4x4 sc_ViewMatrixArray 2576:[2]:64
//float4x4 sc_ViewMatrixInverseArray 2704:[2]:64
//float4x4 sc_PrevFrameViewProjectionMatrixArray 2832:[2]:64
//float4x4 sc_ModelMatrix 2960
//float4x4 sc_ModelMatrixInverse 3024
//float3x3 sc_NormalMatrix 3088
//float3x3 sc_NormalMatrixInverse 3136
//float4x4 sc_PrevFrameModelMatrix 3184
//float4x4 sc_PrevFrameModelMatrixInverse 3248
//float3 sc_LocalAabbMin 3312
//float3 sc_LocalAabbMax 3328
//float3 sc_WorldAabbMin 3344
//float3 sc_WorldAabbMax 3360
//float4 sc_WindowToViewportTransform 3376
//sc_Camera_t sc_Camera 3392
//float3 sc_Camera.position 0
//float sc_Camera.aspect 16
//float2 sc_Camera.clipPlanes 24
//float sc_ShadowDensity 3424
//float4 sc_ShadowColor 3440
//float4x4 sc_ProjectorMatrix 3456
//float _sc_GetFramebufferColorInvalidUsageMarker 3520
//float shaderComplexityValue 3524
//float sc_DisableFrustumCullingMarker 3528
//float4 weights0 3536
//float4 weights1 3552
//float4 weights2 3568
//float4 sc_StereoClipPlanes 3584:[2]:16
//int sc_FallbackInstanceID 3616
//float _sc_framebufferFetchMarker 3620
//float2 sc_TAAJitterOffset 3624
//float strandWidth 3632
//float strandTaper 3636
//float4 sc_StrandDataMapTextureSize 3648
//float clumpInstanceCount 3664
//float clumpRadius 3668
//float clumpTipScale 3672
//float hairstyleInstanceCount 3676
//float hairstyleNoise 3680
//float4 sc_ScreenTextureSize 3696
//float4 sc_ScreenTextureDims 3712
//float4 sc_ScreenTextureView 3728
//bool receivesRayTracedReflections 3744
//bool isProxyMode 3748
//bool receivesRayTracedShadows 3752
//bool receivesRayTracedDiffuseIndirect 3756
//bool receivesRayTracedAo 3760
//float4 sc_RayTracedReflectionTextureSize 3776
//float4 sc_RayTracedReflectionTextureDims 3792
//float4 sc_RayTracedReflectionTextureView 3808
//float4 sc_RayTracedShadowTextureSize 3824
//float4 sc_RayTracedShadowTextureDims 3840
//float4 sc_RayTracedShadowTextureView 3856
//float4 sc_RayTracedDiffIndTextureSize 3872
//float4 sc_RayTracedDiffIndTextureDims 3888
//float4 sc_RayTracedDiffIndTextureView 3904
//float4 sc_RayTracedAoTextureSize 3920
//float4 sc_RayTracedAoTextureDims 3936
//float4 sc_RayTracedAoTextureView 3952
//float receiver_mask 3968
//float3 OriginNormalizationScale 3984
//float3 OriginNormalizationScaleInv 4000
//float3 OriginNormalizationOffset 4016
//int receiverId 4032
//int instance_id 4036
//int lray_triangles_last 4040
//bool noEarlyZ 4044
//bool has_animated_pn 4048
//int emitter_stride 4052
//int proxy_offset_position 4056
//int proxy_offset_normal 4060
//int proxy_offset_tangent 4064
//int proxy_offset_color 4068
//int proxy_offset_texture0 4072
//int proxy_offset_texture1 4076
//int proxy_offset_texture2 4080
//int proxy_offset_texture3 4084
//int proxy_format_position 4088
//int proxy_format_normal 4092
//int proxy_format_tangent 4096
//int proxy_format_color 4100
//int proxy_format_texture0 4104
//int proxy_format_texture1 4108
//int proxy_format_texture2 4112
//int proxy_format_texture3 4116
//float4 z_rayDirectionsSize 4128
//float4 z_rayDirectionsDims 4144
//float4 z_rayDirectionsView 4160
//float correctedIntensity 4176
//float4 intensityTextureSize 4192
//float4 intensityTextureDims 4208
//float4 intensityTextureView 4224
//float3x3 intensityTextureTransform 4240
//float4 intensityTextureUvMinMax 4288
//float4 intensityTextureBorderColor 4304
//float reflBlurWidth 4320
//float reflBlurMinRough 4324
//float reflBlurMaxRough 4328
//int overrideTimeEnabled 4332
//float overrideTimeElapsed 4336
//float overrideTimeDelta 4340
//int PreviewEnabled 4344
//int PreviewNodeID 4348
//float alphaTestThreshold 4352
//float4 baseTexSize 4368
//float4 baseTexDims 4384
//float4 baseTexView 4400
//float3x3 baseTexTransform 4416
//float4 baseTexUvMinMax 4464
//float4 baseTexBorderColor 4480
//float uvScale 4496
//float4 normalTexSize 4512
//float4 normalTexDims 4528
//float4 normalTexView 4544
//float3x3 normalTexTransform 4560
//float4 normalTexUvMinMax 4608
//float4 normalTexBorderColor 4624
//float4 materialParamsTexSize 4640
//float4 materialParamsTexDims 4656
//float4 materialParamsTexView 4672
//float3x3 materialParamsTexTransform 4688
//float4 materialParamsTexUvMinMax 4736
//float4 materialParamsTexBorderColor 4752
//float2 Port_Center_N016 4768
//float3 Port_Emissive_N006 4784
//float3 Port_SpecularAO_N006 4800
//float depthRef 4816
//}
//ssbo int layoutIndices 2:0:4 {
//uint _Triangles 0:[]:4
//}
//ssbo float layoutVerticesPN 2:2:4 {
//float _VerticesPN 0:[]:4
//}
//ssbo float layoutVertices 2:1:4 {
//float _Vertices 0:[]:4
//}
//spec_const bool BLEND_MODE_AVERAGE 1000
//spec_const bool BLEND_MODE_BRIGHT 1001
//spec_const bool BLEND_MODE_COLOR_BURN 1002
//spec_const bool BLEND_MODE_COLOR_DODGE 1003
//spec_const bool BLEND_MODE_COLOR 1004
//spec_const bool BLEND_MODE_DARKEN 1005
//spec_const bool BLEND_MODE_DIFFERENCE 1006
//spec_const bool BLEND_MODE_DIVIDE 1007
//spec_const bool BLEND_MODE_DIVISION 1008
//spec_const bool BLEND_MODE_EXCLUSION 1009
//spec_const bool BLEND_MODE_FORGRAY 1010
//spec_const bool BLEND_MODE_HARD_GLOW 1011
//spec_const bool BLEND_MODE_HARD_LIGHT 1012
//spec_const bool BLEND_MODE_HARD_MIX 1013
//spec_const bool BLEND_MODE_HARD_PHOENIX 1014
//spec_const bool BLEND_MODE_HARD_REFLECT 1015
//spec_const bool BLEND_MODE_HUE 1016
//spec_const bool BLEND_MODE_INTENSE 1017
//spec_const bool BLEND_MODE_LIGHTEN 1018
//spec_const bool BLEND_MODE_LINEAR_LIGHT 1019
//spec_const bool BLEND_MODE_LUMINOSITY 1020
//spec_const bool BLEND_MODE_NEGATION 1021
//spec_const bool BLEND_MODE_NOTBRIGHT 1022
//spec_const bool BLEND_MODE_OVERLAY 1023
//spec_const bool BLEND_MODE_PIN_LIGHT 1024
//spec_const bool BLEND_MODE_REALISTIC 1025
//spec_const bool BLEND_MODE_SATURATION 1026
//spec_const bool BLEND_MODE_SOFT_LIGHT 1027
//spec_const bool BLEND_MODE_SUBTRACT 1028
//spec_const bool BLEND_MODE_VIVID_LIGHT 1029
//spec_const bool ENABLE_STIPPLE_PATTERN_TEST 1030
//spec_const bool SC_USE_CLAMP_TO_BORDER_baseTex 1031
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 1032
//spec_const bool SC_USE_CLAMP_TO_BORDER_materialParamsTex 1033
//spec_const bool SC_USE_CLAMP_TO_BORDER_normalTex 1034
//spec_const bool SC_USE_UV_MIN_MAX_baseTex 1035
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 1036
//spec_const bool SC_USE_UV_MIN_MAX_materialParamsTex 1037
//spec_const bool SC_USE_UV_MIN_MAX_normalTex 1038
//spec_const bool SC_USE_UV_TRANSFORM_baseTex 1039
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 1040
//spec_const bool SC_USE_UV_TRANSFORM_materialParamsTex 1041
//spec_const bool SC_USE_UV_TRANSFORM_normalTex 1042
//spec_const bool UseViewSpaceDepthVariant 1043
//spec_const bool baseTexHasSwappedViews 1044
//spec_const bool intensityTextureHasSwappedViews 1045
//spec_const bool materialParamsTexHasSwappedViews 1046
//spec_const bool normalTexHasSwappedViews 1047
//spec_const bool sc_BlendMode_AddWithAlphaFactor 1048
//spec_const bool sc_BlendMode_Add 1049
//spec_const bool sc_BlendMode_AlphaTest 1050
//spec_const bool sc_BlendMode_AlphaToCoverage 1051
//spec_const bool sc_BlendMode_ColoredGlass 1052
//spec_const bool sc_BlendMode_Custom 1053
//spec_const bool sc_BlendMode_Max 1054
//spec_const bool sc_BlendMode_Min 1055
//spec_const bool sc_BlendMode_MultiplyOriginal 1056
//spec_const bool sc_BlendMode_Multiply 1057
//spec_const bool sc_BlendMode_Normal 1058
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 1059
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 1060
//spec_const bool sc_BlendMode_PremultipliedAlpha 1061
//spec_const bool sc_BlendMode_Screen 1062
//spec_const bool sc_DepthOnly 1063
//spec_const bool sc_EnvmapDiffuseHasSwappedViews 1064
//spec_const bool sc_EnvmapSpecularHasSwappedViews 1065
//spec_const bool sc_FramebufferFetch 1066
//spec_const bool sc_HasDiffuseEnvmap 1067
//spec_const bool sc_LightEstimation 1068
//spec_const bool sc_MotionVectorsPass 1069
//spec_const bool sc_OITCompositingPass 1070
//spec_const bool sc_OITDepthBoundsPass 1071
//spec_const bool sc_OITDepthGatherPass 1072
//spec_const bool sc_ProjectiveShadowsCaster 1073
//spec_const bool sc_ProjectiveShadowsReceiver 1074
//spec_const bool sc_ProxyAlphaOne 1075
//spec_const bool sc_RayTracedAoTextureHasSwappedViews 1076
//spec_const bool sc_RayTracedDiffIndTextureHasSwappedViews 1077
//spec_const bool sc_RayTracedReflectionTextureHasSwappedViews 1078
//spec_const bool sc_RayTracedShadowTextureHasSwappedViews 1079
//spec_const bool sc_RenderAlphaToColor 1080
//spec_const bool sc_SSAOEnabled 1081
//spec_const bool sc_ScreenTextureHasSwappedViews 1082
//spec_const bool sc_ShaderComplexityAnalyzer 1083
//spec_const bool sc_UseFramebufferFetchMarker 1084
//spec_const bool sc_VertexBlendingUseNormals 1085
//spec_const bool sc_VertexBlending 1086
//spec_const int SC_DEVICE_CLASS 1087
//spec_const int SC_SOFTWARE_WRAP_MODE_U_baseTex 1088
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 1089
//spec_const int SC_SOFTWARE_WRAP_MODE_U_materialParamsTex 1090
//spec_const int SC_SOFTWARE_WRAP_MODE_U_normalTex 1091
//spec_const int SC_SOFTWARE_WRAP_MODE_V_baseTex 1092
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 1093
//spec_const int SC_SOFTWARE_WRAP_MODE_V_materialParamsTex 1094
//spec_const int SC_SOFTWARE_WRAP_MODE_V_normalTex 1095
//spec_const int baseTexLayout 1096
//spec_const int intensityTextureLayout 1097
//spec_const int materialParamsTexLayout 1098
//spec_const int normalTexLayout 1099
//spec_const int sc_AmbientLightMode0 1100
//spec_const int sc_AmbientLightMode1 1101
//spec_const int sc_AmbientLightMode2 1102
//spec_const int sc_AmbientLightMode_Constant 1103
//spec_const int sc_AmbientLightMode_EnvironmentMap 1104
//spec_const int sc_AmbientLightMode_FromCamera 1105
//spec_const int sc_AmbientLightMode_SphericalHarmonics 1106
//spec_const int sc_AmbientLightsCount 1107
//spec_const int sc_DepthBufferMode 1108
//spec_const int sc_DirectionalLightsCount 1109
//spec_const int sc_EnvLightMode 1110
//spec_const int sc_EnvmapDiffuseLayout 1111
//spec_const int sc_EnvmapSpecularLayout 1112
//spec_const int sc_LightEstimationSGCount 1113
//spec_const int sc_MaxTextureImageUnits 1114
//spec_const int sc_PointLightsCount 1115
//spec_const int sc_RayTracedAoTextureLayout 1116
//spec_const int sc_RayTracedDiffIndTextureLayout 1117
//spec_const int sc_RayTracedReflectionTextureLayout 1118
//spec_const int sc_RayTracedShadowTextureLayout 1119
//spec_const int sc_RenderingSpace 1120
//spec_const int sc_ScreenTextureLayout 1121
//spec_const int sc_SkinBonesCount 1122
//spec_const int sc_StereoRenderingMode 1123
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1124
//SG_REFLECTION_END
constant bool BLEND_MODE_AVERAGE [[function_constant(1000)]];
constant bool BLEND_MODE_AVERAGE_tmp = is_function_constant_defined(BLEND_MODE_AVERAGE) ? BLEND_MODE_AVERAGE : false;
constant bool BLEND_MODE_BRIGHT [[function_constant(1001)]];
constant bool BLEND_MODE_BRIGHT_tmp = is_function_constant_defined(BLEND_MODE_BRIGHT) ? BLEND_MODE_BRIGHT : false;
constant bool BLEND_MODE_COLOR_BURN [[function_constant(1002)]];
constant bool BLEND_MODE_COLOR_BURN_tmp = is_function_constant_defined(BLEND_MODE_COLOR_BURN) ? BLEND_MODE_COLOR_BURN : false;
constant bool BLEND_MODE_COLOR_DODGE [[function_constant(1003)]];
constant bool BLEND_MODE_COLOR_DODGE_tmp = is_function_constant_defined(BLEND_MODE_COLOR_DODGE) ? BLEND_MODE_COLOR_DODGE : false;
constant bool BLEND_MODE_COLOR [[function_constant(1004)]];
constant bool BLEND_MODE_COLOR_tmp = is_function_constant_defined(BLEND_MODE_COLOR) ? BLEND_MODE_COLOR : false;
constant bool BLEND_MODE_DARKEN [[function_constant(1005)]];
constant bool BLEND_MODE_DARKEN_tmp = is_function_constant_defined(BLEND_MODE_DARKEN) ? BLEND_MODE_DARKEN : false;
constant bool BLEND_MODE_DIFFERENCE [[function_constant(1006)]];
constant bool BLEND_MODE_DIFFERENCE_tmp = is_function_constant_defined(BLEND_MODE_DIFFERENCE) ? BLEND_MODE_DIFFERENCE : false;
constant bool BLEND_MODE_DIVIDE [[function_constant(1007)]];
constant bool BLEND_MODE_DIVIDE_tmp = is_function_constant_defined(BLEND_MODE_DIVIDE) ? BLEND_MODE_DIVIDE : false;
constant bool BLEND_MODE_DIVISION [[function_constant(1008)]];
constant bool BLEND_MODE_DIVISION_tmp = is_function_constant_defined(BLEND_MODE_DIVISION) ? BLEND_MODE_DIVISION : false;
constant bool BLEND_MODE_EXCLUSION [[function_constant(1009)]];
constant bool BLEND_MODE_EXCLUSION_tmp = is_function_constant_defined(BLEND_MODE_EXCLUSION) ? BLEND_MODE_EXCLUSION : false;
constant bool BLEND_MODE_FORGRAY [[function_constant(1010)]];
constant bool BLEND_MODE_FORGRAY_tmp = is_function_constant_defined(BLEND_MODE_FORGRAY) ? BLEND_MODE_FORGRAY : false;
constant bool BLEND_MODE_HARD_GLOW [[function_constant(1011)]];
constant bool BLEND_MODE_HARD_GLOW_tmp = is_function_constant_defined(BLEND_MODE_HARD_GLOW) ? BLEND_MODE_HARD_GLOW : false;
constant bool BLEND_MODE_HARD_LIGHT [[function_constant(1012)]];
constant bool BLEND_MODE_HARD_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_HARD_LIGHT) ? BLEND_MODE_HARD_LIGHT : false;
constant bool BLEND_MODE_HARD_MIX [[function_constant(1013)]];
constant bool BLEND_MODE_HARD_MIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_MIX) ? BLEND_MODE_HARD_MIX : false;
constant bool BLEND_MODE_HARD_PHOENIX [[function_constant(1014)]];
constant bool BLEND_MODE_HARD_PHOENIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_PHOENIX) ? BLEND_MODE_HARD_PHOENIX : false;
constant bool BLEND_MODE_HARD_REFLECT [[function_constant(1015)]];
constant bool BLEND_MODE_HARD_REFLECT_tmp = is_function_constant_defined(BLEND_MODE_HARD_REFLECT) ? BLEND_MODE_HARD_REFLECT : false;
constant bool BLEND_MODE_HUE [[function_constant(1016)]];
constant bool BLEND_MODE_HUE_tmp = is_function_constant_defined(BLEND_MODE_HUE) ? BLEND_MODE_HUE : false;
constant bool BLEND_MODE_INTENSE [[function_constant(1017)]];
constant bool BLEND_MODE_INTENSE_tmp = is_function_constant_defined(BLEND_MODE_INTENSE) ? BLEND_MODE_INTENSE : false;
constant bool BLEND_MODE_LIGHTEN [[function_constant(1018)]];
constant bool BLEND_MODE_LIGHTEN_tmp = is_function_constant_defined(BLEND_MODE_LIGHTEN) ? BLEND_MODE_LIGHTEN : false;
constant bool BLEND_MODE_LINEAR_LIGHT [[function_constant(1019)]];
constant bool BLEND_MODE_LINEAR_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_LINEAR_LIGHT) ? BLEND_MODE_LINEAR_LIGHT : false;
constant bool BLEND_MODE_LUMINOSITY [[function_constant(1020)]];
constant bool BLEND_MODE_LUMINOSITY_tmp = is_function_constant_defined(BLEND_MODE_LUMINOSITY) ? BLEND_MODE_LUMINOSITY : false;
constant bool BLEND_MODE_NEGATION [[function_constant(1021)]];
constant bool BLEND_MODE_NEGATION_tmp = is_function_constant_defined(BLEND_MODE_NEGATION) ? BLEND_MODE_NEGATION : false;
constant bool BLEND_MODE_NOTBRIGHT [[function_constant(1022)]];
constant bool BLEND_MODE_NOTBRIGHT_tmp = is_function_constant_defined(BLEND_MODE_NOTBRIGHT) ? BLEND_MODE_NOTBRIGHT : false;
constant bool BLEND_MODE_OVERLAY [[function_constant(1023)]];
constant bool BLEND_MODE_OVERLAY_tmp = is_function_constant_defined(BLEND_MODE_OVERLAY) ? BLEND_MODE_OVERLAY : false;
constant bool BLEND_MODE_PIN_LIGHT [[function_constant(1024)]];
constant bool BLEND_MODE_PIN_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_PIN_LIGHT) ? BLEND_MODE_PIN_LIGHT : false;
constant bool BLEND_MODE_REALISTIC [[function_constant(1025)]];
constant bool BLEND_MODE_REALISTIC_tmp = is_function_constant_defined(BLEND_MODE_REALISTIC) ? BLEND_MODE_REALISTIC : false;
constant bool BLEND_MODE_SATURATION [[function_constant(1026)]];
constant bool BLEND_MODE_SATURATION_tmp = is_function_constant_defined(BLEND_MODE_SATURATION) ? BLEND_MODE_SATURATION : false;
constant bool BLEND_MODE_SOFT_LIGHT [[function_constant(1027)]];
constant bool BLEND_MODE_SOFT_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_SOFT_LIGHT) ? BLEND_MODE_SOFT_LIGHT : false;
constant bool BLEND_MODE_SUBTRACT [[function_constant(1028)]];
constant bool BLEND_MODE_SUBTRACT_tmp = is_function_constant_defined(BLEND_MODE_SUBTRACT) ? BLEND_MODE_SUBTRACT : false;
constant bool BLEND_MODE_VIVID_LIGHT [[function_constant(1029)]];
constant bool BLEND_MODE_VIVID_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_VIVID_LIGHT) ? BLEND_MODE_VIVID_LIGHT : false;
constant bool ENABLE_STIPPLE_PATTERN_TEST [[function_constant(1030)]];
constant bool ENABLE_STIPPLE_PATTERN_TEST_tmp = is_function_constant_defined(ENABLE_STIPPLE_PATTERN_TEST) ? ENABLE_STIPPLE_PATTERN_TEST : false;
constant bool SC_USE_CLAMP_TO_BORDER_baseTex [[function_constant(1031)]];
constant bool SC_USE_CLAMP_TO_BORDER_baseTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_baseTex) ? SC_USE_CLAMP_TO_BORDER_baseTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(1032)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_materialParamsTex [[function_constant(1033)]];
constant bool SC_USE_CLAMP_TO_BORDER_materialParamsTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_materialParamsTex) ? SC_USE_CLAMP_TO_BORDER_materialParamsTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_normalTex [[function_constant(1034)]];
constant bool SC_USE_CLAMP_TO_BORDER_normalTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_normalTex) ? SC_USE_CLAMP_TO_BORDER_normalTex : false;
constant bool SC_USE_UV_MIN_MAX_baseTex [[function_constant(1035)]];
constant bool SC_USE_UV_MIN_MAX_baseTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_baseTex) ? SC_USE_UV_MIN_MAX_baseTex : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(1036)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_materialParamsTex [[function_constant(1037)]];
constant bool SC_USE_UV_MIN_MAX_materialParamsTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_materialParamsTex) ? SC_USE_UV_MIN_MAX_materialParamsTex : false;
constant bool SC_USE_UV_MIN_MAX_normalTex [[function_constant(1038)]];
constant bool SC_USE_UV_MIN_MAX_normalTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_normalTex) ? SC_USE_UV_MIN_MAX_normalTex : false;
constant bool SC_USE_UV_TRANSFORM_baseTex [[function_constant(1039)]];
constant bool SC_USE_UV_TRANSFORM_baseTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_baseTex) ? SC_USE_UV_TRANSFORM_baseTex : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(1040)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_materialParamsTex [[function_constant(1041)]];
constant bool SC_USE_UV_TRANSFORM_materialParamsTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_materialParamsTex) ? SC_USE_UV_TRANSFORM_materialParamsTex : false;
constant bool SC_USE_UV_TRANSFORM_normalTex [[function_constant(1042)]];
constant bool SC_USE_UV_TRANSFORM_normalTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_normalTex) ? SC_USE_UV_TRANSFORM_normalTex : false;
constant bool UseViewSpaceDepthVariant [[function_constant(1043)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool baseTexHasSwappedViews [[function_constant(1044)]];
constant bool baseTexHasSwappedViews_tmp = is_function_constant_defined(baseTexHasSwappedViews) ? baseTexHasSwappedViews : false;
constant bool intensityTextureHasSwappedViews [[function_constant(1045)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool materialParamsTexHasSwappedViews [[function_constant(1046)]];
constant bool materialParamsTexHasSwappedViews_tmp = is_function_constant_defined(materialParamsTexHasSwappedViews) ? materialParamsTexHasSwappedViews : false;
constant bool normalTexHasSwappedViews [[function_constant(1047)]];
constant bool normalTexHasSwappedViews_tmp = is_function_constant_defined(normalTexHasSwappedViews) ? normalTexHasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(1048)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(1049)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(1050)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(1051)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(1052)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(1053)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(1054)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(1055)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(1056)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(1057)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(1058)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(1059)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(1060)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(1061)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(1062)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_DepthOnly [[function_constant(1063)]];
constant bool sc_DepthOnly_tmp = is_function_constant_defined(sc_DepthOnly) ? sc_DepthOnly : false;
constant bool sc_EnvmapDiffuseHasSwappedViews [[function_constant(1064)]];
constant bool sc_EnvmapDiffuseHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapDiffuseHasSwappedViews) ? sc_EnvmapDiffuseHasSwappedViews : false;
constant bool sc_EnvmapSpecularHasSwappedViews [[function_constant(1065)]];
constant bool sc_EnvmapSpecularHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapSpecularHasSwappedViews) ? sc_EnvmapSpecularHasSwappedViews : false;
constant bool sc_FramebufferFetch [[function_constant(1066)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_HasDiffuseEnvmap [[function_constant(1067)]];
constant bool sc_HasDiffuseEnvmap_tmp = is_function_constant_defined(sc_HasDiffuseEnvmap) ? sc_HasDiffuseEnvmap : false;
constant bool sc_LightEstimation [[function_constant(1068)]];
constant bool sc_LightEstimation_tmp = is_function_constant_defined(sc_LightEstimation) ? sc_LightEstimation : false;
constant bool sc_MotionVectorsPass [[function_constant(1069)]];
constant bool sc_MotionVectorsPass_tmp = is_function_constant_defined(sc_MotionVectorsPass) ? sc_MotionVectorsPass : false;
constant bool sc_OITCompositingPass [[function_constant(1070)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(1071)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(1072)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(1073)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_ProjectiveShadowsReceiver [[function_constant(1074)]];
constant bool sc_ProjectiveShadowsReceiver_tmp = is_function_constant_defined(sc_ProjectiveShadowsReceiver) ? sc_ProjectiveShadowsReceiver : false;
constant bool sc_ProxyAlphaOne [[function_constant(1075)]];
constant bool sc_ProxyAlphaOne_tmp = is_function_constant_defined(sc_ProxyAlphaOne) ? sc_ProxyAlphaOne : false;
constant bool sc_RayTracedAoTextureHasSwappedViews [[function_constant(1076)]];
constant bool sc_RayTracedAoTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedAoTextureHasSwappedViews) ? sc_RayTracedAoTextureHasSwappedViews : false;
constant bool sc_RayTracedDiffIndTextureHasSwappedViews [[function_constant(1077)]];
constant bool sc_RayTracedDiffIndTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureHasSwappedViews) ? sc_RayTracedDiffIndTextureHasSwappedViews : false;
constant bool sc_RayTracedReflectionTextureHasSwappedViews [[function_constant(1078)]];
constant bool sc_RayTracedReflectionTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureHasSwappedViews) ? sc_RayTracedReflectionTextureHasSwappedViews : false;
constant bool sc_RayTracedShadowTextureHasSwappedViews [[function_constant(1079)]];
constant bool sc_RayTracedShadowTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedShadowTextureHasSwappedViews) ? sc_RayTracedShadowTextureHasSwappedViews : false;
constant bool sc_RenderAlphaToColor [[function_constant(1080)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_SSAOEnabled [[function_constant(1081)]];
constant bool sc_SSAOEnabled_tmp = is_function_constant_defined(sc_SSAOEnabled) ? sc_SSAOEnabled : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(1082)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(1083)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(1084)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant bool sc_VertexBlendingUseNormals [[function_constant(1085)]];
constant bool sc_VertexBlendingUseNormals_tmp = is_function_constant_defined(sc_VertexBlendingUseNormals) ? sc_VertexBlendingUseNormals : false;
constant bool sc_VertexBlending [[function_constant(1086)]];
constant bool sc_VertexBlending_tmp = is_function_constant_defined(sc_VertexBlending) ? sc_VertexBlending : false;
constant int SC_DEVICE_CLASS [[function_constant(1087)]];
constant int SC_DEVICE_CLASS_tmp = is_function_constant_defined(SC_DEVICE_CLASS) ? SC_DEVICE_CLASS : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_baseTex [[function_constant(1088)]];
constant int SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_baseTex) ? SC_SOFTWARE_WRAP_MODE_U_baseTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(1089)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_materialParamsTex [[function_constant(1090)]];
constant int SC_SOFTWARE_WRAP_MODE_U_materialParamsTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_materialParamsTex) ? SC_SOFTWARE_WRAP_MODE_U_materialParamsTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_normalTex [[function_constant(1091)]];
constant int SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_normalTex) ? SC_SOFTWARE_WRAP_MODE_U_normalTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_baseTex [[function_constant(1092)]];
constant int SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_baseTex) ? SC_SOFTWARE_WRAP_MODE_V_baseTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(1093)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_materialParamsTex [[function_constant(1094)]];
constant int SC_SOFTWARE_WRAP_MODE_V_materialParamsTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_materialParamsTex) ? SC_SOFTWARE_WRAP_MODE_V_materialParamsTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_normalTex [[function_constant(1095)]];
constant int SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_normalTex) ? SC_SOFTWARE_WRAP_MODE_V_normalTex : -1;
constant int baseTexLayout [[function_constant(1096)]];
constant int baseTexLayout_tmp = is_function_constant_defined(baseTexLayout) ? baseTexLayout : 0;
constant int intensityTextureLayout [[function_constant(1097)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int materialParamsTexLayout [[function_constant(1098)]];
constant int materialParamsTexLayout_tmp = is_function_constant_defined(materialParamsTexLayout) ? materialParamsTexLayout : 0;
constant int normalTexLayout [[function_constant(1099)]];
constant int normalTexLayout_tmp = is_function_constant_defined(normalTexLayout) ? normalTexLayout : 0;
constant int sc_AmbientLightMode0 [[function_constant(1100)]];
constant int sc_AmbientLightMode0_tmp = is_function_constant_defined(sc_AmbientLightMode0) ? sc_AmbientLightMode0 : 0;
constant int sc_AmbientLightMode1 [[function_constant(1101)]];
constant int sc_AmbientLightMode1_tmp = is_function_constant_defined(sc_AmbientLightMode1) ? sc_AmbientLightMode1 : 0;
constant int sc_AmbientLightMode2 [[function_constant(1102)]];
constant int sc_AmbientLightMode2_tmp = is_function_constant_defined(sc_AmbientLightMode2) ? sc_AmbientLightMode2 : 0;
constant int sc_AmbientLightMode_Constant [[function_constant(1103)]];
constant int sc_AmbientLightMode_Constant_tmp = is_function_constant_defined(sc_AmbientLightMode_Constant) ? sc_AmbientLightMode_Constant : 0;
constant int sc_AmbientLightMode_EnvironmentMap [[function_constant(1104)]];
constant int sc_AmbientLightMode_EnvironmentMap_tmp = is_function_constant_defined(sc_AmbientLightMode_EnvironmentMap) ? sc_AmbientLightMode_EnvironmentMap : 0;
constant int sc_AmbientLightMode_FromCamera [[function_constant(1105)]];
constant int sc_AmbientLightMode_FromCamera_tmp = is_function_constant_defined(sc_AmbientLightMode_FromCamera) ? sc_AmbientLightMode_FromCamera : 0;
constant int sc_AmbientLightMode_SphericalHarmonics [[function_constant(1106)]];
constant int sc_AmbientLightMode_SphericalHarmonics_tmp = is_function_constant_defined(sc_AmbientLightMode_SphericalHarmonics) ? sc_AmbientLightMode_SphericalHarmonics : 0;
constant int sc_AmbientLightsCount [[function_constant(1107)]];
constant int sc_AmbientLightsCount_tmp = is_function_constant_defined(sc_AmbientLightsCount) ? sc_AmbientLightsCount : 0;
constant int sc_DepthBufferMode [[function_constant(1108)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_DirectionalLightsCount [[function_constant(1109)]];
constant int sc_DirectionalLightsCount_tmp = is_function_constant_defined(sc_DirectionalLightsCount) ? sc_DirectionalLightsCount : 0;
constant int sc_EnvLightMode [[function_constant(1110)]];
constant int sc_EnvLightMode_tmp = is_function_constant_defined(sc_EnvLightMode) ? sc_EnvLightMode : 0;
constant int sc_EnvmapDiffuseLayout [[function_constant(1111)]];
constant int sc_EnvmapDiffuseLayout_tmp = is_function_constant_defined(sc_EnvmapDiffuseLayout) ? sc_EnvmapDiffuseLayout : 0;
constant int sc_EnvmapSpecularLayout [[function_constant(1112)]];
constant int sc_EnvmapSpecularLayout_tmp = is_function_constant_defined(sc_EnvmapSpecularLayout) ? sc_EnvmapSpecularLayout : 0;
constant int sc_LightEstimationSGCount [[function_constant(1113)]];
constant int sc_LightEstimationSGCount_tmp = is_function_constant_defined(sc_LightEstimationSGCount) ? sc_LightEstimationSGCount : 0;
constant int sc_MaxTextureImageUnits [[function_constant(1114)]];
constant int sc_MaxTextureImageUnits_tmp = is_function_constant_defined(sc_MaxTextureImageUnits) ? sc_MaxTextureImageUnits : 0;
constant int sc_PointLightsCount [[function_constant(1115)]];
constant int sc_PointLightsCount_tmp = is_function_constant_defined(sc_PointLightsCount) ? sc_PointLightsCount : 0;
constant int sc_RayTracedAoTextureLayout [[function_constant(1116)]];
constant int sc_RayTracedAoTextureLayout_tmp = is_function_constant_defined(sc_RayTracedAoTextureLayout) ? sc_RayTracedAoTextureLayout : 0;
constant int sc_RayTracedDiffIndTextureLayout [[function_constant(1117)]];
constant int sc_RayTracedDiffIndTextureLayout_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureLayout) ? sc_RayTracedDiffIndTextureLayout : 0;
constant int sc_RayTracedReflectionTextureLayout [[function_constant(1118)]];
constant int sc_RayTracedReflectionTextureLayout_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureLayout) ? sc_RayTracedReflectionTextureLayout : 0;
constant int sc_RayTracedShadowTextureLayout [[function_constant(1119)]];
constant int sc_RayTracedShadowTextureLayout_tmp = is_function_constant_defined(sc_RayTracedShadowTextureLayout) ? sc_RayTracedShadowTextureLayout : 0;
constant int sc_RenderingSpace [[function_constant(1120)]];
constant int sc_RenderingSpace_tmp = is_function_constant_defined(sc_RenderingSpace) ? sc_RenderingSpace : -1;
constant int sc_ScreenTextureLayout [[function_constant(1121)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_SkinBonesCount [[function_constant(1122)]];
constant int sc_SkinBonesCount_tmp = is_function_constant_defined(sc_SkinBonesCount) ? sc_SkinBonesCount : 0;
constant int sc_StereoRenderingMode [[function_constant(1123)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1124)]];
constant int sc_StereoRendering_IsClipDistanceEnabled_tmp = is_function_constant_defined(sc_StereoRendering_IsClipDistanceEnabled) ? sc_StereoRendering_IsClipDistanceEnabled : 0;

namespace SNAP_VS {
struct sc_Vertex_t
{
float4 position;
float3 normal;
float3 tangent;
float2 texture0;
float2 texture1;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[3];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
int receivesRayTracedReflections;
int isProxyMode;
int receivesRayTracedShadows;
int receivesRayTracedDiffuseIndirect;
int receivesRayTracedAo;
float4 sc_RayTracedReflectionTextureSize;
float4 sc_RayTracedReflectionTextureDims;
float4 sc_RayTracedReflectionTextureView;
float4 sc_RayTracedShadowTextureSize;
float4 sc_RayTracedShadowTextureDims;
float4 sc_RayTracedShadowTextureView;
float4 sc_RayTracedDiffIndTextureSize;
float4 sc_RayTracedDiffIndTextureDims;
float4 sc_RayTracedDiffIndTextureView;
float4 sc_RayTracedAoTextureSize;
float4 sc_RayTracedAoTextureDims;
float4 sc_RayTracedAoTextureView;
float receiver_mask;
float3 OriginNormalizationScale;
float3 OriginNormalizationScaleInv;
float3 OriginNormalizationOffset;
int receiverId;
int instance_id;
int lray_triangles_last;
int noEarlyZ;
int has_animated_pn;
int emitter_stride;
int proxy_offset_position;
int proxy_offset_normal;
int proxy_offset_tangent;
int proxy_offset_color;
int proxy_offset_texture0;
int proxy_offset_texture1;
int proxy_offset_texture2;
int proxy_offset_texture3;
int proxy_format_position;
int proxy_format_normal;
int proxy_format_tangent;
int proxy_format_color;
int proxy_format_texture0;
int proxy_format_texture1;
int proxy_format_texture2;
int proxy_format_texture3;
float4 z_rayDirectionsSize;
float4 z_rayDirectionsDims;
float4 z_rayDirectionsView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int PreviewEnabled;
int PreviewNodeID;
float alphaTestThreshold;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float uvScale;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float4 materialParamsTexSize;
float4 materialParamsTexDims;
float4 materialParamsTexView;
float3x3 materialParamsTexTransform;
float4 materialParamsTexUvMinMax;
float4 materialParamsTexBorderColor;
float2 Port_Center_N016;
float3 Port_Emissive_N006;
float3 Port_SpecularAO_N006;
float depthRef;
};
struct sc_Bone_t
{
float4 boneMatrix[3];
float4 normalMatrix[3];
};
struct sc_Bones_obj
{
sc_Bone_t sc_Bones[1];
};
struct ssPreviewInfo
{
float4 Color;
bool Saved;
};
struct layoutIndices_obj
{
uint _Triangles[1];
};
struct layoutVertices_obj
{
float _Vertices[1];
};
struct layoutVerticesPN_obj
{
float _VerticesPN[1];
};
struct sc_Set2
{
const device layoutIndices_obj* layoutIndices [[id(0)]];
const device layoutVertices_obj* layoutVertices [[id(1)]];
const device layoutVerticesPN_obj* layoutVerticesPN [[id(2)]];
constant sc_Bones_obj* sc_BonesUBO [[id(3)]];
texture2d<float> baseTex [[id(4)]];
texture2d<float> intensityTexture [[id(5)]];
texture2d<float> materialParamsTex [[id(6)]];
texture2d<float> normalTex [[id(7)]];
texture2d<float> sc_EnvmapDiffuse [[id(8)]];
texture2d<float> sc_EnvmapSpecular [[id(9)]];
texture2d<float> sc_RayTracedAoTexture [[id(18)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(19)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(20)]];
texture2d<float> sc_RayTracedShadowTexture [[id(21)]];
texture2d<float> sc_SSAOTexture [[id(22)]];
texture2d<float> sc_ScreenTexture [[id(23)]];
texture2d<float> sc_ShadowTexture [[id(24)]];
texture2d<uint> z_hitIdAndBarycentric [[id(26)]];
texture2d<float> z_rayDirections [[id(27)]];
sampler baseTexSmpSC [[id(28)]];
sampler intensityTextureSmpSC [[id(29)]];
sampler materialParamsTexSmpSC [[id(30)]];
sampler normalTexSmpSC [[id(31)]];
sampler sc_EnvmapDiffuseSmpSC [[id(32)]];
sampler sc_EnvmapSpecularSmpSC [[id(33)]];
sampler sc_RayTracedAoTextureSmpSC [[id(35)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(36)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(37)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(38)]];
sampler sc_SSAOTextureSmpSC [[id(39)]];
sampler sc_ScreenTextureSmpSC [[id(40)]];
sampler sc_ShadowTextureSmpSC [[id(41)]];
sampler z_hitIdAndBarycentricSmp [[id(43)]];
sampler z_rayDirectionsSmpSC [[id(44)]];
constant userUniformsObj* UserUniforms [[id(45)]];
};
struct main_vert_out
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float varViewSpaceDepth [[user(locn6)]];
float2 varShadowTex [[user(locn7)]];
int varStereoViewID [[user(locn8)]];
float varClipDistance [[user(locn9)]];
float4 varColor [[user(locn10)]];
float4 PreviewVertexColor [[user(locn11)]];
float PreviewVertexSaved [[user(locn12)]];
float4 gl_Position [[position]];
};
struct main_vert_in
{
float4 position [[attribute(0)]];
float3 normal [[attribute(1)]];
float4 tangent [[attribute(2)]];
float2 texture0 [[attribute(3)]];
float2 texture1 [[attribute(4)]];
float4 boneData [[attribute(5)]];
float3 blendShape0Pos [[attribute(6)]];
float3 blendShape1Pos [[attribute(7)]];
float3 blendShape2Pos [[attribute(8)]];
float3 blendShape3Pos [[attribute(9)]];
float3 blendShape4Pos [[attribute(10)]];
float3 blendShape5Pos [[attribute(11)]];
float3 blendShape0Normal [[attribute(12)]];
float3 blendShape1Normal [[attribute(13)]];
float3 blendShape2Normal [[attribute(14)]];
float3 positionNext [[attribute(15)]];
float3 positionPrevious [[attribute(16)]];
float4 strandProperties [[attribute(17)]];
float4 color [[attribute(18)]];
};
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
bool l9_0=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_0)
{
float4 param=float4(in.position.xy,(*sc_set2.UserUniforms).depthRef+(1e-10*in.position.z),1.0+(1e-10*in.position.w));
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1=param;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_2=dot(l9_1,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_3=l9_2;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_3;
}
}
float4 l9_4=float4(param.x,-param.y,(param.z*0.5)+(param.w*0.5),param.w);
out.gl_Position=l9_4;
return out;
}
out.PreviewVertexColor=float4(0.5);
ssPreviewInfo PreviewInfo;
PreviewInfo.Color=float4(0.5);
PreviewInfo.Saved=false;
out.PreviewVertexSaved=0.0;
sc_Vertex_t l9_6;
l9_6.position=in.position;
l9_6.normal=in.normal;
l9_6.tangent=in.tangent.xyz;
l9_6.texture0=in.texture0;
l9_6.texture1=in.texture1;
sc_Vertex_t l9_7=l9_6;
sc_Vertex_t param_1=l9_7;
sc_Vertex_t l9_8=param_1;
if ((int(sc_VertexBlending_tmp)!=0))
{
if ((int(sc_VertexBlendingUseNormals_tmp)!=0))
{
sc_Vertex_t l9_9=l9_8;
float3 l9_10=in.blendShape0Pos;
float3 l9_11=in.blendShape0Normal;
float l9_12=(*sc_set2.UserUniforms).weights0.x;
sc_Vertex_t l9_13=l9_9;
float3 l9_14=l9_10;
float l9_15=l9_12;
float3 l9_16=l9_13.position.xyz+(l9_14*l9_15);
l9_13.position=float4(l9_16.x,l9_16.y,l9_16.z,l9_13.position.w);
l9_9=l9_13;
l9_9.normal+=(l9_11*l9_12);
l9_8=l9_9;
sc_Vertex_t l9_17=l9_8;
float3 l9_18=in.blendShape1Pos;
float3 l9_19=in.blendShape1Normal;
float l9_20=(*sc_set2.UserUniforms).weights0.y;
sc_Vertex_t l9_21=l9_17;
float3 l9_22=l9_18;
float l9_23=l9_20;
float3 l9_24=l9_21.position.xyz+(l9_22*l9_23);
l9_21.position=float4(l9_24.x,l9_24.y,l9_24.z,l9_21.position.w);
l9_17=l9_21;
l9_17.normal+=(l9_19*l9_20);
l9_8=l9_17;
sc_Vertex_t l9_25=l9_8;
float3 l9_26=in.blendShape2Pos;
float3 l9_27=in.blendShape2Normal;
float l9_28=(*sc_set2.UserUniforms).weights0.z;
sc_Vertex_t l9_29=l9_25;
float3 l9_30=l9_26;
float l9_31=l9_28;
float3 l9_32=l9_29.position.xyz+(l9_30*l9_31);
l9_29.position=float4(l9_32.x,l9_32.y,l9_32.z,l9_29.position.w);
l9_25=l9_29;
l9_25.normal+=(l9_27*l9_28);
l9_8=l9_25;
}
else
{
sc_Vertex_t l9_33=l9_8;
float3 l9_34=in.blendShape0Pos;
float l9_35=(*sc_set2.UserUniforms).weights0.x;
float3 l9_36=l9_33.position.xyz+(l9_34*l9_35);
l9_33.position=float4(l9_36.x,l9_36.y,l9_36.z,l9_33.position.w);
l9_8=l9_33;
sc_Vertex_t l9_37=l9_8;
float3 l9_38=in.blendShape1Pos;
float l9_39=(*sc_set2.UserUniforms).weights0.y;
float3 l9_40=l9_37.position.xyz+(l9_38*l9_39);
l9_37.position=float4(l9_40.x,l9_40.y,l9_40.z,l9_37.position.w);
l9_8=l9_37;
sc_Vertex_t l9_41=l9_8;
float3 l9_42=in.blendShape2Pos;
float l9_43=(*sc_set2.UserUniforms).weights0.z;
float3 l9_44=l9_41.position.xyz+(l9_42*l9_43);
l9_41.position=float4(l9_44.x,l9_44.y,l9_44.z,l9_41.position.w);
l9_8=l9_41;
sc_Vertex_t l9_45=l9_8;
float3 l9_46=in.blendShape3Pos;
float l9_47=(*sc_set2.UserUniforms).weights0.w;
float3 l9_48=l9_45.position.xyz+(l9_46*l9_47);
l9_45.position=float4(l9_48.x,l9_48.y,l9_48.z,l9_45.position.w);
l9_8=l9_45;
sc_Vertex_t l9_49=l9_8;
float3 l9_50=in.blendShape4Pos;
float l9_51=(*sc_set2.UserUniforms).weights1.x;
float3 l9_52=l9_49.position.xyz+(l9_50*l9_51);
l9_49.position=float4(l9_52.x,l9_52.y,l9_52.z,l9_49.position.w);
l9_8=l9_49;
sc_Vertex_t l9_53=l9_8;
float3 l9_54=in.blendShape5Pos;
float l9_55=(*sc_set2.UserUniforms).weights1.y;
float3 l9_56=l9_53.position.xyz+(l9_54*l9_55);
l9_53.position=float4(l9_56.x,l9_56.y,l9_56.z,l9_53.position.w);
l9_8=l9_53;
}
}
param_1=l9_8;
sc_Vertex_t l9_57=param_1;
if (sc_SkinBonesCount_tmp>0)
{
float4 l9_58=float4(0.0);
if (sc_SkinBonesCount_tmp>0)
{
l9_58=float4(1.0,fract(in.boneData.yzw));
l9_58.x-=dot(l9_58.yzw,float3(1.0));
}
float4 l9_59=l9_58;
float4 l9_60=l9_59;
int l9_61=0;
int l9_62=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_62=int(in.boneData[l9_61]);
}
int l9_63=l9_62;
int l9_64=l9_63;
int l9_65=1;
int l9_66=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_66=int(in.boneData[l9_65]);
}
int l9_67=l9_66;
int l9_68=l9_67;
int l9_69=2;
int l9_70=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_70=int(in.boneData[l9_69]);
}
int l9_71=l9_70;
int l9_72=l9_71;
int l9_73=3;
int l9_74=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_74=int(in.boneData[l9_73]);
}
int l9_75=l9_74;
int l9_76=l9_75;
int l9_77=l9_64;
float4 l9_78=l9_57.position;
float3 l9_79=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_80=l9_77;
float4 l9_81=(*sc_set2.sc_BonesUBO).sc_Bones[l9_80].boneMatrix[0];
float4 l9_82=(*sc_set2.sc_BonesUBO).sc_Bones[l9_80].boneMatrix[1];
float4 l9_83=(*sc_set2.sc_BonesUBO).sc_Bones[l9_80].boneMatrix[2];
float4 l9_84[3];
l9_84[0]=l9_81;
l9_84[1]=l9_82;
l9_84[2]=l9_83;
l9_79=float3(dot(l9_78,l9_84[0]),dot(l9_78,l9_84[1]),dot(l9_78,l9_84[2]));
}
else
{
l9_79=l9_78.xyz;
}
float3 l9_85=l9_79;
float3 l9_86=l9_85;
float l9_87=l9_60.x;
int l9_88=l9_68;
float4 l9_89=l9_57.position;
float3 l9_90=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_91=l9_88;
float4 l9_92=(*sc_set2.sc_BonesUBO).sc_Bones[l9_91].boneMatrix[0];
float4 l9_93=(*sc_set2.sc_BonesUBO).sc_Bones[l9_91].boneMatrix[1];
float4 l9_94=(*sc_set2.sc_BonesUBO).sc_Bones[l9_91].boneMatrix[2];
float4 l9_95[3];
l9_95[0]=l9_92;
l9_95[1]=l9_93;
l9_95[2]=l9_94;
l9_90=float3(dot(l9_89,l9_95[0]),dot(l9_89,l9_95[1]),dot(l9_89,l9_95[2]));
}
else
{
l9_90=l9_89.xyz;
}
float3 l9_96=l9_90;
float3 l9_97=l9_96;
float l9_98=l9_60.y;
int l9_99=l9_72;
float4 l9_100=l9_57.position;
float3 l9_101=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_102=l9_99;
float4 l9_103=(*sc_set2.sc_BonesUBO).sc_Bones[l9_102].boneMatrix[0];
float4 l9_104=(*sc_set2.sc_BonesUBO).sc_Bones[l9_102].boneMatrix[1];
float4 l9_105=(*sc_set2.sc_BonesUBO).sc_Bones[l9_102].boneMatrix[2];
float4 l9_106[3];
l9_106[0]=l9_103;
l9_106[1]=l9_104;
l9_106[2]=l9_105;
l9_101=float3(dot(l9_100,l9_106[0]),dot(l9_100,l9_106[1]),dot(l9_100,l9_106[2]));
}
else
{
l9_101=l9_100.xyz;
}
float3 l9_107=l9_101;
float3 l9_108=l9_107;
float l9_109=l9_60.z;
int l9_110=l9_76;
float4 l9_111=l9_57.position;
float3 l9_112=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_113=l9_110;
float4 l9_114=(*sc_set2.sc_BonesUBO).sc_Bones[l9_113].boneMatrix[0];
float4 l9_115=(*sc_set2.sc_BonesUBO).sc_Bones[l9_113].boneMatrix[1];
float4 l9_116=(*sc_set2.sc_BonesUBO).sc_Bones[l9_113].boneMatrix[2];
float4 l9_117[3];
l9_117[0]=l9_114;
l9_117[1]=l9_115;
l9_117[2]=l9_116;
l9_112=float3(dot(l9_111,l9_117[0]),dot(l9_111,l9_117[1]),dot(l9_111,l9_117[2]));
}
else
{
l9_112=l9_111.xyz;
}
float3 l9_118=l9_112;
float3 l9_119=(((l9_86*l9_87)+(l9_97*l9_98))+(l9_108*l9_109))+(l9_118*l9_60.w);
l9_57.position=float4(l9_119.x,l9_119.y,l9_119.z,l9_57.position.w);
int l9_120=l9_64;
float3x3 l9_121=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_120].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_120].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_120].normalMatrix[2].xyz));
float3x3 l9_122=l9_121;
float3x3 l9_123=l9_122;
int l9_124=l9_68;
float3x3 l9_125=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_124].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_124].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_124].normalMatrix[2].xyz));
float3x3 l9_126=l9_125;
float3x3 l9_127=l9_126;
int l9_128=l9_72;
float3x3 l9_129=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_128].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_128].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_128].normalMatrix[2].xyz));
float3x3 l9_130=l9_129;
float3x3 l9_131=l9_130;
int l9_132=l9_76;
float3x3 l9_133=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_132].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_132].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_132].normalMatrix[2].xyz));
float3x3 l9_134=l9_133;
float3x3 l9_135=l9_134;
l9_57.normal=((((l9_123*l9_57.normal)*l9_60.x)+((l9_127*l9_57.normal)*l9_60.y))+((l9_131*l9_57.normal)*l9_60.z))+((l9_135*l9_57.normal)*l9_60.w);
l9_57.tangent=((((l9_123*l9_57.tangent)*l9_60.x)+((l9_127*l9_57.tangent)*l9_60.y))+((l9_131*l9_57.tangent)*l9_60.z))+((l9_135*l9_57.tangent)*l9_60.w);
}
param_1=l9_57;
if (sc_RenderingSpace_tmp==3)
{
out.varPos=float3(0.0);
out.varNormal=param_1.normal;
out.varTangent=float4(param_1.tangent.x,param_1.tangent.y,param_1.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==4)
{
out.varPos=float3(0.0);
out.varNormal=param_1.normal;
out.varTangent=float4(param_1.tangent.x,param_1.tangent.y,param_1.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
out.varPos=param_1.position.xyz;
out.varNormal=param_1.normal;
out.varTangent=float4(param_1.tangent.x,param_1.tangent.y,param_1.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
out.varPos=((*sc_set2.UserUniforms).sc_ModelMatrix*param_1.position).xyz;
out.varNormal=(*sc_set2.UserUniforms).sc_NormalMatrix*param_1.normal;
float3 l9_136=(*sc_set2.UserUniforms).sc_NormalMatrix*param_1.tangent;
out.varTangent=float4(l9_136.x,l9_136.y,l9_136.z,out.varTangent.w);
}
}
}
}
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
param_1.texture0.x=1.0-param_1.texture0.x;
}
out.varColor=in.color;
sc_Vertex_t v=param_1;
float3 WorldPosition=out.varPos;
float3 WorldNormal=out.varNormal;
float3 WorldTangent=out.varTangent.xyz;
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
WorldPosition=out.varPos;
WorldNormal=out.varNormal;
WorldTangent=out.varTangent.xyz;
}
sc_Vertex_t param_2=v;
float3 param_3=WorldPosition;
float3 param_4=WorldNormal;
float3 param_5=WorldTangent;
float4 param_6=v.position;
out.varPos=param_3;
out.varNormal=normalize(param_4);
float3 l9_137=normalize(param_5);
out.varTangent=float4(l9_137.x,l9_137.y,l9_137.z,out.varTangent.w);
out.varTangent.w=in.tangent.w;
if ((int(UseViewSpaceDepthVariant_tmp)!=0)&&(((int(sc_OITDepthGatherPass_tmp)!=0)||(int(sc_OITCompositingPass_tmp)!=0))||(int(sc_OITDepthBoundsPass_tmp)!=0)))
{
float4 l9_138=param_2.position;
float4 l9_139=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
int l9_140=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_140=0;
}
else
{
l9_140=gl_InstanceIndex%2;
}
int l9_141=l9_140;
l9_139=(*sc_set2.UserUniforms).sc_ProjectionMatrixInverseArray[l9_141]*l9_138;
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_142=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_142=0;
}
else
{
l9_142=gl_InstanceIndex%2;
}
int l9_143=l9_142;
l9_139=(*sc_set2.UserUniforms).sc_ViewMatrixArray[l9_143]*l9_138;
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_144=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_144=0;
}
else
{
l9_144=gl_InstanceIndex%2;
}
int l9_145=l9_144;
l9_139=(*sc_set2.UserUniforms).sc_ModelViewMatrixArray[l9_145]*l9_138;
}
else
{
l9_139=l9_138;
}
}
}
float4 l9_146=l9_139;
out.varViewSpaceDepth=-l9_146.z;
}
float4 l9_147=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
l9_147=param_6;
}
else
{
if (sc_RenderingSpace_tmp==4)
{
int l9_148=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_148=0;
}
else
{
l9_148=gl_InstanceIndex%2;
}
int l9_149=l9_148;
l9_147=((*sc_set2.UserUniforms).sc_ModelViewMatrixArray[l9_149]*param_2.position)*float4(1.0/(*sc_set2.UserUniforms).sc_Camera.aspect,1.0,1.0,1.0);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_150=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_150=0;
}
else
{
l9_150=gl_InstanceIndex%2;
}
int l9_151=l9_150;
l9_147=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_151]*float4(out.varPos,1.0);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_152=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_152=0;
}
else
{
l9_152=gl_InstanceIndex%2;
}
int l9_153=l9_152;
l9_147=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_153]*float4(out.varPos,1.0);
}
}
}
}
out.varPackedTex=float4(param_2.texture0,param_2.texture1);
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float4 l9_154=param_2.position;
float4 l9_155=l9_154;
if (sc_RenderingSpace_tmp==1)
{
l9_155=(*sc_set2.UserUniforms).sc_ModelMatrix*l9_154;
}
float4 l9_156=(*sc_set2.UserUniforms).sc_ProjectorMatrix*l9_155;
float2 l9_157=((l9_156.xy/float2(l9_156.w))*0.5)+float2(0.5);
out.varShadowTex=l9_157;
}
float4 l9_158=l9_147;
if (sc_DepthBufferMode_tmp==1)
{
float l9_159=2.0/log2((*sc_set2.UserUniforms).sc_Camera.clipPlanes.y+1.0);
l9_158.z=((log2(fast::max((*sc_set2.UserUniforms).sc_Camera.clipPlanes.x,1.0+l9_158.w))*l9_159)-1.0)*l9_158.w;
}
float4 l9_160=l9_158;
l9_147=l9_160;
float4 l9_161=l9_147;
float4 l9_162=l9_161;
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_163=l9_162;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_164=dot(l9_163,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_165=l9_164;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_165;
}
}
float4 l9_166=float4(l9_162.x,-l9_162.y,(l9_162.z*0.5)+(l9_162.w*0.5),l9_162.w);
out.gl_Position=l9_166;
v=param_2;
if (PreviewInfo.Saved)
{
out.PreviewVertexColor=float4(PreviewInfo.Color.xyz,1.0);
out.PreviewVertexSaved=1.0;
}
return out;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct RayHitPayload
{
float3 viewDirWS;
float3 positionWS;
float3 normalWS;
float4 tangentWS;
float4 color;
float2 uv0;
float2 uv1;
float2 uv2;
float2 uv3;
uint2 id;
};
struct SurfaceProperties
{
float3 albedo;
float opacity;
float3 normal;
float3 positionWS;
float3 viewDirWS;
float metallic;
float roughness;
float3 emissive;
float3 ao;
float3 specularAo;
float3 bakedShadows;
float3 specColor;
};
struct LightingComponents
{
float3 directDiffuse;
float3 directSpecular;
float3 indirectDiffuse;
float3 indirectSpecular;
float3 emitted;
float3 transmitted;
};
struct LightProperties
{
float3 direction;
float3 color;
float attenuation;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float3 BumpedNormal;
float3 ViewDirWS;
float3 PositionWS;
float3 VertexTangent_WorldSpace;
float3 VertexNormal_WorldSpace;
float3 VertexBinormal_WorldSpace;
float2 Surface_UVCoord0;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[3];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
int receivesRayTracedReflections;
int isProxyMode;
int receivesRayTracedShadows;
int receivesRayTracedDiffuseIndirect;
int receivesRayTracedAo;
float4 sc_RayTracedReflectionTextureSize;
float4 sc_RayTracedReflectionTextureDims;
float4 sc_RayTracedReflectionTextureView;
float4 sc_RayTracedShadowTextureSize;
float4 sc_RayTracedShadowTextureDims;
float4 sc_RayTracedShadowTextureView;
float4 sc_RayTracedDiffIndTextureSize;
float4 sc_RayTracedDiffIndTextureDims;
float4 sc_RayTracedDiffIndTextureView;
float4 sc_RayTracedAoTextureSize;
float4 sc_RayTracedAoTextureDims;
float4 sc_RayTracedAoTextureView;
float receiver_mask;
float3 OriginNormalizationScale;
float3 OriginNormalizationScaleInv;
float3 OriginNormalizationOffset;
int receiverId;
int instance_id;
int lray_triangles_last;
int noEarlyZ;
int has_animated_pn;
int emitter_stride;
int proxy_offset_position;
int proxy_offset_normal;
int proxy_offset_tangent;
int proxy_offset_color;
int proxy_offset_texture0;
int proxy_offset_texture1;
int proxy_offset_texture2;
int proxy_offset_texture3;
int proxy_format_position;
int proxy_format_normal;
int proxy_format_tangent;
int proxy_format_color;
int proxy_format_texture0;
int proxy_format_texture1;
int proxy_format_texture2;
int proxy_format_texture3;
float4 z_rayDirectionsSize;
float4 z_rayDirectionsDims;
float4 z_rayDirectionsView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int PreviewEnabled;
int PreviewNodeID;
float alphaTestThreshold;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float uvScale;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float4 materialParamsTexSize;
float4 materialParamsTexDims;
float4 materialParamsTexView;
float3x3 materialParamsTexTransform;
float4 materialParamsTexUvMinMax;
float4 materialParamsTexBorderColor;
float2 Port_Center_N016;
float3 Port_Emissive_N006;
float3 Port_SpecularAO_N006;
float depthRef;
};
struct layoutVertices_obj
{
float _Vertices[1];
};
struct layoutVerticesPN_obj
{
float _VerticesPN[1];
};
struct layoutIndices_obj
{
uint _Triangles[1];
};
struct sc_PointLight_t_1
{
bool falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct ssPreviewInfo
{
float4 Color;
bool Saved;
};
struct sc_Bone_t
{
float4 boneMatrix[3];
float4 normalMatrix[3];
};
struct sc_Bones_obj
{
sc_Bone_t sc_Bones[1];
};
struct sc_Set2
{
const device layoutIndices_obj* layoutIndices [[id(0)]];
const device layoutVertices_obj* layoutVertices [[id(1)]];
const device layoutVerticesPN_obj* layoutVerticesPN [[id(2)]];
constant sc_Bones_obj* sc_BonesUBO [[id(3)]];
texture2d<float> baseTex [[id(4)]];
texture2d<float> intensityTexture [[id(5)]];
texture2d<float> materialParamsTex [[id(6)]];
texture2d<float> normalTex [[id(7)]];
texture2d<float> sc_EnvmapDiffuse [[id(8)]];
texture2d<float> sc_EnvmapSpecular [[id(9)]];
texture2d<float> sc_RayTracedAoTexture [[id(18)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(19)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(20)]];
texture2d<float> sc_RayTracedShadowTexture [[id(21)]];
texture2d<float> sc_SSAOTexture [[id(22)]];
texture2d<float> sc_ScreenTexture [[id(23)]];
texture2d<float> sc_ShadowTexture [[id(24)]];
texture2d<uint> z_hitIdAndBarycentric [[id(26)]];
texture2d<float> z_rayDirections [[id(27)]];
sampler baseTexSmpSC [[id(28)]];
sampler intensityTextureSmpSC [[id(29)]];
sampler materialParamsTexSmpSC [[id(30)]];
sampler normalTexSmpSC [[id(31)]];
sampler sc_EnvmapDiffuseSmpSC [[id(32)]];
sampler sc_EnvmapSpecularSmpSC [[id(33)]];
sampler sc_RayTracedAoTextureSmpSC [[id(35)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(36)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(37)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(38)]];
sampler sc_SSAOTextureSmpSC [[id(39)]];
sampler sc_ScreenTextureSmpSC [[id(40)]];
sampler sc_ShadowTextureSmpSC [[id(41)]];
sampler z_hitIdAndBarycentricSmp [[id(43)]];
sampler z_rayDirectionsSmpSC [[id(44)]];
constant userUniformsObj* UserUniforms [[id(45)]];
};
struct main_frag_out
{
float4 FragColor0 [[color(0)]];
float4 FragColor1 [[color(1)]];
float4 FragColor2 [[color(2)]];
float4 FragColor3 [[color(3)]];
};
struct main_frag_in
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float varViewSpaceDepth [[user(locn6)]];
float2 varShadowTex [[user(locn7)]];
int varStereoViewID [[user(locn8)]];
float varClipDistance [[user(locn9)]];
float4 varColor [[user(locn10)]];
float4 PreviewVertexColor [[user(locn11)]];
float PreviewVertexSaved [[user(locn12)]];
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
RayHitPayload GetHitData(thread const int2& screenPos,constant userUniformsObj& UserUniforms,thread texture2d<float> z_rayDirections,thread sampler z_rayDirectionsSmpSC,thread texture2d<uint> z_hitIdAndBarycentric,thread sampler z_hitIdAndBarycentricSmp,const device layoutVertices_obj& layoutVertices,const device layoutVerticesPN_obj& layoutVerticesPN,const device layoutIndices_obj& layoutIndices)
{
int2 param=screenPos;
uint4 l9_0=z_hitIdAndBarycentric.read(uint2(param),0);
uint4 id_and_barycentric=l9_0;
RayHitPayload rhp;
rhp.id=id_and_barycentric.xy;
if (rhp.id.x!=uint(UserUniforms.instance_id))
{
return rhp;
}
float2 brc_vw=float2(as_type<half2>(id_and_barycentric.z|(id_and_barycentric.w<<uint(16))));
float3 brc=float3((1.0-brc_vw.x)-brc_vw.y,brc_vw);
float2 param_1=z_rayDirections.read(uint2(screenPos),0).xy;
float3 l9_1=float3(param_1.x,param_1.y,(1.0-abs(param_1.x))-abs(param_1.y));
float l9_2=fast::clamp(-l9_1.z,0.0,1.0);
float l9_3;
if (l9_1.x>=0.0)
{
l9_3=-l9_2;
}
else
{
l9_3=l9_2;
}
float l9_4=l9_3;
float l9_5;
if (l9_1.y>=0.0)
{
l9_5=-l9_2;
}
else
{
l9_5=l9_2;
}
float2 l9_6=l9_1.xy+float2(l9_4,l9_5);
l9_1=float3(l9_6.x,l9_6.y,l9_1.z);
float3 l9_7=normalize(l9_1);
float3 rayDir=l9_7;
rhp.viewDirWS=-rayDir;
uint param_2=rhp.id.y;
uint l9_8=min(param_2,uint(UserUniforms.lray_triangles_last));
uint l9_9=l9_8*6u;
uint l9_10=l9_9&4294967292u;
uint4 l9_11=(uint4(uint2(layoutIndices._Triangles[l9_10/4u]),uint2(layoutIndices._Triangles[(l9_10/4u)+1u]))&uint4(65535u,4294967295u,65535u,4294967295u))>>uint4(0u,16u,0u,16u);
int3 l9_12;
if (l9_9==l9_10)
{
l9_12=int3(l9_11.xyz);
}
else
{
l9_12=int3(l9_11.yzw);
}
int3 l9_13=l9_12;
int3 i=l9_13;
if (UserUniforms.has_animated_pn!=0)
{
float3 param_3=brc;
int3 param_4=i;
int param_5=0;
int3 l9_14=(param_4*int3(6))+int3(param_5);
int l9_15=l9_14.x;
float3 l9_16=float3(layoutVerticesPN._VerticesPN[l9_15],layoutVerticesPN._VerticesPN[l9_15+1],layoutVerticesPN._VerticesPN[l9_15+2]);
int l9_17=l9_14.y;
float3 l9_18=float3(layoutVerticesPN._VerticesPN[l9_17],layoutVerticesPN._VerticesPN[l9_17+1],layoutVerticesPN._VerticesPN[l9_17+2]);
int l9_19=l9_14.z;
float3 l9_20=float3(layoutVerticesPN._VerticesPN[l9_19],layoutVerticesPN._VerticesPN[l9_19+1],layoutVerticesPN._VerticesPN[l9_19+2]);
float3 l9_21=((l9_16*param_3.x)+(l9_18*param_3.y))+(l9_20*param_3.z);
rhp.positionWS=l9_21;
}
else
{
float3 param_6=brc;
int3 param_7=i;
int3 l9_22=int3((param_7.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_position,(param_7.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_position,(param_7.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_position);
float3 l9_23=float3(0.0);
if (UserUniforms.proxy_format_position==5)
{
int l9_24=l9_22.x;
float3 l9_25=float3(layoutVertices._Vertices[l9_24],layoutVertices._Vertices[l9_24+1],layoutVertices._Vertices[l9_24+2]);
int l9_26=l9_22.y;
float3 l9_27=float3(layoutVertices._Vertices[l9_26],layoutVertices._Vertices[l9_26+1],layoutVertices._Vertices[l9_26+2]);
int l9_28=l9_22.z;
float3 l9_29=float3(layoutVertices._Vertices[l9_28],layoutVertices._Vertices[l9_28+1],layoutVertices._Vertices[l9_28+2]);
l9_23=((l9_25*param_6.x)+(l9_27*param_6.y))+(l9_29*param_6.z);
}
else
{
if (UserUniforms.proxy_format_position==6)
{
int l9_30=l9_22.x;
float3 l9_31=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_30]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_30+1]))).x);
int l9_32=l9_22.y;
float3 l9_33=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_32]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_32+1]))).x);
int l9_34=l9_22.z;
float3 l9_35=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_34]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_34+1]))).x);
l9_23=((l9_31*param_6.x)+(l9_33*param_6.y))+(l9_35*param_6.z);
}
else
{
l9_23=float3(1.0,0.0,0.0);
}
}
float3 l9_36=l9_23;
float3 positionOS=l9_36;
rhp.positionWS=(UserUniforms.sc_ModelMatrix*float4(positionOS,1.0)).xyz;
}
if (UserUniforms.proxy_offset_normal>0)
{
if (UserUniforms.has_animated_pn!=0)
{
float3 param_8=brc;
int3 param_9=i;
int param_10=3;
int3 l9_37=(param_9*int3(6))+int3(param_10);
int l9_38=l9_37.x;
float3 l9_39=float3(layoutVerticesPN._VerticesPN[l9_38],layoutVerticesPN._VerticesPN[l9_38+1],layoutVerticesPN._VerticesPN[l9_38+2]);
int l9_40=l9_37.y;
float3 l9_41=float3(layoutVerticesPN._VerticesPN[l9_40],layoutVerticesPN._VerticesPN[l9_40+1],layoutVerticesPN._VerticesPN[l9_40+2]);
int l9_42=l9_37.z;
float3 l9_43=float3(layoutVerticesPN._VerticesPN[l9_42],layoutVerticesPN._VerticesPN[l9_42+1],layoutVerticesPN._VerticesPN[l9_42+2]);
float3 l9_44=((l9_39*param_8.x)+(l9_41*param_8.y))+(l9_43*param_8.z);
rhp.normalWS=l9_44;
}
else
{
float3 param_11=brc;
int3 param_12=i;
int3 l9_45=int3((param_12.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_normal,(param_12.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_normal,(param_12.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_normal);
float3 l9_46=float3(0.0);
if (UserUniforms.proxy_format_normal==5)
{
int l9_47=l9_45.x;
float3 l9_48=float3(layoutVertices._Vertices[l9_47],layoutVertices._Vertices[l9_47+1],layoutVertices._Vertices[l9_47+2]);
int l9_49=l9_45.y;
float3 l9_50=float3(layoutVertices._Vertices[l9_49],layoutVertices._Vertices[l9_49+1],layoutVertices._Vertices[l9_49+2]);
int l9_51=l9_45.z;
float3 l9_52=float3(layoutVertices._Vertices[l9_51],layoutVertices._Vertices[l9_51+1],layoutVertices._Vertices[l9_51+2]);
l9_46=((l9_48*param_11.x)+(l9_50*param_11.y))+(l9_52*param_11.z);
}
else
{
if (UserUniforms.proxy_format_normal==6)
{
int l9_53=l9_45.x;
float3 l9_54=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_53]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_53+1]))).x);
int l9_55=l9_45.y;
float3 l9_56=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_55]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_55+1]))).x);
int l9_57=l9_45.z;
float3 l9_58=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_57]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_57+1]))).x);
l9_46=((l9_54*param_11.x)+(l9_56*param_11.y))+(l9_58*param_11.z);
}
else
{
l9_46=float3(1.0,0.0,0.0);
}
}
float3 l9_59=l9_46;
float3 normalOS=l9_59;
rhp.normalWS=normalize(UserUniforms.sc_NormalMatrix*normalOS);
}
}
else
{
rhp.normalWS=float3(1.0,0.0,0.0);
}
bool l9_60=!(UserUniforms.has_animated_pn!=0);
bool l9_61;
if (l9_60)
{
l9_61=UserUniforms.proxy_offset_tangent>0;
}
else
{
l9_61=l9_60;
}
if (l9_61)
{
float3 param_13=brc;
int3 param_14=i;
int3 l9_62=int3((param_14.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_tangent,(param_14.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_tangent,(param_14.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_tangent);
float4 l9_63=float4(0.0);
if (UserUniforms.proxy_format_tangent==5)
{
int l9_64=l9_62.x;
float4 l9_65=float4(layoutVertices._Vertices[l9_64],layoutVertices._Vertices[l9_64+1],layoutVertices._Vertices[l9_64+2],layoutVertices._Vertices[l9_64+3]);
int l9_66=l9_62.y;
float4 l9_67=float4(layoutVertices._Vertices[l9_66],layoutVertices._Vertices[l9_66+1],layoutVertices._Vertices[l9_66+2],layoutVertices._Vertices[l9_66+3]);
int l9_68=l9_62.z;
float4 l9_69=float4(layoutVertices._Vertices[l9_68],layoutVertices._Vertices[l9_68+1],layoutVertices._Vertices[l9_68+2],layoutVertices._Vertices[l9_68+3]);
l9_63=((l9_65*param_13.x)+(l9_67*param_13.y))+(l9_69*param_13.z);
}
else
{
if (UserUniforms.proxy_format_tangent==6)
{
int l9_70=l9_62.x;
float4 l9_71=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_70]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_70+1]))));
int l9_72=l9_62.y;
float4 l9_73=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_72]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_72+1]))));
int l9_74=l9_62.z;
float4 l9_75=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_74]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_74+1]))));
l9_63=((l9_71*param_13.x)+(l9_73*param_13.y))+(l9_75*param_13.z);
}
else
{
if (UserUniforms.proxy_format_tangent==2)
{
int l9_76=l9_62.x;
uint l9_77=as_type<uint>(layoutVertices._Vertices[l9_76]);
uint l9_78=l9_77&255u;
uint l9_79=(l9_77>>uint(8))&255u;
uint l9_80=(l9_77>>uint(16))&255u;
uint l9_81=(l9_77>>uint(24))&255u;
float4 l9_82=float4(float(l9_78),float(l9_79),float(l9_80),float(l9_81))/float4(255.0);
int l9_83=l9_62.y;
uint l9_84=as_type<uint>(layoutVertices._Vertices[l9_83]);
uint l9_85=l9_84&255u;
uint l9_86=(l9_84>>uint(8))&255u;
uint l9_87=(l9_84>>uint(16))&255u;
uint l9_88=(l9_84>>uint(24))&255u;
float4 l9_89=float4(float(l9_85),float(l9_86),float(l9_87),float(l9_88))/float4(255.0);
int l9_90=l9_62.z;
uint l9_91=as_type<uint>(layoutVertices._Vertices[l9_90]);
uint l9_92=l9_91&255u;
uint l9_93=(l9_91>>uint(8))&255u;
uint l9_94=(l9_91>>uint(16))&255u;
uint l9_95=(l9_91>>uint(24))&255u;
float4 l9_96=float4(float(l9_92),float(l9_93),float(l9_94),float(l9_95))/float4(255.0);
l9_63=((l9_82*param_13.x)+(l9_89*param_13.y))+(l9_96*param_13.z);
}
else
{
l9_63=float4(1.0,0.0,0.0,0.0);
}
}
}
float4 l9_97=l9_63;
float4 tangentOS=l9_97;
float3 tangentWS=normalize(UserUniforms.sc_NormalMatrix*tangentOS.xyz);
rhp.tangentWS=float4(tangentWS,tangentOS.w);
}
else
{
rhp.tangentWS=float4(1.0,0.0,0.0,1.0);
}
if (UserUniforms.proxy_format_color>0)
{
float3 param_15=brc;
int3 param_16=i;
int3 l9_98=int3((param_16.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_color,(param_16.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_color,(param_16.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_color);
float4 l9_99=float4(0.0);
if (UserUniforms.proxy_format_color==5)
{
int l9_100=l9_98.x;
float4 l9_101=float4(layoutVertices._Vertices[l9_100],layoutVertices._Vertices[l9_100+1],layoutVertices._Vertices[l9_100+2],layoutVertices._Vertices[l9_100+3]);
int l9_102=l9_98.y;
float4 l9_103=float4(layoutVertices._Vertices[l9_102],layoutVertices._Vertices[l9_102+1],layoutVertices._Vertices[l9_102+2],layoutVertices._Vertices[l9_102+3]);
int l9_104=l9_98.z;
float4 l9_105=float4(layoutVertices._Vertices[l9_104],layoutVertices._Vertices[l9_104+1],layoutVertices._Vertices[l9_104+2],layoutVertices._Vertices[l9_104+3]);
l9_99=((l9_101*param_15.x)+(l9_103*param_15.y))+(l9_105*param_15.z);
}
else
{
if (UserUniforms.proxy_format_color==6)
{
int l9_106=l9_98.x;
float4 l9_107=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_106]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_106+1]))));
int l9_108=l9_98.y;
float4 l9_109=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_108]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_108+1]))));
int l9_110=l9_98.z;
float4 l9_111=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_110]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_110+1]))));
l9_99=((l9_107*param_15.x)+(l9_109*param_15.y))+(l9_111*param_15.z);
}
else
{
if (UserUniforms.proxy_format_color==2)
{
int l9_112=l9_98.x;
uint l9_113=as_type<uint>(layoutVertices._Vertices[l9_112]);
uint l9_114=l9_113&255u;
uint l9_115=(l9_113>>uint(8))&255u;
uint l9_116=(l9_113>>uint(16))&255u;
uint l9_117=(l9_113>>uint(24))&255u;
float4 l9_118=float4(float(l9_114),float(l9_115),float(l9_116),float(l9_117))/float4(255.0);
int l9_119=l9_98.y;
uint l9_120=as_type<uint>(layoutVertices._Vertices[l9_119]);
uint l9_121=l9_120&255u;
uint l9_122=(l9_120>>uint(8))&255u;
uint l9_123=(l9_120>>uint(16))&255u;
uint l9_124=(l9_120>>uint(24))&255u;
float4 l9_125=float4(float(l9_121),float(l9_122),float(l9_123),float(l9_124))/float4(255.0);
int l9_126=l9_98.z;
uint l9_127=as_type<uint>(layoutVertices._Vertices[l9_126]);
uint l9_128=l9_127&255u;
uint l9_129=(l9_127>>uint(8))&255u;
uint l9_130=(l9_127>>uint(16))&255u;
uint l9_131=(l9_127>>uint(24))&255u;
float4 l9_132=float4(float(l9_128),float(l9_129),float(l9_130),float(l9_131))/float4(255.0);
l9_99=((l9_118*param_15.x)+(l9_125*param_15.y))+(l9_132*param_15.z);
}
else
{
l9_99=float4(1.0,0.0,0.0,0.0);
}
}
}
float4 l9_133=l9_99;
rhp.color=l9_133;
}
float2 dummy_red_black=float2(dot(brc,float3(int3(1)-(i%int3(2)))),0.0);
if (UserUniforms.proxy_format_texture0>0)
{
float3 param_17=brc;
int3 param_18=i;
int3 l9_134=int3((param_18.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture0,(param_18.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture0,(param_18.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture0);
float2 l9_135=float2(0.0);
if (UserUniforms.proxy_format_texture0==5)
{
int l9_136=l9_134.x;
float2 l9_137=float2(layoutVertices._Vertices[l9_136],layoutVertices._Vertices[l9_136+1]);
int l9_138=l9_134.y;
float2 l9_139=float2(layoutVertices._Vertices[l9_138],layoutVertices._Vertices[l9_138+1]);
int l9_140=l9_134.z;
float2 l9_141=float2(layoutVertices._Vertices[l9_140],layoutVertices._Vertices[l9_140+1]);
l9_135=((l9_137*param_17.x)+(l9_139*param_17.y))+(l9_141*param_17.z);
}
else
{
if (UserUniforms.proxy_format_texture0==6)
{
int l9_142=l9_134.x;
float2 l9_143=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_142])));
int l9_144=l9_134.y;
float2 l9_145=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_144])));
int l9_146=l9_134.z;
float2 l9_147=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_146])));
l9_135=((l9_143*param_17.x)+(l9_145*param_17.y))+(l9_147*param_17.z);
}
else
{
l9_135=float2(1.0,0.0);
}
}
float2 l9_148=l9_135;
rhp.uv0=l9_148;
}
else
{
rhp.uv0=dummy_red_black;
}
if (UserUniforms.proxy_format_texture1>0)
{
float3 param_19=brc;
int3 param_20=i;
int3 l9_149=int3((param_20.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture1,(param_20.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture1,(param_20.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture1);
float2 l9_150=float2(0.0);
if (UserUniforms.proxy_format_texture1==5)
{
int l9_151=l9_149.x;
float2 l9_152=float2(layoutVertices._Vertices[l9_151],layoutVertices._Vertices[l9_151+1]);
int l9_153=l9_149.y;
float2 l9_154=float2(layoutVertices._Vertices[l9_153],layoutVertices._Vertices[l9_153+1]);
int l9_155=l9_149.z;
float2 l9_156=float2(layoutVertices._Vertices[l9_155],layoutVertices._Vertices[l9_155+1]);
l9_150=((l9_152*param_19.x)+(l9_154*param_19.y))+(l9_156*param_19.z);
}
else
{
if (UserUniforms.proxy_format_texture1==6)
{
int l9_157=l9_149.x;
float2 l9_158=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_157])));
int l9_159=l9_149.y;
float2 l9_160=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_159])));
int l9_161=l9_149.z;
float2 l9_162=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_161])));
l9_150=((l9_158*param_19.x)+(l9_160*param_19.y))+(l9_162*param_19.z);
}
else
{
l9_150=float2(1.0,0.0);
}
}
float2 l9_163=l9_150;
rhp.uv1=l9_163;
}
else
{
rhp.uv1=dummy_red_black;
}
if (UserUniforms.proxy_format_texture2>0)
{
float3 param_21=brc;
int3 param_22=i;
int3 l9_164=int3((param_22.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture2,(param_22.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture2,(param_22.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture2);
float2 l9_165=float2(0.0);
if (UserUniforms.proxy_format_texture2==5)
{
int l9_166=l9_164.x;
float2 l9_167=float2(layoutVertices._Vertices[l9_166],layoutVertices._Vertices[l9_166+1]);
int l9_168=l9_164.y;
float2 l9_169=float2(layoutVertices._Vertices[l9_168],layoutVertices._Vertices[l9_168+1]);
int l9_170=l9_164.z;
float2 l9_171=float2(layoutVertices._Vertices[l9_170],layoutVertices._Vertices[l9_170+1]);
l9_165=((l9_167*param_21.x)+(l9_169*param_21.y))+(l9_171*param_21.z);
}
else
{
if (UserUniforms.proxy_format_texture2==6)
{
int l9_172=l9_164.x;
float2 l9_173=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_172])));
int l9_174=l9_164.y;
float2 l9_175=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_174])));
int l9_176=l9_164.z;
float2 l9_177=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_176])));
l9_165=((l9_173*param_21.x)+(l9_175*param_21.y))+(l9_177*param_21.z);
}
else
{
l9_165=float2(1.0,0.0);
}
}
float2 l9_178=l9_165;
rhp.uv2=l9_178;
}
else
{
rhp.uv2=dummy_red_black;
}
if (UserUniforms.proxy_format_texture3>0)
{
float3 param_23=brc;
int3 param_24=i;
int3 l9_179=int3((param_24.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture3,(param_24.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture3,(param_24.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture3);
float2 l9_180=float2(0.0);
if (UserUniforms.proxy_format_texture3==5)
{
int l9_181=l9_179.x;
float2 l9_182=float2(layoutVertices._Vertices[l9_181],layoutVertices._Vertices[l9_181+1]);
int l9_183=l9_179.y;
float2 l9_184=float2(layoutVertices._Vertices[l9_183],layoutVertices._Vertices[l9_183+1]);
int l9_185=l9_179.z;
float2 l9_186=float2(layoutVertices._Vertices[l9_185],layoutVertices._Vertices[l9_185+1]);
l9_180=((l9_182*param_23.x)+(l9_184*param_23.y))+(l9_186*param_23.z);
}
else
{
if (UserUniforms.proxy_format_texture3==6)
{
int l9_187=l9_179.x;
float2 l9_188=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_187])));
int l9_189=l9_179.y;
float2 l9_190=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_189])));
int l9_191=l9_179.z;
float2 l9_192=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_191])));
l9_180=((l9_188*param_23.x)+(l9_190*param_23.y))+(l9_192*param_23.z);
}
else
{
l9_180=float2(1.0,0.0);
}
}
float2 l9_193=l9_180;
rhp.uv3=l9_193;
}
else
{
rhp.uv3=dummy_red_black;
}
return rhp;
}
float3 evaluateSSAO(thread const float3& positionWS,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_SSAOTexture,thread sampler sc_SSAOTextureSmpSC)
{
if ((int(sc_SSAOEnabled_tmp)!=0))
{
int l9_0=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_0=0;
}
else
{
l9_0=varStereoViewID;
}
int l9_1=l9_0;
float4 clipSpaceCoord=UserUniforms.sc_ViewProjectionMatrixArray[l9_1]*float4(positionWS,1.0);
float3 l9_2=clipSpaceCoord.xyz/float3(clipSpaceCoord.w);
clipSpaceCoord=float4(l9_2.x,l9_2.y,l9_2.z,clipSpaceCoord.w);
float4 shadowSample=sc_SSAOTexture.sample(sc_SSAOTextureSmpSC,((clipSpaceCoord.xy*0.5)+float2(0.5)));
return float3(shadowSample.x);
}
else
{
return float3(1.0);
}
}
float3 calculateDirectSpecular(thread const SurfaceProperties& surfaceProperties,thread const float3& L,thread const float3& V,constant userUniformsObj& UserUniforms)
{
float r=fast::max(surfaceProperties.roughness,0.029999999);
float3 F0=surfaceProperties.specColor;
float3 N=surfaceProperties.normal;
float3 H=normalize(L+V);
float param=dot(N,L);
float l9_0=fast::clamp(param,0.0,1.0);
float NdotL=l9_0;
float param_1=dot(N,V);
float l9_1=fast::clamp(param_1,0.0,1.0);
float NdotV=l9_1;
float param_2=dot(N,H);
float l9_2=fast::clamp(param_2,0.0,1.0);
float NdotH=l9_2;
float param_3=dot(V,H);
float l9_3=fast::clamp(param_3,0.0,1.0);
float VdotH=l9_3;
if (SC_DEVICE_CLASS_tmp>=2)
{
float param_4=NdotH;
float param_5=r;
float l9_4=param_5*param_5;
float l9_5=l9_4*l9_4;
float l9_6=param_4*param_4;
float l9_7=(l9_6*(l9_5-1.0))+1.0;
float l9_8=l9_7*l9_7;
float l9_9=9.9999999e-09;
bool l9_10=UserUniforms.isProxyMode!=0;
if (l9_10)
{
l9_9=1e-07;
}
float l9_11=l9_5/(l9_8+l9_9);
float param_6=NdotL;
float param_7=NdotV;
float param_8=r;
float l9_12=param_6;
float l9_13=param_8;
float l9_14=l9_13+1.0;
l9_14=(l9_14*l9_14)*0.125;
float l9_15=(l9_12*(1.0-l9_14))+l9_14;
float l9_16=param_7;
float l9_17=param_8;
float l9_18=l9_17+1.0;
l9_18=(l9_18*l9_18)*0.125;
float l9_19=(l9_16*(1.0-l9_18))+l9_18;
float l9_20=1.0/(l9_15*l9_19);
float param_9=VdotH;
float3 param_10=F0;
float l9_21=param_9;
float3 l9_22=param_10;
float3 l9_23=float3(1.0);
float l9_24=1.0-l9_21;
float l9_25=l9_24*l9_24;
float l9_26=(l9_25*l9_25)*l9_24;
float3 l9_27=l9_22+((l9_23-l9_22)*l9_26);
float3 l9_28=l9_27;
return l9_28*(((l9_11*l9_20)*0.25)*NdotL);
}
else
{
float specPower=exp2(11.0-(10.0*r));
float param_11=VdotH;
float3 param_12=F0;
float l9_29=param_11;
float3 l9_30=param_12;
float3 l9_31=float3(1.0);
float l9_32=1.0-l9_29;
float l9_33=l9_32*l9_32;
float l9_34=(l9_33*l9_33)*l9_32;
float3 l9_35=l9_30+((l9_31-l9_30)*l9_34);
float3 l9_36=l9_35;
return ((l9_36*((specPower*0.125)+0.25))*pow(NdotH,specPower))*NdotL;
}
}
float computeDistanceAttenuation(thread const float& distanceToLight,thread const float& falloffEndDistance)
{
float distanceToLightSquared=distanceToLight*distanceToLight;
if (falloffEndDistance==0.0)
{
return 1.0/distanceToLightSquared;
}
float distanceToLightToTheFourth=distanceToLightSquared*distanceToLightSquared;
float falloffEndDistanceToTheFourth=pow(falloffEndDistance,4.0);
return fast::max(fast::min(1.0-(distanceToLightToTheFourth/falloffEndDistanceToTheFourth),1.0),0.0)/distanceToLightSquared;
}
float2 calcSeamlessPanoramicUvsForSampling(thread const float2& uv,thread const float2& topMipRes,thread const float& lod)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float2 thisMipRes=fast::max(float2(1.0),topMipRes/float2(exp2(lod)));
return ((uv*(thisMipRes-float2(1.0)))/thisMipRes)+(float2(0.5)/thisMipRes);
}
else
{
return uv;
}
}
float4 sampleRayTracedIndirectDiffuse(thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_RayTracedDiffIndTexture,thread sampler sc_RayTracedDiffIndTextureSmpSC,thread float4& gl_FragCoord)
{
bool l9_0=UserUniforms.receivesRayTracedDiffuseIndirect!=0;
if (l9_0)
{
float4 l9_1=gl_FragCoord;
float2 l9_2=(l9_1.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 p=l9_2;
float2 param=p;
int l9_3=0;
if ((int(sc_RayTracedDiffIndTextureHasSwappedViews_tmp)!=0))
{
int l9_4=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4=0;
}
else
{
l9_4=varStereoViewID;
}
int l9_5=l9_4;
l9_3=1-l9_5;
}
else
{
int l9_6=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_6=0;
}
else
{
l9_6=varStereoViewID;
}
int l9_7=l9_6;
l9_3=l9_7;
}
int l9_8=l9_3;
float2 l9_9=param;
int l9_10=l9_8;
float2 l9_11=l9_9;
int l9_12=l9_10;
float l9_13=0.0;
float4 l9_14=float4(0.0);
float2 l9_15=l9_11;
int l9_16=sc_RayTracedDiffIndTextureLayout_tmp;
int l9_17=l9_12;
float l9_18=l9_13;
float2 l9_19=l9_15;
int l9_20=l9_16;
int l9_21=l9_17;
float3 l9_22=float3(0.0);
if (l9_20==0)
{
l9_22=float3(l9_19,0.0);
}
else
{
if (l9_20==1)
{
l9_22=float3(l9_19.x,(l9_19.y*0.5)+(0.5-(float(l9_21)*0.5)),0.0);
}
else
{
l9_22=float3(l9_19,float(l9_21));
}
}
float3 l9_23=l9_22;
float3 l9_24=l9_23;
float2 l9_25=l9_24.xy;
float l9_26=l9_18;
float4 l9_27=sc_RayTracedDiffIndTexture.sample(sc_RayTracedDiffIndTextureSmpSC,l9_25,bias(l9_26));
float4 l9_28=l9_27;
l9_14=l9_28;
float4 l9_29=l9_14;
float4 l9_30=l9_29;
float4 l9_31=l9_30;
return l9_31;
}
return float4(0.0);
}
float3 getSpecularDominantDir(thread const float3& N,thread const float3& R,thread const float& roughness)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float lerpFactor=(roughness*roughness)*roughness;
return normalize(mix(R,N,float3(lerpFactor)));
}
else
{
return R;
}
}
float4 sampleRayTracedReflections(thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_RayTracedReflectionTexture,thread sampler sc_RayTracedReflectionTextureSmpSC,thread float4& gl_FragCoord)
{
bool l9_0=UserUniforms.receivesRayTracedReflections!=0;
if (!l9_0)
{
return float4(0.0);
}
else
{
float4 l9_1=gl_FragCoord;
float2 l9_2=(l9_1.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 p=l9_2;
float2 param=p;
int l9_3=0;
if ((int(sc_RayTracedReflectionTextureHasSwappedViews_tmp)!=0))
{
int l9_4=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4=0;
}
else
{
l9_4=varStereoViewID;
}
int l9_5=l9_4;
l9_3=1-l9_5;
}
else
{
int l9_6=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_6=0;
}
else
{
l9_6=varStereoViewID;
}
int l9_7=l9_6;
l9_3=l9_7;
}
int l9_8=l9_3;
float2 l9_9=param;
int l9_10=l9_8;
float2 l9_11=l9_9;
int l9_12=l9_10;
float l9_13=0.0;
float4 l9_14=float4(0.0);
float2 l9_15=l9_11;
int l9_16=sc_RayTracedReflectionTextureLayout_tmp;
int l9_17=l9_12;
float l9_18=l9_13;
float2 l9_19=l9_15;
int l9_20=l9_16;
int l9_21=l9_17;
float3 l9_22=float3(0.0);
if (l9_20==0)
{
l9_22=float3(l9_19,0.0);
}
else
{
if (l9_20==1)
{
l9_22=float3(l9_19.x,(l9_19.y*0.5)+(0.5-(float(l9_21)*0.5)),0.0);
}
else
{
l9_22=float3(l9_19,float(l9_21));
}
}
float3 l9_23=l9_22;
float3 l9_24=l9_23;
float2 l9_25=l9_24.xy;
float l9_26=l9_18;
float4 l9_27=sc_RayTracedReflectionTexture.sample(sc_RayTracedReflectionTextureSmpSC,l9_25,bias(l9_26));
float4 l9_28=l9_27;
l9_14=l9_28;
float4 l9_29=l9_14;
float4 l9_30=l9_29;
float4 l9_31=l9_30;
return l9_31;
}
}
float3 envBRDFApprox(thread const SurfaceProperties& surfaceProperties,thread const float& NdotV)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float4 r=(float4(-1.0,-0.0275,-0.57200003,0.022)*surfaceProperties.roughness)+float4(1.0,0.0425,1.04,-0.039999999);
float a004=(fast::min(r.x*r.x,exp2((-9.2799997)*NdotV))*r.x)+r.y;
float2 AB=(float2(-1.04,1.04)*a004)+r.zw;
return fast::max((surfaceProperties.specColor*AB.x)+float3(AB.y),float3(0.0));
}
else
{
float3 fresnelMax=fast::max(float3(1.0-surfaceProperties.roughness),surfaceProperties.specColor);
float param=NdotV;
float3 param_1=surfaceProperties.specColor;
float3 param_2=fresnelMax;
float l9_0=1.0-param;
float l9_1=l9_0*l9_0;
float l9_2=(l9_1*l9_1)*l9_0;
float3 l9_3=param_1+((param_2-param_1)*l9_2);
return l9_3;
}
}
float sampleRayTracedAo(thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_RayTracedAoTexture,thread sampler sc_RayTracedAoTextureSmpSC,thread float4& gl_FragCoord)
{
bool l9_0=UserUniforms.receivesRayTracedAo!=0;
if (l9_0)
{
float4 l9_1=gl_FragCoord;
float2 l9_2=(l9_1.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 p=l9_2;
float2 param=p;
int l9_3=0;
if ((int(sc_RayTracedAoTextureHasSwappedViews_tmp)!=0))
{
int l9_4=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4=0;
}
else
{
l9_4=varStereoViewID;
}
int l9_5=l9_4;
l9_3=1-l9_5;
}
else
{
int l9_6=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_6=0;
}
else
{
l9_6=varStereoViewID;
}
int l9_7=l9_6;
l9_3=l9_7;
}
int l9_8=l9_3;
float2 l9_9=param;
int l9_10=l9_8;
float2 l9_11=l9_9;
int l9_12=l9_10;
float l9_13=0.0;
float4 l9_14=float4(0.0);
float2 l9_15=l9_11;
int l9_16=sc_RayTracedAoTextureLayout_tmp;
int l9_17=l9_12;
float l9_18=l9_13;
float2 l9_19=l9_15;
int l9_20=l9_16;
int l9_21=l9_17;
float3 l9_22=float3(0.0);
if (l9_20==0)
{
l9_22=float3(l9_19,0.0);
}
else
{
if (l9_20==1)
{
l9_22=float3(l9_19.x,(l9_19.y*0.5)+(0.5-(float(l9_21)*0.5)),0.0);
}
else
{
l9_22=float3(l9_19,float(l9_21));
}
}
float3 l9_23=l9_22;
float3 l9_24=l9_23;
float2 l9_25=l9_24.xy;
float l9_26=l9_18;
float4 l9_27=sc_RayTracedAoTexture.sample(sc_RayTracedAoTextureSmpSC,l9_25,bias(l9_26));
float4 l9_28=l9_27;
l9_14=l9_28;
float4 l9_29=l9_14;
float4 l9_30=l9_29;
float4 l9_31=l9_30;
return l9_31.x;
}
return 0.0;
}
float srgbToLinear(thread const float& x)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
return pow(x,2.2);
}
else
{
return x*x;
}
}
float linearToSrgb(thread const float& x)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
return pow(x,0.45454547);
}
else
{
return sqrt(x);
}
}
float4 ngsCalculateLighting(thread const float3& albedo,thread const float& opacity,thread const float3& normal,thread const float3& position,thread const float3& viewDir,thread const float3& emissive,thread const float& metallic,thread const float& roughness,thread const float3& ao,thread const float3& specularAO,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_EnvmapDiffuse,thread sampler sc_EnvmapDiffuseSmpSC,thread texture2d<float> sc_EnvmapSpecular,thread sampler sc_EnvmapSpecularSmpSC,thread texture2d<float> sc_ScreenTexture,thread sampler sc_ScreenTextureSmpSC,thread texture2d<float> sc_ShadowTexture,thread sampler sc_ShadowTextureSmpSC,thread texture2d<float> sc_SSAOTexture,thread sampler sc_SSAOTextureSmpSC,thread texture2d<float> sc_RayTracedReflectionTexture,thread sampler sc_RayTracedReflectionTextureSmpSC,thread texture2d<float> sc_RayTracedShadowTexture,thread sampler sc_RayTracedShadowTextureSmpSC,thread texture2d<float> sc_RayTracedDiffIndTexture,thread sampler sc_RayTracedDiffIndTextureSmpSC,thread texture2d<float> sc_RayTracedAoTexture,thread sampler sc_RayTracedAoTextureSmpSC,thread float4& gl_FragCoord,thread float2& varShadowTex,thread float4& FragColor0)
{
SurfaceProperties l9_0;
l9_0.albedo=float3(0.0);
l9_0.opacity=1.0;
l9_0.normal=float3(0.0);
l9_0.positionWS=float3(0.0);
l9_0.viewDirWS=float3(0.0);
l9_0.metallic=0.0;
l9_0.roughness=0.0;
l9_0.emissive=float3(0.0);
l9_0.ao=float3(1.0);
l9_0.specularAo=float3(1.0);
l9_0.bakedShadows=float3(1.0);
SurfaceProperties l9_1=l9_0;
SurfaceProperties surfaceProperties=l9_1;
surfaceProperties.opacity=opacity;
float3 param=albedo;
float3 l9_2;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_2=float3(pow(param.x,2.2),pow(param.y,2.2),pow(param.z,2.2));
}
else
{
l9_2=param*param;
}
float3 l9_3=l9_2;
surfaceProperties.albedo=l9_3;
surfaceProperties.normal=normalize(normal);
surfaceProperties.positionWS=position;
surfaceProperties.viewDirWS=viewDir;
float3 param_1=emissive;
float3 l9_4;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_4=float3(pow(param_1.x,2.2),pow(param_1.y,2.2),pow(param_1.z,2.2));
}
else
{
l9_4=param_1*param_1;
}
float3 l9_5=l9_4;
surfaceProperties.emissive=l9_5;
surfaceProperties.metallic=metallic;
surfaceProperties.roughness=roughness;
surfaceProperties.ao=ao;
surfaceProperties.specularAo=specularAO;
if ((int(sc_SSAOEnabled_tmp)!=0))
{
float3 param_2=surfaceProperties.positionWS;
surfaceProperties.ao=evaluateSSAO(param_2,varStereoViewID,UserUniforms,sc_SSAOTexture,sc_SSAOTextureSmpSC);
}
SurfaceProperties param_3=surfaceProperties;
SurfaceProperties l9_6=param_3;
float3 l9_7=mix(float3(0.039999999),l9_6.albedo*l9_6.metallic,float3(l9_6.metallic));
float3 l9_8=mix(l9_6.albedo*(1.0-l9_6.metallic),float3(0.0),float3(l9_6.metallic));
param_3.albedo=l9_8;
param_3.specColor=l9_7;
SurfaceProperties l9_9=param_3;
surfaceProperties=l9_9;
SurfaceProperties param_4=surfaceProperties;
LightingComponents l9_10;
l9_10.directDiffuse=float3(0.0);
l9_10.directSpecular=float3(0.0);
l9_10.indirectDiffuse=float3(1.0);
l9_10.indirectSpecular=float3(0.0);
l9_10.emitted=float3(0.0);
l9_10.transmitted=float3(0.0);
LightingComponents l9_11=l9_10;
LightingComponents l9_12=l9_11;
float3 l9_13=param_4.viewDirWS;
int l9_14=0;
float4 l9_15=float4(param_4.bakedShadows,1.0);
if (sc_DirectionalLightsCount_tmp>0)
{
sc_DirectionalLight_t l9_16;
LightProperties l9_17;
int l9_18=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_18<sc_DirectionalLightsCount_tmp)
{
l9_16.direction=UserUniforms.sc_DirectionalLights[l9_18].direction;
l9_16.color=UserUniforms.sc_DirectionalLights[l9_18].color;
l9_17.direction=l9_16.direction;
l9_17.color=l9_16.color.xyz;
l9_17.attenuation=l9_16.color.w;
l9_17.attenuation*=l9_15[(l9_14<3) ? l9_14 : 3];
l9_14++;
LightingComponents l9_19=l9_12;
LightProperties l9_20=l9_17;
SurfaceProperties l9_21=param_4;
float3 l9_22=l9_13;
SurfaceProperties l9_23=l9_21;
float3 l9_24=l9_20.direction;
float l9_25=dot(l9_23.normal,l9_24);
float l9_26=fast::clamp(l9_25,0.0,1.0);
float3 l9_27=float3(l9_26);
l9_19.directDiffuse+=((l9_27*l9_20.color)*l9_20.attenuation);
SurfaceProperties l9_28=l9_21;
float3 l9_29=l9_20.direction;
float3 l9_30=l9_22;
l9_19.directSpecular+=((calculateDirectSpecular(l9_28,l9_29,l9_30,UserUniforms)*l9_20.color)*l9_20.attenuation);
LightingComponents l9_31=l9_19;
l9_12=l9_31;
l9_18++;
continue;
}
else
{
break;
}
}
}
if (sc_PointLightsCount_tmp>0)
{
sc_PointLight_t_1 l9_32;
LightProperties l9_33;
int l9_34=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_34<sc_PointLightsCount_tmp)
{
l9_32.falloffEnabled=UserUniforms.sc_PointLights[l9_34].falloffEnabled!=0;
l9_32.falloffEndDistance=UserUniforms.sc_PointLights[l9_34].falloffEndDistance;
l9_32.negRcpFalloffEndDistance4=UserUniforms.sc_PointLights[l9_34].negRcpFalloffEndDistance4;
l9_32.angleScale=UserUniforms.sc_PointLights[l9_34].angleScale;
l9_32.angleOffset=UserUniforms.sc_PointLights[l9_34].angleOffset;
l9_32.direction=UserUniforms.sc_PointLights[l9_34].direction;
l9_32.position=UserUniforms.sc_PointLights[l9_34].position;
l9_32.color=UserUniforms.sc_PointLights[l9_34].color;
float3 l9_35=l9_32.position-param_4.positionWS;
l9_33.direction=normalize(l9_35);
l9_33.color=l9_32.color.xyz;
l9_33.attenuation=l9_32.color.w;
l9_33.attenuation*=l9_15[(l9_14<3) ? l9_14 : 3];
float3 l9_36=l9_33.direction;
float3 l9_37=l9_32.direction;
float l9_38=l9_32.angleScale;
float l9_39=l9_32.angleOffset;
float l9_40=dot(l9_36,l9_37);
float l9_41=fast::clamp((l9_40*l9_38)+l9_39,0.0,1.0);
float l9_42=l9_41*l9_41;
l9_33.attenuation*=l9_42;
if (l9_32.falloffEnabled)
{
float l9_43=length(l9_35);
float l9_44=l9_32.falloffEndDistance;
l9_33.attenuation*=computeDistanceAttenuation(l9_43,l9_44);
}
l9_14++;
LightingComponents l9_45=l9_12;
LightProperties l9_46=l9_33;
SurfaceProperties l9_47=param_4;
float3 l9_48=l9_13;
SurfaceProperties l9_49=l9_47;
float3 l9_50=l9_46.direction;
float l9_51=dot(l9_49.normal,l9_50);
float l9_52=fast::clamp(l9_51,0.0,1.0);
float3 l9_53=float3(l9_52);
l9_45.directDiffuse+=((l9_53*l9_46.color)*l9_46.attenuation);
SurfaceProperties l9_54=l9_47;
float3 l9_55=l9_46.direction;
float3 l9_56=l9_48;
l9_45.directSpecular+=((calculateDirectSpecular(l9_54,l9_55,l9_56,UserUniforms)*l9_46.color)*l9_46.attenuation);
LightingComponents l9_57=l9_45;
l9_12=l9_57;
l9_34++;
continue;
}
else
{
break;
}
}
}
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float3 l9_58=float3(0.0);
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float2 l9_59=abs(varShadowTex-float2(0.5));
float l9_60=fast::max(l9_59.x,l9_59.y);
float l9_61=step(l9_60,0.5);
float4 l9_62=sc_ShadowTexture.sample(sc_ShadowTextureSmpSC,varShadowTex)*l9_61;
float3 l9_63=mix(UserUniforms.sc_ShadowColor.xyz,UserUniforms.sc_ShadowColor.xyz*l9_62.xyz,float3(UserUniforms.sc_ShadowColor.w));
float l9_64=l9_62.w*UserUniforms.sc_ShadowDensity;
l9_58=mix(float3(1.0),l9_63,float3(l9_64));
}
else
{
l9_58=float3(1.0);
}
float3 l9_65=l9_58;
float3 l9_66=l9_65;
l9_12.directDiffuse*=l9_66;
l9_12.directSpecular*=l9_66;
}
bool l9_67=UserUniforms.receivesRayTracedShadows!=0;
if (l9_67)
{
float4 l9_68=gl_FragCoord;
float2 l9_69=(l9_68.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 l9_70=l9_69;
float2 l9_71=l9_70;
int l9_72=0;
if ((int(sc_RayTracedShadowTextureHasSwappedViews_tmp)!=0))
{
int l9_73=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_73=0;
}
else
{
l9_73=varStereoViewID;
}
int l9_74=l9_73;
l9_72=1-l9_74;
}
else
{
int l9_75=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_75=0;
}
else
{
l9_75=varStereoViewID;
}
int l9_76=l9_75;
l9_72=l9_76;
}
int l9_77=l9_72;
float2 l9_78=l9_71;
int l9_79=l9_77;
float2 l9_80=l9_78;
int l9_81=l9_79;
float l9_82=0.0;
float4 l9_83=float4(0.0);
float2 l9_84=l9_80;
int l9_85=sc_RayTracedShadowTextureLayout_tmp;
int l9_86=l9_81;
float l9_87=l9_82;
float2 l9_88=l9_84;
int l9_89=l9_85;
int l9_90=l9_86;
float3 l9_91=float3(0.0);
if (l9_89==0)
{
l9_91=float3(l9_88,0.0);
}
else
{
if (l9_89==1)
{
l9_91=float3(l9_88.x,(l9_88.y*0.5)+(0.5-(float(l9_90)*0.5)),0.0);
}
else
{
l9_91=float3(l9_88,float(l9_90));
}
}
float3 l9_92=l9_91;
float3 l9_93=l9_92;
float2 l9_94=l9_93.xy;
float l9_95=l9_87;
float4 l9_96=sc_RayTracedShadowTexture.sample(sc_RayTracedShadowTextureSmpSC,l9_94,bias(l9_95));
float4 l9_97=l9_96;
l9_83=l9_97;
float4 l9_98=l9_83;
float4 l9_99=l9_98;
float4 l9_100=l9_99;
float l9_101=l9_100.x;
float3 l9_102=float3(l9_101);
float3 l9_103=l9_102;
l9_12.directDiffuse*=(float3(1.0)-l9_103);
l9_12.directSpecular*=(float3(1.0)-l9_103);
}
SurfaceProperties l9_104=param_4;
float3 l9_105=l9_104.normal;
float3 l9_106=float3(0.0);
if ((sc_EnvLightMode_tmp==sc_AmbientLightMode_EnvironmentMap_tmp)||(sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp))
{
float3 l9_107=l9_105;
float3 l9_108=l9_107;
float l9_109=UserUniforms.sc_EnvmapRotation.y;
float2 l9_110=float2(0.0);
float l9_111=l9_108.x;
float l9_112=-l9_108.z;
float l9_113=(l9_111<0.0) ? (-1.0) : 1.0;
float l9_114=l9_113*acos(fast::clamp(l9_112/length(float2(l9_111,l9_112)),-1.0,1.0));
l9_110.x=l9_114-1.5707964;
l9_110.y=acos(l9_108.y);
l9_110/=float2(6.2831855,3.1415927);
l9_110.y=1.0-l9_110.y;
l9_110.x+=(l9_109/360.0);
l9_110.x=fract((l9_110.x+floor(l9_110.x))+1.0);
float2 l9_115=l9_110;
float2 l9_116=l9_115;
float4 l9_117=float4(0.0);
if (sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float2 l9_118=l9_116;
float2 l9_119=UserUniforms.sc_EnvmapSpecularSize.xy;
float l9_120=5.0;
l9_116=calcSeamlessPanoramicUvsForSampling(l9_118,l9_119,l9_120);
}
float2 l9_121=l9_116;
float l9_122=13.0;
int l9_123=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_124=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_124=0;
}
else
{
l9_124=varStereoViewID;
}
int l9_125=l9_124;
l9_123=1-l9_125;
}
else
{
int l9_126=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_126=0;
}
else
{
l9_126=varStereoViewID;
}
int l9_127=l9_126;
l9_123=l9_127;
}
int l9_128=l9_123;
float2 l9_129=l9_121;
int l9_130=l9_128;
float l9_131=l9_122;
float4 l9_132=float4(0.0);
float2 l9_133=l9_129;
int l9_134=sc_EnvmapSpecularLayout_tmp;
int l9_135=l9_130;
float l9_136=l9_131;
float2 l9_137=l9_133;
int l9_138=l9_134;
int l9_139=l9_135;
float3 l9_140=float3(0.0);
if (l9_138==0)
{
l9_140=float3(l9_137,0.0);
}
else
{
if (l9_138==1)
{
l9_140=float3(l9_137.x,(l9_137.y*0.5)+(0.5-(float(l9_139)*0.5)),0.0);
}
else
{
l9_140=float3(l9_137,float(l9_139));
}
}
float3 l9_141=l9_140;
float3 l9_142=l9_141;
float2 l9_143=l9_142.xy;
float l9_144=l9_136;
float4 l9_145=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_143,bias(l9_144));
float4 l9_146=l9_145;
l9_132=l9_146;
float4 l9_147=l9_132;
float4 l9_148=l9_147;
l9_117=l9_148;
}
else
{
if ((sc_MaxTextureImageUnits_tmp>8)&&(int(sc_HasDiffuseEnvmap_tmp)!=0))
{
float2 l9_149=l9_116;
float2 l9_150=UserUniforms.sc_EnvmapDiffuseSize.xy;
float l9_151=0.0;
l9_116=calcSeamlessPanoramicUvsForSampling(l9_149,l9_150,l9_151);
bool l9_152=UserUniforms.isProxyMode!=0;
if (l9_152)
{
float2 l9_153=l9_116;
float l9_154=0.0;
int l9_155=0;
if ((int(sc_EnvmapDiffuseHasSwappedViews_tmp)!=0))
{
int l9_156=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_156=0;
}
else
{
l9_156=varStereoViewID;
}
int l9_157=l9_156;
l9_155=1-l9_157;
}
else
{
int l9_158=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_158=0;
}
else
{
l9_158=varStereoViewID;
}
int l9_159=l9_158;
l9_155=l9_159;
}
int l9_160=l9_155;
float2 l9_161=l9_153;
int l9_162=l9_160;
float l9_163=l9_154;
float4 l9_164=float4(0.0);
float2 l9_165=l9_161;
int l9_166=sc_EnvmapDiffuseLayout_tmp;
int l9_167=l9_162;
float l9_168=l9_163;
float2 l9_169=l9_165;
int l9_170=l9_166;
int l9_171=l9_167;
float3 l9_172=float3(0.0);
if (l9_170==0)
{
l9_172=float3(l9_169,0.0);
}
else
{
if (l9_170==1)
{
l9_172=float3(l9_169.x,(l9_169.y*0.5)+(0.5-(float(l9_171)*0.5)),0.0);
}
else
{
l9_172=float3(l9_169,float(l9_171));
}
}
float3 l9_173=l9_172;
float3 l9_174=l9_173;
float2 l9_175=l9_174.xy;
float l9_176=l9_168;
float4 l9_177=sc_EnvmapDiffuse.sample(sc_EnvmapDiffuseSmpSC,l9_175,level(l9_176));
float4 l9_178=l9_177;
l9_164=l9_178;
float4 l9_179=l9_164;
float4 l9_180=l9_179;
l9_117=l9_180;
}
else
{
float2 l9_181=l9_116;
float l9_182=-13.0;
int l9_183=0;
if ((int(sc_EnvmapDiffuseHasSwappedViews_tmp)!=0))
{
int l9_184=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_184=0;
}
else
{
l9_184=varStereoViewID;
}
int l9_185=l9_184;
l9_183=1-l9_185;
}
else
{
int l9_186=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_186=0;
}
else
{
l9_186=varStereoViewID;
}
int l9_187=l9_186;
l9_183=l9_187;
}
int l9_188=l9_183;
float2 l9_189=l9_181;
int l9_190=l9_188;
float l9_191=l9_182;
float4 l9_192=float4(0.0);
float2 l9_193=l9_189;
int l9_194=sc_EnvmapDiffuseLayout_tmp;
int l9_195=l9_190;
float l9_196=l9_191;
float2 l9_197=l9_193;
int l9_198=l9_194;
int l9_199=l9_195;
float3 l9_200=float3(0.0);
if (l9_198==0)
{
l9_200=float3(l9_197,0.0);
}
else
{
if (l9_198==1)
{
l9_200=float3(l9_197.x,(l9_197.y*0.5)+(0.5-(float(l9_199)*0.5)),0.0);
}
else
{
l9_200=float3(l9_197,float(l9_199));
}
}
float3 l9_201=l9_200;
float3 l9_202=l9_201;
float2 l9_203=l9_202.xy;
float l9_204=l9_196;
float4 l9_205=sc_EnvmapDiffuse.sample(sc_EnvmapDiffuseSmpSC,l9_203,bias(l9_204));
float4 l9_206=l9_205;
l9_192=l9_206;
float4 l9_207=l9_192;
float4 l9_208=l9_207;
l9_117=l9_208;
}
}
else
{
float2 l9_209=l9_116;
float l9_210=13.0;
int l9_211=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_212=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_212=0;
}
else
{
l9_212=varStereoViewID;
}
int l9_213=l9_212;
l9_211=1-l9_213;
}
else
{
int l9_214=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_214=0;
}
else
{
l9_214=varStereoViewID;
}
int l9_215=l9_214;
l9_211=l9_215;
}
int l9_216=l9_211;
float2 l9_217=l9_209;
int l9_218=l9_216;
float l9_219=l9_210;
float4 l9_220=float4(0.0);
float2 l9_221=l9_217;
int l9_222=sc_EnvmapSpecularLayout_tmp;
int l9_223=l9_218;
float l9_224=l9_219;
float2 l9_225=l9_221;
int l9_226=l9_222;
int l9_227=l9_223;
float3 l9_228=float3(0.0);
if (l9_226==0)
{
l9_228=float3(l9_225,0.0);
}
else
{
if (l9_226==1)
{
l9_228=float3(l9_225.x,(l9_225.y*0.5)+(0.5-(float(l9_227)*0.5)),0.0);
}
else
{
l9_228=float3(l9_225,float(l9_227));
}
}
float3 l9_229=l9_228;
float3 l9_230=l9_229;
float2 l9_231=l9_230.xy;
float l9_232=l9_224;
float4 l9_233=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_231,bias(l9_232));
float4 l9_234=l9_233;
l9_220=l9_234;
float4 l9_235=l9_220;
float4 l9_236=l9_235;
l9_117=l9_236;
}
}
float4 l9_237=l9_117;
float3 l9_238=l9_237.xyz*(1.0/l9_237.w);
float3 l9_239=l9_238*UserUniforms.sc_EnvmapExposure;
l9_106=l9_239;
}
else
{
if (sc_EnvLightMode_tmp==sc_AmbientLightMode_SphericalHarmonics_tmp)
{
float3 l9_240=UserUniforms.sc_Sh[0];
float3 l9_241=UserUniforms.sc_Sh[1];
float3 l9_242=UserUniforms.sc_Sh[2];
float3 l9_243=UserUniforms.sc_Sh[3];
float3 l9_244=UserUniforms.sc_Sh[4];
float3 l9_245=UserUniforms.sc_Sh[5];
float3 l9_246=UserUniforms.sc_Sh[6];
float3 l9_247=UserUniforms.sc_Sh[7];
float3 l9_248=UserUniforms.sc_Sh[8];
float3 l9_249=-l9_105;
float l9_250=0.0;
l9_250=l9_249.x;
float l9_251=l9_249.y;
float l9_252=l9_249.z;
float l9_253=l9_250*l9_250;
float l9_254=l9_251*l9_251;
float l9_255=l9_252*l9_252;
float l9_256=l9_250*l9_251;
float l9_257=l9_251*l9_252;
float l9_258=l9_250*l9_252;
float3 l9_259=((((((l9_248*0.42904299)*(l9_253-l9_254))+((l9_246*0.74312502)*l9_255))+(l9_240*0.88622701))-(l9_246*0.24770799))+((((l9_244*l9_256)+(l9_247*l9_258))+(l9_245*l9_257))*0.85808599))+((((l9_243*l9_250)+(l9_241*l9_251))+(l9_242*l9_252))*1.0233279);
l9_106=l9_259*UserUniforms.sc_ShIntensity;
}
}
bool l9_260=UserUniforms.receivesRayTracedDiffuseIndirect!=0;
if (l9_260)
{
float4 l9_261=sampleRayTracedIndirectDiffuse(varStereoViewID,UserUniforms,sc_RayTracedDiffIndTexture,sc_RayTracedDiffIndTextureSmpSC,gl_FragCoord);
l9_106=mix(l9_106,l9_261.xyz,float3(l9_261.w));
}
if (sc_AmbientLightsCount_tmp>0)
{
if (sc_AmbientLightMode0_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_106+=(UserUniforms.sc_AmbientLights[0].color*UserUniforms.sc_AmbientLights[0].intensity);
}
else
{
l9_106.x+=(1e-06*UserUniforms.sc_AmbientLights[0].color.x);
}
}
if (sc_AmbientLightsCount_tmp>1)
{
if (sc_AmbientLightMode1_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_106+=(UserUniforms.sc_AmbientLights[1].color*UserUniforms.sc_AmbientLights[1].intensity);
}
else
{
l9_106.x+=(1e-06*UserUniforms.sc_AmbientLights[1].color.x);
}
}
if (sc_AmbientLightsCount_tmp>2)
{
if (sc_AmbientLightMode2_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_106+=(UserUniforms.sc_AmbientLights[2].color*UserUniforms.sc_AmbientLights[2].intensity);
}
else
{
l9_106.x+=(1e-06*UserUniforms.sc_AmbientLights[2].color.x);
}
}
if ((int(sc_LightEstimation_tmp)!=0))
{
float3 l9_262=l9_105;
float3 l9_263=UserUniforms.sc_LightEstimationData.ambientLight;
sc_SphericalGaussianLight_t l9_264;
float l9_265;
int l9_266=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_266<sc_LightEstimationSGCount_tmp)
{
l9_264.color=UserUniforms.sc_LightEstimationData.sg[l9_266].color;
l9_264.sharpness=UserUniforms.sc_LightEstimationData.sg[l9_266].sharpness;
l9_264.axis=UserUniforms.sc_LightEstimationData.sg[l9_266].axis;
float3 l9_267=l9_262;
float l9_268=dot(l9_264.axis,l9_267);
float l9_269=l9_264.sharpness;
float l9_270=0.36000001;
float l9_271=1.0/(4.0*l9_270);
float l9_272=exp(-l9_269);
float l9_273=l9_272*l9_272;
float l9_274=1.0/l9_269;
float l9_275=(1.0+(2.0*l9_273))-l9_274;
float l9_276=((l9_272-l9_273)*l9_274)-l9_273;
float l9_277=sqrt(1.0-l9_275);
float l9_278=l9_270*l9_268;
float l9_279=l9_271*l9_277;
float l9_280=l9_278+l9_279;
float l9_281=l9_268;
float l9_282=fast::clamp(l9_281,0.0,1.0);
float l9_283=l9_282;
if (step(abs(l9_278),l9_279)>0.5)
{
l9_265=(l9_280*l9_280)/l9_277;
}
else
{
l9_265=l9_283;
}
l9_283=l9_265;
float l9_284=(l9_275*l9_283)+l9_276;
sc_SphericalGaussianLight_t l9_285=l9_264;
float3 l9_286=(l9_285.color/float3(l9_285.sharpness))*6.2831855;
float3 l9_287=(l9_286*l9_284)/float3(3.1415927);
l9_263+=l9_287;
l9_266++;
continue;
}
else
{
break;
}
}
float3 l9_288=l9_263;
l9_106+=l9_288;
}
float3 l9_289=l9_106;
float3 l9_290=l9_289;
l9_12.indirectDiffuse=l9_290;
SurfaceProperties l9_291=param_4;
float3 l9_292=l9_13;
float3 l9_293=float3(0.0);
if ((sc_EnvLightMode_tmp==sc_AmbientLightMode_EnvironmentMap_tmp)||(sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp))
{
SurfaceProperties l9_294=l9_291;
float3 l9_295=l9_292;
float3 l9_296=l9_294.normal;
float3 l9_297=reflect(-l9_295,l9_296);
float3 l9_298=l9_296;
float3 l9_299=l9_297;
float l9_300=l9_294.roughness;
l9_297=getSpecularDominantDir(l9_298,l9_299,l9_300);
float l9_301=l9_294.roughness;
float l9_302=pow(l9_301,0.66666669);
float l9_303=fast::clamp(l9_302,0.0,1.0);
float l9_304=l9_303*5.0;
float l9_305=l9_304;
float l9_306=l9_305;
float3 l9_307=l9_297;
float l9_308=l9_306;
float3 l9_309=l9_307;
float l9_310=l9_308;
float4 l9_311=float4(0.0);
float3 l9_312=l9_309;
float l9_313=UserUniforms.sc_EnvmapRotation.y;
float2 l9_314=float2(0.0);
float l9_315=l9_312.x;
float l9_316=-l9_312.z;
float l9_317=(l9_315<0.0) ? (-1.0) : 1.0;
float l9_318=l9_317*acos(fast::clamp(l9_316/length(float2(l9_315,l9_316)),-1.0,1.0));
l9_314.x=l9_318-1.5707964;
l9_314.y=acos(l9_312.y);
l9_314/=float2(6.2831855,3.1415927);
l9_314.y=1.0-l9_314.y;
l9_314.x+=(l9_313/360.0);
l9_314.x=fract((l9_314.x+floor(l9_314.x))+1.0);
float2 l9_319=l9_314;
float2 l9_320=l9_319;
if (SC_DEVICE_CLASS_tmp>=2)
{
float l9_321=floor(l9_310);
float l9_322=ceil(l9_310);
float l9_323=l9_310-l9_321;
float2 l9_324=l9_320;
float2 l9_325=UserUniforms.sc_EnvmapSpecularSize.xy;
float l9_326=l9_321;
float2 l9_327=calcSeamlessPanoramicUvsForSampling(l9_324,l9_325,l9_326);
float2 l9_328=l9_327;
float l9_329=l9_321;
float2 l9_330=l9_328;
float l9_331=l9_329;
int l9_332=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_333=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_333=0;
}
else
{
l9_333=varStereoViewID;
}
int l9_334=l9_333;
l9_332=1-l9_334;
}
else
{
int l9_335=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_335=0;
}
else
{
l9_335=varStereoViewID;
}
int l9_336=l9_335;
l9_332=l9_336;
}
int l9_337=l9_332;
float2 l9_338=l9_330;
int l9_339=l9_337;
float l9_340=l9_331;
float4 l9_341=float4(0.0);
float2 l9_342=l9_338;
int l9_343=sc_EnvmapSpecularLayout_tmp;
int l9_344=l9_339;
float l9_345=l9_340;
float2 l9_346=l9_342;
int l9_347=l9_343;
int l9_348=l9_344;
float3 l9_349=float3(0.0);
if (l9_347==0)
{
l9_349=float3(l9_346,0.0);
}
else
{
if (l9_347==1)
{
l9_349=float3(l9_346.x,(l9_346.y*0.5)+(0.5-(float(l9_348)*0.5)),0.0);
}
else
{
l9_349=float3(l9_346,float(l9_348));
}
}
float3 l9_350=l9_349;
float3 l9_351=l9_350;
float2 l9_352=l9_351.xy;
float l9_353=l9_345;
float4 l9_354=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_352,level(l9_353));
float4 l9_355=l9_354;
l9_341=l9_355;
float4 l9_356=l9_341;
float4 l9_357=l9_356;
float4 l9_358=l9_357;
float4 l9_359=l9_358;
float2 l9_360=l9_320;
float2 l9_361=UserUniforms.sc_EnvmapSpecularSize.xy;
float l9_362=l9_322;
float2 l9_363=calcSeamlessPanoramicUvsForSampling(l9_360,l9_361,l9_362);
float2 l9_364=l9_363;
float l9_365=l9_322;
float2 l9_366=l9_364;
float l9_367=l9_365;
int l9_368=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_369=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_369=0;
}
else
{
l9_369=varStereoViewID;
}
int l9_370=l9_369;
l9_368=1-l9_370;
}
else
{
int l9_371=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_371=0;
}
else
{
l9_371=varStereoViewID;
}
int l9_372=l9_371;
l9_368=l9_372;
}
int l9_373=l9_368;
float2 l9_374=l9_366;
int l9_375=l9_373;
float l9_376=l9_367;
float4 l9_377=float4(0.0);
float2 l9_378=l9_374;
int l9_379=sc_EnvmapSpecularLayout_tmp;
int l9_380=l9_375;
float l9_381=l9_376;
float2 l9_382=l9_378;
int l9_383=l9_379;
int l9_384=l9_380;
float3 l9_385=float3(0.0);
if (l9_383==0)
{
l9_385=float3(l9_382,0.0);
}
else
{
if (l9_383==1)
{
l9_385=float3(l9_382.x,(l9_382.y*0.5)+(0.5-(float(l9_384)*0.5)),0.0);
}
else
{
l9_385=float3(l9_382,float(l9_384));
}
}
float3 l9_386=l9_385;
float3 l9_387=l9_386;
float2 l9_388=l9_387.xy;
float l9_389=l9_381;
float4 l9_390=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_388,level(l9_389));
float4 l9_391=l9_390;
l9_377=l9_391;
float4 l9_392=l9_377;
float4 l9_393=l9_392;
float4 l9_394=l9_393;
float4 l9_395=l9_394;
l9_311=mix(l9_359,l9_395,float4(l9_323));
}
else
{
float2 l9_396=l9_320;
float l9_397=l9_310;
float2 l9_398=l9_396;
float l9_399=l9_397;
int l9_400=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_401=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_401=0;
}
else
{
l9_401=varStereoViewID;
}
int l9_402=l9_401;
l9_400=1-l9_402;
}
else
{
int l9_403=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_403=0;
}
else
{
l9_403=varStereoViewID;
}
int l9_404=l9_403;
l9_400=l9_404;
}
int l9_405=l9_400;
float2 l9_406=l9_398;
int l9_407=l9_405;
float l9_408=l9_399;
float4 l9_409=float4(0.0);
float2 l9_410=l9_406;
int l9_411=sc_EnvmapSpecularLayout_tmp;
int l9_412=l9_407;
float l9_413=l9_408;
float2 l9_414=l9_410;
int l9_415=l9_411;
int l9_416=l9_412;
float3 l9_417=float3(0.0);
if (l9_415==0)
{
l9_417=float3(l9_414,0.0);
}
else
{
if (l9_415==1)
{
l9_417=float3(l9_414.x,(l9_414.y*0.5)+(0.5-(float(l9_416)*0.5)),0.0);
}
else
{
l9_417=float3(l9_414,float(l9_416));
}
}
float3 l9_418=l9_417;
float3 l9_419=l9_418;
float2 l9_420=l9_419.xy;
float l9_421=l9_413;
float4 l9_422=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_420,level(l9_421));
float4 l9_423=l9_422;
l9_409=l9_423;
float4 l9_424=l9_409;
float4 l9_425=l9_424;
float4 l9_426=l9_425;
l9_311=l9_426;
}
float4 l9_427=l9_311;
float3 l9_428=l9_427.xyz*(1.0/l9_427.w);
float3 l9_429=l9_428;
float3 l9_430=l9_429*UserUniforms.sc_EnvmapExposure;
l9_430+=float3(1e-06);
float3 l9_431=l9_430;
float3 l9_432=l9_431;
bool l9_433=UserUniforms.receivesRayTracedReflections!=0;
if (l9_433)
{
float4 l9_434=sampleRayTracedReflections(varStereoViewID,UserUniforms,sc_RayTracedReflectionTexture,sc_RayTracedReflectionTextureSmpSC,gl_FragCoord);
l9_432=mix(l9_432,l9_434.xyz,float3(l9_434.w));
}
SurfaceProperties l9_435=l9_294;
float l9_436=abs(dot(l9_296,l9_295));
float3 l9_437=l9_432*envBRDFApprox(l9_435,l9_436);
l9_293+=l9_437;
}
if ((int(sc_LightEstimation_tmp)!=0))
{
SurfaceProperties l9_438=l9_291;
float3 l9_439=l9_292;
float l9_440=fast::clamp(l9_438.roughness*l9_438.roughness,0.0099999998,1.0);
float3 l9_441=UserUniforms.sc_LightEstimationData.ambientLight*l9_438.specColor;
sc_SphericalGaussianLight_t l9_442;
sc_SphericalGaussianLight_t l9_443;
sc_SphericalGaussianLight_t l9_444;
int l9_445=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_445<sc_LightEstimationSGCount_tmp)
{
l9_442.color=UserUniforms.sc_LightEstimationData.sg[l9_445].color;
l9_442.sharpness=UserUniforms.sc_LightEstimationData.sg[l9_445].sharpness;
l9_442.axis=UserUniforms.sc_LightEstimationData.sg[l9_445].axis;
float3 l9_446=l9_438.normal;
float l9_447=l9_440;
float3 l9_448=l9_439;
float3 l9_449=l9_438.specColor;
float3 l9_450=l9_446;
float l9_451=l9_447;
l9_443.axis=l9_450;
float l9_452=l9_451*l9_451;
l9_443.sharpness=2.0/l9_452;
l9_443.color=float3(1.0/(3.1415927*l9_452));
sc_SphericalGaussianLight_t l9_453=l9_443;
sc_SphericalGaussianLight_t l9_454=l9_453;
sc_SphericalGaussianLight_t l9_455=l9_454;
float3 l9_456=l9_448;
l9_444.axis=reflect(-l9_456,l9_455.axis);
l9_444.color=l9_455.color;
l9_444.sharpness=l9_455.sharpness;
l9_444.sharpness/=(4.0*fast::max(dot(l9_455.axis,l9_456),9.9999997e-05));
sc_SphericalGaussianLight_t l9_457=l9_444;
sc_SphericalGaussianLight_t l9_458=l9_457;
sc_SphericalGaussianLight_t l9_459=l9_458;
sc_SphericalGaussianLight_t l9_460=l9_442;
float l9_461=length((l9_459.axis*l9_459.sharpness)+(l9_460.axis*l9_460.sharpness));
float3 l9_462=(l9_459.color*exp((l9_461-l9_459.sharpness)-l9_460.sharpness))*l9_460.color;
float l9_463=1.0-exp((-2.0)*l9_461);
float3 l9_464=((l9_462*6.2831855)*l9_463)/float3(l9_461);
float3 l9_465=l9_464;
float3 l9_466=l9_458.axis;
float l9_467=l9_447*l9_447;
float l9_468=dot(l9_446,l9_466);
float l9_469=fast::clamp(l9_468,0.0,1.0);
float l9_470=l9_469;
float l9_471=dot(l9_446,l9_448);
float l9_472=fast::clamp(l9_471,0.0,1.0);
float l9_473=l9_472;
float3 l9_474=normalize(l9_458.axis+l9_448);
float l9_475=l9_467;
float l9_476=l9_470;
float l9_477=1.0/(l9_476+sqrt(l9_475+(((1.0-l9_475)*l9_476)*l9_476)));
float l9_478=l9_467;
float l9_479=l9_473;
float l9_480=1.0/(l9_479+sqrt(l9_478+(((1.0-l9_478)*l9_479)*l9_479)));
l9_465*=(l9_477*l9_480);
float l9_481=dot(l9_466,l9_474);
float l9_482=fast::clamp(l9_481,0.0,1.0);
float l9_483=pow(1.0-l9_482,5.0);
l9_465*=(l9_449+((float3(1.0)-l9_449)*l9_483));
l9_465*=l9_470;
float3 l9_484=l9_465;
l9_441+=l9_484;
l9_445++;
continue;
}
else
{
break;
}
}
float3 l9_485=l9_441;
l9_293+=l9_485;
}
float3 l9_486=l9_293;
l9_12.indirectSpecular=l9_486;
LightingComponents l9_487=l9_12;
LightingComponents lighting=l9_487;
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
lighting.directDiffuse=float3(0.0);
lighting.indirectDiffuse=float3(0.0);
float4 l9_488=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_489=FragColor0;
float4 l9_490=l9_489;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_490.x+=UserUniforms._sc_framebufferFetchMarker;
}
float4 l9_491=l9_490;
l9_488=l9_491;
}
else
{
float4 l9_492=gl_FragCoord;
float2 l9_493=(l9_492.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 l9_494=l9_493;
float2 l9_495=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_496=1;
int l9_497=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_497=0;
}
else
{
l9_497=varStereoViewID;
}
int l9_498=l9_497;
int l9_499=l9_498;
float3 l9_500=float3(l9_494,0.0);
int l9_501=l9_496;
int l9_502=l9_499;
if (l9_501==1)
{
l9_500.y=((2.0*l9_500.y)+float(l9_502))-1.0;
}
float2 l9_503=l9_500.xy;
l9_495=l9_503;
}
else
{
l9_495=l9_494;
}
float2 l9_504=l9_495;
float2 l9_505=l9_504;
float2 l9_506=l9_505;
int l9_507=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_508=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_508=0;
}
else
{
l9_508=varStereoViewID;
}
int l9_509=l9_508;
l9_507=1-l9_509;
}
else
{
int l9_510=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_510=0;
}
else
{
l9_510=varStereoViewID;
}
int l9_511=l9_510;
l9_507=l9_511;
}
int l9_512=l9_507;
float2 l9_513=l9_506;
int l9_514=l9_512;
float2 l9_515=l9_513;
int l9_516=l9_514;
float l9_517=0.0;
float4 l9_518=float4(0.0);
float2 l9_519=l9_515;
int l9_520=sc_ScreenTextureLayout_tmp;
int l9_521=l9_516;
float l9_522=l9_517;
float2 l9_523=l9_519;
int l9_524=l9_520;
int l9_525=l9_521;
float3 l9_526=float3(0.0);
if (l9_524==0)
{
l9_526=float3(l9_523,0.0);
}
else
{
if (l9_524==1)
{
l9_526=float3(l9_523.x,(l9_523.y*0.5)+(0.5-(float(l9_525)*0.5)),0.0);
}
else
{
l9_526=float3(l9_523,float(l9_525));
}
}
float3 l9_527=l9_526;
float3 l9_528=l9_527;
float2 l9_529=l9_528.xy;
float l9_530=l9_522;
float4 l9_531=sc_ScreenTexture.sample(sc_ScreenTextureSmpSC,l9_529,bias(l9_530));
float4 l9_532=l9_531;
l9_518=l9_532;
float4 l9_533=l9_518;
float4 l9_534=l9_533;
float4 l9_535=l9_534;
l9_488=l9_535;
}
float4 l9_536=l9_488;
float4 l9_537=l9_536;
float3 param_5=l9_537.xyz;
float3 l9_538;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_538=float3(pow(param_5.x,2.2),pow(param_5.y,2.2),pow(param_5.z,2.2));
}
else
{
l9_538=param_5*param_5;
}
float3 l9_539=l9_538;
float3 framebuffer=l9_539;
lighting.transmitted=framebuffer*mix(float3(1.0),surfaceProperties.albedo,float3(surfaceProperties.opacity));
surfaceProperties.opacity=1.0;
}
bool enablePremultipliedAlpha=false;
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
enablePremultipliedAlpha=true;
}
SurfaceProperties param_6=surfaceProperties;
LightingComponents param_7=lighting;
bool param_8=enablePremultipliedAlpha;
float3 l9_540=float3(0.0);
bool l9_541=UserUniforms.receivesRayTracedAo!=0;
if (l9_541)
{
l9_540=param_6.albedo*(param_7.directDiffuse+(param_7.indirectDiffuse*float3(1.0-sampleRayTracedAo(varStereoViewID,UserUniforms,sc_RayTracedAoTexture,sc_RayTracedAoTextureSmpSC,gl_FragCoord))));
}
else
{
l9_540=param_6.albedo*(param_7.directDiffuse+(param_7.indirectDiffuse*param_6.ao));
}
float3 l9_542=param_7.directSpecular+(param_7.indirectSpecular*param_6.specularAo);
float3 l9_543=param_6.emissive;
float3 l9_544=param_7.transmitted;
if (param_8)
{
float l9_545=param_6.opacity;
l9_540*=srgbToLinear(l9_545);
}
float3 l9_546=((l9_540+l9_542)+l9_543)+l9_544;
float3 l9_547=l9_546;
float4 Output=float4(l9_547,surfaceProperties.opacity);
bool l9_548=UserUniforms.isProxyMode!=0;
if (l9_548)
{
return Output;
}
if (!(int(sc_BlendMode_Multiply_tmp)!=0))
{
float3 param_9=Output.xyz;
float l9_549=1.8;
float l9_550=1.4;
float l9_551=0.5;
float l9_552=1.5;
float3 l9_553=(param_9*((param_9*l9_549)+float3(l9_550)))/((param_9*((param_9*l9_549)+float3(l9_551)))+float3(l9_552));
Output=float4(l9_553.x,l9_553.y,l9_553.z,Output.w);
}
float3 param_10=Output.xyz;
float l9_554=param_10.x;
float l9_555=param_10.y;
float l9_556=param_10.z;
float3 l9_557=float3(linearToSrgb(l9_554),linearToSrgb(l9_555),linearToSrgb(l9_556));
Output=float4(l9_557.x,l9_557.y,l9_557.z,Output.w);
return Output;
}
float transformSingleColor(thread const float& original,thread const float& intMap,thread const float& target)
{
if (((int(BLEND_MODE_REALISTIC_tmp)!=0)||(int(BLEND_MODE_FORGRAY_tmp)!=0))||(int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
return original/pow(1.0-target,intMap);
}
else
{
if ((int(BLEND_MODE_DIVISION_tmp)!=0))
{
return original/(1.0-target);
}
else
{
if ((int(BLEND_MODE_BRIGHT_tmp)!=0))
{
return original/pow(1.0-target,2.0-(2.0*original));
}
}
}
return 0.0;
}
float3 transformColor(thread const float& yValue,thread const float3& original,thread const float3& target,thread const float& weight,thread const float& intMap)
{
if ((int(BLEND_MODE_INTENSE_tmp)!=0))
{
float3 param=original;
float3 l9_0=param;
float4 l9_1;
if (l9_0.y<l9_0.z)
{
l9_1=float4(l9_0.zy,-1.0,0.66666669);
}
else
{
l9_1=float4(l9_0.yz,0.0,-0.33333334);
}
float4 l9_2=l9_1;
float4 l9_3;
if (l9_0.x<l9_2.x)
{
l9_3=float4(l9_2.xyw,l9_0.x);
}
else
{
l9_3=float4(l9_0.x,l9_2.yzx);
}
float4 l9_4=l9_3;
float l9_5=l9_4.x-fast::min(l9_4.w,l9_4.y);
float l9_6=abs(((l9_4.w-l9_4.y)/((6.0*l9_5)+1e-07))+l9_4.z);
float l9_7=l9_4.x;
float3 l9_8=float3(l9_6,l9_5,l9_7);
float3 l9_9=l9_8;
float l9_10=l9_9.z-(l9_9.y*0.5);
float l9_11=l9_9.y/((1.0-abs((2.0*l9_10)-1.0))+1e-07);
float3 l9_12=float3(l9_9.x,l9_11,l9_10);
float3 hslOrig=l9_12;
float3 res=float3(0.0);
res.x=target.x;
res.y=target.y;
res.z=hslOrig.z;
float3 param_1=res;
float l9_13=param_1.x;
float l9_14=abs((6.0*l9_13)-3.0)-1.0;
float l9_15=2.0-abs((6.0*l9_13)-2.0);
float l9_16=2.0-abs((6.0*l9_13)-4.0);
float3 l9_17=fast::clamp(float3(l9_14,l9_15,l9_16),float3(0.0),float3(1.0));
float3 l9_18=l9_17;
float l9_19=(1.0-abs((2.0*param_1.z)-1.0))*param_1.y;
l9_18=((l9_18-float3(0.5))*l9_19)+float3(param_1.z);
float3 l9_20=l9_18;
res=l9_20;
float3 resColor=mix(original,res,float3(weight));
return resColor;
}
else
{
float3 tmpColor=float3(0.0);
float param_2=yValue;
float param_3=intMap;
float param_4=target.x;
tmpColor.x=transformSingleColor(param_2,param_3,param_4);
float param_5=yValue;
float param_6=intMap;
float param_7=target.y;
tmpColor.y=transformSingleColor(param_5,param_6,param_7);
float param_8=yValue;
float param_9=intMap;
float param_10=target.z;
tmpColor.z=transformSingleColor(param_8,param_9,param_10);
tmpColor=fast::clamp(tmpColor,float3(0.0),float3(1.0));
float3 resColor_1=mix(original,tmpColor,float3(weight));
return resColor_1;
}
}
float3 definedBlend(thread const float3& a,thread const float3& b,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> intensityTexture,thread sampler intensityTextureSmpSC)
{
if ((int(BLEND_MODE_LIGHTEN_tmp)!=0))
{
return fast::max(a,b);
}
else
{
if ((int(BLEND_MODE_DARKEN_tmp)!=0))
{
return fast::min(a,b);
}
else
{
if ((int(BLEND_MODE_DIVIDE_tmp)!=0))
{
return b/a;
}
else
{
if ((int(BLEND_MODE_AVERAGE_tmp)!=0))
{
return (a+b)*0.5;
}
else
{
if ((int(BLEND_MODE_SUBTRACT_tmp)!=0))
{
return fast::max((a+b)-float3(1.0),float3(0.0));
}
else
{
if ((int(BLEND_MODE_DIFFERENCE_tmp)!=0))
{
return abs(a-b);
}
else
{
if ((int(BLEND_MODE_NEGATION_tmp)!=0))
{
return float3(1.0)-abs((float3(1.0)-a)-b);
}
else
{
if ((int(BLEND_MODE_EXCLUSION_tmp)!=0))
{
return (a+b)-((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_OVERLAY_tmp)!=0))
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
float l9_1=l9_0;
float l9_2;
if (a.y<0.5)
{
l9_2=(2.0*a.y)*b.y;
}
else
{
l9_2=1.0-((2.0*(1.0-a.y))*(1.0-b.y));
}
float l9_3=l9_2;
float l9_4;
if (a.z<0.5)
{
l9_4=(2.0*a.z)*b.z;
}
else
{
l9_4=1.0-((2.0*(1.0-a.z))*(1.0-b.z));
}
return float3(l9_1,l9_3,l9_4);
}
else
{
if ((int(BLEND_MODE_SOFT_LIGHT_tmp)!=0))
{
return (((float3(1.0)-(b*2.0))*a)*a)+((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_HARD_LIGHT_tmp)!=0))
{
float l9_5;
if (b.x<0.5)
{
l9_5=(2.0*b.x)*a.x;
}
else
{
l9_5=1.0-((2.0*(1.0-b.x))*(1.0-a.x));
}
float l9_6=l9_5;
float l9_7;
if (b.y<0.5)
{
l9_7=(2.0*b.y)*a.y;
}
else
{
l9_7=1.0-((2.0*(1.0-b.y))*(1.0-a.y));
}
float l9_8=l9_7;
float l9_9;
if (b.z<0.5)
{
l9_9=(2.0*b.z)*a.z;
}
else
{
l9_9=1.0-((2.0*(1.0-b.z))*(1.0-a.z));
}
return float3(l9_6,l9_8,l9_9);
}
else
{
if ((int(BLEND_MODE_COLOR_DODGE_tmp)!=0))
{
float l9_10;
if (b.x==1.0)
{
l9_10=b.x;
}
else
{
l9_10=fast::min(a.x/(1.0-b.x),1.0);
}
float l9_11=l9_10;
float l9_12;
if (b.y==1.0)
{
l9_12=b.y;
}
else
{
l9_12=fast::min(a.y/(1.0-b.y),1.0);
}
float l9_13=l9_12;
float l9_14;
if (b.z==1.0)
{
l9_14=b.z;
}
else
{
l9_14=fast::min(a.z/(1.0-b.z),1.0);
}
return float3(l9_11,l9_13,l9_14);
}
else
{
if ((int(BLEND_MODE_COLOR_BURN_tmp)!=0))
{
float l9_15;
if (b.x==0.0)
{
l9_15=b.x;
}
else
{
l9_15=fast::max(1.0-((1.0-a.x)/b.x),0.0);
}
float l9_16=l9_15;
float l9_17;
if (b.y==0.0)
{
l9_17=b.y;
}
else
{
l9_17=fast::max(1.0-((1.0-a.y)/b.y),0.0);
}
float l9_18=l9_17;
float l9_19;
if (b.z==0.0)
{
l9_19=b.z;
}
else
{
l9_19=fast::max(1.0-((1.0-a.z)/b.z),0.0);
}
return float3(l9_16,l9_18,l9_19);
}
else
{
if ((int(BLEND_MODE_LINEAR_LIGHT_tmp)!=0))
{
float l9_20;
if (b.x<0.5)
{
l9_20=fast::max((a.x+(2.0*b.x))-1.0,0.0);
}
else
{
l9_20=fast::min(a.x+(2.0*(b.x-0.5)),1.0);
}
float l9_21=l9_20;
float l9_22;
if (b.y<0.5)
{
l9_22=fast::max((a.y+(2.0*b.y))-1.0,0.0);
}
else
{
l9_22=fast::min(a.y+(2.0*(b.y-0.5)),1.0);
}
float l9_23=l9_22;
float l9_24;
if (b.z<0.5)
{
l9_24=fast::max((a.z+(2.0*b.z))-1.0,0.0);
}
else
{
l9_24=fast::min(a.z+(2.0*(b.z-0.5)),1.0);
}
return float3(l9_21,l9_23,l9_24);
}
else
{
if ((int(BLEND_MODE_VIVID_LIGHT_tmp)!=0))
{
float l9_25;
if (b.x<0.5)
{
float l9_26;
if ((2.0*b.x)==0.0)
{
l9_26=2.0*b.x;
}
else
{
l9_26=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_25=l9_26;
}
else
{
float l9_27;
if ((2.0*(b.x-0.5))==1.0)
{
l9_27=2.0*(b.x-0.5);
}
else
{
l9_27=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_25=l9_27;
}
float l9_28=l9_25;
float l9_29;
if (b.y<0.5)
{
float l9_30;
if ((2.0*b.y)==0.0)
{
l9_30=2.0*b.y;
}
else
{
l9_30=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_29=l9_30;
}
else
{
float l9_31;
if ((2.0*(b.y-0.5))==1.0)
{
l9_31=2.0*(b.y-0.5);
}
else
{
l9_31=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_29=l9_31;
}
float l9_32=l9_29;
float l9_33;
if (b.z<0.5)
{
float l9_34;
if ((2.0*b.z)==0.0)
{
l9_34=2.0*b.z;
}
else
{
l9_34=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_33=l9_34;
}
else
{
float l9_35;
if ((2.0*(b.z-0.5))==1.0)
{
l9_35=2.0*(b.z-0.5);
}
else
{
l9_35=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_33=l9_35;
}
return float3(l9_28,l9_32,l9_33);
}
else
{
if ((int(BLEND_MODE_PIN_LIGHT_tmp)!=0))
{
float l9_36;
if (b.x<0.5)
{
l9_36=fast::min(a.x,2.0*b.x);
}
else
{
l9_36=fast::max(a.x,2.0*(b.x-0.5));
}
float l9_37=l9_36;
float l9_38;
if (b.y<0.5)
{
l9_38=fast::min(a.y,2.0*b.y);
}
else
{
l9_38=fast::max(a.y,2.0*(b.y-0.5));
}
float l9_39=l9_38;
float l9_40;
if (b.z<0.5)
{
l9_40=fast::min(a.z,2.0*b.z);
}
else
{
l9_40=fast::max(a.z,2.0*(b.z-0.5));
}
return float3(l9_37,l9_39,l9_40);
}
else
{
if ((int(BLEND_MODE_HARD_MIX_tmp)!=0))
{
float l9_41;
if (b.x<0.5)
{
float l9_42;
if ((2.0*b.x)==0.0)
{
l9_42=2.0*b.x;
}
else
{
l9_42=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_41=l9_42;
}
else
{
float l9_43;
if ((2.0*(b.x-0.5))==1.0)
{
l9_43=2.0*(b.x-0.5);
}
else
{
l9_43=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_41=l9_43;
}
float l9_44=l9_41;
float l9_45;
if (b.y<0.5)
{
float l9_46;
if ((2.0*b.y)==0.0)
{
l9_46=2.0*b.y;
}
else
{
l9_46=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_45=l9_46;
}
else
{
float l9_47;
if ((2.0*(b.y-0.5))==1.0)
{
l9_47=2.0*(b.y-0.5);
}
else
{
l9_47=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_45=l9_47;
}
float l9_48=l9_45;
float l9_49;
if (b.z<0.5)
{
float l9_50;
if ((2.0*b.z)==0.0)
{
l9_50=2.0*b.z;
}
else
{
l9_50=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_49=l9_50;
}
else
{
float l9_51;
if ((2.0*(b.z-0.5))==1.0)
{
l9_51=2.0*(b.z-0.5);
}
else
{
l9_51=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_49=l9_51;
}
return float3((l9_44<0.5) ? 0.0 : 1.0,(l9_48<0.5) ? 0.0 : 1.0,(l9_49<0.5) ? 0.0 : 1.0);
}
else
{
if ((int(BLEND_MODE_HARD_REFLECT_tmp)!=0))
{
float l9_52;
if (b.x==1.0)
{
l9_52=b.x;
}
else
{
l9_52=fast::min((a.x*a.x)/(1.0-b.x),1.0);
}
float l9_53=l9_52;
float l9_54;
if (b.y==1.0)
{
l9_54=b.y;
}
else
{
l9_54=fast::min((a.y*a.y)/(1.0-b.y),1.0);
}
float l9_55=l9_54;
float l9_56;
if (b.z==1.0)
{
l9_56=b.z;
}
else
{
l9_56=fast::min((a.z*a.z)/(1.0-b.z),1.0);
}
return float3(l9_53,l9_55,l9_56);
}
else
{
if ((int(BLEND_MODE_HARD_GLOW_tmp)!=0))
{
float l9_57;
if (a.x==1.0)
{
l9_57=a.x;
}
else
{
l9_57=fast::min((b.x*b.x)/(1.0-a.x),1.0);
}
float l9_58=l9_57;
float l9_59;
if (a.y==1.0)
{
l9_59=a.y;
}
else
{
l9_59=fast::min((b.y*b.y)/(1.0-a.y),1.0);
}
float l9_60=l9_59;
float l9_61;
if (a.z==1.0)
{
l9_61=a.z;
}
else
{
l9_61=fast::min((b.z*b.z)/(1.0-a.z),1.0);
}
return float3(l9_58,l9_60,l9_61);
}
else
{
if ((int(BLEND_MODE_HARD_PHOENIX_tmp)!=0))
{
return (fast::min(a,b)-fast::max(a,b))+float3(1.0);
}
else
{
if ((int(BLEND_MODE_HUE_tmp)!=0))
{
float3 param=a;
float3 param_1=b;
float3 l9_62=param;
float3 l9_63=l9_62;
float4 l9_64;
if (l9_63.y<l9_63.z)
{
l9_64=float4(l9_63.zy,-1.0,0.66666669);
}
else
{
l9_64=float4(l9_63.yz,0.0,-0.33333334);
}
float4 l9_65=l9_64;
float4 l9_66;
if (l9_63.x<l9_65.x)
{
l9_66=float4(l9_65.xyw,l9_63.x);
}
else
{
l9_66=float4(l9_63.x,l9_65.yzx);
}
float4 l9_67=l9_66;
float l9_68=l9_67.x-fast::min(l9_67.w,l9_67.y);
float l9_69=abs(((l9_67.w-l9_67.y)/((6.0*l9_68)+1e-07))+l9_67.z);
float l9_70=l9_67.x;
float3 l9_71=float3(l9_69,l9_68,l9_70);
float3 l9_72=l9_71;
float l9_73=l9_72.z-(l9_72.y*0.5);
float l9_74=l9_72.y/((1.0-abs((2.0*l9_73)-1.0))+1e-07);
float3 l9_75=float3(l9_72.x,l9_74,l9_73);
float3 l9_76=l9_75;
float3 l9_77=param_1;
float3 l9_78=l9_77;
float4 l9_79;
if (l9_78.y<l9_78.z)
{
l9_79=float4(l9_78.zy,-1.0,0.66666669);
}
else
{
l9_79=float4(l9_78.yz,0.0,-0.33333334);
}
float4 l9_80=l9_79;
float4 l9_81;
if (l9_78.x<l9_80.x)
{
l9_81=float4(l9_80.xyw,l9_78.x);
}
else
{
l9_81=float4(l9_78.x,l9_80.yzx);
}
float4 l9_82=l9_81;
float l9_83=l9_82.x-fast::min(l9_82.w,l9_82.y);
float l9_84=abs(((l9_82.w-l9_82.y)/((6.0*l9_83)+1e-07))+l9_82.z);
float l9_85=l9_82.x;
float3 l9_86=float3(l9_84,l9_83,l9_85);
float3 l9_87=l9_86;
float l9_88=l9_87.z-(l9_87.y*0.5);
float l9_89=l9_87.y/((1.0-abs((2.0*l9_88)-1.0))+1e-07);
float3 l9_90=float3(l9_87.x,l9_89,l9_88);
float3 l9_91=float3(l9_90.x,l9_76.y,l9_76.z);
float l9_92=l9_91.x;
float l9_93=abs((6.0*l9_92)-3.0)-1.0;
float l9_94=2.0-abs((6.0*l9_92)-2.0);
float l9_95=2.0-abs((6.0*l9_92)-4.0);
float3 l9_96=fast::clamp(float3(l9_93,l9_94,l9_95),float3(0.0),float3(1.0));
float3 l9_97=l9_96;
float l9_98=(1.0-abs((2.0*l9_91.z)-1.0))*l9_91.y;
l9_97=((l9_97-float3(0.5))*l9_98)+float3(l9_91.z);
float3 l9_99=l9_97;
float3 l9_100=l9_99;
return l9_100;
}
else
{
if ((int(BLEND_MODE_SATURATION_tmp)!=0))
{
float3 param_2=a;
float3 param_3=b;
float3 l9_101=param_2;
float3 l9_102=l9_101;
float4 l9_103;
if (l9_102.y<l9_102.z)
{
l9_103=float4(l9_102.zy,-1.0,0.66666669);
}
else
{
l9_103=float4(l9_102.yz,0.0,-0.33333334);
}
float4 l9_104=l9_103;
float4 l9_105;
if (l9_102.x<l9_104.x)
{
l9_105=float4(l9_104.xyw,l9_102.x);
}
else
{
l9_105=float4(l9_102.x,l9_104.yzx);
}
float4 l9_106=l9_105;
float l9_107=l9_106.x-fast::min(l9_106.w,l9_106.y);
float l9_108=abs(((l9_106.w-l9_106.y)/((6.0*l9_107)+1e-07))+l9_106.z);
float l9_109=l9_106.x;
float3 l9_110=float3(l9_108,l9_107,l9_109);
float3 l9_111=l9_110;
float l9_112=l9_111.z-(l9_111.y*0.5);
float l9_113=l9_111.y/((1.0-abs((2.0*l9_112)-1.0))+1e-07);
float3 l9_114=float3(l9_111.x,l9_113,l9_112);
float3 l9_115=l9_114;
float l9_116=l9_115.x;
float3 l9_117=param_3;
float3 l9_118=l9_117;
float4 l9_119;
if (l9_118.y<l9_118.z)
{
l9_119=float4(l9_118.zy,-1.0,0.66666669);
}
else
{
l9_119=float4(l9_118.yz,0.0,-0.33333334);
}
float4 l9_120=l9_119;
float4 l9_121;
if (l9_118.x<l9_120.x)
{
l9_121=float4(l9_120.xyw,l9_118.x);
}
else
{
l9_121=float4(l9_118.x,l9_120.yzx);
}
float4 l9_122=l9_121;
float l9_123=l9_122.x-fast::min(l9_122.w,l9_122.y);
float l9_124=abs(((l9_122.w-l9_122.y)/((6.0*l9_123)+1e-07))+l9_122.z);
float l9_125=l9_122.x;
float3 l9_126=float3(l9_124,l9_123,l9_125);
float3 l9_127=l9_126;
float l9_128=l9_127.z-(l9_127.y*0.5);
float l9_129=l9_127.y/((1.0-abs((2.0*l9_128)-1.0))+1e-07);
float3 l9_130=float3(l9_127.x,l9_129,l9_128);
float3 l9_131=float3(l9_116,l9_130.y,l9_115.z);
float l9_132=l9_131.x;
float l9_133=abs((6.0*l9_132)-3.0)-1.0;
float l9_134=2.0-abs((6.0*l9_132)-2.0);
float l9_135=2.0-abs((6.0*l9_132)-4.0);
float3 l9_136=fast::clamp(float3(l9_133,l9_134,l9_135),float3(0.0),float3(1.0));
float3 l9_137=l9_136;
float l9_138=(1.0-abs((2.0*l9_131.z)-1.0))*l9_131.y;
l9_137=((l9_137-float3(0.5))*l9_138)+float3(l9_131.z);
float3 l9_139=l9_137;
float3 l9_140=l9_139;
return l9_140;
}
else
{
if ((int(BLEND_MODE_COLOR_tmp)!=0))
{
float3 param_4=a;
float3 param_5=b;
float3 l9_141=param_5;
float3 l9_142=l9_141;
float4 l9_143;
if (l9_142.y<l9_142.z)
{
l9_143=float4(l9_142.zy,-1.0,0.66666669);
}
else
{
l9_143=float4(l9_142.yz,0.0,-0.33333334);
}
float4 l9_144=l9_143;
float4 l9_145;
if (l9_142.x<l9_144.x)
{
l9_145=float4(l9_144.xyw,l9_142.x);
}
else
{
l9_145=float4(l9_142.x,l9_144.yzx);
}
float4 l9_146=l9_145;
float l9_147=l9_146.x-fast::min(l9_146.w,l9_146.y);
float l9_148=abs(((l9_146.w-l9_146.y)/((6.0*l9_147)+1e-07))+l9_146.z);
float l9_149=l9_146.x;
float3 l9_150=float3(l9_148,l9_147,l9_149);
float3 l9_151=l9_150;
float l9_152=l9_151.z-(l9_151.y*0.5);
float l9_153=l9_151.y/((1.0-abs((2.0*l9_152)-1.0))+1e-07);
float3 l9_154=float3(l9_151.x,l9_153,l9_152);
float3 l9_155=l9_154;
float l9_156=l9_155.x;
float l9_157=l9_155.y;
float3 l9_158=param_4;
float3 l9_159=l9_158;
float4 l9_160;
if (l9_159.y<l9_159.z)
{
l9_160=float4(l9_159.zy,-1.0,0.66666669);
}
else
{
l9_160=float4(l9_159.yz,0.0,-0.33333334);
}
float4 l9_161=l9_160;
float4 l9_162;
if (l9_159.x<l9_161.x)
{
l9_162=float4(l9_161.xyw,l9_159.x);
}
else
{
l9_162=float4(l9_159.x,l9_161.yzx);
}
float4 l9_163=l9_162;
float l9_164=l9_163.x-fast::min(l9_163.w,l9_163.y);
float l9_165=abs(((l9_163.w-l9_163.y)/((6.0*l9_164)+1e-07))+l9_163.z);
float l9_166=l9_163.x;
float3 l9_167=float3(l9_165,l9_164,l9_166);
float3 l9_168=l9_167;
float l9_169=l9_168.z-(l9_168.y*0.5);
float l9_170=l9_168.y/((1.0-abs((2.0*l9_169)-1.0))+1e-07);
float3 l9_171=float3(l9_168.x,l9_170,l9_169);
float3 l9_172=float3(l9_156,l9_157,l9_171.z);
float l9_173=l9_172.x;
float l9_174=abs((6.0*l9_173)-3.0)-1.0;
float l9_175=2.0-abs((6.0*l9_173)-2.0);
float l9_176=2.0-abs((6.0*l9_173)-4.0);
float3 l9_177=fast::clamp(float3(l9_174,l9_175,l9_176),float3(0.0),float3(1.0));
float3 l9_178=l9_177;
float l9_179=(1.0-abs((2.0*l9_172.z)-1.0))*l9_172.y;
l9_178=((l9_178-float3(0.5))*l9_179)+float3(l9_172.z);
float3 l9_180=l9_178;
float3 l9_181=l9_180;
return l9_181;
}
else
{
if ((int(BLEND_MODE_LUMINOSITY_tmp)!=0))
{
float3 param_6=a;
float3 param_7=b;
float3 l9_182=param_6;
float3 l9_183=l9_182;
float4 l9_184;
if (l9_183.y<l9_183.z)
{
l9_184=float4(l9_183.zy,-1.0,0.66666669);
}
else
{
l9_184=float4(l9_183.yz,0.0,-0.33333334);
}
float4 l9_185=l9_184;
float4 l9_186;
if (l9_183.x<l9_185.x)
{
l9_186=float4(l9_185.xyw,l9_183.x);
}
else
{
l9_186=float4(l9_183.x,l9_185.yzx);
}
float4 l9_187=l9_186;
float l9_188=l9_187.x-fast::min(l9_187.w,l9_187.y);
float l9_189=abs(((l9_187.w-l9_187.y)/((6.0*l9_188)+1e-07))+l9_187.z);
float l9_190=l9_187.x;
float3 l9_191=float3(l9_189,l9_188,l9_190);
float3 l9_192=l9_191;
float l9_193=l9_192.z-(l9_192.y*0.5);
float l9_194=l9_192.y/((1.0-abs((2.0*l9_193)-1.0))+1e-07);
float3 l9_195=float3(l9_192.x,l9_194,l9_193);
float3 l9_196=l9_195;
float l9_197=l9_196.x;
float l9_198=l9_196.y;
float3 l9_199=param_7;
float3 l9_200=l9_199;
float4 l9_201;
if (l9_200.y<l9_200.z)
{
l9_201=float4(l9_200.zy,-1.0,0.66666669);
}
else
{
l9_201=float4(l9_200.yz,0.0,-0.33333334);
}
float4 l9_202=l9_201;
float4 l9_203;
if (l9_200.x<l9_202.x)
{
l9_203=float4(l9_202.xyw,l9_200.x);
}
else
{
l9_203=float4(l9_200.x,l9_202.yzx);
}
float4 l9_204=l9_203;
float l9_205=l9_204.x-fast::min(l9_204.w,l9_204.y);
float l9_206=abs(((l9_204.w-l9_204.y)/((6.0*l9_205)+1e-07))+l9_204.z);
float l9_207=l9_204.x;
float3 l9_208=float3(l9_206,l9_205,l9_207);
float3 l9_209=l9_208;
float l9_210=l9_209.z-(l9_209.y*0.5);
float l9_211=l9_209.y/((1.0-abs((2.0*l9_210)-1.0))+1e-07);
float3 l9_212=float3(l9_209.x,l9_211,l9_210);
float3 l9_213=float3(l9_197,l9_198,l9_212.z);
float l9_214=l9_213.x;
float l9_215=abs((6.0*l9_214)-3.0)-1.0;
float l9_216=2.0-abs((6.0*l9_214)-2.0);
float l9_217=2.0-abs((6.0*l9_214)-4.0);
float3 l9_218=fast::clamp(float3(l9_215,l9_216,l9_217),float3(0.0),float3(1.0));
float3 l9_219=l9_218;
float l9_220=(1.0-abs((2.0*l9_213.z)-1.0))*l9_213.y;
l9_219=((l9_219-float3(0.5))*l9_220)+float3(l9_213.z);
float3 l9_221=l9_219;
float3 l9_222=l9_221;
return l9_222;
}
else
{
float3 param_8=a;
float3 param_9=b;
float3 l9_223=param_8;
float l9_224=((0.29899999*l9_223.x)+(0.58700001*l9_223.y))+(0.114*l9_223.z);
float l9_225=l9_224;
float l9_226=1.0;
float l9_227=pow(l9_225,1.0/UserUniforms.correctedIntensity);
int l9_228=0;
if ((int(intensityTextureHasSwappedViews_tmp)!=0))
{
int l9_229=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_229=0;
}
else
{
l9_229=varStereoViewID;
}
int l9_230=l9_229;
l9_228=1-l9_230;
}
else
{
int l9_231=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_231=0;
}
else
{
l9_231=varStereoViewID;
}
int l9_232=l9_231;
l9_228=l9_232;
}
int l9_233=l9_228;
int l9_234=intensityTextureLayout_tmp;
int l9_235=l9_233;
float2 l9_236=float2(l9_227,0.5);
bool l9_237=(int(SC_USE_UV_TRANSFORM_intensityTexture_tmp)!=0);
float3x3 l9_238=UserUniforms.intensityTextureTransform;
int2 l9_239=int2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp);
bool l9_240=(int(SC_USE_UV_MIN_MAX_intensityTexture_tmp)!=0);
float4 l9_241=UserUniforms.intensityTextureUvMinMax;
bool l9_242=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp)!=0);
float4 l9_243=UserUniforms.intensityTextureBorderColor;
float l9_244=0.0;
bool l9_245=l9_242&&(!l9_240);
float l9_246=1.0;
float l9_247=l9_236.x;
int l9_248=l9_239.x;
if (l9_248==1)
{
l9_247=fract(l9_247);
}
else
{
if (l9_248==2)
{
float l9_249=fract(l9_247);
float l9_250=l9_247-l9_249;
float l9_251=step(0.25,fract(l9_250*0.5));
l9_247=mix(l9_249,1.0-l9_249,fast::clamp(l9_251,0.0,1.0));
}
}
l9_236.x=l9_247;
float l9_252=l9_236.y;
int l9_253=l9_239.y;
if (l9_253==1)
{
l9_252=fract(l9_252);
}
else
{
if (l9_253==2)
{
float l9_254=fract(l9_252);
float l9_255=l9_252-l9_254;
float l9_256=step(0.25,fract(l9_255*0.5));
l9_252=mix(l9_254,1.0-l9_254,fast::clamp(l9_256,0.0,1.0));
}
}
l9_236.y=l9_252;
if (l9_240)
{
bool l9_257=l9_242;
bool l9_258;
if (l9_257)
{
l9_258=l9_239.x==3;
}
else
{
l9_258=l9_257;
}
float l9_259=l9_236.x;
float l9_260=l9_241.x;
float l9_261=l9_241.z;
bool l9_262=l9_258;
float l9_263=l9_246;
float l9_264=fast::clamp(l9_259,l9_260,l9_261);
float l9_265=step(abs(l9_259-l9_264),9.9999997e-06);
l9_263*=(l9_265+((1.0-float(l9_262))*(1.0-l9_265)));
l9_259=l9_264;
l9_236.x=l9_259;
l9_246=l9_263;
bool l9_266=l9_242;
bool l9_267;
if (l9_266)
{
l9_267=l9_239.y==3;
}
else
{
l9_267=l9_266;
}
float l9_268=l9_236.y;
float l9_269=l9_241.y;
float l9_270=l9_241.w;
bool l9_271=l9_267;
float l9_272=l9_246;
float l9_273=fast::clamp(l9_268,l9_269,l9_270);
float l9_274=step(abs(l9_268-l9_273),9.9999997e-06);
l9_272*=(l9_274+((1.0-float(l9_271))*(1.0-l9_274)));
l9_268=l9_273;
l9_236.y=l9_268;
l9_246=l9_272;
}
float2 l9_275=l9_236;
bool l9_276=l9_237;
float3x3 l9_277=l9_238;
if (l9_276)
{
l9_275=float2((l9_277*float3(l9_275,1.0)).xy);
}
float2 l9_278=l9_275;
float2 l9_279=l9_278;
float2 l9_280=l9_279;
l9_236=l9_280;
float l9_281=l9_236.x;
int l9_282=l9_239.x;
bool l9_283=l9_245;
float l9_284=l9_246;
if ((l9_282==0)||(l9_282==3))
{
float l9_285=l9_281;
float l9_286=0.0;
float l9_287=1.0;
bool l9_288=l9_283;
float l9_289=l9_284;
float l9_290=fast::clamp(l9_285,l9_286,l9_287);
float l9_291=step(abs(l9_285-l9_290),9.9999997e-06);
l9_289*=(l9_291+((1.0-float(l9_288))*(1.0-l9_291)));
l9_285=l9_290;
l9_281=l9_285;
l9_284=l9_289;
}
l9_236.x=l9_281;
l9_246=l9_284;
float l9_292=l9_236.y;
int l9_293=l9_239.y;
bool l9_294=l9_245;
float l9_295=l9_246;
if ((l9_293==0)||(l9_293==3))
{
float l9_296=l9_292;
float l9_297=0.0;
float l9_298=1.0;
bool l9_299=l9_294;
float l9_300=l9_295;
float l9_301=fast::clamp(l9_296,l9_297,l9_298);
float l9_302=step(abs(l9_296-l9_301),9.9999997e-06);
l9_300*=(l9_302+((1.0-float(l9_299))*(1.0-l9_302)));
l9_296=l9_301;
l9_292=l9_296;
l9_295=l9_300;
}
l9_236.y=l9_292;
l9_246=l9_295;
float2 l9_303=l9_236;
int l9_304=l9_234;
int l9_305=l9_235;
float l9_306=l9_244;
float2 l9_307=l9_303;
int l9_308=l9_304;
int l9_309=l9_305;
float3 l9_310=float3(0.0);
if (l9_308==0)
{
l9_310=float3(l9_307,0.0);
}
else
{
if (l9_308==1)
{
l9_310=float3(l9_307.x,(l9_307.y*0.5)+(0.5-(float(l9_309)*0.5)),0.0);
}
else
{
l9_310=float3(l9_307,float(l9_309));
}
}
float3 l9_311=l9_310;
float3 l9_312=l9_311;
float2 l9_313=l9_312.xy;
float l9_314=l9_306;
float4 l9_315=intensityTexture.sample(intensityTextureSmpSC,l9_313,bias(l9_314));
float4 l9_316=l9_315;
float4 l9_317=l9_316;
if (l9_242)
{
l9_317=mix(l9_243,l9_317,float4(l9_246));
}
float4 l9_318=l9_317;
float3 l9_319=l9_318.xyz;
float3 l9_320=l9_319;
float l9_321=16.0;
float l9_322=((((l9_320.x*256.0)+l9_320.y)+(l9_320.z/256.0))/257.00391)*l9_321;
float l9_323=l9_322;
if ((int(BLEND_MODE_FORGRAY_tmp)!=0))
{
l9_323=fast::max(l9_323,1.0);
}
if ((int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
l9_323=fast::min(l9_323,1.0);
}
float l9_324=l9_225;
float3 l9_325=param_8;
float3 l9_326=param_9;
float l9_327=l9_226;
float l9_328=l9_323;
float3 l9_329=transformColor(l9_324,l9_325,l9_326,l9_327,l9_328);
return l9_329;
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
float4 outputMotionVectorsIfNeeded(thread const float3& surfacePosWorldSpace,thread const float4& finalColor,thread int& varStereoViewID,constant userUniformsObj& UserUniforms)
{
if ((int(sc_MotionVectorsPass_tmp)!=0))
{
float3 param=surfacePosWorldSpace;
int l9_0=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_0=0;
}
else
{
l9_0=varStereoViewID;
}
int l9_1=l9_0;
float4 l9_2=UserUniforms.sc_ViewProjectionMatrixArray[l9_1]*float4(param,1.0);
float2 l9_3=l9_2.xy/float2(l9_2.w);
l9_2=float4(l9_3.x,l9_3.y,l9_2.z,l9_2.w);
int l9_4=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4=0;
}
else
{
l9_4=varStereoViewID;
}
int l9_5=l9_4;
float4 l9_6=((UserUniforms.sc_PrevFrameViewProjectionMatrixArray[l9_5]*UserUniforms.sc_PrevFrameModelMatrix)*UserUniforms.sc_ModelMatrixInverse)*float4(param,1.0);
float2 l9_7=l9_6.xy/float2(l9_6.w);
l9_6=float4(l9_7.x,l9_7.y,l9_6.z,l9_6.w);
float2 l9_8=(l9_2.xy-l9_6.xy)*0.5;
float2 l9_9=l9_8;
float l9_10=(l9_9.x*5.0)+0.5;
float l9_11=floor(l9_10*65535.0);
float l9_12=floor(l9_11*0.00390625);
float2 l9_13=float2(l9_12/255.0,(l9_11-(l9_12*256.0))/255.0);
float l9_14=(l9_9.y*5.0)+0.5;
float l9_15=floor(l9_14*65535.0);
float l9_16=floor(l9_15*0.00390625);
float2 l9_17=float2(l9_16/255.0,(l9_15-(l9_16*256.0))/255.0);
float4 l9_18=float4(l9_13,l9_17);
float4 l9_19=l9_18;
return l9_19;
}
else
{
return finalColor;
}
}
fragment main_frag_out main_frag(main_frag_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]])
{
main_frag_out out={};
if ((int(sc_DepthOnly_tmp)!=0))
{
return out;
}
if ((sc_StereoRenderingMode_tmp==1)&&(sc_StereoRendering_IsClipDistanceEnabled_tmp==0))
{
if (in.varClipDistance<0.0)
{
discard_fragment();
}
}
ssPreviewInfo PreviewInfo;
PreviewInfo.Color=in.PreviewVertexColor;
PreviewInfo.Saved=((in.PreviewVertexSaved*1.0)!=0.0) ? true : false;
float4 FinalColor=float4(1.0);
float l9_0;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_0=(*sc_set2.UserUniforms).overrideTimeElapsed;
}
else
{
l9_0=(*sc_set2.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_0;
float l9_1;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_1=(*sc_set2.UserUniforms).overrideTimeDelta;
}
else
{
l9_1=(*sc_set2.UserUniforms).sc_Time.y;
}
Globals.gTimeDelta=l9_1;
bool l9_2=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_2)
{
float4 l9_3=gl_FragCoord;
int2 l9_4=int2(l9_3.xy);
RayHitPayload l9_5=GetHitData(l9_4,(*sc_set2.UserUniforms),sc_set2.z_rayDirections,sc_set2.z_rayDirectionsSmpSC,sc_set2.z_hitIdAndBarycentric,sc_set2.z_hitIdAndBarycentricSmp,(*sc_set2.layoutVertices),(*sc_set2.layoutVerticesPN),(*sc_set2.layoutIndices));
RayHitPayload rhp=l9_5;
bool l9_6=(*sc_set2.UserUniforms).noEarlyZ!=0;
if (l9_6)
{
if (rhp.id.x!=uint((*sc_set2.UserUniforms).instance_id))
{
return out;
}
}
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=rhp.viewDirWS;
Globals.PositionWS=rhp.positionWS;
Globals.VertexTangent_WorldSpace=rhp.tangentWS.xyz;
Globals.VertexNormal_WorldSpace=rhp.normalWS;
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*rhp.tangentWS.w;
Globals.Surface_UVCoord0=rhp.uv0;
}
else
{
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-in.varPos);
Globals.PositionWS=in.varPos;
Globals.VertexTangent_WorldSpace=normalize(in.varTangent.xyz);
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*in.varTangent.w;
Globals.Surface_UVCoord0=in.varPackedTex.xy;
}
float2 UVCoord_N11=float2(0.0);
UVCoord_N11=Globals.Surface_UVCoord0;
float Output_N0=0.0;
float param=(*sc_set2.UserUniforms).uvScale;
Output_N0=param;
float2 CoordsOut_N16=float2(0.0);
CoordsOut_N16=((UVCoord_N11-(*sc_set2.UserUniforms).Port_Center_N016)*float2(Output_N0))+(*sc_set2.UserUniforms).Port_Center_N016;
float4 Output_N1=float4(0.0);
int l9_7=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_8=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_8=0;
}
else
{
l9_8=in.varStereoViewID;
}
int l9_9=l9_8;
l9_7=1-l9_9;
}
else
{
int l9_10=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_10=0;
}
else
{
l9_10=in.varStereoViewID;
}
int l9_11=l9_10;
l9_7=l9_11;
}
int l9_12=l9_7;
int param_1=baseTexLayout_tmp;
int param_2=l9_12;
float2 param_3=CoordsOut_N16;
bool param_4=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).baseTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool param_7=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 param_8=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 param_10=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_11=0.0;
bool l9_13=param_9&&(!param_7);
float l9_14=1.0;
float l9_15=param_3.x;
int l9_16=param_6.x;
if (l9_16==1)
{
l9_15=fract(l9_15);
}
else
{
if (l9_16==2)
{
float l9_17=fract(l9_15);
float l9_18=l9_15-l9_17;
float l9_19=step(0.25,fract(l9_18*0.5));
l9_15=mix(l9_17,1.0-l9_17,fast::clamp(l9_19,0.0,1.0));
}
}
param_3.x=l9_15;
float l9_20=param_3.y;
int l9_21=param_6.y;
if (l9_21==1)
{
l9_20=fract(l9_20);
}
else
{
if (l9_21==2)
{
float l9_22=fract(l9_20);
float l9_23=l9_20-l9_22;
float l9_24=step(0.25,fract(l9_23*0.5));
l9_20=mix(l9_22,1.0-l9_22,fast::clamp(l9_24,0.0,1.0));
}
}
param_3.y=l9_20;
if (param_7)
{
bool l9_25=param_9;
bool l9_26;
if (l9_25)
{
l9_26=param_6.x==3;
}
else
{
l9_26=l9_25;
}
float l9_27=param_3.x;
float l9_28=param_8.x;
float l9_29=param_8.z;
bool l9_30=l9_26;
float l9_31=l9_14;
float l9_32=fast::clamp(l9_27,l9_28,l9_29);
float l9_33=step(abs(l9_27-l9_32),9.9999997e-06);
l9_31*=(l9_33+((1.0-float(l9_30))*(1.0-l9_33)));
l9_27=l9_32;
param_3.x=l9_27;
l9_14=l9_31;
bool l9_34=param_9;
bool l9_35;
if (l9_34)
{
l9_35=param_6.y==3;
}
else
{
l9_35=l9_34;
}
float l9_36=param_3.y;
float l9_37=param_8.y;
float l9_38=param_8.w;
bool l9_39=l9_35;
float l9_40=l9_14;
float l9_41=fast::clamp(l9_36,l9_37,l9_38);
float l9_42=step(abs(l9_36-l9_41),9.9999997e-06);
l9_40*=(l9_42+((1.0-float(l9_39))*(1.0-l9_42)));
l9_36=l9_41;
param_3.y=l9_36;
l9_14=l9_40;
}
float2 l9_43=param_3;
bool l9_44=param_4;
float3x3 l9_45=param_5;
if (l9_44)
{
l9_43=float2((l9_45*float3(l9_43,1.0)).xy);
}
float2 l9_46=l9_43;
float2 l9_47=l9_46;
float2 l9_48=l9_47;
param_3=l9_48;
float l9_49=param_3.x;
int l9_50=param_6.x;
bool l9_51=l9_13;
float l9_52=l9_14;
if ((l9_50==0)||(l9_50==3))
{
float l9_53=l9_49;
float l9_54=0.0;
float l9_55=1.0;
bool l9_56=l9_51;
float l9_57=l9_52;
float l9_58=fast::clamp(l9_53,l9_54,l9_55);
float l9_59=step(abs(l9_53-l9_58),9.9999997e-06);
l9_57*=(l9_59+((1.0-float(l9_56))*(1.0-l9_59)));
l9_53=l9_58;
l9_49=l9_53;
l9_52=l9_57;
}
param_3.x=l9_49;
l9_14=l9_52;
float l9_60=param_3.y;
int l9_61=param_6.y;
bool l9_62=l9_13;
float l9_63=l9_14;
if ((l9_61==0)||(l9_61==3))
{
float l9_64=l9_60;
float l9_65=0.0;
float l9_66=1.0;
bool l9_67=l9_62;
float l9_68=l9_63;
float l9_69=fast::clamp(l9_64,l9_65,l9_66);
float l9_70=step(abs(l9_64-l9_69),9.9999997e-06);
l9_68*=(l9_70+((1.0-float(l9_67))*(1.0-l9_70)));
l9_64=l9_69;
l9_60=l9_64;
l9_63=l9_68;
}
param_3.y=l9_60;
l9_14=l9_63;
float2 l9_71=param_3;
int l9_72=param_1;
int l9_73=param_2;
float l9_74=param_11;
float2 l9_75=l9_71;
int l9_76=l9_72;
int l9_77=l9_73;
float3 l9_78=float3(0.0);
if (l9_76==0)
{
l9_78=float3(l9_75,0.0);
}
else
{
if (l9_76==1)
{
l9_78=float3(l9_75.x,(l9_75.y*0.5)+(0.5-(float(l9_77)*0.5)),0.0);
}
else
{
l9_78=float3(l9_75,float(l9_77));
}
}
float3 l9_79=l9_78;
float3 l9_80=l9_79;
float2 l9_81=l9_80.xy;
float l9_82=l9_74;
float4 l9_83=sc_set2.baseTex.sample(sc_set2.baseTexSmpSC,l9_81,bias(l9_82));
float4 l9_84=l9_83;
float4 l9_85=l9_84;
if (param_9)
{
l9_85=mix(param_10,l9_85,float4(l9_14));
}
float4 l9_86=l9_85;
Output_N1=l9_86;
float Output_N5=0.0;
Output_N5=Output_N1.w;
float4 Output_N9=float4(0.0);
float2 param_12=CoordsOut_N16;
int l9_87=0;
if ((int(normalTexHasSwappedViews_tmp)!=0))
{
int l9_88=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_88=0;
}
else
{
l9_88=in.varStereoViewID;
}
int l9_89=l9_88;
l9_87=1-l9_89;
}
else
{
int l9_90=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_90=0;
}
else
{
l9_90=in.varStereoViewID;
}
int l9_91=l9_90;
l9_87=l9_91;
}
int l9_92=l9_87;
int l9_93=normalTexLayout_tmp;
int l9_94=l9_92;
float2 l9_95=param_12;
bool l9_96=(int(SC_USE_UV_TRANSFORM_normalTex_tmp)!=0);
float3x3 l9_97=(*sc_set2.UserUniforms).normalTexTransform;
int2 l9_98=int2(SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp);
bool l9_99=(int(SC_USE_UV_MIN_MAX_normalTex_tmp)!=0);
float4 l9_100=(*sc_set2.UserUniforms).normalTexUvMinMax;
bool l9_101=(int(SC_USE_CLAMP_TO_BORDER_normalTex_tmp)!=0);
float4 l9_102=(*sc_set2.UserUniforms).normalTexBorderColor;
float l9_103=0.0;
bool l9_104=l9_101&&(!l9_99);
float l9_105=1.0;
float l9_106=l9_95.x;
int l9_107=l9_98.x;
if (l9_107==1)
{
l9_106=fract(l9_106);
}
else
{
if (l9_107==2)
{
float l9_108=fract(l9_106);
float l9_109=l9_106-l9_108;
float l9_110=step(0.25,fract(l9_109*0.5));
l9_106=mix(l9_108,1.0-l9_108,fast::clamp(l9_110,0.0,1.0));
}
}
l9_95.x=l9_106;
float l9_111=l9_95.y;
int l9_112=l9_98.y;
if (l9_112==1)
{
l9_111=fract(l9_111);
}
else
{
if (l9_112==2)
{
float l9_113=fract(l9_111);
float l9_114=l9_111-l9_113;
float l9_115=step(0.25,fract(l9_114*0.5));
l9_111=mix(l9_113,1.0-l9_113,fast::clamp(l9_115,0.0,1.0));
}
}
l9_95.y=l9_111;
if (l9_99)
{
bool l9_116=l9_101;
bool l9_117;
if (l9_116)
{
l9_117=l9_98.x==3;
}
else
{
l9_117=l9_116;
}
float l9_118=l9_95.x;
float l9_119=l9_100.x;
float l9_120=l9_100.z;
bool l9_121=l9_117;
float l9_122=l9_105;
float l9_123=fast::clamp(l9_118,l9_119,l9_120);
float l9_124=step(abs(l9_118-l9_123),9.9999997e-06);
l9_122*=(l9_124+((1.0-float(l9_121))*(1.0-l9_124)));
l9_118=l9_123;
l9_95.x=l9_118;
l9_105=l9_122;
bool l9_125=l9_101;
bool l9_126;
if (l9_125)
{
l9_126=l9_98.y==3;
}
else
{
l9_126=l9_125;
}
float l9_127=l9_95.y;
float l9_128=l9_100.y;
float l9_129=l9_100.w;
bool l9_130=l9_126;
float l9_131=l9_105;
float l9_132=fast::clamp(l9_127,l9_128,l9_129);
float l9_133=step(abs(l9_127-l9_132),9.9999997e-06);
l9_131*=(l9_133+((1.0-float(l9_130))*(1.0-l9_133)));
l9_127=l9_132;
l9_95.y=l9_127;
l9_105=l9_131;
}
float2 l9_134=l9_95;
bool l9_135=l9_96;
float3x3 l9_136=l9_97;
if (l9_135)
{
l9_134=float2((l9_136*float3(l9_134,1.0)).xy);
}
float2 l9_137=l9_134;
float2 l9_138=l9_137;
float2 l9_139=l9_138;
l9_95=l9_139;
float l9_140=l9_95.x;
int l9_141=l9_98.x;
bool l9_142=l9_104;
float l9_143=l9_105;
if ((l9_141==0)||(l9_141==3))
{
float l9_144=l9_140;
float l9_145=0.0;
float l9_146=1.0;
bool l9_147=l9_142;
float l9_148=l9_143;
float l9_149=fast::clamp(l9_144,l9_145,l9_146);
float l9_150=step(abs(l9_144-l9_149),9.9999997e-06);
l9_148*=(l9_150+((1.0-float(l9_147))*(1.0-l9_150)));
l9_144=l9_149;
l9_140=l9_144;
l9_143=l9_148;
}
l9_95.x=l9_140;
l9_105=l9_143;
float l9_151=l9_95.y;
int l9_152=l9_98.y;
bool l9_153=l9_104;
float l9_154=l9_105;
if ((l9_152==0)||(l9_152==3))
{
float l9_155=l9_151;
float l9_156=0.0;
float l9_157=1.0;
bool l9_158=l9_153;
float l9_159=l9_154;
float l9_160=fast::clamp(l9_155,l9_156,l9_157);
float l9_161=step(abs(l9_155-l9_160),9.9999997e-06);
l9_159*=(l9_161+((1.0-float(l9_158))*(1.0-l9_161)));
l9_155=l9_160;
l9_151=l9_155;
l9_154=l9_159;
}
l9_95.y=l9_151;
l9_105=l9_154;
float2 l9_162=l9_95;
int l9_163=l9_93;
int l9_164=l9_94;
float l9_165=l9_103;
float2 l9_166=l9_162;
int l9_167=l9_163;
int l9_168=l9_164;
float3 l9_169=float3(0.0);
if (l9_167==0)
{
l9_169=float3(l9_166,0.0);
}
else
{
if (l9_167==1)
{
l9_169=float3(l9_166.x,(l9_166.y*0.5)+(0.5-(float(l9_168)*0.5)),0.0);
}
else
{
l9_169=float3(l9_166,float(l9_168));
}
}
float3 l9_170=l9_169;
float3 l9_171=l9_170;
float2 l9_172=l9_171.xy;
float l9_173=l9_165;
float4 l9_174=sc_set2.normalTex.sample(sc_set2.normalTexSmpSC,l9_172,bias(l9_173));
float4 l9_175=l9_174;
float4 l9_176=l9_175;
if (l9_101)
{
l9_176=mix(l9_102,l9_176,float4(l9_105));
}
float4 l9_177=l9_176;
float4 param_13=l9_177;
float3 l9_178=(param_13.xyz*1.9921875)-float3(1.0);
param_13=float4(l9_178.x,l9_178.y,l9_178.z,param_13.w);
Output_N9=param_13;
float4 Output_N2=float4(0.0);
int l9_179=0;
if ((int(materialParamsTexHasSwappedViews_tmp)!=0))
{
int l9_180=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_180=0;
}
else
{
l9_180=in.varStereoViewID;
}
int l9_181=l9_180;
l9_179=1-l9_181;
}
else
{
int l9_182=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_182=0;
}
else
{
l9_182=in.varStereoViewID;
}
int l9_183=l9_182;
l9_179=l9_183;
}
int l9_184=l9_179;
int param_14=materialParamsTexLayout_tmp;
int param_15=l9_184;
float2 param_16=CoordsOut_N16;
bool param_17=(int(SC_USE_UV_TRANSFORM_materialParamsTex_tmp)!=0);
float3x3 param_18=(*sc_set2.UserUniforms).materialParamsTexTransform;
int2 param_19=int2(SC_SOFTWARE_WRAP_MODE_U_materialParamsTex_tmp,SC_SOFTWARE_WRAP_MODE_V_materialParamsTex_tmp);
bool param_20=(int(SC_USE_UV_MIN_MAX_materialParamsTex_tmp)!=0);
float4 param_21=(*sc_set2.UserUniforms).materialParamsTexUvMinMax;
bool param_22=(int(SC_USE_CLAMP_TO_BORDER_materialParamsTex_tmp)!=0);
float4 param_23=(*sc_set2.UserUniforms).materialParamsTexBorderColor;
float param_24=0.0;
bool l9_185=param_22&&(!param_20);
float l9_186=1.0;
float l9_187=param_16.x;
int l9_188=param_19.x;
if (l9_188==1)
{
l9_187=fract(l9_187);
}
else
{
if (l9_188==2)
{
float l9_189=fract(l9_187);
float l9_190=l9_187-l9_189;
float l9_191=step(0.25,fract(l9_190*0.5));
l9_187=mix(l9_189,1.0-l9_189,fast::clamp(l9_191,0.0,1.0));
}
}
param_16.x=l9_187;
float l9_192=param_16.y;
int l9_193=param_19.y;
if (l9_193==1)
{
l9_192=fract(l9_192);
}
else
{
if (l9_193==2)
{
float l9_194=fract(l9_192);
float l9_195=l9_192-l9_194;
float l9_196=step(0.25,fract(l9_195*0.5));
l9_192=mix(l9_194,1.0-l9_194,fast::clamp(l9_196,0.0,1.0));
}
}
param_16.y=l9_192;
if (param_20)
{
bool l9_197=param_22;
bool l9_198;
if (l9_197)
{
l9_198=param_19.x==3;
}
else
{
l9_198=l9_197;
}
float l9_199=param_16.x;
float l9_200=param_21.x;
float l9_201=param_21.z;
bool l9_202=l9_198;
float l9_203=l9_186;
float l9_204=fast::clamp(l9_199,l9_200,l9_201);
float l9_205=step(abs(l9_199-l9_204),9.9999997e-06);
l9_203*=(l9_205+((1.0-float(l9_202))*(1.0-l9_205)));
l9_199=l9_204;
param_16.x=l9_199;
l9_186=l9_203;
bool l9_206=param_22;
bool l9_207;
if (l9_206)
{
l9_207=param_19.y==3;
}
else
{
l9_207=l9_206;
}
float l9_208=param_16.y;
float l9_209=param_21.y;
float l9_210=param_21.w;
bool l9_211=l9_207;
float l9_212=l9_186;
float l9_213=fast::clamp(l9_208,l9_209,l9_210);
float l9_214=step(abs(l9_208-l9_213),9.9999997e-06);
l9_212*=(l9_214+((1.0-float(l9_211))*(1.0-l9_214)));
l9_208=l9_213;
param_16.y=l9_208;
l9_186=l9_212;
}
float2 l9_215=param_16;
bool l9_216=param_17;
float3x3 l9_217=param_18;
if (l9_216)
{
l9_215=float2((l9_217*float3(l9_215,1.0)).xy);
}
float2 l9_218=l9_215;
float2 l9_219=l9_218;
float2 l9_220=l9_219;
param_16=l9_220;
float l9_221=param_16.x;
int l9_222=param_19.x;
bool l9_223=l9_185;
float l9_224=l9_186;
if ((l9_222==0)||(l9_222==3))
{
float l9_225=l9_221;
float l9_226=0.0;
float l9_227=1.0;
bool l9_228=l9_223;
float l9_229=l9_224;
float l9_230=fast::clamp(l9_225,l9_226,l9_227);
float l9_231=step(abs(l9_225-l9_230),9.9999997e-06);
l9_229*=(l9_231+((1.0-float(l9_228))*(1.0-l9_231)));
l9_225=l9_230;
l9_221=l9_225;
l9_224=l9_229;
}
param_16.x=l9_221;
l9_186=l9_224;
float l9_232=param_16.y;
int l9_233=param_19.y;
bool l9_234=l9_185;
float l9_235=l9_186;
if ((l9_233==0)||(l9_233==3))
{
float l9_236=l9_232;
float l9_237=0.0;
float l9_238=1.0;
bool l9_239=l9_234;
float l9_240=l9_235;
float l9_241=fast::clamp(l9_236,l9_237,l9_238);
float l9_242=step(abs(l9_236-l9_241),9.9999997e-06);
l9_240*=(l9_242+((1.0-float(l9_239))*(1.0-l9_242)));
l9_236=l9_241;
l9_232=l9_236;
l9_235=l9_240;
}
param_16.y=l9_232;
l9_186=l9_235;
float2 l9_243=param_16;
int l9_244=param_14;
int l9_245=param_15;
float l9_246=param_24;
float2 l9_247=l9_243;
int l9_248=l9_244;
int l9_249=l9_245;
float3 l9_250=float3(0.0);
if (l9_248==0)
{
l9_250=float3(l9_247,0.0);
}
else
{
if (l9_248==1)
{
l9_250=float3(l9_247.x,(l9_247.y*0.5)+(0.5-(float(l9_249)*0.5)),0.0);
}
else
{
l9_250=float3(l9_247,float(l9_249));
}
}
float3 l9_251=l9_250;
float3 l9_252=l9_251;
float2 l9_253=l9_252.xy;
float l9_254=l9_246;
float4 l9_255=sc_set2.materialParamsTex.sample(sc_set2.materialParamsTexSmpSC,l9_253,bias(l9_254));
float4 l9_256=l9_255;
float4 l9_257=l9_256;
if (param_22)
{
l9_257=mix(param_23,l9_257,float4(l9_186));
}
float4 l9_258=l9_257;
Output_N2=l9_258;
float Value1_N3=0.0;
float Value2_N3=0.0;
float Value3_N3=0.0;
float4 param_25=Output_N2;
float param_26=param_25.x;
float param_27=param_25.y;
float param_28=param_25.z;
Value1_N3=param_26;
Value2_N3=param_27;
Value3_N3=param_28;
float4 Output_N6=float4(0.0);
float3 param_29=Output_N1.xyz;
float param_30=Output_N5;
float3 param_31=Output_N9.xyz;
float3 param_32=(*sc_set2.UserUniforms).Port_Emissive_N006;
float param_33=Value1_N3;
float param_34=Value2_N3;
float3 param_35=float3(Value3_N3);
float3 param_36=(*sc_set2.UserUniforms).Port_SpecularAO_N006;
ssGlobals param_38=Globals;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
param_38.BumpedNormal=float3x3(float3(param_38.VertexTangent_WorldSpace),float3(param_38.VertexBinormal_WorldSpace),float3(param_38.VertexNormal_WorldSpace))*param_31;
}
param_30=fast::clamp(param_30,0.0,1.0);
float l9_259=param_30;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_259<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_260=gl_FragCoord;
float2 l9_261=floor(mod(l9_260.xy,float2(4.0)));
float l9_262=(mod(dot(l9_261,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_259<l9_262)
{
discard_fragment();
}
}
param_29=fast::max(param_29,float3(0.0));
float4 param_37;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
param_37=float4(param_29,param_30);
}
else
{
param_33=fast::clamp(param_33,0.0,1.0);
param_34=fast::clamp(param_34,0.0,1.0);
param_35=fast::clamp(param_35,float3(0.0),float3(1.0));
float3 l9_263=param_29;
float l9_264=param_30;
float3 l9_265=param_38.BumpedNormal;
float3 l9_266=param_38.PositionWS;
float3 l9_267=param_38.ViewDirWS;
float3 l9_268=param_32;
float l9_269=param_33;
float l9_270=param_34;
float3 l9_271=param_35;
float3 l9_272=param_36;
param_37=ngsCalculateLighting(l9_263,l9_264,l9_265,l9_266,l9_267,l9_268,l9_269,l9_270,l9_271,l9_272,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_EnvmapDiffuse,sc_set2.sc_EnvmapDiffuseSmpSC,sc_set2.sc_EnvmapSpecular,sc_set2.sc_EnvmapSpecularSmpSC,sc_set2.sc_ScreenTexture,sc_set2.sc_ScreenTextureSmpSC,sc_set2.sc_ShadowTexture,sc_set2.sc_ShadowTextureSmpSC,sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC,sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,sc_set2.sc_RayTracedShadowTexture,sc_set2.sc_RayTracedShadowTextureSmpSC,sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord,in.varShadowTex,out.FragColor0);
}
param_37=fast::max(param_37,float4(0.0));
Output_N6=param_37;
FinalColor=Output_N6;
bool l9_273=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_273)
{
float4 param_39=FinalColor;
if ((int(sc_ProxyAlphaOne_tmp)!=0))
{
param_39.w=1.0;
}
float4 l9_274=fast::max(param_39,float4(0.0));
float4 param_40=l9_274;
out.FragColor0=param_40;
return out;
}
float4 param_41=FinalColor;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_275=param_41;
float4 l9_276=l9_275;
float l9_277=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_277=l9_276.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_277=fast::clamp(l9_276.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_277=fast::clamp(dot(l9_276.xyz,float3(l9_276.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_277=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_277=(1.0-dot(l9_276.xyz,float3(0.33333001)))*l9_276.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_277=(1.0-fast::clamp(dot(l9_276.xyz,float3(1.0)),0.0,1.0))*l9_276.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_277=fast::clamp(dot(l9_276.xyz,float3(1.0)),0.0,1.0)*l9_276.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_277=fast::clamp(dot(l9_276.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_277=fast::clamp(dot(l9_276.xyz,float3(1.0)),0.0,1.0)*l9_276.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_277=dot(l9_276.xyz,float3(0.33333001))*l9_276.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_277=1.0-fast::clamp(dot(l9_276.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_277=fast::clamp(dot(l9_276.xyz,float3(1.0)),0.0,1.0);
}
}
}
}
}
}
}
}
}
}
}
}
float l9_278=l9_277;
float l9_279=l9_278;
float l9_280=(*sc_set2.UserUniforms).sc_ShadowDensity*l9_279;
float3 l9_281=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_275.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float4 l9_282=float4(l9_281.x,l9_281.y,l9_281.z,l9_280);
param_41=l9_282;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_41=float4(param_41.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_283=param_41;
float4 l9_284=float4(0.0);
float4 l9_285=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_286=out.FragColor0;
float4 l9_287=l9_286;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_287.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_288=l9_287;
l9_285=l9_288;
}
else
{
float4 l9_289=gl_FragCoord;
float2 l9_290=(l9_289.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_291=l9_290;
float2 l9_292=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_293=1;
int l9_294=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_294=0;
}
else
{
l9_294=in.varStereoViewID;
}
int l9_295=l9_294;
int l9_296=l9_295;
float3 l9_297=float3(l9_291,0.0);
int l9_298=l9_293;
int l9_299=l9_296;
if (l9_298==1)
{
l9_297.y=((2.0*l9_297.y)+float(l9_299))-1.0;
}
float2 l9_300=l9_297.xy;
l9_292=l9_300;
}
else
{
l9_292=l9_291;
}
float2 l9_301=l9_292;
float2 l9_302=l9_301;
float2 l9_303=l9_302;
int l9_304=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_305=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_305=0;
}
else
{
l9_305=in.varStereoViewID;
}
int l9_306=l9_305;
l9_304=1-l9_306;
}
else
{
int l9_307=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_307=0;
}
else
{
l9_307=in.varStereoViewID;
}
int l9_308=l9_307;
l9_304=l9_308;
}
int l9_309=l9_304;
float2 l9_310=l9_303;
int l9_311=l9_309;
float2 l9_312=l9_310;
int l9_313=l9_311;
float l9_314=0.0;
float4 l9_315=float4(0.0);
float2 l9_316=l9_312;
int l9_317=sc_ScreenTextureLayout_tmp;
int l9_318=l9_313;
float l9_319=l9_314;
float2 l9_320=l9_316;
int l9_321=l9_317;
int l9_322=l9_318;
float3 l9_323=float3(0.0);
if (l9_321==0)
{
l9_323=float3(l9_320,0.0);
}
else
{
if (l9_321==1)
{
l9_323=float3(l9_320.x,(l9_320.y*0.5)+(0.5-(float(l9_322)*0.5)),0.0);
}
else
{
l9_323=float3(l9_320,float(l9_322));
}
}
float3 l9_324=l9_323;
float3 l9_325=l9_324;
float2 l9_326=l9_325.xy;
float l9_327=l9_319;
float4 l9_328=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_326,bias(l9_327));
float4 l9_329=l9_328;
l9_315=l9_329;
float4 l9_330=l9_315;
float4 l9_331=l9_330;
float4 l9_332=l9_331;
l9_285=l9_332;
}
float4 l9_333=l9_285;
float4 l9_334=l9_333;
float3 l9_335=l9_334.xyz;
float3 l9_336=l9_335;
float3 l9_337=l9_283.xyz;
float3 l9_338=definedBlend(l9_336,l9_337,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.intensityTexture,sc_set2.intensityTextureSmpSC);
l9_284=float4(l9_338.x,l9_338.y,l9_338.z,l9_284.w);
float3 l9_339=mix(l9_335,l9_284.xyz,float3(l9_283.w));
l9_284=float4(l9_339.x,l9_339.y,l9_339.z,l9_284.w);
l9_284.w=1.0;
float4 l9_340=l9_284;
param_41=l9_340;
}
else
{
float4 l9_341=param_41;
float4 l9_342=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_342=float4(mix(float3(1.0),l9_341.xyz,float3(l9_341.w)),l9_341.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_343=l9_341.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_343=fast::clamp(l9_343,0.0,1.0);
}
l9_342=float4(l9_341.xyz*l9_343,l9_343);
}
else
{
l9_342=l9_341;
}
}
float4 l9_344=l9_342;
param_41=l9_344;
}
}
}
float4 l9_345=param_41;
FinalColor=l9_345;
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
if (PreviewInfo.Saved)
{
FinalColor=float4(PreviewInfo.Color);
}
else
{
FinalColor=float4(0.0);
}
}
float4 l9_346=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_346=float4((*sc_set2.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_346=float4(0.0);
}
float4 l9_347=l9_346;
float4 Cost=l9_347;
if (Cost.w>0.0)
{
FinalColor=Cost;
}
FinalColor=fast::max(FinalColor,float4(0.0));
float3 param_42=in.varPos;
float4 param_43=FinalColor;
FinalColor=outputMotionVectorsIfNeeded(param_42,param_43,in.varStereoViewID,(*sc_set2.UserUniforms));
float4 param_44=FinalColor;
float4 l9_348=param_44;
out.FragColor0=l9_348;
return out;
}
} // FRAGMENT SHADER

namespace SNAP_RECV {
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float3 BumpedNormal;
float3 ViewDirWS;
float3 PositionWS;
float3 VertexTangent_WorldSpace;
float3 VertexNormal_WorldSpace;
float3 VertexBinormal_WorldSpace;
float2 Surface_UVCoord0;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[3];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
int receivesRayTracedReflections;
int isProxyMode;
int receivesRayTracedShadows;
int receivesRayTracedDiffuseIndirect;
int receivesRayTracedAo;
float4 sc_RayTracedReflectionTextureSize;
float4 sc_RayTracedReflectionTextureDims;
float4 sc_RayTracedReflectionTextureView;
float4 sc_RayTracedShadowTextureSize;
float4 sc_RayTracedShadowTextureDims;
float4 sc_RayTracedShadowTextureView;
float4 sc_RayTracedDiffIndTextureSize;
float4 sc_RayTracedDiffIndTextureDims;
float4 sc_RayTracedDiffIndTextureView;
float4 sc_RayTracedAoTextureSize;
float4 sc_RayTracedAoTextureDims;
float4 sc_RayTracedAoTextureView;
float receiver_mask;
float3 OriginNormalizationScale;
float3 OriginNormalizationScaleInv;
float3 OriginNormalizationOffset;
int receiverId;
int instance_id;
int lray_triangles_last;
int noEarlyZ;
int has_animated_pn;
int emitter_stride;
int proxy_offset_position;
int proxy_offset_normal;
int proxy_offset_tangent;
int proxy_offset_color;
int proxy_offset_texture0;
int proxy_offset_texture1;
int proxy_offset_texture2;
int proxy_offset_texture3;
int proxy_format_position;
int proxy_format_normal;
int proxy_format_tangent;
int proxy_format_color;
int proxy_format_texture0;
int proxy_format_texture1;
int proxy_format_texture2;
int proxy_format_texture3;
float4 z_rayDirectionsSize;
float4 z_rayDirectionsDims;
float4 z_rayDirectionsView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int PreviewEnabled;
int PreviewNodeID;
float alphaTestThreshold;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float uvScale;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float4 materialParamsTexSize;
float4 materialParamsTexDims;
float4 materialParamsTexView;
float3x3 materialParamsTexTransform;
float4 materialParamsTexUvMinMax;
float4 materialParamsTexBorderColor;
float2 Port_Center_N016;
float3 Port_Emissive_N006;
float3 Port_SpecularAO_N006;
float depthRef;
};
struct sc_Bone_t
{
float4 boneMatrix[3];
float4 normalMatrix[3];
};
struct sc_Bones_obj
{
sc_Bone_t sc_Bones[1];
};
struct layoutIndices_obj
{
uint _Triangles[1];
};
struct layoutVertices_obj
{
float _Vertices[1];
};
struct layoutVerticesPN_obj
{
float _VerticesPN[1];
};
struct sc_Set2
{
const device layoutIndices_obj* layoutIndices [[id(0)]];
const device layoutVertices_obj* layoutVertices [[id(1)]];
const device layoutVerticesPN_obj* layoutVerticesPN [[id(2)]];
constant sc_Bones_obj* sc_BonesUBO [[id(3)]];
texture2d<float> baseTex [[id(4)]];
texture2d<float> intensityTexture [[id(5)]];
texture2d<float> materialParamsTex [[id(6)]];
texture2d<float> normalTex [[id(7)]];
texture2d<float> sc_EnvmapDiffuse [[id(8)]];
texture2d<float> sc_EnvmapSpecular [[id(9)]];
texture2d<float> sc_RayTracedAoTexture [[id(18)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(19)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(20)]];
texture2d<float> sc_RayTracedShadowTexture [[id(21)]];
texture2d<float> sc_SSAOTexture [[id(22)]];
texture2d<float> sc_ScreenTexture [[id(23)]];
texture2d<float> sc_ShadowTexture [[id(24)]];
texture2d<uint> z_hitIdAndBarycentric [[id(26)]];
texture2d<float> z_rayDirections [[id(27)]];
sampler baseTexSmpSC [[id(28)]];
sampler intensityTextureSmpSC [[id(29)]];
sampler materialParamsTexSmpSC [[id(30)]];
sampler normalTexSmpSC [[id(31)]];
sampler sc_EnvmapDiffuseSmpSC [[id(32)]];
sampler sc_EnvmapSpecularSmpSC [[id(33)]];
sampler sc_RayTracedAoTextureSmpSC [[id(35)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(36)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(37)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(38)]];
sampler sc_SSAOTextureSmpSC [[id(39)]];
sampler sc_ScreenTextureSmpSC [[id(40)]];
sampler sc_ShadowTextureSmpSC [[id(41)]];
sampler z_hitIdAndBarycentricSmp [[id(43)]];
sampler z_rayDirectionsSmpSC [[id(44)]];
constant userUniformsObj* UserUniforms [[id(45)]];
};
struct main_recv_out
{
uint4 position_and_mask [[color(0)]];
uint4 normal_and_more [[color(1)]];
};
struct main_recv_in
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float varViewSpaceDepth [[user(locn6)]];
float2 varShadowTex [[user(locn7)]];
int varStereoViewID [[user(locn8)]];
float varClipDistance [[user(locn9)]];
float4 varColor [[user(locn10)]];
float4 PreviewVertexColor [[user(locn11)]];
float PreviewVertexSaved [[user(locn12)]];
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
fragment main_recv_out main_recv(main_recv_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]])
{
main_recv_out out={};
if ((int(sc_DepthOnly_tmp)!=0))
{
return out;
}
float l9_0;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_0=(*sc_set2.UserUniforms).overrideTimeElapsed;
}
else
{
l9_0=(*sc_set2.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_0;
float l9_1;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_1=(*sc_set2.UserUniforms).overrideTimeDelta;
}
else
{
l9_1=(*sc_set2.UserUniforms).sc_Time.y;
}
Globals.gTimeDelta=l9_1;
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-in.varPos);
Globals.PositionWS=in.varPos;
Globals.VertexTangent_WorldSpace=normalize(in.varTangent.xyz);
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*in.varTangent.w;
Globals.Surface_UVCoord0=in.varPackedTex.xy;
float2 UVCoord_N11=float2(0.0);
UVCoord_N11=Globals.Surface_UVCoord0;
float Output_N0=0.0;
float param=(*sc_set2.UserUniforms).uvScale;
Output_N0=param;
float2 CoordsOut_N16=float2(0.0);
CoordsOut_N16=((UVCoord_N11-(*sc_set2.UserUniforms).Port_Center_N016)*float2(Output_N0))+(*sc_set2.UserUniforms).Port_Center_N016;
float4 Output_N1=float4(0.0);
int l9_2=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_3=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3=0;
}
else
{
l9_3=in.varStereoViewID;
}
int l9_4=l9_3;
l9_2=1-l9_4;
}
else
{
int l9_5=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_5=0;
}
else
{
l9_5=in.varStereoViewID;
}
int l9_6=l9_5;
l9_2=l9_6;
}
int l9_7=l9_2;
int param_1=baseTexLayout_tmp;
int param_2=l9_7;
float2 param_3=CoordsOut_N16;
bool param_4=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).baseTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool param_7=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 param_8=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 param_10=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_11=0.0;
bool l9_8=param_9&&(!param_7);
float l9_9=1.0;
float l9_10=param_3.x;
int l9_11=param_6.x;
if (l9_11==1)
{
l9_10=fract(l9_10);
}
else
{
if (l9_11==2)
{
float l9_12=fract(l9_10);
float l9_13=l9_10-l9_12;
float l9_14=step(0.25,fract(l9_13*0.5));
l9_10=mix(l9_12,1.0-l9_12,fast::clamp(l9_14,0.0,1.0));
}
}
param_3.x=l9_10;
float l9_15=param_3.y;
int l9_16=param_6.y;
if (l9_16==1)
{
l9_15=fract(l9_15);
}
else
{
if (l9_16==2)
{
float l9_17=fract(l9_15);
float l9_18=l9_15-l9_17;
float l9_19=step(0.25,fract(l9_18*0.5));
l9_15=mix(l9_17,1.0-l9_17,fast::clamp(l9_19,0.0,1.0));
}
}
param_3.y=l9_15;
if (param_7)
{
bool l9_20=param_9;
bool l9_21;
if (l9_20)
{
l9_21=param_6.x==3;
}
else
{
l9_21=l9_20;
}
float l9_22=param_3.x;
float l9_23=param_8.x;
float l9_24=param_8.z;
bool l9_25=l9_21;
float l9_26=l9_9;
float l9_27=fast::clamp(l9_22,l9_23,l9_24);
float l9_28=step(abs(l9_22-l9_27),9.9999997e-06);
l9_26*=(l9_28+((1.0-float(l9_25))*(1.0-l9_28)));
l9_22=l9_27;
param_3.x=l9_22;
l9_9=l9_26;
bool l9_29=param_9;
bool l9_30;
if (l9_29)
{
l9_30=param_6.y==3;
}
else
{
l9_30=l9_29;
}
float l9_31=param_3.y;
float l9_32=param_8.y;
float l9_33=param_8.w;
bool l9_34=l9_30;
float l9_35=l9_9;
float l9_36=fast::clamp(l9_31,l9_32,l9_33);
float l9_37=step(abs(l9_31-l9_36),9.9999997e-06);
l9_35*=(l9_37+((1.0-float(l9_34))*(1.0-l9_37)));
l9_31=l9_36;
param_3.y=l9_31;
l9_9=l9_35;
}
float2 l9_38=param_3;
bool l9_39=param_4;
float3x3 l9_40=param_5;
if (l9_39)
{
l9_38=float2((l9_40*float3(l9_38,1.0)).xy);
}
float2 l9_41=l9_38;
float2 l9_42=l9_41;
float2 l9_43=l9_42;
param_3=l9_43;
float l9_44=param_3.x;
int l9_45=param_6.x;
bool l9_46=l9_8;
float l9_47=l9_9;
if ((l9_45==0)||(l9_45==3))
{
float l9_48=l9_44;
float l9_49=0.0;
float l9_50=1.0;
bool l9_51=l9_46;
float l9_52=l9_47;
float l9_53=fast::clamp(l9_48,l9_49,l9_50);
float l9_54=step(abs(l9_48-l9_53),9.9999997e-06);
l9_52*=(l9_54+((1.0-float(l9_51))*(1.0-l9_54)));
l9_48=l9_53;
l9_44=l9_48;
l9_47=l9_52;
}
param_3.x=l9_44;
l9_9=l9_47;
float l9_55=param_3.y;
int l9_56=param_6.y;
bool l9_57=l9_8;
float l9_58=l9_9;
if ((l9_56==0)||(l9_56==3))
{
float l9_59=l9_55;
float l9_60=0.0;
float l9_61=1.0;
bool l9_62=l9_57;
float l9_63=l9_58;
float l9_64=fast::clamp(l9_59,l9_60,l9_61);
float l9_65=step(abs(l9_59-l9_64),9.9999997e-06);
l9_63*=(l9_65+((1.0-float(l9_62))*(1.0-l9_65)));
l9_59=l9_64;
l9_55=l9_59;
l9_58=l9_63;
}
param_3.y=l9_55;
l9_9=l9_58;
float2 l9_66=param_3;
int l9_67=param_1;
int l9_68=param_2;
float l9_69=param_11;
float2 l9_70=l9_66;
int l9_71=l9_67;
int l9_72=l9_68;
float3 l9_73=float3(0.0);
if (l9_71==0)
{
l9_73=float3(l9_70,0.0);
}
else
{
if (l9_71==1)
{
l9_73=float3(l9_70.x,(l9_70.y*0.5)+(0.5-(float(l9_72)*0.5)),0.0);
}
else
{
l9_73=float3(l9_70,float(l9_72));
}
}
float3 l9_74=l9_73;
float3 l9_75=l9_74;
float2 l9_76=l9_75.xy;
float l9_77=l9_69;
float4 l9_78=sc_set2.baseTex.sample(sc_set2.baseTexSmpSC,l9_76,bias(l9_77));
float4 l9_79=l9_78;
float4 l9_80=l9_79;
if (param_9)
{
l9_80=mix(param_10,l9_80,float4(l9_9));
}
float4 l9_81=l9_80;
Output_N1=l9_81;
float Output_N5=0.0;
Output_N5=Output_N1.w;
float4 Output_N9=float4(0.0);
float2 param_12=CoordsOut_N16;
int l9_82=0;
if ((int(normalTexHasSwappedViews_tmp)!=0))
{
int l9_83=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_83=0;
}
else
{
l9_83=in.varStereoViewID;
}
int l9_84=l9_83;
l9_82=1-l9_84;
}
else
{
int l9_85=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_85=0;
}
else
{
l9_85=in.varStereoViewID;
}
int l9_86=l9_85;
l9_82=l9_86;
}
int l9_87=l9_82;
int l9_88=normalTexLayout_tmp;
int l9_89=l9_87;
float2 l9_90=param_12;
bool l9_91=(int(SC_USE_UV_TRANSFORM_normalTex_tmp)!=0);
float3x3 l9_92=(*sc_set2.UserUniforms).normalTexTransform;
int2 l9_93=int2(SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp);
bool l9_94=(int(SC_USE_UV_MIN_MAX_normalTex_tmp)!=0);
float4 l9_95=(*sc_set2.UserUniforms).normalTexUvMinMax;
bool l9_96=(int(SC_USE_CLAMP_TO_BORDER_normalTex_tmp)!=0);
float4 l9_97=(*sc_set2.UserUniforms).normalTexBorderColor;
float l9_98=0.0;
bool l9_99=l9_96&&(!l9_94);
float l9_100=1.0;
float l9_101=l9_90.x;
int l9_102=l9_93.x;
if (l9_102==1)
{
l9_101=fract(l9_101);
}
else
{
if (l9_102==2)
{
float l9_103=fract(l9_101);
float l9_104=l9_101-l9_103;
float l9_105=step(0.25,fract(l9_104*0.5));
l9_101=mix(l9_103,1.0-l9_103,fast::clamp(l9_105,0.0,1.0));
}
}
l9_90.x=l9_101;
float l9_106=l9_90.y;
int l9_107=l9_93.y;
if (l9_107==1)
{
l9_106=fract(l9_106);
}
else
{
if (l9_107==2)
{
float l9_108=fract(l9_106);
float l9_109=l9_106-l9_108;
float l9_110=step(0.25,fract(l9_109*0.5));
l9_106=mix(l9_108,1.0-l9_108,fast::clamp(l9_110,0.0,1.0));
}
}
l9_90.y=l9_106;
if (l9_94)
{
bool l9_111=l9_96;
bool l9_112;
if (l9_111)
{
l9_112=l9_93.x==3;
}
else
{
l9_112=l9_111;
}
float l9_113=l9_90.x;
float l9_114=l9_95.x;
float l9_115=l9_95.z;
bool l9_116=l9_112;
float l9_117=l9_100;
float l9_118=fast::clamp(l9_113,l9_114,l9_115);
float l9_119=step(abs(l9_113-l9_118),9.9999997e-06);
l9_117*=(l9_119+((1.0-float(l9_116))*(1.0-l9_119)));
l9_113=l9_118;
l9_90.x=l9_113;
l9_100=l9_117;
bool l9_120=l9_96;
bool l9_121;
if (l9_120)
{
l9_121=l9_93.y==3;
}
else
{
l9_121=l9_120;
}
float l9_122=l9_90.y;
float l9_123=l9_95.y;
float l9_124=l9_95.w;
bool l9_125=l9_121;
float l9_126=l9_100;
float l9_127=fast::clamp(l9_122,l9_123,l9_124);
float l9_128=step(abs(l9_122-l9_127),9.9999997e-06);
l9_126*=(l9_128+((1.0-float(l9_125))*(1.0-l9_128)));
l9_122=l9_127;
l9_90.y=l9_122;
l9_100=l9_126;
}
float2 l9_129=l9_90;
bool l9_130=l9_91;
float3x3 l9_131=l9_92;
if (l9_130)
{
l9_129=float2((l9_131*float3(l9_129,1.0)).xy);
}
float2 l9_132=l9_129;
float2 l9_133=l9_132;
float2 l9_134=l9_133;
l9_90=l9_134;
float l9_135=l9_90.x;
int l9_136=l9_93.x;
bool l9_137=l9_99;
float l9_138=l9_100;
if ((l9_136==0)||(l9_136==3))
{
float l9_139=l9_135;
float l9_140=0.0;
float l9_141=1.0;
bool l9_142=l9_137;
float l9_143=l9_138;
float l9_144=fast::clamp(l9_139,l9_140,l9_141);
float l9_145=step(abs(l9_139-l9_144),9.9999997e-06);
l9_143*=(l9_145+((1.0-float(l9_142))*(1.0-l9_145)));
l9_139=l9_144;
l9_135=l9_139;
l9_138=l9_143;
}
l9_90.x=l9_135;
l9_100=l9_138;
float l9_146=l9_90.y;
int l9_147=l9_93.y;
bool l9_148=l9_99;
float l9_149=l9_100;
if ((l9_147==0)||(l9_147==3))
{
float l9_150=l9_146;
float l9_151=0.0;
float l9_152=1.0;
bool l9_153=l9_148;
float l9_154=l9_149;
float l9_155=fast::clamp(l9_150,l9_151,l9_152);
float l9_156=step(abs(l9_150-l9_155),9.9999997e-06);
l9_154*=(l9_156+((1.0-float(l9_153))*(1.0-l9_156)));
l9_150=l9_155;
l9_146=l9_150;
l9_149=l9_154;
}
l9_90.y=l9_146;
l9_100=l9_149;
float2 l9_157=l9_90;
int l9_158=l9_88;
int l9_159=l9_89;
float l9_160=l9_98;
float2 l9_161=l9_157;
int l9_162=l9_158;
int l9_163=l9_159;
float3 l9_164=float3(0.0);
if (l9_162==0)
{
l9_164=float3(l9_161,0.0);
}
else
{
if (l9_162==1)
{
l9_164=float3(l9_161.x,(l9_161.y*0.5)+(0.5-(float(l9_163)*0.5)),0.0);
}
else
{
l9_164=float3(l9_161,float(l9_163));
}
}
float3 l9_165=l9_164;
float3 l9_166=l9_165;
float2 l9_167=l9_166.xy;
float l9_168=l9_160;
float4 l9_169=sc_set2.normalTex.sample(sc_set2.normalTexSmpSC,l9_167,bias(l9_168));
float4 l9_170=l9_169;
float4 l9_171=l9_170;
if (l9_96)
{
l9_171=mix(l9_97,l9_171,float4(l9_100));
}
float4 l9_172=l9_171;
float4 param_13=l9_172;
float3 l9_173=(param_13.xyz*1.9921875)-float3(1.0);
param_13=float4(l9_173.x,l9_173.y,l9_173.z,param_13.w);
Output_N9=param_13;
float4 Output_N2=float4(0.0);
int l9_174=0;
if ((int(materialParamsTexHasSwappedViews_tmp)!=0))
{
int l9_175=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_175=0;
}
else
{
l9_175=in.varStereoViewID;
}
int l9_176=l9_175;
l9_174=1-l9_176;
}
else
{
int l9_177=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_177=0;
}
else
{
l9_177=in.varStereoViewID;
}
int l9_178=l9_177;
l9_174=l9_178;
}
int l9_179=l9_174;
int param_14=materialParamsTexLayout_tmp;
int param_15=l9_179;
float2 param_16=CoordsOut_N16;
bool param_17=(int(SC_USE_UV_TRANSFORM_materialParamsTex_tmp)!=0);
float3x3 param_18=(*sc_set2.UserUniforms).materialParamsTexTransform;
int2 param_19=int2(SC_SOFTWARE_WRAP_MODE_U_materialParamsTex_tmp,SC_SOFTWARE_WRAP_MODE_V_materialParamsTex_tmp);
bool param_20=(int(SC_USE_UV_MIN_MAX_materialParamsTex_tmp)!=0);
float4 param_21=(*sc_set2.UserUniforms).materialParamsTexUvMinMax;
bool param_22=(int(SC_USE_CLAMP_TO_BORDER_materialParamsTex_tmp)!=0);
float4 param_23=(*sc_set2.UserUniforms).materialParamsTexBorderColor;
float param_24=0.0;
bool l9_180=param_22&&(!param_20);
float l9_181=1.0;
float l9_182=param_16.x;
int l9_183=param_19.x;
if (l9_183==1)
{
l9_182=fract(l9_182);
}
else
{
if (l9_183==2)
{
float l9_184=fract(l9_182);
float l9_185=l9_182-l9_184;
float l9_186=step(0.25,fract(l9_185*0.5));
l9_182=mix(l9_184,1.0-l9_184,fast::clamp(l9_186,0.0,1.0));
}
}
param_16.x=l9_182;
float l9_187=param_16.y;
int l9_188=param_19.y;
if (l9_188==1)
{
l9_187=fract(l9_187);
}
else
{
if (l9_188==2)
{
float l9_189=fract(l9_187);
float l9_190=l9_187-l9_189;
float l9_191=step(0.25,fract(l9_190*0.5));
l9_187=mix(l9_189,1.0-l9_189,fast::clamp(l9_191,0.0,1.0));
}
}
param_16.y=l9_187;
if (param_20)
{
bool l9_192=param_22;
bool l9_193;
if (l9_192)
{
l9_193=param_19.x==3;
}
else
{
l9_193=l9_192;
}
float l9_194=param_16.x;
float l9_195=param_21.x;
float l9_196=param_21.z;
bool l9_197=l9_193;
float l9_198=l9_181;
float l9_199=fast::clamp(l9_194,l9_195,l9_196);
float l9_200=step(abs(l9_194-l9_199),9.9999997e-06);
l9_198*=(l9_200+((1.0-float(l9_197))*(1.0-l9_200)));
l9_194=l9_199;
param_16.x=l9_194;
l9_181=l9_198;
bool l9_201=param_22;
bool l9_202;
if (l9_201)
{
l9_202=param_19.y==3;
}
else
{
l9_202=l9_201;
}
float l9_203=param_16.y;
float l9_204=param_21.y;
float l9_205=param_21.w;
bool l9_206=l9_202;
float l9_207=l9_181;
float l9_208=fast::clamp(l9_203,l9_204,l9_205);
float l9_209=step(abs(l9_203-l9_208),9.9999997e-06);
l9_207*=(l9_209+((1.0-float(l9_206))*(1.0-l9_209)));
l9_203=l9_208;
param_16.y=l9_203;
l9_181=l9_207;
}
float2 l9_210=param_16;
bool l9_211=param_17;
float3x3 l9_212=param_18;
if (l9_211)
{
l9_210=float2((l9_212*float3(l9_210,1.0)).xy);
}
float2 l9_213=l9_210;
float2 l9_214=l9_213;
float2 l9_215=l9_214;
param_16=l9_215;
float l9_216=param_16.x;
int l9_217=param_19.x;
bool l9_218=l9_180;
float l9_219=l9_181;
if ((l9_217==0)||(l9_217==3))
{
float l9_220=l9_216;
float l9_221=0.0;
float l9_222=1.0;
bool l9_223=l9_218;
float l9_224=l9_219;
float l9_225=fast::clamp(l9_220,l9_221,l9_222);
float l9_226=step(abs(l9_220-l9_225),9.9999997e-06);
l9_224*=(l9_226+((1.0-float(l9_223))*(1.0-l9_226)));
l9_220=l9_225;
l9_216=l9_220;
l9_219=l9_224;
}
param_16.x=l9_216;
l9_181=l9_219;
float l9_227=param_16.y;
int l9_228=param_19.y;
bool l9_229=l9_180;
float l9_230=l9_181;
if ((l9_228==0)||(l9_228==3))
{
float l9_231=l9_227;
float l9_232=0.0;
float l9_233=1.0;
bool l9_234=l9_229;
float l9_235=l9_230;
float l9_236=fast::clamp(l9_231,l9_232,l9_233);
float l9_237=step(abs(l9_231-l9_236),9.9999997e-06);
l9_235*=(l9_237+((1.0-float(l9_234))*(1.0-l9_237)));
l9_231=l9_236;
l9_227=l9_231;
l9_230=l9_235;
}
param_16.y=l9_227;
l9_181=l9_230;
float2 l9_238=param_16;
int l9_239=param_14;
int l9_240=param_15;
float l9_241=param_24;
float2 l9_242=l9_238;
int l9_243=l9_239;
int l9_244=l9_240;
float3 l9_245=float3(0.0);
if (l9_243==0)
{
l9_245=float3(l9_242,0.0);
}
else
{
if (l9_243==1)
{
l9_245=float3(l9_242.x,(l9_242.y*0.5)+(0.5-(float(l9_244)*0.5)),0.0);
}
else
{
l9_245=float3(l9_242,float(l9_244));
}
}
float3 l9_246=l9_245;
float3 l9_247=l9_246;
float2 l9_248=l9_247.xy;
float l9_249=l9_241;
float4 l9_250=sc_set2.materialParamsTex.sample(sc_set2.materialParamsTexSmpSC,l9_248,bias(l9_249));
float4 l9_251=l9_250;
float4 l9_252=l9_251;
if (param_22)
{
l9_252=mix(param_23,l9_252,float4(l9_181));
}
float4 l9_253=l9_252;
Output_N2=l9_253;
float Value2_N3=0.0;
float4 param_25=Output_N2;
float param_26=param_25.y;
Value2_N3=param_26;
float param_27=Output_N5;
float3 param_28=Output_N9.xyz;
float param_29=Value2_N3;
ssGlobals param_30=Globals;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
param_30.BumpedNormal=float3x3(float3(param_30.VertexTangent_WorldSpace),float3(param_30.VertexBinormal_WorldSpace),float3(param_30.VertexNormal_WorldSpace))*param_28;
}
param_27=fast::clamp(param_27,0.0,1.0);
float l9_254=param_27;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_254<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_255=gl_FragCoord;
float2 l9_256=floor(mod(l9_255.xy,float2(4.0)));
float l9_257=(mod(dot(l9_256,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_254<l9_257)
{
discard_fragment();
}
}
float3 l9_258=param_30.PositionWS;
float3 l9_259=param_30.BumpedNormal;
float l9_260=param_29;
float3 l9_261=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_258);
if (dot(l9_261,l9_259)>=(-0.050000001))
{
uint3 l9_262=uint3(round((l9_258-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_262.x,l9_262.y,l9_262.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_263=l9_259;
float l9_264=dot(abs(l9_263),float3(1.0));
l9_263/=float3(l9_264);
float l9_265=fast::clamp(-l9_263.z,0.0,1.0);
float2 l9_266=l9_263.xy;
float l9_267;
if (l9_263.x>=0.0)
{
l9_267=l9_265;
}
else
{
l9_267=-l9_265;
}
l9_266.x+=l9_267;
float l9_268;
if (l9_263.y>=0.0)
{
l9_268=l9_265;
}
else
{
l9_268=-l9_265;
}
l9_266.y+=l9_268;
float2 l9_269=l9_266;
float2 l9_270=l9_269;
uint2 l9_271=uint2(as_type<uint>(half2(float2(l9_270.x,0.0))),as_type<uint>(half2(float2(l9_270.y,0.0))));
out.normal_and_more=uint4(l9_271.x,l9_271.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_272;
if (l9_260<0.0)
{
l9_272=1023u;
}
else
{
l9_272=uint(fast::clamp(l9_260,0.0,1.0)*1000.0);
}
uint l9_273=l9_272;
l9_273 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_273;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
return out;
}
} // RECEIVER MODE SHADER
