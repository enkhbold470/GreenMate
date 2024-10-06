#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
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
//sampler sampler baseColorTextureSmpSC 2:36
//sampler sampler clearcoatNormalTextureSmpSC 2:37
//sampler sampler clearcoatRoughnessTextureSmpSC 2:38
//sampler sampler clearcoatTextureSmpSC 2:39
//sampler sampler emissiveTextureSmpSC 2:40
//sampler sampler intensityTextureSmpSC 2:41
//sampler sampler metallicRoughnessTextureSmpSC 2:42
//sampler sampler normalTextureSmpSC 2:43
//sampler sampler sc_EnvmapDiffuseSmpSC 2:44
//sampler sampler sc_EnvmapSpecularSmpSC 2:45
//sampler sampler sc_RayTracedAoTextureSmpSC 2:47
//sampler sampler sc_RayTracedDiffIndTextureSmpSC 2:48
//sampler sampler sc_RayTracedReflectionTextureSmpSC 2:49
//sampler sampler sc_RayTracedShadowTextureSmpSC 2:50
//sampler sampler sc_SSAOTextureSmpSC 2:51
//sampler sampler sc_ScreenTextureSmpSC 2:52
//sampler sampler sc_ShadowTextureSmpSC 2:53
//sampler sampler screenTextureSmpSC 2:55
//sampler sampler sheenColorTextureSmpSC 2:56
//sampler sampler sheenRoughnessTextureSmpSC 2:57
//sampler sampler transmissionTextureSmpSC 2:58
//sampler sampler z_hitIdAndBarycentricSmp 2:59
//sampler sampler z_rayDirectionsSmpSC 2:60
//texture texture2D baseColorTexture 2:4:2:36
//texture texture2D clearcoatNormalTexture 2:5:2:37
//texture texture2D clearcoatRoughnessTexture 2:6:2:38
//texture texture2D clearcoatTexture 2:7:2:39
//texture texture2D emissiveTexture 2:8:2:40
//texture texture2D intensityTexture 2:9:2:41
//texture texture2D metallicRoughnessTexture 2:10:2:42
//texture texture2D normalTexture 2:11:2:43
//texture texture2D sc_EnvmapDiffuse 2:12:2:44
//texture texture2D sc_EnvmapSpecular 2:13:2:45
//texture texture2D sc_RayTracedAoTexture 2:22:2:47
//texture texture2D sc_RayTracedDiffIndTexture 2:23:2:48
//texture texture2D sc_RayTracedReflectionTexture 2:24:2:49
//texture texture2D sc_RayTracedShadowTexture 2:25:2:50
//texture texture2D sc_SSAOTexture 2:26:2:51
//texture texture2D sc_ScreenTexture 2:27:2:52
//texture texture2D sc_ShadowTexture 2:28:2:53
//texture texture2D screenTexture 2:30:2:55
//texture texture2D sheenColorTexture 2:31:2:56
//texture texture2D sheenRoughnessTexture 2:32:2:57
//texture texture2D transmissionTexture 2:33:2:58
//texture utexture2D z_hitIdAndBarycentric 2:34:2:59
//texture texture2D z_rayDirections 2:35:2:60
//ubo float sc_BonesUBO 2:3:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:61:6288 {
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
//float3 emissiveFactor 4368
//float4 emissiveTextureSize 4384
//float4 emissiveTextureDims 4400
//float4 emissiveTextureView 4416
//float3x3 emissiveTextureTransform 4432
//float4 emissiveTextureUvMinMax 4480
//float4 emissiveTextureBorderColor 4496
//float normalTextureScale 4512
//float4 normalTextureSize 4528
//float4 normalTextureDims 4544
//float4 normalTextureView 4560
//float3x3 normalTextureTransform 4576
//float4 normalTextureUvMinMax 4624
//float4 normalTextureBorderColor 4640
//float metallicFactor 4656
//float roughnessFactor 4660
//float occlusionTextureStrength 4664
//float4 metallicRoughnessTextureSize 4672
//float4 metallicRoughnessTextureDims 4688
//float4 metallicRoughnessTextureView 4704
//float3x3 metallicRoughnessTextureTransform 4720
//float4 metallicRoughnessTextureUvMinMax 4768
//float4 metallicRoughnessTextureBorderColor 4784
//float transmissionFactor 4800
//float4 transmissionTextureSize 4816
//float4 transmissionTextureDims 4832
//float4 transmissionTextureView 4848
//float3x3 transmissionTextureTransform 4864
//float4 transmissionTextureUvMinMax 4912
//float4 transmissionTextureBorderColor 4928
//float4 screenTextureSize 4944
//float4 screenTextureDims 4960
//float4 screenTextureView 4976
//float3x3 screenTextureTransform 4992
//float4 screenTextureUvMinMax 5040
//float4 screenTextureBorderColor 5056
//float3 sheenColorFactor 5072
//float4 sheenColorTextureSize 5088
//float4 sheenColorTextureDims 5104
//float4 sheenColorTextureView 5120
//float3x3 sheenColorTextureTransform 5136
//float4 sheenColorTextureUvMinMax 5184
//float4 sheenColorTextureBorderColor 5200
//float sheenRoughnessFactor 5216
//float4 sheenRoughnessTextureSize 5232
//float4 sheenRoughnessTextureDims 5248
//float4 sheenRoughnessTextureView 5264
//float3x3 sheenRoughnessTextureTransform 5280
//float4 sheenRoughnessTextureUvMinMax 5328
//float4 sheenRoughnessTextureBorderColor 5344
//float clearcoatFactor 5360
//float4 clearcoatTextureSize 5376
//float4 clearcoatTextureDims 5392
//float4 clearcoatTextureView 5408
//float3x3 clearcoatTextureTransform 5424
//float4 clearcoatTextureUvMinMax 5472
//float4 clearcoatTextureBorderColor 5488
//float clearcoatRoughnessFactor 5504
//float4 clearcoatRoughnessTextureSize 5520
//float4 clearcoatRoughnessTextureDims 5536
//float4 clearcoatRoughnessTextureView 5552
//float3x3 clearcoatRoughnessTextureTransform 5568
//float4 clearcoatRoughnessTextureUvMinMax 5616
//float4 clearcoatRoughnessTextureBorderColor 5632
//float4 clearcoatNormalTextureSize 5648
//float4 clearcoatNormalTextureDims 5664
//float4 clearcoatNormalTextureView 5680
//float3x3 clearcoatNormalTextureTransform 5696
//float4 clearcoatNormalTextureUvMinMax 5744
//float4 clearcoatNormalTextureBorderColor 5760
//float4 baseColorTextureSize 5776
//float4 baseColorTextureDims 5792
//float4 baseColorTextureView 5808
//float3x3 baseColorTextureTransform 5824
//float4 baseColorTextureUvMinMax 5872
//float4 baseColorTextureBorderColor 5888
//float4 baseColorFactor 5904
//float2 baseColorTexture_offset 5920
//float2 baseColorTexture_scale 5928
//float baseColorTexture_rotation 5936
//float2 emissiveTexture_offset 5944
//float2 emissiveTexture_scale 5952
//float emissiveTexture_rotation 5960
//float2 normalTexture_offset 5968
//float2 normalTexture_scale 5976
//float normalTexture_rotation 5984
//float2 metallicRoughnessTexture_offset 5992
//float2 metallicRoughnessTexture_scale 6000
//float metallicRoughnessTexture_rotation 6008
//float2 transmissionTexture_offset 6016
//float2 transmissionTexture_scale 6024
//float transmissionTexture_rotation 6032
//float2 sheenColorTexture_offset 6040
//float2 sheenColorTexture_scale 6048
//float sheenColorTexture_rotation 6056
//float2 sheenRoughnessTexture_offset 6064
//float2 sheenRoughnessTexture_scale 6072
//float sheenRoughnessTexture_rotation 6080
//float2 clearcoatTexture_offset 6088
//float2 clearcoatTexture_scale 6096
//float clearcoatTexture_rotation 6104
//float2 clearcoatNormalTexture_offset 6112
//float2 clearcoatNormalTexture_scale 6120
//float clearcoatNormalTexture_rotation 6128
//float2 clearcoatRoughnessTexture_offset 6136
//float2 clearcoatRoughnessTexture_scale 6144
//float clearcoatRoughnessTexture_rotation 6152
//float Port_DebugSheenEnvLightMult_N003 6156
//float Port_DebugSheenPunctualLightMult_N003 6160
//float Port_Input2_N043 6164
//float Port_Input2_N062 6168
//float3 Port_SpecularAO_N036 6176
//float3 Port_Albedo_N405 6192
//float Port_Opacity_N405 6208
//float3 Port_Emissive_N405 6224
//float Port_Metallic_N405 6240
//float3 Port_SpecularAO_N405 6256
//float depthRef 6272
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
//spec_const bool ENABLE_BASE_TEXTURE_TRANSFORM 1030
//spec_const bool ENABLE_BASE_TEX 1031
//spec_const bool ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM 1032
//spec_const bool ENABLE_CLEARCOAT_NORMAL_TEX 1033
//spec_const bool ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM 1034
//spec_const bool ENABLE_CLEARCOAT_ROUGHNESS_TEX 1035
//spec_const bool ENABLE_CLEARCOAT_TEXTURE_TRANSFORM 1036
//spec_const bool ENABLE_CLEARCOAT_TEX 1037
//spec_const bool ENABLE_CLEARCOAT 1038
//spec_const bool ENABLE_EMISSIVE_TEXTURE_TRANSFORM 1039
//spec_const bool ENABLE_EMISSIVE 1040
//spec_const bool ENABLE_GLTF_LIGHTING 1041
//spec_const bool ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM 1042
//spec_const bool ENABLE_METALLIC_ROUGHNESS_TEX 1043
//spec_const bool ENABLE_NORMALMAP 1044
//spec_const bool ENABLE_NORMAL_TEXTURE_TRANSFORM 1045
//spec_const bool ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM 1046
//spec_const bool ENABLE_SHEEN_COLOR_TEX 1047
//spec_const bool ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM 1048
//spec_const bool ENABLE_SHEEN_ROUGHNESS_TEX 1049
//spec_const bool ENABLE_SHEEN 1050
//spec_const bool ENABLE_STIPPLE_PATTERN_TEST 1051
//spec_const bool ENABLE_TEXTURE_TRANSFORM 1052
//spec_const bool ENABLE_TRANSMISSION_TEXTURE_TRANSFORM 1053
//spec_const bool ENABLE_TRANSMISSION_TEX 1054
//spec_const bool ENABLE_TRANSMISSION 1055
//spec_const bool ENABLE_VERTEX_COLOR_BASE 1056
//spec_const bool SC_USE_CLAMP_TO_BORDER_baseColorTexture 1057
//spec_const bool SC_USE_CLAMP_TO_BORDER_clearcoatNormalTexture 1058
//spec_const bool SC_USE_CLAMP_TO_BORDER_clearcoatRoughnessTexture 1059
//spec_const bool SC_USE_CLAMP_TO_BORDER_clearcoatTexture 1060
//spec_const bool SC_USE_CLAMP_TO_BORDER_emissiveTexture 1061
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 1062
//spec_const bool SC_USE_CLAMP_TO_BORDER_metallicRoughnessTexture 1063
//spec_const bool SC_USE_CLAMP_TO_BORDER_normalTexture 1064
//spec_const bool SC_USE_CLAMP_TO_BORDER_screenTexture 1065
//spec_const bool SC_USE_CLAMP_TO_BORDER_sheenColorTexture 1066
//spec_const bool SC_USE_CLAMP_TO_BORDER_sheenRoughnessTexture 1067
//spec_const bool SC_USE_CLAMP_TO_BORDER_transmissionTexture 1068
//spec_const bool SC_USE_UV_MIN_MAX_baseColorTexture 1069
//spec_const bool SC_USE_UV_MIN_MAX_clearcoatNormalTexture 1070
//spec_const bool SC_USE_UV_MIN_MAX_clearcoatRoughnessTexture 1071
//spec_const bool SC_USE_UV_MIN_MAX_clearcoatTexture 1072
//spec_const bool SC_USE_UV_MIN_MAX_emissiveTexture 1073
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 1074
//spec_const bool SC_USE_UV_MIN_MAX_metallicRoughnessTexture 1075
//spec_const bool SC_USE_UV_MIN_MAX_normalTexture 1076
//spec_const bool SC_USE_UV_MIN_MAX_screenTexture 1077
//spec_const bool SC_USE_UV_MIN_MAX_sheenColorTexture 1078
//spec_const bool SC_USE_UV_MIN_MAX_sheenRoughnessTexture 1079
//spec_const bool SC_USE_UV_MIN_MAX_transmissionTexture 1080
//spec_const bool SC_USE_UV_TRANSFORM_baseColorTexture 1081
//spec_const bool SC_USE_UV_TRANSFORM_clearcoatNormalTexture 1082
//spec_const bool SC_USE_UV_TRANSFORM_clearcoatRoughnessTexture 1083
//spec_const bool SC_USE_UV_TRANSFORM_clearcoatTexture 1084
//spec_const bool SC_USE_UV_TRANSFORM_emissiveTexture 1085
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 1086
//spec_const bool SC_USE_UV_TRANSFORM_metallicRoughnessTexture 1087
//spec_const bool SC_USE_UV_TRANSFORM_normalTexture 1088
//spec_const bool SC_USE_UV_TRANSFORM_screenTexture 1089
//spec_const bool SC_USE_UV_TRANSFORM_sheenColorTexture 1090
//spec_const bool SC_USE_UV_TRANSFORM_sheenRoughnessTexture 1091
//spec_const bool SC_USE_UV_TRANSFORM_transmissionTexture 1092
//spec_const bool UseViewSpaceDepthVariant 1093
//spec_const bool baseColorTextureHasSwappedViews 1094
//spec_const bool clearcoatNormalTextureHasSwappedViews 1095
//spec_const bool clearcoatRoughnessTextureHasSwappedViews 1096
//spec_const bool clearcoatTextureHasSwappedViews 1097
//spec_const bool emissiveTextureHasSwappedViews 1098
//spec_const bool intensityTextureHasSwappedViews 1099
//spec_const bool metallicRoughnessTextureHasSwappedViews 1100
//spec_const bool normalTextureHasSwappedViews 1101
//spec_const bool sc_BlendMode_AddWithAlphaFactor 1102
//spec_const bool sc_BlendMode_Add 1103
//spec_const bool sc_BlendMode_AlphaTest 1104
//spec_const bool sc_BlendMode_AlphaToCoverage 1105
//spec_const bool sc_BlendMode_ColoredGlass 1106
//spec_const bool sc_BlendMode_Custom 1107
//spec_const bool sc_BlendMode_Max 1108
//spec_const bool sc_BlendMode_Min 1109
//spec_const bool sc_BlendMode_MultiplyOriginal 1110
//spec_const bool sc_BlendMode_Multiply 1111
//spec_const bool sc_BlendMode_Normal 1112
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 1113
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 1114
//spec_const bool sc_BlendMode_PremultipliedAlpha 1115
//spec_const bool sc_BlendMode_Screen 1116
//spec_const bool sc_DepthOnly 1117
//spec_const bool sc_EnvmapDiffuseHasSwappedViews 1118
//spec_const bool sc_EnvmapSpecularHasSwappedViews 1119
//spec_const bool sc_FramebufferFetch 1120
//spec_const bool sc_HasDiffuseEnvmap 1121
//spec_const bool sc_LightEstimation 1122
//spec_const bool sc_MotionVectorsPass 1123
//spec_const bool sc_OITCompositingPass 1124
//spec_const bool sc_OITDepthBoundsPass 1125
//spec_const bool sc_OITDepthGatherPass 1126
//spec_const bool sc_ProjectiveShadowsCaster 1127
//spec_const bool sc_ProjectiveShadowsReceiver 1128
//spec_const bool sc_ProxyAlphaOne 1129
//spec_const bool sc_RayTracedAoTextureHasSwappedViews 1130
//spec_const bool sc_RayTracedDiffIndTextureHasSwappedViews 1131
//spec_const bool sc_RayTracedReflectionTextureHasSwappedViews 1132
//spec_const bool sc_RayTracedShadowTextureHasSwappedViews 1133
//spec_const bool sc_RenderAlphaToColor 1134
//spec_const bool sc_SSAOEnabled 1135
//spec_const bool sc_ScreenTextureHasSwappedViews 1136
//spec_const bool sc_ShaderComplexityAnalyzer 1137
//spec_const bool sc_UseFramebufferFetchMarker 1138
//spec_const bool sc_VertexBlendingUseNormals 1139
//spec_const bool sc_VertexBlending 1140
//spec_const bool screenTextureHasSwappedViews 1141
//spec_const bool sheenColorTextureHasSwappedViews 1142
//spec_const bool sheenRoughnessTextureHasSwappedViews 1143
//spec_const bool transmissionTextureHasSwappedViews 1144
//spec_const int NODE_10_DROPLIST_ITEM 1145
//spec_const int NODE_11_DROPLIST_ITEM 1146
//spec_const int NODE_7_DROPLIST_ITEM 1147
//spec_const int NODE_8_DROPLIST_ITEM 1148
//spec_const int SC_DEVICE_CLASS 1149
//spec_const int SC_SOFTWARE_WRAP_MODE_U_baseColorTexture 1150
//spec_const int SC_SOFTWARE_WRAP_MODE_U_clearcoatNormalTexture 1151
//spec_const int SC_SOFTWARE_WRAP_MODE_U_clearcoatRoughnessTexture 1152
//spec_const int SC_SOFTWARE_WRAP_MODE_U_clearcoatTexture 1153
//spec_const int SC_SOFTWARE_WRAP_MODE_U_emissiveTexture 1154
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 1155
//spec_const int SC_SOFTWARE_WRAP_MODE_U_metallicRoughnessTexture 1156
//spec_const int SC_SOFTWARE_WRAP_MODE_U_normalTexture 1157
//spec_const int SC_SOFTWARE_WRAP_MODE_U_screenTexture 1158
//spec_const int SC_SOFTWARE_WRAP_MODE_U_sheenColorTexture 1159
//spec_const int SC_SOFTWARE_WRAP_MODE_U_sheenRoughnessTexture 1160
//spec_const int SC_SOFTWARE_WRAP_MODE_U_transmissionTexture 1161
//spec_const int SC_SOFTWARE_WRAP_MODE_V_baseColorTexture 1162
//spec_const int SC_SOFTWARE_WRAP_MODE_V_clearcoatNormalTexture 1163
//spec_const int SC_SOFTWARE_WRAP_MODE_V_clearcoatRoughnessTexture 1164
//spec_const int SC_SOFTWARE_WRAP_MODE_V_clearcoatTexture 1165
//spec_const int SC_SOFTWARE_WRAP_MODE_V_emissiveTexture 1166
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 1167
//spec_const int SC_SOFTWARE_WRAP_MODE_V_metallicRoughnessTexture 1168
//spec_const int SC_SOFTWARE_WRAP_MODE_V_normalTexture 1169
//spec_const int SC_SOFTWARE_WRAP_MODE_V_screenTexture 1170
//spec_const int SC_SOFTWARE_WRAP_MODE_V_sheenColorTexture 1171
//spec_const int SC_SOFTWARE_WRAP_MODE_V_sheenRoughnessTexture 1172
//spec_const int SC_SOFTWARE_WRAP_MODE_V_transmissionTexture 1173
//spec_const int Tweak_N30 1174
//spec_const int Tweak_N32 1175
//spec_const int Tweak_N37 1176
//spec_const int Tweak_N44 1177
//spec_const int Tweak_N47 1178
//spec_const int Tweak_N60 1179
//spec_const int baseColorTextureLayout 1180
//spec_const int clearcoatNormalTextureLayout 1181
//spec_const int clearcoatRoughnessTextureLayout 1182
//spec_const int clearcoatTextureLayout 1183
//spec_const int emissiveTextureLayout 1184
//spec_const int intensityTextureLayout 1185
//spec_const int metallicRoughnessTextureLayout 1186
//spec_const int normalTextureLayout 1187
//spec_const int sc_AmbientLightMode0 1188
//spec_const int sc_AmbientLightMode1 1189
//spec_const int sc_AmbientLightMode2 1190
//spec_const int sc_AmbientLightMode_Constant 1191
//spec_const int sc_AmbientLightMode_EnvironmentMap 1192
//spec_const int sc_AmbientLightMode_FromCamera 1193
//spec_const int sc_AmbientLightMode_SphericalHarmonics 1194
//spec_const int sc_AmbientLightsCount 1195
//spec_const int sc_DepthBufferMode 1196
//spec_const int sc_DirectionalLightsCount 1197
//spec_const int sc_EnvLightMode 1198
//spec_const int sc_EnvmapDiffuseLayout 1199
//spec_const int sc_EnvmapSpecularLayout 1200
//spec_const int sc_LightEstimationSGCount 1201
//spec_const int sc_MaxTextureImageUnits 1202
//spec_const int sc_PointLightsCount 1203
//spec_const int sc_RayTracedAoTextureLayout 1204
//spec_const int sc_RayTracedDiffIndTextureLayout 1205
//spec_const int sc_RayTracedReflectionTextureLayout 1206
//spec_const int sc_RayTracedShadowTextureLayout 1207
//spec_const int sc_RenderingSpace 1208
//spec_const int sc_ScreenTextureLayout 1209
//spec_const int sc_SkinBonesCount 1210
//spec_const int sc_StereoRenderingMode 1211
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1212
//spec_const int screenTextureLayout 1213
//spec_const int sheenColorTextureLayout 1214
//spec_const int sheenRoughnessTextureLayout 1215
//spec_const int transmissionTextureLayout 1216
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
constant bool ENABLE_BASE_TEXTURE_TRANSFORM [[function_constant(1030)]];
constant bool ENABLE_BASE_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_BASE_TEXTURE_TRANSFORM) ? ENABLE_BASE_TEXTURE_TRANSFORM : false;
constant bool ENABLE_BASE_TEX [[function_constant(1031)]];
constant bool ENABLE_BASE_TEX_tmp = is_function_constant_defined(ENABLE_BASE_TEX) ? ENABLE_BASE_TEX : false;
constant bool ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM [[function_constant(1032)]];
constant bool ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM) ? ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM : false;
constant bool ENABLE_CLEARCOAT_NORMAL_TEX [[function_constant(1033)]];
constant bool ENABLE_CLEARCOAT_NORMAL_TEX_tmp = is_function_constant_defined(ENABLE_CLEARCOAT_NORMAL_TEX) ? ENABLE_CLEARCOAT_NORMAL_TEX : false;
constant bool ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM [[function_constant(1034)]];
constant bool ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM) ? ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM : false;
constant bool ENABLE_CLEARCOAT_ROUGHNESS_TEX [[function_constant(1035)]];
constant bool ENABLE_CLEARCOAT_ROUGHNESS_TEX_tmp = is_function_constant_defined(ENABLE_CLEARCOAT_ROUGHNESS_TEX) ? ENABLE_CLEARCOAT_ROUGHNESS_TEX : false;
constant bool ENABLE_CLEARCOAT_TEXTURE_TRANSFORM [[function_constant(1036)]];
constant bool ENABLE_CLEARCOAT_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_CLEARCOAT_TEXTURE_TRANSFORM) ? ENABLE_CLEARCOAT_TEXTURE_TRANSFORM : false;
constant bool ENABLE_CLEARCOAT_TEX [[function_constant(1037)]];
constant bool ENABLE_CLEARCOAT_TEX_tmp = is_function_constant_defined(ENABLE_CLEARCOAT_TEX) ? ENABLE_CLEARCOAT_TEX : false;
constant bool ENABLE_CLEARCOAT [[function_constant(1038)]];
constant bool ENABLE_CLEARCOAT_tmp = is_function_constant_defined(ENABLE_CLEARCOAT) ? ENABLE_CLEARCOAT : false;
constant bool ENABLE_EMISSIVE_TEXTURE_TRANSFORM [[function_constant(1039)]];
constant bool ENABLE_EMISSIVE_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_EMISSIVE_TEXTURE_TRANSFORM) ? ENABLE_EMISSIVE_TEXTURE_TRANSFORM : false;
constant bool ENABLE_EMISSIVE [[function_constant(1040)]];
constant bool ENABLE_EMISSIVE_tmp = is_function_constant_defined(ENABLE_EMISSIVE) ? ENABLE_EMISSIVE : false;
constant bool ENABLE_GLTF_LIGHTING [[function_constant(1041)]];
constant bool ENABLE_GLTF_LIGHTING_tmp = is_function_constant_defined(ENABLE_GLTF_LIGHTING) ? ENABLE_GLTF_LIGHTING : false;
constant bool ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM [[function_constant(1042)]];
constant bool ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM) ? ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM : false;
constant bool ENABLE_METALLIC_ROUGHNESS_TEX [[function_constant(1043)]];
constant bool ENABLE_METALLIC_ROUGHNESS_TEX_tmp = is_function_constant_defined(ENABLE_METALLIC_ROUGHNESS_TEX) ? ENABLE_METALLIC_ROUGHNESS_TEX : false;
constant bool ENABLE_NORMALMAP [[function_constant(1044)]];
constant bool ENABLE_NORMALMAP_tmp = is_function_constant_defined(ENABLE_NORMALMAP) ? ENABLE_NORMALMAP : false;
constant bool ENABLE_NORMAL_TEXTURE_TRANSFORM [[function_constant(1045)]];
constant bool ENABLE_NORMAL_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_NORMAL_TEXTURE_TRANSFORM) ? ENABLE_NORMAL_TEXTURE_TRANSFORM : false;
constant bool ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM [[function_constant(1046)]];
constant bool ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM) ? ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM : false;
constant bool ENABLE_SHEEN_COLOR_TEX [[function_constant(1047)]];
constant bool ENABLE_SHEEN_COLOR_TEX_tmp = is_function_constant_defined(ENABLE_SHEEN_COLOR_TEX) ? ENABLE_SHEEN_COLOR_TEX : false;
constant bool ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM [[function_constant(1048)]];
constant bool ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM) ? ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM : false;
constant bool ENABLE_SHEEN_ROUGHNESS_TEX [[function_constant(1049)]];
constant bool ENABLE_SHEEN_ROUGHNESS_TEX_tmp = is_function_constant_defined(ENABLE_SHEEN_ROUGHNESS_TEX) ? ENABLE_SHEEN_ROUGHNESS_TEX : false;
constant bool ENABLE_SHEEN [[function_constant(1050)]];
constant bool ENABLE_SHEEN_tmp = is_function_constant_defined(ENABLE_SHEEN) ? ENABLE_SHEEN : false;
constant bool ENABLE_STIPPLE_PATTERN_TEST [[function_constant(1051)]];
constant bool ENABLE_STIPPLE_PATTERN_TEST_tmp = is_function_constant_defined(ENABLE_STIPPLE_PATTERN_TEST) ? ENABLE_STIPPLE_PATTERN_TEST : false;
constant bool ENABLE_TEXTURE_TRANSFORM [[function_constant(1052)]];
constant bool ENABLE_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_TEXTURE_TRANSFORM) ? ENABLE_TEXTURE_TRANSFORM : false;
constant bool ENABLE_TRANSMISSION_TEXTURE_TRANSFORM [[function_constant(1053)]];
constant bool ENABLE_TRANSMISSION_TEXTURE_TRANSFORM_tmp = is_function_constant_defined(ENABLE_TRANSMISSION_TEXTURE_TRANSFORM) ? ENABLE_TRANSMISSION_TEXTURE_TRANSFORM : false;
constant bool ENABLE_TRANSMISSION_TEX [[function_constant(1054)]];
constant bool ENABLE_TRANSMISSION_TEX_tmp = is_function_constant_defined(ENABLE_TRANSMISSION_TEX) ? ENABLE_TRANSMISSION_TEX : false;
constant bool ENABLE_TRANSMISSION [[function_constant(1055)]];
constant bool ENABLE_TRANSMISSION_tmp = is_function_constant_defined(ENABLE_TRANSMISSION) ? ENABLE_TRANSMISSION : false;
constant bool ENABLE_VERTEX_COLOR_BASE [[function_constant(1056)]];
constant bool ENABLE_VERTEX_COLOR_BASE_tmp = is_function_constant_defined(ENABLE_VERTEX_COLOR_BASE) ? ENABLE_VERTEX_COLOR_BASE : false;
constant bool SC_USE_CLAMP_TO_BORDER_baseColorTexture [[function_constant(1057)]];
constant bool SC_USE_CLAMP_TO_BORDER_baseColorTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_baseColorTexture) ? SC_USE_CLAMP_TO_BORDER_baseColorTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_clearcoatNormalTexture [[function_constant(1058)]];
constant bool SC_USE_CLAMP_TO_BORDER_clearcoatNormalTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_clearcoatNormalTexture) ? SC_USE_CLAMP_TO_BORDER_clearcoatNormalTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_clearcoatRoughnessTexture [[function_constant(1059)]];
constant bool SC_USE_CLAMP_TO_BORDER_clearcoatRoughnessTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_clearcoatRoughnessTexture) ? SC_USE_CLAMP_TO_BORDER_clearcoatRoughnessTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_clearcoatTexture [[function_constant(1060)]];
constant bool SC_USE_CLAMP_TO_BORDER_clearcoatTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_clearcoatTexture) ? SC_USE_CLAMP_TO_BORDER_clearcoatTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_emissiveTexture [[function_constant(1061)]];
constant bool SC_USE_CLAMP_TO_BORDER_emissiveTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_emissiveTexture) ? SC_USE_CLAMP_TO_BORDER_emissiveTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(1062)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_metallicRoughnessTexture [[function_constant(1063)]];
constant bool SC_USE_CLAMP_TO_BORDER_metallicRoughnessTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_metallicRoughnessTexture) ? SC_USE_CLAMP_TO_BORDER_metallicRoughnessTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_normalTexture [[function_constant(1064)]];
constant bool SC_USE_CLAMP_TO_BORDER_normalTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_normalTexture) ? SC_USE_CLAMP_TO_BORDER_normalTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_screenTexture [[function_constant(1065)]];
constant bool SC_USE_CLAMP_TO_BORDER_screenTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_screenTexture) ? SC_USE_CLAMP_TO_BORDER_screenTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_sheenColorTexture [[function_constant(1066)]];
constant bool SC_USE_CLAMP_TO_BORDER_sheenColorTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_sheenColorTexture) ? SC_USE_CLAMP_TO_BORDER_sheenColorTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_sheenRoughnessTexture [[function_constant(1067)]];
constant bool SC_USE_CLAMP_TO_BORDER_sheenRoughnessTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_sheenRoughnessTexture) ? SC_USE_CLAMP_TO_BORDER_sheenRoughnessTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_transmissionTexture [[function_constant(1068)]];
constant bool SC_USE_CLAMP_TO_BORDER_transmissionTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_transmissionTexture) ? SC_USE_CLAMP_TO_BORDER_transmissionTexture : false;
constant bool SC_USE_UV_MIN_MAX_baseColorTexture [[function_constant(1069)]];
constant bool SC_USE_UV_MIN_MAX_baseColorTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_baseColorTexture) ? SC_USE_UV_MIN_MAX_baseColorTexture : false;
constant bool SC_USE_UV_MIN_MAX_clearcoatNormalTexture [[function_constant(1070)]];
constant bool SC_USE_UV_MIN_MAX_clearcoatNormalTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_clearcoatNormalTexture) ? SC_USE_UV_MIN_MAX_clearcoatNormalTexture : false;
constant bool SC_USE_UV_MIN_MAX_clearcoatRoughnessTexture [[function_constant(1071)]];
constant bool SC_USE_UV_MIN_MAX_clearcoatRoughnessTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_clearcoatRoughnessTexture) ? SC_USE_UV_MIN_MAX_clearcoatRoughnessTexture : false;
constant bool SC_USE_UV_MIN_MAX_clearcoatTexture [[function_constant(1072)]];
constant bool SC_USE_UV_MIN_MAX_clearcoatTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_clearcoatTexture) ? SC_USE_UV_MIN_MAX_clearcoatTexture : false;
constant bool SC_USE_UV_MIN_MAX_emissiveTexture [[function_constant(1073)]];
constant bool SC_USE_UV_MIN_MAX_emissiveTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_emissiveTexture) ? SC_USE_UV_MIN_MAX_emissiveTexture : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(1074)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_metallicRoughnessTexture [[function_constant(1075)]];
constant bool SC_USE_UV_MIN_MAX_metallicRoughnessTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_metallicRoughnessTexture) ? SC_USE_UV_MIN_MAX_metallicRoughnessTexture : false;
constant bool SC_USE_UV_MIN_MAX_normalTexture [[function_constant(1076)]];
constant bool SC_USE_UV_MIN_MAX_normalTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_normalTexture) ? SC_USE_UV_MIN_MAX_normalTexture : false;
constant bool SC_USE_UV_MIN_MAX_screenTexture [[function_constant(1077)]];
constant bool SC_USE_UV_MIN_MAX_screenTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_screenTexture) ? SC_USE_UV_MIN_MAX_screenTexture : false;
constant bool SC_USE_UV_MIN_MAX_sheenColorTexture [[function_constant(1078)]];
constant bool SC_USE_UV_MIN_MAX_sheenColorTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_sheenColorTexture) ? SC_USE_UV_MIN_MAX_sheenColorTexture : false;
constant bool SC_USE_UV_MIN_MAX_sheenRoughnessTexture [[function_constant(1079)]];
constant bool SC_USE_UV_MIN_MAX_sheenRoughnessTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_sheenRoughnessTexture) ? SC_USE_UV_MIN_MAX_sheenRoughnessTexture : false;
constant bool SC_USE_UV_MIN_MAX_transmissionTexture [[function_constant(1080)]];
constant bool SC_USE_UV_MIN_MAX_transmissionTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_transmissionTexture) ? SC_USE_UV_MIN_MAX_transmissionTexture : false;
constant bool SC_USE_UV_TRANSFORM_baseColorTexture [[function_constant(1081)]];
constant bool SC_USE_UV_TRANSFORM_baseColorTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_baseColorTexture) ? SC_USE_UV_TRANSFORM_baseColorTexture : false;
constant bool SC_USE_UV_TRANSFORM_clearcoatNormalTexture [[function_constant(1082)]];
constant bool SC_USE_UV_TRANSFORM_clearcoatNormalTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_clearcoatNormalTexture) ? SC_USE_UV_TRANSFORM_clearcoatNormalTexture : false;
constant bool SC_USE_UV_TRANSFORM_clearcoatRoughnessTexture [[function_constant(1083)]];
constant bool SC_USE_UV_TRANSFORM_clearcoatRoughnessTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_clearcoatRoughnessTexture) ? SC_USE_UV_TRANSFORM_clearcoatRoughnessTexture : false;
constant bool SC_USE_UV_TRANSFORM_clearcoatTexture [[function_constant(1084)]];
constant bool SC_USE_UV_TRANSFORM_clearcoatTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_clearcoatTexture) ? SC_USE_UV_TRANSFORM_clearcoatTexture : false;
constant bool SC_USE_UV_TRANSFORM_emissiveTexture [[function_constant(1085)]];
constant bool SC_USE_UV_TRANSFORM_emissiveTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_emissiveTexture) ? SC_USE_UV_TRANSFORM_emissiveTexture : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(1086)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_metallicRoughnessTexture [[function_constant(1087)]];
constant bool SC_USE_UV_TRANSFORM_metallicRoughnessTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_metallicRoughnessTexture) ? SC_USE_UV_TRANSFORM_metallicRoughnessTexture : false;
constant bool SC_USE_UV_TRANSFORM_normalTexture [[function_constant(1088)]];
constant bool SC_USE_UV_TRANSFORM_normalTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_normalTexture) ? SC_USE_UV_TRANSFORM_normalTexture : false;
constant bool SC_USE_UV_TRANSFORM_screenTexture [[function_constant(1089)]];
constant bool SC_USE_UV_TRANSFORM_screenTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_screenTexture) ? SC_USE_UV_TRANSFORM_screenTexture : false;
constant bool SC_USE_UV_TRANSFORM_sheenColorTexture [[function_constant(1090)]];
constant bool SC_USE_UV_TRANSFORM_sheenColorTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_sheenColorTexture) ? SC_USE_UV_TRANSFORM_sheenColorTexture : false;
constant bool SC_USE_UV_TRANSFORM_sheenRoughnessTexture [[function_constant(1091)]];
constant bool SC_USE_UV_TRANSFORM_sheenRoughnessTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_sheenRoughnessTexture) ? SC_USE_UV_TRANSFORM_sheenRoughnessTexture : false;
constant bool SC_USE_UV_TRANSFORM_transmissionTexture [[function_constant(1092)]];
constant bool SC_USE_UV_TRANSFORM_transmissionTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_transmissionTexture) ? SC_USE_UV_TRANSFORM_transmissionTexture : false;
constant bool UseViewSpaceDepthVariant [[function_constant(1093)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool baseColorTextureHasSwappedViews [[function_constant(1094)]];
constant bool baseColorTextureHasSwappedViews_tmp = is_function_constant_defined(baseColorTextureHasSwappedViews) ? baseColorTextureHasSwappedViews : false;
constant bool clearcoatNormalTextureHasSwappedViews [[function_constant(1095)]];
constant bool clearcoatNormalTextureHasSwappedViews_tmp = is_function_constant_defined(clearcoatNormalTextureHasSwappedViews) ? clearcoatNormalTextureHasSwappedViews : false;
constant bool clearcoatRoughnessTextureHasSwappedViews [[function_constant(1096)]];
constant bool clearcoatRoughnessTextureHasSwappedViews_tmp = is_function_constant_defined(clearcoatRoughnessTextureHasSwappedViews) ? clearcoatRoughnessTextureHasSwappedViews : false;
constant bool clearcoatTextureHasSwappedViews [[function_constant(1097)]];
constant bool clearcoatTextureHasSwappedViews_tmp = is_function_constant_defined(clearcoatTextureHasSwappedViews) ? clearcoatTextureHasSwappedViews : false;
constant bool emissiveTextureHasSwappedViews [[function_constant(1098)]];
constant bool emissiveTextureHasSwappedViews_tmp = is_function_constant_defined(emissiveTextureHasSwappedViews) ? emissiveTextureHasSwappedViews : false;
constant bool intensityTextureHasSwappedViews [[function_constant(1099)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool metallicRoughnessTextureHasSwappedViews [[function_constant(1100)]];
constant bool metallicRoughnessTextureHasSwappedViews_tmp = is_function_constant_defined(metallicRoughnessTextureHasSwappedViews) ? metallicRoughnessTextureHasSwappedViews : false;
constant bool normalTextureHasSwappedViews [[function_constant(1101)]];
constant bool normalTextureHasSwappedViews_tmp = is_function_constant_defined(normalTextureHasSwappedViews) ? normalTextureHasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(1102)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(1103)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(1104)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(1105)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(1106)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(1107)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(1108)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(1109)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(1110)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(1111)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(1112)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(1113)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(1114)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(1115)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(1116)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_DepthOnly [[function_constant(1117)]];
constant bool sc_DepthOnly_tmp = is_function_constant_defined(sc_DepthOnly) ? sc_DepthOnly : false;
constant bool sc_EnvmapDiffuseHasSwappedViews [[function_constant(1118)]];
constant bool sc_EnvmapDiffuseHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapDiffuseHasSwappedViews) ? sc_EnvmapDiffuseHasSwappedViews : false;
constant bool sc_EnvmapSpecularHasSwappedViews [[function_constant(1119)]];
constant bool sc_EnvmapSpecularHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapSpecularHasSwappedViews) ? sc_EnvmapSpecularHasSwappedViews : false;
constant bool sc_FramebufferFetch [[function_constant(1120)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_HasDiffuseEnvmap [[function_constant(1121)]];
constant bool sc_HasDiffuseEnvmap_tmp = is_function_constant_defined(sc_HasDiffuseEnvmap) ? sc_HasDiffuseEnvmap : false;
constant bool sc_LightEstimation [[function_constant(1122)]];
constant bool sc_LightEstimation_tmp = is_function_constant_defined(sc_LightEstimation) ? sc_LightEstimation : false;
constant bool sc_MotionVectorsPass [[function_constant(1123)]];
constant bool sc_MotionVectorsPass_tmp = is_function_constant_defined(sc_MotionVectorsPass) ? sc_MotionVectorsPass : false;
constant bool sc_OITCompositingPass [[function_constant(1124)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(1125)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(1126)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(1127)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_ProjectiveShadowsReceiver [[function_constant(1128)]];
constant bool sc_ProjectiveShadowsReceiver_tmp = is_function_constant_defined(sc_ProjectiveShadowsReceiver) ? sc_ProjectiveShadowsReceiver : false;
constant bool sc_ProxyAlphaOne [[function_constant(1129)]];
constant bool sc_ProxyAlphaOne_tmp = is_function_constant_defined(sc_ProxyAlphaOne) ? sc_ProxyAlphaOne : false;
constant bool sc_RayTracedAoTextureHasSwappedViews [[function_constant(1130)]];
constant bool sc_RayTracedAoTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedAoTextureHasSwappedViews) ? sc_RayTracedAoTextureHasSwappedViews : false;
constant bool sc_RayTracedDiffIndTextureHasSwappedViews [[function_constant(1131)]];
constant bool sc_RayTracedDiffIndTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureHasSwappedViews) ? sc_RayTracedDiffIndTextureHasSwappedViews : false;
constant bool sc_RayTracedReflectionTextureHasSwappedViews [[function_constant(1132)]];
constant bool sc_RayTracedReflectionTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureHasSwappedViews) ? sc_RayTracedReflectionTextureHasSwappedViews : false;
constant bool sc_RayTracedShadowTextureHasSwappedViews [[function_constant(1133)]];
constant bool sc_RayTracedShadowTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedShadowTextureHasSwappedViews) ? sc_RayTracedShadowTextureHasSwappedViews : false;
constant bool sc_RenderAlphaToColor [[function_constant(1134)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_SSAOEnabled [[function_constant(1135)]];
constant bool sc_SSAOEnabled_tmp = is_function_constant_defined(sc_SSAOEnabled) ? sc_SSAOEnabled : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(1136)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(1137)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(1138)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant bool sc_VertexBlendingUseNormals [[function_constant(1139)]];
constant bool sc_VertexBlendingUseNormals_tmp = is_function_constant_defined(sc_VertexBlendingUseNormals) ? sc_VertexBlendingUseNormals : false;
constant bool sc_VertexBlending [[function_constant(1140)]];
constant bool sc_VertexBlending_tmp = is_function_constant_defined(sc_VertexBlending) ? sc_VertexBlending : false;
constant bool screenTextureHasSwappedViews [[function_constant(1141)]];
constant bool screenTextureHasSwappedViews_tmp = is_function_constant_defined(screenTextureHasSwappedViews) ? screenTextureHasSwappedViews : false;
constant bool sheenColorTextureHasSwappedViews [[function_constant(1142)]];
constant bool sheenColorTextureHasSwappedViews_tmp = is_function_constant_defined(sheenColorTextureHasSwappedViews) ? sheenColorTextureHasSwappedViews : false;
constant bool sheenRoughnessTextureHasSwappedViews [[function_constant(1143)]];
constant bool sheenRoughnessTextureHasSwappedViews_tmp = is_function_constant_defined(sheenRoughnessTextureHasSwappedViews) ? sheenRoughnessTextureHasSwappedViews : false;
constant bool transmissionTextureHasSwappedViews [[function_constant(1144)]];
constant bool transmissionTextureHasSwappedViews_tmp = is_function_constant_defined(transmissionTextureHasSwappedViews) ? transmissionTextureHasSwappedViews : false;
constant int NODE_10_DROPLIST_ITEM [[function_constant(1145)]];
constant int NODE_10_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_10_DROPLIST_ITEM) ? NODE_10_DROPLIST_ITEM : 0;
constant int NODE_11_DROPLIST_ITEM [[function_constant(1146)]];
constant int NODE_11_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_11_DROPLIST_ITEM) ? NODE_11_DROPLIST_ITEM : 0;
constant int NODE_7_DROPLIST_ITEM [[function_constant(1147)]];
constant int NODE_7_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_7_DROPLIST_ITEM) ? NODE_7_DROPLIST_ITEM : 0;
constant int NODE_8_DROPLIST_ITEM [[function_constant(1148)]];
constant int NODE_8_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_8_DROPLIST_ITEM) ? NODE_8_DROPLIST_ITEM : 0;
constant int SC_DEVICE_CLASS [[function_constant(1149)]];
constant int SC_DEVICE_CLASS_tmp = is_function_constant_defined(SC_DEVICE_CLASS) ? SC_DEVICE_CLASS : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_baseColorTexture [[function_constant(1150)]];
constant int SC_SOFTWARE_WRAP_MODE_U_baseColorTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_baseColorTexture) ? SC_SOFTWARE_WRAP_MODE_U_baseColorTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_clearcoatNormalTexture [[function_constant(1151)]];
constant int SC_SOFTWARE_WRAP_MODE_U_clearcoatNormalTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_clearcoatNormalTexture) ? SC_SOFTWARE_WRAP_MODE_U_clearcoatNormalTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_clearcoatRoughnessTexture [[function_constant(1152)]];
constant int SC_SOFTWARE_WRAP_MODE_U_clearcoatRoughnessTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_clearcoatRoughnessTexture) ? SC_SOFTWARE_WRAP_MODE_U_clearcoatRoughnessTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_clearcoatTexture [[function_constant(1153)]];
constant int SC_SOFTWARE_WRAP_MODE_U_clearcoatTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_clearcoatTexture) ? SC_SOFTWARE_WRAP_MODE_U_clearcoatTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_emissiveTexture [[function_constant(1154)]];
constant int SC_SOFTWARE_WRAP_MODE_U_emissiveTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_emissiveTexture) ? SC_SOFTWARE_WRAP_MODE_U_emissiveTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(1155)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_metallicRoughnessTexture [[function_constant(1156)]];
constant int SC_SOFTWARE_WRAP_MODE_U_metallicRoughnessTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_metallicRoughnessTexture) ? SC_SOFTWARE_WRAP_MODE_U_metallicRoughnessTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_normalTexture [[function_constant(1157)]];
constant int SC_SOFTWARE_WRAP_MODE_U_normalTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_normalTexture) ? SC_SOFTWARE_WRAP_MODE_U_normalTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_screenTexture [[function_constant(1158)]];
constant int SC_SOFTWARE_WRAP_MODE_U_screenTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_screenTexture) ? SC_SOFTWARE_WRAP_MODE_U_screenTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_sheenColorTexture [[function_constant(1159)]];
constant int SC_SOFTWARE_WRAP_MODE_U_sheenColorTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_sheenColorTexture) ? SC_SOFTWARE_WRAP_MODE_U_sheenColorTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_sheenRoughnessTexture [[function_constant(1160)]];
constant int SC_SOFTWARE_WRAP_MODE_U_sheenRoughnessTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_sheenRoughnessTexture) ? SC_SOFTWARE_WRAP_MODE_U_sheenRoughnessTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_transmissionTexture [[function_constant(1161)]];
constant int SC_SOFTWARE_WRAP_MODE_U_transmissionTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_transmissionTexture) ? SC_SOFTWARE_WRAP_MODE_U_transmissionTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_baseColorTexture [[function_constant(1162)]];
constant int SC_SOFTWARE_WRAP_MODE_V_baseColorTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_baseColorTexture) ? SC_SOFTWARE_WRAP_MODE_V_baseColorTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_clearcoatNormalTexture [[function_constant(1163)]];
constant int SC_SOFTWARE_WRAP_MODE_V_clearcoatNormalTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_clearcoatNormalTexture) ? SC_SOFTWARE_WRAP_MODE_V_clearcoatNormalTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_clearcoatRoughnessTexture [[function_constant(1164)]];
constant int SC_SOFTWARE_WRAP_MODE_V_clearcoatRoughnessTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_clearcoatRoughnessTexture) ? SC_SOFTWARE_WRAP_MODE_V_clearcoatRoughnessTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_clearcoatTexture [[function_constant(1165)]];
constant int SC_SOFTWARE_WRAP_MODE_V_clearcoatTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_clearcoatTexture) ? SC_SOFTWARE_WRAP_MODE_V_clearcoatTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_emissiveTexture [[function_constant(1166)]];
constant int SC_SOFTWARE_WRAP_MODE_V_emissiveTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_emissiveTexture) ? SC_SOFTWARE_WRAP_MODE_V_emissiveTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(1167)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_metallicRoughnessTexture [[function_constant(1168)]];
constant int SC_SOFTWARE_WRAP_MODE_V_metallicRoughnessTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_metallicRoughnessTexture) ? SC_SOFTWARE_WRAP_MODE_V_metallicRoughnessTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_normalTexture [[function_constant(1169)]];
constant int SC_SOFTWARE_WRAP_MODE_V_normalTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_normalTexture) ? SC_SOFTWARE_WRAP_MODE_V_normalTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_screenTexture [[function_constant(1170)]];
constant int SC_SOFTWARE_WRAP_MODE_V_screenTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_screenTexture) ? SC_SOFTWARE_WRAP_MODE_V_screenTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_sheenColorTexture [[function_constant(1171)]];
constant int SC_SOFTWARE_WRAP_MODE_V_sheenColorTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_sheenColorTexture) ? SC_SOFTWARE_WRAP_MODE_V_sheenColorTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_sheenRoughnessTexture [[function_constant(1172)]];
constant int SC_SOFTWARE_WRAP_MODE_V_sheenRoughnessTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_sheenRoughnessTexture) ? SC_SOFTWARE_WRAP_MODE_V_sheenRoughnessTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_transmissionTexture [[function_constant(1173)]];
constant int SC_SOFTWARE_WRAP_MODE_V_transmissionTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_transmissionTexture) ? SC_SOFTWARE_WRAP_MODE_V_transmissionTexture : -1;
constant int Tweak_N30 [[function_constant(1174)]];
constant int Tweak_N30_tmp = is_function_constant_defined(Tweak_N30) ? Tweak_N30 : 0;
constant int Tweak_N32 [[function_constant(1175)]];
constant int Tweak_N32_tmp = is_function_constant_defined(Tweak_N32) ? Tweak_N32 : 0;
constant int Tweak_N37 [[function_constant(1176)]];
constant int Tweak_N37_tmp = is_function_constant_defined(Tweak_N37) ? Tweak_N37 : 0;
constant int Tweak_N44 [[function_constant(1177)]];
constant int Tweak_N44_tmp = is_function_constant_defined(Tweak_N44) ? Tweak_N44 : 0;
constant int Tweak_N47 [[function_constant(1178)]];
constant int Tweak_N47_tmp = is_function_constant_defined(Tweak_N47) ? Tweak_N47 : 0;
constant int Tweak_N60 [[function_constant(1179)]];
constant int Tweak_N60_tmp = is_function_constant_defined(Tweak_N60) ? Tweak_N60 : 0;
constant int baseColorTextureLayout [[function_constant(1180)]];
constant int baseColorTextureLayout_tmp = is_function_constant_defined(baseColorTextureLayout) ? baseColorTextureLayout : 0;
constant int clearcoatNormalTextureLayout [[function_constant(1181)]];
constant int clearcoatNormalTextureLayout_tmp = is_function_constant_defined(clearcoatNormalTextureLayout) ? clearcoatNormalTextureLayout : 0;
constant int clearcoatRoughnessTextureLayout [[function_constant(1182)]];
constant int clearcoatRoughnessTextureLayout_tmp = is_function_constant_defined(clearcoatRoughnessTextureLayout) ? clearcoatRoughnessTextureLayout : 0;
constant int clearcoatTextureLayout [[function_constant(1183)]];
constant int clearcoatTextureLayout_tmp = is_function_constant_defined(clearcoatTextureLayout) ? clearcoatTextureLayout : 0;
constant int emissiveTextureLayout [[function_constant(1184)]];
constant int emissiveTextureLayout_tmp = is_function_constant_defined(emissiveTextureLayout) ? emissiveTextureLayout : 0;
constant int intensityTextureLayout [[function_constant(1185)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int metallicRoughnessTextureLayout [[function_constant(1186)]];
constant int metallicRoughnessTextureLayout_tmp = is_function_constant_defined(metallicRoughnessTextureLayout) ? metallicRoughnessTextureLayout : 0;
constant int normalTextureLayout [[function_constant(1187)]];
constant int normalTextureLayout_tmp = is_function_constant_defined(normalTextureLayout) ? normalTextureLayout : 0;
constant int sc_AmbientLightMode0 [[function_constant(1188)]];
constant int sc_AmbientLightMode0_tmp = is_function_constant_defined(sc_AmbientLightMode0) ? sc_AmbientLightMode0 : 0;
constant int sc_AmbientLightMode1 [[function_constant(1189)]];
constant int sc_AmbientLightMode1_tmp = is_function_constant_defined(sc_AmbientLightMode1) ? sc_AmbientLightMode1 : 0;
constant int sc_AmbientLightMode2 [[function_constant(1190)]];
constant int sc_AmbientLightMode2_tmp = is_function_constant_defined(sc_AmbientLightMode2) ? sc_AmbientLightMode2 : 0;
constant int sc_AmbientLightMode_Constant [[function_constant(1191)]];
constant int sc_AmbientLightMode_Constant_tmp = is_function_constant_defined(sc_AmbientLightMode_Constant) ? sc_AmbientLightMode_Constant : 0;
constant int sc_AmbientLightMode_EnvironmentMap [[function_constant(1192)]];
constant int sc_AmbientLightMode_EnvironmentMap_tmp = is_function_constant_defined(sc_AmbientLightMode_EnvironmentMap) ? sc_AmbientLightMode_EnvironmentMap : 0;
constant int sc_AmbientLightMode_FromCamera [[function_constant(1193)]];
constant int sc_AmbientLightMode_FromCamera_tmp = is_function_constant_defined(sc_AmbientLightMode_FromCamera) ? sc_AmbientLightMode_FromCamera : 0;
constant int sc_AmbientLightMode_SphericalHarmonics [[function_constant(1194)]];
constant int sc_AmbientLightMode_SphericalHarmonics_tmp = is_function_constant_defined(sc_AmbientLightMode_SphericalHarmonics) ? sc_AmbientLightMode_SphericalHarmonics : 0;
constant int sc_AmbientLightsCount [[function_constant(1195)]];
constant int sc_AmbientLightsCount_tmp = is_function_constant_defined(sc_AmbientLightsCount) ? sc_AmbientLightsCount : 0;
constant int sc_DepthBufferMode [[function_constant(1196)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_DirectionalLightsCount [[function_constant(1197)]];
constant int sc_DirectionalLightsCount_tmp = is_function_constant_defined(sc_DirectionalLightsCount) ? sc_DirectionalLightsCount : 0;
constant int sc_EnvLightMode [[function_constant(1198)]];
constant int sc_EnvLightMode_tmp = is_function_constant_defined(sc_EnvLightMode) ? sc_EnvLightMode : 0;
constant int sc_EnvmapDiffuseLayout [[function_constant(1199)]];
constant int sc_EnvmapDiffuseLayout_tmp = is_function_constant_defined(sc_EnvmapDiffuseLayout) ? sc_EnvmapDiffuseLayout : 0;
constant int sc_EnvmapSpecularLayout [[function_constant(1200)]];
constant int sc_EnvmapSpecularLayout_tmp = is_function_constant_defined(sc_EnvmapSpecularLayout) ? sc_EnvmapSpecularLayout : 0;
constant int sc_LightEstimationSGCount [[function_constant(1201)]];
constant int sc_LightEstimationSGCount_tmp = is_function_constant_defined(sc_LightEstimationSGCount) ? sc_LightEstimationSGCount : 0;
constant int sc_MaxTextureImageUnits [[function_constant(1202)]];
constant int sc_MaxTextureImageUnits_tmp = is_function_constant_defined(sc_MaxTextureImageUnits) ? sc_MaxTextureImageUnits : 0;
constant int sc_PointLightsCount [[function_constant(1203)]];
constant int sc_PointLightsCount_tmp = is_function_constant_defined(sc_PointLightsCount) ? sc_PointLightsCount : 0;
constant int sc_RayTracedAoTextureLayout [[function_constant(1204)]];
constant int sc_RayTracedAoTextureLayout_tmp = is_function_constant_defined(sc_RayTracedAoTextureLayout) ? sc_RayTracedAoTextureLayout : 0;
constant int sc_RayTracedDiffIndTextureLayout [[function_constant(1205)]];
constant int sc_RayTracedDiffIndTextureLayout_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureLayout) ? sc_RayTracedDiffIndTextureLayout : 0;
constant int sc_RayTracedReflectionTextureLayout [[function_constant(1206)]];
constant int sc_RayTracedReflectionTextureLayout_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureLayout) ? sc_RayTracedReflectionTextureLayout : 0;
constant int sc_RayTracedShadowTextureLayout [[function_constant(1207)]];
constant int sc_RayTracedShadowTextureLayout_tmp = is_function_constant_defined(sc_RayTracedShadowTextureLayout) ? sc_RayTracedShadowTextureLayout : 0;
constant int sc_RenderingSpace [[function_constant(1208)]];
constant int sc_RenderingSpace_tmp = is_function_constant_defined(sc_RenderingSpace) ? sc_RenderingSpace : -1;
constant int sc_ScreenTextureLayout [[function_constant(1209)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_SkinBonesCount [[function_constant(1210)]];
constant int sc_SkinBonesCount_tmp = is_function_constant_defined(sc_SkinBonesCount) ? sc_SkinBonesCount : 0;
constant int sc_StereoRenderingMode [[function_constant(1211)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1212)]];
constant int sc_StereoRendering_IsClipDistanceEnabled_tmp = is_function_constant_defined(sc_StereoRendering_IsClipDistanceEnabled) ? sc_StereoRendering_IsClipDistanceEnabled : 0;
constant int screenTextureLayout [[function_constant(1213)]];
constant int screenTextureLayout_tmp = is_function_constant_defined(screenTextureLayout) ? screenTextureLayout : 0;
constant int sheenColorTextureLayout [[function_constant(1214)]];
constant int sheenColorTextureLayout_tmp = is_function_constant_defined(sheenColorTextureLayout) ? sheenColorTextureLayout : 0;
constant int sheenRoughnessTextureLayout [[function_constant(1215)]];
constant int sheenRoughnessTextureLayout_tmp = is_function_constant_defined(sheenRoughnessTextureLayout) ? sheenRoughnessTextureLayout : 0;
constant int transmissionTextureLayout [[function_constant(1216)]];
constant int transmissionTextureLayout_tmp = is_function_constant_defined(transmissionTextureLayout) ? transmissionTextureLayout : 0;

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
float3 emissiveFactor;
float4 emissiveTextureSize;
float4 emissiveTextureDims;
float4 emissiveTextureView;
float3x3 emissiveTextureTransform;
float4 emissiveTextureUvMinMax;
float4 emissiveTextureBorderColor;
float normalTextureScale;
float4 normalTextureSize;
float4 normalTextureDims;
float4 normalTextureView;
float3x3 normalTextureTransform;
float4 normalTextureUvMinMax;
float4 normalTextureBorderColor;
float metallicFactor;
float roughnessFactor;
float occlusionTextureStrength;
float4 metallicRoughnessTextureSize;
float4 metallicRoughnessTextureDims;
float4 metallicRoughnessTextureView;
float3x3 metallicRoughnessTextureTransform;
float4 metallicRoughnessTextureUvMinMax;
float4 metallicRoughnessTextureBorderColor;
float transmissionFactor;
float4 transmissionTextureSize;
float4 transmissionTextureDims;
float4 transmissionTextureView;
float3x3 transmissionTextureTransform;
float4 transmissionTextureUvMinMax;
float4 transmissionTextureBorderColor;
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
float3 sheenColorFactor;
float4 sheenColorTextureSize;
float4 sheenColorTextureDims;
float4 sheenColorTextureView;
float3x3 sheenColorTextureTransform;
float4 sheenColorTextureUvMinMax;
float4 sheenColorTextureBorderColor;
float sheenRoughnessFactor;
float4 sheenRoughnessTextureSize;
float4 sheenRoughnessTextureDims;
float4 sheenRoughnessTextureView;
float3x3 sheenRoughnessTextureTransform;
float4 sheenRoughnessTextureUvMinMax;
float4 sheenRoughnessTextureBorderColor;
float clearcoatFactor;
float4 clearcoatTextureSize;
float4 clearcoatTextureDims;
float4 clearcoatTextureView;
float3x3 clearcoatTextureTransform;
float4 clearcoatTextureUvMinMax;
float4 clearcoatTextureBorderColor;
float clearcoatRoughnessFactor;
float4 clearcoatRoughnessTextureSize;
float4 clearcoatRoughnessTextureDims;
float4 clearcoatRoughnessTextureView;
float3x3 clearcoatRoughnessTextureTransform;
float4 clearcoatRoughnessTextureUvMinMax;
float4 clearcoatRoughnessTextureBorderColor;
float4 clearcoatNormalTextureSize;
float4 clearcoatNormalTextureDims;
float4 clearcoatNormalTextureView;
float3x3 clearcoatNormalTextureTransform;
float4 clearcoatNormalTextureUvMinMax;
float4 clearcoatNormalTextureBorderColor;
float4 baseColorTextureSize;
float4 baseColorTextureDims;
float4 baseColorTextureView;
float3x3 baseColorTextureTransform;
float4 baseColorTextureUvMinMax;
float4 baseColorTextureBorderColor;
float4 baseColorFactor;
float2 baseColorTexture_offset;
float2 baseColorTexture_scale;
float baseColorTexture_rotation;
float2 emissiveTexture_offset;
float2 emissiveTexture_scale;
float emissiveTexture_rotation;
float2 normalTexture_offset;
float2 normalTexture_scale;
float normalTexture_rotation;
float2 metallicRoughnessTexture_offset;
float2 metallicRoughnessTexture_scale;
float metallicRoughnessTexture_rotation;
float2 transmissionTexture_offset;
float2 transmissionTexture_scale;
float transmissionTexture_rotation;
float2 sheenColorTexture_offset;
float2 sheenColorTexture_scale;
float sheenColorTexture_rotation;
float2 sheenRoughnessTexture_offset;
float2 sheenRoughnessTexture_scale;
float sheenRoughnessTexture_rotation;
float2 clearcoatTexture_offset;
float2 clearcoatTexture_scale;
float clearcoatTexture_rotation;
float2 clearcoatNormalTexture_offset;
float2 clearcoatNormalTexture_scale;
float clearcoatNormalTexture_rotation;
float2 clearcoatRoughnessTexture_offset;
float2 clearcoatRoughnessTexture_scale;
float clearcoatRoughnessTexture_rotation;
float Port_DebugSheenEnvLightMult_N003;
float Port_DebugSheenPunctualLightMult_N003;
float Port_Input2_N043;
float Port_Input2_N062;
float3 Port_SpecularAO_N036;
float3 Port_Albedo_N405;
float Port_Opacity_N405;
float3 Port_Emissive_N405;
float Port_Metallic_N405;
float3 Port_SpecularAO_N405;
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
texture2d<float> baseColorTexture [[id(4)]];
texture2d<float> clearcoatNormalTexture [[id(5)]];
texture2d<float> clearcoatRoughnessTexture [[id(6)]];
texture2d<float> clearcoatTexture [[id(7)]];
texture2d<float> emissiveTexture [[id(8)]];
texture2d<float> intensityTexture [[id(9)]];
texture2d<float> metallicRoughnessTexture [[id(10)]];
texture2d<float> normalTexture [[id(11)]];
texture2d<float> sc_EnvmapDiffuse [[id(12)]];
texture2d<float> sc_EnvmapSpecular [[id(13)]];
texture2d<float> sc_RayTracedAoTexture [[id(22)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(23)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(24)]];
texture2d<float> sc_RayTracedShadowTexture [[id(25)]];
texture2d<float> sc_SSAOTexture [[id(26)]];
texture2d<float> sc_ScreenTexture [[id(27)]];
texture2d<float> sc_ShadowTexture [[id(28)]];
texture2d<float> screenTexture [[id(30)]];
texture2d<float> sheenColorTexture [[id(31)]];
texture2d<float> sheenRoughnessTexture [[id(32)]];
texture2d<float> transmissionTexture [[id(33)]];
texture2d<uint> z_hitIdAndBarycentric [[id(34)]];
texture2d<float> z_rayDirections [[id(35)]];
sampler baseColorTextureSmpSC [[id(36)]];
sampler clearcoatNormalTextureSmpSC [[id(37)]];
sampler clearcoatRoughnessTextureSmpSC [[id(38)]];
sampler clearcoatTextureSmpSC [[id(39)]];
sampler emissiveTextureSmpSC [[id(40)]];
sampler intensityTextureSmpSC [[id(41)]];
sampler metallicRoughnessTextureSmpSC [[id(42)]];
sampler normalTextureSmpSC [[id(43)]];
sampler sc_EnvmapDiffuseSmpSC [[id(44)]];
sampler sc_EnvmapSpecularSmpSC [[id(45)]];
sampler sc_RayTracedAoTextureSmpSC [[id(47)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(48)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(49)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(50)]];
sampler sc_SSAOTextureSmpSC [[id(51)]];
sampler sc_ScreenTextureSmpSC [[id(52)]];
sampler sc_ShadowTextureSmpSC [[id(53)]];
sampler screenTextureSmpSC [[id(55)]];
sampler sheenColorTextureSmpSC [[id(56)]];
sampler sheenRoughnessTextureSmpSC [[id(57)]];
sampler transmissionTextureSmpSC [[id(58)]];
sampler z_hitIdAndBarycentricSmp [[id(59)]];
sampler z_rayDirectionsSmpSC [[id(60)]];
constant userUniformsObj* UserUniforms [[id(61)]];
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
float3 SurfacePosition_WorldSpace;
float3 VertexNormal_WorldSpace;
float3 VertexTangent_WorldSpace;
float3 VertexBinormal_WorldSpace;
float2 Surface_UVCoord0;
float2 Surface_UVCoord1;
float2 gScreenCoord;
float4 VertexColor;
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
float3 emissiveFactor;
float4 emissiveTextureSize;
float4 emissiveTextureDims;
float4 emissiveTextureView;
float3x3 emissiveTextureTransform;
float4 emissiveTextureUvMinMax;
float4 emissiveTextureBorderColor;
float normalTextureScale;
float4 normalTextureSize;
float4 normalTextureDims;
float4 normalTextureView;
float3x3 normalTextureTransform;
float4 normalTextureUvMinMax;
float4 normalTextureBorderColor;
float metallicFactor;
float roughnessFactor;
float occlusionTextureStrength;
float4 metallicRoughnessTextureSize;
float4 metallicRoughnessTextureDims;
float4 metallicRoughnessTextureView;
float3x3 metallicRoughnessTextureTransform;
float4 metallicRoughnessTextureUvMinMax;
float4 metallicRoughnessTextureBorderColor;
float transmissionFactor;
float4 transmissionTextureSize;
float4 transmissionTextureDims;
float4 transmissionTextureView;
float3x3 transmissionTextureTransform;
float4 transmissionTextureUvMinMax;
float4 transmissionTextureBorderColor;
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
float3 sheenColorFactor;
float4 sheenColorTextureSize;
float4 sheenColorTextureDims;
float4 sheenColorTextureView;
float3x3 sheenColorTextureTransform;
float4 sheenColorTextureUvMinMax;
float4 sheenColorTextureBorderColor;
float sheenRoughnessFactor;
float4 sheenRoughnessTextureSize;
float4 sheenRoughnessTextureDims;
float4 sheenRoughnessTextureView;
float3x3 sheenRoughnessTextureTransform;
float4 sheenRoughnessTextureUvMinMax;
float4 sheenRoughnessTextureBorderColor;
float clearcoatFactor;
float4 clearcoatTextureSize;
float4 clearcoatTextureDims;
float4 clearcoatTextureView;
float3x3 clearcoatTextureTransform;
float4 clearcoatTextureUvMinMax;
float4 clearcoatTextureBorderColor;
float clearcoatRoughnessFactor;
float4 clearcoatRoughnessTextureSize;
float4 clearcoatRoughnessTextureDims;
float4 clearcoatRoughnessTextureView;
float3x3 clearcoatRoughnessTextureTransform;
float4 clearcoatRoughnessTextureUvMinMax;
float4 clearcoatRoughnessTextureBorderColor;
float4 clearcoatNormalTextureSize;
float4 clearcoatNormalTextureDims;
float4 clearcoatNormalTextureView;
float3x3 clearcoatNormalTextureTransform;
float4 clearcoatNormalTextureUvMinMax;
float4 clearcoatNormalTextureBorderColor;
float4 baseColorTextureSize;
float4 baseColorTextureDims;
float4 baseColorTextureView;
float3x3 baseColorTextureTransform;
float4 baseColorTextureUvMinMax;
float4 baseColorTextureBorderColor;
float4 baseColorFactor;
float2 baseColorTexture_offset;
float2 baseColorTexture_scale;
float baseColorTexture_rotation;
float2 emissiveTexture_offset;
float2 emissiveTexture_scale;
float emissiveTexture_rotation;
float2 normalTexture_offset;
float2 normalTexture_scale;
float normalTexture_rotation;
float2 metallicRoughnessTexture_offset;
float2 metallicRoughnessTexture_scale;
float metallicRoughnessTexture_rotation;
float2 transmissionTexture_offset;
float2 transmissionTexture_scale;
float transmissionTexture_rotation;
float2 sheenColorTexture_offset;
float2 sheenColorTexture_scale;
float sheenColorTexture_rotation;
float2 sheenRoughnessTexture_offset;
float2 sheenRoughnessTexture_scale;
float sheenRoughnessTexture_rotation;
float2 clearcoatTexture_offset;
float2 clearcoatTexture_scale;
float clearcoatTexture_rotation;
float2 clearcoatNormalTexture_offset;
float2 clearcoatNormalTexture_scale;
float clearcoatNormalTexture_rotation;
float2 clearcoatRoughnessTexture_offset;
float2 clearcoatRoughnessTexture_scale;
float clearcoatRoughnessTexture_rotation;
float Port_DebugSheenEnvLightMult_N003;
float Port_DebugSheenPunctualLightMult_N003;
float Port_Input2_N043;
float Port_Input2_N062;
float3 Port_SpecularAO_N036;
float3 Port_Albedo_N405;
float Port_Opacity_N405;
float3 Port_Emissive_N405;
float Port_Metallic_N405;
float3 Port_SpecularAO_N405;
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
texture2d<float> baseColorTexture [[id(4)]];
texture2d<float> clearcoatNormalTexture [[id(5)]];
texture2d<float> clearcoatRoughnessTexture [[id(6)]];
texture2d<float> clearcoatTexture [[id(7)]];
texture2d<float> emissiveTexture [[id(8)]];
texture2d<float> intensityTexture [[id(9)]];
texture2d<float> metallicRoughnessTexture [[id(10)]];
texture2d<float> normalTexture [[id(11)]];
texture2d<float> sc_EnvmapDiffuse [[id(12)]];
texture2d<float> sc_EnvmapSpecular [[id(13)]];
texture2d<float> sc_RayTracedAoTexture [[id(22)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(23)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(24)]];
texture2d<float> sc_RayTracedShadowTexture [[id(25)]];
texture2d<float> sc_SSAOTexture [[id(26)]];
texture2d<float> sc_ScreenTexture [[id(27)]];
texture2d<float> sc_ShadowTexture [[id(28)]];
texture2d<float> screenTexture [[id(30)]];
texture2d<float> sheenColorTexture [[id(31)]];
texture2d<float> sheenRoughnessTexture [[id(32)]];
texture2d<float> transmissionTexture [[id(33)]];
texture2d<uint> z_hitIdAndBarycentric [[id(34)]];
texture2d<float> z_rayDirections [[id(35)]];
sampler baseColorTextureSmpSC [[id(36)]];
sampler clearcoatNormalTextureSmpSC [[id(37)]];
sampler clearcoatRoughnessTextureSmpSC [[id(38)]];
sampler clearcoatTextureSmpSC [[id(39)]];
sampler emissiveTextureSmpSC [[id(40)]];
sampler intensityTextureSmpSC [[id(41)]];
sampler metallicRoughnessTextureSmpSC [[id(42)]];
sampler normalTextureSmpSC [[id(43)]];
sampler sc_EnvmapDiffuseSmpSC [[id(44)]];
sampler sc_EnvmapSpecularSmpSC [[id(45)]];
sampler sc_RayTracedAoTextureSmpSC [[id(47)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(48)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(49)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(50)]];
sampler sc_SSAOTextureSmpSC [[id(51)]];
sampler sc_ScreenTextureSmpSC [[id(52)]];
sampler sc_ShadowTextureSmpSC [[id(53)]];
sampler screenTextureSmpSC [[id(55)]];
sampler sheenColorTextureSmpSC [[id(56)]];
sampler sheenRoughnessTextureSmpSC [[id(57)]];
sampler transmissionTextureSmpSC [[id(58)]];
sampler z_hitIdAndBarycentricSmp [[id(59)]];
sampler z_rayDirectionsSmpSC [[id(60)]];
constant userUniformsObj* UserUniforms [[id(61)]];
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
// Implementation of the GLSL radians() function
template<typename T>
T radians(T d)
{
return d*T(0.01745329251);
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
float4 N31_PbrIn=float4(0.0);
bool N31_EnableTransmission=false;
float N31_Opacity=0.0;
float3 N31_Background=float3(0.0);
bool N31_EnableSheen=false;
float4 N31_SheenColor=float4(0.0);
bool N31_EnableClearcoat=false;
float N31_ClearcoatBase=0.0;
float4 N31_ClearcoatColor=float4(0.0);
float4 N31_Result=float4(0.0);
float3 N3_EmissiveColor=float3(0.0);
bool N3_EnableEmissiveTexture=false;
int N3_EmissiveTextureCoord=0;
bool N3_EnableNormalTexture=false;
float N3_NormalScale=0.0;
int N3_NormalTextureCoord=0;
float N3_MetallicValue=0.0;
float N3_RoughnessValue=0.0;
bool N3_EnableMetallicRoughnessTexture=false;
float N3_OcclusionStrength=0.0;
int N3_MaterialParamsTextureCoord=0;
bool N3_TransmissionEnable=false;
float N3_TransmissionFactor=0.0;
bool N3_EnableTransmissionTexture=false;
int N3_TransmissionTextureCoord=0;
bool N3_SheenEnable=false;
float3 N3_SheenColorFactor=float3(0.0);
bool N3_EnableSheenTexture=false;
int N3_SheenColorTextureCoord=0;
float N3_SheenRoughnessFactor=0.0;
bool N3_EnableSheenRoughnessTexture=false;
int N3_SheenRoughnessTextureCoord=0;
bool N3_ClearcoatEnable=false;
float N3_ClearcoatFactor=0.0;
bool N3_EnableClearcoatTexture=false;
int N3_ClearcoatTextureCoord=0;
float N3_ClearcoatRoughnessFactor=0.0;
bool N3_EnableClearCoatRoughnessTexture=false;
int N3_ClearcoatRoughnessTextureCoord=0;
bool N3_EnableClearCoatNormalTexture=false;
int N3_ClearcoatNormalMapCoord=0;
float3 N3_BaseColorIn=float3(0.0);
float N3_OpacityIn=0.0;
bool N3_EnableTextureTransform=false;
bool N3_EmissiveTextureTransform=false;
float2 N3_EmissiveTextureOffset=float2(0.0);
float2 N3_EmissiveTextureScale=float2(0.0);
float N3_EmissiveTextureRotation=0.0;
bool N3_NormalTextureTransform=false;
float2 N3_NormalTextureOffset=float2(0.0);
float2 N3_NormalTextureScale=float2(0.0);
float N3_NormalTextureRotation=0.0;
bool N3_MaterialParamsTextureTransform=false;
float2 N3_MaterialParamsTextureOffset=float2(0.0);
float2 N3_MaterialParamsTextureScale=float2(0.0);
float N3_MaterialParamsTextureRotation=0.0;
bool N3_TransmissionTextureTransform=false;
float2 N3_TransmissionTextureOffset=float2(0.0);
float2 N3_TransmissionTextureScale=float2(0.0);
float N3_TransmissionTextureRotation=0.0;
bool N3_SheenColorTextureTransform=false;
float2 N3_SheenColorTextureOffset=float2(0.0);
float2 N3_SheenColorTextureScale=float2(0.0);
float N3_SheenColorTextureRotation=0.0;
bool N3_SheenRoughnessTextureTransform=false;
float2 N3_SheenRoughnessTextureOffset=float2(0.0);
float2 N3_SheenRoughnessTextureScale=float2(0.0);
float N3_SheenRoughnessTextureRotation=0.0;
bool N3_ClearcoatTextureTransform=false;
float2 N3_ClearcoatTextureOffset=float2(0.0);
float2 N3_ClearcoatTextureScale=float2(0.0);
float N3_ClearcoatTextureRotation=0.0;
bool N3_ClearcoatNormalTextureTransform=false;
float2 N3_ClearcoatNormalTextureOffset=float2(0.0);
float2 N3_ClearcoatNormalTextureScale=float2(0.0);
float N3_ClearcoatNormalTextureRotation=0.0;
bool N3_ClearcoatRoughnessTextureTransform=false;
float2 N3_ClearcoatRoughnessTextureOffset=float2(0.0);
float2 N3_ClearcoatRoughnessTextureScale=float2(0.0);
float N3_ClearcoatRoughnessTextureRotation=0.0;
float3 N3_BaseColor=float3(0.0);
float N3_Opacity=0.0;
float3 N3_Normal=float3(0.0);
float3 N3_Emissive=float3(0.0);
float N3_Metallic=0.0;
float N3_Roughness=0.0;
float4 N3_Occlusion=float4(0.0);
float3 N3_Background=float3(0.0);
float4 N3_SheenOut=float4(0.0);
float N3_ClearcoatBase=0.0;
float3 N3_ClearcoatNormal=float3(0.0);
float N3_ClearcoatRoughness=0.0;
bool N35_EnableVertexColor=false;
bool N35_EnableBaseTexture=false;
int N35_BaseColorTextureCoord=0;
float4 N35_BaseColorFactor=float4(0.0);
bool N35_EnableTextureTransform=false;
bool N35_BaseTextureTransform=false;
float2 N35_BaseTextureOffset=float2(0.0);
float2 N35_BaseTextureScale=float2(0.0);
float N35_BaseTextureRotation=0.0;
float3 N35_BaseColor=float3(0.0);
float N35_Opacity=0.0;
float4 N35_UnlitColor=float4(0.0);
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
Globals.SurfacePosition_WorldSpace=rhp.positionWS;
Globals.VertexNormal_WorldSpace=rhp.normalWS;
Globals.VertexTangent_WorldSpace=rhp.tangentWS.xyz;
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*rhp.tangentWS.w;
Globals.Surface_UVCoord0=rhp.uv0;
Globals.Surface_UVCoord1=rhp.uv1;
int l9_7=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_7=0;
}
else
{
l9_7=in.varStereoViewID;
}
int l9_8=l9_7;
float4 emitterPositionCS=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_8]*float4(rhp.positionWS,1.0);
Globals.gScreenCoord=((emitterPositionCS.xy/float2(emitterPositionCS.w))*0.5)+float2(0.5);
Globals.VertexColor=rhp.color;
}
else
{
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-in.varPos);
Globals.PositionWS=in.varPos;
Globals.SurfacePosition_WorldSpace=in.varPos;
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.VertexTangent_WorldSpace=normalize(in.varTangent.xyz);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*in.varTangent.w;
Globals.Surface_UVCoord0=in.varPackedTex.xy;
Globals.Surface_UVCoord1=in.varPackedTex.zw;
float4 l9_9=gl_FragCoord;
float2 l9_10=(l9_9.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_11=l9_10;
float2 l9_12=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_13=1;
int l9_14=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_14=0;
}
else
{
l9_14=in.varStereoViewID;
}
int l9_15=l9_14;
int l9_16=l9_15;
float3 l9_17=float3(l9_11,0.0);
int l9_18=l9_13;
int l9_19=l9_16;
if (l9_18==1)
{
l9_17.y=((2.0*l9_17.y)+float(l9_19))-1.0;
}
float2 l9_20=l9_17.xy;
l9_12=l9_20;
}
else
{
l9_12=l9_11;
}
float2 l9_21=l9_12;
float2 l9_22=l9_21;
float2 l9_23=l9_22;
Globals.gScreenCoord=l9_23;
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-Globals.SurfacePosition_WorldSpace);
Globals.VertexColor=in.varColor;
}
float4 Output_N17=float4(0.0);
float4 param=float4(1.0);
float4 param_1=float4(0.0);
ssGlobals param_3=Globals;
ssGlobals tempGlobals;
float4 param_2;
if ((int(ENABLE_GLTF_LIGHTING_tmp)!=0))
{
float3 l9_24=float3(0.0);
float3 l9_25=(*sc_set2.UserUniforms).emissiveFactor;
l9_24=l9_25;
float l9_26=0.0;
float l9_27=1.0;
float l9_28=(*sc_set2.UserUniforms).Port_Input2_N043;
float l9_29;
if ((int(ENABLE_NORMALMAP_tmp)!=0))
{
float l9_30=0.0;
float l9_31=(*sc_set2.UserUniforms).normalTextureScale;
l9_30=l9_31;
l9_27=l9_30;
l9_29=l9_27;
}
else
{
l9_29=l9_28;
}
l9_26=l9_29;
float l9_32=0.0;
float l9_33=(*sc_set2.UserUniforms).metallicFactor;
l9_32=l9_33;
float l9_34=0.0;
float l9_35=(*sc_set2.UserUniforms).roughnessFactor;
l9_34=l9_35;
float l9_36=0.0;
float l9_37=1.0;
float l9_38=(*sc_set2.UserUniforms).Port_Input2_N062;
float l9_39;
if ((int(ENABLE_METALLIC_ROUGHNESS_TEX_tmp)!=0))
{
float l9_40=0.0;
float l9_41=(*sc_set2.UserUniforms).occlusionTextureStrength;
l9_40=l9_41;
l9_37=l9_40;
l9_39=l9_37;
}
else
{
l9_39=l9_38;
}
l9_36=l9_39;
float l9_42=0.0;
float l9_43=(*sc_set2.UserUniforms).transmissionFactor;
l9_42=l9_43;
float3 l9_44=float3(0.0);
float3 l9_45=(*sc_set2.UserUniforms).sheenColorFactor;
l9_44=l9_45;
float l9_46=0.0;
float l9_47=(*sc_set2.UserUniforms).sheenRoughnessFactor;
l9_46=l9_47;
float l9_48=0.0;
float l9_49=(*sc_set2.UserUniforms).clearcoatFactor;
l9_48=l9_49;
float l9_50=0.0;
float l9_51=(*sc_set2.UserUniforms).clearcoatRoughnessFactor;
l9_50=l9_51;
float4 l9_52=float4(0.0);
float4 l9_53=(*sc_set2.UserUniforms).baseColorFactor;
l9_52=l9_53;
float2 l9_54=float2(0.0);
float2 l9_55=(*sc_set2.UserUniforms).baseColorTexture_offset;
l9_54=l9_55;
float2 l9_56=float2(0.0);
float2 l9_57=(*sc_set2.UserUniforms).baseColorTexture_scale;
l9_56=l9_57;
float l9_58=0.0;
float l9_59=(*sc_set2.UserUniforms).baseColorTexture_rotation;
l9_58=l9_59;
float3 l9_60=float3(0.0);
float l9_61=0.0;
float4 l9_62=l9_52;
float2 l9_63=l9_54;
float2 l9_64=l9_56;
float l9_65=l9_58;
ssGlobals l9_66=param_3;
tempGlobals=l9_66;
float3 l9_67=float3(0.0);
float l9_68=0.0;
N35_EnableVertexColor=(int(ENABLE_VERTEX_COLOR_BASE_tmp)!=0);
N35_EnableBaseTexture=(int(ENABLE_BASE_TEX_tmp)!=0);
N35_BaseColorTextureCoord=NODE_7_DROPLIST_ITEM_tmp;
N35_BaseColorFactor=l9_62;
N35_EnableTextureTransform=(int(ENABLE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureTransform=(int(ENABLE_BASE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureOffset=l9_63;
N35_BaseTextureScale=l9_64;
N35_BaseTextureRotation=l9_65;
float4 l9_69=N35_BaseColorFactor;
if (N35_EnableBaseTexture)
{
int l9_70=N35_BaseColorTextureCoord;
float2 l9_71=tempGlobals.Surface_UVCoord0;
float2 l9_72=l9_71;
if (l9_70==0)
{
float2 l9_73=tempGlobals.Surface_UVCoord0;
l9_72=l9_73;
}
if (l9_70==1)
{
float2 l9_74=tempGlobals.Surface_UVCoord1;
l9_72=l9_74;
}
float2 l9_75=l9_72;
float2 l9_76=l9_75;
if (N35_EnableTextureTransform&&N35_BaseTextureTransform)
{
float2 l9_77=l9_76;
float2 l9_78=N35_BaseTextureOffset;
float2 l9_79=N35_BaseTextureScale;
float l9_80=N35_BaseTextureRotation;
float3x3 l9_81=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_78.x,l9_78.y,1.0));
float3x3 l9_82=float3x3(float3(cos(l9_80),sin(l9_80),0.0),float3(-sin(l9_80),cos(l9_80),0.0),float3(0.0,0.0,1.0));
float3x3 l9_83=float3x3(float3(l9_79.x,0.0,0.0),float3(0.0,l9_79.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_84=(l9_81*l9_82)*l9_83;
float2 l9_85=(l9_84*float3(l9_77,1.0)).xy;
l9_76=l9_85;
}
float2 l9_86=l9_76;
float4 l9_87=float4(0.0);
int l9_88=0;
if ((int(baseColorTextureHasSwappedViews_tmp)!=0))
{
int l9_89=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_89=0;
}
else
{
l9_89=in.varStereoViewID;
}
int l9_90=l9_89;
l9_88=1-l9_90;
}
else
{
int l9_91=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_91=0;
}
else
{
l9_91=in.varStereoViewID;
}
int l9_92=l9_91;
l9_88=l9_92;
}
int l9_93=l9_88;
int l9_94=baseColorTextureLayout_tmp;
int l9_95=l9_93;
float2 l9_96=l9_86;
bool l9_97=(int(SC_USE_UV_TRANSFORM_baseColorTexture_tmp)!=0);
float3x3 l9_98=(*sc_set2.UserUniforms).baseColorTextureTransform;
int2 l9_99=int2(SC_SOFTWARE_WRAP_MODE_U_baseColorTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_baseColorTexture_tmp);
bool l9_100=(int(SC_USE_UV_MIN_MAX_baseColorTexture_tmp)!=0);
float4 l9_101=(*sc_set2.UserUniforms).baseColorTextureUvMinMax;
bool l9_102=(int(SC_USE_CLAMP_TO_BORDER_baseColorTexture_tmp)!=0);
float4 l9_103=(*sc_set2.UserUniforms).baseColorTextureBorderColor;
float l9_104=0.0;
bool l9_105=l9_102&&(!l9_100);
float l9_106=1.0;
float l9_107=l9_96.x;
int l9_108=l9_99.x;
if (l9_108==1)
{
l9_107=fract(l9_107);
}
else
{
if (l9_108==2)
{
float l9_109=fract(l9_107);
float l9_110=l9_107-l9_109;
float l9_111=step(0.25,fract(l9_110*0.5));
l9_107=mix(l9_109,1.0-l9_109,fast::clamp(l9_111,0.0,1.0));
}
}
l9_96.x=l9_107;
float l9_112=l9_96.y;
int l9_113=l9_99.y;
if (l9_113==1)
{
l9_112=fract(l9_112);
}
else
{
if (l9_113==2)
{
float l9_114=fract(l9_112);
float l9_115=l9_112-l9_114;
float l9_116=step(0.25,fract(l9_115*0.5));
l9_112=mix(l9_114,1.0-l9_114,fast::clamp(l9_116,0.0,1.0));
}
}
l9_96.y=l9_112;
if (l9_100)
{
bool l9_117=l9_102;
bool l9_118;
if (l9_117)
{
l9_118=l9_99.x==3;
}
else
{
l9_118=l9_117;
}
float l9_119=l9_96.x;
float l9_120=l9_101.x;
float l9_121=l9_101.z;
bool l9_122=l9_118;
float l9_123=l9_106;
float l9_124=fast::clamp(l9_119,l9_120,l9_121);
float l9_125=step(abs(l9_119-l9_124),9.9999997e-06);
l9_123*=(l9_125+((1.0-float(l9_122))*(1.0-l9_125)));
l9_119=l9_124;
l9_96.x=l9_119;
l9_106=l9_123;
bool l9_126=l9_102;
bool l9_127;
if (l9_126)
{
l9_127=l9_99.y==3;
}
else
{
l9_127=l9_126;
}
float l9_128=l9_96.y;
float l9_129=l9_101.y;
float l9_130=l9_101.w;
bool l9_131=l9_127;
float l9_132=l9_106;
float l9_133=fast::clamp(l9_128,l9_129,l9_130);
float l9_134=step(abs(l9_128-l9_133),9.9999997e-06);
l9_132*=(l9_134+((1.0-float(l9_131))*(1.0-l9_134)));
l9_128=l9_133;
l9_96.y=l9_128;
l9_106=l9_132;
}
float2 l9_135=l9_96;
bool l9_136=l9_97;
float3x3 l9_137=l9_98;
if (l9_136)
{
l9_135=float2((l9_137*float3(l9_135,1.0)).xy);
}
float2 l9_138=l9_135;
float2 l9_139=l9_138;
float2 l9_140=l9_139;
l9_96=l9_140;
float l9_141=l9_96.x;
int l9_142=l9_99.x;
bool l9_143=l9_105;
float l9_144=l9_106;
if ((l9_142==0)||(l9_142==3))
{
float l9_145=l9_141;
float l9_146=0.0;
float l9_147=1.0;
bool l9_148=l9_143;
float l9_149=l9_144;
float l9_150=fast::clamp(l9_145,l9_146,l9_147);
float l9_151=step(abs(l9_145-l9_150),9.9999997e-06);
l9_149*=(l9_151+((1.0-float(l9_148))*(1.0-l9_151)));
l9_145=l9_150;
l9_141=l9_145;
l9_144=l9_149;
}
l9_96.x=l9_141;
l9_106=l9_144;
float l9_152=l9_96.y;
int l9_153=l9_99.y;
bool l9_154=l9_105;
float l9_155=l9_106;
if ((l9_153==0)||(l9_153==3))
{
float l9_156=l9_152;
float l9_157=0.0;
float l9_158=1.0;
bool l9_159=l9_154;
float l9_160=l9_155;
float l9_161=fast::clamp(l9_156,l9_157,l9_158);
float l9_162=step(abs(l9_156-l9_161),9.9999997e-06);
l9_160*=(l9_162+((1.0-float(l9_159))*(1.0-l9_162)));
l9_156=l9_161;
l9_152=l9_156;
l9_155=l9_160;
}
l9_96.y=l9_152;
l9_106=l9_155;
float2 l9_163=l9_96;
int l9_164=l9_94;
int l9_165=l9_95;
float l9_166=l9_104;
float2 l9_167=l9_163;
int l9_168=l9_164;
int l9_169=l9_165;
float3 l9_170=float3(0.0);
if (l9_168==0)
{
l9_170=float3(l9_167,0.0);
}
else
{
if (l9_168==1)
{
l9_170=float3(l9_167.x,(l9_167.y*0.5)+(0.5-(float(l9_169)*0.5)),0.0);
}
else
{
l9_170=float3(l9_167,float(l9_169));
}
}
float3 l9_171=l9_170;
float3 l9_172=l9_171;
float2 l9_173=l9_172.xy;
float l9_174=l9_166;
float4 l9_175=sc_set2.baseColorTexture.sample(sc_set2.baseColorTextureSmpSC,l9_173,bias(l9_174));
float4 l9_176=l9_175;
float4 l9_177=l9_176;
if (l9_102)
{
l9_177=mix(l9_103,l9_177,float4(l9_106));
}
float4 l9_178=l9_177;
l9_87=l9_178;
float4 l9_179=l9_87;
float4 l9_180=l9_179;
float4 l9_181;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_181=float4(pow(l9_180.x,2.2),pow(l9_180.y,2.2),pow(l9_180.z,2.2),pow(l9_180.w,2.2));
}
else
{
l9_181=l9_180*l9_180;
}
float4 l9_182=l9_181;
l9_69*=l9_182;
}
if (N35_EnableVertexColor)
{
float4 l9_183=tempGlobals.VertexColor;
l9_69*=l9_183;
}
N35_BaseColor=l9_69.xyz;
N35_Opacity=l9_69.w;
float4 l9_184=l9_69;
float4 l9_185;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_185=float4(pow(l9_184.x,0.45454544),pow(l9_184.y,0.45454544),pow(l9_184.z,0.45454544),pow(l9_184.w,0.45454544));
}
else
{
l9_185=sqrt(l9_184);
}
float4 l9_186=l9_185;
N35_UnlitColor=l9_186;
l9_67=N35_BaseColor;
l9_68=N35_Opacity;
l9_60=l9_67;
l9_61=l9_68;
float2 l9_187=float2(0.0);
float2 l9_188=(*sc_set2.UserUniforms).emissiveTexture_offset;
l9_187=l9_188;
float2 l9_189=float2(0.0);
float2 l9_190=(*sc_set2.UserUniforms).emissiveTexture_scale;
l9_189=l9_190;
float l9_191=0.0;
float l9_192=(*sc_set2.UserUniforms).emissiveTexture_rotation;
l9_191=l9_192;
float2 l9_193=float2(0.0);
float2 l9_194=(*sc_set2.UserUniforms).normalTexture_offset;
l9_193=l9_194;
float2 l9_195=float2(0.0);
float2 l9_196=(*sc_set2.UserUniforms).normalTexture_scale;
l9_195=l9_196;
float l9_197=0.0;
float l9_198=(*sc_set2.UserUniforms).normalTexture_rotation;
l9_197=l9_198;
float2 l9_199=float2(0.0);
float2 l9_200=(*sc_set2.UserUniforms).metallicRoughnessTexture_offset;
l9_199=l9_200;
float2 l9_201=float2(0.0);
float2 l9_202=(*sc_set2.UserUniforms).metallicRoughnessTexture_scale;
l9_201=l9_202;
float l9_203=0.0;
float l9_204=(*sc_set2.UserUniforms).metallicRoughnessTexture_rotation;
l9_203=l9_204;
float2 l9_205=float2(0.0);
float2 l9_206=(*sc_set2.UserUniforms).transmissionTexture_offset;
l9_205=l9_206;
float2 l9_207=float2(0.0);
float2 l9_208=(*sc_set2.UserUniforms).transmissionTexture_scale;
l9_207=l9_208;
float l9_209=0.0;
float l9_210=(*sc_set2.UserUniforms).transmissionTexture_rotation;
l9_209=l9_210;
float2 l9_211=float2(0.0);
float2 l9_212=(*sc_set2.UserUniforms).sheenColorTexture_offset;
l9_211=l9_212;
float2 l9_213=float2(0.0);
float2 l9_214=(*sc_set2.UserUniforms).sheenColorTexture_scale;
l9_213=l9_214;
float l9_215=0.0;
float l9_216=(*sc_set2.UserUniforms).sheenColorTexture_rotation;
l9_215=l9_216;
float2 l9_217=float2(0.0);
float2 l9_218=(*sc_set2.UserUniforms).sheenRoughnessTexture_offset;
l9_217=l9_218;
float2 l9_219=float2(0.0);
float2 l9_220=(*sc_set2.UserUniforms).sheenRoughnessTexture_scale;
l9_219=l9_220;
float l9_221=0.0;
float l9_222=(*sc_set2.UserUniforms).sheenRoughnessTexture_rotation;
l9_221=l9_222;
float2 l9_223=float2(0.0);
float2 l9_224=(*sc_set2.UserUniforms).clearcoatTexture_offset;
l9_223=l9_224;
float2 l9_225=float2(0.0);
float2 l9_226=(*sc_set2.UserUniforms).clearcoatTexture_scale;
l9_225=l9_226;
float l9_227=0.0;
float l9_228=(*sc_set2.UserUniforms).clearcoatTexture_rotation;
l9_227=l9_228;
float2 l9_229=float2(0.0);
float2 l9_230=(*sc_set2.UserUniforms).clearcoatNormalTexture_offset;
l9_229=l9_230;
float2 l9_231=float2(0.0);
float2 l9_232=(*sc_set2.UserUniforms).clearcoatNormalTexture_scale;
l9_231=l9_232;
float l9_233=0.0;
float l9_234=(*sc_set2.UserUniforms).clearcoatNormalTexture_rotation;
l9_233=l9_234;
float2 l9_235=float2(0.0);
float2 l9_236=(*sc_set2.UserUniforms).clearcoatRoughnessTexture_offset;
l9_235=l9_236;
float2 l9_237=float2(0.0);
float2 l9_238=(*sc_set2.UserUniforms).clearcoatRoughnessTexture_scale;
l9_237=l9_238;
float l9_239=0.0;
float l9_240=(*sc_set2.UserUniforms).clearcoatRoughnessTexture_rotation;
l9_239=l9_240;
float3 l9_241=float3(0.0);
float l9_242=0.0;
float3 l9_243=float3(0.0);
float3 l9_244=float3(0.0);
float l9_245=0.0;
float l9_246=0.0;
float4 l9_247=float4(0.0);
float3 l9_248=float3(0.0);
float4 l9_249=float4(0.0);
float l9_250=0.0;
float3 l9_251=float3(0.0);
float l9_252=0.0;
float3 l9_253=l9_24;
float l9_254=l9_26;
float l9_255=l9_32;
float l9_256=l9_34;
float l9_257=l9_36;
float l9_258=l9_42;
float3 l9_259=l9_44;
float l9_260=l9_46;
float l9_261=l9_48;
float l9_262=l9_50;
float3 l9_263=l9_60;
float l9_264=l9_61;
float2 l9_265=l9_187;
float2 l9_266=l9_189;
float l9_267=l9_191;
float2 l9_268=l9_193;
float2 l9_269=l9_195;
float l9_270=l9_197;
float2 l9_271=l9_199;
float2 l9_272=l9_201;
float l9_273=l9_203;
float2 l9_274=l9_205;
float2 l9_275=l9_207;
float l9_276=l9_209;
float2 l9_277=l9_211;
float2 l9_278=l9_213;
float l9_279=l9_215;
float2 l9_280=l9_217;
float2 l9_281=l9_219;
float l9_282=l9_221;
float2 l9_283=l9_223;
float2 l9_284=l9_225;
float l9_285=l9_227;
float2 l9_286=l9_229;
float2 l9_287=l9_231;
float l9_288=l9_233;
float2 l9_289=l9_235;
float2 l9_290=l9_237;
float l9_291=l9_239;
ssGlobals l9_292=param_3;
tempGlobals=l9_292;
float3 l9_293=float3(0.0);
float l9_294=0.0;
float3 l9_295=float3(0.0);
float3 l9_296=float3(0.0);
float l9_297=0.0;
float l9_298=0.0;
float4 l9_299=float4(0.0);
float3 l9_300=float3(0.0);
float4 l9_301=float4(0.0);
float l9_302=0.0;
float3 l9_303=float3(0.0);
float l9_304=0.0;
N3_EmissiveColor=l9_253;
N3_EnableEmissiveTexture=(int(ENABLE_EMISSIVE_tmp)!=0);
N3_EmissiveTextureCoord=NODE_10_DROPLIST_ITEM_tmp;
N3_EnableNormalTexture=(int(ENABLE_NORMALMAP_tmp)!=0);
N3_NormalScale=l9_254;
N3_NormalTextureCoord=NODE_8_DROPLIST_ITEM_tmp;
N3_MetallicValue=l9_255;
N3_RoughnessValue=l9_256;
N3_EnableMetallicRoughnessTexture=(int(ENABLE_METALLIC_ROUGHNESS_TEX_tmp)!=0);
N3_OcclusionStrength=l9_257;
N3_MaterialParamsTextureCoord=NODE_11_DROPLIST_ITEM_tmp;
N3_TransmissionEnable=(int(ENABLE_TRANSMISSION_tmp)!=0);
N3_TransmissionFactor=l9_258;
N3_EnableTransmissionTexture=(int(ENABLE_TRANSMISSION_TEX_tmp)!=0);
N3_TransmissionTextureCoord=Tweak_N30_tmp;
N3_SheenEnable=(int(ENABLE_SHEEN_tmp)!=0);
N3_SheenColorFactor=l9_259;
N3_EnableSheenTexture=(int(ENABLE_SHEEN_COLOR_TEX_tmp)!=0);
N3_SheenColorTextureCoord=Tweak_N32_tmp;
N3_SheenRoughnessFactor=l9_260;
N3_EnableSheenRoughnessTexture=(int(ENABLE_SHEEN_ROUGHNESS_TEX_tmp)!=0);
N3_SheenRoughnessTextureCoord=Tweak_N37_tmp;
N3_ClearcoatEnable=(int(ENABLE_CLEARCOAT_tmp)!=0);
N3_ClearcoatFactor=l9_261;
N3_EnableClearcoatTexture=(int(ENABLE_CLEARCOAT_TEX_tmp)!=0);
N3_ClearcoatTextureCoord=Tweak_N44_tmp;
N3_ClearcoatRoughnessFactor=l9_262;
N3_EnableClearCoatRoughnessTexture=(int(ENABLE_CLEARCOAT_ROUGHNESS_TEX_tmp)!=0);
N3_ClearcoatRoughnessTextureCoord=Tweak_N60_tmp;
N3_EnableClearCoatNormalTexture=(int(ENABLE_CLEARCOAT_NORMAL_TEX_tmp)!=0);
N3_ClearcoatNormalMapCoord=Tweak_N47_tmp;
N3_BaseColorIn=l9_263;
N3_OpacityIn=l9_264;
N3_EnableTextureTransform=(int(ENABLE_TEXTURE_TRANSFORM_tmp)!=0);
N3_EmissiveTextureTransform=(int(ENABLE_EMISSIVE_TEXTURE_TRANSFORM_tmp)!=0);
N3_EmissiveTextureOffset=l9_265;
N3_EmissiveTextureScale=l9_266;
N3_EmissiveTextureRotation=l9_267;
N3_NormalTextureTransform=(int(ENABLE_NORMAL_TEXTURE_TRANSFORM_tmp)!=0);
N3_NormalTextureOffset=l9_268;
N3_NormalTextureScale=l9_269;
N3_NormalTextureRotation=l9_270;
N3_MaterialParamsTextureTransform=(int(ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM_tmp)!=0);
N3_MaterialParamsTextureOffset=l9_271;
N3_MaterialParamsTextureScale=l9_272;
N3_MaterialParamsTextureRotation=l9_273;
N3_TransmissionTextureTransform=(int(ENABLE_TRANSMISSION_TEXTURE_TRANSFORM_tmp)!=0);
N3_TransmissionTextureOffset=l9_274;
N3_TransmissionTextureScale=l9_275;
N3_TransmissionTextureRotation=l9_276;
N3_SheenColorTextureTransform=(int(ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM_tmp)!=0);
N3_SheenColorTextureOffset=l9_277;
N3_SheenColorTextureScale=l9_278;
N3_SheenColorTextureRotation=l9_279;
N3_SheenRoughnessTextureTransform=(int(ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM_tmp)!=0);
N3_SheenRoughnessTextureOffset=l9_280;
N3_SheenRoughnessTextureScale=l9_281;
N3_SheenRoughnessTextureRotation=l9_282;
N3_ClearcoatTextureTransform=(int(ENABLE_CLEARCOAT_TEXTURE_TRANSFORM_tmp)!=0);
N3_ClearcoatTextureOffset=l9_283;
N3_ClearcoatTextureScale=l9_284;
N3_ClearcoatTextureRotation=l9_285;
N3_ClearcoatNormalTextureTransform=(int(ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM_tmp)!=0);
N3_ClearcoatNormalTextureOffset=l9_286;
N3_ClearcoatNormalTextureScale=l9_287;
N3_ClearcoatNormalTextureRotation=l9_288;
N3_ClearcoatRoughnessTextureTransform=(int(ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM_tmp)!=0);
N3_ClearcoatRoughnessTextureOffset=l9_289;
N3_ClearcoatRoughnessTextureScale=l9_290;
N3_ClearcoatRoughnessTextureRotation=l9_291;
N3_BaseColor=N3_BaseColorIn;
N3_Opacity=N3_OpacityIn;
N3_Emissive=N3_EmissiveColor;
if (N3_EnableEmissiveTexture)
{
float3 l9_305=N3_Emissive;
int l9_306=N3_EmissiveTextureCoord;
float2 l9_307=tempGlobals.Surface_UVCoord0;
float2 l9_308=l9_307;
if (l9_306==0)
{
float2 l9_309=tempGlobals.Surface_UVCoord0;
l9_308=l9_309;
}
if (l9_306==1)
{
float2 l9_310=tempGlobals.Surface_UVCoord1;
l9_308=l9_310;
}
float2 l9_311=l9_308;
float2 l9_312=l9_311;
if (N3_EnableTextureTransform&&N3_EmissiveTextureTransform)
{
float2 l9_313=l9_312;
float2 l9_314=N3_EmissiveTextureOffset;
float2 l9_315=N3_EmissiveTextureScale;
float l9_316=N3_EmissiveTextureRotation;
float l9_317=radians(l9_316);
float3x3 l9_318=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_314.x,l9_314.y,1.0));
float3x3 l9_319=float3x3(float3(cos(l9_317),sin(l9_317),0.0),float3(-sin(l9_317),cos(l9_317),0.0),float3(0.0,0.0,1.0));
float3x3 l9_320=float3x3(float3(l9_315.x,0.0,0.0),float3(0.0,l9_315.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_321=(l9_318*l9_319)*l9_320;
float2 l9_322=(l9_321*float3(l9_313,1.0)).xy;
l9_312=l9_322;
}
float2 l9_323=l9_312;
float4 l9_324=float4(0.0);
int l9_325=0;
if ((int(emissiveTextureHasSwappedViews_tmp)!=0))
{
int l9_326=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_326=0;
}
else
{
l9_326=in.varStereoViewID;
}
int l9_327=l9_326;
l9_325=1-l9_327;
}
else
{
int l9_328=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_328=0;
}
else
{
l9_328=in.varStereoViewID;
}
int l9_329=l9_328;
l9_325=l9_329;
}
int l9_330=l9_325;
int l9_331=emissiveTextureLayout_tmp;
int l9_332=l9_330;
float2 l9_333=l9_323;
bool l9_334=(int(SC_USE_UV_TRANSFORM_emissiveTexture_tmp)!=0);
float3x3 l9_335=(*sc_set2.UserUniforms).emissiveTextureTransform;
int2 l9_336=int2(SC_SOFTWARE_WRAP_MODE_U_emissiveTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_emissiveTexture_tmp);
bool l9_337=(int(SC_USE_UV_MIN_MAX_emissiveTexture_tmp)!=0);
float4 l9_338=(*sc_set2.UserUniforms).emissiveTextureUvMinMax;
bool l9_339=(int(SC_USE_CLAMP_TO_BORDER_emissiveTexture_tmp)!=0);
float4 l9_340=(*sc_set2.UserUniforms).emissiveTextureBorderColor;
float l9_341=0.0;
bool l9_342=l9_339&&(!l9_337);
float l9_343=1.0;
float l9_344=l9_333.x;
int l9_345=l9_336.x;
if (l9_345==1)
{
l9_344=fract(l9_344);
}
else
{
if (l9_345==2)
{
float l9_346=fract(l9_344);
float l9_347=l9_344-l9_346;
float l9_348=step(0.25,fract(l9_347*0.5));
l9_344=mix(l9_346,1.0-l9_346,fast::clamp(l9_348,0.0,1.0));
}
}
l9_333.x=l9_344;
float l9_349=l9_333.y;
int l9_350=l9_336.y;
if (l9_350==1)
{
l9_349=fract(l9_349);
}
else
{
if (l9_350==2)
{
float l9_351=fract(l9_349);
float l9_352=l9_349-l9_351;
float l9_353=step(0.25,fract(l9_352*0.5));
l9_349=mix(l9_351,1.0-l9_351,fast::clamp(l9_353,0.0,1.0));
}
}
l9_333.y=l9_349;
if (l9_337)
{
bool l9_354=l9_339;
bool l9_355;
if (l9_354)
{
l9_355=l9_336.x==3;
}
else
{
l9_355=l9_354;
}
float l9_356=l9_333.x;
float l9_357=l9_338.x;
float l9_358=l9_338.z;
bool l9_359=l9_355;
float l9_360=l9_343;
float l9_361=fast::clamp(l9_356,l9_357,l9_358);
float l9_362=step(abs(l9_356-l9_361),9.9999997e-06);
l9_360*=(l9_362+((1.0-float(l9_359))*(1.0-l9_362)));
l9_356=l9_361;
l9_333.x=l9_356;
l9_343=l9_360;
bool l9_363=l9_339;
bool l9_364;
if (l9_363)
{
l9_364=l9_336.y==3;
}
else
{
l9_364=l9_363;
}
float l9_365=l9_333.y;
float l9_366=l9_338.y;
float l9_367=l9_338.w;
bool l9_368=l9_364;
float l9_369=l9_343;
float l9_370=fast::clamp(l9_365,l9_366,l9_367);
float l9_371=step(abs(l9_365-l9_370),9.9999997e-06);
l9_369*=(l9_371+((1.0-float(l9_368))*(1.0-l9_371)));
l9_365=l9_370;
l9_333.y=l9_365;
l9_343=l9_369;
}
float2 l9_372=l9_333;
bool l9_373=l9_334;
float3x3 l9_374=l9_335;
if (l9_373)
{
l9_372=float2((l9_374*float3(l9_372,1.0)).xy);
}
float2 l9_375=l9_372;
float2 l9_376=l9_375;
float2 l9_377=l9_376;
l9_333=l9_377;
float l9_378=l9_333.x;
int l9_379=l9_336.x;
bool l9_380=l9_342;
float l9_381=l9_343;
if ((l9_379==0)||(l9_379==3))
{
float l9_382=l9_378;
float l9_383=0.0;
float l9_384=1.0;
bool l9_385=l9_380;
float l9_386=l9_381;
float l9_387=fast::clamp(l9_382,l9_383,l9_384);
float l9_388=step(abs(l9_382-l9_387),9.9999997e-06);
l9_386*=(l9_388+((1.0-float(l9_385))*(1.0-l9_388)));
l9_382=l9_387;
l9_378=l9_382;
l9_381=l9_386;
}
l9_333.x=l9_378;
l9_343=l9_381;
float l9_389=l9_333.y;
int l9_390=l9_336.y;
bool l9_391=l9_342;
float l9_392=l9_343;
if ((l9_390==0)||(l9_390==3))
{
float l9_393=l9_389;
float l9_394=0.0;
float l9_395=1.0;
bool l9_396=l9_391;
float l9_397=l9_392;
float l9_398=fast::clamp(l9_393,l9_394,l9_395);
float l9_399=step(abs(l9_393-l9_398),9.9999997e-06);
l9_397*=(l9_399+((1.0-float(l9_396))*(1.0-l9_399)));
l9_393=l9_398;
l9_389=l9_393;
l9_392=l9_397;
}
l9_333.y=l9_389;
l9_343=l9_392;
float2 l9_400=l9_333;
int l9_401=l9_331;
int l9_402=l9_332;
float l9_403=l9_341;
float2 l9_404=l9_400;
int l9_405=l9_401;
int l9_406=l9_402;
float3 l9_407=float3(0.0);
if (l9_405==0)
{
l9_407=float3(l9_404,0.0);
}
else
{
if (l9_405==1)
{
l9_407=float3(l9_404.x,(l9_404.y*0.5)+(0.5-(float(l9_406)*0.5)),0.0);
}
else
{
l9_407=float3(l9_404,float(l9_406));
}
}
float3 l9_408=l9_407;
float3 l9_409=l9_408;
float2 l9_410=l9_409.xy;
float l9_411=l9_403;
float4 l9_412=sc_set2.emissiveTexture.sample(sc_set2.emissiveTextureSmpSC,l9_410,bias(l9_411));
float4 l9_413=l9_412;
float4 l9_414=l9_413;
if (l9_339)
{
l9_414=mix(l9_340,l9_414,float4(l9_343));
}
float4 l9_415=l9_414;
l9_324=l9_415;
float4 l9_416=l9_324;
float3 l9_417=l9_416.xyz;
float3 l9_418;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_418=float3(pow(l9_417.x,2.2),pow(l9_417.y,2.2),pow(l9_417.z,2.2));
}
else
{
l9_418=l9_417*l9_417;
}
float3 l9_419=l9_418;
float3 l9_420=l9_419;
float3 l9_421=l9_305;
float3 l9_422;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_422=float3(pow(l9_421.x,2.2),pow(l9_421.y,2.2),pow(l9_421.z,2.2));
}
else
{
l9_422=l9_421*l9_421;
}
float3 l9_423=l9_422;
l9_305=l9_420*l9_423;
N3_Emissive=l9_305;
}
float3 l9_424=tempGlobals.VertexNormal_WorldSpace;
N3_Normal=normalize(l9_424);
if (N3_EnableNormalTexture)
{
float3 l9_425=N3_Normal;
int l9_426=N3_NormalTextureCoord;
float2 l9_427=tempGlobals.Surface_UVCoord0;
float2 l9_428=l9_427;
if (l9_426==0)
{
float2 l9_429=tempGlobals.Surface_UVCoord0;
l9_428=l9_429;
}
if (l9_426==1)
{
float2 l9_430=tempGlobals.Surface_UVCoord1;
l9_428=l9_430;
}
float2 l9_431=l9_428;
float2 l9_432=l9_431;
if (N3_EnableTextureTransform&&N3_NormalTextureTransform)
{
float2 l9_433=l9_432;
float2 l9_434=N3_NormalTextureOffset;
float2 l9_435=N3_NormalTextureScale;
float l9_436=N3_NormalTextureRotation;
float l9_437=radians(l9_436);
float3x3 l9_438=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_434.x,l9_434.y,1.0));
float3x3 l9_439=float3x3(float3(cos(l9_437),sin(l9_437),0.0),float3(-sin(l9_437),cos(l9_437),0.0),float3(0.0,0.0,1.0));
float3x3 l9_440=float3x3(float3(l9_435.x,0.0,0.0),float3(0.0,l9_435.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_441=(l9_438*l9_439)*l9_440;
float2 l9_442=(l9_441*float3(l9_433,1.0)).xy;
l9_432=l9_442;
}
float2 l9_443=l9_432;
float4 l9_444=float4(0.0);
int l9_445=0;
if ((int(normalTextureHasSwappedViews_tmp)!=0))
{
int l9_446=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_446=0;
}
else
{
l9_446=in.varStereoViewID;
}
int l9_447=l9_446;
l9_445=1-l9_447;
}
else
{
int l9_448=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_448=0;
}
else
{
l9_448=in.varStereoViewID;
}
int l9_449=l9_448;
l9_445=l9_449;
}
int l9_450=l9_445;
int l9_451=normalTextureLayout_tmp;
int l9_452=l9_450;
float2 l9_453=l9_443;
bool l9_454=(int(SC_USE_UV_TRANSFORM_normalTexture_tmp)!=0);
float3x3 l9_455=(*sc_set2.UserUniforms).normalTextureTransform;
int2 l9_456=int2(SC_SOFTWARE_WRAP_MODE_U_normalTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTexture_tmp);
bool l9_457=(int(SC_USE_UV_MIN_MAX_normalTexture_tmp)!=0);
float4 l9_458=(*sc_set2.UserUniforms).normalTextureUvMinMax;
bool l9_459=(int(SC_USE_CLAMP_TO_BORDER_normalTexture_tmp)!=0);
float4 l9_460=(*sc_set2.UserUniforms).normalTextureBorderColor;
float l9_461=0.0;
bool l9_462=l9_459&&(!l9_457);
float l9_463=1.0;
float l9_464=l9_453.x;
int l9_465=l9_456.x;
if (l9_465==1)
{
l9_464=fract(l9_464);
}
else
{
if (l9_465==2)
{
float l9_466=fract(l9_464);
float l9_467=l9_464-l9_466;
float l9_468=step(0.25,fract(l9_467*0.5));
l9_464=mix(l9_466,1.0-l9_466,fast::clamp(l9_468,0.0,1.0));
}
}
l9_453.x=l9_464;
float l9_469=l9_453.y;
int l9_470=l9_456.y;
if (l9_470==1)
{
l9_469=fract(l9_469);
}
else
{
if (l9_470==2)
{
float l9_471=fract(l9_469);
float l9_472=l9_469-l9_471;
float l9_473=step(0.25,fract(l9_472*0.5));
l9_469=mix(l9_471,1.0-l9_471,fast::clamp(l9_473,0.0,1.0));
}
}
l9_453.y=l9_469;
if (l9_457)
{
bool l9_474=l9_459;
bool l9_475;
if (l9_474)
{
l9_475=l9_456.x==3;
}
else
{
l9_475=l9_474;
}
float l9_476=l9_453.x;
float l9_477=l9_458.x;
float l9_478=l9_458.z;
bool l9_479=l9_475;
float l9_480=l9_463;
float l9_481=fast::clamp(l9_476,l9_477,l9_478);
float l9_482=step(abs(l9_476-l9_481),9.9999997e-06);
l9_480*=(l9_482+((1.0-float(l9_479))*(1.0-l9_482)));
l9_476=l9_481;
l9_453.x=l9_476;
l9_463=l9_480;
bool l9_483=l9_459;
bool l9_484;
if (l9_483)
{
l9_484=l9_456.y==3;
}
else
{
l9_484=l9_483;
}
float l9_485=l9_453.y;
float l9_486=l9_458.y;
float l9_487=l9_458.w;
bool l9_488=l9_484;
float l9_489=l9_463;
float l9_490=fast::clamp(l9_485,l9_486,l9_487);
float l9_491=step(abs(l9_485-l9_490),9.9999997e-06);
l9_489*=(l9_491+((1.0-float(l9_488))*(1.0-l9_491)));
l9_485=l9_490;
l9_453.y=l9_485;
l9_463=l9_489;
}
float2 l9_492=l9_453;
bool l9_493=l9_454;
float3x3 l9_494=l9_455;
if (l9_493)
{
l9_492=float2((l9_494*float3(l9_492,1.0)).xy);
}
float2 l9_495=l9_492;
float2 l9_496=l9_495;
float2 l9_497=l9_496;
l9_453=l9_497;
float l9_498=l9_453.x;
int l9_499=l9_456.x;
bool l9_500=l9_462;
float l9_501=l9_463;
if ((l9_499==0)||(l9_499==3))
{
float l9_502=l9_498;
float l9_503=0.0;
float l9_504=1.0;
bool l9_505=l9_500;
float l9_506=l9_501;
float l9_507=fast::clamp(l9_502,l9_503,l9_504);
float l9_508=step(abs(l9_502-l9_507),9.9999997e-06);
l9_506*=(l9_508+((1.0-float(l9_505))*(1.0-l9_508)));
l9_502=l9_507;
l9_498=l9_502;
l9_501=l9_506;
}
l9_453.x=l9_498;
l9_463=l9_501;
float l9_509=l9_453.y;
int l9_510=l9_456.y;
bool l9_511=l9_462;
float l9_512=l9_463;
if ((l9_510==0)||(l9_510==3))
{
float l9_513=l9_509;
float l9_514=0.0;
float l9_515=1.0;
bool l9_516=l9_511;
float l9_517=l9_512;
float l9_518=fast::clamp(l9_513,l9_514,l9_515);
float l9_519=step(abs(l9_513-l9_518),9.9999997e-06);
l9_517*=(l9_519+((1.0-float(l9_516))*(1.0-l9_519)));
l9_513=l9_518;
l9_509=l9_513;
l9_512=l9_517;
}
l9_453.y=l9_509;
l9_463=l9_512;
float2 l9_520=l9_453;
int l9_521=l9_451;
int l9_522=l9_452;
float l9_523=l9_461;
float2 l9_524=l9_520;
int l9_525=l9_521;
int l9_526=l9_522;
float3 l9_527=float3(0.0);
if (l9_525==0)
{
l9_527=float3(l9_524,0.0);
}
else
{
if (l9_525==1)
{
l9_527=float3(l9_524.x,(l9_524.y*0.5)+(0.5-(float(l9_526)*0.5)),0.0);
}
else
{
l9_527=float3(l9_524,float(l9_526));
}
}
float3 l9_528=l9_527;
float3 l9_529=l9_528;
float2 l9_530=l9_529.xy;
float l9_531=l9_523;
float4 l9_532=sc_set2.normalTexture.sample(sc_set2.normalTextureSmpSC,l9_530,bias(l9_531));
float4 l9_533=l9_532;
float4 l9_534=l9_533;
if (l9_459)
{
l9_534=mix(l9_460,l9_534,float4(l9_463));
}
float4 l9_535=l9_534;
l9_444=l9_535;
float4 l9_536=l9_444;
float3 l9_537=(l9_536.xyz*1.9921875)-float3(1.0);
l9_537=mix(float3(0.0,0.0,1.0),l9_537,float3(N3_NormalScale));
float3 l9_538=tempGlobals.VertexTangent_WorldSpace;
float3 l9_539=l9_538;
float3 l9_540=tempGlobals.VertexBinormal_WorldSpace;
float3 l9_541=l9_540;
float3x3 l9_542=float3x3(float3(l9_539),float3(l9_541),float3(l9_425));
l9_425=normalize(l9_542*l9_537);
N3_Normal=l9_425;
}
N3_Metallic=N3_MetallicValue;
N3_Roughness=N3_RoughnessValue;
N3_Occlusion=float4(1.0,1.0,1.0,0.0);
if (N3_EnableMetallicRoughnessTexture)
{
float l9_543=N3_Metallic;
float l9_544=N3_Roughness;
float4 l9_545=N3_Occlusion;
int l9_546=N3_MaterialParamsTextureCoord;
float2 l9_547=tempGlobals.Surface_UVCoord0;
float2 l9_548=l9_547;
if (l9_546==0)
{
float2 l9_549=tempGlobals.Surface_UVCoord0;
l9_548=l9_549;
}
if (l9_546==1)
{
float2 l9_550=tempGlobals.Surface_UVCoord1;
l9_548=l9_550;
}
float2 l9_551=l9_548;
float2 l9_552=l9_551;
if (N3_EnableTextureTransform&&N3_MaterialParamsTextureTransform)
{
float2 l9_553=l9_552;
float2 l9_554=N3_MaterialParamsTextureOffset;
float2 l9_555=N3_MaterialParamsTextureScale;
float l9_556=N3_MaterialParamsTextureRotation;
float l9_557=radians(l9_556);
float3x3 l9_558=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_554.x,l9_554.y,1.0));
float3x3 l9_559=float3x3(float3(cos(l9_557),sin(l9_557),0.0),float3(-sin(l9_557),cos(l9_557),0.0),float3(0.0,0.0,1.0));
float3x3 l9_560=float3x3(float3(l9_555.x,0.0,0.0),float3(0.0,l9_555.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_561=(l9_558*l9_559)*l9_560;
float2 l9_562=(l9_561*float3(l9_553,1.0)).xy;
l9_552=l9_562;
}
float2 l9_563=l9_552;
float4 l9_564=float4(0.0);
int l9_565=0;
if ((int(metallicRoughnessTextureHasSwappedViews_tmp)!=0))
{
int l9_566=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_566=0;
}
else
{
l9_566=in.varStereoViewID;
}
int l9_567=l9_566;
l9_565=1-l9_567;
}
else
{
int l9_568=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_568=0;
}
else
{
l9_568=in.varStereoViewID;
}
int l9_569=l9_568;
l9_565=l9_569;
}
int l9_570=l9_565;
int l9_571=metallicRoughnessTextureLayout_tmp;
int l9_572=l9_570;
float2 l9_573=l9_563;
bool l9_574=(int(SC_USE_UV_TRANSFORM_metallicRoughnessTexture_tmp)!=0);
float3x3 l9_575=(*sc_set2.UserUniforms).metallicRoughnessTextureTransform;
int2 l9_576=int2(SC_SOFTWARE_WRAP_MODE_U_metallicRoughnessTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_metallicRoughnessTexture_tmp);
bool l9_577=(int(SC_USE_UV_MIN_MAX_metallicRoughnessTexture_tmp)!=0);
float4 l9_578=(*sc_set2.UserUniforms).metallicRoughnessTextureUvMinMax;
bool l9_579=(int(SC_USE_CLAMP_TO_BORDER_metallicRoughnessTexture_tmp)!=0);
float4 l9_580=(*sc_set2.UserUniforms).metallicRoughnessTextureBorderColor;
float l9_581=0.0;
bool l9_582=l9_579&&(!l9_577);
float l9_583=1.0;
float l9_584=l9_573.x;
int l9_585=l9_576.x;
if (l9_585==1)
{
l9_584=fract(l9_584);
}
else
{
if (l9_585==2)
{
float l9_586=fract(l9_584);
float l9_587=l9_584-l9_586;
float l9_588=step(0.25,fract(l9_587*0.5));
l9_584=mix(l9_586,1.0-l9_586,fast::clamp(l9_588,0.0,1.0));
}
}
l9_573.x=l9_584;
float l9_589=l9_573.y;
int l9_590=l9_576.y;
if (l9_590==1)
{
l9_589=fract(l9_589);
}
else
{
if (l9_590==2)
{
float l9_591=fract(l9_589);
float l9_592=l9_589-l9_591;
float l9_593=step(0.25,fract(l9_592*0.5));
l9_589=mix(l9_591,1.0-l9_591,fast::clamp(l9_593,0.0,1.0));
}
}
l9_573.y=l9_589;
if (l9_577)
{
bool l9_594=l9_579;
bool l9_595;
if (l9_594)
{
l9_595=l9_576.x==3;
}
else
{
l9_595=l9_594;
}
float l9_596=l9_573.x;
float l9_597=l9_578.x;
float l9_598=l9_578.z;
bool l9_599=l9_595;
float l9_600=l9_583;
float l9_601=fast::clamp(l9_596,l9_597,l9_598);
float l9_602=step(abs(l9_596-l9_601),9.9999997e-06);
l9_600*=(l9_602+((1.0-float(l9_599))*(1.0-l9_602)));
l9_596=l9_601;
l9_573.x=l9_596;
l9_583=l9_600;
bool l9_603=l9_579;
bool l9_604;
if (l9_603)
{
l9_604=l9_576.y==3;
}
else
{
l9_604=l9_603;
}
float l9_605=l9_573.y;
float l9_606=l9_578.y;
float l9_607=l9_578.w;
bool l9_608=l9_604;
float l9_609=l9_583;
float l9_610=fast::clamp(l9_605,l9_606,l9_607);
float l9_611=step(abs(l9_605-l9_610),9.9999997e-06);
l9_609*=(l9_611+((1.0-float(l9_608))*(1.0-l9_611)));
l9_605=l9_610;
l9_573.y=l9_605;
l9_583=l9_609;
}
float2 l9_612=l9_573;
bool l9_613=l9_574;
float3x3 l9_614=l9_575;
if (l9_613)
{
l9_612=float2((l9_614*float3(l9_612,1.0)).xy);
}
float2 l9_615=l9_612;
float2 l9_616=l9_615;
float2 l9_617=l9_616;
l9_573=l9_617;
float l9_618=l9_573.x;
int l9_619=l9_576.x;
bool l9_620=l9_582;
float l9_621=l9_583;
if ((l9_619==0)||(l9_619==3))
{
float l9_622=l9_618;
float l9_623=0.0;
float l9_624=1.0;
bool l9_625=l9_620;
float l9_626=l9_621;
float l9_627=fast::clamp(l9_622,l9_623,l9_624);
float l9_628=step(abs(l9_622-l9_627),9.9999997e-06);
l9_626*=(l9_628+((1.0-float(l9_625))*(1.0-l9_628)));
l9_622=l9_627;
l9_618=l9_622;
l9_621=l9_626;
}
l9_573.x=l9_618;
l9_583=l9_621;
float l9_629=l9_573.y;
int l9_630=l9_576.y;
bool l9_631=l9_582;
float l9_632=l9_583;
if ((l9_630==0)||(l9_630==3))
{
float l9_633=l9_629;
float l9_634=0.0;
float l9_635=1.0;
bool l9_636=l9_631;
float l9_637=l9_632;
float l9_638=fast::clamp(l9_633,l9_634,l9_635);
float l9_639=step(abs(l9_633-l9_638),9.9999997e-06);
l9_637*=(l9_639+((1.0-float(l9_636))*(1.0-l9_639)));
l9_633=l9_638;
l9_629=l9_633;
l9_632=l9_637;
}
l9_573.y=l9_629;
l9_583=l9_632;
float2 l9_640=l9_573;
int l9_641=l9_571;
int l9_642=l9_572;
float l9_643=l9_581;
float2 l9_644=l9_640;
int l9_645=l9_641;
int l9_646=l9_642;
float3 l9_647=float3(0.0);
if (l9_645==0)
{
l9_647=float3(l9_644,0.0);
}
else
{
if (l9_645==1)
{
l9_647=float3(l9_644.x,(l9_644.y*0.5)+(0.5-(float(l9_646)*0.5)),0.0);
}
else
{
l9_647=float3(l9_644,float(l9_646));
}
}
float3 l9_648=l9_647;
float3 l9_649=l9_648;
float2 l9_650=l9_649.xy;
float l9_651=l9_643;
float4 l9_652=sc_set2.metallicRoughnessTexture.sample(sc_set2.metallicRoughnessTextureSmpSC,l9_650,bias(l9_651));
float4 l9_653=l9_652;
float4 l9_654=l9_653;
if (l9_579)
{
l9_654=mix(l9_580,l9_654,float4(l9_583));
}
float4 l9_655=l9_654;
l9_564=l9_655;
float4 l9_656=l9_564;
float3 l9_657=l9_656.xyz;
l9_543*=l9_657.x;
l9_544*=l9_657.y;
l9_545.w=N3_OcclusionStrength;
float3 l9_658=float3(1.0+(l9_545.w*(l9_657.z-1.0)));
l9_545=float4(l9_658.x,l9_658.y,l9_658.z,l9_545.w);
N3_Metallic=l9_543;
N3_Roughness=l9_544;
N3_Occlusion=l9_545;
}
if (N3_TransmissionEnable)
{
float3 l9_659=N3_BaseColor;
float3 l9_660=N3_Emissive;
float l9_661=N3_Metallic;
float2 l9_662=tempGlobals.gScreenCoord;
float2 l9_663=l9_662;
float4 l9_664=float4(0.0);
int l9_665=0;
if ((int(screenTextureHasSwappedViews_tmp)!=0))
{
int l9_666=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_666=0;
}
else
{
l9_666=in.varStereoViewID;
}
int l9_667=l9_666;
l9_665=1-l9_667;
}
else
{
int l9_668=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_668=0;
}
else
{
l9_668=in.varStereoViewID;
}
int l9_669=l9_668;
l9_665=l9_669;
}
int l9_670=l9_665;
int l9_671=screenTextureLayout_tmp;
int l9_672=l9_670;
float2 l9_673=l9_663;
bool l9_674=(int(SC_USE_UV_TRANSFORM_screenTexture_tmp)!=0);
float3x3 l9_675=(*sc_set2.UserUniforms).screenTextureTransform;
int2 l9_676=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_screenTexture_tmp);
bool l9_677=(int(SC_USE_UV_MIN_MAX_screenTexture_tmp)!=0);
float4 l9_678=(*sc_set2.UserUniforms).screenTextureUvMinMax;
bool l9_679=(int(SC_USE_CLAMP_TO_BORDER_screenTexture_tmp)!=0);
float4 l9_680=(*sc_set2.UserUniforms).screenTextureBorderColor;
float l9_681=0.0;
bool l9_682=l9_679&&(!l9_677);
float l9_683=1.0;
float l9_684=l9_673.x;
int l9_685=l9_676.x;
if (l9_685==1)
{
l9_684=fract(l9_684);
}
else
{
if (l9_685==2)
{
float l9_686=fract(l9_684);
float l9_687=l9_684-l9_686;
float l9_688=step(0.25,fract(l9_687*0.5));
l9_684=mix(l9_686,1.0-l9_686,fast::clamp(l9_688,0.0,1.0));
}
}
l9_673.x=l9_684;
float l9_689=l9_673.y;
int l9_690=l9_676.y;
if (l9_690==1)
{
l9_689=fract(l9_689);
}
else
{
if (l9_690==2)
{
float l9_691=fract(l9_689);
float l9_692=l9_689-l9_691;
float l9_693=step(0.25,fract(l9_692*0.5));
l9_689=mix(l9_691,1.0-l9_691,fast::clamp(l9_693,0.0,1.0));
}
}
l9_673.y=l9_689;
if (l9_677)
{
bool l9_694=l9_679;
bool l9_695;
if (l9_694)
{
l9_695=l9_676.x==3;
}
else
{
l9_695=l9_694;
}
float l9_696=l9_673.x;
float l9_697=l9_678.x;
float l9_698=l9_678.z;
bool l9_699=l9_695;
float l9_700=l9_683;
float l9_701=fast::clamp(l9_696,l9_697,l9_698);
float l9_702=step(abs(l9_696-l9_701),9.9999997e-06);
l9_700*=(l9_702+((1.0-float(l9_699))*(1.0-l9_702)));
l9_696=l9_701;
l9_673.x=l9_696;
l9_683=l9_700;
bool l9_703=l9_679;
bool l9_704;
if (l9_703)
{
l9_704=l9_676.y==3;
}
else
{
l9_704=l9_703;
}
float l9_705=l9_673.y;
float l9_706=l9_678.y;
float l9_707=l9_678.w;
bool l9_708=l9_704;
float l9_709=l9_683;
float l9_710=fast::clamp(l9_705,l9_706,l9_707);
float l9_711=step(abs(l9_705-l9_710),9.9999997e-06);
l9_709*=(l9_711+((1.0-float(l9_708))*(1.0-l9_711)));
l9_705=l9_710;
l9_673.y=l9_705;
l9_683=l9_709;
}
float2 l9_712=l9_673;
bool l9_713=l9_674;
float3x3 l9_714=l9_675;
if (l9_713)
{
l9_712=float2((l9_714*float3(l9_712,1.0)).xy);
}
float2 l9_715=l9_712;
float2 l9_716=l9_715;
float2 l9_717=l9_716;
l9_673=l9_717;
float l9_718=l9_673.x;
int l9_719=l9_676.x;
bool l9_720=l9_682;
float l9_721=l9_683;
if ((l9_719==0)||(l9_719==3))
{
float l9_722=l9_718;
float l9_723=0.0;
float l9_724=1.0;
bool l9_725=l9_720;
float l9_726=l9_721;
float l9_727=fast::clamp(l9_722,l9_723,l9_724);
float l9_728=step(abs(l9_722-l9_727),9.9999997e-06);
l9_726*=(l9_728+((1.0-float(l9_725))*(1.0-l9_728)));
l9_722=l9_727;
l9_718=l9_722;
l9_721=l9_726;
}
l9_673.x=l9_718;
l9_683=l9_721;
float l9_729=l9_673.y;
int l9_730=l9_676.y;
bool l9_731=l9_682;
float l9_732=l9_683;
if ((l9_730==0)||(l9_730==3))
{
float l9_733=l9_729;
float l9_734=0.0;
float l9_735=1.0;
bool l9_736=l9_731;
float l9_737=l9_732;
float l9_738=fast::clamp(l9_733,l9_734,l9_735);
float l9_739=step(abs(l9_733-l9_738),9.9999997e-06);
l9_737*=(l9_739+((1.0-float(l9_736))*(1.0-l9_739)));
l9_733=l9_738;
l9_729=l9_733;
l9_732=l9_737;
}
l9_673.y=l9_729;
l9_683=l9_732;
float2 l9_740=l9_673;
int l9_741=l9_671;
int l9_742=l9_672;
float l9_743=l9_681;
float2 l9_744=l9_740;
int l9_745=l9_741;
int l9_746=l9_742;
float3 l9_747=float3(0.0);
if (l9_745==0)
{
l9_747=float3(l9_744,0.0);
}
else
{
if (l9_745==1)
{
l9_747=float3(l9_744.x,(l9_744.y*0.5)+(0.5-(float(l9_746)*0.5)),0.0);
}
else
{
l9_747=float3(l9_744,float(l9_746));
}
}
float3 l9_748=l9_747;
float3 l9_749=l9_748;
float2 l9_750=l9_749.xy;
float l9_751=l9_743;
float4 l9_752=sc_set2.screenTexture.sample(sc_set2.screenTextureSmpSC,l9_750,bias(l9_751));
float4 l9_753=l9_752;
float4 l9_754=l9_753;
if (l9_679)
{
l9_754=mix(l9_680,l9_754,float4(l9_683));
}
float4 l9_755=l9_754;
l9_664=l9_755;
float4 l9_756=l9_664;
float3 l9_757=l9_756.xyz;
float3 l9_758;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_758=float3(pow(l9_757.x,2.2),pow(l9_757.y,2.2),pow(l9_757.z,2.2));
}
else
{
l9_758=l9_757*l9_757;
}
float3 l9_759=l9_758;
N3_Background=l9_759;
float l9_760=1.0;
if (N3_EnableTransmissionTexture)
{
int l9_761=N3_TransmissionTextureCoord;
float2 l9_762=tempGlobals.Surface_UVCoord0;
float2 l9_763=l9_762;
if (l9_761==0)
{
float2 l9_764=tempGlobals.Surface_UVCoord0;
l9_763=l9_764;
}
if (l9_761==1)
{
float2 l9_765=tempGlobals.Surface_UVCoord1;
l9_763=l9_765;
}
float2 l9_766=l9_763;
float2 l9_767=l9_766;
if (N3_EnableTextureTransform&&N3_TransmissionTextureTransform)
{
float2 l9_768=l9_767;
float2 l9_769=N3_TransmissionTextureOffset;
float2 l9_770=N3_TransmissionTextureScale;
float l9_771=N3_TransmissionTextureRotation;
float l9_772=radians(l9_771);
float3x3 l9_773=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_769.x,l9_769.y,1.0));
float3x3 l9_774=float3x3(float3(cos(l9_772),sin(l9_772),0.0),float3(-sin(l9_772),cos(l9_772),0.0),float3(0.0,0.0,1.0));
float3x3 l9_775=float3x3(float3(l9_770.x,0.0,0.0),float3(0.0,l9_770.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_776=(l9_773*l9_774)*l9_775;
float2 l9_777=(l9_776*float3(l9_768,1.0)).xy;
l9_767=l9_777;
}
float2 l9_778=l9_767;
float4 l9_779=float4(0.0);
int l9_780=0;
if ((int(transmissionTextureHasSwappedViews_tmp)!=0))
{
int l9_781=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_781=0;
}
else
{
l9_781=in.varStereoViewID;
}
int l9_782=l9_781;
l9_780=1-l9_782;
}
else
{
int l9_783=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_783=0;
}
else
{
l9_783=in.varStereoViewID;
}
int l9_784=l9_783;
l9_780=l9_784;
}
int l9_785=l9_780;
int l9_786=transmissionTextureLayout_tmp;
int l9_787=l9_785;
float2 l9_788=l9_778;
bool l9_789=(int(SC_USE_UV_TRANSFORM_transmissionTexture_tmp)!=0);
float3x3 l9_790=(*sc_set2.UserUniforms).transmissionTextureTransform;
int2 l9_791=int2(SC_SOFTWARE_WRAP_MODE_U_transmissionTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_transmissionTexture_tmp);
bool l9_792=(int(SC_USE_UV_MIN_MAX_transmissionTexture_tmp)!=0);
float4 l9_793=(*sc_set2.UserUniforms).transmissionTextureUvMinMax;
bool l9_794=(int(SC_USE_CLAMP_TO_BORDER_transmissionTexture_tmp)!=0);
float4 l9_795=(*sc_set2.UserUniforms).transmissionTextureBorderColor;
float l9_796=0.0;
bool l9_797=l9_794&&(!l9_792);
float l9_798=1.0;
float l9_799=l9_788.x;
int l9_800=l9_791.x;
if (l9_800==1)
{
l9_799=fract(l9_799);
}
else
{
if (l9_800==2)
{
float l9_801=fract(l9_799);
float l9_802=l9_799-l9_801;
float l9_803=step(0.25,fract(l9_802*0.5));
l9_799=mix(l9_801,1.0-l9_801,fast::clamp(l9_803,0.0,1.0));
}
}
l9_788.x=l9_799;
float l9_804=l9_788.y;
int l9_805=l9_791.y;
if (l9_805==1)
{
l9_804=fract(l9_804);
}
else
{
if (l9_805==2)
{
float l9_806=fract(l9_804);
float l9_807=l9_804-l9_806;
float l9_808=step(0.25,fract(l9_807*0.5));
l9_804=mix(l9_806,1.0-l9_806,fast::clamp(l9_808,0.0,1.0));
}
}
l9_788.y=l9_804;
if (l9_792)
{
bool l9_809=l9_794;
bool l9_810;
if (l9_809)
{
l9_810=l9_791.x==3;
}
else
{
l9_810=l9_809;
}
float l9_811=l9_788.x;
float l9_812=l9_793.x;
float l9_813=l9_793.z;
bool l9_814=l9_810;
float l9_815=l9_798;
float l9_816=fast::clamp(l9_811,l9_812,l9_813);
float l9_817=step(abs(l9_811-l9_816),9.9999997e-06);
l9_815*=(l9_817+((1.0-float(l9_814))*(1.0-l9_817)));
l9_811=l9_816;
l9_788.x=l9_811;
l9_798=l9_815;
bool l9_818=l9_794;
bool l9_819;
if (l9_818)
{
l9_819=l9_791.y==3;
}
else
{
l9_819=l9_818;
}
float l9_820=l9_788.y;
float l9_821=l9_793.y;
float l9_822=l9_793.w;
bool l9_823=l9_819;
float l9_824=l9_798;
float l9_825=fast::clamp(l9_820,l9_821,l9_822);
float l9_826=step(abs(l9_820-l9_825),9.9999997e-06);
l9_824*=(l9_826+((1.0-float(l9_823))*(1.0-l9_826)));
l9_820=l9_825;
l9_788.y=l9_820;
l9_798=l9_824;
}
float2 l9_827=l9_788;
bool l9_828=l9_789;
float3x3 l9_829=l9_790;
if (l9_828)
{
l9_827=float2((l9_829*float3(l9_827,1.0)).xy);
}
float2 l9_830=l9_827;
float2 l9_831=l9_830;
float2 l9_832=l9_831;
l9_788=l9_832;
float l9_833=l9_788.x;
int l9_834=l9_791.x;
bool l9_835=l9_797;
float l9_836=l9_798;
if ((l9_834==0)||(l9_834==3))
{
float l9_837=l9_833;
float l9_838=0.0;
float l9_839=1.0;
bool l9_840=l9_835;
float l9_841=l9_836;
float l9_842=fast::clamp(l9_837,l9_838,l9_839);
float l9_843=step(abs(l9_837-l9_842),9.9999997e-06);
l9_841*=(l9_843+((1.0-float(l9_840))*(1.0-l9_843)));
l9_837=l9_842;
l9_833=l9_837;
l9_836=l9_841;
}
l9_788.x=l9_833;
l9_798=l9_836;
float l9_844=l9_788.y;
int l9_845=l9_791.y;
bool l9_846=l9_797;
float l9_847=l9_798;
if ((l9_845==0)||(l9_845==3))
{
float l9_848=l9_844;
float l9_849=0.0;
float l9_850=1.0;
bool l9_851=l9_846;
float l9_852=l9_847;
float l9_853=fast::clamp(l9_848,l9_849,l9_850);
float l9_854=step(abs(l9_848-l9_853),9.9999997e-06);
l9_852*=(l9_854+((1.0-float(l9_851))*(1.0-l9_854)));
l9_848=l9_853;
l9_844=l9_848;
l9_847=l9_852;
}
l9_788.y=l9_844;
l9_798=l9_847;
float2 l9_855=l9_788;
int l9_856=l9_786;
int l9_857=l9_787;
float l9_858=l9_796;
float2 l9_859=l9_855;
int l9_860=l9_856;
int l9_861=l9_857;
float3 l9_862=float3(0.0);
if (l9_860==0)
{
l9_862=float3(l9_859,0.0);
}
else
{
if (l9_860==1)
{
l9_862=float3(l9_859.x,(l9_859.y*0.5)+(0.5-(float(l9_861)*0.5)),0.0);
}
else
{
l9_862=float3(l9_859,float(l9_861));
}
}
float3 l9_863=l9_862;
float3 l9_864=l9_863;
float2 l9_865=l9_864.xy;
float l9_866=l9_858;
float4 l9_867=sc_set2.transmissionTexture.sample(sc_set2.transmissionTextureSmpSC,l9_865,bias(l9_866));
float4 l9_868=l9_867;
float4 l9_869=l9_868;
if (l9_794)
{
l9_869=mix(l9_795,l9_869,float4(l9_798));
}
float4 l9_870=l9_869;
l9_779=l9_870;
float4 l9_871=l9_779;
l9_760=l9_871.x;
}
l9_760*=N3_TransmissionFactor;
float3 l9_872=l9_659;
l9_659=mix(l9_872,float3(0.0),float3(l9_760));
l9_659=mix(l9_659,l9_872,float3(l9_661));
float3 l9_873=l9_660;
l9_660=mix(float3(0.0),l9_872,float3(l9_760))*N3_Background;
l9_660=mix(l9_660,float3(0.0),float3(l9_661))+l9_873;
N3_BaseColor=l9_659;
N3_Emissive=l9_660;
}
float3 l9_874=N3_BaseColor;
float3 l9_875;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_875=float3(pow(l9_874.x,0.45454544),pow(l9_874.y,0.45454544),pow(l9_874.z,0.45454544));
}
else
{
l9_875=sqrt(l9_874);
}
float3 l9_876=l9_875;
N3_BaseColor=l9_876;
float l9_877=N3_Opacity;
float l9_878;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_878=pow(l9_877,0.45454544);
}
else
{
l9_878=sqrt(l9_877);
}
float l9_879=l9_878;
N3_Opacity=l9_879;
float3 l9_880=N3_Emissive;
float3 l9_881;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_881=float3(pow(l9_880.x,0.45454544),pow(l9_880.y,0.45454544),pow(l9_880.z,0.45454544));
}
else
{
l9_881=sqrt(l9_880);
}
float3 l9_882=l9_881;
N3_Emissive=l9_882;
if (N3_SheenEnable)
{
float3 l9_883=N3_Normal;
float4 l9_884=N3_Occlusion;
float3 l9_885=N3_SheenColorFactor;
float l9_886=N3_SheenRoughnessFactor;
if (N3_EnableSheenTexture)
{
int l9_887=N3_SheenColorTextureCoord;
float2 l9_888=tempGlobals.Surface_UVCoord0;
float2 l9_889=l9_888;
if (l9_887==0)
{
float2 l9_890=tempGlobals.Surface_UVCoord0;
l9_889=l9_890;
}
if (l9_887==1)
{
float2 l9_891=tempGlobals.Surface_UVCoord1;
l9_889=l9_891;
}
float2 l9_892=l9_889;
float2 l9_893=l9_892;
if (N3_EnableTextureTransform&&N3_SheenColorTextureTransform)
{
float2 l9_894=l9_893;
float2 l9_895=N3_SheenColorTextureOffset;
float2 l9_896=N3_SheenColorTextureScale;
float l9_897=N3_SheenColorTextureRotation;
float l9_898=radians(l9_897);
float3x3 l9_899=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_895.x,l9_895.y,1.0));
float3x3 l9_900=float3x3(float3(cos(l9_898),sin(l9_898),0.0),float3(-sin(l9_898),cos(l9_898),0.0),float3(0.0,0.0,1.0));
float3x3 l9_901=float3x3(float3(l9_896.x,0.0,0.0),float3(0.0,l9_896.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_902=(l9_899*l9_900)*l9_901;
float2 l9_903=(l9_902*float3(l9_894,1.0)).xy;
l9_893=l9_903;
}
float2 l9_904=l9_893;
float4 l9_905=float4(0.0);
int l9_906=0;
if ((int(sheenColorTextureHasSwappedViews_tmp)!=0))
{
int l9_907=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_907=0;
}
else
{
l9_907=in.varStereoViewID;
}
int l9_908=l9_907;
l9_906=1-l9_908;
}
else
{
int l9_909=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_909=0;
}
else
{
l9_909=in.varStereoViewID;
}
int l9_910=l9_909;
l9_906=l9_910;
}
int l9_911=l9_906;
int l9_912=sheenColorTextureLayout_tmp;
int l9_913=l9_911;
float2 l9_914=l9_904;
bool l9_915=(int(SC_USE_UV_TRANSFORM_sheenColorTexture_tmp)!=0);
float3x3 l9_916=(*sc_set2.UserUniforms).sheenColorTextureTransform;
int2 l9_917=int2(SC_SOFTWARE_WRAP_MODE_U_sheenColorTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sheenColorTexture_tmp);
bool l9_918=(int(SC_USE_UV_MIN_MAX_sheenColorTexture_tmp)!=0);
float4 l9_919=(*sc_set2.UserUniforms).sheenColorTextureUvMinMax;
bool l9_920=(int(SC_USE_CLAMP_TO_BORDER_sheenColorTexture_tmp)!=0);
float4 l9_921=(*sc_set2.UserUniforms).sheenColorTextureBorderColor;
float l9_922=0.0;
bool l9_923=l9_920&&(!l9_918);
float l9_924=1.0;
float l9_925=l9_914.x;
int l9_926=l9_917.x;
if (l9_926==1)
{
l9_925=fract(l9_925);
}
else
{
if (l9_926==2)
{
float l9_927=fract(l9_925);
float l9_928=l9_925-l9_927;
float l9_929=step(0.25,fract(l9_928*0.5));
l9_925=mix(l9_927,1.0-l9_927,fast::clamp(l9_929,0.0,1.0));
}
}
l9_914.x=l9_925;
float l9_930=l9_914.y;
int l9_931=l9_917.y;
if (l9_931==1)
{
l9_930=fract(l9_930);
}
else
{
if (l9_931==2)
{
float l9_932=fract(l9_930);
float l9_933=l9_930-l9_932;
float l9_934=step(0.25,fract(l9_933*0.5));
l9_930=mix(l9_932,1.0-l9_932,fast::clamp(l9_934,0.0,1.0));
}
}
l9_914.y=l9_930;
if (l9_918)
{
bool l9_935=l9_920;
bool l9_936;
if (l9_935)
{
l9_936=l9_917.x==3;
}
else
{
l9_936=l9_935;
}
float l9_937=l9_914.x;
float l9_938=l9_919.x;
float l9_939=l9_919.z;
bool l9_940=l9_936;
float l9_941=l9_924;
float l9_942=fast::clamp(l9_937,l9_938,l9_939);
float l9_943=step(abs(l9_937-l9_942),9.9999997e-06);
l9_941*=(l9_943+((1.0-float(l9_940))*(1.0-l9_943)));
l9_937=l9_942;
l9_914.x=l9_937;
l9_924=l9_941;
bool l9_944=l9_920;
bool l9_945;
if (l9_944)
{
l9_945=l9_917.y==3;
}
else
{
l9_945=l9_944;
}
float l9_946=l9_914.y;
float l9_947=l9_919.y;
float l9_948=l9_919.w;
bool l9_949=l9_945;
float l9_950=l9_924;
float l9_951=fast::clamp(l9_946,l9_947,l9_948);
float l9_952=step(abs(l9_946-l9_951),9.9999997e-06);
l9_950*=(l9_952+((1.0-float(l9_949))*(1.0-l9_952)));
l9_946=l9_951;
l9_914.y=l9_946;
l9_924=l9_950;
}
float2 l9_953=l9_914;
bool l9_954=l9_915;
float3x3 l9_955=l9_916;
if (l9_954)
{
l9_953=float2((l9_955*float3(l9_953,1.0)).xy);
}
float2 l9_956=l9_953;
float2 l9_957=l9_956;
float2 l9_958=l9_957;
l9_914=l9_958;
float l9_959=l9_914.x;
int l9_960=l9_917.x;
bool l9_961=l9_923;
float l9_962=l9_924;
if ((l9_960==0)||(l9_960==3))
{
float l9_963=l9_959;
float l9_964=0.0;
float l9_965=1.0;
bool l9_966=l9_961;
float l9_967=l9_962;
float l9_968=fast::clamp(l9_963,l9_964,l9_965);
float l9_969=step(abs(l9_963-l9_968),9.9999997e-06);
l9_967*=(l9_969+((1.0-float(l9_966))*(1.0-l9_969)));
l9_963=l9_968;
l9_959=l9_963;
l9_962=l9_967;
}
l9_914.x=l9_959;
l9_924=l9_962;
float l9_970=l9_914.y;
int l9_971=l9_917.y;
bool l9_972=l9_923;
float l9_973=l9_924;
if ((l9_971==0)||(l9_971==3))
{
float l9_974=l9_970;
float l9_975=0.0;
float l9_976=1.0;
bool l9_977=l9_972;
float l9_978=l9_973;
float l9_979=fast::clamp(l9_974,l9_975,l9_976);
float l9_980=step(abs(l9_974-l9_979),9.9999997e-06);
l9_978*=(l9_980+((1.0-float(l9_977))*(1.0-l9_980)));
l9_974=l9_979;
l9_970=l9_974;
l9_973=l9_978;
}
l9_914.y=l9_970;
l9_924=l9_973;
float2 l9_981=l9_914;
int l9_982=l9_912;
int l9_983=l9_913;
float l9_984=l9_922;
float2 l9_985=l9_981;
int l9_986=l9_982;
int l9_987=l9_983;
float3 l9_988=float3(0.0);
if (l9_986==0)
{
l9_988=float3(l9_985,0.0);
}
else
{
if (l9_986==1)
{
l9_988=float3(l9_985.x,(l9_985.y*0.5)+(0.5-(float(l9_987)*0.5)),0.0);
}
else
{
l9_988=float3(l9_985,float(l9_987));
}
}
float3 l9_989=l9_988;
float3 l9_990=l9_989;
float2 l9_991=l9_990.xy;
float l9_992=l9_984;
float4 l9_993=sc_set2.sheenColorTexture.sample(sc_set2.sheenColorTextureSmpSC,l9_991,bias(l9_992));
float4 l9_994=l9_993;
float4 l9_995=l9_994;
if (l9_920)
{
l9_995=mix(l9_921,l9_995,float4(l9_924));
}
float4 l9_996=l9_995;
l9_905=l9_996;
float4 l9_997=l9_905;
float3 l9_998=l9_997.xyz;
float3 l9_999;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_999=float3(pow(l9_998.x,2.2),pow(l9_998.y,2.2),pow(l9_998.z,2.2));
}
else
{
l9_999=l9_998*l9_998;
}
float3 l9_1000=l9_999;
l9_885*=l9_1000;
}
if (N3_EnableSheenRoughnessTexture)
{
int l9_1001=N3_SheenRoughnessTextureCoord;
float2 l9_1002=tempGlobals.Surface_UVCoord0;
float2 l9_1003=l9_1002;
if (l9_1001==0)
{
float2 l9_1004=tempGlobals.Surface_UVCoord0;
l9_1003=l9_1004;
}
if (l9_1001==1)
{
float2 l9_1005=tempGlobals.Surface_UVCoord1;
l9_1003=l9_1005;
}
float2 l9_1006=l9_1003;
float2 l9_1007=l9_1006;
if (N3_EnableTextureTransform&&N3_SheenRoughnessTextureTransform)
{
float2 l9_1008=l9_1007;
float2 l9_1009=N3_SheenRoughnessTextureOffset;
float2 l9_1010=N3_SheenRoughnessTextureScale;
float l9_1011=N3_SheenRoughnessTextureRotation;
float l9_1012=radians(l9_1011);
float3x3 l9_1013=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_1009.x,l9_1009.y,1.0));
float3x3 l9_1014=float3x3(float3(cos(l9_1012),sin(l9_1012),0.0),float3(-sin(l9_1012),cos(l9_1012),0.0),float3(0.0,0.0,1.0));
float3x3 l9_1015=float3x3(float3(l9_1010.x,0.0,0.0),float3(0.0,l9_1010.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_1016=(l9_1013*l9_1014)*l9_1015;
float2 l9_1017=(l9_1016*float3(l9_1008,1.0)).xy;
l9_1007=l9_1017;
}
float2 l9_1018=l9_1007;
float4 l9_1019=float4(0.0);
int l9_1020=0;
if ((int(sheenRoughnessTextureHasSwappedViews_tmp)!=0))
{
int l9_1021=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1021=0;
}
else
{
l9_1021=in.varStereoViewID;
}
int l9_1022=l9_1021;
l9_1020=1-l9_1022;
}
else
{
int l9_1023=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1023=0;
}
else
{
l9_1023=in.varStereoViewID;
}
int l9_1024=l9_1023;
l9_1020=l9_1024;
}
int l9_1025=l9_1020;
int l9_1026=sheenRoughnessTextureLayout_tmp;
int l9_1027=l9_1025;
float2 l9_1028=l9_1018;
bool l9_1029=(int(SC_USE_UV_TRANSFORM_sheenRoughnessTexture_tmp)!=0);
float3x3 l9_1030=(*sc_set2.UserUniforms).sheenRoughnessTextureTransform;
int2 l9_1031=int2(SC_SOFTWARE_WRAP_MODE_U_sheenRoughnessTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sheenRoughnessTexture_tmp);
bool l9_1032=(int(SC_USE_UV_MIN_MAX_sheenRoughnessTexture_tmp)!=0);
float4 l9_1033=(*sc_set2.UserUniforms).sheenRoughnessTextureUvMinMax;
bool l9_1034=(int(SC_USE_CLAMP_TO_BORDER_sheenRoughnessTexture_tmp)!=0);
float4 l9_1035=(*sc_set2.UserUniforms).sheenRoughnessTextureBorderColor;
float l9_1036=0.0;
bool l9_1037=l9_1034&&(!l9_1032);
float l9_1038=1.0;
float l9_1039=l9_1028.x;
int l9_1040=l9_1031.x;
if (l9_1040==1)
{
l9_1039=fract(l9_1039);
}
else
{
if (l9_1040==2)
{
float l9_1041=fract(l9_1039);
float l9_1042=l9_1039-l9_1041;
float l9_1043=step(0.25,fract(l9_1042*0.5));
l9_1039=mix(l9_1041,1.0-l9_1041,fast::clamp(l9_1043,0.0,1.0));
}
}
l9_1028.x=l9_1039;
float l9_1044=l9_1028.y;
int l9_1045=l9_1031.y;
if (l9_1045==1)
{
l9_1044=fract(l9_1044);
}
else
{
if (l9_1045==2)
{
float l9_1046=fract(l9_1044);
float l9_1047=l9_1044-l9_1046;
float l9_1048=step(0.25,fract(l9_1047*0.5));
l9_1044=mix(l9_1046,1.0-l9_1046,fast::clamp(l9_1048,0.0,1.0));
}
}
l9_1028.y=l9_1044;
if (l9_1032)
{
bool l9_1049=l9_1034;
bool l9_1050;
if (l9_1049)
{
l9_1050=l9_1031.x==3;
}
else
{
l9_1050=l9_1049;
}
float l9_1051=l9_1028.x;
float l9_1052=l9_1033.x;
float l9_1053=l9_1033.z;
bool l9_1054=l9_1050;
float l9_1055=l9_1038;
float l9_1056=fast::clamp(l9_1051,l9_1052,l9_1053);
float l9_1057=step(abs(l9_1051-l9_1056),9.9999997e-06);
l9_1055*=(l9_1057+((1.0-float(l9_1054))*(1.0-l9_1057)));
l9_1051=l9_1056;
l9_1028.x=l9_1051;
l9_1038=l9_1055;
bool l9_1058=l9_1034;
bool l9_1059;
if (l9_1058)
{
l9_1059=l9_1031.y==3;
}
else
{
l9_1059=l9_1058;
}
float l9_1060=l9_1028.y;
float l9_1061=l9_1033.y;
float l9_1062=l9_1033.w;
bool l9_1063=l9_1059;
float l9_1064=l9_1038;
float l9_1065=fast::clamp(l9_1060,l9_1061,l9_1062);
float l9_1066=step(abs(l9_1060-l9_1065),9.9999997e-06);
l9_1064*=(l9_1066+((1.0-float(l9_1063))*(1.0-l9_1066)));
l9_1060=l9_1065;
l9_1028.y=l9_1060;
l9_1038=l9_1064;
}
float2 l9_1067=l9_1028;
bool l9_1068=l9_1029;
float3x3 l9_1069=l9_1030;
if (l9_1068)
{
l9_1067=float2((l9_1069*float3(l9_1067,1.0)).xy);
}
float2 l9_1070=l9_1067;
float2 l9_1071=l9_1070;
float2 l9_1072=l9_1071;
l9_1028=l9_1072;
float l9_1073=l9_1028.x;
int l9_1074=l9_1031.x;
bool l9_1075=l9_1037;
float l9_1076=l9_1038;
if ((l9_1074==0)||(l9_1074==3))
{
float l9_1077=l9_1073;
float l9_1078=0.0;
float l9_1079=1.0;
bool l9_1080=l9_1075;
float l9_1081=l9_1076;
float l9_1082=fast::clamp(l9_1077,l9_1078,l9_1079);
float l9_1083=step(abs(l9_1077-l9_1082),9.9999997e-06);
l9_1081*=(l9_1083+((1.0-float(l9_1080))*(1.0-l9_1083)));
l9_1077=l9_1082;
l9_1073=l9_1077;
l9_1076=l9_1081;
}
l9_1028.x=l9_1073;
l9_1038=l9_1076;
float l9_1084=l9_1028.y;
int l9_1085=l9_1031.y;
bool l9_1086=l9_1037;
float l9_1087=l9_1038;
if ((l9_1085==0)||(l9_1085==3))
{
float l9_1088=l9_1084;
float l9_1089=0.0;
float l9_1090=1.0;
bool l9_1091=l9_1086;
float l9_1092=l9_1087;
float l9_1093=fast::clamp(l9_1088,l9_1089,l9_1090);
float l9_1094=step(abs(l9_1088-l9_1093),9.9999997e-06);
l9_1092*=(l9_1094+((1.0-float(l9_1091))*(1.0-l9_1094)));
l9_1088=l9_1093;
l9_1084=l9_1088;
l9_1087=l9_1092;
}
l9_1028.y=l9_1084;
l9_1038=l9_1087;
float2 l9_1095=l9_1028;
int l9_1096=l9_1026;
int l9_1097=l9_1027;
float l9_1098=l9_1036;
float2 l9_1099=l9_1095;
int l9_1100=l9_1096;
int l9_1101=l9_1097;
float3 l9_1102=float3(0.0);
if (l9_1100==0)
{
l9_1102=float3(l9_1099,0.0);
}
else
{
if (l9_1100==1)
{
l9_1102=float3(l9_1099.x,(l9_1099.y*0.5)+(0.5-(float(l9_1101)*0.5)),0.0);
}
else
{
l9_1102=float3(l9_1099,float(l9_1101));
}
}
float3 l9_1103=l9_1102;
float3 l9_1104=l9_1103;
float2 l9_1105=l9_1104.xy;
float l9_1106=l9_1098;
float4 l9_1107=sc_set2.sheenRoughnessTexture.sample(sc_set2.sheenRoughnessTextureSmpSC,l9_1105,bias(l9_1106));
float4 l9_1108=l9_1107;
float4 l9_1109=l9_1108;
if (l9_1034)
{
l9_1109=mix(l9_1035,l9_1109,float4(l9_1038));
}
float4 l9_1110=l9_1109;
l9_1019=l9_1110;
float4 l9_1111=l9_1019;
float l9_1112=l9_1111.w;
float l9_1113;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1113=pow(l9_1112,2.2);
}
else
{
l9_1113=l9_1112*l9_1112;
}
float l9_1114=l9_1113;
l9_886*=l9_1114;
}
l9_886=fast::max(l9_886,9.9999997e-05);
N3_SheenOut=float4(0.0);
float3 l9_1115=l9_883;
float3 l9_1116=tempGlobals.ViewDirWS;
float3 l9_1117=l9_1116;
float3 l9_1118=l9_1115;
float3 l9_1119=l9_1117;
float l9_1120=fast::clamp(dot(l9_1118,l9_1119),0.0,1.0);
float l9_1121=fast::max(l9_1120,9.9999997e-05);
float l9_1122=l9_886*l9_886;
float3 l9_1123=normalize(reflect(-l9_1117,l9_1115));
float l9_1124=l9_1121;
float3 l9_1125=l9_1123;
float l9_1126=l9_886;
float3 l9_1127=l9_885;
float l9_1128=l9_1126*4.0;
l9_1128=3.0+(((l9_1128-0.0)*2.0)/5.0);
float l9_1129=l9_1126*l9_1126;
float l9_1130;
if (l9_1126<0.25)
{
l9_1130=(((-339.20001)*l9_1129)+(161.39999*l9_1126))-25.9;
}
else
{
l9_1130=(((-8.4799995)*l9_1129)+(14.3*l9_1126))-9.9499998;
}
float l9_1131=l9_1130;
float l9_1132;
if (l9_1126<0.25)
{
l9_1132=((44.0*l9_1129)-(23.700001*l9_1126))+3.26;
}
else
{
l9_1132=((1.97*l9_1129)-(3.27*l9_1126))+0.72000003;
}
float l9_1133=l9_1132;
float l9_1134=l9_1131;
float l9_1135=l9_1124;
float l9_1136=l9_1133;
float l9_1137;
if (l9_1126<0.25)
{
l9_1137=0.0;
}
else
{
l9_1137=0.1*(l9_1126-0.25);
}
float l9_1138=exp((l9_1134*l9_1135)+l9_1136)+l9_1137;
float l9_1139=3.1415927;
l9_1138=fast::clamp(l9_1138*l9_1139,0.0,1.0);
float3 l9_1140=l9_1125;
float l9_1141=l9_1128;
float3 l9_1142=float3(0.0);
float3 l9_1143=l9_1140;
float l9_1144=l9_1141;
float3 l9_1145=l9_1143;
float l9_1146=l9_1144;
float4 l9_1147=float4(0.0);
float3 l9_1148=l9_1145;
float l9_1149=(*sc_set2.UserUniforms).sc_EnvmapRotation.y;
float2 l9_1150=float2(0.0);
float l9_1151=l9_1148.x;
float l9_1152=-l9_1148.z;
float l9_1153=(l9_1151<0.0) ? (-1.0) : 1.0;
float l9_1154=l9_1153*acos(fast::clamp(l9_1152/length(float2(l9_1151,l9_1152)),-1.0,1.0));
l9_1150.x=l9_1154-1.5707964;
l9_1150.y=acos(l9_1148.y);
l9_1150/=float2(6.2831855,3.1415927);
l9_1150.y=1.0-l9_1150.y;
l9_1150.x+=(l9_1149/360.0);
l9_1150.x=fract((l9_1150.x+floor(l9_1150.x))+1.0);
float2 l9_1155=l9_1150;
float2 l9_1156=l9_1155;
if (SC_DEVICE_CLASS_tmp>=2)
{
float l9_1157=floor(l9_1146);
float l9_1158=ceil(l9_1146);
float l9_1159=l9_1146-l9_1157;
float2 l9_1160=l9_1156;
float2 l9_1161=(*sc_set2.UserUniforms).sc_EnvmapSpecularSize.xy;
float l9_1162=l9_1157;
float2 l9_1163=calcSeamlessPanoramicUvsForSampling(l9_1160,l9_1161,l9_1162);
float2 l9_1164=l9_1163;
float l9_1165=l9_1157;
float2 l9_1166=l9_1164;
float l9_1167=l9_1165;
int l9_1168=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1169=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1169=0;
}
else
{
l9_1169=in.varStereoViewID;
}
int l9_1170=l9_1169;
l9_1168=1-l9_1170;
}
else
{
int l9_1171=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1171=0;
}
else
{
l9_1171=in.varStereoViewID;
}
int l9_1172=l9_1171;
l9_1168=l9_1172;
}
int l9_1173=l9_1168;
float2 l9_1174=l9_1166;
int l9_1175=l9_1173;
float l9_1176=l9_1167;
float4 l9_1177=float4(0.0);
float2 l9_1178=l9_1174;
int l9_1179=sc_EnvmapSpecularLayout_tmp;
int l9_1180=l9_1175;
float l9_1181=l9_1176;
float2 l9_1182=l9_1178;
int l9_1183=l9_1179;
int l9_1184=l9_1180;
float3 l9_1185=float3(0.0);
if (l9_1183==0)
{
l9_1185=float3(l9_1182,0.0);
}
else
{
if (l9_1183==1)
{
l9_1185=float3(l9_1182.x,(l9_1182.y*0.5)+(0.5-(float(l9_1184)*0.5)),0.0);
}
else
{
l9_1185=float3(l9_1182,float(l9_1184));
}
}
float3 l9_1186=l9_1185;
float3 l9_1187=l9_1186;
float2 l9_1188=l9_1187.xy;
float l9_1189=l9_1181;
float4 l9_1190=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1188,level(l9_1189));
float4 l9_1191=l9_1190;
l9_1177=l9_1191;
float4 l9_1192=l9_1177;
float4 l9_1193=l9_1192;
float4 l9_1194=l9_1193;
float4 l9_1195=l9_1194;
float2 l9_1196=l9_1156;
float2 l9_1197=(*sc_set2.UserUniforms).sc_EnvmapSpecularSize.xy;
float l9_1198=l9_1158;
float2 l9_1199=calcSeamlessPanoramicUvsForSampling(l9_1196,l9_1197,l9_1198);
float2 l9_1200=l9_1199;
float l9_1201=l9_1158;
float2 l9_1202=l9_1200;
float l9_1203=l9_1201;
int l9_1204=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1205=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1205=0;
}
else
{
l9_1205=in.varStereoViewID;
}
int l9_1206=l9_1205;
l9_1204=1-l9_1206;
}
else
{
int l9_1207=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1207=0;
}
else
{
l9_1207=in.varStereoViewID;
}
int l9_1208=l9_1207;
l9_1204=l9_1208;
}
int l9_1209=l9_1204;
float2 l9_1210=l9_1202;
int l9_1211=l9_1209;
float l9_1212=l9_1203;
float4 l9_1213=float4(0.0);
float2 l9_1214=l9_1210;
int l9_1215=sc_EnvmapSpecularLayout_tmp;
int l9_1216=l9_1211;
float l9_1217=l9_1212;
float2 l9_1218=l9_1214;
int l9_1219=l9_1215;
int l9_1220=l9_1216;
float3 l9_1221=float3(0.0);
if (l9_1219==0)
{
l9_1221=float3(l9_1218,0.0);
}
else
{
if (l9_1219==1)
{
l9_1221=float3(l9_1218.x,(l9_1218.y*0.5)+(0.5-(float(l9_1220)*0.5)),0.0);
}
else
{
l9_1221=float3(l9_1218,float(l9_1220));
}
}
float3 l9_1222=l9_1221;
float3 l9_1223=l9_1222;
float2 l9_1224=l9_1223.xy;
float l9_1225=l9_1217;
float4 l9_1226=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1224,level(l9_1225));
float4 l9_1227=l9_1226;
l9_1213=l9_1227;
float4 l9_1228=l9_1213;
float4 l9_1229=l9_1228;
float4 l9_1230=l9_1229;
float4 l9_1231=l9_1230;
l9_1147=mix(l9_1195,l9_1231,float4(l9_1159));
}
else
{
float2 l9_1232=l9_1156;
float l9_1233=l9_1146;
float2 l9_1234=l9_1232;
float l9_1235=l9_1233;
int l9_1236=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1237=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1237=0;
}
else
{
l9_1237=in.varStereoViewID;
}
int l9_1238=l9_1237;
l9_1236=1-l9_1238;
}
else
{
int l9_1239=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1239=0;
}
else
{
l9_1239=in.varStereoViewID;
}
int l9_1240=l9_1239;
l9_1236=l9_1240;
}
int l9_1241=l9_1236;
float2 l9_1242=l9_1234;
int l9_1243=l9_1241;
float l9_1244=l9_1235;
float4 l9_1245=float4(0.0);
float2 l9_1246=l9_1242;
int l9_1247=sc_EnvmapSpecularLayout_tmp;
int l9_1248=l9_1243;
float l9_1249=l9_1244;
float2 l9_1250=l9_1246;
int l9_1251=l9_1247;
int l9_1252=l9_1248;
float3 l9_1253=float3(0.0);
if (l9_1251==0)
{
l9_1253=float3(l9_1250,0.0);
}
else
{
if (l9_1251==1)
{
l9_1253=float3(l9_1250.x,(l9_1250.y*0.5)+(0.5-(float(l9_1252)*0.5)),0.0);
}
else
{
l9_1253=float3(l9_1250,float(l9_1252));
}
}
float3 l9_1254=l9_1253;
float3 l9_1255=l9_1254;
float2 l9_1256=l9_1255.xy;
float l9_1257=l9_1249;
float4 l9_1258=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1256,level(l9_1257));
float4 l9_1259=l9_1258;
l9_1245=l9_1259;
float4 l9_1260=l9_1245;
float4 l9_1261=l9_1260;
float4 l9_1262=l9_1261;
l9_1147=l9_1262;
}
float4 l9_1263=l9_1147;
float3 l9_1264=l9_1263.xyz*(1.0/l9_1263.w);
float3 l9_1265=l9_1264;
float3 l9_1266=l9_1265*(*sc_set2.UserUniforms).sc_EnvmapExposure;
l9_1266+=float3(1e-06);
float3 l9_1267=l9_1266;
l9_1142=l9_1267;
float3 l9_1268=l9_1142;
float3 l9_1269=l9_1268;
float3 l9_1270=(l9_1269*l9_1127)*l9_1138;
float3 l9_1271=N3_SheenOut.xyz+l9_1270;
N3_SheenOut=float4(l9_1271.x,l9_1271.y,l9_1271.z,N3_SheenOut.w);
float3 l9_1272=mix(N3_SheenOut.xyz,N3_SheenOut.xyz*l9_884.xyz,float3(l9_884.w));
N3_SheenOut=float4(l9_1272.x,l9_1272.y,l9_1272.z,N3_SheenOut.w);
float3 l9_1273=l9_885;
float3 l9_1274=l9_1115;
float3 l9_1275=l9_1117;
float l9_1276=l9_1121;
float l9_1277=l9_1122;
float3 l9_1278=float3(0.0);
int l9_1279=0;
l9_1279=sc_DirectionalLightsCount_tmp;
int l9_1280=l9_1279;
if (l9_1280>0)
{
float l9_1281;
int l9_1282=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
int l9_1283=0;
l9_1283=sc_DirectionalLightsCount_tmp;
int l9_1284=l9_1283;
if (l9_1282<l9_1284)
{
int l9_1285=l9_1282;
float3 l9_1286=float3(0.0);
if (l9_1285<sc_DirectionalLightsCount_tmp)
{
l9_1286=(*sc_set2.UserUniforms).sc_DirectionalLights[l9_1285].color.xyz;
}
float3 l9_1287=l9_1286;
float3 l9_1288=l9_1287;
int l9_1289=l9_1282;
float l9_1290=0.0;
if (l9_1289<sc_DirectionalLightsCount_tmp)
{
l9_1290=(*sc_set2.UserUniforms).sc_DirectionalLights[l9_1289].color.w;
}
float l9_1291=l9_1290;
float l9_1292=l9_1291;
l9_1288*=l9_1292;
l9_1288*=3.1415901;
int l9_1293=l9_1282;
float3 l9_1294=float3(0.0);
if (l9_1293<sc_DirectionalLightsCount_tmp)
{
l9_1294=-(*sc_set2.UserUniforms).sc_DirectionalLights[l9_1293].direction;
}
float3 l9_1295=l9_1294;
float3 l9_1296=normalize(-l9_1295);
float3 l9_1297=normalize(l9_1296+l9_1275);
float3 l9_1298=l9_1274;
float3 l9_1299=l9_1297;
float l9_1300=fast::clamp(dot(l9_1298,l9_1299),0.0,1.0);
float l9_1301=l9_1300;
float3 l9_1302=l9_1274;
float3 l9_1303=l9_1296;
float l9_1304=fast::clamp(dot(l9_1302,l9_1303),0.0,1.0);
float l9_1305=l9_1304;
float l9_1306=l9_1277;
float l9_1307=l9_1301;
float l9_1308=1.0/l9_1306;
float l9_1309=l9_1307*l9_1307;
float l9_1310=1.0-l9_1309;
float l9_1311=l9_1308;
float l9_1312=l9_1310;
float l9_1313=l9_1308*0.5;
if (l9_1312<=0.0)
{
l9_1281=0.0;
}
else
{
l9_1281=pow(l9_1312,l9_1313);
}
float l9_1314=l9_1281;
float l9_1315=3.1415927;
float l9_1316=((2.0+l9_1311)*l9_1314)/(2.0*l9_1315);
float l9_1317=l9_1316;
float l9_1318=l9_1276;
float l9_1319=l9_1305;
float l9_1320=1.0/(4.0*((l9_1319+l9_1318)-(l9_1319*l9_1318)));
float l9_1321=l9_1320;
l9_1278+=((((l9_1288*l9_1273)*l9_1317)*l9_1321)*l9_1305);
l9_1282++;
continue;
}
else
{
break;
}
}
}
int l9_1322=0;
l9_1322=sc_PointLightsCount_tmp;
int l9_1323=l9_1322;
if (l9_1323>0)
{
float l9_1324;
int l9_1325=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
int l9_1326=0;
l9_1326=sc_PointLightsCount_tmp;
int l9_1327=l9_1326;
if (l9_1325<l9_1327)
{
int l9_1328=l9_1325;
float3 l9_1329=float3(0.0);
if (l9_1328<sc_PointLightsCount_tmp)
{
l9_1329=(*sc_set2.UserUniforms).sc_PointLights[l9_1328].color.xyz;
}
float3 l9_1330=l9_1329;
float3 l9_1331=l9_1330;
int l9_1332=l9_1325;
float l9_1333=0.0;
if (l9_1332<sc_PointLightsCount_tmp)
{
l9_1333=(*sc_set2.UserUniforms).sc_PointLights[l9_1332].color.w;
}
float l9_1334=l9_1333;
float l9_1335=l9_1334;
l9_1331*=l9_1335;
l9_1331*=3.1415901;
int l9_1336=l9_1325;
float3 l9_1337=float3(0.0);
if (l9_1336<sc_PointLightsCount_tmp)
{
l9_1337=(*sc_set2.UserUniforms).sc_PointLights[l9_1336].position;
}
float3 l9_1338=l9_1337;
float3 l9_1339=l9_1338;
float3 l9_1340=tempGlobals.SurfacePosition_WorldSpace;
float3 l9_1341=normalize(l9_1339-l9_1340);
float3 l9_1342=normalize(l9_1341+l9_1275);
float3 l9_1343=l9_1274;
float3 l9_1344=l9_1342;
float l9_1345=fast::clamp(dot(l9_1343,l9_1344),0.0,1.0);
float l9_1346=l9_1345;
float3 l9_1347=l9_1274;
float3 l9_1348=l9_1341;
float l9_1349=fast::clamp(dot(l9_1347,l9_1348),0.0,1.0);
float l9_1350=l9_1349;
float l9_1351=l9_1277;
float l9_1352=l9_1346;
float l9_1353=1.0/l9_1351;
float l9_1354=l9_1352*l9_1352;
float l9_1355=1.0-l9_1354;
float l9_1356=l9_1353;
float l9_1357=l9_1355;
float l9_1358=l9_1353*0.5;
if (l9_1357<=0.0)
{
l9_1324=0.0;
}
else
{
l9_1324=pow(l9_1357,l9_1358);
}
float l9_1359=l9_1324;
float l9_1360=3.1415927;
float l9_1361=((2.0+l9_1356)*l9_1359)/(2.0*l9_1360);
float l9_1362=l9_1361;
float l9_1363=l9_1276;
float l9_1364=l9_1350;
float l9_1365=1.0/(4.0*((l9_1364+l9_1363)-(l9_1364*l9_1363)));
float l9_1366=l9_1365;
l9_1278+=((((l9_1331*l9_1273)*l9_1362)*l9_1366)*l9_1350);
l9_1325++;
continue;
}
else
{
break;
}
}
}
int l9_1367=0;
l9_1367=sc_AmbientLightsCount_tmp;
int l9_1368=l9_1367;
if (l9_1368>0)
{
int l9_1369=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
int l9_1370=0;
l9_1370=sc_AmbientLightsCount_tmp;
int l9_1371=l9_1370;
if (l9_1369<l9_1371)
{
int l9_1372=l9_1369;
float3 l9_1373=float3(0.0);
if (l9_1372<sc_AmbientLightsCount_tmp)
{
l9_1373=(*sc_set2.UserUniforms).sc_AmbientLights[l9_1372].color;
}
float3 l9_1374=l9_1373;
float3 l9_1375=l9_1374;
int l9_1376=l9_1369;
float l9_1377=0.0;
if (l9_1376<sc_AmbientLightsCount_tmp)
{
l9_1377=(*sc_set2.UserUniforms).sc_AmbientLights[l9_1376].intensity;
}
float l9_1378=l9_1377;
float l9_1379=l9_1378;
l9_1375*=l9_1379;
l9_1375/=float3(3.1415901);
l9_1278+=(l9_1375*l9_1273);
l9_1369++;
continue;
}
else
{
break;
}
}
}
float3 l9_1380=l9_1278;
float3 l9_1381=N3_SheenOut.xyz+l9_1380;
N3_SheenOut=float4(l9_1381.x,l9_1381.y,l9_1381.z,N3_SheenOut.w);
float3 l9_1382=l9_885;
float3 l9_1383=l9_1382;
float l9_1384=fast::max(fast::max(l9_1383.x,l9_1383.y),l9_1383.z);
float l9_1385=1.0-(l9_1384*0.15700001);
N3_SheenOut.w=l9_1385;
}
if (N3_ClearcoatEnable)
{
N3_ClearcoatBase=1.0;
N3_ClearcoatRoughness=1.0;
N3_ClearcoatNormal=float3(0.0,0.0,1.0);
if (N3_EnableClearcoatTexture)
{
int l9_1386=N3_ClearcoatTextureCoord;
float2 l9_1387=tempGlobals.Surface_UVCoord0;
float2 l9_1388=l9_1387;
if (l9_1386==0)
{
float2 l9_1389=tempGlobals.Surface_UVCoord0;
l9_1388=l9_1389;
}
if (l9_1386==1)
{
float2 l9_1390=tempGlobals.Surface_UVCoord1;
l9_1388=l9_1390;
}
float2 l9_1391=l9_1388;
float2 l9_1392=l9_1391;
if (N3_EnableTextureTransform&&N3_ClearcoatTextureTransform)
{
float2 l9_1393=l9_1392;
float2 l9_1394=N3_ClearcoatTextureOffset;
float2 l9_1395=N3_ClearcoatTextureScale;
float l9_1396=N3_ClearcoatTextureRotation;
float l9_1397=radians(l9_1396);
float3x3 l9_1398=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_1394.x,l9_1394.y,1.0));
float3x3 l9_1399=float3x3(float3(cos(l9_1397),sin(l9_1397),0.0),float3(-sin(l9_1397),cos(l9_1397),0.0),float3(0.0,0.0,1.0));
float3x3 l9_1400=float3x3(float3(l9_1395.x,0.0,0.0),float3(0.0,l9_1395.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_1401=(l9_1398*l9_1399)*l9_1400;
float2 l9_1402=(l9_1401*float3(l9_1393,1.0)).xy;
l9_1392=l9_1402;
}
float2 l9_1403=l9_1392;
float4 l9_1404=float4(0.0);
int l9_1405=0;
if ((int(clearcoatTextureHasSwappedViews_tmp)!=0))
{
int l9_1406=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1406=0;
}
else
{
l9_1406=in.varStereoViewID;
}
int l9_1407=l9_1406;
l9_1405=1-l9_1407;
}
else
{
int l9_1408=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1408=0;
}
else
{
l9_1408=in.varStereoViewID;
}
int l9_1409=l9_1408;
l9_1405=l9_1409;
}
int l9_1410=l9_1405;
int l9_1411=clearcoatTextureLayout_tmp;
int l9_1412=l9_1410;
float2 l9_1413=l9_1403;
bool l9_1414=(int(SC_USE_UV_TRANSFORM_clearcoatTexture_tmp)!=0);
float3x3 l9_1415=(*sc_set2.UserUniforms).clearcoatTextureTransform;
int2 l9_1416=int2(SC_SOFTWARE_WRAP_MODE_U_clearcoatTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_clearcoatTexture_tmp);
bool l9_1417=(int(SC_USE_UV_MIN_MAX_clearcoatTexture_tmp)!=0);
float4 l9_1418=(*sc_set2.UserUniforms).clearcoatTextureUvMinMax;
bool l9_1419=(int(SC_USE_CLAMP_TO_BORDER_clearcoatTexture_tmp)!=0);
float4 l9_1420=(*sc_set2.UserUniforms).clearcoatTextureBorderColor;
float l9_1421=0.0;
bool l9_1422=l9_1419&&(!l9_1417);
float l9_1423=1.0;
float l9_1424=l9_1413.x;
int l9_1425=l9_1416.x;
if (l9_1425==1)
{
l9_1424=fract(l9_1424);
}
else
{
if (l9_1425==2)
{
float l9_1426=fract(l9_1424);
float l9_1427=l9_1424-l9_1426;
float l9_1428=step(0.25,fract(l9_1427*0.5));
l9_1424=mix(l9_1426,1.0-l9_1426,fast::clamp(l9_1428,0.0,1.0));
}
}
l9_1413.x=l9_1424;
float l9_1429=l9_1413.y;
int l9_1430=l9_1416.y;
if (l9_1430==1)
{
l9_1429=fract(l9_1429);
}
else
{
if (l9_1430==2)
{
float l9_1431=fract(l9_1429);
float l9_1432=l9_1429-l9_1431;
float l9_1433=step(0.25,fract(l9_1432*0.5));
l9_1429=mix(l9_1431,1.0-l9_1431,fast::clamp(l9_1433,0.0,1.0));
}
}
l9_1413.y=l9_1429;
if (l9_1417)
{
bool l9_1434=l9_1419;
bool l9_1435;
if (l9_1434)
{
l9_1435=l9_1416.x==3;
}
else
{
l9_1435=l9_1434;
}
float l9_1436=l9_1413.x;
float l9_1437=l9_1418.x;
float l9_1438=l9_1418.z;
bool l9_1439=l9_1435;
float l9_1440=l9_1423;
float l9_1441=fast::clamp(l9_1436,l9_1437,l9_1438);
float l9_1442=step(abs(l9_1436-l9_1441),9.9999997e-06);
l9_1440*=(l9_1442+((1.0-float(l9_1439))*(1.0-l9_1442)));
l9_1436=l9_1441;
l9_1413.x=l9_1436;
l9_1423=l9_1440;
bool l9_1443=l9_1419;
bool l9_1444;
if (l9_1443)
{
l9_1444=l9_1416.y==3;
}
else
{
l9_1444=l9_1443;
}
float l9_1445=l9_1413.y;
float l9_1446=l9_1418.y;
float l9_1447=l9_1418.w;
bool l9_1448=l9_1444;
float l9_1449=l9_1423;
float l9_1450=fast::clamp(l9_1445,l9_1446,l9_1447);
float l9_1451=step(abs(l9_1445-l9_1450),9.9999997e-06);
l9_1449*=(l9_1451+((1.0-float(l9_1448))*(1.0-l9_1451)));
l9_1445=l9_1450;
l9_1413.y=l9_1445;
l9_1423=l9_1449;
}
float2 l9_1452=l9_1413;
bool l9_1453=l9_1414;
float3x3 l9_1454=l9_1415;
if (l9_1453)
{
l9_1452=float2((l9_1454*float3(l9_1452,1.0)).xy);
}
float2 l9_1455=l9_1452;
float2 l9_1456=l9_1455;
float2 l9_1457=l9_1456;
l9_1413=l9_1457;
float l9_1458=l9_1413.x;
int l9_1459=l9_1416.x;
bool l9_1460=l9_1422;
float l9_1461=l9_1423;
if ((l9_1459==0)||(l9_1459==3))
{
float l9_1462=l9_1458;
float l9_1463=0.0;
float l9_1464=1.0;
bool l9_1465=l9_1460;
float l9_1466=l9_1461;
float l9_1467=fast::clamp(l9_1462,l9_1463,l9_1464);
float l9_1468=step(abs(l9_1462-l9_1467),9.9999997e-06);
l9_1466*=(l9_1468+((1.0-float(l9_1465))*(1.0-l9_1468)));
l9_1462=l9_1467;
l9_1458=l9_1462;
l9_1461=l9_1466;
}
l9_1413.x=l9_1458;
l9_1423=l9_1461;
float l9_1469=l9_1413.y;
int l9_1470=l9_1416.y;
bool l9_1471=l9_1422;
float l9_1472=l9_1423;
if ((l9_1470==0)||(l9_1470==3))
{
float l9_1473=l9_1469;
float l9_1474=0.0;
float l9_1475=1.0;
bool l9_1476=l9_1471;
float l9_1477=l9_1472;
float l9_1478=fast::clamp(l9_1473,l9_1474,l9_1475);
float l9_1479=step(abs(l9_1473-l9_1478),9.9999997e-06);
l9_1477*=(l9_1479+((1.0-float(l9_1476))*(1.0-l9_1479)));
l9_1473=l9_1478;
l9_1469=l9_1473;
l9_1472=l9_1477;
}
l9_1413.y=l9_1469;
l9_1423=l9_1472;
float2 l9_1480=l9_1413;
int l9_1481=l9_1411;
int l9_1482=l9_1412;
float l9_1483=l9_1421;
float2 l9_1484=l9_1480;
int l9_1485=l9_1481;
int l9_1486=l9_1482;
float3 l9_1487=float3(0.0);
if (l9_1485==0)
{
l9_1487=float3(l9_1484,0.0);
}
else
{
if (l9_1485==1)
{
l9_1487=float3(l9_1484.x,(l9_1484.y*0.5)+(0.5-(float(l9_1486)*0.5)),0.0);
}
else
{
l9_1487=float3(l9_1484,float(l9_1486));
}
}
float3 l9_1488=l9_1487;
float3 l9_1489=l9_1488;
float2 l9_1490=l9_1489.xy;
float l9_1491=l9_1483;
float4 l9_1492=sc_set2.clearcoatTexture.sample(sc_set2.clearcoatTextureSmpSC,l9_1490,bias(l9_1491));
float4 l9_1493=l9_1492;
float4 l9_1494=l9_1493;
if (l9_1419)
{
l9_1494=mix(l9_1420,l9_1494,float4(l9_1423));
}
float4 l9_1495=l9_1494;
l9_1404=l9_1495;
float4 l9_1496=l9_1404;
float l9_1497=l9_1496.x;
float l9_1498;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1498=pow(l9_1497,2.2);
}
else
{
l9_1498=l9_1497*l9_1497;
}
float l9_1499=l9_1498;
N3_ClearcoatBase=l9_1499;
}
N3_ClearcoatBase*=N3_ClearcoatFactor;
if (N3_EnableClearCoatRoughnessTexture)
{
int l9_1500=N3_ClearcoatRoughnessTextureCoord;
float2 l9_1501=tempGlobals.Surface_UVCoord0;
float2 l9_1502=l9_1501;
if (l9_1500==0)
{
float2 l9_1503=tempGlobals.Surface_UVCoord0;
l9_1502=l9_1503;
}
if (l9_1500==1)
{
float2 l9_1504=tempGlobals.Surface_UVCoord1;
l9_1502=l9_1504;
}
float2 l9_1505=l9_1502;
float2 l9_1506=l9_1505;
if (N3_EnableTextureTransform&&N3_ClearcoatRoughnessTextureTransform)
{
float2 l9_1507=l9_1506;
float2 l9_1508=N3_ClearcoatRoughnessTextureOffset;
float2 l9_1509=N3_ClearcoatRoughnessTextureScale;
float l9_1510=N3_ClearcoatRoughnessTextureRotation;
float l9_1511=radians(l9_1510);
float3x3 l9_1512=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_1508.x,l9_1508.y,1.0));
float3x3 l9_1513=float3x3(float3(cos(l9_1511),sin(l9_1511),0.0),float3(-sin(l9_1511),cos(l9_1511),0.0),float3(0.0,0.0,1.0));
float3x3 l9_1514=float3x3(float3(l9_1509.x,0.0,0.0),float3(0.0,l9_1509.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_1515=(l9_1512*l9_1513)*l9_1514;
float2 l9_1516=(l9_1515*float3(l9_1507,1.0)).xy;
l9_1506=l9_1516;
}
float2 l9_1517=l9_1506;
float4 l9_1518=float4(0.0);
int l9_1519=0;
if ((int(clearcoatRoughnessTextureHasSwappedViews_tmp)!=0))
{
int l9_1520=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1520=0;
}
else
{
l9_1520=in.varStereoViewID;
}
int l9_1521=l9_1520;
l9_1519=1-l9_1521;
}
else
{
int l9_1522=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1522=0;
}
else
{
l9_1522=in.varStereoViewID;
}
int l9_1523=l9_1522;
l9_1519=l9_1523;
}
int l9_1524=l9_1519;
int l9_1525=clearcoatRoughnessTextureLayout_tmp;
int l9_1526=l9_1524;
float2 l9_1527=l9_1517;
bool l9_1528=(int(SC_USE_UV_TRANSFORM_clearcoatRoughnessTexture_tmp)!=0);
float3x3 l9_1529=(*sc_set2.UserUniforms).clearcoatRoughnessTextureTransform;
int2 l9_1530=int2(SC_SOFTWARE_WRAP_MODE_U_clearcoatRoughnessTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_clearcoatRoughnessTexture_tmp);
bool l9_1531=(int(SC_USE_UV_MIN_MAX_clearcoatRoughnessTexture_tmp)!=0);
float4 l9_1532=(*sc_set2.UserUniforms).clearcoatRoughnessTextureUvMinMax;
bool l9_1533=(int(SC_USE_CLAMP_TO_BORDER_clearcoatRoughnessTexture_tmp)!=0);
float4 l9_1534=(*sc_set2.UserUniforms).clearcoatRoughnessTextureBorderColor;
float l9_1535=0.0;
bool l9_1536=l9_1533&&(!l9_1531);
float l9_1537=1.0;
float l9_1538=l9_1527.x;
int l9_1539=l9_1530.x;
if (l9_1539==1)
{
l9_1538=fract(l9_1538);
}
else
{
if (l9_1539==2)
{
float l9_1540=fract(l9_1538);
float l9_1541=l9_1538-l9_1540;
float l9_1542=step(0.25,fract(l9_1541*0.5));
l9_1538=mix(l9_1540,1.0-l9_1540,fast::clamp(l9_1542,0.0,1.0));
}
}
l9_1527.x=l9_1538;
float l9_1543=l9_1527.y;
int l9_1544=l9_1530.y;
if (l9_1544==1)
{
l9_1543=fract(l9_1543);
}
else
{
if (l9_1544==2)
{
float l9_1545=fract(l9_1543);
float l9_1546=l9_1543-l9_1545;
float l9_1547=step(0.25,fract(l9_1546*0.5));
l9_1543=mix(l9_1545,1.0-l9_1545,fast::clamp(l9_1547,0.0,1.0));
}
}
l9_1527.y=l9_1543;
if (l9_1531)
{
bool l9_1548=l9_1533;
bool l9_1549;
if (l9_1548)
{
l9_1549=l9_1530.x==3;
}
else
{
l9_1549=l9_1548;
}
float l9_1550=l9_1527.x;
float l9_1551=l9_1532.x;
float l9_1552=l9_1532.z;
bool l9_1553=l9_1549;
float l9_1554=l9_1537;
float l9_1555=fast::clamp(l9_1550,l9_1551,l9_1552);
float l9_1556=step(abs(l9_1550-l9_1555),9.9999997e-06);
l9_1554*=(l9_1556+((1.0-float(l9_1553))*(1.0-l9_1556)));
l9_1550=l9_1555;
l9_1527.x=l9_1550;
l9_1537=l9_1554;
bool l9_1557=l9_1533;
bool l9_1558;
if (l9_1557)
{
l9_1558=l9_1530.y==3;
}
else
{
l9_1558=l9_1557;
}
float l9_1559=l9_1527.y;
float l9_1560=l9_1532.y;
float l9_1561=l9_1532.w;
bool l9_1562=l9_1558;
float l9_1563=l9_1537;
float l9_1564=fast::clamp(l9_1559,l9_1560,l9_1561);
float l9_1565=step(abs(l9_1559-l9_1564),9.9999997e-06);
l9_1563*=(l9_1565+((1.0-float(l9_1562))*(1.0-l9_1565)));
l9_1559=l9_1564;
l9_1527.y=l9_1559;
l9_1537=l9_1563;
}
float2 l9_1566=l9_1527;
bool l9_1567=l9_1528;
float3x3 l9_1568=l9_1529;
if (l9_1567)
{
l9_1566=float2((l9_1568*float3(l9_1566,1.0)).xy);
}
float2 l9_1569=l9_1566;
float2 l9_1570=l9_1569;
float2 l9_1571=l9_1570;
l9_1527=l9_1571;
float l9_1572=l9_1527.x;
int l9_1573=l9_1530.x;
bool l9_1574=l9_1536;
float l9_1575=l9_1537;
if ((l9_1573==0)||(l9_1573==3))
{
float l9_1576=l9_1572;
float l9_1577=0.0;
float l9_1578=1.0;
bool l9_1579=l9_1574;
float l9_1580=l9_1575;
float l9_1581=fast::clamp(l9_1576,l9_1577,l9_1578);
float l9_1582=step(abs(l9_1576-l9_1581),9.9999997e-06);
l9_1580*=(l9_1582+((1.0-float(l9_1579))*(1.0-l9_1582)));
l9_1576=l9_1581;
l9_1572=l9_1576;
l9_1575=l9_1580;
}
l9_1527.x=l9_1572;
l9_1537=l9_1575;
float l9_1583=l9_1527.y;
int l9_1584=l9_1530.y;
bool l9_1585=l9_1536;
float l9_1586=l9_1537;
if ((l9_1584==0)||(l9_1584==3))
{
float l9_1587=l9_1583;
float l9_1588=0.0;
float l9_1589=1.0;
bool l9_1590=l9_1585;
float l9_1591=l9_1586;
float l9_1592=fast::clamp(l9_1587,l9_1588,l9_1589);
float l9_1593=step(abs(l9_1587-l9_1592),9.9999997e-06);
l9_1591*=(l9_1593+((1.0-float(l9_1590))*(1.0-l9_1593)));
l9_1587=l9_1592;
l9_1583=l9_1587;
l9_1586=l9_1591;
}
l9_1527.y=l9_1583;
l9_1537=l9_1586;
float2 l9_1594=l9_1527;
int l9_1595=l9_1525;
int l9_1596=l9_1526;
float l9_1597=l9_1535;
float2 l9_1598=l9_1594;
int l9_1599=l9_1595;
int l9_1600=l9_1596;
float3 l9_1601=float3(0.0);
if (l9_1599==0)
{
l9_1601=float3(l9_1598,0.0);
}
else
{
if (l9_1599==1)
{
l9_1601=float3(l9_1598.x,(l9_1598.y*0.5)+(0.5-(float(l9_1600)*0.5)),0.0);
}
else
{
l9_1601=float3(l9_1598,float(l9_1600));
}
}
float3 l9_1602=l9_1601;
float3 l9_1603=l9_1602;
float2 l9_1604=l9_1603.xy;
float l9_1605=l9_1597;
float4 l9_1606=sc_set2.clearcoatRoughnessTexture.sample(sc_set2.clearcoatRoughnessTextureSmpSC,l9_1604,bias(l9_1605));
float4 l9_1607=l9_1606;
float4 l9_1608=l9_1607;
if (l9_1533)
{
l9_1608=mix(l9_1534,l9_1608,float4(l9_1537));
}
float4 l9_1609=l9_1608;
l9_1518=l9_1609;
float4 l9_1610=l9_1518;
float l9_1611=l9_1610.y;
float l9_1612;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1612=pow(l9_1611,2.2);
}
else
{
l9_1612=l9_1611*l9_1611;
}
float l9_1613=l9_1612;
N3_ClearcoatRoughness=l9_1613;
}
N3_ClearcoatRoughness*=N3_ClearcoatRoughnessFactor;
if (N3_EnableClearCoatNormalTexture)
{
int l9_1614=N3_ClearcoatNormalMapCoord;
float2 l9_1615=tempGlobals.Surface_UVCoord0;
float2 l9_1616=l9_1615;
if (l9_1614==0)
{
float2 l9_1617=tempGlobals.Surface_UVCoord0;
l9_1616=l9_1617;
}
if (l9_1614==1)
{
float2 l9_1618=tempGlobals.Surface_UVCoord1;
l9_1616=l9_1618;
}
float2 l9_1619=l9_1616;
float2 l9_1620=l9_1619;
if (N3_EnableTextureTransform&&N3_ClearcoatNormalTextureTransform)
{
float2 l9_1621=l9_1620;
float2 l9_1622=N3_ClearcoatNormalTextureOffset;
float2 l9_1623=N3_ClearcoatNormalTextureScale;
float l9_1624=N3_ClearcoatNormalTextureRotation;
float l9_1625=radians(l9_1624);
float3x3 l9_1626=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_1622.x,l9_1622.y,1.0));
float3x3 l9_1627=float3x3(float3(cos(l9_1625),sin(l9_1625),0.0),float3(-sin(l9_1625),cos(l9_1625),0.0),float3(0.0,0.0,1.0));
float3x3 l9_1628=float3x3(float3(l9_1623.x,0.0,0.0),float3(0.0,l9_1623.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_1629=(l9_1626*l9_1627)*l9_1628;
float2 l9_1630=(l9_1629*float3(l9_1621,1.0)).xy;
l9_1620=l9_1630;
}
float2 l9_1631=l9_1620;
float4 l9_1632=float4(0.0);
int l9_1633=0;
if ((int(clearcoatNormalTextureHasSwappedViews_tmp)!=0))
{
int l9_1634=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1634=0;
}
else
{
l9_1634=in.varStereoViewID;
}
int l9_1635=l9_1634;
l9_1633=1-l9_1635;
}
else
{
int l9_1636=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1636=0;
}
else
{
l9_1636=in.varStereoViewID;
}
int l9_1637=l9_1636;
l9_1633=l9_1637;
}
int l9_1638=l9_1633;
int l9_1639=clearcoatNormalTextureLayout_tmp;
int l9_1640=l9_1638;
float2 l9_1641=l9_1631;
bool l9_1642=(int(SC_USE_UV_TRANSFORM_clearcoatNormalTexture_tmp)!=0);
float3x3 l9_1643=(*sc_set2.UserUniforms).clearcoatNormalTextureTransform;
int2 l9_1644=int2(SC_SOFTWARE_WRAP_MODE_U_clearcoatNormalTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_clearcoatNormalTexture_tmp);
bool l9_1645=(int(SC_USE_UV_MIN_MAX_clearcoatNormalTexture_tmp)!=0);
float4 l9_1646=(*sc_set2.UserUniforms).clearcoatNormalTextureUvMinMax;
bool l9_1647=(int(SC_USE_CLAMP_TO_BORDER_clearcoatNormalTexture_tmp)!=0);
float4 l9_1648=(*sc_set2.UserUniforms).clearcoatNormalTextureBorderColor;
float l9_1649=0.0;
bool l9_1650=l9_1647&&(!l9_1645);
float l9_1651=1.0;
float l9_1652=l9_1641.x;
int l9_1653=l9_1644.x;
if (l9_1653==1)
{
l9_1652=fract(l9_1652);
}
else
{
if (l9_1653==2)
{
float l9_1654=fract(l9_1652);
float l9_1655=l9_1652-l9_1654;
float l9_1656=step(0.25,fract(l9_1655*0.5));
l9_1652=mix(l9_1654,1.0-l9_1654,fast::clamp(l9_1656,0.0,1.0));
}
}
l9_1641.x=l9_1652;
float l9_1657=l9_1641.y;
int l9_1658=l9_1644.y;
if (l9_1658==1)
{
l9_1657=fract(l9_1657);
}
else
{
if (l9_1658==2)
{
float l9_1659=fract(l9_1657);
float l9_1660=l9_1657-l9_1659;
float l9_1661=step(0.25,fract(l9_1660*0.5));
l9_1657=mix(l9_1659,1.0-l9_1659,fast::clamp(l9_1661,0.0,1.0));
}
}
l9_1641.y=l9_1657;
if (l9_1645)
{
bool l9_1662=l9_1647;
bool l9_1663;
if (l9_1662)
{
l9_1663=l9_1644.x==3;
}
else
{
l9_1663=l9_1662;
}
float l9_1664=l9_1641.x;
float l9_1665=l9_1646.x;
float l9_1666=l9_1646.z;
bool l9_1667=l9_1663;
float l9_1668=l9_1651;
float l9_1669=fast::clamp(l9_1664,l9_1665,l9_1666);
float l9_1670=step(abs(l9_1664-l9_1669),9.9999997e-06);
l9_1668*=(l9_1670+((1.0-float(l9_1667))*(1.0-l9_1670)));
l9_1664=l9_1669;
l9_1641.x=l9_1664;
l9_1651=l9_1668;
bool l9_1671=l9_1647;
bool l9_1672;
if (l9_1671)
{
l9_1672=l9_1644.y==3;
}
else
{
l9_1672=l9_1671;
}
float l9_1673=l9_1641.y;
float l9_1674=l9_1646.y;
float l9_1675=l9_1646.w;
bool l9_1676=l9_1672;
float l9_1677=l9_1651;
float l9_1678=fast::clamp(l9_1673,l9_1674,l9_1675);
float l9_1679=step(abs(l9_1673-l9_1678),9.9999997e-06);
l9_1677*=(l9_1679+((1.0-float(l9_1676))*(1.0-l9_1679)));
l9_1673=l9_1678;
l9_1641.y=l9_1673;
l9_1651=l9_1677;
}
float2 l9_1680=l9_1641;
bool l9_1681=l9_1642;
float3x3 l9_1682=l9_1643;
if (l9_1681)
{
l9_1680=float2((l9_1682*float3(l9_1680,1.0)).xy);
}
float2 l9_1683=l9_1680;
float2 l9_1684=l9_1683;
float2 l9_1685=l9_1684;
l9_1641=l9_1685;
float l9_1686=l9_1641.x;
int l9_1687=l9_1644.x;
bool l9_1688=l9_1650;
float l9_1689=l9_1651;
if ((l9_1687==0)||(l9_1687==3))
{
float l9_1690=l9_1686;
float l9_1691=0.0;
float l9_1692=1.0;
bool l9_1693=l9_1688;
float l9_1694=l9_1689;
float l9_1695=fast::clamp(l9_1690,l9_1691,l9_1692);
float l9_1696=step(abs(l9_1690-l9_1695),9.9999997e-06);
l9_1694*=(l9_1696+((1.0-float(l9_1693))*(1.0-l9_1696)));
l9_1690=l9_1695;
l9_1686=l9_1690;
l9_1689=l9_1694;
}
l9_1641.x=l9_1686;
l9_1651=l9_1689;
float l9_1697=l9_1641.y;
int l9_1698=l9_1644.y;
bool l9_1699=l9_1650;
float l9_1700=l9_1651;
if ((l9_1698==0)||(l9_1698==3))
{
float l9_1701=l9_1697;
float l9_1702=0.0;
float l9_1703=1.0;
bool l9_1704=l9_1699;
float l9_1705=l9_1700;
float l9_1706=fast::clamp(l9_1701,l9_1702,l9_1703);
float l9_1707=step(abs(l9_1701-l9_1706),9.9999997e-06);
l9_1705*=(l9_1707+((1.0-float(l9_1704))*(1.0-l9_1707)));
l9_1701=l9_1706;
l9_1697=l9_1701;
l9_1700=l9_1705;
}
l9_1641.y=l9_1697;
l9_1651=l9_1700;
float2 l9_1708=l9_1641;
int l9_1709=l9_1639;
int l9_1710=l9_1640;
float l9_1711=l9_1649;
float2 l9_1712=l9_1708;
int l9_1713=l9_1709;
int l9_1714=l9_1710;
float3 l9_1715=float3(0.0);
if (l9_1713==0)
{
l9_1715=float3(l9_1712,0.0);
}
else
{
if (l9_1713==1)
{
l9_1715=float3(l9_1712.x,(l9_1712.y*0.5)+(0.5-(float(l9_1714)*0.5)),0.0);
}
else
{
l9_1715=float3(l9_1712,float(l9_1714));
}
}
float3 l9_1716=l9_1715;
float3 l9_1717=l9_1716;
float2 l9_1718=l9_1717.xy;
float l9_1719=l9_1711;
float4 l9_1720=sc_set2.clearcoatNormalTexture.sample(sc_set2.clearcoatNormalTextureSmpSC,l9_1718,bias(l9_1719));
float4 l9_1721=l9_1720;
float4 l9_1722=l9_1721;
if (l9_1647)
{
l9_1722=mix(l9_1648,l9_1722,float4(l9_1651));
}
float4 l9_1723=l9_1722;
l9_1632=l9_1723;
float4 l9_1724=l9_1632;
N3_ClearcoatNormal=l9_1724.xyz;
N3_ClearcoatNormal*=0.9921875;
}
}
l9_293=N3_BaseColor;
l9_294=N3_Opacity;
l9_295=N3_Normal;
l9_296=N3_Emissive;
l9_297=N3_Metallic;
l9_298=N3_Roughness;
l9_299=N3_Occlusion;
l9_300=N3_Background;
l9_301=N3_SheenOut;
l9_302=N3_ClearcoatBase;
l9_303=N3_ClearcoatNormal;
l9_304=N3_ClearcoatRoughness;
l9_241=l9_293;
l9_242=l9_294;
l9_243=l9_295;
l9_244=l9_296;
l9_245=l9_297;
l9_246=l9_298;
l9_247=l9_299;
l9_248=l9_300;
l9_249=l9_301;
l9_250=l9_302;
l9_251=l9_303;
l9_252=l9_304;
float4 l9_1725=float4(0.0);
float3 l9_1726=l9_241;
float l9_1727=l9_242;
float3 l9_1728=l9_243;
float3 l9_1729=l9_244;
float l9_1730=l9_245;
float l9_1731=l9_246;
float3 l9_1732=l9_247.xyz;
float3 l9_1733=(*sc_set2.UserUniforms).Port_SpecularAO_N036;
ssGlobals l9_1734=param_3;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1734.BumpedNormal=l9_1728;
}
l9_1727=fast::clamp(l9_1727,0.0,1.0);
float l9_1735=l9_1727;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_1735<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_1736=gl_FragCoord;
float2 l9_1737=floor(mod(l9_1736.xy,float2(4.0)));
float l9_1738=(mod(dot(l9_1737,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_1735<l9_1738)
{
discard_fragment();
}
}
l9_1726=fast::max(l9_1726,float3(0.0));
float4 l9_1739;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1739=float4(l9_1726,l9_1727);
}
else
{
l9_1729=fast::max(l9_1729,float3(0.0));
l9_1730=fast::clamp(l9_1730,0.0,1.0);
l9_1731=fast::clamp(l9_1731,0.0,1.0);
l9_1732=fast::clamp(l9_1732,float3(0.0),float3(1.0));
float3 l9_1740=l9_1726;
float l9_1741=l9_1727;
float3 l9_1742=l9_1734.BumpedNormal;
float3 l9_1743=l9_1734.PositionWS;
float3 l9_1744=l9_1734.ViewDirWS;
float3 l9_1745=l9_1729;
float l9_1746=l9_1730;
float l9_1747=l9_1731;
float3 l9_1748=l9_1732;
float3 l9_1749=l9_1733;
l9_1739=ngsCalculateLighting(l9_1740,l9_1741,l9_1742,l9_1743,l9_1744,l9_1745,l9_1746,l9_1747,l9_1748,l9_1749,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_EnvmapDiffuse,sc_set2.sc_EnvmapDiffuseSmpSC,sc_set2.sc_EnvmapSpecular,sc_set2.sc_EnvmapSpecularSmpSC,sc_set2.sc_ScreenTexture,sc_set2.sc_ScreenTextureSmpSC,sc_set2.sc_ShadowTexture,sc_set2.sc_ShadowTextureSmpSC,sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC,sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,sc_set2.sc_RayTracedShadowTexture,sc_set2.sc_RayTracedShadowTextureSmpSC,sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord,in.varShadowTex,out.FragColor0);
}
l9_1739=fast::max(l9_1739,float4(0.0));
l9_1725=l9_1739;
float4 l9_1750=float4(0.0);
float3 l9_1751=(*sc_set2.UserUniforms).Port_Albedo_N405;
float l9_1752=(*sc_set2.UserUniforms).Port_Opacity_N405;
float3 l9_1753=l9_251;
float3 l9_1754=(*sc_set2.UserUniforms).Port_Emissive_N405;
float l9_1755=(*sc_set2.UserUniforms).Port_Metallic_N405;
float l9_1756=l9_252;
float3 l9_1757=(*sc_set2.UserUniforms).Port_SpecularAO_N405;
ssGlobals l9_1758=param_3;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1758.BumpedNormal=float3x3(float3(l9_1758.VertexTangent_WorldSpace),float3(l9_1758.VertexBinormal_WorldSpace),float3(l9_1758.VertexNormal_WorldSpace))*l9_1753;
}
float l9_1759=l9_1752;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_1759<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_1760=gl_FragCoord;
float2 l9_1761=floor(mod(l9_1760.xy,float2(4.0)));
float l9_1762=(mod(dot(l9_1761,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_1759<l9_1762)
{
discard_fragment();
}
}
float4 l9_1763;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1763=float4(l9_1751,l9_1752);
}
else
{
l9_1756=fast::clamp(l9_1756,0.0,1.0);
float3 l9_1764=float3(1.0);
float3 l9_1765=l9_1751;
float l9_1766=l9_1752;
float3 l9_1767=l9_1758.BumpedNormal;
float3 l9_1768=l9_1758.PositionWS;
float3 l9_1769=l9_1758.ViewDirWS;
float3 l9_1770=l9_1754;
float l9_1771=l9_1755;
float l9_1772=l9_1756;
float3 l9_1773=l9_1764;
float3 l9_1774=l9_1757;
l9_1763=ngsCalculateLighting(l9_1765,l9_1766,l9_1767,l9_1768,l9_1769,l9_1770,l9_1771,l9_1772,l9_1773,l9_1774,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_EnvmapDiffuse,sc_set2.sc_EnvmapDiffuseSmpSC,sc_set2.sc_EnvmapSpecular,sc_set2.sc_EnvmapSpecularSmpSC,sc_set2.sc_ScreenTexture,sc_set2.sc_ScreenTextureSmpSC,sc_set2.sc_ShadowTexture,sc_set2.sc_ShadowTextureSmpSC,sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC,sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,sc_set2.sc_RayTracedShadowTexture,sc_set2.sc_RayTracedShadowTextureSmpSC,sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord,in.varShadowTex,out.FragColor0);
}
l9_1763=fast::max(l9_1763,float4(0.0));
l9_1750=l9_1763;
float4 l9_1775=float4(0.0);
float4 l9_1776=l9_1725;
float l9_1777=l9_242;
float3 l9_1778=l9_248;
float4 l9_1779=l9_249;
float l9_1780=l9_250;
float4 l9_1781=l9_1750;
ssGlobals l9_1782=param_3;
tempGlobals=l9_1782;
float4 l9_1783=float4(0.0);
N31_PbrIn=l9_1776;
N31_EnableTransmission=(int(ENABLE_TRANSMISSION_tmp)!=0);
N31_Opacity=l9_1777;
N31_Background=l9_1778;
N31_EnableSheen=(int(ENABLE_SHEEN_tmp)!=0);
N31_SheenColor=l9_1779;
N31_EnableClearcoat=(int(ENABLE_CLEARCOAT_tmp)!=0);
N31_ClearcoatBase=l9_1780;
N31_ClearcoatColor=l9_1781;
N31_Result=N31_PbrIn;
if ((N31_EnableSheen||N31_EnableTransmission)||N31_EnableClearcoat)
{
float4 l9_1784=N31_Result;
float4 l9_1785;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1785=float4(pow(l9_1784.x,2.2),pow(l9_1784.y,2.2),pow(l9_1784.z,2.2),pow(l9_1784.w,2.2));
}
else
{
l9_1785=l9_1784*l9_1784;
}
float4 l9_1786=l9_1785;
N31_Result=l9_1786;
if (N31_EnableSheen)
{
float l9_1787=N31_SheenColor.w;
float3 l9_1788=(N31_Result.xyz*l9_1787)+N31_SheenColor.xyz;
N31_Result=float4(l9_1788.x,l9_1788.y,l9_1788.z,N31_Result.w);
}
if (N31_EnableTransmission)
{
float4 l9_1789=N31_Result;
float l9_1790=N31_Opacity;
float l9_1791;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1791=pow(l9_1790,2.2);
}
else
{
l9_1791=l9_1790*l9_1790;
}
float l9_1792=l9_1791;
N31_Result=mix(float4(N31_Background,1.0),l9_1789,float4(l9_1792));
N31_Result.w=1.0;
}
if (N31_EnableClearcoat)
{
float l9_1793=N31_ClearcoatBase;
float4 l9_1794=N31_ClearcoatColor;
float4 l9_1795;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1795=float4(pow(l9_1794.x,2.2),pow(l9_1794.y,2.2),pow(l9_1794.z,2.2),pow(l9_1794.w,2.2));
}
else
{
l9_1795=l9_1794*l9_1794;
}
float4 l9_1796=l9_1795;
float4 l9_1797=l9_1796*l9_1793;
float3 l9_1798=N31_Result.xyz+l9_1797.xyz;
N31_Result=float4(l9_1798.x,l9_1798.y,l9_1798.z,N31_Result.w);
}
float4 l9_1799=N31_Result;
float4 l9_1800;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1800=float4(pow(l9_1799.x,0.45454544),pow(l9_1799.y,0.45454544),pow(l9_1799.z,0.45454544),pow(l9_1799.w,0.45454544));
}
else
{
l9_1800=sqrt(l9_1799);
}
float4 l9_1801=l9_1800;
N31_Result=l9_1801;
}
l9_1783=N31_Result;
l9_1775=l9_1783;
param=l9_1775;
param_2=param;
}
else
{
float4 l9_1802=float4(0.0);
float4 l9_1803=(*sc_set2.UserUniforms).baseColorFactor;
l9_1802=l9_1803;
float2 l9_1804=float2(0.0);
float2 l9_1805=(*sc_set2.UserUniforms).baseColorTexture_offset;
l9_1804=l9_1805;
float2 l9_1806=float2(0.0);
float2 l9_1807=(*sc_set2.UserUniforms).baseColorTexture_scale;
l9_1806=l9_1807;
float l9_1808=0.0;
float l9_1809=(*sc_set2.UserUniforms).baseColorTexture_rotation;
l9_1808=l9_1809;
float4 l9_1810=float4(0.0);
float4 l9_1811=l9_1802;
float2 l9_1812=l9_1804;
float2 l9_1813=l9_1806;
float l9_1814=l9_1808;
ssGlobals l9_1815=param_3;
tempGlobals=l9_1815;
float4 l9_1816=float4(0.0);
N35_EnableVertexColor=(int(ENABLE_VERTEX_COLOR_BASE_tmp)!=0);
N35_EnableBaseTexture=(int(ENABLE_BASE_TEX_tmp)!=0);
N35_BaseColorTextureCoord=NODE_7_DROPLIST_ITEM_tmp;
N35_BaseColorFactor=l9_1811;
N35_EnableTextureTransform=(int(ENABLE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureTransform=(int(ENABLE_BASE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureOffset=l9_1812;
N35_BaseTextureScale=l9_1813;
N35_BaseTextureRotation=l9_1814;
float4 l9_1817=N35_BaseColorFactor;
if (N35_EnableBaseTexture)
{
int l9_1818=N35_BaseColorTextureCoord;
float2 l9_1819=tempGlobals.Surface_UVCoord0;
float2 l9_1820=l9_1819;
if (l9_1818==0)
{
float2 l9_1821=tempGlobals.Surface_UVCoord0;
l9_1820=l9_1821;
}
if (l9_1818==1)
{
float2 l9_1822=tempGlobals.Surface_UVCoord1;
l9_1820=l9_1822;
}
float2 l9_1823=l9_1820;
float2 l9_1824=l9_1823;
if (N35_EnableTextureTransform&&N35_BaseTextureTransform)
{
float2 l9_1825=l9_1824;
float2 l9_1826=N35_BaseTextureOffset;
float2 l9_1827=N35_BaseTextureScale;
float l9_1828=N35_BaseTextureRotation;
float3x3 l9_1829=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_1826.x,l9_1826.y,1.0));
float3x3 l9_1830=float3x3(float3(cos(l9_1828),sin(l9_1828),0.0),float3(-sin(l9_1828),cos(l9_1828),0.0),float3(0.0,0.0,1.0));
float3x3 l9_1831=float3x3(float3(l9_1827.x,0.0,0.0),float3(0.0,l9_1827.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_1832=(l9_1829*l9_1830)*l9_1831;
float2 l9_1833=(l9_1832*float3(l9_1825,1.0)).xy;
l9_1824=l9_1833;
}
float2 l9_1834=l9_1824;
float4 l9_1835=float4(0.0);
int l9_1836=0;
if ((int(baseColorTextureHasSwappedViews_tmp)!=0))
{
int l9_1837=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1837=0;
}
else
{
l9_1837=in.varStereoViewID;
}
int l9_1838=l9_1837;
l9_1836=1-l9_1838;
}
else
{
int l9_1839=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1839=0;
}
else
{
l9_1839=in.varStereoViewID;
}
int l9_1840=l9_1839;
l9_1836=l9_1840;
}
int l9_1841=l9_1836;
int l9_1842=baseColorTextureLayout_tmp;
int l9_1843=l9_1841;
float2 l9_1844=l9_1834;
bool l9_1845=(int(SC_USE_UV_TRANSFORM_baseColorTexture_tmp)!=0);
float3x3 l9_1846=(*sc_set2.UserUniforms).baseColorTextureTransform;
int2 l9_1847=int2(SC_SOFTWARE_WRAP_MODE_U_baseColorTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_baseColorTexture_tmp);
bool l9_1848=(int(SC_USE_UV_MIN_MAX_baseColorTexture_tmp)!=0);
float4 l9_1849=(*sc_set2.UserUniforms).baseColorTextureUvMinMax;
bool l9_1850=(int(SC_USE_CLAMP_TO_BORDER_baseColorTexture_tmp)!=0);
float4 l9_1851=(*sc_set2.UserUniforms).baseColorTextureBorderColor;
float l9_1852=0.0;
bool l9_1853=l9_1850&&(!l9_1848);
float l9_1854=1.0;
float l9_1855=l9_1844.x;
int l9_1856=l9_1847.x;
if (l9_1856==1)
{
l9_1855=fract(l9_1855);
}
else
{
if (l9_1856==2)
{
float l9_1857=fract(l9_1855);
float l9_1858=l9_1855-l9_1857;
float l9_1859=step(0.25,fract(l9_1858*0.5));
l9_1855=mix(l9_1857,1.0-l9_1857,fast::clamp(l9_1859,0.0,1.0));
}
}
l9_1844.x=l9_1855;
float l9_1860=l9_1844.y;
int l9_1861=l9_1847.y;
if (l9_1861==1)
{
l9_1860=fract(l9_1860);
}
else
{
if (l9_1861==2)
{
float l9_1862=fract(l9_1860);
float l9_1863=l9_1860-l9_1862;
float l9_1864=step(0.25,fract(l9_1863*0.5));
l9_1860=mix(l9_1862,1.0-l9_1862,fast::clamp(l9_1864,0.0,1.0));
}
}
l9_1844.y=l9_1860;
if (l9_1848)
{
bool l9_1865=l9_1850;
bool l9_1866;
if (l9_1865)
{
l9_1866=l9_1847.x==3;
}
else
{
l9_1866=l9_1865;
}
float l9_1867=l9_1844.x;
float l9_1868=l9_1849.x;
float l9_1869=l9_1849.z;
bool l9_1870=l9_1866;
float l9_1871=l9_1854;
float l9_1872=fast::clamp(l9_1867,l9_1868,l9_1869);
float l9_1873=step(abs(l9_1867-l9_1872),9.9999997e-06);
l9_1871*=(l9_1873+((1.0-float(l9_1870))*(1.0-l9_1873)));
l9_1867=l9_1872;
l9_1844.x=l9_1867;
l9_1854=l9_1871;
bool l9_1874=l9_1850;
bool l9_1875;
if (l9_1874)
{
l9_1875=l9_1847.y==3;
}
else
{
l9_1875=l9_1874;
}
float l9_1876=l9_1844.y;
float l9_1877=l9_1849.y;
float l9_1878=l9_1849.w;
bool l9_1879=l9_1875;
float l9_1880=l9_1854;
float l9_1881=fast::clamp(l9_1876,l9_1877,l9_1878);
float l9_1882=step(abs(l9_1876-l9_1881),9.9999997e-06);
l9_1880*=(l9_1882+((1.0-float(l9_1879))*(1.0-l9_1882)));
l9_1876=l9_1881;
l9_1844.y=l9_1876;
l9_1854=l9_1880;
}
float2 l9_1883=l9_1844;
bool l9_1884=l9_1845;
float3x3 l9_1885=l9_1846;
if (l9_1884)
{
l9_1883=float2((l9_1885*float3(l9_1883,1.0)).xy);
}
float2 l9_1886=l9_1883;
float2 l9_1887=l9_1886;
float2 l9_1888=l9_1887;
l9_1844=l9_1888;
float l9_1889=l9_1844.x;
int l9_1890=l9_1847.x;
bool l9_1891=l9_1853;
float l9_1892=l9_1854;
if ((l9_1890==0)||(l9_1890==3))
{
float l9_1893=l9_1889;
float l9_1894=0.0;
float l9_1895=1.0;
bool l9_1896=l9_1891;
float l9_1897=l9_1892;
float l9_1898=fast::clamp(l9_1893,l9_1894,l9_1895);
float l9_1899=step(abs(l9_1893-l9_1898),9.9999997e-06);
l9_1897*=(l9_1899+((1.0-float(l9_1896))*(1.0-l9_1899)));
l9_1893=l9_1898;
l9_1889=l9_1893;
l9_1892=l9_1897;
}
l9_1844.x=l9_1889;
l9_1854=l9_1892;
float l9_1900=l9_1844.y;
int l9_1901=l9_1847.y;
bool l9_1902=l9_1853;
float l9_1903=l9_1854;
if ((l9_1901==0)||(l9_1901==3))
{
float l9_1904=l9_1900;
float l9_1905=0.0;
float l9_1906=1.0;
bool l9_1907=l9_1902;
float l9_1908=l9_1903;
float l9_1909=fast::clamp(l9_1904,l9_1905,l9_1906);
float l9_1910=step(abs(l9_1904-l9_1909),9.9999997e-06);
l9_1908*=(l9_1910+((1.0-float(l9_1907))*(1.0-l9_1910)));
l9_1904=l9_1909;
l9_1900=l9_1904;
l9_1903=l9_1908;
}
l9_1844.y=l9_1900;
l9_1854=l9_1903;
float2 l9_1911=l9_1844;
int l9_1912=l9_1842;
int l9_1913=l9_1843;
float l9_1914=l9_1852;
float2 l9_1915=l9_1911;
int l9_1916=l9_1912;
int l9_1917=l9_1913;
float3 l9_1918=float3(0.0);
if (l9_1916==0)
{
l9_1918=float3(l9_1915,0.0);
}
else
{
if (l9_1916==1)
{
l9_1918=float3(l9_1915.x,(l9_1915.y*0.5)+(0.5-(float(l9_1917)*0.5)),0.0);
}
else
{
l9_1918=float3(l9_1915,float(l9_1917));
}
}
float3 l9_1919=l9_1918;
float3 l9_1920=l9_1919;
float2 l9_1921=l9_1920.xy;
float l9_1922=l9_1914;
float4 l9_1923=sc_set2.baseColorTexture.sample(sc_set2.baseColorTextureSmpSC,l9_1921,bias(l9_1922));
float4 l9_1924=l9_1923;
float4 l9_1925=l9_1924;
if (l9_1850)
{
l9_1925=mix(l9_1851,l9_1925,float4(l9_1854));
}
float4 l9_1926=l9_1925;
l9_1835=l9_1926;
float4 l9_1927=l9_1835;
float4 l9_1928=l9_1927;
float4 l9_1929;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1929=float4(pow(l9_1928.x,2.2),pow(l9_1928.y,2.2),pow(l9_1928.z,2.2),pow(l9_1928.w,2.2));
}
else
{
l9_1929=l9_1928*l9_1928;
}
float4 l9_1930=l9_1929;
l9_1817*=l9_1930;
}
if (N35_EnableVertexColor)
{
float4 l9_1931=tempGlobals.VertexColor;
l9_1817*=l9_1931;
}
N35_BaseColor=l9_1817.xyz;
N35_Opacity=l9_1817.w;
float4 l9_1932=l9_1817;
float4 l9_1933;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1933=float4(pow(l9_1932.x,0.45454544),pow(l9_1932.y,0.45454544),pow(l9_1932.z,0.45454544),pow(l9_1932.w,0.45454544));
}
else
{
l9_1933=sqrt(l9_1932);
}
float4 l9_1934=l9_1933;
N35_UnlitColor=l9_1934;
l9_1816=N35_UnlitColor;
l9_1810=l9_1816;
param_1=l9_1810;
param_2=param_1;
}
Output_N17=param_2;
FinalColor=Output_N17;
bool l9_1935=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_1935)
{
float4 param_4=FinalColor;
if ((int(sc_ProxyAlphaOne_tmp)!=0))
{
param_4.w=1.0;
}
float4 l9_1936=fast::max(param_4,float4(0.0));
float4 param_5=l9_1936;
out.FragColor0=param_5;
return out;
}
float4 param_6=FinalColor;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_1937=param_6;
float4 l9_1938=l9_1937;
float l9_1939=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_1939=l9_1938.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_1939=fast::clamp(l9_1938.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_1939=fast::clamp(dot(l9_1938.xyz,float3(l9_1938.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_1939=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_1939=(1.0-dot(l9_1938.xyz,float3(0.33333001)))*l9_1938.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_1939=(1.0-fast::clamp(dot(l9_1938.xyz,float3(1.0)),0.0,1.0))*l9_1938.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_1939=fast::clamp(dot(l9_1938.xyz,float3(1.0)),0.0,1.0)*l9_1938.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_1939=fast::clamp(dot(l9_1938.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_1939=fast::clamp(dot(l9_1938.xyz,float3(1.0)),0.0,1.0)*l9_1938.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_1939=dot(l9_1938.xyz,float3(0.33333001))*l9_1938.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_1939=1.0-fast::clamp(dot(l9_1938.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_1939=fast::clamp(dot(l9_1938.xyz,float3(1.0)),0.0,1.0);
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
float l9_1940=l9_1939;
float l9_1941=l9_1940;
float l9_1942=(*sc_set2.UserUniforms).sc_ShadowDensity*l9_1941;
float3 l9_1943=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_1937.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float4 l9_1944=float4(l9_1943.x,l9_1943.y,l9_1943.z,l9_1942);
param_6=l9_1944;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_6=float4(param_6.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_1945=param_6;
float4 l9_1946=float4(0.0);
float4 l9_1947=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_1948=out.FragColor0;
float4 l9_1949=l9_1948;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_1949.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_1950=l9_1949;
l9_1947=l9_1950;
}
else
{
float4 l9_1951=gl_FragCoord;
float2 l9_1952=(l9_1951.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_1953=l9_1952;
float2 l9_1954=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_1955=1;
int l9_1956=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1956=0;
}
else
{
l9_1956=in.varStereoViewID;
}
int l9_1957=l9_1956;
int l9_1958=l9_1957;
float3 l9_1959=float3(l9_1953,0.0);
int l9_1960=l9_1955;
int l9_1961=l9_1958;
if (l9_1960==1)
{
l9_1959.y=((2.0*l9_1959.y)+float(l9_1961))-1.0;
}
float2 l9_1962=l9_1959.xy;
l9_1954=l9_1962;
}
else
{
l9_1954=l9_1953;
}
float2 l9_1963=l9_1954;
float2 l9_1964=l9_1963;
float2 l9_1965=l9_1964;
int l9_1966=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_1967=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1967=0;
}
else
{
l9_1967=in.varStereoViewID;
}
int l9_1968=l9_1967;
l9_1966=1-l9_1968;
}
else
{
int l9_1969=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1969=0;
}
else
{
l9_1969=in.varStereoViewID;
}
int l9_1970=l9_1969;
l9_1966=l9_1970;
}
int l9_1971=l9_1966;
float2 l9_1972=l9_1965;
int l9_1973=l9_1971;
float2 l9_1974=l9_1972;
int l9_1975=l9_1973;
float l9_1976=0.0;
float4 l9_1977=float4(0.0);
float2 l9_1978=l9_1974;
int l9_1979=sc_ScreenTextureLayout_tmp;
int l9_1980=l9_1975;
float l9_1981=l9_1976;
float2 l9_1982=l9_1978;
int l9_1983=l9_1979;
int l9_1984=l9_1980;
float3 l9_1985=float3(0.0);
if (l9_1983==0)
{
l9_1985=float3(l9_1982,0.0);
}
else
{
if (l9_1983==1)
{
l9_1985=float3(l9_1982.x,(l9_1982.y*0.5)+(0.5-(float(l9_1984)*0.5)),0.0);
}
else
{
l9_1985=float3(l9_1982,float(l9_1984));
}
}
float3 l9_1986=l9_1985;
float3 l9_1987=l9_1986;
float2 l9_1988=l9_1987.xy;
float l9_1989=l9_1981;
float4 l9_1990=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_1988,bias(l9_1989));
float4 l9_1991=l9_1990;
l9_1977=l9_1991;
float4 l9_1992=l9_1977;
float4 l9_1993=l9_1992;
float4 l9_1994=l9_1993;
l9_1947=l9_1994;
}
float4 l9_1995=l9_1947;
float4 l9_1996=l9_1995;
float3 l9_1997=l9_1996.xyz;
float3 l9_1998=l9_1997;
float3 l9_1999=l9_1945.xyz;
float3 l9_2000=definedBlend(l9_1998,l9_1999,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.intensityTexture,sc_set2.intensityTextureSmpSC);
l9_1946=float4(l9_2000.x,l9_2000.y,l9_2000.z,l9_1946.w);
float3 l9_2001=mix(l9_1997,l9_1946.xyz,float3(l9_1945.w));
l9_1946=float4(l9_2001.x,l9_2001.y,l9_2001.z,l9_1946.w);
l9_1946.w=1.0;
float4 l9_2002=l9_1946;
param_6=l9_2002;
}
else
{
float4 l9_2003=param_6;
float4 l9_2004=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_2004=float4(mix(float3(1.0),l9_2003.xyz,float3(l9_2003.w)),l9_2003.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_2005=l9_2003.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_2005=fast::clamp(l9_2005,0.0,1.0);
}
l9_2004=float4(l9_2003.xyz*l9_2005,l9_2005);
}
else
{
l9_2004=l9_2003;
}
}
float4 l9_2006=l9_2004;
param_6=l9_2006;
}
}
}
float4 l9_2007=param_6;
FinalColor=l9_2007;
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
float4 l9_2008=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_2008=float4((*sc_set2.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_2008=float4(0.0);
}
float4 l9_2009=l9_2008;
float4 Cost=l9_2009;
if (Cost.w>0.0)
{
FinalColor=Cost;
}
FinalColor=fast::max(FinalColor,float4(0.0));
float3 param_7=in.varPos;
float4 param_8=FinalColor;
FinalColor=outputMotionVectorsIfNeeded(param_7,param_8,in.varStereoViewID,(*sc_set2.UserUniforms));
float4 param_9=FinalColor;
float4 l9_2010=param_9;
out.FragColor0=l9_2010;
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
float3 SurfacePosition_WorldSpace;
float3 VertexNormal_WorldSpace;
float3 VertexTangent_WorldSpace;
float3 VertexBinormal_WorldSpace;
float2 Surface_UVCoord0;
float2 Surface_UVCoord1;
float2 gScreenCoord;
float4 VertexColor;
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
float3 emissiveFactor;
float4 emissiveTextureSize;
float4 emissiveTextureDims;
float4 emissiveTextureView;
float3x3 emissiveTextureTransform;
float4 emissiveTextureUvMinMax;
float4 emissiveTextureBorderColor;
float normalTextureScale;
float4 normalTextureSize;
float4 normalTextureDims;
float4 normalTextureView;
float3x3 normalTextureTransform;
float4 normalTextureUvMinMax;
float4 normalTextureBorderColor;
float metallicFactor;
float roughnessFactor;
float occlusionTextureStrength;
float4 metallicRoughnessTextureSize;
float4 metallicRoughnessTextureDims;
float4 metallicRoughnessTextureView;
float3x3 metallicRoughnessTextureTransform;
float4 metallicRoughnessTextureUvMinMax;
float4 metallicRoughnessTextureBorderColor;
float transmissionFactor;
float4 transmissionTextureSize;
float4 transmissionTextureDims;
float4 transmissionTextureView;
float3x3 transmissionTextureTransform;
float4 transmissionTextureUvMinMax;
float4 transmissionTextureBorderColor;
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
float3 sheenColorFactor;
float4 sheenColorTextureSize;
float4 sheenColorTextureDims;
float4 sheenColorTextureView;
float3x3 sheenColorTextureTransform;
float4 sheenColorTextureUvMinMax;
float4 sheenColorTextureBorderColor;
float sheenRoughnessFactor;
float4 sheenRoughnessTextureSize;
float4 sheenRoughnessTextureDims;
float4 sheenRoughnessTextureView;
float3x3 sheenRoughnessTextureTransform;
float4 sheenRoughnessTextureUvMinMax;
float4 sheenRoughnessTextureBorderColor;
float clearcoatFactor;
float4 clearcoatTextureSize;
float4 clearcoatTextureDims;
float4 clearcoatTextureView;
float3x3 clearcoatTextureTransform;
float4 clearcoatTextureUvMinMax;
float4 clearcoatTextureBorderColor;
float clearcoatRoughnessFactor;
float4 clearcoatRoughnessTextureSize;
float4 clearcoatRoughnessTextureDims;
float4 clearcoatRoughnessTextureView;
float3x3 clearcoatRoughnessTextureTransform;
float4 clearcoatRoughnessTextureUvMinMax;
float4 clearcoatRoughnessTextureBorderColor;
float4 clearcoatNormalTextureSize;
float4 clearcoatNormalTextureDims;
float4 clearcoatNormalTextureView;
float3x3 clearcoatNormalTextureTransform;
float4 clearcoatNormalTextureUvMinMax;
float4 clearcoatNormalTextureBorderColor;
float4 baseColorTextureSize;
float4 baseColorTextureDims;
float4 baseColorTextureView;
float3x3 baseColorTextureTransform;
float4 baseColorTextureUvMinMax;
float4 baseColorTextureBorderColor;
float4 baseColorFactor;
float2 baseColorTexture_offset;
float2 baseColorTexture_scale;
float baseColorTexture_rotation;
float2 emissiveTexture_offset;
float2 emissiveTexture_scale;
float emissiveTexture_rotation;
float2 normalTexture_offset;
float2 normalTexture_scale;
float normalTexture_rotation;
float2 metallicRoughnessTexture_offset;
float2 metallicRoughnessTexture_scale;
float metallicRoughnessTexture_rotation;
float2 transmissionTexture_offset;
float2 transmissionTexture_scale;
float transmissionTexture_rotation;
float2 sheenColorTexture_offset;
float2 sheenColorTexture_scale;
float sheenColorTexture_rotation;
float2 sheenRoughnessTexture_offset;
float2 sheenRoughnessTexture_scale;
float sheenRoughnessTexture_rotation;
float2 clearcoatTexture_offset;
float2 clearcoatTexture_scale;
float clearcoatTexture_rotation;
float2 clearcoatNormalTexture_offset;
float2 clearcoatNormalTexture_scale;
float clearcoatNormalTexture_rotation;
float2 clearcoatRoughnessTexture_offset;
float2 clearcoatRoughnessTexture_scale;
float clearcoatRoughnessTexture_rotation;
float Port_DebugSheenEnvLightMult_N003;
float Port_DebugSheenPunctualLightMult_N003;
float Port_Input2_N043;
float Port_Input2_N062;
float3 Port_SpecularAO_N036;
float3 Port_Albedo_N405;
float Port_Opacity_N405;
float3 Port_Emissive_N405;
float Port_Metallic_N405;
float3 Port_SpecularAO_N405;
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
texture2d<float> baseColorTexture [[id(4)]];
texture2d<float> clearcoatNormalTexture [[id(5)]];
texture2d<float> clearcoatRoughnessTexture [[id(6)]];
texture2d<float> clearcoatTexture [[id(7)]];
texture2d<float> emissiveTexture [[id(8)]];
texture2d<float> intensityTexture [[id(9)]];
texture2d<float> metallicRoughnessTexture [[id(10)]];
texture2d<float> normalTexture [[id(11)]];
texture2d<float> sc_EnvmapDiffuse [[id(12)]];
texture2d<float> sc_EnvmapSpecular [[id(13)]];
texture2d<float> sc_RayTracedAoTexture [[id(22)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(23)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(24)]];
texture2d<float> sc_RayTracedShadowTexture [[id(25)]];
texture2d<float> sc_SSAOTexture [[id(26)]];
texture2d<float> sc_ScreenTexture [[id(27)]];
texture2d<float> sc_ShadowTexture [[id(28)]];
texture2d<float> screenTexture [[id(30)]];
texture2d<float> sheenColorTexture [[id(31)]];
texture2d<float> sheenRoughnessTexture [[id(32)]];
texture2d<float> transmissionTexture [[id(33)]];
texture2d<uint> z_hitIdAndBarycentric [[id(34)]];
texture2d<float> z_rayDirections [[id(35)]];
sampler baseColorTextureSmpSC [[id(36)]];
sampler clearcoatNormalTextureSmpSC [[id(37)]];
sampler clearcoatRoughnessTextureSmpSC [[id(38)]];
sampler clearcoatTextureSmpSC [[id(39)]];
sampler emissiveTextureSmpSC [[id(40)]];
sampler intensityTextureSmpSC [[id(41)]];
sampler metallicRoughnessTextureSmpSC [[id(42)]];
sampler normalTextureSmpSC [[id(43)]];
sampler sc_EnvmapDiffuseSmpSC [[id(44)]];
sampler sc_EnvmapSpecularSmpSC [[id(45)]];
sampler sc_RayTracedAoTextureSmpSC [[id(47)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(48)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(49)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(50)]];
sampler sc_SSAOTextureSmpSC [[id(51)]];
sampler sc_ScreenTextureSmpSC [[id(52)]];
sampler sc_ShadowTextureSmpSC [[id(53)]];
sampler screenTextureSmpSC [[id(55)]];
sampler sheenColorTextureSmpSC [[id(56)]];
sampler sheenRoughnessTextureSmpSC [[id(57)]];
sampler transmissionTextureSmpSC [[id(58)]];
sampler z_hitIdAndBarycentricSmp [[id(59)]];
sampler z_rayDirectionsSmpSC [[id(60)]];
constant userUniformsObj* UserUniforms [[id(61)]];
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
// Implementation of the GLSL radians() function
template<typename T>
T radians(T d)
{
return d*T(0.01745329251);
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
fragment main_recv_out main_recv(main_recv_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]])
{
main_recv_out out={};
bool N3_EnableNormalTexture=false;
float N3_NormalScale=0.0;
int N3_NormalTextureCoord=0;
float N3_RoughnessValue=0.0;
bool N3_EnableMetallicRoughnessTexture=false;
int N3_MaterialParamsTextureCoord=0;
bool N3_SheenEnable=false;
float N3_SheenRoughnessFactor=0.0;
bool N3_EnableSheenRoughnessTexture=false;
int N3_SheenRoughnessTextureCoord=0;
bool N3_ClearcoatEnable=false;
float N3_ClearcoatRoughnessFactor=0.0;
bool N3_EnableClearCoatRoughnessTexture=false;
int N3_ClearcoatRoughnessTextureCoord=0;
bool N3_EnableClearCoatNormalTexture=false;
int N3_ClearcoatNormalMapCoord=0;
float N3_OpacityIn=0.0;
bool N3_EnableTextureTransform=false;
bool N3_NormalTextureTransform=false;
float2 N3_NormalTextureOffset=float2(0.0);
float2 N3_NormalTextureScale=float2(0.0);
float N3_NormalTextureRotation=0.0;
bool N3_MaterialParamsTextureTransform=false;
float2 N3_MaterialParamsTextureOffset=float2(0.0);
float2 N3_MaterialParamsTextureScale=float2(0.0);
float N3_MaterialParamsTextureRotation=0.0;
bool N3_SheenRoughnessTextureTransform=false;
float2 N3_SheenRoughnessTextureOffset=float2(0.0);
float2 N3_SheenRoughnessTextureScale=float2(0.0);
float N3_SheenRoughnessTextureRotation=0.0;
bool N3_ClearcoatNormalTextureTransform=false;
float2 N3_ClearcoatNormalTextureOffset=float2(0.0);
float2 N3_ClearcoatNormalTextureScale=float2(0.0);
float N3_ClearcoatNormalTextureRotation=0.0;
bool N3_ClearcoatRoughnessTextureTransform=false;
float2 N3_ClearcoatRoughnessTextureOffset=float2(0.0);
float2 N3_ClearcoatRoughnessTextureScale=float2(0.0);
float N3_ClearcoatRoughnessTextureRotation=0.0;
float N3_Opacity=0.0;
float3 N3_Normal=float3(0.0);
float N3_Roughness=0.0;
float3 N3_ClearcoatNormal=float3(0.0);
float N3_ClearcoatRoughness=0.0;
bool N35_EnableVertexColor=false;
bool N35_EnableBaseTexture=false;
int N35_BaseColorTextureCoord=0;
float4 N35_BaseColorFactor=float4(0.0);
bool N35_EnableTextureTransform=false;
bool N35_BaseTextureTransform=false;
float2 N35_BaseTextureOffset=float2(0.0);
float2 N35_BaseTextureScale=float2(0.0);
float N35_BaseTextureRotation=0.0;
float N35_Opacity=0.0;
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
Globals.SurfacePosition_WorldSpace=in.varPos;
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.VertexTangent_WorldSpace=normalize(in.varTangent.xyz);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*in.varTangent.w;
Globals.Surface_UVCoord0=in.varPackedTex.xy;
Globals.Surface_UVCoord1=in.varPackedTex.zw;
float4 l9_2=gl_FragCoord;
float2 l9_3=(l9_2.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_4=l9_3;
float2 l9_5=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_6=1;
int l9_7=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_7=0;
}
else
{
l9_7=in.varStereoViewID;
}
int l9_8=l9_7;
int l9_9=l9_8;
float3 l9_10=float3(l9_4,0.0);
int l9_11=l9_6;
int l9_12=l9_9;
if (l9_11==1)
{
l9_10.y=((2.0*l9_10.y)+float(l9_12))-1.0;
}
float2 l9_13=l9_10.xy;
l9_5=l9_13;
}
else
{
l9_5=l9_4;
}
float2 l9_14=l9_5;
float2 l9_15=l9_14;
float2 l9_16=l9_15;
Globals.gScreenCoord=l9_16;
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-Globals.SurfacePosition_WorldSpace);
Globals.VertexColor=in.varColor;
ssGlobals param=Globals;
ssGlobals tempGlobals;
if ((int(ENABLE_GLTF_LIGHTING_tmp)!=0))
{
float l9_17=0.0;
float l9_18=1.0;
float l9_19=(*sc_set2.UserUniforms).Port_Input2_N043;
float l9_20;
if ((int(ENABLE_NORMALMAP_tmp)!=0))
{
float l9_21=0.0;
float l9_22=(*sc_set2.UserUniforms).normalTextureScale;
l9_21=l9_22;
l9_18=l9_21;
l9_20=l9_18;
}
else
{
l9_20=l9_19;
}
l9_17=l9_20;
float l9_23=0.0;
float l9_24=(*sc_set2.UserUniforms).roughnessFactor;
l9_23=l9_24;
float l9_25=0.0;
float l9_26=(*sc_set2.UserUniforms).sheenRoughnessFactor;
l9_25=l9_26;
float l9_27=0.0;
float l9_28=(*sc_set2.UserUniforms).clearcoatRoughnessFactor;
l9_27=l9_28;
float4 l9_29=float4(0.0);
float4 l9_30=(*sc_set2.UserUniforms).baseColorFactor;
l9_29=l9_30;
float2 l9_31=float2(0.0);
float2 l9_32=(*sc_set2.UserUniforms).baseColorTexture_offset;
l9_31=l9_32;
float2 l9_33=float2(0.0);
float2 l9_34=(*sc_set2.UserUniforms).baseColorTexture_scale;
l9_33=l9_34;
float l9_35=0.0;
float l9_36=(*sc_set2.UserUniforms).baseColorTexture_rotation;
l9_35=l9_36;
float l9_37=0.0;
float4 l9_38=l9_29;
float2 l9_39=l9_31;
float2 l9_40=l9_33;
float l9_41=l9_35;
ssGlobals l9_42=param;
tempGlobals=l9_42;
float l9_43=0.0;
N35_EnableVertexColor=(int(ENABLE_VERTEX_COLOR_BASE_tmp)!=0);
N35_EnableBaseTexture=(int(ENABLE_BASE_TEX_tmp)!=0);
N35_BaseColorTextureCoord=NODE_7_DROPLIST_ITEM_tmp;
N35_BaseColorFactor=l9_38;
N35_EnableTextureTransform=(int(ENABLE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureTransform=(int(ENABLE_BASE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureOffset=l9_39;
N35_BaseTextureScale=l9_40;
N35_BaseTextureRotation=l9_41;
float4 l9_44=N35_BaseColorFactor;
if (N35_EnableBaseTexture)
{
int l9_45=N35_BaseColorTextureCoord;
float2 l9_46=tempGlobals.Surface_UVCoord0;
float2 l9_47=l9_46;
if (l9_45==0)
{
float2 l9_48=tempGlobals.Surface_UVCoord0;
l9_47=l9_48;
}
if (l9_45==1)
{
float2 l9_49=tempGlobals.Surface_UVCoord1;
l9_47=l9_49;
}
float2 l9_50=l9_47;
float2 l9_51=l9_50;
if (N35_EnableTextureTransform&&N35_BaseTextureTransform)
{
float2 l9_52=l9_51;
float2 l9_53=N35_BaseTextureOffset;
float2 l9_54=N35_BaseTextureScale;
float l9_55=N35_BaseTextureRotation;
float3x3 l9_56=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_53.x,l9_53.y,1.0));
float3x3 l9_57=float3x3(float3(cos(l9_55),sin(l9_55),0.0),float3(-sin(l9_55),cos(l9_55),0.0),float3(0.0,0.0,1.0));
float3x3 l9_58=float3x3(float3(l9_54.x,0.0,0.0),float3(0.0,l9_54.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_59=(l9_56*l9_57)*l9_58;
float2 l9_60=(l9_59*float3(l9_52,1.0)).xy;
l9_51=l9_60;
}
float2 l9_61=l9_51;
float4 l9_62=float4(0.0);
int l9_63=0;
if ((int(baseColorTextureHasSwappedViews_tmp)!=0))
{
int l9_64=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_64=0;
}
else
{
l9_64=in.varStereoViewID;
}
int l9_65=l9_64;
l9_63=1-l9_65;
}
else
{
int l9_66=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_66=0;
}
else
{
l9_66=in.varStereoViewID;
}
int l9_67=l9_66;
l9_63=l9_67;
}
int l9_68=l9_63;
int l9_69=baseColorTextureLayout_tmp;
int l9_70=l9_68;
float2 l9_71=l9_61;
bool l9_72=(int(SC_USE_UV_TRANSFORM_baseColorTexture_tmp)!=0);
float3x3 l9_73=(*sc_set2.UserUniforms).baseColorTextureTransform;
int2 l9_74=int2(SC_SOFTWARE_WRAP_MODE_U_baseColorTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_baseColorTexture_tmp);
bool l9_75=(int(SC_USE_UV_MIN_MAX_baseColorTexture_tmp)!=0);
float4 l9_76=(*sc_set2.UserUniforms).baseColorTextureUvMinMax;
bool l9_77=(int(SC_USE_CLAMP_TO_BORDER_baseColorTexture_tmp)!=0);
float4 l9_78=(*sc_set2.UserUniforms).baseColorTextureBorderColor;
float l9_79=0.0;
bool l9_80=l9_77&&(!l9_75);
float l9_81=1.0;
float l9_82=l9_71.x;
int l9_83=l9_74.x;
if (l9_83==1)
{
l9_82=fract(l9_82);
}
else
{
if (l9_83==2)
{
float l9_84=fract(l9_82);
float l9_85=l9_82-l9_84;
float l9_86=step(0.25,fract(l9_85*0.5));
l9_82=mix(l9_84,1.0-l9_84,fast::clamp(l9_86,0.0,1.0));
}
}
l9_71.x=l9_82;
float l9_87=l9_71.y;
int l9_88=l9_74.y;
if (l9_88==1)
{
l9_87=fract(l9_87);
}
else
{
if (l9_88==2)
{
float l9_89=fract(l9_87);
float l9_90=l9_87-l9_89;
float l9_91=step(0.25,fract(l9_90*0.5));
l9_87=mix(l9_89,1.0-l9_89,fast::clamp(l9_91,0.0,1.0));
}
}
l9_71.y=l9_87;
if (l9_75)
{
bool l9_92=l9_77;
bool l9_93;
if (l9_92)
{
l9_93=l9_74.x==3;
}
else
{
l9_93=l9_92;
}
float l9_94=l9_71.x;
float l9_95=l9_76.x;
float l9_96=l9_76.z;
bool l9_97=l9_93;
float l9_98=l9_81;
float l9_99=fast::clamp(l9_94,l9_95,l9_96);
float l9_100=step(abs(l9_94-l9_99),9.9999997e-06);
l9_98*=(l9_100+((1.0-float(l9_97))*(1.0-l9_100)));
l9_94=l9_99;
l9_71.x=l9_94;
l9_81=l9_98;
bool l9_101=l9_77;
bool l9_102;
if (l9_101)
{
l9_102=l9_74.y==3;
}
else
{
l9_102=l9_101;
}
float l9_103=l9_71.y;
float l9_104=l9_76.y;
float l9_105=l9_76.w;
bool l9_106=l9_102;
float l9_107=l9_81;
float l9_108=fast::clamp(l9_103,l9_104,l9_105);
float l9_109=step(abs(l9_103-l9_108),9.9999997e-06);
l9_107*=(l9_109+((1.0-float(l9_106))*(1.0-l9_109)));
l9_103=l9_108;
l9_71.y=l9_103;
l9_81=l9_107;
}
float2 l9_110=l9_71;
bool l9_111=l9_72;
float3x3 l9_112=l9_73;
if (l9_111)
{
l9_110=float2((l9_112*float3(l9_110,1.0)).xy);
}
float2 l9_113=l9_110;
float2 l9_114=l9_113;
float2 l9_115=l9_114;
l9_71=l9_115;
float l9_116=l9_71.x;
int l9_117=l9_74.x;
bool l9_118=l9_80;
float l9_119=l9_81;
if ((l9_117==0)||(l9_117==3))
{
float l9_120=l9_116;
float l9_121=0.0;
float l9_122=1.0;
bool l9_123=l9_118;
float l9_124=l9_119;
float l9_125=fast::clamp(l9_120,l9_121,l9_122);
float l9_126=step(abs(l9_120-l9_125),9.9999997e-06);
l9_124*=(l9_126+((1.0-float(l9_123))*(1.0-l9_126)));
l9_120=l9_125;
l9_116=l9_120;
l9_119=l9_124;
}
l9_71.x=l9_116;
l9_81=l9_119;
float l9_127=l9_71.y;
int l9_128=l9_74.y;
bool l9_129=l9_80;
float l9_130=l9_81;
if ((l9_128==0)||(l9_128==3))
{
float l9_131=l9_127;
float l9_132=0.0;
float l9_133=1.0;
bool l9_134=l9_129;
float l9_135=l9_130;
float l9_136=fast::clamp(l9_131,l9_132,l9_133);
float l9_137=step(abs(l9_131-l9_136),9.9999997e-06);
l9_135*=(l9_137+((1.0-float(l9_134))*(1.0-l9_137)));
l9_131=l9_136;
l9_127=l9_131;
l9_130=l9_135;
}
l9_71.y=l9_127;
l9_81=l9_130;
float2 l9_138=l9_71;
int l9_139=l9_69;
int l9_140=l9_70;
float l9_141=l9_79;
float2 l9_142=l9_138;
int l9_143=l9_139;
int l9_144=l9_140;
float3 l9_145=float3(0.0);
if (l9_143==0)
{
l9_145=float3(l9_142,0.0);
}
else
{
if (l9_143==1)
{
l9_145=float3(l9_142.x,(l9_142.y*0.5)+(0.5-(float(l9_144)*0.5)),0.0);
}
else
{
l9_145=float3(l9_142,float(l9_144));
}
}
float3 l9_146=l9_145;
float3 l9_147=l9_146;
float2 l9_148=l9_147.xy;
float l9_149=l9_141;
float4 l9_150=sc_set2.baseColorTexture.sample(sc_set2.baseColorTextureSmpSC,l9_148,bias(l9_149));
float4 l9_151=l9_150;
float4 l9_152=l9_151;
if (l9_77)
{
l9_152=mix(l9_78,l9_152,float4(l9_81));
}
float4 l9_153=l9_152;
l9_62=l9_153;
float4 l9_154=l9_62;
float4 l9_155=l9_154;
float4 l9_156;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_156=float4(pow(l9_155.x,2.2),pow(l9_155.y,2.2),pow(l9_155.z,2.2),pow(l9_155.w,2.2));
}
else
{
l9_156=l9_155*l9_155;
}
float4 l9_157=l9_156;
l9_44*=l9_157;
}
if (N35_EnableVertexColor)
{
float4 l9_158=tempGlobals.VertexColor;
l9_44*=l9_158;
}
N35_Opacity=l9_44.w;
l9_43=N35_Opacity;
l9_37=l9_43;
float2 l9_159=float2(0.0);
float2 l9_160=(*sc_set2.UserUniforms).normalTexture_offset;
l9_159=l9_160;
float2 l9_161=float2(0.0);
float2 l9_162=(*sc_set2.UserUniforms).normalTexture_scale;
l9_161=l9_162;
float l9_163=0.0;
float l9_164=(*sc_set2.UserUniforms).normalTexture_rotation;
l9_163=l9_164;
float2 l9_165=float2(0.0);
float2 l9_166=(*sc_set2.UserUniforms).metallicRoughnessTexture_offset;
l9_165=l9_166;
float2 l9_167=float2(0.0);
float2 l9_168=(*sc_set2.UserUniforms).metallicRoughnessTexture_scale;
l9_167=l9_168;
float l9_169=0.0;
float l9_170=(*sc_set2.UserUniforms).metallicRoughnessTexture_rotation;
l9_169=l9_170;
float2 l9_171=float2(0.0);
float2 l9_172=(*sc_set2.UserUniforms).sheenRoughnessTexture_offset;
l9_171=l9_172;
float2 l9_173=float2(0.0);
float2 l9_174=(*sc_set2.UserUniforms).sheenRoughnessTexture_scale;
l9_173=l9_174;
float l9_175=0.0;
float l9_176=(*sc_set2.UserUniforms).sheenRoughnessTexture_rotation;
l9_175=l9_176;
float2 l9_177=float2(0.0);
float2 l9_178=(*sc_set2.UserUniforms).clearcoatNormalTexture_offset;
l9_177=l9_178;
float2 l9_179=float2(0.0);
float2 l9_180=(*sc_set2.UserUniforms).clearcoatNormalTexture_scale;
l9_179=l9_180;
float l9_181=0.0;
float l9_182=(*sc_set2.UserUniforms).clearcoatNormalTexture_rotation;
l9_181=l9_182;
float2 l9_183=float2(0.0);
float2 l9_184=(*sc_set2.UserUniforms).clearcoatRoughnessTexture_offset;
l9_183=l9_184;
float2 l9_185=float2(0.0);
float2 l9_186=(*sc_set2.UserUniforms).clearcoatRoughnessTexture_scale;
l9_185=l9_186;
float l9_187=0.0;
float l9_188=(*sc_set2.UserUniforms).clearcoatRoughnessTexture_rotation;
l9_187=l9_188;
float l9_189=0.0;
float3 l9_190=float3(0.0);
float l9_191=0.0;
float3 l9_192=float3(0.0);
float l9_193=0.0;
float l9_194=l9_17;
float l9_195=l9_23;
float l9_196=l9_25;
float l9_197=l9_27;
float l9_198=l9_37;
float2 l9_199=l9_159;
float2 l9_200=l9_161;
float l9_201=l9_163;
float2 l9_202=l9_165;
float2 l9_203=l9_167;
float l9_204=l9_169;
float2 l9_205=l9_171;
float2 l9_206=l9_173;
float l9_207=l9_175;
float2 l9_208=l9_177;
float2 l9_209=l9_179;
float l9_210=l9_181;
float2 l9_211=l9_183;
float2 l9_212=l9_185;
float l9_213=l9_187;
ssGlobals l9_214=param;
tempGlobals=l9_214;
float l9_215=0.0;
float3 l9_216=float3(0.0);
float l9_217=0.0;
float3 l9_218=float3(0.0);
float l9_219=0.0;
N3_EnableNormalTexture=(int(ENABLE_NORMALMAP_tmp)!=0);
N3_NormalScale=l9_194;
N3_NormalTextureCoord=NODE_8_DROPLIST_ITEM_tmp;
N3_RoughnessValue=l9_195;
N3_EnableMetallicRoughnessTexture=(int(ENABLE_METALLIC_ROUGHNESS_TEX_tmp)!=0);
N3_MaterialParamsTextureCoord=NODE_11_DROPLIST_ITEM_tmp;
N3_SheenEnable=(int(ENABLE_SHEEN_tmp)!=0);
N3_SheenRoughnessFactor=l9_196;
N3_EnableSheenRoughnessTexture=(int(ENABLE_SHEEN_ROUGHNESS_TEX_tmp)!=0);
N3_SheenRoughnessTextureCoord=Tweak_N37_tmp;
N3_ClearcoatEnable=(int(ENABLE_CLEARCOAT_tmp)!=0);
N3_ClearcoatRoughnessFactor=l9_197;
N3_EnableClearCoatRoughnessTexture=(int(ENABLE_CLEARCOAT_ROUGHNESS_TEX_tmp)!=0);
N3_ClearcoatRoughnessTextureCoord=Tweak_N60_tmp;
N3_EnableClearCoatNormalTexture=(int(ENABLE_CLEARCOAT_NORMAL_TEX_tmp)!=0);
N3_ClearcoatNormalMapCoord=Tweak_N47_tmp;
N3_OpacityIn=l9_198;
N3_EnableTextureTransform=(int(ENABLE_TEXTURE_TRANSFORM_tmp)!=0);
N3_NormalTextureTransform=(int(ENABLE_NORMAL_TEXTURE_TRANSFORM_tmp)!=0);
N3_NormalTextureOffset=l9_199;
N3_NormalTextureScale=l9_200;
N3_NormalTextureRotation=l9_201;
N3_MaterialParamsTextureTransform=(int(ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM_tmp)!=0);
N3_MaterialParamsTextureOffset=l9_202;
N3_MaterialParamsTextureScale=l9_203;
N3_MaterialParamsTextureRotation=l9_204;
N3_SheenRoughnessTextureTransform=(int(ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM_tmp)!=0);
N3_SheenRoughnessTextureOffset=l9_205;
N3_SheenRoughnessTextureScale=l9_206;
N3_SheenRoughnessTextureRotation=l9_207;
N3_ClearcoatNormalTextureTransform=(int(ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM_tmp)!=0);
N3_ClearcoatNormalTextureOffset=l9_208;
N3_ClearcoatNormalTextureScale=l9_209;
N3_ClearcoatNormalTextureRotation=l9_210;
N3_ClearcoatRoughnessTextureTransform=(int(ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM_tmp)!=0);
N3_ClearcoatRoughnessTextureOffset=l9_211;
N3_ClearcoatRoughnessTextureScale=l9_212;
N3_ClearcoatRoughnessTextureRotation=l9_213;
N3_Opacity=N3_OpacityIn;
float3 l9_220=tempGlobals.VertexNormal_WorldSpace;
N3_Normal=normalize(l9_220);
if (N3_EnableNormalTexture)
{
float3 l9_221=N3_Normal;
int l9_222=N3_NormalTextureCoord;
float2 l9_223=tempGlobals.Surface_UVCoord0;
float2 l9_224=l9_223;
if (l9_222==0)
{
float2 l9_225=tempGlobals.Surface_UVCoord0;
l9_224=l9_225;
}
if (l9_222==1)
{
float2 l9_226=tempGlobals.Surface_UVCoord1;
l9_224=l9_226;
}
float2 l9_227=l9_224;
float2 l9_228=l9_227;
if (N3_EnableTextureTransform&&N3_NormalTextureTransform)
{
float2 l9_229=l9_228;
float2 l9_230=N3_NormalTextureOffset;
float2 l9_231=N3_NormalTextureScale;
float l9_232=N3_NormalTextureRotation;
float l9_233=radians(l9_232);
float3x3 l9_234=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_230.x,l9_230.y,1.0));
float3x3 l9_235=float3x3(float3(cos(l9_233),sin(l9_233),0.0),float3(-sin(l9_233),cos(l9_233),0.0),float3(0.0,0.0,1.0));
float3x3 l9_236=float3x3(float3(l9_231.x,0.0,0.0),float3(0.0,l9_231.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_237=(l9_234*l9_235)*l9_236;
float2 l9_238=(l9_237*float3(l9_229,1.0)).xy;
l9_228=l9_238;
}
float2 l9_239=l9_228;
float4 l9_240=float4(0.0);
int l9_241=0;
if ((int(normalTextureHasSwappedViews_tmp)!=0))
{
int l9_242=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_242=0;
}
else
{
l9_242=in.varStereoViewID;
}
int l9_243=l9_242;
l9_241=1-l9_243;
}
else
{
int l9_244=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_244=0;
}
else
{
l9_244=in.varStereoViewID;
}
int l9_245=l9_244;
l9_241=l9_245;
}
int l9_246=l9_241;
int l9_247=normalTextureLayout_tmp;
int l9_248=l9_246;
float2 l9_249=l9_239;
bool l9_250=(int(SC_USE_UV_TRANSFORM_normalTexture_tmp)!=0);
float3x3 l9_251=(*sc_set2.UserUniforms).normalTextureTransform;
int2 l9_252=int2(SC_SOFTWARE_WRAP_MODE_U_normalTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTexture_tmp);
bool l9_253=(int(SC_USE_UV_MIN_MAX_normalTexture_tmp)!=0);
float4 l9_254=(*sc_set2.UserUniforms).normalTextureUvMinMax;
bool l9_255=(int(SC_USE_CLAMP_TO_BORDER_normalTexture_tmp)!=0);
float4 l9_256=(*sc_set2.UserUniforms).normalTextureBorderColor;
float l9_257=0.0;
bool l9_258=l9_255&&(!l9_253);
float l9_259=1.0;
float l9_260=l9_249.x;
int l9_261=l9_252.x;
if (l9_261==1)
{
l9_260=fract(l9_260);
}
else
{
if (l9_261==2)
{
float l9_262=fract(l9_260);
float l9_263=l9_260-l9_262;
float l9_264=step(0.25,fract(l9_263*0.5));
l9_260=mix(l9_262,1.0-l9_262,fast::clamp(l9_264,0.0,1.0));
}
}
l9_249.x=l9_260;
float l9_265=l9_249.y;
int l9_266=l9_252.y;
if (l9_266==1)
{
l9_265=fract(l9_265);
}
else
{
if (l9_266==2)
{
float l9_267=fract(l9_265);
float l9_268=l9_265-l9_267;
float l9_269=step(0.25,fract(l9_268*0.5));
l9_265=mix(l9_267,1.0-l9_267,fast::clamp(l9_269,0.0,1.0));
}
}
l9_249.y=l9_265;
if (l9_253)
{
bool l9_270=l9_255;
bool l9_271;
if (l9_270)
{
l9_271=l9_252.x==3;
}
else
{
l9_271=l9_270;
}
float l9_272=l9_249.x;
float l9_273=l9_254.x;
float l9_274=l9_254.z;
bool l9_275=l9_271;
float l9_276=l9_259;
float l9_277=fast::clamp(l9_272,l9_273,l9_274);
float l9_278=step(abs(l9_272-l9_277),9.9999997e-06);
l9_276*=(l9_278+((1.0-float(l9_275))*(1.0-l9_278)));
l9_272=l9_277;
l9_249.x=l9_272;
l9_259=l9_276;
bool l9_279=l9_255;
bool l9_280;
if (l9_279)
{
l9_280=l9_252.y==3;
}
else
{
l9_280=l9_279;
}
float l9_281=l9_249.y;
float l9_282=l9_254.y;
float l9_283=l9_254.w;
bool l9_284=l9_280;
float l9_285=l9_259;
float l9_286=fast::clamp(l9_281,l9_282,l9_283);
float l9_287=step(abs(l9_281-l9_286),9.9999997e-06);
l9_285*=(l9_287+((1.0-float(l9_284))*(1.0-l9_287)));
l9_281=l9_286;
l9_249.y=l9_281;
l9_259=l9_285;
}
float2 l9_288=l9_249;
bool l9_289=l9_250;
float3x3 l9_290=l9_251;
if (l9_289)
{
l9_288=float2((l9_290*float3(l9_288,1.0)).xy);
}
float2 l9_291=l9_288;
float2 l9_292=l9_291;
float2 l9_293=l9_292;
l9_249=l9_293;
float l9_294=l9_249.x;
int l9_295=l9_252.x;
bool l9_296=l9_258;
float l9_297=l9_259;
if ((l9_295==0)||(l9_295==3))
{
float l9_298=l9_294;
float l9_299=0.0;
float l9_300=1.0;
bool l9_301=l9_296;
float l9_302=l9_297;
float l9_303=fast::clamp(l9_298,l9_299,l9_300);
float l9_304=step(abs(l9_298-l9_303),9.9999997e-06);
l9_302*=(l9_304+((1.0-float(l9_301))*(1.0-l9_304)));
l9_298=l9_303;
l9_294=l9_298;
l9_297=l9_302;
}
l9_249.x=l9_294;
l9_259=l9_297;
float l9_305=l9_249.y;
int l9_306=l9_252.y;
bool l9_307=l9_258;
float l9_308=l9_259;
if ((l9_306==0)||(l9_306==3))
{
float l9_309=l9_305;
float l9_310=0.0;
float l9_311=1.0;
bool l9_312=l9_307;
float l9_313=l9_308;
float l9_314=fast::clamp(l9_309,l9_310,l9_311);
float l9_315=step(abs(l9_309-l9_314),9.9999997e-06);
l9_313*=(l9_315+((1.0-float(l9_312))*(1.0-l9_315)));
l9_309=l9_314;
l9_305=l9_309;
l9_308=l9_313;
}
l9_249.y=l9_305;
l9_259=l9_308;
float2 l9_316=l9_249;
int l9_317=l9_247;
int l9_318=l9_248;
float l9_319=l9_257;
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
float4 l9_328=sc_set2.normalTexture.sample(sc_set2.normalTextureSmpSC,l9_326,bias(l9_327));
float4 l9_329=l9_328;
float4 l9_330=l9_329;
if (l9_255)
{
l9_330=mix(l9_256,l9_330,float4(l9_259));
}
float4 l9_331=l9_330;
l9_240=l9_331;
float4 l9_332=l9_240;
float3 l9_333=(l9_332.xyz*1.9921875)-float3(1.0);
l9_333=mix(float3(0.0,0.0,1.0),l9_333,float3(N3_NormalScale));
float3 l9_334=tempGlobals.VertexTangent_WorldSpace;
float3 l9_335=l9_334;
float3 l9_336=tempGlobals.VertexBinormal_WorldSpace;
float3 l9_337=l9_336;
float3x3 l9_338=float3x3(float3(l9_335),float3(l9_337),float3(l9_221));
l9_221=normalize(l9_338*l9_333);
N3_Normal=l9_221;
}
N3_Roughness=N3_RoughnessValue;
if (N3_EnableMetallicRoughnessTexture)
{
float l9_339=N3_Roughness;
int l9_340=N3_MaterialParamsTextureCoord;
float2 l9_341=tempGlobals.Surface_UVCoord0;
float2 l9_342=l9_341;
if (l9_340==0)
{
float2 l9_343=tempGlobals.Surface_UVCoord0;
l9_342=l9_343;
}
if (l9_340==1)
{
float2 l9_344=tempGlobals.Surface_UVCoord1;
l9_342=l9_344;
}
float2 l9_345=l9_342;
float2 l9_346=l9_345;
if (N3_EnableTextureTransform&&N3_MaterialParamsTextureTransform)
{
float2 l9_347=l9_346;
float2 l9_348=N3_MaterialParamsTextureOffset;
float2 l9_349=N3_MaterialParamsTextureScale;
float l9_350=N3_MaterialParamsTextureRotation;
float l9_351=radians(l9_350);
float3x3 l9_352=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_348.x,l9_348.y,1.0));
float3x3 l9_353=float3x3(float3(cos(l9_351),sin(l9_351),0.0),float3(-sin(l9_351),cos(l9_351),0.0),float3(0.0,0.0,1.0));
float3x3 l9_354=float3x3(float3(l9_349.x,0.0,0.0),float3(0.0,l9_349.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_355=(l9_352*l9_353)*l9_354;
float2 l9_356=(l9_355*float3(l9_347,1.0)).xy;
l9_346=l9_356;
}
float2 l9_357=l9_346;
float4 l9_358=float4(0.0);
int l9_359=0;
if ((int(metallicRoughnessTextureHasSwappedViews_tmp)!=0))
{
int l9_360=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_360=0;
}
else
{
l9_360=in.varStereoViewID;
}
int l9_361=l9_360;
l9_359=1-l9_361;
}
else
{
int l9_362=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_362=0;
}
else
{
l9_362=in.varStereoViewID;
}
int l9_363=l9_362;
l9_359=l9_363;
}
int l9_364=l9_359;
int l9_365=metallicRoughnessTextureLayout_tmp;
int l9_366=l9_364;
float2 l9_367=l9_357;
bool l9_368=(int(SC_USE_UV_TRANSFORM_metallicRoughnessTexture_tmp)!=0);
float3x3 l9_369=(*sc_set2.UserUniforms).metallicRoughnessTextureTransform;
int2 l9_370=int2(SC_SOFTWARE_WRAP_MODE_U_metallicRoughnessTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_metallicRoughnessTexture_tmp);
bool l9_371=(int(SC_USE_UV_MIN_MAX_metallicRoughnessTexture_tmp)!=0);
float4 l9_372=(*sc_set2.UserUniforms).metallicRoughnessTextureUvMinMax;
bool l9_373=(int(SC_USE_CLAMP_TO_BORDER_metallicRoughnessTexture_tmp)!=0);
float4 l9_374=(*sc_set2.UserUniforms).metallicRoughnessTextureBorderColor;
float l9_375=0.0;
bool l9_376=l9_373&&(!l9_371);
float l9_377=1.0;
float l9_378=l9_367.x;
int l9_379=l9_370.x;
if (l9_379==1)
{
l9_378=fract(l9_378);
}
else
{
if (l9_379==2)
{
float l9_380=fract(l9_378);
float l9_381=l9_378-l9_380;
float l9_382=step(0.25,fract(l9_381*0.5));
l9_378=mix(l9_380,1.0-l9_380,fast::clamp(l9_382,0.0,1.0));
}
}
l9_367.x=l9_378;
float l9_383=l9_367.y;
int l9_384=l9_370.y;
if (l9_384==1)
{
l9_383=fract(l9_383);
}
else
{
if (l9_384==2)
{
float l9_385=fract(l9_383);
float l9_386=l9_383-l9_385;
float l9_387=step(0.25,fract(l9_386*0.5));
l9_383=mix(l9_385,1.0-l9_385,fast::clamp(l9_387,0.0,1.0));
}
}
l9_367.y=l9_383;
if (l9_371)
{
bool l9_388=l9_373;
bool l9_389;
if (l9_388)
{
l9_389=l9_370.x==3;
}
else
{
l9_389=l9_388;
}
float l9_390=l9_367.x;
float l9_391=l9_372.x;
float l9_392=l9_372.z;
bool l9_393=l9_389;
float l9_394=l9_377;
float l9_395=fast::clamp(l9_390,l9_391,l9_392);
float l9_396=step(abs(l9_390-l9_395),9.9999997e-06);
l9_394*=(l9_396+((1.0-float(l9_393))*(1.0-l9_396)));
l9_390=l9_395;
l9_367.x=l9_390;
l9_377=l9_394;
bool l9_397=l9_373;
bool l9_398;
if (l9_397)
{
l9_398=l9_370.y==3;
}
else
{
l9_398=l9_397;
}
float l9_399=l9_367.y;
float l9_400=l9_372.y;
float l9_401=l9_372.w;
bool l9_402=l9_398;
float l9_403=l9_377;
float l9_404=fast::clamp(l9_399,l9_400,l9_401);
float l9_405=step(abs(l9_399-l9_404),9.9999997e-06);
l9_403*=(l9_405+((1.0-float(l9_402))*(1.0-l9_405)));
l9_399=l9_404;
l9_367.y=l9_399;
l9_377=l9_403;
}
float2 l9_406=l9_367;
bool l9_407=l9_368;
float3x3 l9_408=l9_369;
if (l9_407)
{
l9_406=float2((l9_408*float3(l9_406,1.0)).xy);
}
float2 l9_409=l9_406;
float2 l9_410=l9_409;
float2 l9_411=l9_410;
l9_367=l9_411;
float l9_412=l9_367.x;
int l9_413=l9_370.x;
bool l9_414=l9_376;
float l9_415=l9_377;
if ((l9_413==0)||(l9_413==3))
{
float l9_416=l9_412;
float l9_417=0.0;
float l9_418=1.0;
bool l9_419=l9_414;
float l9_420=l9_415;
float l9_421=fast::clamp(l9_416,l9_417,l9_418);
float l9_422=step(abs(l9_416-l9_421),9.9999997e-06);
l9_420*=(l9_422+((1.0-float(l9_419))*(1.0-l9_422)));
l9_416=l9_421;
l9_412=l9_416;
l9_415=l9_420;
}
l9_367.x=l9_412;
l9_377=l9_415;
float l9_423=l9_367.y;
int l9_424=l9_370.y;
bool l9_425=l9_376;
float l9_426=l9_377;
if ((l9_424==0)||(l9_424==3))
{
float l9_427=l9_423;
float l9_428=0.0;
float l9_429=1.0;
bool l9_430=l9_425;
float l9_431=l9_426;
float l9_432=fast::clamp(l9_427,l9_428,l9_429);
float l9_433=step(abs(l9_427-l9_432),9.9999997e-06);
l9_431*=(l9_433+((1.0-float(l9_430))*(1.0-l9_433)));
l9_427=l9_432;
l9_423=l9_427;
l9_426=l9_431;
}
l9_367.y=l9_423;
l9_377=l9_426;
float2 l9_434=l9_367;
int l9_435=l9_365;
int l9_436=l9_366;
float l9_437=l9_375;
float2 l9_438=l9_434;
int l9_439=l9_435;
int l9_440=l9_436;
float3 l9_441=float3(0.0);
if (l9_439==0)
{
l9_441=float3(l9_438,0.0);
}
else
{
if (l9_439==1)
{
l9_441=float3(l9_438.x,(l9_438.y*0.5)+(0.5-(float(l9_440)*0.5)),0.0);
}
else
{
l9_441=float3(l9_438,float(l9_440));
}
}
float3 l9_442=l9_441;
float3 l9_443=l9_442;
float2 l9_444=l9_443.xy;
float l9_445=l9_437;
float4 l9_446=sc_set2.metallicRoughnessTexture.sample(sc_set2.metallicRoughnessTextureSmpSC,l9_444,bias(l9_445));
float4 l9_447=l9_446;
float4 l9_448=l9_447;
if (l9_373)
{
l9_448=mix(l9_374,l9_448,float4(l9_377));
}
float4 l9_449=l9_448;
l9_358=l9_449;
float4 l9_450=l9_358;
float3 l9_451=l9_450.xyz;
l9_339*=l9_451.y;
N3_Roughness=l9_339;
}
float l9_452=N3_Opacity;
float l9_453;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_453=pow(l9_452,0.45454544);
}
else
{
l9_453=sqrt(l9_452);
}
float l9_454=l9_453;
N3_Opacity=l9_454;
if (N3_SheenEnable)
{
float3 l9_455=N3_Normal;
float l9_456=N3_SheenRoughnessFactor;
if (N3_EnableSheenRoughnessTexture)
{
int l9_457=N3_SheenRoughnessTextureCoord;
float2 l9_458=tempGlobals.Surface_UVCoord0;
float2 l9_459=l9_458;
if (l9_457==0)
{
float2 l9_460=tempGlobals.Surface_UVCoord0;
l9_459=l9_460;
}
if (l9_457==1)
{
float2 l9_461=tempGlobals.Surface_UVCoord1;
l9_459=l9_461;
}
float2 l9_462=l9_459;
float2 l9_463=l9_462;
if (N3_EnableTextureTransform&&N3_SheenRoughnessTextureTransform)
{
float2 l9_464=l9_463;
float2 l9_465=N3_SheenRoughnessTextureOffset;
float2 l9_466=N3_SheenRoughnessTextureScale;
float l9_467=N3_SheenRoughnessTextureRotation;
float l9_468=radians(l9_467);
float3x3 l9_469=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_465.x,l9_465.y,1.0));
float3x3 l9_470=float3x3(float3(cos(l9_468),sin(l9_468),0.0),float3(-sin(l9_468),cos(l9_468),0.0),float3(0.0,0.0,1.0));
float3x3 l9_471=float3x3(float3(l9_466.x,0.0,0.0),float3(0.0,l9_466.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_472=(l9_469*l9_470)*l9_471;
float2 l9_473=(l9_472*float3(l9_464,1.0)).xy;
l9_463=l9_473;
}
float2 l9_474=l9_463;
float4 l9_475=float4(0.0);
int l9_476=0;
if ((int(sheenRoughnessTextureHasSwappedViews_tmp)!=0))
{
int l9_477=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_477=0;
}
else
{
l9_477=in.varStereoViewID;
}
int l9_478=l9_477;
l9_476=1-l9_478;
}
else
{
int l9_479=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_479=0;
}
else
{
l9_479=in.varStereoViewID;
}
int l9_480=l9_479;
l9_476=l9_480;
}
int l9_481=l9_476;
int l9_482=sheenRoughnessTextureLayout_tmp;
int l9_483=l9_481;
float2 l9_484=l9_474;
bool l9_485=(int(SC_USE_UV_TRANSFORM_sheenRoughnessTexture_tmp)!=0);
float3x3 l9_486=(*sc_set2.UserUniforms).sheenRoughnessTextureTransform;
int2 l9_487=int2(SC_SOFTWARE_WRAP_MODE_U_sheenRoughnessTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sheenRoughnessTexture_tmp);
bool l9_488=(int(SC_USE_UV_MIN_MAX_sheenRoughnessTexture_tmp)!=0);
float4 l9_489=(*sc_set2.UserUniforms).sheenRoughnessTextureUvMinMax;
bool l9_490=(int(SC_USE_CLAMP_TO_BORDER_sheenRoughnessTexture_tmp)!=0);
float4 l9_491=(*sc_set2.UserUniforms).sheenRoughnessTextureBorderColor;
float l9_492=0.0;
bool l9_493=l9_490&&(!l9_488);
float l9_494=1.0;
float l9_495=l9_484.x;
int l9_496=l9_487.x;
if (l9_496==1)
{
l9_495=fract(l9_495);
}
else
{
if (l9_496==2)
{
float l9_497=fract(l9_495);
float l9_498=l9_495-l9_497;
float l9_499=step(0.25,fract(l9_498*0.5));
l9_495=mix(l9_497,1.0-l9_497,fast::clamp(l9_499,0.0,1.0));
}
}
l9_484.x=l9_495;
float l9_500=l9_484.y;
int l9_501=l9_487.y;
if (l9_501==1)
{
l9_500=fract(l9_500);
}
else
{
if (l9_501==2)
{
float l9_502=fract(l9_500);
float l9_503=l9_500-l9_502;
float l9_504=step(0.25,fract(l9_503*0.5));
l9_500=mix(l9_502,1.0-l9_502,fast::clamp(l9_504,0.0,1.0));
}
}
l9_484.y=l9_500;
if (l9_488)
{
bool l9_505=l9_490;
bool l9_506;
if (l9_505)
{
l9_506=l9_487.x==3;
}
else
{
l9_506=l9_505;
}
float l9_507=l9_484.x;
float l9_508=l9_489.x;
float l9_509=l9_489.z;
bool l9_510=l9_506;
float l9_511=l9_494;
float l9_512=fast::clamp(l9_507,l9_508,l9_509);
float l9_513=step(abs(l9_507-l9_512),9.9999997e-06);
l9_511*=(l9_513+((1.0-float(l9_510))*(1.0-l9_513)));
l9_507=l9_512;
l9_484.x=l9_507;
l9_494=l9_511;
bool l9_514=l9_490;
bool l9_515;
if (l9_514)
{
l9_515=l9_487.y==3;
}
else
{
l9_515=l9_514;
}
float l9_516=l9_484.y;
float l9_517=l9_489.y;
float l9_518=l9_489.w;
bool l9_519=l9_515;
float l9_520=l9_494;
float l9_521=fast::clamp(l9_516,l9_517,l9_518);
float l9_522=step(abs(l9_516-l9_521),9.9999997e-06);
l9_520*=(l9_522+((1.0-float(l9_519))*(1.0-l9_522)));
l9_516=l9_521;
l9_484.y=l9_516;
l9_494=l9_520;
}
float2 l9_523=l9_484;
bool l9_524=l9_485;
float3x3 l9_525=l9_486;
if (l9_524)
{
l9_523=float2((l9_525*float3(l9_523,1.0)).xy);
}
float2 l9_526=l9_523;
float2 l9_527=l9_526;
float2 l9_528=l9_527;
l9_484=l9_528;
float l9_529=l9_484.x;
int l9_530=l9_487.x;
bool l9_531=l9_493;
float l9_532=l9_494;
if ((l9_530==0)||(l9_530==3))
{
float l9_533=l9_529;
float l9_534=0.0;
float l9_535=1.0;
bool l9_536=l9_531;
float l9_537=l9_532;
float l9_538=fast::clamp(l9_533,l9_534,l9_535);
float l9_539=step(abs(l9_533-l9_538),9.9999997e-06);
l9_537*=(l9_539+((1.0-float(l9_536))*(1.0-l9_539)));
l9_533=l9_538;
l9_529=l9_533;
l9_532=l9_537;
}
l9_484.x=l9_529;
l9_494=l9_532;
float l9_540=l9_484.y;
int l9_541=l9_487.y;
bool l9_542=l9_493;
float l9_543=l9_494;
if ((l9_541==0)||(l9_541==3))
{
float l9_544=l9_540;
float l9_545=0.0;
float l9_546=1.0;
bool l9_547=l9_542;
float l9_548=l9_543;
float l9_549=fast::clamp(l9_544,l9_545,l9_546);
float l9_550=step(abs(l9_544-l9_549),9.9999997e-06);
l9_548*=(l9_550+((1.0-float(l9_547))*(1.0-l9_550)));
l9_544=l9_549;
l9_540=l9_544;
l9_543=l9_548;
}
l9_484.y=l9_540;
l9_494=l9_543;
float2 l9_551=l9_484;
int l9_552=l9_482;
int l9_553=l9_483;
float l9_554=l9_492;
float2 l9_555=l9_551;
int l9_556=l9_552;
int l9_557=l9_553;
float3 l9_558=float3(0.0);
if (l9_556==0)
{
l9_558=float3(l9_555,0.0);
}
else
{
if (l9_556==1)
{
l9_558=float3(l9_555.x,(l9_555.y*0.5)+(0.5-(float(l9_557)*0.5)),0.0);
}
else
{
l9_558=float3(l9_555,float(l9_557));
}
}
float3 l9_559=l9_558;
float3 l9_560=l9_559;
float2 l9_561=l9_560.xy;
float l9_562=l9_554;
float4 l9_563=sc_set2.sheenRoughnessTexture.sample(sc_set2.sheenRoughnessTextureSmpSC,l9_561,bias(l9_562));
float4 l9_564=l9_563;
float4 l9_565=l9_564;
if (l9_490)
{
l9_565=mix(l9_491,l9_565,float4(l9_494));
}
float4 l9_566=l9_565;
l9_475=l9_566;
float4 l9_567=l9_475;
float l9_568=l9_567.w;
float l9_569;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_569=pow(l9_568,2.2);
}
else
{
l9_569=l9_568*l9_568;
}
float l9_570=l9_569;
l9_456*=l9_570;
}
l9_456=fast::max(l9_456,9.9999997e-05);
float3 l9_571=l9_455;
float3 l9_572=tempGlobals.ViewDirWS;
float3 l9_573=l9_572;
float3 l9_574=normalize(reflect(-l9_573,l9_571));
float3 l9_575=l9_574;
float l9_576=l9_456;
float l9_577=l9_576*4.0;
l9_577=3.0+(((l9_577-0.0)*2.0)/5.0);
float3 l9_578=l9_575;
float l9_579=l9_577;
float3 l9_580=l9_578;
float l9_581=l9_579;
float3 l9_582=l9_580;
float l9_583=l9_581;
float3 l9_584=l9_582;
float l9_585=(*sc_set2.UserUniforms).sc_EnvmapRotation.y;
float2 l9_586=float2(0.0);
float l9_587=l9_584.x;
float l9_588=-l9_584.z;
float l9_589=(l9_587<0.0) ? (-1.0) : 1.0;
float l9_590=l9_589*acos(fast::clamp(l9_588/length(float2(l9_587,l9_588)),-1.0,1.0));
l9_586.x=l9_590-1.5707964;
l9_586.y=acos(l9_584.y);
l9_586/=float2(6.2831855,3.1415927);
l9_586.y=1.0-l9_586.y;
l9_586.x+=(l9_585/360.0);
l9_586.x=fract((l9_586.x+floor(l9_586.x))+1.0);
float2 l9_591=l9_586;
float2 l9_592=l9_591;
if (SC_DEVICE_CLASS_tmp>=2)
{
float l9_593=floor(l9_583);
float l9_594=ceil(l9_583);
float2 l9_595=l9_592;
float2 l9_596=(*sc_set2.UserUniforms).sc_EnvmapSpecularSize.xy;
float l9_597=l9_593;
float2 l9_598=l9_592;
float2 l9_599=(*sc_set2.UserUniforms).sc_EnvmapSpecularSize.xy;
float l9_600=l9_594;
}
else
{
}
}
if (N3_ClearcoatEnable)
{
N3_ClearcoatRoughness=1.0;
N3_ClearcoatNormal=float3(0.0,0.0,1.0);
if (N3_EnableClearCoatRoughnessTexture)
{
int l9_601=N3_ClearcoatRoughnessTextureCoord;
float2 l9_602=tempGlobals.Surface_UVCoord0;
float2 l9_603=l9_602;
if (l9_601==0)
{
float2 l9_604=tempGlobals.Surface_UVCoord0;
l9_603=l9_604;
}
if (l9_601==1)
{
float2 l9_605=tempGlobals.Surface_UVCoord1;
l9_603=l9_605;
}
float2 l9_606=l9_603;
float2 l9_607=l9_606;
if (N3_EnableTextureTransform&&N3_ClearcoatRoughnessTextureTransform)
{
float2 l9_608=l9_607;
float2 l9_609=N3_ClearcoatRoughnessTextureOffset;
float2 l9_610=N3_ClearcoatRoughnessTextureScale;
float l9_611=N3_ClearcoatRoughnessTextureRotation;
float l9_612=radians(l9_611);
float3x3 l9_613=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_609.x,l9_609.y,1.0));
float3x3 l9_614=float3x3(float3(cos(l9_612),sin(l9_612),0.0),float3(-sin(l9_612),cos(l9_612),0.0),float3(0.0,0.0,1.0));
float3x3 l9_615=float3x3(float3(l9_610.x,0.0,0.0),float3(0.0,l9_610.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_616=(l9_613*l9_614)*l9_615;
float2 l9_617=(l9_616*float3(l9_608,1.0)).xy;
l9_607=l9_617;
}
float2 l9_618=l9_607;
float4 l9_619=float4(0.0);
int l9_620=0;
if ((int(clearcoatRoughnessTextureHasSwappedViews_tmp)!=0))
{
int l9_621=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_621=0;
}
else
{
l9_621=in.varStereoViewID;
}
int l9_622=l9_621;
l9_620=1-l9_622;
}
else
{
int l9_623=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_623=0;
}
else
{
l9_623=in.varStereoViewID;
}
int l9_624=l9_623;
l9_620=l9_624;
}
int l9_625=l9_620;
int l9_626=clearcoatRoughnessTextureLayout_tmp;
int l9_627=l9_625;
float2 l9_628=l9_618;
bool l9_629=(int(SC_USE_UV_TRANSFORM_clearcoatRoughnessTexture_tmp)!=0);
float3x3 l9_630=(*sc_set2.UserUniforms).clearcoatRoughnessTextureTransform;
int2 l9_631=int2(SC_SOFTWARE_WRAP_MODE_U_clearcoatRoughnessTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_clearcoatRoughnessTexture_tmp);
bool l9_632=(int(SC_USE_UV_MIN_MAX_clearcoatRoughnessTexture_tmp)!=0);
float4 l9_633=(*sc_set2.UserUniforms).clearcoatRoughnessTextureUvMinMax;
bool l9_634=(int(SC_USE_CLAMP_TO_BORDER_clearcoatRoughnessTexture_tmp)!=0);
float4 l9_635=(*sc_set2.UserUniforms).clearcoatRoughnessTextureBorderColor;
float l9_636=0.0;
bool l9_637=l9_634&&(!l9_632);
float l9_638=1.0;
float l9_639=l9_628.x;
int l9_640=l9_631.x;
if (l9_640==1)
{
l9_639=fract(l9_639);
}
else
{
if (l9_640==2)
{
float l9_641=fract(l9_639);
float l9_642=l9_639-l9_641;
float l9_643=step(0.25,fract(l9_642*0.5));
l9_639=mix(l9_641,1.0-l9_641,fast::clamp(l9_643,0.0,1.0));
}
}
l9_628.x=l9_639;
float l9_644=l9_628.y;
int l9_645=l9_631.y;
if (l9_645==1)
{
l9_644=fract(l9_644);
}
else
{
if (l9_645==2)
{
float l9_646=fract(l9_644);
float l9_647=l9_644-l9_646;
float l9_648=step(0.25,fract(l9_647*0.5));
l9_644=mix(l9_646,1.0-l9_646,fast::clamp(l9_648,0.0,1.0));
}
}
l9_628.y=l9_644;
if (l9_632)
{
bool l9_649=l9_634;
bool l9_650;
if (l9_649)
{
l9_650=l9_631.x==3;
}
else
{
l9_650=l9_649;
}
float l9_651=l9_628.x;
float l9_652=l9_633.x;
float l9_653=l9_633.z;
bool l9_654=l9_650;
float l9_655=l9_638;
float l9_656=fast::clamp(l9_651,l9_652,l9_653);
float l9_657=step(abs(l9_651-l9_656),9.9999997e-06);
l9_655*=(l9_657+((1.0-float(l9_654))*(1.0-l9_657)));
l9_651=l9_656;
l9_628.x=l9_651;
l9_638=l9_655;
bool l9_658=l9_634;
bool l9_659;
if (l9_658)
{
l9_659=l9_631.y==3;
}
else
{
l9_659=l9_658;
}
float l9_660=l9_628.y;
float l9_661=l9_633.y;
float l9_662=l9_633.w;
bool l9_663=l9_659;
float l9_664=l9_638;
float l9_665=fast::clamp(l9_660,l9_661,l9_662);
float l9_666=step(abs(l9_660-l9_665),9.9999997e-06);
l9_664*=(l9_666+((1.0-float(l9_663))*(1.0-l9_666)));
l9_660=l9_665;
l9_628.y=l9_660;
l9_638=l9_664;
}
float2 l9_667=l9_628;
bool l9_668=l9_629;
float3x3 l9_669=l9_630;
if (l9_668)
{
l9_667=float2((l9_669*float3(l9_667,1.0)).xy);
}
float2 l9_670=l9_667;
float2 l9_671=l9_670;
float2 l9_672=l9_671;
l9_628=l9_672;
float l9_673=l9_628.x;
int l9_674=l9_631.x;
bool l9_675=l9_637;
float l9_676=l9_638;
if ((l9_674==0)||(l9_674==3))
{
float l9_677=l9_673;
float l9_678=0.0;
float l9_679=1.0;
bool l9_680=l9_675;
float l9_681=l9_676;
float l9_682=fast::clamp(l9_677,l9_678,l9_679);
float l9_683=step(abs(l9_677-l9_682),9.9999997e-06);
l9_681*=(l9_683+((1.0-float(l9_680))*(1.0-l9_683)));
l9_677=l9_682;
l9_673=l9_677;
l9_676=l9_681;
}
l9_628.x=l9_673;
l9_638=l9_676;
float l9_684=l9_628.y;
int l9_685=l9_631.y;
bool l9_686=l9_637;
float l9_687=l9_638;
if ((l9_685==0)||(l9_685==3))
{
float l9_688=l9_684;
float l9_689=0.0;
float l9_690=1.0;
bool l9_691=l9_686;
float l9_692=l9_687;
float l9_693=fast::clamp(l9_688,l9_689,l9_690);
float l9_694=step(abs(l9_688-l9_693),9.9999997e-06);
l9_692*=(l9_694+((1.0-float(l9_691))*(1.0-l9_694)));
l9_688=l9_693;
l9_684=l9_688;
l9_687=l9_692;
}
l9_628.y=l9_684;
l9_638=l9_687;
float2 l9_695=l9_628;
int l9_696=l9_626;
int l9_697=l9_627;
float l9_698=l9_636;
float2 l9_699=l9_695;
int l9_700=l9_696;
int l9_701=l9_697;
float3 l9_702=float3(0.0);
if (l9_700==0)
{
l9_702=float3(l9_699,0.0);
}
else
{
if (l9_700==1)
{
l9_702=float3(l9_699.x,(l9_699.y*0.5)+(0.5-(float(l9_701)*0.5)),0.0);
}
else
{
l9_702=float3(l9_699,float(l9_701));
}
}
float3 l9_703=l9_702;
float3 l9_704=l9_703;
float2 l9_705=l9_704.xy;
float l9_706=l9_698;
float4 l9_707=sc_set2.clearcoatRoughnessTexture.sample(sc_set2.clearcoatRoughnessTextureSmpSC,l9_705,bias(l9_706));
float4 l9_708=l9_707;
float4 l9_709=l9_708;
if (l9_634)
{
l9_709=mix(l9_635,l9_709,float4(l9_638));
}
float4 l9_710=l9_709;
l9_619=l9_710;
float4 l9_711=l9_619;
float l9_712=l9_711.y;
float l9_713;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_713=pow(l9_712,2.2);
}
else
{
l9_713=l9_712*l9_712;
}
float l9_714=l9_713;
N3_ClearcoatRoughness=l9_714;
}
N3_ClearcoatRoughness*=N3_ClearcoatRoughnessFactor;
if (N3_EnableClearCoatNormalTexture)
{
int l9_715=N3_ClearcoatNormalMapCoord;
float2 l9_716=tempGlobals.Surface_UVCoord0;
float2 l9_717=l9_716;
if (l9_715==0)
{
float2 l9_718=tempGlobals.Surface_UVCoord0;
l9_717=l9_718;
}
if (l9_715==1)
{
float2 l9_719=tempGlobals.Surface_UVCoord1;
l9_717=l9_719;
}
float2 l9_720=l9_717;
float2 l9_721=l9_720;
if (N3_EnableTextureTransform&&N3_ClearcoatNormalTextureTransform)
{
float2 l9_722=l9_721;
float2 l9_723=N3_ClearcoatNormalTextureOffset;
float2 l9_724=N3_ClearcoatNormalTextureScale;
float l9_725=N3_ClearcoatNormalTextureRotation;
float l9_726=radians(l9_725);
float3x3 l9_727=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_723.x,l9_723.y,1.0));
float3x3 l9_728=float3x3(float3(cos(l9_726),sin(l9_726),0.0),float3(-sin(l9_726),cos(l9_726),0.0),float3(0.0,0.0,1.0));
float3x3 l9_729=float3x3(float3(l9_724.x,0.0,0.0),float3(0.0,l9_724.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_730=(l9_727*l9_728)*l9_729;
float2 l9_731=(l9_730*float3(l9_722,1.0)).xy;
l9_721=l9_731;
}
float2 l9_732=l9_721;
float4 l9_733=float4(0.0);
int l9_734=0;
if ((int(clearcoatNormalTextureHasSwappedViews_tmp)!=0))
{
int l9_735=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_735=0;
}
else
{
l9_735=in.varStereoViewID;
}
int l9_736=l9_735;
l9_734=1-l9_736;
}
else
{
int l9_737=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_737=0;
}
else
{
l9_737=in.varStereoViewID;
}
int l9_738=l9_737;
l9_734=l9_738;
}
int l9_739=l9_734;
int l9_740=clearcoatNormalTextureLayout_tmp;
int l9_741=l9_739;
float2 l9_742=l9_732;
bool l9_743=(int(SC_USE_UV_TRANSFORM_clearcoatNormalTexture_tmp)!=0);
float3x3 l9_744=(*sc_set2.UserUniforms).clearcoatNormalTextureTransform;
int2 l9_745=int2(SC_SOFTWARE_WRAP_MODE_U_clearcoatNormalTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_clearcoatNormalTexture_tmp);
bool l9_746=(int(SC_USE_UV_MIN_MAX_clearcoatNormalTexture_tmp)!=0);
float4 l9_747=(*sc_set2.UserUniforms).clearcoatNormalTextureUvMinMax;
bool l9_748=(int(SC_USE_CLAMP_TO_BORDER_clearcoatNormalTexture_tmp)!=0);
float4 l9_749=(*sc_set2.UserUniforms).clearcoatNormalTextureBorderColor;
float l9_750=0.0;
bool l9_751=l9_748&&(!l9_746);
float l9_752=1.0;
float l9_753=l9_742.x;
int l9_754=l9_745.x;
if (l9_754==1)
{
l9_753=fract(l9_753);
}
else
{
if (l9_754==2)
{
float l9_755=fract(l9_753);
float l9_756=l9_753-l9_755;
float l9_757=step(0.25,fract(l9_756*0.5));
l9_753=mix(l9_755,1.0-l9_755,fast::clamp(l9_757,0.0,1.0));
}
}
l9_742.x=l9_753;
float l9_758=l9_742.y;
int l9_759=l9_745.y;
if (l9_759==1)
{
l9_758=fract(l9_758);
}
else
{
if (l9_759==2)
{
float l9_760=fract(l9_758);
float l9_761=l9_758-l9_760;
float l9_762=step(0.25,fract(l9_761*0.5));
l9_758=mix(l9_760,1.0-l9_760,fast::clamp(l9_762,0.0,1.0));
}
}
l9_742.y=l9_758;
if (l9_746)
{
bool l9_763=l9_748;
bool l9_764;
if (l9_763)
{
l9_764=l9_745.x==3;
}
else
{
l9_764=l9_763;
}
float l9_765=l9_742.x;
float l9_766=l9_747.x;
float l9_767=l9_747.z;
bool l9_768=l9_764;
float l9_769=l9_752;
float l9_770=fast::clamp(l9_765,l9_766,l9_767);
float l9_771=step(abs(l9_765-l9_770),9.9999997e-06);
l9_769*=(l9_771+((1.0-float(l9_768))*(1.0-l9_771)));
l9_765=l9_770;
l9_742.x=l9_765;
l9_752=l9_769;
bool l9_772=l9_748;
bool l9_773;
if (l9_772)
{
l9_773=l9_745.y==3;
}
else
{
l9_773=l9_772;
}
float l9_774=l9_742.y;
float l9_775=l9_747.y;
float l9_776=l9_747.w;
bool l9_777=l9_773;
float l9_778=l9_752;
float l9_779=fast::clamp(l9_774,l9_775,l9_776);
float l9_780=step(abs(l9_774-l9_779),9.9999997e-06);
l9_778*=(l9_780+((1.0-float(l9_777))*(1.0-l9_780)));
l9_774=l9_779;
l9_742.y=l9_774;
l9_752=l9_778;
}
float2 l9_781=l9_742;
bool l9_782=l9_743;
float3x3 l9_783=l9_744;
if (l9_782)
{
l9_781=float2((l9_783*float3(l9_781,1.0)).xy);
}
float2 l9_784=l9_781;
float2 l9_785=l9_784;
float2 l9_786=l9_785;
l9_742=l9_786;
float l9_787=l9_742.x;
int l9_788=l9_745.x;
bool l9_789=l9_751;
float l9_790=l9_752;
if ((l9_788==0)||(l9_788==3))
{
float l9_791=l9_787;
float l9_792=0.0;
float l9_793=1.0;
bool l9_794=l9_789;
float l9_795=l9_790;
float l9_796=fast::clamp(l9_791,l9_792,l9_793);
float l9_797=step(abs(l9_791-l9_796),9.9999997e-06);
l9_795*=(l9_797+((1.0-float(l9_794))*(1.0-l9_797)));
l9_791=l9_796;
l9_787=l9_791;
l9_790=l9_795;
}
l9_742.x=l9_787;
l9_752=l9_790;
float l9_798=l9_742.y;
int l9_799=l9_745.y;
bool l9_800=l9_751;
float l9_801=l9_752;
if ((l9_799==0)||(l9_799==3))
{
float l9_802=l9_798;
float l9_803=0.0;
float l9_804=1.0;
bool l9_805=l9_800;
float l9_806=l9_801;
float l9_807=fast::clamp(l9_802,l9_803,l9_804);
float l9_808=step(abs(l9_802-l9_807),9.9999997e-06);
l9_806*=(l9_808+((1.0-float(l9_805))*(1.0-l9_808)));
l9_802=l9_807;
l9_798=l9_802;
l9_801=l9_806;
}
l9_742.y=l9_798;
l9_752=l9_801;
float2 l9_809=l9_742;
int l9_810=l9_740;
int l9_811=l9_741;
float l9_812=l9_750;
float2 l9_813=l9_809;
int l9_814=l9_810;
int l9_815=l9_811;
float3 l9_816=float3(0.0);
if (l9_814==0)
{
l9_816=float3(l9_813,0.0);
}
else
{
if (l9_814==1)
{
l9_816=float3(l9_813.x,(l9_813.y*0.5)+(0.5-(float(l9_815)*0.5)),0.0);
}
else
{
l9_816=float3(l9_813,float(l9_815));
}
}
float3 l9_817=l9_816;
float3 l9_818=l9_817;
float2 l9_819=l9_818.xy;
float l9_820=l9_812;
float4 l9_821=sc_set2.clearcoatNormalTexture.sample(sc_set2.clearcoatNormalTextureSmpSC,l9_819,bias(l9_820));
float4 l9_822=l9_821;
float4 l9_823=l9_822;
if (l9_748)
{
l9_823=mix(l9_749,l9_823,float4(l9_752));
}
float4 l9_824=l9_823;
l9_733=l9_824;
float4 l9_825=l9_733;
N3_ClearcoatNormal=l9_825.xyz;
N3_ClearcoatNormal*=0.9921875;
}
}
l9_215=N3_Opacity;
l9_216=N3_Normal;
l9_217=N3_Roughness;
l9_218=N3_ClearcoatNormal;
l9_219=N3_ClearcoatRoughness;
l9_189=l9_215;
l9_190=l9_216;
l9_191=l9_217;
l9_192=l9_218;
l9_193=l9_219;
float l9_826=l9_189;
float3 l9_827=l9_190;
float l9_828=l9_191;
ssGlobals l9_829=param;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_829.BumpedNormal=l9_827;
}
l9_826=fast::clamp(l9_826,0.0,1.0);
float l9_830=l9_826;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_830<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_831=gl_FragCoord;
float2 l9_832=floor(mod(l9_831.xy,float2(4.0)));
float l9_833=(mod(dot(l9_832,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_830<l9_833)
{
discard_fragment();
}
}
float3 l9_834=l9_829.PositionWS;
float3 l9_835=l9_829.BumpedNormal;
float l9_836=l9_828;
float3 l9_837=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_834);
if (dot(l9_837,l9_835)>=(-0.050000001))
{
uint3 l9_838=uint3(round((l9_834-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_838.x,l9_838.y,l9_838.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_839=l9_835;
float l9_840=dot(abs(l9_839),float3(1.0));
l9_839/=float3(l9_840);
float l9_841=fast::clamp(-l9_839.z,0.0,1.0);
float2 l9_842=l9_839.xy;
float l9_843;
if (l9_839.x>=0.0)
{
l9_843=l9_841;
}
else
{
l9_843=-l9_841;
}
l9_842.x+=l9_843;
float l9_844;
if (l9_839.y>=0.0)
{
l9_844=l9_841;
}
else
{
l9_844=-l9_841;
}
l9_842.y+=l9_844;
float2 l9_845=l9_842;
float2 l9_846=l9_845;
uint2 l9_847=uint2(as_type<uint>(half2(float2(l9_846.x,0.0))),as_type<uint>(half2(float2(l9_846.y,0.0))));
out.normal_and_more=uint4(l9_847.x,l9_847.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_848;
if (l9_836<0.0)
{
l9_848=1023u;
}
else
{
l9_848=uint(fast::clamp(l9_836,0.0,1.0)*1000.0);
}
uint l9_849=l9_848;
l9_849 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_849;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
float l9_850=(*sc_set2.UserUniforms).Port_Opacity_N405;
float3 l9_851=l9_192;
float l9_852=l9_193;
ssGlobals l9_853=param;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_853.BumpedNormal=float3x3(float3(l9_853.VertexTangent_WorldSpace),float3(l9_853.VertexBinormal_WorldSpace),float3(l9_853.VertexNormal_WorldSpace))*l9_851;
}
float l9_854=l9_850;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_854<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_855=gl_FragCoord;
float2 l9_856=floor(mod(l9_855.xy,float2(4.0)));
float l9_857=(mod(dot(l9_856,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_854<l9_857)
{
discard_fragment();
}
}
float3 l9_858=l9_853.PositionWS;
float3 l9_859=l9_853.BumpedNormal;
float l9_860=l9_852;
float3 l9_861=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_858);
if (dot(l9_861,l9_859)>=(-0.050000001))
{
uint3 l9_862=uint3(round((l9_858-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_862.x,l9_862.y,l9_862.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_863=l9_859;
float l9_864=dot(abs(l9_863),float3(1.0));
l9_863/=float3(l9_864);
float l9_865=fast::clamp(-l9_863.z,0.0,1.0);
float2 l9_866=l9_863.xy;
float l9_867;
if (l9_863.x>=0.0)
{
l9_867=l9_865;
}
else
{
l9_867=-l9_865;
}
l9_866.x+=l9_867;
float l9_868;
if (l9_863.y>=0.0)
{
l9_868=l9_865;
}
else
{
l9_868=-l9_865;
}
l9_866.y+=l9_868;
float2 l9_869=l9_866;
float2 l9_870=l9_869;
uint2 l9_871=uint2(as_type<uint>(half2(float2(l9_870.x,0.0))),as_type<uint>(half2(float2(l9_870.y,0.0))));
out.normal_and_more=uint4(l9_871.x,l9_871.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_872;
if (l9_860<0.0)
{
l9_872=1023u;
}
else
{
l9_872=uint(fast::clamp(l9_860,0.0,1.0)*1000.0);
}
uint l9_873=l9_872;
l9_873 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_873;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
ssGlobals l9_874=param;
tempGlobals=l9_874;
}
else
{
float4 l9_875=float4(0.0);
float4 l9_876=(*sc_set2.UserUniforms).baseColorFactor;
l9_875=l9_876;
float2 l9_877=float2(0.0);
float2 l9_878=(*sc_set2.UserUniforms).baseColorTexture_offset;
l9_877=l9_878;
float2 l9_879=float2(0.0);
float2 l9_880=(*sc_set2.UserUniforms).baseColorTexture_scale;
l9_879=l9_880;
float l9_881=0.0;
float l9_882=(*sc_set2.UserUniforms).baseColorTexture_rotation;
l9_881=l9_882;
float4 l9_883=l9_875;
float2 l9_884=l9_877;
float2 l9_885=l9_879;
float l9_886=l9_881;
ssGlobals l9_887=param;
tempGlobals=l9_887;
N35_EnableVertexColor=(int(ENABLE_VERTEX_COLOR_BASE_tmp)!=0);
N35_EnableBaseTexture=(int(ENABLE_BASE_TEX_tmp)!=0);
N35_BaseColorTextureCoord=NODE_7_DROPLIST_ITEM_tmp;
N35_BaseColorFactor=l9_883;
N35_EnableTextureTransform=(int(ENABLE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureTransform=(int(ENABLE_BASE_TEXTURE_TRANSFORM_tmp)!=0);
N35_BaseTextureOffset=l9_884;
N35_BaseTextureScale=l9_885;
N35_BaseTextureRotation=l9_886;
float4 l9_888=N35_BaseColorFactor;
if (N35_EnableBaseTexture)
{
int l9_889=N35_BaseColorTextureCoord;
float2 l9_890=tempGlobals.Surface_UVCoord0;
float2 l9_891=l9_890;
if (l9_889==0)
{
float2 l9_892=tempGlobals.Surface_UVCoord0;
l9_891=l9_892;
}
if (l9_889==1)
{
float2 l9_893=tempGlobals.Surface_UVCoord1;
l9_891=l9_893;
}
float2 l9_894=l9_891;
float2 l9_895=l9_894;
if (N35_EnableTextureTransform&&N35_BaseTextureTransform)
{
float2 l9_896=l9_895;
float2 l9_897=N35_BaseTextureOffset;
float2 l9_898=N35_BaseTextureScale;
float l9_899=N35_BaseTextureRotation;
float3x3 l9_900=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(l9_897.x,l9_897.y,1.0));
float3x3 l9_901=float3x3(float3(cos(l9_899),sin(l9_899),0.0),float3(-sin(l9_899),cos(l9_899),0.0),float3(0.0,0.0,1.0));
float3x3 l9_902=float3x3(float3(l9_898.x,0.0,0.0),float3(0.0,l9_898.y,0.0),float3(0.0,0.0,1.0));
float3x3 l9_903=(l9_900*l9_901)*l9_902;
float2 l9_904=(l9_903*float3(l9_896,1.0)).xy;
l9_895=l9_904;
}
float2 l9_905=l9_895;
float4 l9_906=float4(0.0);
int l9_907=0;
if ((int(baseColorTextureHasSwappedViews_tmp)!=0))
{
int l9_908=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_908=0;
}
else
{
l9_908=in.varStereoViewID;
}
int l9_909=l9_908;
l9_907=1-l9_909;
}
else
{
int l9_910=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_910=0;
}
else
{
l9_910=in.varStereoViewID;
}
int l9_911=l9_910;
l9_907=l9_911;
}
int l9_912=l9_907;
int l9_913=baseColorTextureLayout_tmp;
int l9_914=l9_912;
float2 l9_915=l9_905;
bool l9_916=(int(SC_USE_UV_TRANSFORM_baseColorTexture_tmp)!=0);
float3x3 l9_917=(*sc_set2.UserUniforms).baseColorTextureTransform;
int2 l9_918=int2(SC_SOFTWARE_WRAP_MODE_U_baseColorTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_baseColorTexture_tmp);
bool l9_919=(int(SC_USE_UV_MIN_MAX_baseColorTexture_tmp)!=0);
float4 l9_920=(*sc_set2.UserUniforms).baseColorTextureUvMinMax;
bool l9_921=(int(SC_USE_CLAMP_TO_BORDER_baseColorTexture_tmp)!=0);
float4 l9_922=(*sc_set2.UserUniforms).baseColorTextureBorderColor;
float l9_923=0.0;
bool l9_924=l9_921&&(!l9_919);
float l9_925=1.0;
float l9_926=l9_915.x;
int l9_927=l9_918.x;
if (l9_927==1)
{
l9_926=fract(l9_926);
}
else
{
if (l9_927==2)
{
float l9_928=fract(l9_926);
float l9_929=l9_926-l9_928;
float l9_930=step(0.25,fract(l9_929*0.5));
l9_926=mix(l9_928,1.0-l9_928,fast::clamp(l9_930,0.0,1.0));
}
}
l9_915.x=l9_926;
float l9_931=l9_915.y;
int l9_932=l9_918.y;
if (l9_932==1)
{
l9_931=fract(l9_931);
}
else
{
if (l9_932==2)
{
float l9_933=fract(l9_931);
float l9_934=l9_931-l9_933;
float l9_935=step(0.25,fract(l9_934*0.5));
l9_931=mix(l9_933,1.0-l9_933,fast::clamp(l9_935,0.0,1.0));
}
}
l9_915.y=l9_931;
if (l9_919)
{
bool l9_936=l9_921;
bool l9_937;
if (l9_936)
{
l9_937=l9_918.x==3;
}
else
{
l9_937=l9_936;
}
float l9_938=l9_915.x;
float l9_939=l9_920.x;
float l9_940=l9_920.z;
bool l9_941=l9_937;
float l9_942=l9_925;
float l9_943=fast::clamp(l9_938,l9_939,l9_940);
float l9_944=step(abs(l9_938-l9_943),9.9999997e-06);
l9_942*=(l9_944+((1.0-float(l9_941))*(1.0-l9_944)));
l9_938=l9_943;
l9_915.x=l9_938;
l9_925=l9_942;
bool l9_945=l9_921;
bool l9_946;
if (l9_945)
{
l9_946=l9_918.y==3;
}
else
{
l9_946=l9_945;
}
float l9_947=l9_915.y;
float l9_948=l9_920.y;
float l9_949=l9_920.w;
bool l9_950=l9_946;
float l9_951=l9_925;
float l9_952=fast::clamp(l9_947,l9_948,l9_949);
float l9_953=step(abs(l9_947-l9_952),9.9999997e-06);
l9_951*=(l9_953+((1.0-float(l9_950))*(1.0-l9_953)));
l9_947=l9_952;
l9_915.y=l9_947;
l9_925=l9_951;
}
float2 l9_954=l9_915;
bool l9_955=l9_916;
float3x3 l9_956=l9_917;
if (l9_955)
{
l9_954=float2((l9_956*float3(l9_954,1.0)).xy);
}
float2 l9_957=l9_954;
float2 l9_958=l9_957;
float2 l9_959=l9_958;
l9_915=l9_959;
float l9_960=l9_915.x;
int l9_961=l9_918.x;
bool l9_962=l9_924;
float l9_963=l9_925;
if ((l9_961==0)||(l9_961==3))
{
float l9_964=l9_960;
float l9_965=0.0;
float l9_966=1.0;
bool l9_967=l9_962;
float l9_968=l9_963;
float l9_969=fast::clamp(l9_964,l9_965,l9_966);
float l9_970=step(abs(l9_964-l9_969),9.9999997e-06);
l9_968*=(l9_970+((1.0-float(l9_967))*(1.0-l9_970)));
l9_964=l9_969;
l9_960=l9_964;
l9_963=l9_968;
}
l9_915.x=l9_960;
l9_925=l9_963;
float l9_971=l9_915.y;
int l9_972=l9_918.y;
bool l9_973=l9_924;
float l9_974=l9_925;
if ((l9_972==0)||(l9_972==3))
{
float l9_975=l9_971;
float l9_976=0.0;
float l9_977=1.0;
bool l9_978=l9_973;
float l9_979=l9_974;
float l9_980=fast::clamp(l9_975,l9_976,l9_977);
float l9_981=step(abs(l9_975-l9_980),9.9999997e-06);
l9_979*=(l9_981+((1.0-float(l9_978))*(1.0-l9_981)));
l9_975=l9_980;
l9_971=l9_975;
l9_974=l9_979;
}
l9_915.y=l9_971;
l9_925=l9_974;
float2 l9_982=l9_915;
int l9_983=l9_913;
int l9_984=l9_914;
float l9_985=l9_923;
float2 l9_986=l9_982;
int l9_987=l9_983;
int l9_988=l9_984;
float3 l9_989=float3(0.0);
if (l9_987==0)
{
l9_989=float3(l9_986,0.0);
}
else
{
if (l9_987==1)
{
l9_989=float3(l9_986.x,(l9_986.y*0.5)+(0.5-(float(l9_988)*0.5)),0.0);
}
else
{
l9_989=float3(l9_986,float(l9_988));
}
}
float3 l9_990=l9_989;
float3 l9_991=l9_990;
float2 l9_992=l9_991.xy;
float l9_993=l9_985;
float4 l9_994=sc_set2.baseColorTexture.sample(sc_set2.baseColorTextureSmpSC,l9_992,bias(l9_993));
float4 l9_995=l9_994;
float4 l9_996=l9_995;
if (l9_921)
{
l9_996=mix(l9_922,l9_996,float4(l9_925));
}
float4 l9_997=l9_996;
l9_906=l9_997;
float4 l9_998=l9_906;
float4 l9_999=l9_998;
float4 l9_1000;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1000=float4(pow(l9_999.x,2.2),pow(l9_999.y,2.2),pow(l9_999.z,2.2),pow(l9_999.w,2.2));
}
else
{
l9_1000=l9_999*l9_999;
}
float4 l9_1001=l9_1000;
l9_888*=l9_1001;
}
if (N35_EnableVertexColor)
{
float4 l9_1002=tempGlobals.VertexColor;
l9_888*=l9_1002;
}
N35_Opacity=l9_888.w;
}
return out;
}
} // RECEIVER MODE SHADER
