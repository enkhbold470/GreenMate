#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_FLAG_IS_NORMAL_MAP detailNormalTex
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
//sampler sampler baseTexSmpSC 2:29
//sampler sampler detailNormalTexSmpSC 2:30
//sampler sampler emissiveTexSmpSC 2:31
//sampler sampler intensityTextureSmpSC 2:32
//sampler sampler normalTexSmpSC 2:33
//sampler sampler opacityTexSmpSC 2:34
//sampler sampler reflectionModulationTexSmpSC 2:35
//sampler sampler reflectionTexSmpSC 2:36
//sampler sampler rimColorTexSmpSC 2:37
//sampler sampler sc_ScreenTextureSmpSC 2:42
//sampler sampler z_hitIdAndBarycentricSmp 2:45
//sampler sampler z_rayDirectionsSmpSC 2:46
//texture texture2D baseTex 2:4:2:29
//texture texture2D detailNormalTex 2:5:2:30
//texture texture2D emissiveTex 2:6:2:31
//texture texture2D intensityTexture 2:7:2:32
//texture texture2D normalTex 2:8:2:33
//texture texture2D opacityTex 2:9:2:34
//texture texture2D reflectionModulationTex 2:10:2:35
//texture texture2D reflectionTex 2:11:2:36
//texture texture2D rimColorTex 2:12:2:37
//texture texture2D sc_ScreenTexture 2:24:2:42
//texture utexture2D z_hitIdAndBarycentric 2:27:2:45
//texture texture2D z_rayDirections 2:28:2:46
//ubo float sc_BonesUBO 2:3:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:47:6096 {
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
//bool isProxyMode 3744
//int instance_id 3748
//int lray_triangles_last 3752
//bool noEarlyZ 3756
//bool has_animated_pn 3760
//int emitter_stride 3764
//int proxy_offset_position 3768
//int proxy_offset_normal 3772
//int proxy_offset_tangent 3776
//int proxy_offset_color 3780
//int proxy_offset_texture0 3784
//int proxy_offset_texture1 3788
//int proxy_offset_texture2 3792
//int proxy_offset_texture3 3796
//int proxy_format_position 3800
//int proxy_format_normal 3804
//int proxy_format_tangent 3808
//int proxy_format_color 3812
//int proxy_format_texture0 3816
//int proxy_format_texture1 3820
//int proxy_format_texture2 3824
//int proxy_format_texture3 3828
//float4 z_rayDirectionsSize 3840
//float4 z_rayDirectionsDims 3856
//float4 z_rayDirectionsView 3872
//float correctedIntensity 3888
//float4 intensityTextureSize 3904
//float4 intensityTextureDims 3920
//float4 intensityTextureView 3936
//float3x3 intensityTextureTransform 3952
//float4 intensityTextureUvMinMax 4000
//float4 intensityTextureBorderColor 4016
//float reflBlurWidth 4032
//float reflBlurMinRough 4036
//float reflBlurMaxRough 4040
//int overrideTimeEnabled 4044
//float overrideTimeElapsed 4048
//float overrideTimeDelta 4052
//int PreviewEnabled 4056
//int PreviewNodeID 4060
//float alphaTestThreshold 4064
//float3 recolorRed 4080
//float4 baseColor 4096
//float4 baseTexSize 4112
//float4 baseTexDims 4128
//float4 baseTexView 4144
//float3x3 baseTexTransform 4160
//float4 baseTexUvMinMax 4208
//float4 baseTexBorderColor 4224
//float2 uv2Scale 4240
//float2 uv2Offset 4248
//float2 uv3Scale 4256
//float2 uv3Offset 4264
//float3 recolorGreen 4272
//float3 recolorBlue 4288
//float4 emissiveTexSize 4304
//float4 emissiveTexDims 4320
//float4 emissiveTexView 4336
//float3x3 emissiveTexTransform 4352
//float4 emissiveTexUvMinMax 4400
//float4 emissiveTexBorderColor 4416
//float3 emissiveColor 4432
//float emissiveIntensity 4448
//float reflectionIntensity 4452
//float4 reflectionTexSize 4464
//float4 reflectionTexDims 4480
//float4 reflectionTexView 4496
//float3x3 reflectionTexTransform 4512
//float4 reflectionTexUvMinMax 4560
//float4 reflectionTexBorderColor 4576
//float4 normalTexSize 4592
//float4 normalTexDims 4608
//float4 normalTexView 4624
//float3x3 normalTexTransform 4640
//float4 normalTexUvMinMax 4688
//float4 normalTexBorderColor 4704
//float4 detailNormalTexSize 4720
//float4 detailNormalTexDims 4736
//float4 detailNormalTexView 4752
//float3x3 detailNormalTexTransform 4768
//float4 detailNormalTexUvMinMax 4816
//float4 detailNormalTexBorderColor 4832
//float4 reflectionModulationTexSize 4848
//float4 reflectionModulationTexDims 4864
//float4 reflectionModulationTexView 4880
//float3x3 reflectionModulationTexTransform 4896
//float4 reflectionModulationTexUvMinMax 4944
//float4 reflectionModulationTexBorderColor 4960
//float3 rimColor 4976
//float rimIntensity 4992
//float4 rimColorTexSize 5008
//float4 rimColorTexDims 5024
//float4 rimColorTexView 5040
//float3x3 rimColorTexTransform 5056
//float4 rimColorTexUvMinMax 5104
//float4 rimColorTexBorderColor 5120
//float rimExponent 5136
//float4 opacityTexSize 5152
//float4 opacityTexDims 5168
//float4 opacityTexView 5184
//float3x3 opacityTexTransform 5200
//float4 opacityTexUvMinMax 5248
//float4 opacityTexBorderColor 5264
//float4 Port_Import_N042 5280
//float Port_Input1_N044 5296
//float Port_Import_N088 5300
//float3 Port_Import_N089 5312
//float4 Port_Import_N384 5328
//float Port_Import_N307 5344
//float Port_Import_N201 5348
//float Port_Import_N012 5352
//float Port_Import_N010 5356
//float Port_Import_N007 5360
//float2 Port_Import_N008 5368
//float2 Port_Import_N009 5376
//float Port_Speed_N022 5384
//float2 Port_Import_N254 5392
//float Port_Import_N065 5400
//float Port_Import_N055 5404
//float Port_Import_N056 5408
//float2 Port_Import_N000 5416
//float2 Port_Import_N060 5424
//float2 Port_Import_N061 5432
//float Port_Speed_N063 5440
//float2 Port_Import_N255 5448
//float4 Port_Default_N369 5456
//float4 Port_Import_N092 5472
//float3 Port_Import_N090 5488
//float3 Port_Import_N091 5504
//float3 Port_Import_N144 5520
//float Port_Value2_N073 5536
//float Port_Import_N273 5540
//float Port_Input1_N274 5544
//float Port_Import_N131 5548
//float Port_Import_N116 5552
//float2 Port_Import_N120 5560
//float2 Port_Import_N127 5568
//float3 Port_Default_N132 5584
//float3 Port_Import_N295 5600
//float Port_Import_N296 5616
//float3 Port_Default_N097 5632
//float Port_Import_N133 5648
//float Port_Import_N231 5652
//float Port_Import_N336 5656
//float Port_Import_N160 5660
//float2 Port_Import_N167 5664
//float2 Port_Import_N207 5672
//float Port_Strength1_N200 5680
//float Port_Import_N095 5684
//float Port_Import_N108 5688
//float3 Port_Default_N113 5696
//float Port_Strength2_N200 5712
//float3 Port_Import_N327 5728
//float3 Port_Input1_N257 5744
//float3 Port_Import_N259 5760
//float Port_Input1_N264 5776
//float Port_Input1_N268 5780
//float Port_Input1_N270 5784
//float Port_Import_N123 5788
//float Port_Import_N025 5792
//float2 Port_Import_N030 5800
//float2 Port_Import_N031 5808
//float3 Port_Default_N041 5824
//float3 Port_Default_N134 5840
//float3 Port_Import_N298 5856
//float Port_Import_N172 5872
//float3 Port_Import_N318 5888
//float Port_Import_N319 5904
//float Port_Import_N171 5908
//float Port_Import_N135 5912
//float2 Port_Import_N150 5920
//float2 Port_Import_N152 5928
//float3 Port_Default_N170 5936
//float Port_Import_N339 5952
//float3 Port_Import_N328 5968
//float Port_Import_N340 5984
//float3 Port_Default_N173 6000
//float3 Port_Import_N306 6016
//float4 Port_Import_N166 6032
//float Port_Import_N206 6048
//float Port_Import_N043 6052
//float2 Port_Import_N151 6056
//float2 Port_Import_N155 6064
//float Port_Default_N204 6072
//float Port_Import_N047 6076
//float Port_Input1_N036 6080
//float Port_Input2_N072 6084
//float depthRef 6088
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
//spec_const bool ENABLE_BASE_TEX 1030
//spec_const bool ENABLE_DETAIL_NORMAL 1031
//spec_const bool ENABLE_EMISSIVE 1032
//spec_const bool ENABLE_NORMALMAP 1033
//spec_const bool ENABLE_OPACITY_TEX 1034
//spec_const bool ENABLE_RECOLOR 1035
//spec_const bool ENABLE_REFLECTION_MODULATION_TEX 1036
//spec_const bool ENABLE_RIM_COLOR_TEX 1037
//spec_const bool ENABLE_RIM_HIGHLIGHT 1038
//spec_const bool ENABLE_RIM_INVERT 1039
//spec_const bool ENABLE_STIPPLE_PATTERN_TEST 1040
//spec_const bool ENABLE_UV2_ANIMATION 1041
//spec_const bool ENABLE_UV2 1042
//spec_const bool ENABLE_UV3_ANIMATION 1043
//spec_const bool ENABLE_UV3 1044
//spec_const bool SC_USE_CLAMP_TO_BORDER_baseTex 1045
//spec_const bool SC_USE_CLAMP_TO_BORDER_detailNormalTex 1046
//spec_const bool SC_USE_CLAMP_TO_BORDER_emissiveTex 1047
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 1048
//spec_const bool SC_USE_CLAMP_TO_BORDER_normalTex 1049
//spec_const bool SC_USE_CLAMP_TO_BORDER_opacityTex 1050
//spec_const bool SC_USE_CLAMP_TO_BORDER_reflectionModulationTex 1051
//spec_const bool SC_USE_CLAMP_TO_BORDER_reflectionTex 1052
//spec_const bool SC_USE_CLAMP_TO_BORDER_rimColorTex 1053
//spec_const bool SC_USE_UV_MIN_MAX_baseTex 1054
//spec_const bool SC_USE_UV_MIN_MAX_detailNormalTex 1055
//spec_const bool SC_USE_UV_MIN_MAX_emissiveTex 1056
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 1057
//spec_const bool SC_USE_UV_MIN_MAX_normalTex 1058
//spec_const bool SC_USE_UV_MIN_MAX_opacityTex 1059
//spec_const bool SC_USE_UV_MIN_MAX_reflectionModulationTex 1060
//spec_const bool SC_USE_UV_MIN_MAX_reflectionTex 1061
//spec_const bool SC_USE_UV_MIN_MAX_rimColorTex 1062
//spec_const bool SC_USE_UV_TRANSFORM_baseTex 1063
//spec_const bool SC_USE_UV_TRANSFORM_detailNormalTex 1064
//spec_const bool SC_USE_UV_TRANSFORM_emissiveTex 1065
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 1066
//spec_const bool SC_USE_UV_TRANSFORM_normalTex 1067
//spec_const bool SC_USE_UV_TRANSFORM_opacityTex 1068
//spec_const bool SC_USE_UV_TRANSFORM_reflectionModulationTex 1069
//spec_const bool SC_USE_UV_TRANSFORM_reflectionTex 1070
//spec_const bool SC_USE_UV_TRANSFORM_rimColorTex 1071
//spec_const bool Tweak_N179 1072
//spec_const bool UseViewSpaceDepthVariant 1073
//spec_const bool baseTexHasSwappedViews 1074
//spec_const bool detailNormalTexHasSwappedViews 1075
//spec_const bool emissiveTexHasSwappedViews 1076
//spec_const bool intensityTextureHasSwappedViews 1077
//spec_const bool normalTexHasSwappedViews 1078
//spec_const bool opacityTexHasSwappedViews 1079
//spec_const bool reflectionModulationTexHasSwappedViews 1080
//spec_const bool reflectionTexHasSwappedViews 1081
//spec_const bool rimColorTexHasSwappedViews 1082
//spec_const bool sc_BlendMode_AddWithAlphaFactor 1083
//spec_const bool sc_BlendMode_Add 1084
//spec_const bool sc_BlendMode_AlphaTest 1085
//spec_const bool sc_BlendMode_AlphaToCoverage 1086
//spec_const bool sc_BlendMode_ColoredGlass 1087
//spec_const bool sc_BlendMode_Custom 1088
//spec_const bool sc_BlendMode_Max 1089
//spec_const bool sc_BlendMode_Min 1090
//spec_const bool sc_BlendMode_MultiplyOriginal 1091
//spec_const bool sc_BlendMode_Multiply 1092
//spec_const bool sc_BlendMode_Normal 1093
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 1094
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 1095
//spec_const bool sc_BlendMode_PremultipliedAlpha 1096
//spec_const bool sc_BlendMode_Screen 1097
//spec_const bool sc_DepthOnly 1098
//spec_const bool sc_FramebufferFetch 1099
//spec_const bool sc_MotionVectorsPass 1100
//spec_const bool sc_OITCompositingPass 1101
//spec_const bool sc_OITDepthBoundsPass 1102
//spec_const bool sc_OITDepthGatherPass 1103
//spec_const bool sc_ProjectiveShadowsCaster 1104
//spec_const bool sc_ProjectiveShadowsReceiver 1105
//spec_const bool sc_ProxyAlphaOne 1106
//spec_const bool sc_RenderAlphaToColor 1107
//spec_const bool sc_ScreenTextureHasSwappedViews 1108
//spec_const bool sc_ShaderComplexityAnalyzer 1109
//spec_const bool sc_UseFramebufferFetchMarker 1110
//spec_const bool sc_VertexBlendingUseNormals 1111
//spec_const bool sc_VertexBlending 1112
//spec_const int NODE_13_DROPLIST_ITEM 1113
//spec_const int NODE_181_DROPLIST_ITEM 1114
//spec_const int NODE_184_DROPLIST_ITEM 1115
//spec_const int NODE_228_DROPLIST_ITEM 1116
//spec_const int NODE_27_DROPLIST_ITEM 1117
//spec_const int NODE_315_DROPLIST_ITEM 1118
//spec_const int NODE_38_DROPLIST_ITEM 1119
//spec_const int NODE_49_DROPLIST_ITEM 1120
//spec_const int NODE_69_DROPLIST_ITEM 1121
//spec_const int NODE_76_DROPLIST_ITEM 1122
//spec_const int SC_DEVICE_CLASS 1123
//spec_const int SC_SOFTWARE_WRAP_MODE_U_baseTex 1124
//spec_const int SC_SOFTWARE_WRAP_MODE_U_detailNormalTex 1125
//spec_const int SC_SOFTWARE_WRAP_MODE_U_emissiveTex 1126
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 1127
//spec_const int SC_SOFTWARE_WRAP_MODE_U_normalTex 1128
//spec_const int SC_SOFTWARE_WRAP_MODE_U_opacityTex 1129
//spec_const int SC_SOFTWARE_WRAP_MODE_U_reflectionModulationTex 1130
//spec_const int SC_SOFTWARE_WRAP_MODE_U_reflectionTex 1131
//spec_const int SC_SOFTWARE_WRAP_MODE_U_rimColorTex 1132
//spec_const int SC_SOFTWARE_WRAP_MODE_V_baseTex 1133
//spec_const int SC_SOFTWARE_WRAP_MODE_V_detailNormalTex 1134
//spec_const int SC_SOFTWARE_WRAP_MODE_V_emissiveTex 1135
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 1136
//spec_const int SC_SOFTWARE_WRAP_MODE_V_normalTex 1137
//spec_const int SC_SOFTWARE_WRAP_MODE_V_opacityTex 1138
//spec_const int SC_SOFTWARE_WRAP_MODE_V_reflectionModulationTex 1139
//spec_const int SC_SOFTWARE_WRAP_MODE_V_reflectionTex 1140
//spec_const int SC_SOFTWARE_WRAP_MODE_V_rimColorTex 1141
//spec_const int baseTexLayout 1142
//spec_const int detailNormalTexLayout 1143
//spec_const int emissiveTexLayout 1144
//spec_const int intensityTextureLayout 1145
//spec_const int normalTexLayout 1146
//spec_const int opacityTexLayout 1147
//spec_const int reflectionModulationTexLayout 1148
//spec_const int reflectionTexLayout 1149
//spec_const int rimColorTexLayout 1150
//spec_const int sc_DepthBufferMode 1151
//spec_const int sc_RenderingSpace 1152
//spec_const int sc_ScreenTextureLayout 1153
//spec_const int sc_SkinBonesCount 1154
//spec_const int sc_StereoRenderingMode 1155
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1156
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
constant bool ENABLE_BASE_TEX [[function_constant(1030)]];
constant bool ENABLE_BASE_TEX_tmp = is_function_constant_defined(ENABLE_BASE_TEX) ? ENABLE_BASE_TEX : false;
constant bool ENABLE_DETAIL_NORMAL [[function_constant(1031)]];
constant bool ENABLE_DETAIL_NORMAL_tmp = is_function_constant_defined(ENABLE_DETAIL_NORMAL) ? ENABLE_DETAIL_NORMAL : false;
constant bool ENABLE_EMISSIVE [[function_constant(1032)]];
constant bool ENABLE_EMISSIVE_tmp = is_function_constant_defined(ENABLE_EMISSIVE) ? ENABLE_EMISSIVE : false;
constant bool ENABLE_NORMALMAP [[function_constant(1033)]];
constant bool ENABLE_NORMALMAP_tmp = is_function_constant_defined(ENABLE_NORMALMAP) ? ENABLE_NORMALMAP : false;
constant bool ENABLE_OPACITY_TEX [[function_constant(1034)]];
constant bool ENABLE_OPACITY_TEX_tmp = is_function_constant_defined(ENABLE_OPACITY_TEX) ? ENABLE_OPACITY_TEX : false;
constant bool ENABLE_RECOLOR [[function_constant(1035)]];
constant bool ENABLE_RECOLOR_tmp = is_function_constant_defined(ENABLE_RECOLOR) ? ENABLE_RECOLOR : false;
constant bool ENABLE_REFLECTION_MODULATION_TEX [[function_constant(1036)]];
constant bool ENABLE_REFLECTION_MODULATION_TEX_tmp = is_function_constant_defined(ENABLE_REFLECTION_MODULATION_TEX) ? ENABLE_REFLECTION_MODULATION_TEX : false;
constant bool ENABLE_RIM_COLOR_TEX [[function_constant(1037)]];
constant bool ENABLE_RIM_COLOR_TEX_tmp = is_function_constant_defined(ENABLE_RIM_COLOR_TEX) ? ENABLE_RIM_COLOR_TEX : false;
constant bool ENABLE_RIM_HIGHLIGHT [[function_constant(1038)]];
constant bool ENABLE_RIM_HIGHLIGHT_tmp = is_function_constant_defined(ENABLE_RIM_HIGHLIGHT) ? ENABLE_RIM_HIGHLIGHT : false;
constant bool ENABLE_RIM_INVERT [[function_constant(1039)]];
constant bool ENABLE_RIM_INVERT_tmp = is_function_constant_defined(ENABLE_RIM_INVERT) ? ENABLE_RIM_INVERT : false;
constant bool ENABLE_STIPPLE_PATTERN_TEST [[function_constant(1040)]];
constant bool ENABLE_STIPPLE_PATTERN_TEST_tmp = is_function_constant_defined(ENABLE_STIPPLE_PATTERN_TEST) ? ENABLE_STIPPLE_PATTERN_TEST : false;
constant bool ENABLE_UV2_ANIMATION [[function_constant(1041)]];
constant bool ENABLE_UV2_ANIMATION_tmp = is_function_constant_defined(ENABLE_UV2_ANIMATION) ? ENABLE_UV2_ANIMATION : false;
constant bool ENABLE_UV2 [[function_constant(1042)]];
constant bool ENABLE_UV2_tmp = is_function_constant_defined(ENABLE_UV2) ? ENABLE_UV2 : false;
constant bool ENABLE_UV3_ANIMATION [[function_constant(1043)]];
constant bool ENABLE_UV3_ANIMATION_tmp = is_function_constant_defined(ENABLE_UV3_ANIMATION) ? ENABLE_UV3_ANIMATION : false;
constant bool ENABLE_UV3 [[function_constant(1044)]];
constant bool ENABLE_UV3_tmp = is_function_constant_defined(ENABLE_UV3) ? ENABLE_UV3 : false;
constant bool SC_USE_CLAMP_TO_BORDER_baseTex [[function_constant(1045)]];
constant bool SC_USE_CLAMP_TO_BORDER_baseTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_baseTex) ? SC_USE_CLAMP_TO_BORDER_baseTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_detailNormalTex [[function_constant(1046)]];
constant bool SC_USE_CLAMP_TO_BORDER_detailNormalTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_detailNormalTex) ? SC_USE_CLAMP_TO_BORDER_detailNormalTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_emissiveTex [[function_constant(1047)]];
constant bool SC_USE_CLAMP_TO_BORDER_emissiveTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_emissiveTex) ? SC_USE_CLAMP_TO_BORDER_emissiveTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(1048)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_normalTex [[function_constant(1049)]];
constant bool SC_USE_CLAMP_TO_BORDER_normalTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_normalTex) ? SC_USE_CLAMP_TO_BORDER_normalTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_opacityTex [[function_constant(1050)]];
constant bool SC_USE_CLAMP_TO_BORDER_opacityTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_opacityTex) ? SC_USE_CLAMP_TO_BORDER_opacityTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_reflectionModulationTex [[function_constant(1051)]];
constant bool SC_USE_CLAMP_TO_BORDER_reflectionModulationTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_reflectionModulationTex) ? SC_USE_CLAMP_TO_BORDER_reflectionModulationTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_reflectionTex [[function_constant(1052)]];
constant bool SC_USE_CLAMP_TO_BORDER_reflectionTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_reflectionTex) ? SC_USE_CLAMP_TO_BORDER_reflectionTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_rimColorTex [[function_constant(1053)]];
constant bool SC_USE_CLAMP_TO_BORDER_rimColorTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_rimColorTex) ? SC_USE_CLAMP_TO_BORDER_rimColorTex : false;
constant bool SC_USE_UV_MIN_MAX_baseTex [[function_constant(1054)]];
constant bool SC_USE_UV_MIN_MAX_baseTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_baseTex) ? SC_USE_UV_MIN_MAX_baseTex : false;
constant bool SC_USE_UV_MIN_MAX_detailNormalTex [[function_constant(1055)]];
constant bool SC_USE_UV_MIN_MAX_detailNormalTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_detailNormalTex) ? SC_USE_UV_MIN_MAX_detailNormalTex : false;
constant bool SC_USE_UV_MIN_MAX_emissiveTex [[function_constant(1056)]];
constant bool SC_USE_UV_MIN_MAX_emissiveTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_emissiveTex) ? SC_USE_UV_MIN_MAX_emissiveTex : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(1057)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_normalTex [[function_constant(1058)]];
constant bool SC_USE_UV_MIN_MAX_normalTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_normalTex) ? SC_USE_UV_MIN_MAX_normalTex : false;
constant bool SC_USE_UV_MIN_MAX_opacityTex [[function_constant(1059)]];
constant bool SC_USE_UV_MIN_MAX_opacityTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_opacityTex) ? SC_USE_UV_MIN_MAX_opacityTex : false;
constant bool SC_USE_UV_MIN_MAX_reflectionModulationTex [[function_constant(1060)]];
constant bool SC_USE_UV_MIN_MAX_reflectionModulationTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_reflectionModulationTex) ? SC_USE_UV_MIN_MAX_reflectionModulationTex : false;
constant bool SC_USE_UV_MIN_MAX_reflectionTex [[function_constant(1061)]];
constant bool SC_USE_UV_MIN_MAX_reflectionTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_reflectionTex) ? SC_USE_UV_MIN_MAX_reflectionTex : false;
constant bool SC_USE_UV_MIN_MAX_rimColorTex [[function_constant(1062)]];
constant bool SC_USE_UV_MIN_MAX_rimColorTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_rimColorTex) ? SC_USE_UV_MIN_MAX_rimColorTex : false;
constant bool SC_USE_UV_TRANSFORM_baseTex [[function_constant(1063)]];
constant bool SC_USE_UV_TRANSFORM_baseTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_baseTex) ? SC_USE_UV_TRANSFORM_baseTex : false;
constant bool SC_USE_UV_TRANSFORM_detailNormalTex [[function_constant(1064)]];
constant bool SC_USE_UV_TRANSFORM_detailNormalTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_detailNormalTex) ? SC_USE_UV_TRANSFORM_detailNormalTex : false;
constant bool SC_USE_UV_TRANSFORM_emissiveTex [[function_constant(1065)]];
constant bool SC_USE_UV_TRANSFORM_emissiveTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_emissiveTex) ? SC_USE_UV_TRANSFORM_emissiveTex : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(1066)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_normalTex [[function_constant(1067)]];
constant bool SC_USE_UV_TRANSFORM_normalTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_normalTex) ? SC_USE_UV_TRANSFORM_normalTex : false;
constant bool SC_USE_UV_TRANSFORM_opacityTex [[function_constant(1068)]];
constant bool SC_USE_UV_TRANSFORM_opacityTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_opacityTex) ? SC_USE_UV_TRANSFORM_opacityTex : false;
constant bool SC_USE_UV_TRANSFORM_reflectionModulationTex [[function_constant(1069)]];
constant bool SC_USE_UV_TRANSFORM_reflectionModulationTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_reflectionModulationTex) ? SC_USE_UV_TRANSFORM_reflectionModulationTex : false;
constant bool SC_USE_UV_TRANSFORM_reflectionTex [[function_constant(1070)]];
constant bool SC_USE_UV_TRANSFORM_reflectionTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_reflectionTex) ? SC_USE_UV_TRANSFORM_reflectionTex : false;
constant bool SC_USE_UV_TRANSFORM_rimColorTex [[function_constant(1071)]];
constant bool SC_USE_UV_TRANSFORM_rimColorTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_rimColorTex) ? SC_USE_UV_TRANSFORM_rimColorTex : false;
constant bool Tweak_N179 [[function_constant(1072)]];
constant bool Tweak_N179_tmp = is_function_constant_defined(Tweak_N179) ? Tweak_N179 : false;
constant bool UseViewSpaceDepthVariant [[function_constant(1073)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool baseTexHasSwappedViews [[function_constant(1074)]];
constant bool baseTexHasSwappedViews_tmp = is_function_constant_defined(baseTexHasSwappedViews) ? baseTexHasSwappedViews : false;
constant bool detailNormalTexHasSwappedViews [[function_constant(1075)]];
constant bool detailNormalTexHasSwappedViews_tmp = is_function_constant_defined(detailNormalTexHasSwappedViews) ? detailNormalTexHasSwappedViews : false;
constant bool emissiveTexHasSwappedViews [[function_constant(1076)]];
constant bool emissiveTexHasSwappedViews_tmp = is_function_constant_defined(emissiveTexHasSwappedViews) ? emissiveTexHasSwappedViews : false;
constant bool intensityTextureHasSwappedViews [[function_constant(1077)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool normalTexHasSwappedViews [[function_constant(1078)]];
constant bool normalTexHasSwappedViews_tmp = is_function_constant_defined(normalTexHasSwappedViews) ? normalTexHasSwappedViews : false;
constant bool opacityTexHasSwappedViews [[function_constant(1079)]];
constant bool opacityTexHasSwappedViews_tmp = is_function_constant_defined(opacityTexHasSwappedViews) ? opacityTexHasSwappedViews : false;
constant bool reflectionModulationTexHasSwappedViews [[function_constant(1080)]];
constant bool reflectionModulationTexHasSwappedViews_tmp = is_function_constant_defined(reflectionModulationTexHasSwappedViews) ? reflectionModulationTexHasSwappedViews : false;
constant bool reflectionTexHasSwappedViews [[function_constant(1081)]];
constant bool reflectionTexHasSwappedViews_tmp = is_function_constant_defined(reflectionTexHasSwappedViews) ? reflectionTexHasSwappedViews : false;
constant bool rimColorTexHasSwappedViews [[function_constant(1082)]];
constant bool rimColorTexHasSwappedViews_tmp = is_function_constant_defined(rimColorTexHasSwappedViews) ? rimColorTexHasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(1083)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(1084)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(1085)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(1086)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(1087)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(1088)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(1089)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(1090)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(1091)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(1092)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(1093)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(1094)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(1095)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(1096)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(1097)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_DepthOnly [[function_constant(1098)]];
constant bool sc_DepthOnly_tmp = is_function_constant_defined(sc_DepthOnly) ? sc_DepthOnly : false;
constant bool sc_FramebufferFetch [[function_constant(1099)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_MotionVectorsPass [[function_constant(1100)]];
constant bool sc_MotionVectorsPass_tmp = is_function_constant_defined(sc_MotionVectorsPass) ? sc_MotionVectorsPass : false;
constant bool sc_OITCompositingPass [[function_constant(1101)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(1102)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(1103)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(1104)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_ProjectiveShadowsReceiver [[function_constant(1105)]];
constant bool sc_ProjectiveShadowsReceiver_tmp = is_function_constant_defined(sc_ProjectiveShadowsReceiver) ? sc_ProjectiveShadowsReceiver : false;
constant bool sc_ProxyAlphaOne [[function_constant(1106)]];
constant bool sc_ProxyAlphaOne_tmp = is_function_constant_defined(sc_ProxyAlphaOne) ? sc_ProxyAlphaOne : false;
constant bool sc_RenderAlphaToColor [[function_constant(1107)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(1108)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(1109)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(1110)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant bool sc_VertexBlendingUseNormals [[function_constant(1111)]];
constant bool sc_VertexBlendingUseNormals_tmp = is_function_constant_defined(sc_VertexBlendingUseNormals) ? sc_VertexBlendingUseNormals : false;
constant bool sc_VertexBlending [[function_constant(1112)]];
constant bool sc_VertexBlending_tmp = is_function_constant_defined(sc_VertexBlending) ? sc_VertexBlending : false;
constant int NODE_13_DROPLIST_ITEM [[function_constant(1113)]];
constant int NODE_13_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_13_DROPLIST_ITEM) ? NODE_13_DROPLIST_ITEM : 0;
constant int NODE_181_DROPLIST_ITEM [[function_constant(1114)]];
constant int NODE_181_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_181_DROPLIST_ITEM) ? NODE_181_DROPLIST_ITEM : 0;
constant int NODE_184_DROPLIST_ITEM [[function_constant(1115)]];
constant int NODE_184_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_184_DROPLIST_ITEM) ? NODE_184_DROPLIST_ITEM : 0;
constant int NODE_228_DROPLIST_ITEM [[function_constant(1116)]];
constant int NODE_228_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_228_DROPLIST_ITEM) ? NODE_228_DROPLIST_ITEM : 0;
constant int NODE_27_DROPLIST_ITEM [[function_constant(1117)]];
constant int NODE_27_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_27_DROPLIST_ITEM) ? NODE_27_DROPLIST_ITEM : 0;
constant int NODE_315_DROPLIST_ITEM [[function_constant(1118)]];
constant int NODE_315_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_315_DROPLIST_ITEM) ? NODE_315_DROPLIST_ITEM : 0;
constant int NODE_38_DROPLIST_ITEM [[function_constant(1119)]];
constant int NODE_38_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_38_DROPLIST_ITEM) ? NODE_38_DROPLIST_ITEM : 0;
constant int NODE_49_DROPLIST_ITEM [[function_constant(1120)]];
constant int NODE_49_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_49_DROPLIST_ITEM) ? NODE_49_DROPLIST_ITEM : 0;
constant int NODE_69_DROPLIST_ITEM [[function_constant(1121)]];
constant int NODE_69_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_69_DROPLIST_ITEM) ? NODE_69_DROPLIST_ITEM : 0;
constant int NODE_76_DROPLIST_ITEM [[function_constant(1122)]];
constant int NODE_76_DROPLIST_ITEM_tmp = is_function_constant_defined(NODE_76_DROPLIST_ITEM) ? NODE_76_DROPLIST_ITEM : 0;
constant int SC_DEVICE_CLASS [[function_constant(1123)]];
constant int SC_DEVICE_CLASS_tmp = is_function_constant_defined(SC_DEVICE_CLASS) ? SC_DEVICE_CLASS : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_baseTex [[function_constant(1124)]];
constant int SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_baseTex) ? SC_SOFTWARE_WRAP_MODE_U_baseTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_detailNormalTex [[function_constant(1125)]];
constant int SC_SOFTWARE_WRAP_MODE_U_detailNormalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_detailNormalTex) ? SC_SOFTWARE_WRAP_MODE_U_detailNormalTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_emissiveTex [[function_constant(1126)]];
constant int SC_SOFTWARE_WRAP_MODE_U_emissiveTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_emissiveTex) ? SC_SOFTWARE_WRAP_MODE_U_emissiveTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(1127)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_normalTex [[function_constant(1128)]];
constant int SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_normalTex) ? SC_SOFTWARE_WRAP_MODE_U_normalTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_opacityTex [[function_constant(1129)]];
constant int SC_SOFTWARE_WRAP_MODE_U_opacityTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_opacityTex) ? SC_SOFTWARE_WRAP_MODE_U_opacityTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_reflectionModulationTex [[function_constant(1130)]];
constant int SC_SOFTWARE_WRAP_MODE_U_reflectionModulationTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_reflectionModulationTex) ? SC_SOFTWARE_WRAP_MODE_U_reflectionModulationTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_reflectionTex [[function_constant(1131)]];
constant int SC_SOFTWARE_WRAP_MODE_U_reflectionTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_reflectionTex) ? SC_SOFTWARE_WRAP_MODE_U_reflectionTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_rimColorTex [[function_constant(1132)]];
constant int SC_SOFTWARE_WRAP_MODE_U_rimColorTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_rimColorTex) ? SC_SOFTWARE_WRAP_MODE_U_rimColorTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_baseTex [[function_constant(1133)]];
constant int SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_baseTex) ? SC_SOFTWARE_WRAP_MODE_V_baseTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_detailNormalTex [[function_constant(1134)]];
constant int SC_SOFTWARE_WRAP_MODE_V_detailNormalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_detailNormalTex) ? SC_SOFTWARE_WRAP_MODE_V_detailNormalTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_emissiveTex [[function_constant(1135)]];
constant int SC_SOFTWARE_WRAP_MODE_V_emissiveTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_emissiveTex) ? SC_SOFTWARE_WRAP_MODE_V_emissiveTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(1136)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_normalTex [[function_constant(1137)]];
constant int SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_normalTex) ? SC_SOFTWARE_WRAP_MODE_V_normalTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_opacityTex [[function_constant(1138)]];
constant int SC_SOFTWARE_WRAP_MODE_V_opacityTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_opacityTex) ? SC_SOFTWARE_WRAP_MODE_V_opacityTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_reflectionModulationTex [[function_constant(1139)]];
constant int SC_SOFTWARE_WRAP_MODE_V_reflectionModulationTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_reflectionModulationTex) ? SC_SOFTWARE_WRAP_MODE_V_reflectionModulationTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_reflectionTex [[function_constant(1140)]];
constant int SC_SOFTWARE_WRAP_MODE_V_reflectionTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_reflectionTex) ? SC_SOFTWARE_WRAP_MODE_V_reflectionTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_rimColorTex [[function_constant(1141)]];
constant int SC_SOFTWARE_WRAP_MODE_V_rimColorTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_rimColorTex) ? SC_SOFTWARE_WRAP_MODE_V_rimColorTex : -1;
constant int baseTexLayout [[function_constant(1142)]];
constant int baseTexLayout_tmp = is_function_constant_defined(baseTexLayout) ? baseTexLayout : 0;
constant int detailNormalTexLayout [[function_constant(1143)]];
constant int detailNormalTexLayout_tmp = is_function_constant_defined(detailNormalTexLayout) ? detailNormalTexLayout : 0;
constant int emissiveTexLayout [[function_constant(1144)]];
constant int emissiveTexLayout_tmp = is_function_constant_defined(emissiveTexLayout) ? emissiveTexLayout : 0;
constant int intensityTextureLayout [[function_constant(1145)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int normalTexLayout [[function_constant(1146)]];
constant int normalTexLayout_tmp = is_function_constant_defined(normalTexLayout) ? normalTexLayout : 0;
constant int opacityTexLayout [[function_constant(1147)]];
constant int opacityTexLayout_tmp = is_function_constant_defined(opacityTexLayout) ? opacityTexLayout : 0;
constant int reflectionModulationTexLayout [[function_constant(1148)]];
constant int reflectionModulationTexLayout_tmp = is_function_constant_defined(reflectionModulationTexLayout) ? reflectionModulationTexLayout : 0;
constant int reflectionTexLayout [[function_constant(1149)]];
constant int reflectionTexLayout_tmp = is_function_constant_defined(reflectionTexLayout) ? reflectionTexLayout : 0;
constant int rimColorTexLayout [[function_constant(1150)]];
constant int rimColorTexLayout_tmp = is_function_constant_defined(rimColorTexLayout) ? rimColorTexLayout : 0;
constant int sc_DepthBufferMode [[function_constant(1151)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_RenderingSpace [[function_constant(1152)]];
constant int sc_RenderingSpace_tmp = is_function_constant_defined(sc_RenderingSpace) ? sc_RenderingSpace : -1;
constant int sc_ScreenTextureLayout [[function_constant(1153)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_SkinBonesCount [[function_constant(1154)]];
constant int sc_SkinBonesCount_tmp = is_function_constant_defined(sc_SkinBonesCount) ? sc_SkinBonesCount : 0;
constant int sc_StereoRenderingMode [[function_constant(1155)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1156)]];
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
int isProxyMode;
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
float3 recolorRed;
float4 baseColor;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float2 uv2Scale;
float2 uv2Offset;
float2 uv3Scale;
float2 uv3Offset;
float3 recolorGreen;
float3 recolorBlue;
float4 emissiveTexSize;
float4 emissiveTexDims;
float4 emissiveTexView;
float3x3 emissiveTexTransform;
float4 emissiveTexUvMinMax;
float4 emissiveTexBorderColor;
float3 emissiveColor;
float emissiveIntensity;
float reflectionIntensity;
float4 reflectionTexSize;
float4 reflectionTexDims;
float4 reflectionTexView;
float3x3 reflectionTexTransform;
float4 reflectionTexUvMinMax;
float4 reflectionTexBorderColor;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float4 detailNormalTexSize;
float4 detailNormalTexDims;
float4 detailNormalTexView;
float3x3 detailNormalTexTransform;
float4 detailNormalTexUvMinMax;
float4 detailNormalTexBorderColor;
float4 reflectionModulationTexSize;
float4 reflectionModulationTexDims;
float4 reflectionModulationTexView;
float3x3 reflectionModulationTexTransform;
float4 reflectionModulationTexUvMinMax;
float4 reflectionModulationTexBorderColor;
float3 rimColor;
float rimIntensity;
float4 rimColorTexSize;
float4 rimColorTexDims;
float4 rimColorTexView;
float3x3 rimColorTexTransform;
float4 rimColorTexUvMinMax;
float4 rimColorTexBorderColor;
float rimExponent;
float4 opacityTexSize;
float4 opacityTexDims;
float4 opacityTexView;
float3x3 opacityTexTransform;
float4 opacityTexUvMinMax;
float4 opacityTexBorderColor;
float4 Port_Import_N042;
float Port_Input1_N044;
float Port_Import_N088;
float3 Port_Import_N089;
float4 Port_Import_N384;
float Port_Import_N307;
float Port_Import_N201;
float Port_Import_N012;
float Port_Import_N010;
float Port_Import_N007;
float2 Port_Import_N008;
float2 Port_Import_N009;
float Port_Speed_N022;
float2 Port_Import_N254;
float Port_Import_N065;
float Port_Import_N055;
float Port_Import_N056;
float2 Port_Import_N000;
float2 Port_Import_N060;
float2 Port_Import_N061;
float Port_Speed_N063;
float2 Port_Import_N255;
float4 Port_Default_N369;
float4 Port_Import_N092;
float3 Port_Import_N090;
float3 Port_Import_N091;
float3 Port_Import_N144;
float Port_Value2_N073;
float Port_Import_N273;
float Port_Input1_N274;
float Port_Import_N131;
float Port_Import_N116;
float2 Port_Import_N120;
float2 Port_Import_N127;
float3 Port_Default_N132;
float3 Port_Import_N295;
float Port_Import_N296;
float3 Port_Default_N097;
float Port_Import_N133;
float Port_Import_N231;
float Port_Import_N336;
float Port_Import_N160;
float2 Port_Import_N167;
float2 Port_Import_N207;
float Port_Strength1_N200;
float Port_Import_N095;
float Port_Import_N108;
float3 Port_Default_N113;
float Port_Strength2_N200;
float3 Port_Import_N327;
float3 Port_Input1_N257;
float3 Port_Import_N259;
float Port_Input1_N264;
float Port_Input1_N268;
float Port_Input1_N270;
float Port_Import_N123;
float Port_Import_N025;
float2 Port_Import_N030;
float2 Port_Import_N031;
float3 Port_Default_N041;
float3 Port_Default_N134;
float3 Port_Import_N298;
float Port_Import_N172;
float3 Port_Import_N318;
float Port_Import_N319;
float Port_Import_N171;
float Port_Import_N135;
float2 Port_Import_N150;
float2 Port_Import_N152;
float3 Port_Default_N170;
float Port_Import_N339;
float3 Port_Import_N328;
float Port_Import_N340;
float3 Port_Default_N173;
float3 Port_Import_N306;
float4 Port_Import_N166;
float Port_Import_N206;
float Port_Import_N043;
float2 Port_Import_N151;
float2 Port_Import_N155;
float Port_Default_N204;
float Port_Import_N047;
float Port_Input1_N036;
float Port_Input2_N072;
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
texture2d<float> detailNormalTex [[id(5)]];
texture2d<float> emissiveTex [[id(6)]];
texture2d<float> intensityTexture [[id(7)]];
texture2d<float> normalTex [[id(8)]];
texture2d<float> opacityTex [[id(9)]];
texture2d<float> reflectionModulationTex [[id(10)]];
texture2d<float> reflectionTex [[id(11)]];
texture2d<float> rimColorTex [[id(12)]];
texture2d<float> sc_ScreenTexture [[id(24)]];
texture2d<uint> z_hitIdAndBarycentric [[id(27)]];
texture2d<float> z_rayDirections [[id(28)]];
sampler baseTexSmpSC [[id(29)]];
sampler detailNormalTexSmpSC [[id(30)]];
sampler emissiveTexSmpSC [[id(31)]];
sampler intensityTextureSmpSC [[id(32)]];
sampler normalTexSmpSC [[id(33)]];
sampler opacityTexSmpSC [[id(34)]];
sampler reflectionModulationTexSmpSC [[id(35)]];
sampler reflectionTexSmpSC [[id(36)]];
sampler rimColorTexSmpSC [[id(37)]];
sampler sc_ScreenTextureSmpSC [[id(42)]];
sampler z_hitIdAndBarycentricSmp [[id(45)]];
sampler z_rayDirectionsSmpSC [[id(46)]];
constant userUniformsObj* UserUniforms [[id(47)]];
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
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float4 VertexColor;
float2 Surface_UVCoord0;
float2 Surface_UVCoord1;
float2 gScreenCoord;
float3 ViewDirWS;
float3 SurfacePosition_WorldSpace;
float3 VertexTangent_WorldSpace;
float3 VertexNormal_WorldSpace;
float3 VertexBinormal_WorldSpace;
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
int isProxyMode;
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
float3 recolorRed;
float4 baseColor;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float2 uv2Scale;
float2 uv2Offset;
float2 uv3Scale;
float2 uv3Offset;
float3 recolorGreen;
float3 recolorBlue;
float4 emissiveTexSize;
float4 emissiveTexDims;
float4 emissiveTexView;
float3x3 emissiveTexTransform;
float4 emissiveTexUvMinMax;
float4 emissiveTexBorderColor;
float3 emissiveColor;
float emissiveIntensity;
float reflectionIntensity;
float4 reflectionTexSize;
float4 reflectionTexDims;
float4 reflectionTexView;
float3x3 reflectionTexTransform;
float4 reflectionTexUvMinMax;
float4 reflectionTexBorderColor;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float4 detailNormalTexSize;
float4 detailNormalTexDims;
float4 detailNormalTexView;
float3x3 detailNormalTexTransform;
float4 detailNormalTexUvMinMax;
float4 detailNormalTexBorderColor;
float4 reflectionModulationTexSize;
float4 reflectionModulationTexDims;
float4 reflectionModulationTexView;
float3x3 reflectionModulationTexTransform;
float4 reflectionModulationTexUvMinMax;
float4 reflectionModulationTexBorderColor;
float3 rimColor;
float rimIntensity;
float4 rimColorTexSize;
float4 rimColorTexDims;
float4 rimColorTexView;
float3x3 rimColorTexTransform;
float4 rimColorTexUvMinMax;
float4 rimColorTexBorderColor;
float rimExponent;
float4 opacityTexSize;
float4 opacityTexDims;
float4 opacityTexView;
float3x3 opacityTexTransform;
float4 opacityTexUvMinMax;
float4 opacityTexBorderColor;
float4 Port_Import_N042;
float Port_Input1_N044;
float Port_Import_N088;
float3 Port_Import_N089;
float4 Port_Import_N384;
float Port_Import_N307;
float Port_Import_N201;
float Port_Import_N012;
float Port_Import_N010;
float Port_Import_N007;
float2 Port_Import_N008;
float2 Port_Import_N009;
float Port_Speed_N022;
float2 Port_Import_N254;
float Port_Import_N065;
float Port_Import_N055;
float Port_Import_N056;
float2 Port_Import_N000;
float2 Port_Import_N060;
float2 Port_Import_N061;
float Port_Speed_N063;
float2 Port_Import_N255;
float4 Port_Default_N369;
float4 Port_Import_N092;
float3 Port_Import_N090;
float3 Port_Import_N091;
float3 Port_Import_N144;
float Port_Value2_N073;
float Port_Import_N273;
float Port_Input1_N274;
float Port_Import_N131;
float Port_Import_N116;
float2 Port_Import_N120;
float2 Port_Import_N127;
float3 Port_Default_N132;
float3 Port_Import_N295;
float Port_Import_N296;
float3 Port_Default_N097;
float Port_Import_N133;
float Port_Import_N231;
float Port_Import_N336;
float Port_Import_N160;
float2 Port_Import_N167;
float2 Port_Import_N207;
float Port_Strength1_N200;
float Port_Import_N095;
float Port_Import_N108;
float3 Port_Default_N113;
float Port_Strength2_N200;
float3 Port_Import_N327;
float3 Port_Input1_N257;
float3 Port_Import_N259;
float Port_Input1_N264;
float Port_Input1_N268;
float Port_Input1_N270;
float Port_Import_N123;
float Port_Import_N025;
float2 Port_Import_N030;
float2 Port_Import_N031;
float3 Port_Default_N041;
float3 Port_Default_N134;
float3 Port_Import_N298;
float Port_Import_N172;
float3 Port_Import_N318;
float Port_Import_N319;
float Port_Import_N171;
float Port_Import_N135;
float2 Port_Import_N150;
float2 Port_Import_N152;
float3 Port_Default_N170;
float Port_Import_N339;
float3 Port_Import_N328;
float Port_Import_N340;
float3 Port_Default_N173;
float3 Port_Import_N306;
float4 Port_Import_N166;
float Port_Import_N206;
float Port_Import_N043;
float2 Port_Import_N151;
float2 Port_Import_N155;
float Port_Default_N204;
float Port_Import_N047;
float Port_Input1_N036;
float Port_Input2_N072;
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
texture2d<float> detailNormalTex [[id(5)]];
texture2d<float> emissiveTex [[id(6)]];
texture2d<float> intensityTexture [[id(7)]];
texture2d<float> normalTex [[id(8)]];
texture2d<float> opacityTex [[id(9)]];
texture2d<float> reflectionModulationTex [[id(10)]];
texture2d<float> reflectionTex [[id(11)]];
texture2d<float> rimColorTex [[id(12)]];
texture2d<float> sc_ScreenTexture [[id(24)]];
texture2d<uint> z_hitIdAndBarycentric [[id(27)]];
texture2d<float> z_rayDirections [[id(28)]];
sampler baseTexSmpSC [[id(29)]];
sampler detailNormalTexSmpSC [[id(30)]];
sampler emissiveTexSmpSC [[id(31)]];
sampler intensityTextureSmpSC [[id(32)]];
sampler normalTexSmpSC [[id(33)]];
sampler opacityTexSmpSC [[id(34)]];
sampler reflectionModulationTexSmpSC [[id(35)]];
sampler reflectionTexSmpSC [[id(36)]];
sampler rimColorTexSmpSC [[id(37)]];
sampler sc_ScreenTextureSmpSC [[id(42)]];
sampler z_hitIdAndBarycentricSmp [[id(45)]];
sampler z_rayDirectionsSmpSC [[id(46)]];
constant userUniformsObj* UserUniforms [[id(47)]];
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
Globals.VertexColor=rhp.color;
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
Globals.SurfacePosition_WorldSpace=rhp.positionWS;
Globals.ViewDirWS=rhp.viewDirWS;
Globals.VertexTangent_WorldSpace=rhp.tangentWS.xyz;
Globals.VertexNormal_WorldSpace=rhp.normalWS;
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*rhp.tangentWS.w;
}
else
{
Globals.VertexColor=in.varColor;
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
Globals.SurfacePosition_WorldSpace=in.varPos;
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-Globals.SurfacePosition_WorldSpace);
Globals.VertexTangent_WorldSpace=normalize(in.varTangent.xyz);
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*in.varTangent.w;
}
float4 Result_N363=float4(0.0);
float4 param=float4(0.0);
float4 param_1=float4(0.0);
ssGlobals param_3=Globals;
float4 param_2;
if (NODE_38_DROPLIST_ITEM_tmp==1)
{
float4 l9_24=float4(0.0);
l9_24=param_3.VertexColor;
float3 l9_25=float3(0.0);
float3 l9_26=float3(0.0);
float3 l9_27=float3(0.0);
ssGlobals l9_28=param_3;
float3 l9_29;
if ((int(ENABLE_RECOLOR_tmp)!=0))
{
float3 l9_30=float3(0.0);
float3 l9_31=(*sc_set2.UserUniforms).recolorRed;
l9_30=l9_31;
float3 l9_32=float3(0.0);
l9_32=l9_30;
float4 l9_33=float4(0.0);
float4 l9_34=(*sc_set2.UserUniforms).baseColor;
l9_33=l9_34;
float4 l9_35=float4(0.0);
l9_35=l9_33;
float4 l9_36=float4(0.0);
float4 l9_37=float4(0.0);
float4 l9_38=(*sc_set2.UserUniforms).Port_Default_N369;
ssGlobals l9_39=l9_28;
float4 l9_40;
if ((int(ENABLE_BASE_TEX_tmp)!=0))
{
float2 l9_41=float2(0.0);
float2 l9_42=float2(0.0);
float2 l9_43=float2(0.0);
float2 l9_44=float2(0.0);
float2 l9_45=float2(0.0);
float2 l9_46=float2(0.0);
ssGlobals l9_47=l9_39;
float2 l9_48;
if (NODE_27_DROPLIST_ITEM_tmp==0)
{
float2 l9_49=float2(0.0);
l9_49=l9_47.Surface_UVCoord0;
l9_42=l9_49;
l9_48=l9_42;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==1)
{
float2 l9_50=float2(0.0);
l9_50=l9_47.Surface_UVCoord1;
l9_43=l9_50;
l9_48=l9_43;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==2)
{
float2 l9_51=float2(0.0);
float2 l9_52=float2(0.0);
float2 l9_53=float2(0.0);
ssGlobals l9_54=l9_47;
float2 l9_55;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_56=float2(0.0);
float2 l9_57=float2(0.0);
float2 l9_58=float2(0.0);
ssGlobals l9_59=l9_54;
float2 l9_60;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_61=float2(0.0);
float2 l9_62=float2(0.0);
float2 l9_63=float2(0.0);
float2 l9_64=float2(0.0);
float2 l9_65=float2(0.0);
ssGlobals l9_66=l9_59;
float2 l9_67;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_68=float2(0.0);
l9_68=l9_66.Surface_UVCoord0;
l9_62=l9_68;
l9_67=l9_62;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_69=float2(0.0);
l9_69=l9_66.Surface_UVCoord1;
l9_63=l9_69;
l9_67=l9_63;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_70=float2(0.0);
l9_70=l9_66.gScreenCoord;
l9_64=l9_70;
l9_67=l9_64;
}
else
{
float2 l9_71=float2(0.0);
l9_71=l9_66.Surface_UVCoord0;
l9_65=l9_71;
l9_67=l9_65;
}
}
}
l9_61=l9_67;
float2 l9_72=float2(0.0);
float2 l9_73=(*sc_set2.UserUniforms).uv2Scale;
l9_72=l9_73;
float2 l9_74=float2(0.0);
l9_74=l9_72;
float2 l9_75=float2(0.0);
float2 l9_76=(*sc_set2.UserUniforms).uv2Offset;
l9_75=l9_76;
float2 l9_77=float2(0.0);
l9_77=l9_75;
float2 l9_78=float2(0.0);
l9_78=(l9_61*l9_74)+l9_77;
float2 l9_79=float2(0.0);
l9_79=l9_78+(l9_77*(l9_59.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_57=l9_79;
l9_60=l9_57;
}
else
{
float2 l9_80=float2(0.0);
float2 l9_81=float2(0.0);
float2 l9_82=float2(0.0);
float2 l9_83=float2(0.0);
float2 l9_84=float2(0.0);
ssGlobals l9_85=l9_59;
float2 l9_86;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_87=float2(0.0);
l9_87=l9_85.Surface_UVCoord0;
l9_81=l9_87;
l9_86=l9_81;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_88=float2(0.0);
l9_88=l9_85.Surface_UVCoord1;
l9_82=l9_88;
l9_86=l9_82;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_89=float2(0.0);
l9_89=l9_85.gScreenCoord;
l9_83=l9_89;
l9_86=l9_83;
}
else
{
float2 l9_90=float2(0.0);
l9_90=l9_85.Surface_UVCoord0;
l9_84=l9_90;
l9_86=l9_84;
}
}
}
l9_80=l9_86;
float2 l9_91=float2(0.0);
float2 l9_92=(*sc_set2.UserUniforms).uv2Scale;
l9_91=l9_92;
float2 l9_93=float2(0.0);
l9_93=l9_91;
float2 l9_94=float2(0.0);
float2 l9_95=(*sc_set2.UserUniforms).uv2Offset;
l9_94=l9_95;
float2 l9_96=float2(0.0);
l9_96=l9_94;
float2 l9_97=float2(0.0);
l9_97=(l9_80*l9_93)+l9_96;
l9_58=l9_97;
l9_60=l9_58;
}
l9_56=l9_60;
l9_52=l9_56;
l9_55=l9_52;
}
else
{
float2 l9_98=float2(0.0);
l9_98=l9_54.Surface_UVCoord0;
l9_53=l9_98;
l9_55=l9_53;
}
l9_51=l9_55;
float2 l9_99=float2(0.0);
l9_99=l9_51;
float2 l9_100=float2(0.0);
l9_100=l9_99;
l9_44=l9_100;
l9_48=l9_44;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==3)
{
float2 l9_101=float2(0.0);
float2 l9_102=float2(0.0);
float2 l9_103=float2(0.0);
ssGlobals l9_104=l9_47;
float2 l9_105;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_106=float2(0.0);
float2 l9_107=float2(0.0);
float2 l9_108=float2(0.0);
ssGlobals l9_109=l9_104;
float2 l9_110;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_111=float2(0.0);
float2 l9_112=float2(0.0);
float2 l9_113=float2(0.0);
float2 l9_114=float2(0.0);
float2 l9_115=float2(0.0);
float2 l9_116=float2(0.0);
ssGlobals l9_117=l9_109;
float2 l9_118;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_119=float2(0.0);
l9_119=l9_117.Surface_UVCoord0;
l9_112=l9_119;
l9_118=l9_112;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_120=float2(0.0);
l9_120=l9_117.Surface_UVCoord1;
l9_113=l9_120;
l9_118=l9_113;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_121=float2(0.0);
l9_121=l9_117.gScreenCoord;
l9_114=l9_121;
l9_118=l9_114;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_122=float2(0.0);
float2 l9_123=float2(0.0);
float2 l9_124=float2(0.0);
ssGlobals l9_125=l9_117;
float2 l9_126;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_127=float2(0.0);
float2 l9_128=float2(0.0);
float2 l9_129=float2(0.0);
ssGlobals l9_130=l9_125;
float2 l9_131;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_132=float2(0.0);
float2 l9_133=float2(0.0);
float2 l9_134=float2(0.0);
float2 l9_135=float2(0.0);
float2 l9_136=float2(0.0);
ssGlobals l9_137=l9_130;
float2 l9_138;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_139=float2(0.0);
l9_139=l9_137.Surface_UVCoord0;
l9_133=l9_139;
l9_138=l9_133;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_140=float2(0.0);
l9_140=l9_137.Surface_UVCoord1;
l9_134=l9_140;
l9_138=l9_134;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_141=float2(0.0);
l9_141=l9_137.gScreenCoord;
l9_135=l9_141;
l9_138=l9_135;
}
else
{
float2 l9_142=float2(0.0);
l9_142=l9_137.Surface_UVCoord0;
l9_136=l9_142;
l9_138=l9_136;
}
}
}
l9_132=l9_138;
float2 l9_143=float2(0.0);
float2 l9_144=(*sc_set2.UserUniforms).uv2Scale;
l9_143=l9_144;
float2 l9_145=float2(0.0);
l9_145=l9_143;
float2 l9_146=float2(0.0);
float2 l9_147=(*sc_set2.UserUniforms).uv2Offset;
l9_146=l9_147;
float2 l9_148=float2(0.0);
l9_148=l9_146;
float2 l9_149=float2(0.0);
l9_149=(l9_132*l9_145)+l9_148;
float2 l9_150=float2(0.0);
l9_150=l9_149+(l9_148*(l9_130.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_128=l9_150;
l9_131=l9_128;
}
else
{
float2 l9_151=float2(0.0);
float2 l9_152=float2(0.0);
float2 l9_153=float2(0.0);
float2 l9_154=float2(0.0);
float2 l9_155=float2(0.0);
ssGlobals l9_156=l9_130;
float2 l9_157;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_158=float2(0.0);
l9_158=l9_156.Surface_UVCoord0;
l9_152=l9_158;
l9_157=l9_152;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_159=float2(0.0);
l9_159=l9_156.Surface_UVCoord1;
l9_153=l9_159;
l9_157=l9_153;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_160=float2(0.0);
l9_160=l9_156.gScreenCoord;
l9_154=l9_160;
l9_157=l9_154;
}
else
{
float2 l9_161=float2(0.0);
l9_161=l9_156.Surface_UVCoord0;
l9_155=l9_161;
l9_157=l9_155;
}
}
}
l9_151=l9_157;
float2 l9_162=float2(0.0);
float2 l9_163=(*sc_set2.UserUniforms).uv2Scale;
l9_162=l9_163;
float2 l9_164=float2(0.0);
l9_164=l9_162;
float2 l9_165=float2(0.0);
float2 l9_166=(*sc_set2.UserUniforms).uv2Offset;
l9_165=l9_166;
float2 l9_167=float2(0.0);
l9_167=l9_165;
float2 l9_168=float2(0.0);
l9_168=(l9_151*l9_164)+l9_167;
l9_129=l9_168;
l9_131=l9_129;
}
l9_127=l9_131;
l9_123=l9_127;
l9_126=l9_123;
}
else
{
float2 l9_169=float2(0.0);
l9_169=l9_125.Surface_UVCoord0;
l9_124=l9_169;
l9_126=l9_124;
}
l9_122=l9_126;
float2 l9_170=float2(0.0);
l9_170=l9_122;
float2 l9_171=float2(0.0);
l9_171=l9_170;
l9_115=l9_171;
l9_118=l9_115;
}
else
{
float2 l9_172=float2(0.0);
l9_172=l9_117.Surface_UVCoord0;
l9_116=l9_172;
l9_118=l9_116;
}
}
}
}
l9_111=l9_118;
float2 l9_173=float2(0.0);
float2 l9_174=(*sc_set2.UserUniforms).uv3Scale;
l9_173=l9_174;
float2 l9_175=float2(0.0);
l9_175=l9_173;
float2 l9_176=float2(0.0);
float2 l9_177=(*sc_set2.UserUniforms).uv3Offset;
l9_176=l9_177;
float2 l9_178=float2(0.0);
l9_178=l9_176;
float2 l9_179=float2(0.0);
l9_179=(l9_111*l9_175)+l9_178;
float2 l9_180=float2(0.0);
l9_180=l9_179+(l9_178*(l9_109.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_107=l9_180;
l9_110=l9_107;
}
else
{
float2 l9_181=float2(0.0);
float2 l9_182=float2(0.0);
float2 l9_183=float2(0.0);
float2 l9_184=float2(0.0);
float2 l9_185=float2(0.0);
float2 l9_186=float2(0.0);
ssGlobals l9_187=l9_109;
float2 l9_188;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_189=float2(0.0);
l9_189=l9_187.Surface_UVCoord0;
l9_182=l9_189;
l9_188=l9_182;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_190=float2(0.0);
l9_190=l9_187.Surface_UVCoord1;
l9_183=l9_190;
l9_188=l9_183;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_191=float2(0.0);
l9_191=l9_187.gScreenCoord;
l9_184=l9_191;
l9_188=l9_184;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_192=float2(0.0);
float2 l9_193=float2(0.0);
float2 l9_194=float2(0.0);
ssGlobals l9_195=l9_187;
float2 l9_196;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_197=float2(0.0);
float2 l9_198=float2(0.0);
float2 l9_199=float2(0.0);
ssGlobals l9_200=l9_195;
float2 l9_201;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_202=float2(0.0);
float2 l9_203=float2(0.0);
float2 l9_204=float2(0.0);
float2 l9_205=float2(0.0);
float2 l9_206=float2(0.0);
ssGlobals l9_207=l9_200;
float2 l9_208;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_209=float2(0.0);
l9_209=l9_207.Surface_UVCoord0;
l9_203=l9_209;
l9_208=l9_203;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_210=float2(0.0);
l9_210=l9_207.Surface_UVCoord1;
l9_204=l9_210;
l9_208=l9_204;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_211=float2(0.0);
l9_211=l9_207.gScreenCoord;
l9_205=l9_211;
l9_208=l9_205;
}
else
{
float2 l9_212=float2(0.0);
l9_212=l9_207.Surface_UVCoord0;
l9_206=l9_212;
l9_208=l9_206;
}
}
}
l9_202=l9_208;
float2 l9_213=float2(0.0);
float2 l9_214=(*sc_set2.UserUniforms).uv2Scale;
l9_213=l9_214;
float2 l9_215=float2(0.0);
l9_215=l9_213;
float2 l9_216=float2(0.0);
float2 l9_217=(*sc_set2.UserUniforms).uv2Offset;
l9_216=l9_217;
float2 l9_218=float2(0.0);
l9_218=l9_216;
float2 l9_219=float2(0.0);
l9_219=(l9_202*l9_215)+l9_218;
float2 l9_220=float2(0.0);
l9_220=l9_219+(l9_218*(l9_200.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_198=l9_220;
l9_201=l9_198;
}
else
{
float2 l9_221=float2(0.0);
float2 l9_222=float2(0.0);
float2 l9_223=float2(0.0);
float2 l9_224=float2(0.0);
float2 l9_225=float2(0.0);
ssGlobals l9_226=l9_200;
float2 l9_227;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_228=float2(0.0);
l9_228=l9_226.Surface_UVCoord0;
l9_222=l9_228;
l9_227=l9_222;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_229=float2(0.0);
l9_229=l9_226.Surface_UVCoord1;
l9_223=l9_229;
l9_227=l9_223;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_230=float2(0.0);
l9_230=l9_226.gScreenCoord;
l9_224=l9_230;
l9_227=l9_224;
}
else
{
float2 l9_231=float2(0.0);
l9_231=l9_226.Surface_UVCoord0;
l9_225=l9_231;
l9_227=l9_225;
}
}
}
l9_221=l9_227;
float2 l9_232=float2(0.0);
float2 l9_233=(*sc_set2.UserUniforms).uv2Scale;
l9_232=l9_233;
float2 l9_234=float2(0.0);
l9_234=l9_232;
float2 l9_235=float2(0.0);
float2 l9_236=(*sc_set2.UserUniforms).uv2Offset;
l9_235=l9_236;
float2 l9_237=float2(0.0);
l9_237=l9_235;
float2 l9_238=float2(0.0);
l9_238=(l9_221*l9_234)+l9_237;
l9_199=l9_238;
l9_201=l9_199;
}
l9_197=l9_201;
l9_193=l9_197;
l9_196=l9_193;
}
else
{
float2 l9_239=float2(0.0);
l9_239=l9_195.Surface_UVCoord0;
l9_194=l9_239;
l9_196=l9_194;
}
l9_192=l9_196;
float2 l9_240=float2(0.0);
l9_240=l9_192;
float2 l9_241=float2(0.0);
l9_241=l9_240;
l9_185=l9_241;
l9_188=l9_185;
}
else
{
float2 l9_242=float2(0.0);
l9_242=l9_187.Surface_UVCoord0;
l9_186=l9_242;
l9_188=l9_186;
}
}
}
}
l9_181=l9_188;
float2 l9_243=float2(0.0);
float2 l9_244=(*sc_set2.UserUniforms).uv3Scale;
l9_243=l9_244;
float2 l9_245=float2(0.0);
l9_245=l9_243;
float2 l9_246=float2(0.0);
float2 l9_247=(*sc_set2.UserUniforms).uv3Offset;
l9_246=l9_247;
float2 l9_248=float2(0.0);
l9_248=l9_246;
float2 l9_249=float2(0.0);
l9_249=(l9_181*l9_245)+l9_248;
l9_108=l9_249;
l9_110=l9_108;
}
l9_106=l9_110;
l9_102=l9_106;
l9_105=l9_102;
}
else
{
float2 l9_250=float2(0.0);
l9_250=l9_104.Surface_UVCoord0;
l9_103=l9_250;
l9_105=l9_103;
}
l9_101=l9_105;
float2 l9_251=float2(0.0);
l9_251=l9_101;
float2 l9_252=float2(0.0);
l9_252=l9_251;
l9_45=l9_252;
l9_48=l9_45;
}
else
{
float2 l9_253=float2(0.0);
l9_253=l9_47.Surface_UVCoord0;
l9_46=l9_253;
l9_48=l9_46;
}
}
}
}
l9_41=l9_48;
float4 l9_254=float4(0.0);
int l9_255=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_256=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_256=0;
}
else
{
l9_256=in.varStereoViewID;
}
int l9_257=l9_256;
l9_255=1-l9_257;
}
else
{
int l9_258=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_258=0;
}
else
{
l9_258=in.varStereoViewID;
}
int l9_259=l9_258;
l9_255=l9_259;
}
int l9_260=l9_255;
int l9_261=baseTexLayout_tmp;
int l9_262=l9_260;
float2 l9_263=l9_41;
bool l9_264=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_265=(*sc_set2.UserUniforms).baseTexTransform;
int2 l9_266=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_267=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_268=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool l9_269=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_270=(*sc_set2.UserUniforms).baseTexBorderColor;
float l9_271=0.0;
bool l9_272=l9_269&&(!l9_267);
float l9_273=1.0;
float l9_274=l9_263.x;
int l9_275=l9_266.x;
if (l9_275==1)
{
l9_274=fract(l9_274);
}
else
{
if (l9_275==2)
{
float l9_276=fract(l9_274);
float l9_277=l9_274-l9_276;
float l9_278=step(0.25,fract(l9_277*0.5));
l9_274=mix(l9_276,1.0-l9_276,fast::clamp(l9_278,0.0,1.0));
}
}
l9_263.x=l9_274;
float l9_279=l9_263.y;
int l9_280=l9_266.y;
if (l9_280==1)
{
l9_279=fract(l9_279);
}
else
{
if (l9_280==2)
{
float l9_281=fract(l9_279);
float l9_282=l9_279-l9_281;
float l9_283=step(0.25,fract(l9_282*0.5));
l9_279=mix(l9_281,1.0-l9_281,fast::clamp(l9_283,0.0,1.0));
}
}
l9_263.y=l9_279;
if (l9_267)
{
bool l9_284=l9_269;
bool l9_285;
if (l9_284)
{
l9_285=l9_266.x==3;
}
else
{
l9_285=l9_284;
}
float l9_286=l9_263.x;
float l9_287=l9_268.x;
float l9_288=l9_268.z;
bool l9_289=l9_285;
float l9_290=l9_273;
float l9_291=fast::clamp(l9_286,l9_287,l9_288);
float l9_292=step(abs(l9_286-l9_291),9.9999997e-06);
l9_290*=(l9_292+((1.0-float(l9_289))*(1.0-l9_292)));
l9_286=l9_291;
l9_263.x=l9_286;
l9_273=l9_290;
bool l9_293=l9_269;
bool l9_294;
if (l9_293)
{
l9_294=l9_266.y==3;
}
else
{
l9_294=l9_293;
}
float l9_295=l9_263.y;
float l9_296=l9_268.y;
float l9_297=l9_268.w;
bool l9_298=l9_294;
float l9_299=l9_273;
float l9_300=fast::clamp(l9_295,l9_296,l9_297);
float l9_301=step(abs(l9_295-l9_300),9.9999997e-06);
l9_299*=(l9_301+((1.0-float(l9_298))*(1.0-l9_301)));
l9_295=l9_300;
l9_263.y=l9_295;
l9_273=l9_299;
}
float2 l9_302=l9_263;
bool l9_303=l9_264;
float3x3 l9_304=l9_265;
if (l9_303)
{
l9_302=float2((l9_304*float3(l9_302,1.0)).xy);
}
float2 l9_305=l9_302;
float2 l9_306=l9_305;
float2 l9_307=l9_306;
l9_263=l9_307;
float l9_308=l9_263.x;
int l9_309=l9_266.x;
bool l9_310=l9_272;
float l9_311=l9_273;
if ((l9_309==0)||(l9_309==3))
{
float l9_312=l9_308;
float l9_313=0.0;
float l9_314=1.0;
bool l9_315=l9_310;
float l9_316=l9_311;
float l9_317=fast::clamp(l9_312,l9_313,l9_314);
float l9_318=step(abs(l9_312-l9_317),9.9999997e-06);
l9_316*=(l9_318+((1.0-float(l9_315))*(1.0-l9_318)));
l9_312=l9_317;
l9_308=l9_312;
l9_311=l9_316;
}
l9_263.x=l9_308;
l9_273=l9_311;
float l9_319=l9_263.y;
int l9_320=l9_266.y;
bool l9_321=l9_272;
float l9_322=l9_273;
if ((l9_320==0)||(l9_320==3))
{
float l9_323=l9_319;
float l9_324=0.0;
float l9_325=1.0;
bool l9_326=l9_321;
float l9_327=l9_322;
float l9_328=fast::clamp(l9_323,l9_324,l9_325);
float l9_329=step(abs(l9_323-l9_328),9.9999997e-06);
l9_327*=(l9_329+((1.0-float(l9_326))*(1.0-l9_329)));
l9_323=l9_328;
l9_319=l9_323;
l9_322=l9_327;
}
l9_263.y=l9_319;
l9_273=l9_322;
float2 l9_330=l9_263;
int l9_331=l9_261;
int l9_332=l9_262;
float l9_333=l9_271;
float2 l9_334=l9_330;
int l9_335=l9_331;
int l9_336=l9_332;
float3 l9_337=float3(0.0);
if (l9_335==0)
{
l9_337=float3(l9_334,0.0);
}
else
{
if (l9_335==1)
{
l9_337=float3(l9_334.x,(l9_334.y*0.5)+(0.5-(float(l9_336)*0.5)),0.0);
}
else
{
l9_337=float3(l9_334,float(l9_336));
}
}
float3 l9_338=l9_337;
float3 l9_339=l9_338;
float2 l9_340=l9_339.xy;
float l9_341=l9_333;
float4 l9_342=sc_set2.baseTex.sample(sc_set2.baseTexSmpSC,l9_340,bias(l9_341));
float4 l9_343=l9_342;
float4 l9_344=l9_343;
if (l9_269)
{
l9_344=mix(l9_270,l9_344,float4(l9_273));
}
float4 l9_345=l9_344;
l9_254=l9_345;
l9_37=l9_254;
l9_40=l9_37;
}
else
{
l9_40=l9_38;
}
l9_36=l9_40;
float4 l9_346=float4(0.0);
l9_346=l9_35*l9_36;
float4 l9_347=float4(0.0);
l9_347=l9_346;
float4 l9_348=float4(0.0);
l9_348=l9_347;
float l9_349=0.0;
float l9_350=0.0;
float l9_351=0.0;
float3 l9_352=l9_348.xyz;
float l9_353=l9_352.x;
float l9_354=l9_352.y;
float l9_355=l9_352.z;
l9_349=l9_353;
l9_350=l9_354;
l9_351=l9_355;
float3 l9_356=float3(0.0);
l9_356=l9_32*float3(l9_349);
float3 l9_357=float3(0.0);
float3 l9_358=(*sc_set2.UserUniforms).recolorGreen;
l9_357=l9_358;
float3 l9_359=float3(0.0);
l9_359=l9_357;
float3 l9_360=float3(0.0);
l9_360=l9_359*float3(l9_350);
float3 l9_361=float3(0.0);
float3 l9_362=(*sc_set2.UserUniforms).recolorBlue;
l9_361=l9_362;
float3 l9_363=float3(0.0);
l9_363=l9_361;
float3 l9_364=float3(0.0);
l9_364=l9_363*float3(l9_351);
float3 l9_365=float3(0.0);
l9_365=(l9_356+l9_360)+l9_364;
l9_26=l9_365;
l9_29=l9_26;
}
else
{
float4 l9_366=float4(0.0);
float4 l9_367=(*sc_set2.UserUniforms).baseColor;
l9_366=l9_367;
float4 l9_368=float4(0.0);
l9_368=l9_366;
float4 l9_369=float4(0.0);
float4 l9_370=float4(0.0);
float4 l9_371=(*sc_set2.UserUniforms).Port_Default_N369;
ssGlobals l9_372=l9_28;
float4 l9_373;
if ((int(ENABLE_BASE_TEX_tmp)!=0))
{
float2 l9_374=float2(0.0);
float2 l9_375=float2(0.0);
float2 l9_376=float2(0.0);
float2 l9_377=float2(0.0);
float2 l9_378=float2(0.0);
float2 l9_379=float2(0.0);
ssGlobals l9_380=l9_372;
float2 l9_381;
if (NODE_27_DROPLIST_ITEM_tmp==0)
{
float2 l9_382=float2(0.0);
l9_382=l9_380.Surface_UVCoord0;
l9_375=l9_382;
l9_381=l9_375;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==1)
{
float2 l9_383=float2(0.0);
l9_383=l9_380.Surface_UVCoord1;
l9_376=l9_383;
l9_381=l9_376;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==2)
{
float2 l9_384=float2(0.0);
float2 l9_385=float2(0.0);
float2 l9_386=float2(0.0);
ssGlobals l9_387=l9_380;
float2 l9_388;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_389=float2(0.0);
float2 l9_390=float2(0.0);
float2 l9_391=float2(0.0);
ssGlobals l9_392=l9_387;
float2 l9_393;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_394=float2(0.0);
float2 l9_395=float2(0.0);
float2 l9_396=float2(0.0);
float2 l9_397=float2(0.0);
float2 l9_398=float2(0.0);
ssGlobals l9_399=l9_392;
float2 l9_400;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_401=float2(0.0);
l9_401=l9_399.Surface_UVCoord0;
l9_395=l9_401;
l9_400=l9_395;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_402=float2(0.0);
l9_402=l9_399.Surface_UVCoord1;
l9_396=l9_402;
l9_400=l9_396;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_403=float2(0.0);
l9_403=l9_399.gScreenCoord;
l9_397=l9_403;
l9_400=l9_397;
}
else
{
float2 l9_404=float2(0.0);
l9_404=l9_399.Surface_UVCoord0;
l9_398=l9_404;
l9_400=l9_398;
}
}
}
l9_394=l9_400;
float2 l9_405=float2(0.0);
float2 l9_406=(*sc_set2.UserUniforms).uv2Scale;
l9_405=l9_406;
float2 l9_407=float2(0.0);
l9_407=l9_405;
float2 l9_408=float2(0.0);
float2 l9_409=(*sc_set2.UserUniforms).uv2Offset;
l9_408=l9_409;
float2 l9_410=float2(0.0);
l9_410=l9_408;
float2 l9_411=float2(0.0);
l9_411=(l9_394*l9_407)+l9_410;
float2 l9_412=float2(0.0);
l9_412=l9_411+(l9_410*(l9_392.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_390=l9_412;
l9_393=l9_390;
}
else
{
float2 l9_413=float2(0.0);
float2 l9_414=float2(0.0);
float2 l9_415=float2(0.0);
float2 l9_416=float2(0.0);
float2 l9_417=float2(0.0);
ssGlobals l9_418=l9_392;
float2 l9_419;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_420=float2(0.0);
l9_420=l9_418.Surface_UVCoord0;
l9_414=l9_420;
l9_419=l9_414;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_421=float2(0.0);
l9_421=l9_418.Surface_UVCoord1;
l9_415=l9_421;
l9_419=l9_415;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_422=float2(0.0);
l9_422=l9_418.gScreenCoord;
l9_416=l9_422;
l9_419=l9_416;
}
else
{
float2 l9_423=float2(0.0);
l9_423=l9_418.Surface_UVCoord0;
l9_417=l9_423;
l9_419=l9_417;
}
}
}
l9_413=l9_419;
float2 l9_424=float2(0.0);
float2 l9_425=(*sc_set2.UserUniforms).uv2Scale;
l9_424=l9_425;
float2 l9_426=float2(0.0);
l9_426=l9_424;
float2 l9_427=float2(0.0);
float2 l9_428=(*sc_set2.UserUniforms).uv2Offset;
l9_427=l9_428;
float2 l9_429=float2(0.0);
l9_429=l9_427;
float2 l9_430=float2(0.0);
l9_430=(l9_413*l9_426)+l9_429;
l9_391=l9_430;
l9_393=l9_391;
}
l9_389=l9_393;
l9_385=l9_389;
l9_388=l9_385;
}
else
{
float2 l9_431=float2(0.0);
l9_431=l9_387.Surface_UVCoord0;
l9_386=l9_431;
l9_388=l9_386;
}
l9_384=l9_388;
float2 l9_432=float2(0.0);
l9_432=l9_384;
float2 l9_433=float2(0.0);
l9_433=l9_432;
l9_377=l9_433;
l9_381=l9_377;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==3)
{
float2 l9_434=float2(0.0);
float2 l9_435=float2(0.0);
float2 l9_436=float2(0.0);
ssGlobals l9_437=l9_380;
float2 l9_438;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_439=float2(0.0);
float2 l9_440=float2(0.0);
float2 l9_441=float2(0.0);
ssGlobals l9_442=l9_437;
float2 l9_443;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_444=float2(0.0);
float2 l9_445=float2(0.0);
float2 l9_446=float2(0.0);
float2 l9_447=float2(0.0);
float2 l9_448=float2(0.0);
float2 l9_449=float2(0.0);
ssGlobals l9_450=l9_442;
float2 l9_451;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_452=float2(0.0);
l9_452=l9_450.Surface_UVCoord0;
l9_445=l9_452;
l9_451=l9_445;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_453=float2(0.0);
l9_453=l9_450.Surface_UVCoord1;
l9_446=l9_453;
l9_451=l9_446;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_454=float2(0.0);
l9_454=l9_450.gScreenCoord;
l9_447=l9_454;
l9_451=l9_447;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_455=float2(0.0);
float2 l9_456=float2(0.0);
float2 l9_457=float2(0.0);
ssGlobals l9_458=l9_450;
float2 l9_459;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_460=float2(0.0);
float2 l9_461=float2(0.0);
float2 l9_462=float2(0.0);
ssGlobals l9_463=l9_458;
float2 l9_464;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_465=float2(0.0);
float2 l9_466=float2(0.0);
float2 l9_467=float2(0.0);
float2 l9_468=float2(0.0);
float2 l9_469=float2(0.0);
ssGlobals l9_470=l9_463;
float2 l9_471;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_472=float2(0.0);
l9_472=l9_470.Surface_UVCoord0;
l9_466=l9_472;
l9_471=l9_466;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_473=float2(0.0);
l9_473=l9_470.Surface_UVCoord1;
l9_467=l9_473;
l9_471=l9_467;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_474=float2(0.0);
l9_474=l9_470.gScreenCoord;
l9_468=l9_474;
l9_471=l9_468;
}
else
{
float2 l9_475=float2(0.0);
l9_475=l9_470.Surface_UVCoord0;
l9_469=l9_475;
l9_471=l9_469;
}
}
}
l9_465=l9_471;
float2 l9_476=float2(0.0);
float2 l9_477=(*sc_set2.UserUniforms).uv2Scale;
l9_476=l9_477;
float2 l9_478=float2(0.0);
l9_478=l9_476;
float2 l9_479=float2(0.0);
float2 l9_480=(*sc_set2.UserUniforms).uv2Offset;
l9_479=l9_480;
float2 l9_481=float2(0.0);
l9_481=l9_479;
float2 l9_482=float2(0.0);
l9_482=(l9_465*l9_478)+l9_481;
float2 l9_483=float2(0.0);
l9_483=l9_482+(l9_481*(l9_463.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_461=l9_483;
l9_464=l9_461;
}
else
{
float2 l9_484=float2(0.0);
float2 l9_485=float2(0.0);
float2 l9_486=float2(0.0);
float2 l9_487=float2(0.0);
float2 l9_488=float2(0.0);
ssGlobals l9_489=l9_463;
float2 l9_490;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_491=float2(0.0);
l9_491=l9_489.Surface_UVCoord0;
l9_485=l9_491;
l9_490=l9_485;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_492=float2(0.0);
l9_492=l9_489.Surface_UVCoord1;
l9_486=l9_492;
l9_490=l9_486;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_493=float2(0.0);
l9_493=l9_489.gScreenCoord;
l9_487=l9_493;
l9_490=l9_487;
}
else
{
float2 l9_494=float2(0.0);
l9_494=l9_489.Surface_UVCoord0;
l9_488=l9_494;
l9_490=l9_488;
}
}
}
l9_484=l9_490;
float2 l9_495=float2(0.0);
float2 l9_496=(*sc_set2.UserUniforms).uv2Scale;
l9_495=l9_496;
float2 l9_497=float2(0.0);
l9_497=l9_495;
float2 l9_498=float2(0.0);
float2 l9_499=(*sc_set2.UserUniforms).uv2Offset;
l9_498=l9_499;
float2 l9_500=float2(0.0);
l9_500=l9_498;
float2 l9_501=float2(0.0);
l9_501=(l9_484*l9_497)+l9_500;
l9_462=l9_501;
l9_464=l9_462;
}
l9_460=l9_464;
l9_456=l9_460;
l9_459=l9_456;
}
else
{
float2 l9_502=float2(0.0);
l9_502=l9_458.Surface_UVCoord0;
l9_457=l9_502;
l9_459=l9_457;
}
l9_455=l9_459;
float2 l9_503=float2(0.0);
l9_503=l9_455;
float2 l9_504=float2(0.0);
l9_504=l9_503;
l9_448=l9_504;
l9_451=l9_448;
}
else
{
float2 l9_505=float2(0.0);
l9_505=l9_450.Surface_UVCoord0;
l9_449=l9_505;
l9_451=l9_449;
}
}
}
}
l9_444=l9_451;
float2 l9_506=float2(0.0);
float2 l9_507=(*sc_set2.UserUniforms).uv3Scale;
l9_506=l9_507;
float2 l9_508=float2(0.0);
l9_508=l9_506;
float2 l9_509=float2(0.0);
float2 l9_510=(*sc_set2.UserUniforms).uv3Offset;
l9_509=l9_510;
float2 l9_511=float2(0.0);
l9_511=l9_509;
float2 l9_512=float2(0.0);
l9_512=(l9_444*l9_508)+l9_511;
float2 l9_513=float2(0.0);
l9_513=l9_512+(l9_511*(l9_442.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_440=l9_513;
l9_443=l9_440;
}
else
{
float2 l9_514=float2(0.0);
float2 l9_515=float2(0.0);
float2 l9_516=float2(0.0);
float2 l9_517=float2(0.0);
float2 l9_518=float2(0.0);
float2 l9_519=float2(0.0);
ssGlobals l9_520=l9_442;
float2 l9_521;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_522=float2(0.0);
l9_522=l9_520.Surface_UVCoord0;
l9_515=l9_522;
l9_521=l9_515;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_523=float2(0.0);
l9_523=l9_520.Surface_UVCoord1;
l9_516=l9_523;
l9_521=l9_516;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_524=float2(0.0);
l9_524=l9_520.gScreenCoord;
l9_517=l9_524;
l9_521=l9_517;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_525=float2(0.0);
float2 l9_526=float2(0.0);
float2 l9_527=float2(0.0);
ssGlobals l9_528=l9_520;
float2 l9_529;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_530=float2(0.0);
float2 l9_531=float2(0.0);
float2 l9_532=float2(0.0);
ssGlobals l9_533=l9_528;
float2 l9_534;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_535=float2(0.0);
float2 l9_536=float2(0.0);
float2 l9_537=float2(0.0);
float2 l9_538=float2(0.0);
float2 l9_539=float2(0.0);
ssGlobals l9_540=l9_533;
float2 l9_541;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_542=float2(0.0);
l9_542=l9_540.Surface_UVCoord0;
l9_536=l9_542;
l9_541=l9_536;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_543=float2(0.0);
l9_543=l9_540.Surface_UVCoord1;
l9_537=l9_543;
l9_541=l9_537;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_544=float2(0.0);
l9_544=l9_540.gScreenCoord;
l9_538=l9_544;
l9_541=l9_538;
}
else
{
float2 l9_545=float2(0.0);
l9_545=l9_540.Surface_UVCoord0;
l9_539=l9_545;
l9_541=l9_539;
}
}
}
l9_535=l9_541;
float2 l9_546=float2(0.0);
float2 l9_547=(*sc_set2.UserUniforms).uv2Scale;
l9_546=l9_547;
float2 l9_548=float2(0.0);
l9_548=l9_546;
float2 l9_549=float2(0.0);
float2 l9_550=(*sc_set2.UserUniforms).uv2Offset;
l9_549=l9_550;
float2 l9_551=float2(0.0);
l9_551=l9_549;
float2 l9_552=float2(0.0);
l9_552=(l9_535*l9_548)+l9_551;
float2 l9_553=float2(0.0);
l9_553=l9_552+(l9_551*(l9_533.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_531=l9_553;
l9_534=l9_531;
}
else
{
float2 l9_554=float2(0.0);
float2 l9_555=float2(0.0);
float2 l9_556=float2(0.0);
float2 l9_557=float2(0.0);
float2 l9_558=float2(0.0);
ssGlobals l9_559=l9_533;
float2 l9_560;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_561=float2(0.0);
l9_561=l9_559.Surface_UVCoord0;
l9_555=l9_561;
l9_560=l9_555;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_562=float2(0.0);
l9_562=l9_559.Surface_UVCoord1;
l9_556=l9_562;
l9_560=l9_556;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_563=float2(0.0);
l9_563=l9_559.gScreenCoord;
l9_557=l9_563;
l9_560=l9_557;
}
else
{
float2 l9_564=float2(0.0);
l9_564=l9_559.Surface_UVCoord0;
l9_558=l9_564;
l9_560=l9_558;
}
}
}
l9_554=l9_560;
float2 l9_565=float2(0.0);
float2 l9_566=(*sc_set2.UserUniforms).uv2Scale;
l9_565=l9_566;
float2 l9_567=float2(0.0);
l9_567=l9_565;
float2 l9_568=float2(0.0);
float2 l9_569=(*sc_set2.UserUniforms).uv2Offset;
l9_568=l9_569;
float2 l9_570=float2(0.0);
l9_570=l9_568;
float2 l9_571=float2(0.0);
l9_571=(l9_554*l9_567)+l9_570;
l9_532=l9_571;
l9_534=l9_532;
}
l9_530=l9_534;
l9_526=l9_530;
l9_529=l9_526;
}
else
{
float2 l9_572=float2(0.0);
l9_572=l9_528.Surface_UVCoord0;
l9_527=l9_572;
l9_529=l9_527;
}
l9_525=l9_529;
float2 l9_573=float2(0.0);
l9_573=l9_525;
float2 l9_574=float2(0.0);
l9_574=l9_573;
l9_518=l9_574;
l9_521=l9_518;
}
else
{
float2 l9_575=float2(0.0);
l9_575=l9_520.Surface_UVCoord0;
l9_519=l9_575;
l9_521=l9_519;
}
}
}
}
l9_514=l9_521;
float2 l9_576=float2(0.0);
float2 l9_577=(*sc_set2.UserUniforms).uv3Scale;
l9_576=l9_577;
float2 l9_578=float2(0.0);
l9_578=l9_576;
float2 l9_579=float2(0.0);
float2 l9_580=(*sc_set2.UserUniforms).uv3Offset;
l9_579=l9_580;
float2 l9_581=float2(0.0);
l9_581=l9_579;
float2 l9_582=float2(0.0);
l9_582=(l9_514*l9_578)+l9_581;
l9_441=l9_582;
l9_443=l9_441;
}
l9_439=l9_443;
l9_435=l9_439;
l9_438=l9_435;
}
else
{
float2 l9_583=float2(0.0);
l9_583=l9_437.Surface_UVCoord0;
l9_436=l9_583;
l9_438=l9_436;
}
l9_434=l9_438;
float2 l9_584=float2(0.0);
l9_584=l9_434;
float2 l9_585=float2(0.0);
l9_585=l9_584;
l9_378=l9_585;
l9_381=l9_378;
}
else
{
float2 l9_586=float2(0.0);
l9_586=l9_380.Surface_UVCoord0;
l9_379=l9_586;
l9_381=l9_379;
}
}
}
}
l9_374=l9_381;
float4 l9_587=float4(0.0);
int l9_588=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_589=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_589=0;
}
else
{
l9_589=in.varStereoViewID;
}
int l9_590=l9_589;
l9_588=1-l9_590;
}
else
{
int l9_591=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_591=0;
}
else
{
l9_591=in.varStereoViewID;
}
int l9_592=l9_591;
l9_588=l9_592;
}
int l9_593=l9_588;
int l9_594=baseTexLayout_tmp;
int l9_595=l9_593;
float2 l9_596=l9_374;
bool l9_597=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_598=(*sc_set2.UserUniforms).baseTexTransform;
int2 l9_599=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_600=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_601=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool l9_602=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_603=(*sc_set2.UserUniforms).baseTexBorderColor;
float l9_604=0.0;
bool l9_605=l9_602&&(!l9_600);
float l9_606=1.0;
float l9_607=l9_596.x;
int l9_608=l9_599.x;
if (l9_608==1)
{
l9_607=fract(l9_607);
}
else
{
if (l9_608==2)
{
float l9_609=fract(l9_607);
float l9_610=l9_607-l9_609;
float l9_611=step(0.25,fract(l9_610*0.5));
l9_607=mix(l9_609,1.0-l9_609,fast::clamp(l9_611,0.0,1.0));
}
}
l9_596.x=l9_607;
float l9_612=l9_596.y;
int l9_613=l9_599.y;
if (l9_613==1)
{
l9_612=fract(l9_612);
}
else
{
if (l9_613==2)
{
float l9_614=fract(l9_612);
float l9_615=l9_612-l9_614;
float l9_616=step(0.25,fract(l9_615*0.5));
l9_612=mix(l9_614,1.0-l9_614,fast::clamp(l9_616,0.0,1.0));
}
}
l9_596.y=l9_612;
if (l9_600)
{
bool l9_617=l9_602;
bool l9_618;
if (l9_617)
{
l9_618=l9_599.x==3;
}
else
{
l9_618=l9_617;
}
float l9_619=l9_596.x;
float l9_620=l9_601.x;
float l9_621=l9_601.z;
bool l9_622=l9_618;
float l9_623=l9_606;
float l9_624=fast::clamp(l9_619,l9_620,l9_621);
float l9_625=step(abs(l9_619-l9_624),9.9999997e-06);
l9_623*=(l9_625+((1.0-float(l9_622))*(1.0-l9_625)));
l9_619=l9_624;
l9_596.x=l9_619;
l9_606=l9_623;
bool l9_626=l9_602;
bool l9_627;
if (l9_626)
{
l9_627=l9_599.y==3;
}
else
{
l9_627=l9_626;
}
float l9_628=l9_596.y;
float l9_629=l9_601.y;
float l9_630=l9_601.w;
bool l9_631=l9_627;
float l9_632=l9_606;
float l9_633=fast::clamp(l9_628,l9_629,l9_630);
float l9_634=step(abs(l9_628-l9_633),9.9999997e-06);
l9_632*=(l9_634+((1.0-float(l9_631))*(1.0-l9_634)));
l9_628=l9_633;
l9_596.y=l9_628;
l9_606=l9_632;
}
float2 l9_635=l9_596;
bool l9_636=l9_597;
float3x3 l9_637=l9_598;
if (l9_636)
{
l9_635=float2((l9_637*float3(l9_635,1.0)).xy);
}
float2 l9_638=l9_635;
float2 l9_639=l9_638;
float2 l9_640=l9_639;
l9_596=l9_640;
float l9_641=l9_596.x;
int l9_642=l9_599.x;
bool l9_643=l9_605;
float l9_644=l9_606;
if ((l9_642==0)||(l9_642==3))
{
float l9_645=l9_641;
float l9_646=0.0;
float l9_647=1.0;
bool l9_648=l9_643;
float l9_649=l9_644;
float l9_650=fast::clamp(l9_645,l9_646,l9_647);
float l9_651=step(abs(l9_645-l9_650),9.9999997e-06);
l9_649*=(l9_651+((1.0-float(l9_648))*(1.0-l9_651)));
l9_645=l9_650;
l9_641=l9_645;
l9_644=l9_649;
}
l9_596.x=l9_641;
l9_606=l9_644;
float l9_652=l9_596.y;
int l9_653=l9_599.y;
bool l9_654=l9_605;
float l9_655=l9_606;
if ((l9_653==0)||(l9_653==3))
{
float l9_656=l9_652;
float l9_657=0.0;
float l9_658=1.0;
bool l9_659=l9_654;
float l9_660=l9_655;
float l9_661=fast::clamp(l9_656,l9_657,l9_658);
float l9_662=step(abs(l9_656-l9_661),9.9999997e-06);
l9_660*=(l9_662+((1.0-float(l9_659))*(1.0-l9_662)));
l9_656=l9_661;
l9_652=l9_656;
l9_655=l9_660;
}
l9_596.y=l9_652;
l9_606=l9_655;
float2 l9_663=l9_596;
int l9_664=l9_594;
int l9_665=l9_595;
float l9_666=l9_604;
float2 l9_667=l9_663;
int l9_668=l9_664;
int l9_669=l9_665;
float3 l9_670=float3(0.0);
if (l9_668==0)
{
l9_670=float3(l9_667,0.0);
}
else
{
if (l9_668==1)
{
l9_670=float3(l9_667.x,(l9_667.y*0.5)+(0.5-(float(l9_669)*0.5)),0.0);
}
else
{
l9_670=float3(l9_667,float(l9_669));
}
}
float3 l9_671=l9_670;
float3 l9_672=l9_671;
float2 l9_673=l9_672.xy;
float l9_674=l9_666;
float4 l9_675=sc_set2.baseTex.sample(sc_set2.baseTexSmpSC,l9_673,bias(l9_674));
float4 l9_676=l9_675;
float4 l9_677=l9_676;
if (l9_602)
{
l9_677=mix(l9_603,l9_677,float4(l9_606));
}
float4 l9_678=l9_677;
l9_587=l9_678;
l9_370=l9_587;
l9_373=l9_370;
}
else
{
l9_373=l9_371;
}
l9_369=l9_373;
float4 l9_679=float4(0.0);
l9_679=l9_368*l9_369;
float4 l9_680=float4(0.0);
l9_680=l9_679;
float4 l9_681=float4(0.0);
l9_681=l9_680;
l9_27=l9_681.xyz;
l9_29=l9_27;
}
l9_25=l9_29;
float3 l9_682=float3(0.0);
l9_682=l9_25;
float3 l9_683=float3(0.0);
l9_683=l9_682;
float4 l9_684=float4(0.0);
l9_684=float4(l9_683.x,l9_683.y,l9_683.z,l9_684.w);
l9_684.w=(*sc_set2.UserUniforms).Port_Value2_N073;
float4 l9_685=float4(0.0);
l9_685=l9_24*l9_684;
param=l9_685;
param_2=param;
}
else
{
float3 l9_686=float3(0.0);
float3 l9_687=float3(0.0);
float3 l9_688=float3(0.0);
ssGlobals l9_689=param_3;
float3 l9_690;
if ((int(ENABLE_RECOLOR_tmp)!=0))
{
float3 l9_691=float3(0.0);
float3 l9_692=(*sc_set2.UserUniforms).recolorRed;
l9_691=l9_692;
float3 l9_693=float3(0.0);
l9_693=l9_691;
float4 l9_694=float4(0.0);
float4 l9_695=(*sc_set2.UserUniforms).baseColor;
l9_694=l9_695;
float4 l9_696=float4(0.0);
l9_696=l9_694;
float4 l9_697=float4(0.0);
float4 l9_698=float4(0.0);
float4 l9_699=(*sc_set2.UserUniforms).Port_Default_N369;
ssGlobals l9_700=l9_689;
float4 l9_701;
if ((int(ENABLE_BASE_TEX_tmp)!=0))
{
float2 l9_702=float2(0.0);
float2 l9_703=float2(0.0);
float2 l9_704=float2(0.0);
float2 l9_705=float2(0.0);
float2 l9_706=float2(0.0);
float2 l9_707=float2(0.0);
ssGlobals l9_708=l9_700;
float2 l9_709;
if (NODE_27_DROPLIST_ITEM_tmp==0)
{
float2 l9_710=float2(0.0);
l9_710=l9_708.Surface_UVCoord0;
l9_703=l9_710;
l9_709=l9_703;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==1)
{
float2 l9_711=float2(0.0);
l9_711=l9_708.Surface_UVCoord1;
l9_704=l9_711;
l9_709=l9_704;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==2)
{
float2 l9_712=float2(0.0);
float2 l9_713=float2(0.0);
float2 l9_714=float2(0.0);
ssGlobals l9_715=l9_708;
float2 l9_716;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_717=float2(0.0);
float2 l9_718=float2(0.0);
float2 l9_719=float2(0.0);
ssGlobals l9_720=l9_715;
float2 l9_721;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_722=float2(0.0);
float2 l9_723=float2(0.0);
float2 l9_724=float2(0.0);
float2 l9_725=float2(0.0);
float2 l9_726=float2(0.0);
ssGlobals l9_727=l9_720;
float2 l9_728;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_729=float2(0.0);
l9_729=l9_727.Surface_UVCoord0;
l9_723=l9_729;
l9_728=l9_723;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_730=float2(0.0);
l9_730=l9_727.Surface_UVCoord1;
l9_724=l9_730;
l9_728=l9_724;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_731=float2(0.0);
l9_731=l9_727.gScreenCoord;
l9_725=l9_731;
l9_728=l9_725;
}
else
{
float2 l9_732=float2(0.0);
l9_732=l9_727.Surface_UVCoord0;
l9_726=l9_732;
l9_728=l9_726;
}
}
}
l9_722=l9_728;
float2 l9_733=float2(0.0);
float2 l9_734=(*sc_set2.UserUniforms).uv2Scale;
l9_733=l9_734;
float2 l9_735=float2(0.0);
l9_735=l9_733;
float2 l9_736=float2(0.0);
float2 l9_737=(*sc_set2.UserUniforms).uv2Offset;
l9_736=l9_737;
float2 l9_738=float2(0.0);
l9_738=l9_736;
float2 l9_739=float2(0.0);
l9_739=(l9_722*l9_735)+l9_738;
float2 l9_740=float2(0.0);
l9_740=l9_739+(l9_738*(l9_720.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_718=l9_740;
l9_721=l9_718;
}
else
{
float2 l9_741=float2(0.0);
float2 l9_742=float2(0.0);
float2 l9_743=float2(0.0);
float2 l9_744=float2(0.0);
float2 l9_745=float2(0.0);
ssGlobals l9_746=l9_720;
float2 l9_747;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_748=float2(0.0);
l9_748=l9_746.Surface_UVCoord0;
l9_742=l9_748;
l9_747=l9_742;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_749=float2(0.0);
l9_749=l9_746.Surface_UVCoord1;
l9_743=l9_749;
l9_747=l9_743;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_750=float2(0.0);
l9_750=l9_746.gScreenCoord;
l9_744=l9_750;
l9_747=l9_744;
}
else
{
float2 l9_751=float2(0.0);
l9_751=l9_746.Surface_UVCoord0;
l9_745=l9_751;
l9_747=l9_745;
}
}
}
l9_741=l9_747;
float2 l9_752=float2(0.0);
float2 l9_753=(*sc_set2.UserUniforms).uv2Scale;
l9_752=l9_753;
float2 l9_754=float2(0.0);
l9_754=l9_752;
float2 l9_755=float2(0.0);
float2 l9_756=(*sc_set2.UserUniforms).uv2Offset;
l9_755=l9_756;
float2 l9_757=float2(0.0);
l9_757=l9_755;
float2 l9_758=float2(0.0);
l9_758=(l9_741*l9_754)+l9_757;
l9_719=l9_758;
l9_721=l9_719;
}
l9_717=l9_721;
l9_713=l9_717;
l9_716=l9_713;
}
else
{
float2 l9_759=float2(0.0);
l9_759=l9_715.Surface_UVCoord0;
l9_714=l9_759;
l9_716=l9_714;
}
l9_712=l9_716;
float2 l9_760=float2(0.0);
l9_760=l9_712;
float2 l9_761=float2(0.0);
l9_761=l9_760;
l9_705=l9_761;
l9_709=l9_705;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==3)
{
float2 l9_762=float2(0.0);
float2 l9_763=float2(0.0);
float2 l9_764=float2(0.0);
ssGlobals l9_765=l9_708;
float2 l9_766;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_767=float2(0.0);
float2 l9_768=float2(0.0);
float2 l9_769=float2(0.0);
ssGlobals l9_770=l9_765;
float2 l9_771;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_772=float2(0.0);
float2 l9_773=float2(0.0);
float2 l9_774=float2(0.0);
float2 l9_775=float2(0.0);
float2 l9_776=float2(0.0);
float2 l9_777=float2(0.0);
ssGlobals l9_778=l9_770;
float2 l9_779;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_780=float2(0.0);
l9_780=l9_778.Surface_UVCoord0;
l9_773=l9_780;
l9_779=l9_773;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_781=float2(0.0);
l9_781=l9_778.Surface_UVCoord1;
l9_774=l9_781;
l9_779=l9_774;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_782=float2(0.0);
l9_782=l9_778.gScreenCoord;
l9_775=l9_782;
l9_779=l9_775;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_783=float2(0.0);
float2 l9_784=float2(0.0);
float2 l9_785=float2(0.0);
ssGlobals l9_786=l9_778;
float2 l9_787;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_788=float2(0.0);
float2 l9_789=float2(0.0);
float2 l9_790=float2(0.0);
ssGlobals l9_791=l9_786;
float2 l9_792;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_793=float2(0.0);
float2 l9_794=float2(0.0);
float2 l9_795=float2(0.0);
float2 l9_796=float2(0.0);
float2 l9_797=float2(0.0);
ssGlobals l9_798=l9_791;
float2 l9_799;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_800=float2(0.0);
l9_800=l9_798.Surface_UVCoord0;
l9_794=l9_800;
l9_799=l9_794;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_801=float2(0.0);
l9_801=l9_798.Surface_UVCoord1;
l9_795=l9_801;
l9_799=l9_795;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_802=float2(0.0);
l9_802=l9_798.gScreenCoord;
l9_796=l9_802;
l9_799=l9_796;
}
else
{
float2 l9_803=float2(0.0);
l9_803=l9_798.Surface_UVCoord0;
l9_797=l9_803;
l9_799=l9_797;
}
}
}
l9_793=l9_799;
float2 l9_804=float2(0.0);
float2 l9_805=(*sc_set2.UserUniforms).uv2Scale;
l9_804=l9_805;
float2 l9_806=float2(0.0);
l9_806=l9_804;
float2 l9_807=float2(0.0);
float2 l9_808=(*sc_set2.UserUniforms).uv2Offset;
l9_807=l9_808;
float2 l9_809=float2(0.0);
l9_809=l9_807;
float2 l9_810=float2(0.0);
l9_810=(l9_793*l9_806)+l9_809;
float2 l9_811=float2(0.0);
l9_811=l9_810+(l9_809*(l9_791.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_789=l9_811;
l9_792=l9_789;
}
else
{
float2 l9_812=float2(0.0);
float2 l9_813=float2(0.0);
float2 l9_814=float2(0.0);
float2 l9_815=float2(0.0);
float2 l9_816=float2(0.0);
ssGlobals l9_817=l9_791;
float2 l9_818;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_819=float2(0.0);
l9_819=l9_817.Surface_UVCoord0;
l9_813=l9_819;
l9_818=l9_813;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_820=float2(0.0);
l9_820=l9_817.Surface_UVCoord1;
l9_814=l9_820;
l9_818=l9_814;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_821=float2(0.0);
l9_821=l9_817.gScreenCoord;
l9_815=l9_821;
l9_818=l9_815;
}
else
{
float2 l9_822=float2(0.0);
l9_822=l9_817.Surface_UVCoord0;
l9_816=l9_822;
l9_818=l9_816;
}
}
}
l9_812=l9_818;
float2 l9_823=float2(0.0);
float2 l9_824=(*sc_set2.UserUniforms).uv2Scale;
l9_823=l9_824;
float2 l9_825=float2(0.0);
l9_825=l9_823;
float2 l9_826=float2(0.0);
float2 l9_827=(*sc_set2.UserUniforms).uv2Offset;
l9_826=l9_827;
float2 l9_828=float2(0.0);
l9_828=l9_826;
float2 l9_829=float2(0.0);
l9_829=(l9_812*l9_825)+l9_828;
l9_790=l9_829;
l9_792=l9_790;
}
l9_788=l9_792;
l9_784=l9_788;
l9_787=l9_784;
}
else
{
float2 l9_830=float2(0.0);
l9_830=l9_786.Surface_UVCoord0;
l9_785=l9_830;
l9_787=l9_785;
}
l9_783=l9_787;
float2 l9_831=float2(0.0);
l9_831=l9_783;
float2 l9_832=float2(0.0);
l9_832=l9_831;
l9_776=l9_832;
l9_779=l9_776;
}
else
{
float2 l9_833=float2(0.0);
l9_833=l9_778.Surface_UVCoord0;
l9_777=l9_833;
l9_779=l9_777;
}
}
}
}
l9_772=l9_779;
float2 l9_834=float2(0.0);
float2 l9_835=(*sc_set2.UserUniforms).uv3Scale;
l9_834=l9_835;
float2 l9_836=float2(0.0);
l9_836=l9_834;
float2 l9_837=float2(0.0);
float2 l9_838=(*sc_set2.UserUniforms).uv3Offset;
l9_837=l9_838;
float2 l9_839=float2(0.0);
l9_839=l9_837;
float2 l9_840=float2(0.0);
l9_840=(l9_772*l9_836)+l9_839;
float2 l9_841=float2(0.0);
l9_841=l9_840+(l9_839*(l9_770.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_768=l9_841;
l9_771=l9_768;
}
else
{
float2 l9_842=float2(0.0);
float2 l9_843=float2(0.0);
float2 l9_844=float2(0.0);
float2 l9_845=float2(0.0);
float2 l9_846=float2(0.0);
float2 l9_847=float2(0.0);
ssGlobals l9_848=l9_770;
float2 l9_849;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_850=float2(0.0);
l9_850=l9_848.Surface_UVCoord0;
l9_843=l9_850;
l9_849=l9_843;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_851=float2(0.0);
l9_851=l9_848.Surface_UVCoord1;
l9_844=l9_851;
l9_849=l9_844;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_852=float2(0.0);
l9_852=l9_848.gScreenCoord;
l9_845=l9_852;
l9_849=l9_845;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_853=float2(0.0);
float2 l9_854=float2(0.0);
float2 l9_855=float2(0.0);
ssGlobals l9_856=l9_848;
float2 l9_857;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_858=float2(0.0);
float2 l9_859=float2(0.0);
float2 l9_860=float2(0.0);
ssGlobals l9_861=l9_856;
float2 l9_862;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_863=float2(0.0);
float2 l9_864=float2(0.0);
float2 l9_865=float2(0.0);
float2 l9_866=float2(0.0);
float2 l9_867=float2(0.0);
ssGlobals l9_868=l9_861;
float2 l9_869;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_870=float2(0.0);
l9_870=l9_868.Surface_UVCoord0;
l9_864=l9_870;
l9_869=l9_864;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_871=float2(0.0);
l9_871=l9_868.Surface_UVCoord1;
l9_865=l9_871;
l9_869=l9_865;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_872=float2(0.0);
l9_872=l9_868.gScreenCoord;
l9_866=l9_872;
l9_869=l9_866;
}
else
{
float2 l9_873=float2(0.0);
l9_873=l9_868.Surface_UVCoord0;
l9_867=l9_873;
l9_869=l9_867;
}
}
}
l9_863=l9_869;
float2 l9_874=float2(0.0);
float2 l9_875=(*sc_set2.UserUniforms).uv2Scale;
l9_874=l9_875;
float2 l9_876=float2(0.0);
l9_876=l9_874;
float2 l9_877=float2(0.0);
float2 l9_878=(*sc_set2.UserUniforms).uv2Offset;
l9_877=l9_878;
float2 l9_879=float2(0.0);
l9_879=l9_877;
float2 l9_880=float2(0.0);
l9_880=(l9_863*l9_876)+l9_879;
float2 l9_881=float2(0.0);
l9_881=l9_880+(l9_879*(l9_861.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_859=l9_881;
l9_862=l9_859;
}
else
{
float2 l9_882=float2(0.0);
float2 l9_883=float2(0.0);
float2 l9_884=float2(0.0);
float2 l9_885=float2(0.0);
float2 l9_886=float2(0.0);
ssGlobals l9_887=l9_861;
float2 l9_888;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_889=float2(0.0);
l9_889=l9_887.Surface_UVCoord0;
l9_883=l9_889;
l9_888=l9_883;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_890=float2(0.0);
l9_890=l9_887.Surface_UVCoord1;
l9_884=l9_890;
l9_888=l9_884;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_891=float2(0.0);
l9_891=l9_887.gScreenCoord;
l9_885=l9_891;
l9_888=l9_885;
}
else
{
float2 l9_892=float2(0.0);
l9_892=l9_887.Surface_UVCoord0;
l9_886=l9_892;
l9_888=l9_886;
}
}
}
l9_882=l9_888;
float2 l9_893=float2(0.0);
float2 l9_894=(*sc_set2.UserUniforms).uv2Scale;
l9_893=l9_894;
float2 l9_895=float2(0.0);
l9_895=l9_893;
float2 l9_896=float2(0.0);
float2 l9_897=(*sc_set2.UserUniforms).uv2Offset;
l9_896=l9_897;
float2 l9_898=float2(0.0);
l9_898=l9_896;
float2 l9_899=float2(0.0);
l9_899=(l9_882*l9_895)+l9_898;
l9_860=l9_899;
l9_862=l9_860;
}
l9_858=l9_862;
l9_854=l9_858;
l9_857=l9_854;
}
else
{
float2 l9_900=float2(0.0);
l9_900=l9_856.Surface_UVCoord0;
l9_855=l9_900;
l9_857=l9_855;
}
l9_853=l9_857;
float2 l9_901=float2(0.0);
l9_901=l9_853;
float2 l9_902=float2(0.0);
l9_902=l9_901;
l9_846=l9_902;
l9_849=l9_846;
}
else
{
float2 l9_903=float2(0.0);
l9_903=l9_848.Surface_UVCoord0;
l9_847=l9_903;
l9_849=l9_847;
}
}
}
}
l9_842=l9_849;
float2 l9_904=float2(0.0);
float2 l9_905=(*sc_set2.UserUniforms).uv3Scale;
l9_904=l9_905;
float2 l9_906=float2(0.0);
l9_906=l9_904;
float2 l9_907=float2(0.0);
float2 l9_908=(*sc_set2.UserUniforms).uv3Offset;
l9_907=l9_908;
float2 l9_909=float2(0.0);
l9_909=l9_907;
float2 l9_910=float2(0.0);
l9_910=(l9_842*l9_906)+l9_909;
l9_769=l9_910;
l9_771=l9_769;
}
l9_767=l9_771;
l9_763=l9_767;
l9_766=l9_763;
}
else
{
float2 l9_911=float2(0.0);
l9_911=l9_765.Surface_UVCoord0;
l9_764=l9_911;
l9_766=l9_764;
}
l9_762=l9_766;
float2 l9_912=float2(0.0);
l9_912=l9_762;
float2 l9_913=float2(0.0);
l9_913=l9_912;
l9_706=l9_913;
l9_709=l9_706;
}
else
{
float2 l9_914=float2(0.0);
l9_914=l9_708.Surface_UVCoord0;
l9_707=l9_914;
l9_709=l9_707;
}
}
}
}
l9_702=l9_709;
float4 l9_915=float4(0.0);
int l9_916=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_917=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_917=0;
}
else
{
l9_917=in.varStereoViewID;
}
int l9_918=l9_917;
l9_916=1-l9_918;
}
else
{
int l9_919=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_919=0;
}
else
{
l9_919=in.varStereoViewID;
}
int l9_920=l9_919;
l9_916=l9_920;
}
int l9_921=l9_916;
int l9_922=baseTexLayout_tmp;
int l9_923=l9_921;
float2 l9_924=l9_702;
bool l9_925=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_926=(*sc_set2.UserUniforms).baseTexTransform;
int2 l9_927=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_928=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_929=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool l9_930=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_931=(*sc_set2.UserUniforms).baseTexBorderColor;
float l9_932=0.0;
bool l9_933=l9_930&&(!l9_928);
float l9_934=1.0;
float l9_935=l9_924.x;
int l9_936=l9_927.x;
if (l9_936==1)
{
l9_935=fract(l9_935);
}
else
{
if (l9_936==2)
{
float l9_937=fract(l9_935);
float l9_938=l9_935-l9_937;
float l9_939=step(0.25,fract(l9_938*0.5));
l9_935=mix(l9_937,1.0-l9_937,fast::clamp(l9_939,0.0,1.0));
}
}
l9_924.x=l9_935;
float l9_940=l9_924.y;
int l9_941=l9_927.y;
if (l9_941==1)
{
l9_940=fract(l9_940);
}
else
{
if (l9_941==2)
{
float l9_942=fract(l9_940);
float l9_943=l9_940-l9_942;
float l9_944=step(0.25,fract(l9_943*0.5));
l9_940=mix(l9_942,1.0-l9_942,fast::clamp(l9_944,0.0,1.0));
}
}
l9_924.y=l9_940;
if (l9_928)
{
bool l9_945=l9_930;
bool l9_946;
if (l9_945)
{
l9_946=l9_927.x==3;
}
else
{
l9_946=l9_945;
}
float l9_947=l9_924.x;
float l9_948=l9_929.x;
float l9_949=l9_929.z;
bool l9_950=l9_946;
float l9_951=l9_934;
float l9_952=fast::clamp(l9_947,l9_948,l9_949);
float l9_953=step(abs(l9_947-l9_952),9.9999997e-06);
l9_951*=(l9_953+((1.0-float(l9_950))*(1.0-l9_953)));
l9_947=l9_952;
l9_924.x=l9_947;
l9_934=l9_951;
bool l9_954=l9_930;
bool l9_955;
if (l9_954)
{
l9_955=l9_927.y==3;
}
else
{
l9_955=l9_954;
}
float l9_956=l9_924.y;
float l9_957=l9_929.y;
float l9_958=l9_929.w;
bool l9_959=l9_955;
float l9_960=l9_934;
float l9_961=fast::clamp(l9_956,l9_957,l9_958);
float l9_962=step(abs(l9_956-l9_961),9.9999997e-06);
l9_960*=(l9_962+((1.0-float(l9_959))*(1.0-l9_962)));
l9_956=l9_961;
l9_924.y=l9_956;
l9_934=l9_960;
}
float2 l9_963=l9_924;
bool l9_964=l9_925;
float3x3 l9_965=l9_926;
if (l9_964)
{
l9_963=float2((l9_965*float3(l9_963,1.0)).xy);
}
float2 l9_966=l9_963;
float2 l9_967=l9_966;
float2 l9_968=l9_967;
l9_924=l9_968;
float l9_969=l9_924.x;
int l9_970=l9_927.x;
bool l9_971=l9_933;
float l9_972=l9_934;
if ((l9_970==0)||(l9_970==3))
{
float l9_973=l9_969;
float l9_974=0.0;
float l9_975=1.0;
bool l9_976=l9_971;
float l9_977=l9_972;
float l9_978=fast::clamp(l9_973,l9_974,l9_975);
float l9_979=step(abs(l9_973-l9_978),9.9999997e-06);
l9_977*=(l9_979+((1.0-float(l9_976))*(1.0-l9_979)));
l9_973=l9_978;
l9_969=l9_973;
l9_972=l9_977;
}
l9_924.x=l9_969;
l9_934=l9_972;
float l9_980=l9_924.y;
int l9_981=l9_927.y;
bool l9_982=l9_933;
float l9_983=l9_934;
if ((l9_981==0)||(l9_981==3))
{
float l9_984=l9_980;
float l9_985=0.0;
float l9_986=1.0;
bool l9_987=l9_982;
float l9_988=l9_983;
float l9_989=fast::clamp(l9_984,l9_985,l9_986);
float l9_990=step(abs(l9_984-l9_989),9.9999997e-06);
l9_988*=(l9_990+((1.0-float(l9_987))*(1.0-l9_990)));
l9_984=l9_989;
l9_980=l9_984;
l9_983=l9_988;
}
l9_924.y=l9_980;
l9_934=l9_983;
float2 l9_991=l9_924;
int l9_992=l9_922;
int l9_993=l9_923;
float l9_994=l9_932;
float2 l9_995=l9_991;
int l9_996=l9_992;
int l9_997=l9_993;
float3 l9_998=float3(0.0);
if (l9_996==0)
{
l9_998=float3(l9_995,0.0);
}
else
{
if (l9_996==1)
{
l9_998=float3(l9_995.x,(l9_995.y*0.5)+(0.5-(float(l9_997)*0.5)),0.0);
}
else
{
l9_998=float3(l9_995,float(l9_997));
}
}
float3 l9_999=l9_998;
float3 l9_1000=l9_999;
float2 l9_1001=l9_1000.xy;
float l9_1002=l9_994;
float4 l9_1003=sc_set2.baseTex.sample(sc_set2.baseTexSmpSC,l9_1001,bias(l9_1002));
float4 l9_1004=l9_1003;
float4 l9_1005=l9_1004;
if (l9_930)
{
l9_1005=mix(l9_931,l9_1005,float4(l9_934));
}
float4 l9_1006=l9_1005;
l9_915=l9_1006;
l9_698=l9_915;
l9_701=l9_698;
}
else
{
l9_701=l9_699;
}
l9_697=l9_701;
float4 l9_1007=float4(0.0);
l9_1007=l9_696*l9_697;
float4 l9_1008=float4(0.0);
l9_1008=l9_1007;
float4 l9_1009=float4(0.0);
l9_1009=l9_1008;
float l9_1010=0.0;
float l9_1011=0.0;
float l9_1012=0.0;
float3 l9_1013=l9_1009.xyz;
float l9_1014=l9_1013.x;
float l9_1015=l9_1013.y;
float l9_1016=l9_1013.z;
l9_1010=l9_1014;
l9_1011=l9_1015;
l9_1012=l9_1016;
float3 l9_1017=float3(0.0);
l9_1017=l9_693*float3(l9_1010);
float3 l9_1018=float3(0.0);
float3 l9_1019=(*sc_set2.UserUniforms).recolorGreen;
l9_1018=l9_1019;
float3 l9_1020=float3(0.0);
l9_1020=l9_1018;
float3 l9_1021=float3(0.0);
l9_1021=l9_1020*float3(l9_1011);
float3 l9_1022=float3(0.0);
float3 l9_1023=(*sc_set2.UserUniforms).recolorBlue;
l9_1022=l9_1023;
float3 l9_1024=float3(0.0);
l9_1024=l9_1022;
float3 l9_1025=float3(0.0);
l9_1025=l9_1024*float3(l9_1012);
float3 l9_1026=float3(0.0);
l9_1026=(l9_1017+l9_1021)+l9_1025;
l9_687=l9_1026;
l9_690=l9_687;
}
else
{
float4 l9_1027=float4(0.0);
float4 l9_1028=(*sc_set2.UserUniforms).baseColor;
l9_1027=l9_1028;
float4 l9_1029=float4(0.0);
l9_1029=l9_1027;
float4 l9_1030=float4(0.0);
float4 l9_1031=float4(0.0);
float4 l9_1032=(*sc_set2.UserUniforms).Port_Default_N369;
ssGlobals l9_1033=l9_689;
float4 l9_1034;
if ((int(ENABLE_BASE_TEX_tmp)!=0))
{
float2 l9_1035=float2(0.0);
float2 l9_1036=float2(0.0);
float2 l9_1037=float2(0.0);
float2 l9_1038=float2(0.0);
float2 l9_1039=float2(0.0);
float2 l9_1040=float2(0.0);
ssGlobals l9_1041=l9_1033;
float2 l9_1042;
if (NODE_27_DROPLIST_ITEM_tmp==0)
{
float2 l9_1043=float2(0.0);
l9_1043=l9_1041.Surface_UVCoord0;
l9_1036=l9_1043;
l9_1042=l9_1036;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==1)
{
float2 l9_1044=float2(0.0);
l9_1044=l9_1041.Surface_UVCoord1;
l9_1037=l9_1044;
l9_1042=l9_1037;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==2)
{
float2 l9_1045=float2(0.0);
float2 l9_1046=float2(0.0);
float2 l9_1047=float2(0.0);
ssGlobals l9_1048=l9_1041;
float2 l9_1049;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1050=float2(0.0);
float2 l9_1051=float2(0.0);
float2 l9_1052=float2(0.0);
ssGlobals l9_1053=l9_1048;
float2 l9_1054;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1055=float2(0.0);
float2 l9_1056=float2(0.0);
float2 l9_1057=float2(0.0);
float2 l9_1058=float2(0.0);
float2 l9_1059=float2(0.0);
ssGlobals l9_1060=l9_1053;
float2 l9_1061;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1062=float2(0.0);
l9_1062=l9_1060.Surface_UVCoord0;
l9_1056=l9_1062;
l9_1061=l9_1056;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1063=float2(0.0);
l9_1063=l9_1060.Surface_UVCoord1;
l9_1057=l9_1063;
l9_1061=l9_1057;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1064=float2(0.0);
l9_1064=l9_1060.gScreenCoord;
l9_1058=l9_1064;
l9_1061=l9_1058;
}
else
{
float2 l9_1065=float2(0.0);
l9_1065=l9_1060.Surface_UVCoord0;
l9_1059=l9_1065;
l9_1061=l9_1059;
}
}
}
l9_1055=l9_1061;
float2 l9_1066=float2(0.0);
float2 l9_1067=(*sc_set2.UserUniforms).uv2Scale;
l9_1066=l9_1067;
float2 l9_1068=float2(0.0);
l9_1068=l9_1066;
float2 l9_1069=float2(0.0);
float2 l9_1070=(*sc_set2.UserUniforms).uv2Offset;
l9_1069=l9_1070;
float2 l9_1071=float2(0.0);
l9_1071=l9_1069;
float2 l9_1072=float2(0.0);
l9_1072=(l9_1055*l9_1068)+l9_1071;
float2 l9_1073=float2(0.0);
l9_1073=l9_1072+(l9_1071*(l9_1053.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1051=l9_1073;
l9_1054=l9_1051;
}
else
{
float2 l9_1074=float2(0.0);
float2 l9_1075=float2(0.0);
float2 l9_1076=float2(0.0);
float2 l9_1077=float2(0.0);
float2 l9_1078=float2(0.0);
ssGlobals l9_1079=l9_1053;
float2 l9_1080;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1081=float2(0.0);
l9_1081=l9_1079.Surface_UVCoord0;
l9_1075=l9_1081;
l9_1080=l9_1075;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1082=float2(0.0);
l9_1082=l9_1079.Surface_UVCoord1;
l9_1076=l9_1082;
l9_1080=l9_1076;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1083=float2(0.0);
l9_1083=l9_1079.gScreenCoord;
l9_1077=l9_1083;
l9_1080=l9_1077;
}
else
{
float2 l9_1084=float2(0.0);
l9_1084=l9_1079.Surface_UVCoord0;
l9_1078=l9_1084;
l9_1080=l9_1078;
}
}
}
l9_1074=l9_1080;
float2 l9_1085=float2(0.0);
float2 l9_1086=(*sc_set2.UserUniforms).uv2Scale;
l9_1085=l9_1086;
float2 l9_1087=float2(0.0);
l9_1087=l9_1085;
float2 l9_1088=float2(0.0);
float2 l9_1089=(*sc_set2.UserUniforms).uv2Offset;
l9_1088=l9_1089;
float2 l9_1090=float2(0.0);
l9_1090=l9_1088;
float2 l9_1091=float2(0.0);
l9_1091=(l9_1074*l9_1087)+l9_1090;
l9_1052=l9_1091;
l9_1054=l9_1052;
}
l9_1050=l9_1054;
l9_1046=l9_1050;
l9_1049=l9_1046;
}
else
{
float2 l9_1092=float2(0.0);
l9_1092=l9_1048.Surface_UVCoord0;
l9_1047=l9_1092;
l9_1049=l9_1047;
}
l9_1045=l9_1049;
float2 l9_1093=float2(0.0);
l9_1093=l9_1045;
float2 l9_1094=float2(0.0);
l9_1094=l9_1093;
l9_1038=l9_1094;
l9_1042=l9_1038;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==3)
{
float2 l9_1095=float2(0.0);
float2 l9_1096=float2(0.0);
float2 l9_1097=float2(0.0);
ssGlobals l9_1098=l9_1041;
float2 l9_1099;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_1100=float2(0.0);
float2 l9_1101=float2(0.0);
float2 l9_1102=float2(0.0);
ssGlobals l9_1103=l9_1098;
float2 l9_1104;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_1105=float2(0.0);
float2 l9_1106=float2(0.0);
float2 l9_1107=float2(0.0);
float2 l9_1108=float2(0.0);
float2 l9_1109=float2(0.0);
float2 l9_1110=float2(0.0);
ssGlobals l9_1111=l9_1103;
float2 l9_1112;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_1113=float2(0.0);
l9_1113=l9_1111.Surface_UVCoord0;
l9_1106=l9_1113;
l9_1112=l9_1106;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_1114=float2(0.0);
l9_1114=l9_1111.Surface_UVCoord1;
l9_1107=l9_1114;
l9_1112=l9_1107;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_1115=float2(0.0);
l9_1115=l9_1111.gScreenCoord;
l9_1108=l9_1115;
l9_1112=l9_1108;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_1116=float2(0.0);
float2 l9_1117=float2(0.0);
float2 l9_1118=float2(0.0);
ssGlobals l9_1119=l9_1111;
float2 l9_1120;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1121=float2(0.0);
float2 l9_1122=float2(0.0);
float2 l9_1123=float2(0.0);
ssGlobals l9_1124=l9_1119;
float2 l9_1125;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1126=float2(0.0);
float2 l9_1127=float2(0.0);
float2 l9_1128=float2(0.0);
float2 l9_1129=float2(0.0);
float2 l9_1130=float2(0.0);
ssGlobals l9_1131=l9_1124;
float2 l9_1132;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1133=float2(0.0);
l9_1133=l9_1131.Surface_UVCoord0;
l9_1127=l9_1133;
l9_1132=l9_1127;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1134=float2(0.0);
l9_1134=l9_1131.Surface_UVCoord1;
l9_1128=l9_1134;
l9_1132=l9_1128;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1135=float2(0.0);
l9_1135=l9_1131.gScreenCoord;
l9_1129=l9_1135;
l9_1132=l9_1129;
}
else
{
float2 l9_1136=float2(0.0);
l9_1136=l9_1131.Surface_UVCoord0;
l9_1130=l9_1136;
l9_1132=l9_1130;
}
}
}
l9_1126=l9_1132;
float2 l9_1137=float2(0.0);
float2 l9_1138=(*sc_set2.UserUniforms).uv2Scale;
l9_1137=l9_1138;
float2 l9_1139=float2(0.0);
l9_1139=l9_1137;
float2 l9_1140=float2(0.0);
float2 l9_1141=(*sc_set2.UserUniforms).uv2Offset;
l9_1140=l9_1141;
float2 l9_1142=float2(0.0);
l9_1142=l9_1140;
float2 l9_1143=float2(0.0);
l9_1143=(l9_1126*l9_1139)+l9_1142;
float2 l9_1144=float2(0.0);
l9_1144=l9_1143+(l9_1142*(l9_1124.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1122=l9_1144;
l9_1125=l9_1122;
}
else
{
float2 l9_1145=float2(0.0);
float2 l9_1146=float2(0.0);
float2 l9_1147=float2(0.0);
float2 l9_1148=float2(0.0);
float2 l9_1149=float2(0.0);
ssGlobals l9_1150=l9_1124;
float2 l9_1151;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1152=float2(0.0);
l9_1152=l9_1150.Surface_UVCoord0;
l9_1146=l9_1152;
l9_1151=l9_1146;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1153=float2(0.0);
l9_1153=l9_1150.Surface_UVCoord1;
l9_1147=l9_1153;
l9_1151=l9_1147;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1154=float2(0.0);
l9_1154=l9_1150.gScreenCoord;
l9_1148=l9_1154;
l9_1151=l9_1148;
}
else
{
float2 l9_1155=float2(0.0);
l9_1155=l9_1150.Surface_UVCoord0;
l9_1149=l9_1155;
l9_1151=l9_1149;
}
}
}
l9_1145=l9_1151;
float2 l9_1156=float2(0.0);
float2 l9_1157=(*sc_set2.UserUniforms).uv2Scale;
l9_1156=l9_1157;
float2 l9_1158=float2(0.0);
l9_1158=l9_1156;
float2 l9_1159=float2(0.0);
float2 l9_1160=(*sc_set2.UserUniforms).uv2Offset;
l9_1159=l9_1160;
float2 l9_1161=float2(0.0);
l9_1161=l9_1159;
float2 l9_1162=float2(0.0);
l9_1162=(l9_1145*l9_1158)+l9_1161;
l9_1123=l9_1162;
l9_1125=l9_1123;
}
l9_1121=l9_1125;
l9_1117=l9_1121;
l9_1120=l9_1117;
}
else
{
float2 l9_1163=float2(0.0);
l9_1163=l9_1119.Surface_UVCoord0;
l9_1118=l9_1163;
l9_1120=l9_1118;
}
l9_1116=l9_1120;
float2 l9_1164=float2(0.0);
l9_1164=l9_1116;
float2 l9_1165=float2(0.0);
l9_1165=l9_1164;
l9_1109=l9_1165;
l9_1112=l9_1109;
}
else
{
float2 l9_1166=float2(0.0);
l9_1166=l9_1111.Surface_UVCoord0;
l9_1110=l9_1166;
l9_1112=l9_1110;
}
}
}
}
l9_1105=l9_1112;
float2 l9_1167=float2(0.0);
float2 l9_1168=(*sc_set2.UserUniforms).uv3Scale;
l9_1167=l9_1168;
float2 l9_1169=float2(0.0);
l9_1169=l9_1167;
float2 l9_1170=float2(0.0);
float2 l9_1171=(*sc_set2.UserUniforms).uv3Offset;
l9_1170=l9_1171;
float2 l9_1172=float2(0.0);
l9_1172=l9_1170;
float2 l9_1173=float2(0.0);
l9_1173=(l9_1105*l9_1169)+l9_1172;
float2 l9_1174=float2(0.0);
l9_1174=l9_1173+(l9_1172*(l9_1103.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_1101=l9_1174;
l9_1104=l9_1101;
}
else
{
float2 l9_1175=float2(0.0);
float2 l9_1176=float2(0.0);
float2 l9_1177=float2(0.0);
float2 l9_1178=float2(0.0);
float2 l9_1179=float2(0.0);
float2 l9_1180=float2(0.0);
ssGlobals l9_1181=l9_1103;
float2 l9_1182;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_1183=float2(0.0);
l9_1183=l9_1181.Surface_UVCoord0;
l9_1176=l9_1183;
l9_1182=l9_1176;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_1184=float2(0.0);
l9_1184=l9_1181.Surface_UVCoord1;
l9_1177=l9_1184;
l9_1182=l9_1177;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_1185=float2(0.0);
l9_1185=l9_1181.gScreenCoord;
l9_1178=l9_1185;
l9_1182=l9_1178;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_1186=float2(0.0);
float2 l9_1187=float2(0.0);
float2 l9_1188=float2(0.0);
ssGlobals l9_1189=l9_1181;
float2 l9_1190;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1191=float2(0.0);
float2 l9_1192=float2(0.0);
float2 l9_1193=float2(0.0);
ssGlobals l9_1194=l9_1189;
float2 l9_1195;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1196=float2(0.0);
float2 l9_1197=float2(0.0);
float2 l9_1198=float2(0.0);
float2 l9_1199=float2(0.0);
float2 l9_1200=float2(0.0);
ssGlobals l9_1201=l9_1194;
float2 l9_1202;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1203=float2(0.0);
l9_1203=l9_1201.Surface_UVCoord0;
l9_1197=l9_1203;
l9_1202=l9_1197;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1204=float2(0.0);
l9_1204=l9_1201.Surface_UVCoord1;
l9_1198=l9_1204;
l9_1202=l9_1198;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1205=float2(0.0);
l9_1205=l9_1201.gScreenCoord;
l9_1199=l9_1205;
l9_1202=l9_1199;
}
else
{
float2 l9_1206=float2(0.0);
l9_1206=l9_1201.Surface_UVCoord0;
l9_1200=l9_1206;
l9_1202=l9_1200;
}
}
}
l9_1196=l9_1202;
float2 l9_1207=float2(0.0);
float2 l9_1208=(*sc_set2.UserUniforms).uv2Scale;
l9_1207=l9_1208;
float2 l9_1209=float2(0.0);
l9_1209=l9_1207;
float2 l9_1210=float2(0.0);
float2 l9_1211=(*sc_set2.UserUniforms).uv2Offset;
l9_1210=l9_1211;
float2 l9_1212=float2(0.0);
l9_1212=l9_1210;
float2 l9_1213=float2(0.0);
l9_1213=(l9_1196*l9_1209)+l9_1212;
float2 l9_1214=float2(0.0);
l9_1214=l9_1213+(l9_1212*(l9_1194.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1192=l9_1214;
l9_1195=l9_1192;
}
else
{
float2 l9_1215=float2(0.0);
float2 l9_1216=float2(0.0);
float2 l9_1217=float2(0.0);
float2 l9_1218=float2(0.0);
float2 l9_1219=float2(0.0);
ssGlobals l9_1220=l9_1194;
float2 l9_1221;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1222=float2(0.0);
l9_1222=l9_1220.Surface_UVCoord0;
l9_1216=l9_1222;
l9_1221=l9_1216;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1223=float2(0.0);
l9_1223=l9_1220.Surface_UVCoord1;
l9_1217=l9_1223;
l9_1221=l9_1217;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1224=float2(0.0);
l9_1224=l9_1220.gScreenCoord;
l9_1218=l9_1224;
l9_1221=l9_1218;
}
else
{
float2 l9_1225=float2(0.0);
l9_1225=l9_1220.Surface_UVCoord0;
l9_1219=l9_1225;
l9_1221=l9_1219;
}
}
}
l9_1215=l9_1221;
float2 l9_1226=float2(0.0);
float2 l9_1227=(*sc_set2.UserUniforms).uv2Scale;
l9_1226=l9_1227;
float2 l9_1228=float2(0.0);
l9_1228=l9_1226;
float2 l9_1229=float2(0.0);
float2 l9_1230=(*sc_set2.UserUniforms).uv2Offset;
l9_1229=l9_1230;
float2 l9_1231=float2(0.0);
l9_1231=l9_1229;
float2 l9_1232=float2(0.0);
l9_1232=(l9_1215*l9_1228)+l9_1231;
l9_1193=l9_1232;
l9_1195=l9_1193;
}
l9_1191=l9_1195;
l9_1187=l9_1191;
l9_1190=l9_1187;
}
else
{
float2 l9_1233=float2(0.0);
l9_1233=l9_1189.Surface_UVCoord0;
l9_1188=l9_1233;
l9_1190=l9_1188;
}
l9_1186=l9_1190;
float2 l9_1234=float2(0.0);
l9_1234=l9_1186;
float2 l9_1235=float2(0.0);
l9_1235=l9_1234;
l9_1179=l9_1235;
l9_1182=l9_1179;
}
else
{
float2 l9_1236=float2(0.0);
l9_1236=l9_1181.Surface_UVCoord0;
l9_1180=l9_1236;
l9_1182=l9_1180;
}
}
}
}
l9_1175=l9_1182;
float2 l9_1237=float2(0.0);
float2 l9_1238=(*sc_set2.UserUniforms).uv3Scale;
l9_1237=l9_1238;
float2 l9_1239=float2(0.0);
l9_1239=l9_1237;
float2 l9_1240=float2(0.0);
float2 l9_1241=(*sc_set2.UserUniforms).uv3Offset;
l9_1240=l9_1241;
float2 l9_1242=float2(0.0);
l9_1242=l9_1240;
float2 l9_1243=float2(0.0);
l9_1243=(l9_1175*l9_1239)+l9_1242;
l9_1102=l9_1243;
l9_1104=l9_1102;
}
l9_1100=l9_1104;
l9_1096=l9_1100;
l9_1099=l9_1096;
}
else
{
float2 l9_1244=float2(0.0);
l9_1244=l9_1098.Surface_UVCoord0;
l9_1097=l9_1244;
l9_1099=l9_1097;
}
l9_1095=l9_1099;
float2 l9_1245=float2(0.0);
l9_1245=l9_1095;
float2 l9_1246=float2(0.0);
l9_1246=l9_1245;
l9_1039=l9_1246;
l9_1042=l9_1039;
}
else
{
float2 l9_1247=float2(0.0);
l9_1247=l9_1041.Surface_UVCoord0;
l9_1040=l9_1247;
l9_1042=l9_1040;
}
}
}
}
l9_1035=l9_1042;
float4 l9_1248=float4(0.0);
int l9_1249=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_1250=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1250=0;
}
else
{
l9_1250=in.varStereoViewID;
}
int l9_1251=l9_1250;
l9_1249=1-l9_1251;
}
else
{
int l9_1252=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1252=0;
}
else
{
l9_1252=in.varStereoViewID;
}
int l9_1253=l9_1252;
l9_1249=l9_1253;
}
int l9_1254=l9_1249;
int l9_1255=baseTexLayout_tmp;
int l9_1256=l9_1254;
float2 l9_1257=l9_1035;
bool l9_1258=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_1259=(*sc_set2.UserUniforms).baseTexTransform;
int2 l9_1260=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_1261=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_1262=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool l9_1263=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_1264=(*sc_set2.UserUniforms).baseTexBorderColor;
float l9_1265=0.0;
bool l9_1266=l9_1263&&(!l9_1261);
float l9_1267=1.0;
float l9_1268=l9_1257.x;
int l9_1269=l9_1260.x;
if (l9_1269==1)
{
l9_1268=fract(l9_1268);
}
else
{
if (l9_1269==2)
{
float l9_1270=fract(l9_1268);
float l9_1271=l9_1268-l9_1270;
float l9_1272=step(0.25,fract(l9_1271*0.5));
l9_1268=mix(l9_1270,1.0-l9_1270,fast::clamp(l9_1272,0.0,1.0));
}
}
l9_1257.x=l9_1268;
float l9_1273=l9_1257.y;
int l9_1274=l9_1260.y;
if (l9_1274==1)
{
l9_1273=fract(l9_1273);
}
else
{
if (l9_1274==2)
{
float l9_1275=fract(l9_1273);
float l9_1276=l9_1273-l9_1275;
float l9_1277=step(0.25,fract(l9_1276*0.5));
l9_1273=mix(l9_1275,1.0-l9_1275,fast::clamp(l9_1277,0.0,1.0));
}
}
l9_1257.y=l9_1273;
if (l9_1261)
{
bool l9_1278=l9_1263;
bool l9_1279;
if (l9_1278)
{
l9_1279=l9_1260.x==3;
}
else
{
l9_1279=l9_1278;
}
float l9_1280=l9_1257.x;
float l9_1281=l9_1262.x;
float l9_1282=l9_1262.z;
bool l9_1283=l9_1279;
float l9_1284=l9_1267;
float l9_1285=fast::clamp(l9_1280,l9_1281,l9_1282);
float l9_1286=step(abs(l9_1280-l9_1285),9.9999997e-06);
l9_1284*=(l9_1286+((1.0-float(l9_1283))*(1.0-l9_1286)));
l9_1280=l9_1285;
l9_1257.x=l9_1280;
l9_1267=l9_1284;
bool l9_1287=l9_1263;
bool l9_1288;
if (l9_1287)
{
l9_1288=l9_1260.y==3;
}
else
{
l9_1288=l9_1287;
}
float l9_1289=l9_1257.y;
float l9_1290=l9_1262.y;
float l9_1291=l9_1262.w;
bool l9_1292=l9_1288;
float l9_1293=l9_1267;
float l9_1294=fast::clamp(l9_1289,l9_1290,l9_1291);
float l9_1295=step(abs(l9_1289-l9_1294),9.9999997e-06);
l9_1293*=(l9_1295+((1.0-float(l9_1292))*(1.0-l9_1295)));
l9_1289=l9_1294;
l9_1257.y=l9_1289;
l9_1267=l9_1293;
}
float2 l9_1296=l9_1257;
bool l9_1297=l9_1258;
float3x3 l9_1298=l9_1259;
if (l9_1297)
{
l9_1296=float2((l9_1298*float3(l9_1296,1.0)).xy);
}
float2 l9_1299=l9_1296;
float2 l9_1300=l9_1299;
float2 l9_1301=l9_1300;
l9_1257=l9_1301;
float l9_1302=l9_1257.x;
int l9_1303=l9_1260.x;
bool l9_1304=l9_1266;
float l9_1305=l9_1267;
if ((l9_1303==0)||(l9_1303==3))
{
float l9_1306=l9_1302;
float l9_1307=0.0;
float l9_1308=1.0;
bool l9_1309=l9_1304;
float l9_1310=l9_1305;
float l9_1311=fast::clamp(l9_1306,l9_1307,l9_1308);
float l9_1312=step(abs(l9_1306-l9_1311),9.9999997e-06);
l9_1310*=(l9_1312+((1.0-float(l9_1309))*(1.0-l9_1312)));
l9_1306=l9_1311;
l9_1302=l9_1306;
l9_1305=l9_1310;
}
l9_1257.x=l9_1302;
l9_1267=l9_1305;
float l9_1313=l9_1257.y;
int l9_1314=l9_1260.y;
bool l9_1315=l9_1266;
float l9_1316=l9_1267;
if ((l9_1314==0)||(l9_1314==3))
{
float l9_1317=l9_1313;
float l9_1318=0.0;
float l9_1319=1.0;
bool l9_1320=l9_1315;
float l9_1321=l9_1316;
float l9_1322=fast::clamp(l9_1317,l9_1318,l9_1319);
float l9_1323=step(abs(l9_1317-l9_1322),9.9999997e-06);
l9_1321*=(l9_1323+((1.0-float(l9_1320))*(1.0-l9_1323)));
l9_1317=l9_1322;
l9_1313=l9_1317;
l9_1316=l9_1321;
}
l9_1257.y=l9_1313;
l9_1267=l9_1316;
float2 l9_1324=l9_1257;
int l9_1325=l9_1255;
int l9_1326=l9_1256;
float l9_1327=l9_1265;
float2 l9_1328=l9_1324;
int l9_1329=l9_1325;
int l9_1330=l9_1326;
float3 l9_1331=float3(0.0);
if (l9_1329==0)
{
l9_1331=float3(l9_1328,0.0);
}
else
{
if (l9_1329==1)
{
l9_1331=float3(l9_1328.x,(l9_1328.y*0.5)+(0.5-(float(l9_1330)*0.5)),0.0);
}
else
{
l9_1331=float3(l9_1328,float(l9_1330));
}
}
float3 l9_1332=l9_1331;
float3 l9_1333=l9_1332;
float2 l9_1334=l9_1333.xy;
float l9_1335=l9_1327;
float4 l9_1336=sc_set2.baseTex.sample(sc_set2.baseTexSmpSC,l9_1334,bias(l9_1335));
float4 l9_1337=l9_1336;
float4 l9_1338=l9_1337;
if (l9_1263)
{
l9_1338=mix(l9_1264,l9_1338,float4(l9_1267));
}
float4 l9_1339=l9_1338;
l9_1248=l9_1339;
l9_1031=l9_1248;
l9_1034=l9_1031;
}
else
{
l9_1034=l9_1032;
}
l9_1030=l9_1034;
float4 l9_1340=float4(0.0);
l9_1340=l9_1029*l9_1030;
float4 l9_1341=float4(0.0);
l9_1341=l9_1340;
float4 l9_1342=float4(0.0);
l9_1342=l9_1341;
l9_688=l9_1342.xyz;
l9_690=l9_688;
}
l9_686=l9_690;
float3 l9_1343=float3(0.0);
l9_1343=l9_686;
float3 l9_1344=float3(0.0);
l9_1344=l9_1343;
float4 l9_1345=float4(0.0);
l9_1345=float4(l9_1344.x,l9_1344.y,l9_1344.z,l9_1345.w);
l9_1345.w=(*sc_set2.UserUniforms).Port_Value2_N073;
param_1=l9_1345;
param_2=param_1;
}
Result_N363=param_2;
float4 Export_N364=float4(0.0);
Export_N364=Result_N363;
float3 Result_N97=float3(0.0);
float3 param_4=float3(0.0);
float3 param_5=(*sc_set2.UserUniforms).Port_Default_N097;
ssGlobals param_7=Globals;
float3 param_6;
if ((NODE_38_DROPLIST_ITEM_tmp==2)||(int(ENABLE_EMISSIVE_tmp)!=0))
{
float3 l9_1346=float3(0.0);
float3 l9_1347=float3(0.0);
float3 l9_1348=float3(0.0);
ssGlobals l9_1349=param_7;
float3 l9_1350;
if (NODE_38_DROPLIST_ITEM_tmp==2)
{
float4 l9_1351=float4(0.0);
l9_1351=l9_1349.VertexColor;
float3 l9_1352=float3(0.0);
float3 l9_1353=float3(0.0);
float3 l9_1354=(*sc_set2.UserUniforms).Port_Default_N132;
ssGlobals l9_1355=l9_1349;
float3 l9_1356;
if ((int(ENABLE_EMISSIVE_tmp)!=0))
{
float2 l9_1357=float2(0.0);
float2 l9_1358=float2(0.0);
float2 l9_1359=float2(0.0);
float2 l9_1360=float2(0.0);
float2 l9_1361=float2(0.0);
float2 l9_1362=float2(0.0);
ssGlobals l9_1363=l9_1355;
float2 l9_1364;
if (NODE_76_DROPLIST_ITEM_tmp==0)
{
float2 l9_1365=float2(0.0);
l9_1365=l9_1363.Surface_UVCoord0;
l9_1358=l9_1365;
l9_1364=l9_1358;
}
else
{
if (NODE_76_DROPLIST_ITEM_tmp==1)
{
float2 l9_1366=float2(0.0);
l9_1366=l9_1363.Surface_UVCoord1;
l9_1359=l9_1366;
l9_1364=l9_1359;
}
else
{
if (NODE_76_DROPLIST_ITEM_tmp==2)
{
float2 l9_1367=float2(0.0);
float2 l9_1368=float2(0.0);
float2 l9_1369=float2(0.0);
ssGlobals l9_1370=l9_1363;
float2 l9_1371;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1372=float2(0.0);
float2 l9_1373=float2(0.0);
float2 l9_1374=float2(0.0);
ssGlobals l9_1375=l9_1370;
float2 l9_1376;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1377=float2(0.0);
float2 l9_1378=float2(0.0);
float2 l9_1379=float2(0.0);
float2 l9_1380=float2(0.0);
float2 l9_1381=float2(0.0);
ssGlobals l9_1382=l9_1375;
float2 l9_1383;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1384=float2(0.0);
l9_1384=l9_1382.Surface_UVCoord0;
l9_1378=l9_1384;
l9_1383=l9_1378;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1385=float2(0.0);
l9_1385=l9_1382.Surface_UVCoord1;
l9_1379=l9_1385;
l9_1383=l9_1379;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1386=float2(0.0);
l9_1386=l9_1382.gScreenCoord;
l9_1380=l9_1386;
l9_1383=l9_1380;
}
else
{
float2 l9_1387=float2(0.0);
l9_1387=l9_1382.Surface_UVCoord0;
l9_1381=l9_1387;
l9_1383=l9_1381;
}
}
}
l9_1377=l9_1383;
float2 l9_1388=float2(0.0);
float2 l9_1389=(*sc_set2.UserUniforms).uv2Scale;
l9_1388=l9_1389;
float2 l9_1390=float2(0.0);
l9_1390=l9_1388;
float2 l9_1391=float2(0.0);
float2 l9_1392=(*sc_set2.UserUniforms).uv2Offset;
l9_1391=l9_1392;
float2 l9_1393=float2(0.0);
l9_1393=l9_1391;
float2 l9_1394=float2(0.0);
l9_1394=(l9_1377*l9_1390)+l9_1393;
float2 l9_1395=float2(0.0);
l9_1395=l9_1394+(l9_1393*(l9_1375.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1373=l9_1395;
l9_1376=l9_1373;
}
else
{
float2 l9_1396=float2(0.0);
float2 l9_1397=float2(0.0);
float2 l9_1398=float2(0.0);
float2 l9_1399=float2(0.0);
float2 l9_1400=float2(0.0);
ssGlobals l9_1401=l9_1375;
float2 l9_1402;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1403=float2(0.0);
l9_1403=l9_1401.Surface_UVCoord0;
l9_1397=l9_1403;
l9_1402=l9_1397;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1404=float2(0.0);
l9_1404=l9_1401.Surface_UVCoord1;
l9_1398=l9_1404;
l9_1402=l9_1398;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1405=float2(0.0);
l9_1405=l9_1401.gScreenCoord;
l9_1399=l9_1405;
l9_1402=l9_1399;
}
else
{
float2 l9_1406=float2(0.0);
l9_1406=l9_1401.Surface_UVCoord0;
l9_1400=l9_1406;
l9_1402=l9_1400;
}
}
}
l9_1396=l9_1402;
float2 l9_1407=float2(0.0);
float2 l9_1408=(*sc_set2.UserUniforms).uv2Scale;
l9_1407=l9_1408;
float2 l9_1409=float2(0.0);
l9_1409=l9_1407;
float2 l9_1410=float2(0.0);
float2 l9_1411=(*sc_set2.UserUniforms).uv2Offset;
l9_1410=l9_1411;
float2 l9_1412=float2(0.0);
l9_1412=l9_1410;
float2 l9_1413=float2(0.0);
l9_1413=(l9_1396*l9_1409)+l9_1412;
l9_1374=l9_1413;
l9_1376=l9_1374;
}
l9_1372=l9_1376;
l9_1368=l9_1372;
l9_1371=l9_1368;
}
else
{
float2 l9_1414=float2(0.0);
l9_1414=l9_1370.Surface_UVCoord0;
l9_1369=l9_1414;
l9_1371=l9_1369;
}
l9_1367=l9_1371;
float2 l9_1415=float2(0.0);
l9_1415=l9_1367;
float2 l9_1416=float2(0.0);
l9_1416=l9_1415;
l9_1360=l9_1416;
l9_1364=l9_1360;
}
else
{
if (NODE_76_DROPLIST_ITEM_tmp==3)
{
float2 l9_1417=float2(0.0);
float2 l9_1418=float2(0.0);
float2 l9_1419=float2(0.0);
ssGlobals l9_1420=l9_1363;
float2 l9_1421;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_1422=float2(0.0);
float2 l9_1423=float2(0.0);
float2 l9_1424=float2(0.0);
ssGlobals l9_1425=l9_1420;
float2 l9_1426;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_1427=float2(0.0);
float2 l9_1428=float2(0.0);
float2 l9_1429=float2(0.0);
float2 l9_1430=float2(0.0);
float2 l9_1431=float2(0.0);
float2 l9_1432=float2(0.0);
ssGlobals l9_1433=l9_1425;
float2 l9_1434;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_1435=float2(0.0);
l9_1435=l9_1433.Surface_UVCoord0;
l9_1428=l9_1435;
l9_1434=l9_1428;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_1436=float2(0.0);
l9_1436=l9_1433.Surface_UVCoord1;
l9_1429=l9_1436;
l9_1434=l9_1429;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_1437=float2(0.0);
l9_1437=l9_1433.gScreenCoord;
l9_1430=l9_1437;
l9_1434=l9_1430;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_1438=float2(0.0);
float2 l9_1439=float2(0.0);
float2 l9_1440=float2(0.0);
ssGlobals l9_1441=l9_1433;
float2 l9_1442;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1443=float2(0.0);
float2 l9_1444=float2(0.0);
float2 l9_1445=float2(0.0);
ssGlobals l9_1446=l9_1441;
float2 l9_1447;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1448=float2(0.0);
float2 l9_1449=float2(0.0);
float2 l9_1450=float2(0.0);
float2 l9_1451=float2(0.0);
float2 l9_1452=float2(0.0);
ssGlobals l9_1453=l9_1446;
float2 l9_1454;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1455=float2(0.0);
l9_1455=l9_1453.Surface_UVCoord0;
l9_1449=l9_1455;
l9_1454=l9_1449;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1456=float2(0.0);
l9_1456=l9_1453.Surface_UVCoord1;
l9_1450=l9_1456;
l9_1454=l9_1450;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1457=float2(0.0);
l9_1457=l9_1453.gScreenCoord;
l9_1451=l9_1457;
l9_1454=l9_1451;
}
else
{
float2 l9_1458=float2(0.0);
l9_1458=l9_1453.Surface_UVCoord0;
l9_1452=l9_1458;
l9_1454=l9_1452;
}
}
}
l9_1448=l9_1454;
float2 l9_1459=float2(0.0);
float2 l9_1460=(*sc_set2.UserUniforms).uv2Scale;
l9_1459=l9_1460;
float2 l9_1461=float2(0.0);
l9_1461=l9_1459;
float2 l9_1462=float2(0.0);
float2 l9_1463=(*sc_set2.UserUniforms).uv2Offset;
l9_1462=l9_1463;
float2 l9_1464=float2(0.0);
l9_1464=l9_1462;
float2 l9_1465=float2(0.0);
l9_1465=(l9_1448*l9_1461)+l9_1464;
float2 l9_1466=float2(0.0);
l9_1466=l9_1465+(l9_1464*(l9_1446.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1444=l9_1466;
l9_1447=l9_1444;
}
else
{
float2 l9_1467=float2(0.0);
float2 l9_1468=float2(0.0);
float2 l9_1469=float2(0.0);
float2 l9_1470=float2(0.0);
float2 l9_1471=float2(0.0);
ssGlobals l9_1472=l9_1446;
float2 l9_1473;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1474=float2(0.0);
l9_1474=l9_1472.Surface_UVCoord0;
l9_1468=l9_1474;
l9_1473=l9_1468;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1475=float2(0.0);
l9_1475=l9_1472.Surface_UVCoord1;
l9_1469=l9_1475;
l9_1473=l9_1469;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1476=float2(0.0);
l9_1476=l9_1472.gScreenCoord;
l9_1470=l9_1476;
l9_1473=l9_1470;
}
else
{
float2 l9_1477=float2(0.0);
l9_1477=l9_1472.Surface_UVCoord0;
l9_1471=l9_1477;
l9_1473=l9_1471;
}
}
}
l9_1467=l9_1473;
float2 l9_1478=float2(0.0);
float2 l9_1479=(*sc_set2.UserUniforms).uv2Scale;
l9_1478=l9_1479;
float2 l9_1480=float2(0.0);
l9_1480=l9_1478;
float2 l9_1481=float2(0.0);
float2 l9_1482=(*sc_set2.UserUniforms).uv2Offset;
l9_1481=l9_1482;
float2 l9_1483=float2(0.0);
l9_1483=l9_1481;
float2 l9_1484=float2(0.0);
l9_1484=(l9_1467*l9_1480)+l9_1483;
l9_1445=l9_1484;
l9_1447=l9_1445;
}
l9_1443=l9_1447;
l9_1439=l9_1443;
l9_1442=l9_1439;
}
else
{
float2 l9_1485=float2(0.0);
l9_1485=l9_1441.Surface_UVCoord0;
l9_1440=l9_1485;
l9_1442=l9_1440;
}
l9_1438=l9_1442;
float2 l9_1486=float2(0.0);
l9_1486=l9_1438;
float2 l9_1487=float2(0.0);
l9_1487=l9_1486;
l9_1431=l9_1487;
l9_1434=l9_1431;
}
else
{
float2 l9_1488=float2(0.0);
l9_1488=l9_1433.Surface_UVCoord0;
l9_1432=l9_1488;
l9_1434=l9_1432;
}
}
}
}
l9_1427=l9_1434;
float2 l9_1489=float2(0.0);
float2 l9_1490=(*sc_set2.UserUniforms).uv3Scale;
l9_1489=l9_1490;
float2 l9_1491=float2(0.0);
l9_1491=l9_1489;
float2 l9_1492=float2(0.0);
float2 l9_1493=(*sc_set2.UserUniforms).uv3Offset;
l9_1492=l9_1493;
float2 l9_1494=float2(0.0);
l9_1494=l9_1492;
float2 l9_1495=float2(0.0);
l9_1495=(l9_1427*l9_1491)+l9_1494;
float2 l9_1496=float2(0.0);
l9_1496=l9_1495+(l9_1494*(l9_1425.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_1423=l9_1496;
l9_1426=l9_1423;
}
else
{
float2 l9_1497=float2(0.0);
float2 l9_1498=float2(0.0);
float2 l9_1499=float2(0.0);
float2 l9_1500=float2(0.0);
float2 l9_1501=float2(0.0);
float2 l9_1502=float2(0.0);
ssGlobals l9_1503=l9_1425;
float2 l9_1504;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_1505=float2(0.0);
l9_1505=l9_1503.Surface_UVCoord0;
l9_1498=l9_1505;
l9_1504=l9_1498;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_1506=float2(0.0);
l9_1506=l9_1503.Surface_UVCoord1;
l9_1499=l9_1506;
l9_1504=l9_1499;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_1507=float2(0.0);
l9_1507=l9_1503.gScreenCoord;
l9_1500=l9_1507;
l9_1504=l9_1500;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_1508=float2(0.0);
float2 l9_1509=float2(0.0);
float2 l9_1510=float2(0.0);
ssGlobals l9_1511=l9_1503;
float2 l9_1512;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1513=float2(0.0);
float2 l9_1514=float2(0.0);
float2 l9_1515=float2(0.0);
ssGlobals l9_1516=l9_1511;
float2 l9_1517;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1518=float2(0.0);
float2 l9_1519=float2(0.0);
float2 l9_1520=float2(0.0);
float2 l9_1521=float2(0.0);
float2 l9_1522=float2(0.0);
ssGlobals l9_1523=l9_1516;
float2 l9_1524;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1525=float2(0.0);
l9_1525=l9_1523.Surface_UVCoord0;
l9_1519=l9_1525;
l9_1524=l9_1519;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1526=float2(0.0);
l9_1526=l9_1523.Surface_UVCoord1;
l9_1520=l9_1526;
l9_1524=l9_1520;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1527=float2(0.0);
l9_1527=l9_1523.gScreenCoord;
l9_1521=l9_1527;
l9_1524=l9_1521;
}
else
{
float2 l9_1528=float2(0.0);
l9_1528=l9_1523.Surface_UVCoord0;
l9_1522=l9_1528;
l9_1524=l9_1522;
}
}
}
l9_1518=l9_1524;
float2 l9_1529=float2(0.0);
float2 l9_1530=(*sc_set2.UserUniforms).uv2Scale;
l9_1529=l9_1530;
float2 l9_1531=float2(0.0);
l9_1531=l9_1529;
float2 l9_1532=float2(0.0);
float2 l9_1533=(*sc_set2.UserUniforms).uv2Offset;
l9_1532=l9_1533;
float2 l9_1534=float2(0.0);
l9_1534=l9_1532;
float2 l9_1535=float2(0.0);
l9_1535=(l9_1518*l9_1531)+l9_1534;
float2 l9_1536=float2(0.0);
l9_1536=l9_1535+(l9_1534*(l9_1516.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1514=l9_1536;
l9_1517=l9_1514;
}
else
{
float2 l9_1537=float2(0.0);
float2 l9_1538=float2(0.0);
float2 l9_1539=float2(0.0);
float2 l9_1540=float2(0.0);
float2 l9_1541=float2(0.0);
ssGlobals l9_1542=l9_1516;
float2 l9_1543;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1544=float2(0.0);
l9_1544=l9_1542.Surface_UVCoord0;
l9_1538=l9_1544;
l9_1543=l9_1538;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1545=float2(0.0);
l9_1545=l9_1542.Surface_UVCoord1;
l9_1539=l9_1545;
l9_1543=l9_1539;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1546=float2(0.0);
l9_1546=l9_1542.gScreenCoord;
l9_1540=l9_1546;
l9_1543=l9_1540;
}
else
{
float2 l9_1547=float2(0.0);
l9_1547=l9_1542.Surface_UVCoord0;
l9_1541=l9_1547;
l9_1543=l9_1541;
}
}
}
l9_1537=l9_1543;
float2 l9_1548=float2(0.0);
float2 l9_1549=(*sc_set2.UserUniforms).uv2Scale;
l9_1548=l9_1549;
float2 l9_1550=float2(0.0);
l9_1550=l9_1548;
float2 l9_1551=float2(0.0);
float2 l9_1552=(*sc_set2.UserUniforms).uv2Offset;
l9_1551=l9_1552;
float2 l9_1553=float2(0.0);
l9_1553=l9_1551;
float2 l9_1554=float2(0.0);
l9_1554=(l9_1537*l9_1550)+l9_1553;
l9_1515=l9_1554;
l9_1517=l9_1515;
}
l9_1513=l9_1517;
l9_1509=l9_1513;
l9_1512=l9_1509;
}
else
{
float2 l9_1555=float2(0.0);
l9_1555=l9_1511.Surface_UVCoord0;
l9_1510=l9_1555;
l9_1512=l9_1510;
}
l9_1508=l9_1512;
float2 l9_1556=float2(0.0);
l9_1556=l9_1508;
float2 l9_1557=float2(0.0);
l9_1557=l9_1556;
l9_1501=l9_1557;
l9_1504=l9_1501;
}
else
{
float2 l9_1558=float2(0.0);
l9_1558=l9_1503.Surface_UVCoord0;
l9_1502=l9_1558;
l9_1504=l9_1502;
}
}
}
}
l9_1497=l9_1504;
float2 l9_1559=float2(0.0);
float2 l9_1560=(*sc_set2.UserUniforms).uv3Scale;
l9_1559=l9_1560;
float2 l9_1561=float2(0.0);
l9_1561=l9_1559;
float2 l9_1562=float2(0.0);
float2 l9_1563=(*sc_set2.UserUniforms).uv3Offset;
l9_1562=l9_1563;
float2 l9_1564=float2(0.0);
l9_1564=l9_1562;
float2 l9_1565=float2(0.0);
l9_1565=(l9_1497*l9_1561)+l9_1564;
l9_1424=l9_1565;
l9_1426=l9_1424;
}
l9_1422=l9_1426;
l9_1418=l9_1422;
l9_1421=l9_1418;
}
else
{
float2 l9_1566=float2(0.0);
l9_1566=l9_1420.Surface_UVCoord0;
l9_1419=l9_1566;
l9_1421=l9_1419;
}
l9_1417=l9_1421;
float2 l9_1567=float2(0.0);
l9_1567=l9_1417;
float2 l9_1568=float2(0.0);
l9_1568=l9_1567;
l9_1361=l9_1568;
l9_1364=l9_1361;
}
else
{
float2 l9_1569=float2(0.0);
l9_1569=l9_1363.Surface_UVCoord0;
l9_1362=l9_1569;
l9_1364=l9_1362;
}
}
}
}
l9_1357=l9_1364;
float4 l9_1570=float4(0.0);
int l9_1571=0;
if ((int(emissiveTexHasSwappedViews_tmp)!=0))
{
int l9_1572=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1572=0;
}
else
{
l9_1572=in.varStereoViewID;
}
int l9_1573=l9_1572;
l9_1571=1-l9_1573;
}
else
{
int l9_1574=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1574=0;
}
else
{
l9_1574=in.varStereoViewID;
}
int l9_1575=l9_1574;
l9_1571=l9_1575;
}
int l9_1576=l9_1571;
int l9_1577=emissiveTexLayout_tmp;
int l9_1578=l9_1576;
float2 l9_1579=l9_1357;
bool l9_1580=(int(SC_USE_UV_TRANSFORM_emissiveTex_tmp)!=0);
float3x3 l9_1581=(*sc_set2.UserUniforms).emissiveTexTransform;
int2 l9_1582=int2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex_tmp,SC_SOFTWARE_WRAP_MODE_V_emissiveTex_tmp);
bool l9_1583=(int(SC_USE_UV_MIN_MAX_emissiveTex_tmp)!=0);
float4 l9_1584=(*sc_set2.UserUniforms).emissiveTexUvMinMax;
bool l9_1585=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex_tmp)!=0);
float4 l9_1586=(*sc_set2.UserUniforms).emissiveTexBorderColor;
float l9_1587=0.0;
bool l9_1588=l9_1585&&(!l9_1583);
float l9_1589=1.0;
float l9_1590=l9_1579.x;
int l9_1591=l9_1582.x;
if (l9_1591==1)
{
l9_1590=fract(l9_1590);
}
else
{
if (l9_1591==2)
{
float l9_1592=fract(l9_1590);
float l9_1593=l9_1590-l9_1592;
float l9_1594=step(0.25,fract(l9_1593*0.5));
l9_1590=mix(l9_1592,1.0-l9_1592,fast::clamp(l9_1594,0.0,1.0));
}
}
l9_1579.x=l9_1590;
float l9_1595=l9_1579.y;
int l9_1596=l9_1582.y;
if (l9_1596==1)
{
l9_1595=fract(l9_1595);
}
else
{
if (l9_1596==2)
{
float l9_1597=fract(l9_1595);
float l9_1598=l9_1595-l9_1597;
float l9_1599=step(0.25,fract(l9_1598*0.5));
l9_1595=mix(l9_1597,1.0-l9_1597,fast::clamp(l9_1599,0.0,1.0));
}
}
l9_1579.y=l9_1595;
if (l9_1583)
{
bool l9_1600=l9_1585;
bool l9_1601;
if (l9_1600)
{
l9_1601=l9_1582.x==3;
}
else
{
l9_1601=l9_1600;
}
float l9_1602=l9_1579.x;
float l9_1603=l9_1584.x;
float l9_1604=l9_1584.z;
bool l9_1605=l9_1601;
float l9_1606=l9_1589;
float l9_1607=fast::clamp(l9_1602,l9_1603,l9_1604);
float l9_1608=step(abs(l9_1602-l9_1607),9.9999997e-06);
l9_1606*=(l9_1608+((1.0-float(l9_1605))*(1.0-l9_1608)));
l9_1602=l9_1607;
l9_1579.x=l9_1602;
l9_1589=l9_1606;
bool l9_1609=l9_1585;
bool l9_1610;
if (l9_1609)
{
l9_1610=l9_1582.y==3;
}
else
{
l9_1610=l9_1609;
}
float l9_1611=l9_1579.y;
float l9_1612=l9_1584.y;
float l9_1613=l9_1584.w;
bool l9_1614=l9_1610;
float l9_1615=l9_1589;
float l9_1616=fast::clamp(l9_1611,l9_1612,l9_1613);
float l9_1617=step(abs(l9_1611-l9_1616),9.9999997e-06);
l9_1615*=(l9_1617+((1.0-float(l9_1614))*(1.0-l9_1617)));
l9_1611=l9_1616;
l9_1579.y=l9_1611;
l9_1589=l9_1615;
}
float2 l9_1618=l9_1579;
bool l9_1619=l9_1580;
float3x3 l9_1620=l9_1581;
if (l9_1619)
{
l9_1618=float2((l9_1620*float3(l9_1618,1.0)).xy);
}
float2 l9_1621=l9_1618;
float2 l9_1622=l9_1621;
float2 l9_1623=l9_1622;
l9_1579=l9_1623;
float l9_1624=l9_1579.x;
int l9_1625=l9_1582.x;
bool l9_1626=l9_1588;
float l9_1627=l9_1589;
if ((l9_1625==0)||(l9_1625==3))
{
float l9_1628=l9_1624;
float l9_1629=0.0;
float l9_1630=1.0;
bool l9_1631=l9_1626;
float l9_1632=l9_1627;
float l9_1633=fast::clamp(l9_1628,l9_1629,l9_1630);
float l9_1634=step(abs(l9_1628-l9_1633),9.9999997e-06);
l9_1632*=(l9_1634+((1.0-float(l9_1631))*(1.0-l9_1634)));
l9_1628=l9_1633;
l9_1624=l9_1628;
l9_1627=l9_1632;
}
l9_1579.x=l9_1624;
l9_1589=l9_1627;
float l9_1635=l9_1579.y;
int l9_1636=l9_1582.y;
bool l9_1637=l9_1588;
float l9_1638=l9_1589;
if ((l9_1636==0)||(l9_1636==3))
{
float l9_1639=l9_1635;
float l9_1640=0.0;
float l9_1641=1.0;
bool l9_1642=l9_1637;
float l9_1643=l9_1638;
float l9_1644=fast::clamp(l9_1639,l9_1640,l9_1641);
float l9_1645=step(abs(l9_1639-l9_1644),9.9999997e-06);
l9_1643*=(l9_1645+((1.0-float(l9_1642))*(1.0-l9_1645)));
l9_1639=l9_1644;
l9_1635=l9_1639;
l9_1638=l9_1643;
}
l9_1579.y=l9_1635;
l9_1589=l9_1638;
float2 l9_1646=l9_1579;
int l9_1647=l9_1577;
int l9_1648=l9_1578;
float l9_1649=l9_1587;
float2 l9_1650=l9_1646;
int l9_1651=l9_1647;
int l9_1652=l9_1648;
float3 l9_1653=float3(0.0);
if (l9_1651==0)
{
l9_1653=float3(l9_1650,0.0);
}
else
{
if (l9_1651==1)
{
l9_1653=float3(l9_1650.x,(l9_1650.y*0.5)+(0.5-(float(l9_1652)*0.5)),0.0);
}
else
{
l9_1653=float3(l9_1650,float(l9_1652));
}
}
float3 l9_1654=l9_1653;
float3 l9_1655=l9_1654;
float2 l9_1656=l9_1655.xy;
float l9_1657=l9_1649;
float4 l9_1658=sc_set2.emissiveTex.sample(sc_set2.emissiveTexSmpSC,l9_1656,bias(l9_1657));
float4 l9_1659=l9_1658;
float4 l9_1660=l9_1659;
if (l9_1585)
{
l9_1660=mix(l9_1586,l9_1660,float4(l9_1589));
}
float4 l9_1661=l9_1660;
l9_1570=l9_1661;
l9_1353=l9_1570.xyz;
l9_1356=l9_1353;
}
else
{
l9_1356=l9_1354;
}
l9_1352=l9_1356;
float3 l9_1662=float3(0.0);
l9_1662=l9_1351.xyz+l9_1352;
l9_1347=l9_1662;
l9_1350=l9_1347;
}
else
{
float3 l9_1663=float3(0.0);
float3 l9_1664=float3(0.0);
float3 l9_1665=(*sc_set2.UserUniforms).Port_Default_N132;
ssGlobals l9_1666=l9_1349;
float3 l9_1667;
if ((int(ENABLE_EMISSIVE_tmp)!=0))
{
float2 l9_1668=float2(0.0);
float2 l9_1669=float2(0.0);
float2 l9_1670=float2(0.0);
float2 l9_1671=float2(0.0);
float2 l9_1672=float2(0.0);
float2 l9_1673=float2(0.0);
ssGlobals l9_1674=l9_1666;
float2 l9_1675;
if (NODE_76_DROPLIST_ITEM_tmp==0)
{
float2 l9_1676=float2(0.0);
l9_1676=l9_1674.Surface_UVCoord0;
l9_1669=l9_1676;
l9_1675=l9_1669;
}
else
{
if (NODE_76_DROPLIST_ITEM_tmp==1)
{
float2 l9_1677=float2(0.0);
l9_1677=l9_1674.Surface_UVCoord1;
l9_1670=l9_1677;
l9_1675=l9_1670;
}
else
{
if (NODE_76_DROPLIST_ITEM_tmp==2)
{
float2 l9_1678=float2(0.0);
float2 l9_1679=float2(0.0);
float2 l9_1680=float2(0.0);
ssGlobals l9_1681=l9_1674;
float2 l9_1682;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1683=float2(0.0);
float2 l9_1684=float2(0.0);
float2 l9_1685=float2(0.0);
ssGlobals l9_1686=l9_1681;
float2 l9_1687;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1688=float2(0.0);
float2 l9_1689=float2(0.0);
float2 l9_1690=float2(0.0);
float2 l9_1691=float2(0.0);
float2 l9_1692=float2(0.0);
ssGlobals l9_1693=l9_1686;
float2 l9_1694;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1695=float2(0.0);
l9_1695=l9_1693.Surface_UVCoord0;
l9_1689=l9_1695;
l9_1694=l9_1689;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1696=float2(0.0);
l9_1696=l9_1693.Surface_UVCoord1;
l9_1690=l9_1696;
l9_1694=l9_1690;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1697=float2(0.0);
l9_1697=l9_1693.gScreenCoord;
l9_1691=l9_1697;
l9_1694=l9_1691;
}
else
{
float2 l9_1698=float2(0.0);
l9_1698=l9_1693.Surface_UVCoord0;
l9_1692=l9_1698;
l9_1694=l9_1692;
}
}
}
l9_1688=l9_1694;
float2 l9_1699=float2(0.0);
float2 l9_1700=(*sc_set2.UserUniforms).uv2Scale;
l9_1699=l9_1700;
float2 l9_1701=float2(0.0);
l9_1701=l9_1699;
float2 l9_1702=float2(0.0);
float2 l9_1703=(*sc_set2.UserUniforms).uv2Offset;
l9_1702=l9_1703;
float2 l9_1704=float2(0.0);
l9_1704=l9_1702;
float2 l9_1705=float2(0.0);
l9_1705=(l9_1688*l9_1701)+l9_1704;
float2 l9_1706=float2(0.0);
l9_1706=l9_1705+(l9_1704*(l9_1686.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1684=l9_1706;
l9_1687=l9_1684;
}
else
{
float2 l9_1707=float2(0.0);
float2 l9_1708=float2(0.0);
float2 l9_1709=float2(0.0);
float2 l9_1710=float2(0.0);
float2 l9_1711=float2(0.0);
ssGlobals l9_1712=l9_1686;
float2 l9_1713;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1714=float2(0.0);
l9_1714=l9_1712.Surface_UVCoord0;
l9_1708=l9_1714;
l9_1713=l9_1708;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1715=float2(0.0);
l9_1715=l9_1712.Surface_UVCoord1;
l9_1709=l9_1715;
l9_1713=l9_1709;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1716=float2(0.0);
l9_1716=l9_1712.gScreenCoord;
l9_1710=l9_1716;
l9_1713=l9_1710;
}
else
{
float2 l9_1717=float2(0.0);
l9_1717=l9_1712.Surface_UVCoord0;
l9_1711=l9_1717;
l9_1713=l9_1711;
}
}
}
l9_1707=l9_1713;
float2 l9_1718=float2(0.0);
float2 l9_1719=(*sc_set2.UserUniforms).uv2Scale;
l9_1718=l9_1719;
float2 l9_1720=float2(0.0);
l9_1720=l9_1718;
float2 l9_1721=float2(0.0);
float2 l9_1722=(*sc_set2.UserUniforms).uv2Offset;
l9_1721=l9_1722;
float2 l9_1723=float2(0.0);
l9_1723=l9_1721;
float2 l9_1724=float2(0.0);
l9_1724=(l9_1707*l9_1720)+l9_1723;
l9_1685=l9_1724;
l9_1687=l9_1685;
}
l9_1683=l9_1687;
l9_1679=l9_1683;
l9_1682=l9_1679;
}
else
{
float2 l9_1725=float2(0.0);
l9_1725=l9_1681.Surface_UVCoord0;
l9_1680=l9_1725;
l9_1682=l9_1680;
}
l9_1678=l9_1682;
float2 l9_1726=float2(0.0);
l9_1726=l9_1678;
float2 l9_1727=float2(0.0);
l9_1727=l9_1726;
l9_1671=l9_1727;
l9_1675=l9_1671;
}
else
{
if (NODE_76_DROPLIST_ITEM_tmp==3)
{
float2 l9_1728=float2(0.0);
float2 l9_1729=float2(0.0);
float2 l9_1730=float2(0.0);
ssGlobals l9_1731=l9_1674;
float2 l9_1732;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_1733=float2(0.0);
float2 l9_1734=float2(0.0);
float2 l9_1735=float2(0.0);
ssGlobals l9_1736=l9_1731;
float2 l9_1737;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_1738=float2(0.0);
float2 l9_1739=float2(0.0);
float2 l9_1740=float2(0.0);
float2 l9_1741=float2(0.0);
float2 l9_1742=float2(0.0);
float2 l9_1743=float2(0.0);
ssGlobals l9_1744=l9_1736;
float2 l9_1745;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_1746=float2(0.0);
l9_1746=l9_1744.Surface_UVCoord0;
l9_1739=l9_1746;
l9_1745=l9_1739;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_1747=float2(0.0);
l9_1747=l9_1744.Surface_UVCoord1;
l9_1740=l9_1747;
l9_1745=l9_1740;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_1748=float2(0.0);
l9_1748=l9_1744.gScreenCoord;
l9_1741=l9_1748;
l9_1745=l9_1741;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_1749=float2(0.0);
float2 l9_1750=float2(0.0);
float2 l9_1751=float2(0.0);
ssGlobals l9_1752=l9_1744;
float2 l9_1753;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1754=float2(0.0);
float2 l9_1755=float2(0.0);
float2 l9_1756=float2(0.0);
ssGlobals l9_1757=l9_1752;
float2 l9_1758;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1759=float2(0.0);
float2 l9_1760=float2(0.0);
float2 l9_1761=float2(0.0);
float2 l9_1762=float2(0.0);
float2 l9_1763=float2(0.0);
ssGlobals l9_1764=l9_1757;
float2 l9_1765;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1766=float2(0.0);
l9_1766=l9_1764.Surface_UVCoord0;
l9_1760=l9_1766;
l9_1765=l9_1760;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1767=float2(0.0);
l9_1767=l9_1764.Surface_UVCoord1;
l9_1761=l9_1767;
l9_1765=l9_1761;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1768=float2(0.0);
l9_1768=l9_1764.gScreenCoord;
l9_1762=l9_1768;
l9_1765=l9_1762;
}
else
{
float2 l9_1769=float2(0.0);
l9_1769=l9_1764.Surface_UVCoord0;
l9_1763=l9_1769;
l9_1765=l9_1763;
}
}
}
l9_1759=l9_1765;
float2 l9_1770=float2(0.0);
float2 l9_1771=(*sc_set2.UserUniforms).uv2Scale;
l9_1770=l9_1771;
float2 l9_1772=float2(0.0);
l9_1772=l9_1770;
float2 l9_1773=float2(0.0);
float2 l9_1774=(*sc_set2.UserUniforms).uv2Offset;
l9_1773=l9_1774;
float2 l9_1775=float2(0.0);
l9_1775=l9_1773;
float2 l9_1776=float2(0.0);
l9_1776=(l9_1759*l9_1772)+l9_1775;
float2 l9_1777=float2(0.0);
l9_1777=l9_1776+(l9_1775*(l9_1757.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1755=l9_1777;
l9_1758=l9_1755;
}
else
{
float2 l9_1778=float2(0.0);
float2 l9_1779=float2(0.0);
float2 l9_1780=float2(0.0);
float2 l9_1781=float2(0.0);
float2 l9_1782=float2(0.0);
ssGlobals l9_1783=l9_1757;
float2 l9_1784;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1785=float2(0.0);
l9_1785=l9_1783.Surface_UVCoord0;
l9_1779=l9_1785;
l9_1784=l9_1779;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1786=float2(0.0);
l9_1786=l9_1783.Surface_UVCoord1;
l9_1780=l9_1786;
l9_1784=l9_1780;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1787=float2(0.0);
l9_1787=l9_1783.gScreenCoord;
l9_1781=l9_1787;
l9_1784=l9_1781;
}
else
{
float2 l9_1788=float2(0.0);
l9_1788=l9_1783.Surface_UVCoord0;
l9_1782=l9_1788;
l9_1784=l9_1782;
}
}
}
l9_1778=l9_1784;
float2 l9_1789=float2(0.0);
float2 l9_1790=(*sc_set2.UserUniforms).uv2Scale;
l9_1789=l9_1790;
float2 l9_1791=float2(0.0);
l9_1791=l9_1789;
float2 l9_1792=float2(0.0);
float2 l9_1793=(*sc_set2.UserUniforms).uv2Offset;
l9_1792=l9_1793;
float2 l9_1794=float2(0.0);
l9_1794=l9_1792;
float2 l9_1795=float2(0.0);
l9_1795=(l9_1778*l9_1791)+l9_1794;
l9_1756=l9_1795;
l9_1758=l9_1756;
}
l9_1754=l9_1758;
l9_1750=l9_1754;
l9_1753=l9_1750;
}
else
{
float2 l9_1796=float2(0.0);
l9_1796=l9_1752.Surface_UVCoord0;
l9_1751=l9_1796;
l9_1753=l9_1751;
}
l9_1749=l9_1753;
float2 l9_1797=float2(0.0);
l9_1797=l9_1749;
float2 l9_1798=float2(0.0);
l9_1798=l9_1797;
l9_1742=l9_1798;
l9_1745=l9_1742;
}
else
{
float2 l9_1799=float2(0.0);
l9_1799=l9_1744.Surface_UVCoord0;
l9_1743=l9_1799;
l9_1745=l9_1743;
}
}
}
}
l9_1738=l9_1745;
float2 l9_1800=float2(0.0);
float2 l9_1801=(*sc_set2.UserUniforms).uv3Scale;
l9_1800=l9_1801;
float2 l9_1802=float2(0.0);
l9_1802=l9_1800;
float2 l9_1803=float2(0.0);
float2 l9_1804=(*sc_set2.UserUniforms).uv3Offset;
l9_1803=l9_1804;
float2 l9_1805=float2(0.0);
l9_1805=l9_1803;
float2 l9_1806=float2(0.0);
l9_1806=(l9_1738*l9_1802)+l9_1805;
float2 l9_1807=float2(0.0);
l9_1807=l9_1806+(l9_1805*(l9_1736.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_1734=l9_1807;
l9_1737=l9_1734;
}
else
{
float2 l9_1808=float2(0.0);
float2 l9_1809=float2(0.0);
float2 l9_1810=float2(0.0);
float2 l9_1811=float2(0.0);
float2 l9_1812=float2(0.0);
float2 l9_1813=float2(0.0);
ssGlobals l9_1814=l9_1736;
float2 l9_1815;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_1816=float2(0.0);
l9_1816=l9_1814.Surface_UVCoord0;
l9_1809=l9_1816;
l9_1815=l9_1809;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_1817=float2(0.0);
l9_1817=l9_1814.Surface_UVCoord1;
l9_1810=l9_1817;
l9_1815=l9_1810;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_1818=float2(0.0);
l9_1818=l9_1814.gScreenCoord;
l9_1811=l9_1818;
l9_1815=l9_1811;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_1819=float2(0.0);
float2 l9_1820=float2(0.0);
float2 l9_1821=float2(0.0);
ssGlobals l9_1822=l9_1814;
float2 l9_1823;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_1824=float2(0.0);
float2 l9_1825=float2(0.0);
float2 l9_1826=float2(0.0);
ssGlobals l9_1827=l9_1822;
float2 l9_1828;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_1829=float2(0.0);
float2 l9_1830=float2(0.0);
float2 l9_1831=float2(0.0);
float2 l9_1832=float2(0.0);
float2 l9_1833=float2(0.0);
ssGlobals l9_1834=l9_1827;
float2 l9_1835;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1836=float2(0.0);
l9_1836=l9_1834.Surface_UVCoord0;
l9_1830=l9_1836;
l9_1835=l9_1830;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1837=float2(0.0);
l9_1837=l9_1834.Surface_UVCoord1;
l9_1831=l9_1837;
l9_1835=l9_1831;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1838=float2(0.0);
l9_1838=l9_1834.gScreenCoord;
l9_1832=l9_1838;
l9_1835=l9_1832;
}
else
{
float2 l9_1839=float2(0.0);
l9_1839=l9_1834.Surface_UVCoord0;
l9_1833=l9_1839;
l9_1835=l9_1833;
}
}
}
l9_1829=l9_1835;
float2 l9_1840=float2(0.0);
float2 l9_1841=(*sc_set2.UserUniforms).uv2Scale;
l9_1840=l9_1841;
float2 l9_1842=float2(0.0);
l9_1842=l9_1840;
float2 l9_1843=float2(0.0);
float2 l9_1844=(*sc_set2.UserUniforms).uv2Offset;
l9_1843=l9_1844;
float2 l9_1845=float2(0.0);
l9_1845=l9_1843;
float2 l9_1846=float2(0.0);
l9_1846=(l9_1829*l9_1842)+l9_1845;
float2 l9_1847=float2(0.0);
l9_1847=l9_1846+(l9_1845*(l9_1827.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_1825=l9_1847;
l9_1828=l9_1825;
}
else
{
float2 l9_1848=float2(0.0);
float2 l9_1849=float2(0.0);
float2 l9_1850=float2(0.0);
float2 l9_1851=float2(0.0);
float2 l9_1852=float2(0.0);
ssGlobals l9_1853=l9_1827;
float2 l9_1854;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_1855=float2(0.0);
l9_1855=l9_1853.Surface_UVCoord0;
l9_1849=l9_1855;
l9_1854=l9_1849;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_1856=float2(0.0);
l9_1856=l9_1853.Surface_UVCoord1;
l9_1850=l9_1856;
l9_1854=l9_1850;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_1857=float2(0.0);
l9_1857=l9_1853.gScreenCoord;
l9_1851=l9_1857;
l9_1854=l9_1851;
}
else
{
float2 l9_1858=float2(0.0);
l9_1858=l9_1853.Surface_UVCoord0;
l9_1852=l9_1858;
l9_1854=l9_1852;
}
}
}
l9_1848=l9_1854;
float2 l9_1859=float2(0.0);
float2 l9_1860=(*sc_set2.UserUniforms).uv2Scale;
l9_1859=l9_1860;
float2 l9_1861=float2(0.0);
l9_1861=l9_1859;
float2 l9_1862=float2(0.0);
float2 l9_1863=(*sc_set2.UserUniforms).uv2Offset;
l9_1862=l9_1863;
float2 l9_1864=float2(0.0);
l9_1864=l9_1862;
float2 l9_1865=float2(0.0);
l9_1865=(l9_1848*l9_1861)+l9_1864;
l9_1826=l9_1865;
l9_1828=l9_1826;
}
l9_1824=l9_1828;
l9_1820=l9_1824;
l9_1823=l9_1820;
}
else
{
float2 l9_1866=float2(0.0);
l9_1866=l9_1822.Surface_UVCoord0;
l9_1821=l9_1866;
l9_1823=l9_1821;
}
l9_1819=l9_1823;
float2 l9_1867=float2(0.0);
l9_1867=l9_1819;
float2 l9_1868=float2(0.0);
l9_1868=l9_1867;
l9_1812=l9_1868;
l9_1815=l9_1812;
}
else
{
float2 l9_1869=float2(0.0);
l9_1869=l9_1814.Surface_UVCoord0;
l9_1813=l9_1869;
l9_1815=l9_1813;
}
}
}
}
l9_1808=l9_1815;
float2 l9_1870=float2(0.0);
float2 l9_1871=(*sc_set2.UserUniforms).uv3Scale;
l9_1870=l9_1871;
float2 l9_1872=float2(0.0);
l9_1872=l9_1870;
float2 l9_1873=float2(0.0);
float2 l9_1874=(*sc_set2.UserUniforms).uv3Offset;
l9_1873=l9_1874;
float2 l9_1875=float2(0.0);
l9_1875=l9_1873;
float2 l9_1876=float2(0.0);
l9_1876=(l9_1808*l9_1872)+l9_1875;
l9_1735=l9_1876;
l9_1737=l9_1735;
}
l9_1733=l9_1737;
l9_1729=l9_1733;
l9_1732=l9_1729;
}
else
{
float2 l9_1877=float2(0.0);
l9_1877=l9_1731.Surface_UVCoord0;
l9_1730=l9_1877;
l9_1732=l9_1730;
}
l9_1728=l9_1732;
float2 l9_1878=float2(0.0);
l9_1878=l9_1728;
float2 l9_1879=float2(0.0);
l9_1879=l9_1878;
l9_1672=l9_1879;
l9_1675=l9_1672;
}
else
{
float2 l9_1880=float2(0.0);
l9_1880=l9_1674.Surface_UVCoord0;
l9_1673=l9_1880;
l9_1675=l9_1673;
}
}
}
}
l9_1668=l9_1675;
float4 l9_1881=float4(0.0);
int l9_1882=0;
if ((int(emissiveTexHasSwappedViews_tmp)!=0))
{
int l9_1883=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1883=0;
}
else
{
l9_1883=in.varStereoViewID;
}
int l9_1884=l9_1883;
l9_1882=1-l9_1884;
}
else
{
int l9_1885=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1885=0;
}
else
{
l9_1885=in.varStereoViewID;
}
int l9_1886=l9_1885;
l9_1882=l9_1886;
}
int l9_1887=l9_1882;
int l9_1888=emissiveTexLayout_tmp;
int l9_1889=l9_1887;
float2 l9_1890=l9_1668;
bool l9_1891=(int(SC_USE_UV_TRANSFORM_emissiveTex_tmp)!=0);
float3x3 l9_1892=(*sc_set2.UserUniforms).emissiveTexTransform;
int2 l9_1893=int2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex_tmp,SC_SOFTWARE_WRAP_MODE_V_emissiveTex_tmp);
bool l9_1894=(int(SC_USE_UV_MIN_MAX_emissiveTex_tmp)!=0);
float4 l9_1895=(*sc_set2.UserUniforms).emissiveTexUvMinMax;
bool l9_1896=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex_tmp)!=0);
float4 l9_1897=(*sc_set2.UserUniforms).emissiveTexBorderColor;
float l9_1898=0.0;
bool l9_1899=l9_1896&&(!l9_1894);
float l9_1900=1.0;
float l9_1901=l9_1890.x;
int l9_1902=l9_1893.x;
if (l9_1902==1)
{
l9_1901=fract(l9_1901);
}
else
{
if (l9_1902==2)
{
float l9_1903=fract(l9_1901);
float l9_1904=l9_1901-l9_1903;
float l9_1905=step(0.25,fract(l9_1904*0.5));
l9_1901=mix(l9_1903,1.0-l9_1903,fast::clamp(l9_1905,0.0,1.0));
}
}
l9_1890.x=l9_1901;
float l9_1906=l9_1890.y;
int l9_1907=l9_1893.y;
if (l9_1907==1)
{
l9_1906=fract(l9_1906);
}
else
{
if (l9_1907==2)
{
float l9_1908=fract(l9_1906);
float l9_1909=l9_1906-l9_1908;
float l9_1910=step(0.25,fract(l9_1909*0.5));
l9_1906=mix(l9_1908,1.0-l9_1908,fast::clamp(l9_1910,0.0,1.0));
}
}
l9_1890.y=l9_1906;
if (l9_1894)
{
bool l9_1911=l9_1896;
bool l9_1912;
if (l9_1911)
{
l9_1912=l9_1893.x==3;
}
else
{
l9_1912=l9_1911;
}
float l9_1913=l9_1890.x;
float l9_1914=l9_1895.x;
float l9_1915=l9_1895.z;
bool l9_1916=l9_1912;
float l9_1917=l9_1900;
float l9_1918=fast::clamp(l9_1913,l9_1914,l9_1915);
float l9_1919=step(abs(l9_1913-l9_1918),9.9999997e-06);
l9_1917*=(l9_1919+((1.0-float(l9_1916))*(1.0-l9_1919)));
l9_1913=l9_1918;
l9_1890.x=l9_1913;
l9_1900=l9_1917;
bool l9_1920=l9_1896;
bool l9_1921;
if (l9_1920)
{
l9_1921=l9_1893.y==3;
}
else
{
l9_1921=l9_1920;
}
float l9_1922=l9_1890.y;
float l9_1923=l9_1895.y;
float l9_1924=l9_1895.w;
bool l9_1925=l9_1921;
float l9_1926=l9_1900;
float l9_1927=fast::clamp(l9_1922,l9_1923,l9_1924);
float l9_1928=step(abs(l9_1922-l9_1927),9.9999997e-06);
l9_1926*=(l9_1928+((1.0-float(l9_1925))*(1.0-l9_1928)));
l9_1922=l9_1927;
l9_1890.y=l9_1922;
l9_1900=l9_1926;
}
float2 l9_1929=l9_1890;
bool l9_1930=l9_1891;
float3x3 l9_1931=l9_1892;
if (l9_1930)
{
l9_1929=float2((l9_1931*float3(l9_1929,1.0)).xy);
}
float2 l9_1932=l9_1929;
float2 l9_1933=l9_1932;
float2 l9_1934=l9_1933;
l9_1890=l9_1934;
float l9_1935=l9_1890.x;
int l9_1936=l9_1893.x;
bool l9_1937=l9_1899;
float l9_1938=l9_1900;
if ((l9_1936==0)||(l9_1936==3))
{
float l9_1939=l9_1935;
float l9_1940=0.0;
float l9_1941=1.0;
bool l9_1942=l9_1937;
float l9_1943=l9_1938;
float l9_1944=fast::clamp(l9_1939,l9_1940,l9_1941);
float l9_1945=step(abs(l9_1939-l9_1944),9.9999997e-06);
l9_1943*=(l9_1945+((1.0-float(l9_1942))*(1.0-l9_1945)));
l9_1939=l9_1944;
l9_1935=l9_1939;
l9_1938=l9_1943;
}
l9_1890.x=l9_1935;
l9_1900=l9_1938;
float l9_1946=l9_1890.y;
int l9_1947=l9_1893.y;
bool l9_1948=l9_1899;
float l9_1949=l9_1900;
if ((l9_1947==0)||(l9_1947==3))
{
float l9_1950=l9_1946;
float l9_1951=0.0;
float l9_1952=1.0;
bool l9_1953=l9_1948;
float l9_1954=l9_1949;
float l9_1955=fast::clamp(l9_1950,l9_1951,l9_1952);
float l9_1956=step(abs(l9_1950-l9_1955),9.9999997e-06);
l9_1954*=(l9_1956+((1.0-float(l9_1953))*(1.0-l9_1956)));
l9_1950=l9_1955;
l9_1946=l9_1950;
l9_1949=l9_1954;
}
l9_1890.y=l9_1946;
l9_1900=l9_1949;
float2 l9_1957=l9_1890;
int l9_1958=l9_1888;
int l9_1959=l9_1889;
float l9_1960=l9_1898;
float2 l9_1961=l9_1957;
int l9_1962=l9_1958;
int l9_1963=l9_1959;
float3 l9_1964=float3(0.0);
if (l9_1962==0)
{
l9_1964=float3(l9_1961,0.0);
}
else
{
if (l9_1962==1)
{
l9_1964=float3(l9_1961.x,(l9_1961.y*0.5)+(0.5-(float(l9_1963)*0.5)),0.0);
}
else
{
l9_1964=float3(l9_1961,float(l9_1963));
}
}
float3 l9_1965=l9_1964;
float3 l9_1966=l9_1965;
float2 l9_1967=l9_1966.xy;
float l9_1968=l9_1960;
float4 l9_1969=sc_set2.emissiveTex.sample(sc_set2.emissiveTexSmpSC,l9_1967,bias(l9_1968));
float4 l9_1970=l9_1969;
float4 l9_1971=l9_1970;
if (l9_1896)
{
l9_1971=mix(l9_1897,l9_1971,float4(l9_1900));
}
float4 l9_1972=l9_1971;
l9_1881=l9_1972;
l9_1664=l9_1881.xyz;
l9_1667=l9_1664;
}
else
{
l9_1667=l9_1665;
}
l9_1663=l9_1667;
l9_1348=l9_1663;
l9_1350=l9_1348;
}
l9_1346=l9_1350;
float3 l9_1973=float3(0.0);
float3 l9_1974=(*sc_set2.UserUniforms).emissiveColor;
l9_1973=l9_1974;
float3 l9_1975=float3(0.0);
l9_1975=l9_1973;
float l9_1976=0.0;
float l9_1977=(*sc_set2.UserUniforms).emissiveIntensity;
l9_1976=l9_1977;
float l9_1978=0.0;
l9_1978=l9_1976;
float3 l9_1979=float3(0.0);
l9_1979=(l9_1346*l9_1975)*float3(l9_1978);
float3 l9_1980=float3(0.0);
float3 l9_1981=l9_1979;
float3 l9_1982;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1982=float3(pow(l9_1981.x,2.2),pow(l9_1981.y,2.2),pow(l9_1981.z,2.2));
}
else
{
l9_1982=l9_1981*l9_1981;
}
float3 l9_1983=l9_1982;
l9_1980=l9_1983;
param_4=l9_1980;
param_6=param_4;
}
else
{
param_6=param_5;
}
Result_N97=param_6;
float3 Result_N134=float3(0.0);
float3 param_8=float3(0.0);
float3 param_9=(*sc_set2.UserUniforms).Port_Default_N134;
ssGlobals param_11=Globals;
float3 param_10;
if ((int(Tweak_N179_tmp)!=0))
{
float l9_1984=0.0;
float l9_1985=(*sc_set2.UserUniforms).reflectionIntensity;
l9_1984=l9_1985;
float l9_1986=0.0;
l9_1986=l9_1984;
float3 l9_1987=float3(0.0);
l9_1987=param_11.ViewDirWS;
float3 l9_1988=float3(0.0);
float3 l9_1989=float3(0.0);
float3 l9_1990=float3(0.0);
ssGlobals l9_1991=param_11;
float3 l9_1992;
if ((int(ENABLE_NORMALMAP_tmp)!=0))
{
float3 l9_1993=float3(0.0);
l9_1993=l9_1991.VertexTangent_WorldSpace;
float3 l9_1994=float3(0.0);
l9_1994=l9_1991.VertexBinormal_WorldSpace;
float3 l9_1995=float3(0.0);
l9_1995=l9_1991.VertexNormal_WorldSpace;
float3x3 l9_1996=float3x3(float3(0.0),float3(0.0),float3(0.0));
l9_1996=float3x3(float3(l9_1993),float3(l9_1994),float3(l9_1995));
float2 l9_1997=float2(0.0);
float2 l9_1998=float2(0.0);
float2 l9_1999=float2(0.0);
float2 l9_2000=float2(0.0);
float2 l9_2001=float2(0.0);
float2 l9_2002=float2(0.0);
ssGlobals l9_2003=l9_1991;
float2 l9_2004;
if (NODE_181_DROPLIST_ITEM_tmp==0)
{
float2 l9_2005=float2(0.0);
l9_2005=l9_2003.Surface_UVCoord0;
l9_1998=l9_2005;
l9_2004=l9_1998;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==1)
{
float2 l9_2006=float2(0.0);
l9_2006=l9_2003.Surface_UVCoord1;
l9_1999=l9_2006;
l9_2004=l9_1999;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==2)
{
float2 l9_2007=float2(0.0);
float2 l9_2008=float2(0.0);
float2 l9_2009=float2(0.0);
ssGlobals l9_2010=l9_2003;
float2 l9_2011;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2012=float2(0.0);
float2 l9_2013=float2(0.0);
float2 l9_2014=float2(0.0);
ssGlobals l9_2015=l9_2010;
float2 l9_2016;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2017=float2(0.0);
float2 l9_2018=float2(0.0);
float2 l9_2019=float2(0.0);
float2 l9_2020=float2(0.0);
float2 l9_2021=float2(0.0);
ssGlobals l9_2022=l9_2015;
float2 l9_2023;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2024=float2(0.0);
l9_2024=l9_2022.Surface_UVCoord0;
l9_2018=l9_2024;
l9_2023=l9_2018;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2025=float2(0.0);
l9_2025=l9_2022.Surface_UVCoord1;
l9_2019=l9_2025;
l9_2023=l9_2019;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2026=float2(0.0);
l9_2026=l9_2022.gScreenCoord;
l9_2020=l9_2026;
l9_2023=l9_2020;
}
else
{
float2 l9_2027=float2(0.0);
l9_2027=l9_2022.Surface_UVCoord0;
l9_2021=l9_2027;
l9_2023=l9_2021;
}
}
}
l9_2017=l9_2023;
float2 l9_2028=float2(0.0);
float2 l9_2029=(*sc_set2.UserUniforms).uv2Scale;
l9_2028=l9_2029;
float2 l9_2030=float2(0.0);
l9_2030=l9_2028;
float2 l9_2031=float2(0.0);
float2 l9_2032=(*sc_set2.UserUniforms).uv2Offset;
l9_2031=l9_2032;
float2 l9_2033=float2(0.0);
l9_2033=l9_2031;
float2 l9_2034=float2(0.0);
l9_2034=(l9_2017*l9_2030)+l9_2033;
float2 l9_2035=float2(0.0);
l9_2035=l9_2034+(l9_2033*(l9_2015.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2013=l9_2035;
l9_2016=l9_2013;
}
else
{
float2 l9_2036=float2(0.0);
float2 l9_2037=float2(0.0);
float2 l9_2038=float2(0.0);
float2 l9_2039=float2(0.0);
float2 l9_2040=float2(0.0);
ssGlobals l9_2041=l9_2015;
float2 l9_2042;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2043=float2(0.0);
l9_2043=l9_2041.Surface_UVCoord0;
l9_2037=l9_2043;
l9_2042=l9_2037;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2044=float2(0.0);
l9_2044=l9_2041.Surface_UVCoord1;
l9_2038=l9_2044;
l9_2042=l9_2038;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2045=float2(0.0);
l9_2045=l9_2041.gScreenCoord;
l9_2039=l9_2045;
l9_2042=l9_2039;
}
else
{
float2 l9_2046=float2(0.0);
l9_2046=l9_2041.Surface_UVCoord0;
l9_2040=l9_2046;
l9_2042=l9_2040;
}
}
}
l9_2036=l9_2042;
float2 l9_2047=float2(0.0);
float2 l9_2048=(*sc_set2.UserUniforms).uv2Scale;
l9_2047=l9_2048;
float2 l9_2049=float2(0.0);
l9_2049=l9_2047;
float2 l9_2050=float2(0.0);
float2 l9_2051=(*sc_set2.UserUniforms).uv2Offset;
l9_2050=l9_2051;
float2 l9_2052=float2(0.0);
l9_2052=l9_2050;
float2 l9_2053=float2(0.0);
l9_2053=(l9_2036*l9_2049)+l9_2052;
l9_2014=l9_2053;
l9_2016=l9_2014;
}
l9_2012=l9_2016;
l9_2008=l9_2012;
l9_2011=l9_2008;
}
else
{
float2 l9_2054=float2(0.0);
l9_2054=l9_2010.Surface_UVCoord0;
l9_2009=l9_2054;
l9_2011=l9_2009;
}
l9_2007=l9_2011;
float2 l9_2055=float2(0.0);
l9_2055=l9_2007;
float2 l9_2056=float2(0.0);
l9_2056=l9_2055;
l9_2000=l9_2056;
l9_2004=l9_2000;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==3)
{
float2 l9_2057=float2(0.0);
float2 l9_2058=float2(0.0);
float2 l9_2059=float2(0.0);
ssGlobals l9_2060=l9_2003;
float2 l9_2061;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_2062=float2(0.0);
float2 l9_2063=float2(0.0);
float2 l9_2064=float2(0.0);
ssGlobals l9_2065=l9_2060;
float2 l9_2066;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_2067=float2(0.0);
float2 l9_2068=float2(0.0);
float2 l9_2069=float2(0.0);
float2 l9_2070=float2(0.0);
float2 l9_2071=float2(0.0);
float2 l9_2072=float2(0.0);
ssGlobals l9_2073=l9_2065;
float2 l9_2074;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_2075=float2(0.0);
l9_2075=l9_2073.Surface_UVCoord0;
l9_2068=l9_2075;
l9_2074=l9_2068;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_2076=float2(0.0);
l9_2076=l9_2073.Surface_UVCoord1;
l9_2069=l9_2076;
l9_2074=l9_2069;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_2077=float2(0.0);
l9_2077=l9_2073.gScreenCoord;
l9_2070=l9_2077;
l9_2074=l9_2070;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_2078=float2(0.0);
float2 l9_2079=float2(0.0);
float2 l9_2080=float2(0.0);
ssGlobals l9_2081=l9_2073;
float2 l9_2082;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2083=float2(0.0);
float2 l9_2084=float2(0.0);
float2 l9_2085=float2(0.0);
ssGlobals l9_2086=l9_2081;
float2 l9_2087;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2088=float2(0.0);
float2 l9_2089=float2(0.0);
float2 l9_2090=float2(0.0);
float2 l9_2091=float2(0.0);
float2 l9_2092=float2(0.0);
ssGlobals l9_2093=l9_2086;
float2 l9_2094;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2095=float2(0.0);
l9_2095=l9_2093.Surface_UVCoord0;
l9_2089=l9_2095;
l9_2094=l9_2089;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2096=float2(0.0);
l9_2096=l9_2093.Surface_UVCoord1;
l9_2090=l9_2096;
l9_2094=l9_2090;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2097=float2(0.0);
l9_2097=l9_2093.gScreenCoord;
l9_2091=l9_2097;
l9_2094=l9_2091;
}
else
{
float2 l9_2098=float2(0.0);
l9_2098=l9_2093.Surface_UVCoord0;
l9_2092=l9_2098;
l9_2094=l9_2092;
}
}
}
l9_2088=l9_2094;
float2 l9_2099=float2(0.0);
float2 l9_2100=(*sc_set2.UserUniforms).uv2Scale;
l9_2099=l9_2100;
float2 l9_2101=float2(0.0);
l9_2101=l9_2099;
float2 l9_2102=float2(0.0);
float2 l9_2103=(*sc_set2.UserUniforms).uv2Offset;
l9_2102=l9_2103;
float2 l9_2104=float2(0.0);
l9_2104=l9_2102;
float2 l9_2105=float2(0.0);
l9_2105=(l9_2088*l9_2101)+l9_2104;
float2 l9_2106=float2(0.0);
l9_2106=l9_2105+(l9_2104*(l9_2086.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2084=l9_2106;
l9_2087=l9_2084;
}
else
{
float2 l9_2107=float2(0.0);
float2 l9_2108=float2(0.0);
float2 l9_2109=float2(0.0);
float2 l9_2110=float2(0.0);
float2 l9_2111=float2(0.0);
ssGlobals l9_2112=l9_2086;
float2 l9_2113;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2114=float2(0.0);
l9_2114=l9_2112.Surface_UVCoord0;
l9_2108=l9_2114;
l9_2113=l9_2108;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2115=float2(0.0);
l9_2115=l9_2112.Surface_UVCoord1;
l9_2109=l9_2115;
l9_2113=l9_2109;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2116=float2(0.0);
l9_2116=l9_2112.gScreenCoord;
l9_2110=l9_2116;
l9_2113=l9_2110;
}
else
{
float2 l9_2117=float2(0.0);
l9_2117=l9_2112.Surface_UVCoord0;
l9_2111=l9_2117;
l9_2113=l9_2111;
}
}
}
l9_2107=l9_2113;
float2 l9_2118=float2(0.0);
float2 l9_2119=(*sc_set2.UserUniforms).uv2Scale;
l9_2118=l9_2119;
float2 l9_2120=float2(0.0);
l9_2120=l9_2118;
float2 l9_2121=float2(0.0);
float2 l9_2122=(*sc_set2.UserUniforms).uv2Offset;
l9_2121=l9_2122;
float2 l9_2123=float2(0.0);
l9_2123=l9_2121;
float2 l9_2124=float2(0.0);
l9_2124=(l9_2107*l9_2120)+l9_2123;
l9_2085=l9_2124;
l9_2087=l9_2085;
}
l9_2083=l9_2087;
l9_2079=l9_2083;
l9_2082=l9_2079;
}
else
{
float2 l9_2125=float2(0.0);
l9_2125=l9_2081.Surface_UVCoord0;
l9_2080=l9_2125;
l9_2082=l9_2080;
}
l9_2078=l9_2082;
float2 l9_2126=float2(0.0);
l9_2126=l9_2078;
float2 l9_2127=float2(0.0);
l9_2127=l9_2126;
l9_2071=l9_2127;
l9_2074=l9_2071;
}
else
{
float2 l9_2128=float2(0.0);
l9_2128=l9_2073.Surface_UVCoord0;
l9_2072=l9_2128;
l9_2074=l9_2072;
}
}
}
}
l9_2067=l9_2074;
float2 l9_2129=float2(0.0);
float2 l9_2130=(*sc_set2.UserUniforms).uv3Scale;
l9_2129=l9_2130;
float2 l9_2131=float2(0.0);
l9_2131=l9_2129;
float2 l9_2132=float2(0.0);
float2 l9_2133=(*sc_set2.UserUniforms).uv3Offset;
l9_2132=l9_2133;
float2 l9_2134=float2(0.0);
l9_2134=l9_2132;
float2 l9_2135=float2(0.0);
l9_2135=(l9_2067*l9_2131)+l9_2134;
float2 l9_2136=float2(0.0);
l9_2136=l9_2135+(l9_2134*(l9_2065.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_2063=l9_2136;
l9_2066=l9_2063;
}
else
{
float2 l9_2137=float2(0.0);
float2 l9_2138=float2(0.0);
float2 l9_2139=float2(0.0);
float2 l9_2140=float2(0.0);
float2 l9_2141=float2(0.0);
float2 l9_2142=float2(0.0);
ssGlobals l9_2143=l9_2065;
float2 l9_2144;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_2145=float2(0.0);
l9_2145=l9_2143.Surface_UVCoord0;
l9_2138=l9_2145;
l9_2144=l9_2138;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_2146=float2(0.0);
l9_2146=l9_2143.Surface_UVCoord1;
l9_2139=l9_2146;
l9_2144=l9_2139;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_2147=float2(0.0);
l9_2147=l9_2143.gScreenCoord;
l9_2140=l9_2147;
l9_2144=l9_2140;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_2148=float2(0.0);
float2 l9_2149=float2(0.0);
float2 l9_2150=float2(0.0);
ssGlobals l9_2151=l9_2143;
float2 l9_2152;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2153=float2(0.0);
float2 l9_2154=float2(0.0);
float2 l9_2155=float2(0.0);
ssGlobals l9_2156=l9_2151;
float2 l9_2157;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2158=float2(0.0);
float2 l9_2159=float2(0.0);
float2 l9_2160=float2(0.0);
float2 l9_2161=float2(0.0);
float2 l9_2162=float2(0.0);
ssGlobals l9_2163=l9_2156;
float2 l9_2164;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2165=float2(0.0);
l9_2165=l9_2163.Surface_UVCoord0;
l9_2159=l9_2165;
l9_2164=l9_2159;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2166=float2(0.0);
l9_2166=l9_2163.Surface_UVCoord1;
l9_2160=l9_2166;
l9_2164=l9_2160;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2167=float2(0.0);
l9_2167=l9_2163.gScreenCoord;
l9_2161=l9_2167;
l9_2164=l9_2161;
}
else
{
float2 l9_2168=float2(0.0);
l9_2168=l9_2163.Surface_UVCoord0;
l9_2162=l9_2168;
l9_2164=l9_2162;
}
}
}
l9_2158=l9_2164;
float2 l9_2169=float2(0.0);
float2 l9_2170=(*sc_set2.UserUniforms).uv2Scale;
l9_2169=l9_2170;
float2 l9_2171=float2(0.0);
l9_2171=l9_2169;
float2 l9_2172=float2(0.0);
float2 l9_2173=(*sc_set2.UserUniforms).uv2Offset;
l9_2172=l9_2173;
float2 l9_2174=float2(0.0);
l9_2174=l9_2172;
float2 l9_2175=float2(0.0);
l9_2175=(l9_2158*l9_2171)+l9_2174;
float2 l9_2176=float2(0.0);
l9_2176=l9_2175+(l9_2174*(l9_2156.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2154=l9_2176;
l9_2157=l9_2154;
}
else
{
float2 l9_2177=float2(0.0);
float2 l9_2178=float2(0.0);
float2 l9_2179=float2(0.0);
float2 l9_2180=float2(0.0);
float2 l9_2181=float2(0.0);
ssGlobals l9_2182=l9_2156;
float2 l9_2183;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2184=float2(0.0);
l9_2184=l9_2182.Surface_UVCoord0;
l9_2178=l9_2184;
l9_2183=l9_2178;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2185=float2(0.0);
l9_2185=l9_2182.Surface_UVCoord1;
l9_2179=l9_2185;
l9_2183=l9_2179;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2186=float2(0.0);
l9_2186=l9_2182.gScreenCoord;
l9_2180=l9_2186;
l9_2183=l9_2180;
}
else
{
float2 l9_2187=float2(0.0);
l9_2187=l9_2182.Surface_UVCoord0;
l9_2181=l9_2187;
l9_2183=l9_2181;
}
}
}
l9_2177=l9_2183;
float2 l9_2188=float2(0.0);
float2 l9_2189=(*sc_set2.UserUniforms).uv2Scale;
l9_2188=l9_2189;
float2 l9_2190=float2(0.0);
l9_2190=l9_2188;
float2 l9_2191=float2(0.0);
float2 l9_2192=(*sc_set2.UserUniforms).uv2Offset;
l9_2191=l9_2192;
float2 l9_2193=float2(0.0);
l9_2193=l9_2191;
float2 l9_2194=float2(0.0);
l9_2194=(l9_2177*l9_2190)+l9_2193;
l9_2155=l9_2194;
l9_2157=l9_2155;
}
l9_2153=l9_2157;
l9_2149=l9_2153;
l9_2152=l9_2149;
}
else
{
float2 l9_2195=float2(0.0);
l9_2195=l9_2151.Surface_UVCoord0;
l9_2150=l9_2195;
l9_2152=l9_2150;
}
l9_2148=l9_2152;
float2 l9_2196=float2(0.0);
l9_2196=l9_2148;
float2 l9_2197=float2(0.0);
l9_2197=l9_2196;
l9_2141=l9_2197;
l9_2144=l9_2141;
}
else
{
float2 l9_2198=float2(0.0);
l9_2198=l9_2143.Surface_UVCoord0;
l9_2142=l9_2198;
l9_2144=l9_2142;
}
}
}
}
l9_2137=l9_2144;
float2 l9_2199=float2(0.0);
float2 l9_2200=(*sc_set2.UserUniforms).uv3Scale;
l9_2199=l9_2200;
float2 l9_2201=float2(0.0);
l9_2201=l9_2199;
float2 l9_2202=float2(0.0);
float2 l9_2203=(*sc_set2.UserUniforms).uv3Offset;
l9_2202=l9_2203;
float2 l9_2204=float2(0.0);
l9_2204=l9_2202;
float2 l9_2205=float2(0.0);
l9_2205=(l9_2137*l9_2201)+l9_2204;
l9_2064=l9_2205;
l9_2066=l9_2064;
}
l9_2062=l9_2066;
l9_2058=l9_2062;
l9_2061=l9_2058;
}
else
{
float2 l9_2206=float2(0.0);
l9_2206=l9_2060.Surface_UVCoord0;
l9_2059=l9_2206;
l9_2061=l9_2059;
}
l9_2057=l9_2061;
float2 l9_2207=float2(0.0);
l9_2207=l9_2057;
float2 l9_2208=float2(0.0);
l9_2208=l9_2207;
l9_2001=l9_2208;
l9_2004=l9_2001;
}
else
{
float2 l9_2209=float2(0.0);
l9_2209=l9_2003.Surface_UVCoord0;
l9_2002=l9_2209;
l9_2004=l9_2002;
}
}
}
}
l9_1997=l9_2004;
float4 l9_2210=float4(0.0);
float2 l9_2211=l9_1997;
int l9_2212=0;
if ((int(normalTexHasSwappedViews_tmp)!=0))
{
int l9_2213=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2213=0;
}
else
{
l9_2213=in.varStereoViewID;
}
int l9_2214=l9_2213;
l9_2212=1-l9_2214;
}
else
{
int l9_2215=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2215=0;
}
else
{
l9_2215=in.varStereoViewID;
}
int l9_2216=l9_2215;
l9_2212=l9_2216;
}
int l9_2217=l9_2212;
int l9_2218=normalTexLayout_tmp;
int l9_2219=l9_2217;
float2 l9_2220=l9_2211;
bool l9_2221=(int(SC_USE_UV_TRANSFORM_normalTex_tmp)!=0);
float3x3 l9_2222=(*sc_set2.UserUniforms).normalTexTransform;
int2 l9_2223=int2(SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp);
bool l9_2224=(int(SC_USE_UV_MIN_MAX_normalTex_tmp)!=0);
float4 l9_2225=(*sc_set2.UserUniforms).normalTexUvMinMax;
bool l9_2226=(int(SC_USE_CLAMP_TO_BORDER_normalTex_tmp)!=0);
float4 l9_2227=(*sc_set2.UserUniforms).normalTexBorderColor;
float l9_2228=0.0;
bool l9_2229=l9_2226&&(!l9_2224);
float l9_2230=1.0;
float l9_2231=l9_2220.x;
int l9_2232=l9_2223.x;
if (l9_2232==1)
{
l9_2231=fract(l9_2231);
}
else
{
if (l9_2232==2)
{
float l9_2233=fract(l9_2231);
float l9_2234=l9_2231-l9_2233;
float l9_2235=step(0.25,fract(l9_2234*0.5));
l9_2231=mix(l9_2233,1.0-l9_2233,fast::clamp(l9_2235,0.0,1.0));
}
}
l9_2220.x=l9_2231;
float l9_2236=l9_2220.y;
int l9_2237=l9_2223.y;
if (l9_2237==1)
{
l9_2236=fract(l9_2236);
}
else
{
if (l9_2237==2)
{
float l9_2238=fract(l9_2236);
float l9_2239=l9_2236-l9_2238;
float l9_2240=step(0.25,fract(l9_2239*0.5));
l9_2236=mix(l9_2238,1.0-l9_2238,fast::clamp(l9_2240,0.0,1.0));
}
}
l9_2220.y=l9_2236;
if (l9_2224)
{
bool l9_2241=l9_2226;
bool l9_2242;
if (l9_2241)
{
l9_2242=l9_2223.x==3;
}
else
{
l9_2242=l9_2241;
}
float l9_2243=l9_2220.x;
float l9_2244=l9_2225.x;
float l9_2245=l9_2225.z;
bool l9_2246=l9_2242;
float l9_2247=l9_2230;
float l9_2248=fast::clamp(l9_2243,l9_2244,l9_2245);
float l9_2249=step(abs(l9_2243-l9_2248),9.9999997e-06);
l9_2247*=(l9_2249+((1.0-float(l9_2246))*(1.0-l9_2249)));
l9_2243=l9_2248;
l9_2220.x=l9_2243;
l9_2230=l9_2247;
bool l9_2250=l9_2226;
bool l9_2251;
if (l9_2250)
{
l9_2251=l9_2223.y==3;
}
else
{
l9_2251=l9_2250;
}
float l9_2252=l9_2220.y;
float l9_2253=l9_2225.y;
float l9_2254=l9_2225.w;
bool l9_2255=l9_2251;
float l9_2256=l9_2230;
float l9_2257=fast::clamp(l9_2252,l9_2253,l9_2254);
float l9_2258=step(abs(l9_2252-l9_2257),9.9999997e-06);
l9_2256*=(l9_2258+((1.0-float(l9_2255))*(1.0-l9_2258)));
l9_2252=l9_2257;
l9_2220.y=l9_2252;
l9_2230=l9_2256;
}
float2 l9_2259=l9_2220;
bool l9_2260=l9_2221;
float3x3 l9_2261=l9_2222;
if (l9_2260)
{
l9_2259=float2((l9_2261*float3(l9_2259,1.0)).xy);
}
float2 l9_2262=l9_2259;
float2 l9_2263=l9_2262;
float2 l9_2264=l9_2263;
l9_2220=l9_2264;
float l9_2265=l9_2220.x;
int l9_2266=l9_2223.x;
bool l9_2267=l9_2229;
float l9_2268=l9_2230;
if ((l9_2266==0)||(l9_2266==3))
{
float l9_2269=l9_2265;
float l9_2270=0.0;
float l9_2271=1.0;
bool l9_2272=l9_2267;
float l9_2273=l9_2268;
float l9_2274=fast::clamp(l9_2269,l9_2270,l9_2271);
float l9_2275=step(abs(l9_2269-l9_2274),9.9999997e-06);
l9_2273*=(l9_2275+((1.0-float(l9_2272))*(1.0-l9_2275)));
l9_2269=l9_2274;
l9_2265=l9_2269;
l9_2268=l9_2273;
}
l9_2220.x=l9_2265;
l9_2230=l9_2268;
float l9_2276=l9_2220.y;
int l9_2277=l9_2223.y;
bool l9_2278=l9_2229;
float l9_2279=l9_2230;
if ((l9_2277==0)||(l9_2277==3))
{
float l9_2280=l9_2276;
float l9_2281=0.0;
float l9_2282=1.0;
bool l9_2283=l9_2278;
float l9_2284=l9_2279;
float l9_2285=fast::clamp(l9_2280,l9_2281,l9_2282);
float l9_2286=step(abs(l9_2280-l9_2285),9.9999997e-06);
l9_2284*=(l9_2286+((1.0-float(l9_2283))*(1.0-l9_2286)));
l9_2280=l9_2285;
l9_2276=l9_2280;
l9_2279=l9_2284;
}
l9_2220.y=l9_2276;
l9_2230=l9_2279;
float2 l9_2287=l9_2220;
int l9_2288=l9_2218;
int l9_2289=l9_2219;
float l9_2290=l9_2228;
float2 l9_2291=l9_2287;
int l9_2292=l9_2288;
int l9_2293=l9_2289;
float3 l9_2294=float3(0.0);
if (l9_2292==0)
{
l9_2294=float3(l9_2291,0.0);
}
else
{
if (l9_2292==1)
{
l9_2294=float3(l9_2291.x,(l9_2291.y*0.5)+(0.5-(float(l9_2293)*0.5)),0.0);
}
else
{
l9_2294=float3(l9_2291,float(l9_2293));
}
}
float3 l9_2295=l9_2294;
float3 l9_2296=l9_2295;
float2 l9_2297=l9_2296.xy;
float l9_2298=l9_2290;
float4 l9_2299=sc_set2.normalTex.sample(sc_set2.normalTexSmpSC,l9_2297,bias(l9_2298));
float4 l9_2300=l9_2299;
float4 l9_2301=l9_2300;
if (l9_2226)
{
l9_2301=mix(l9_2227,l9_2301,float4(l9_2230));
}
float4 l9_2302=l9_2301;
float4 l9_2303=l9_2302;
float3 l9_2304=(l9_2303.xyz*1.9921875)-float3(1.0);
l9_2303=float4(l9_2304.x,l9_2304.y,l9_2304.z,l9_2303.w);
l9_2210=l9_2303;
float3 l9_2305=float3(0.0);
float3 l9_2306=float3(0.0);
float3 l9_2307=(*sc_set2.UserUniforms).Port_Default_N113;
ssGlobals l9_2308=l9_1991;
float3 l9_2309;
if ((int(ENABLE_DETAIL_NORMAL_tmp)!=0))
{
float2 l9_2310=float2(0.0);
float2 l9_2311=float2(0.0);
float2 l9_2312=float2(0.0);
float2 l9_2313=float2(0.0);
float2 l9_2314=float2(0.0);
float2 l9_2315=float2(0.0);
ssGlobals l9_2316=l9_2308;
float2 l9_2317;
if (NODE_184_DROPLIST_ITEM_tmp==0)
{
float2 l9_2318=float2(0.0);
l9_2318=l9_2316.Surface_UVCoord0;
l9_2311=l9_2318;
l9_2317=l9_2311;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==1)
{
float2 l9_2319=float2(0.0);
l9_2319=l9_2316.Surface_UVCoord1;
l9_2312=l9_2319;
l9_2317=l9_2312;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==2)
{
float2 l9_2320=float2(0.0);
float2 l9_2321=float2(0.0);
float2 l9_2322=float2(0.0);
ssGlobals l9_2323=l9_2316;
float2 l9_2324;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2325=float2(0.0);
float2 l9_2326=float2(0.0);
float2 l9_2327=float2(0.0);
ssGlobals l9_2328=l9_2323;
float2 l9_2329;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2330=float2(0.0);
float2 l9_2331=float2(0.0);
float2 l9_2332=float2(0.0);
float2 l9_2333=float2(0.0);
float2 l9_2334=float2(0.0);
ssGlobals l9_2335=l9_2328;
float2 l9_2336;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2337=float2(0.0);
l9_2337=l9_2335.Surface_UVCoord0;
l9_2331=l9_2337;
l9_2336=l9_2331;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2338=float2(0.0);
l9_2338=l9_2335.Surface_UVCoord1;
l9_2332=l9_2338;
l9_2336=l9_2332;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2339=float2(0.0);
l9_2339=l9_2335.gScreenCoord;
l9_2333=l9_2339;
l9_2336=l9_2333;
}
else
{
float2 l9_2340=float2(0.0);
l9_2340=l9_2335.Surface_UVCoord0;
l9_2334=l9_2340;
l9_2336=l9_2334;
}
}
}
l9_2330=l9_2336;
float2 l9_2341=float2(0.0);
float2 l9_2342=(*sc_set2.UserUniforms).uv2Scale;
l9_2341=l9_2342;
float2 l9_2343=float2(0.0);
l9_2343=l9_2341;
float2 l9_2344=float2(0.0);
float2 l9_2345=(*sc_set2.UserUniforms).uv2Offset;
l9_2344=l9_2345;
float2 l9_2346=float2(0.0);
l9_2346=l9_2344;
float2 l9_2347=float2(0.0);
l9_2347=(l9_2330*l9_2343)+l9_2346;
float2 l9_2348=float2(0.0);
l9_2348=l9_2347+(l9_2346*(l9_2328.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2326=l9_2348;
l9_2329=l9_2326;
}
else
{
float2 l9_2349=float2(0.0);
float2 l9_2350=float2(0.0);
float2 l9_2351=float2(0.0);
float2 l9_2352=float2(0.0);
float2 l9_2353=float2(0.0);
ssGlobals l9_2354=l9_2328;
float2 l9_2355;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2356=float2(0.0);
l9_2356=l9_2354.Surface_UVCoord0;
l9_2350=l9_2356;
l9_2355=l9_2350;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2357=float2(0.0);
l9_2357=l9_2354.Surface_UVCoord1;
l9_2351=l9_2357;
l9_2355=l9_2351;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2358=float2(0.0);
l9_2358=l9_2354.gScreenCoord;
l9_2352=l9_2358;
l9_2355=l9_2352;
}
else
{
float2 l9_2359=float2(0.0);
l9_2359=l9_2354.Surface_UVCoord0;
l9_2353=l9_2359;
l9_2355=l9_2353;
}
}
}
l9_2349=l9_2355;
float2 l9_2360=float2(0.0);
float2 l9_2361=(*sc_set2.UserUniforms).uv2Scale;
l9_2360=l9_2361;
float2 l9_2362=float2(0.0);
l9_2362=l9_2360;
float2 l9_2363=float2(0.0);
float2 l9_2364=(*sc_set2.UserUniforms).uv2Offset;
l9_2363=l9_2364;
float2 l9_2365=float2(0.0);
l9_2365=l9_2363;
float2 l9_2366=float2(0.0);
l9_2366=(l9_2349*l9_2362)+l9_2365;
l9_2327=l9_2366;
l9_2329=l9_2327;
}
l9_2325=l9_2329;
l9_2321=l9_2325;
l9_2324=l9_2321;
}
else
{
float2 l9_2367=float2(0.0);
l9_2367=l9_2323.Surface_UVCoord0;
l9_2322=l9_2367;
l9_2324=l9_2322;
}
l9_2320=l9_2324;
float2 l9_2368=float2(0.0);
l9_2368=l9_2320;
float2 l9_2369=float2(0.0);
l9_2369=l9_2368;
l9_2313=l9_2369;
l9_2317=l9_2313;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==3)
{
float2 l9_2370=float2(0.0);
float2 l9_2371=float2(0.0);
float2 l9_2372=float2(0.0);
ssGlobals l9_2373=l9_2316;
float2 l9_2374;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_2375=float2(0.0);
float2 l9_2376=float2(0.0);
float2 l9_2377=float2(0.0);
ssGlobals l9_2378=l9_2373;
float2 l9_2379;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_2380=float2(0.0);
float2 l9_2381=float2(0.0);
float2 l9_2382=float2(0.0);
float2 l9_2383=float2(0.0);
float2 l9_2384=float2(0.0);
float2 l9_2385=float2(0.0);
ssGlobals l9_2386=l9_2378;
float2 l9_2387;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_2388=float2(0.0);
l9_2388=l9_2386.Surface_UVCoord0;
l9_2381=l9_2388;
l9_2387=l9_2381;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_2389=float2(0.0);
l9_2389=l9_2386.Surface_UVCoord1;
l9_2382=l9_2389;
l9_2387=l9_2382;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_2390=float2(0.0);
l9_2390=l9_2386.gScreenCoord;
l9_2383=l9_2390;
l9_2387=l9_2383;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_2391=float2(0.0);
float2 l9_2392=float2(0.0);
float2 l9_2393=float2(0.0);
ssGlobals l9_2394=l9_2386;
float2 l9_2395;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2396=float2(0.0);
float2 l9_2397=float2(0.0);
float2 l9_2398=float2(0.0);
ssGlobals l9_2399=l9_2394;
float2 l9_2400;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2401=float2(0.0);
float2 l9_2402=float2(0.0);
float2 l9_2403=float2(0.0);
float2 l9_2404=float2(0.0);
float2 l9_2405=float2(0.0);
ssGlobals l9_2406=l9_2399;
float2 l9_2407;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2408=float2(0.0);
l9_2408=l9_2406.Surface_UVCoord0;
l9_2402=l9_2408;
l9_2407=l9_2402;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2409=float2(0.0);
l9_2409=l9_2406.Surface_UVCoord1;
l9_2403=l9_2409;
l9_2407=l9_2403;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2410=float2(0.0);
l9_2410=l9_2406.gScreenCoord;
l9_2404=l9_2410;
l9_2407=l9_2404;
}
else
{
float2 l9_2411=float2(0.0);
l9_2411=l9_2406.Surface_UVCoord0;
l9_2405=l9_2411;
l9_2407=l9_2405;
}
}
}
l9_2401=l9_2407;
float2 l9_2412=float2(0.0);
float2 l9_2413=(*sc_set2.UserUniforms).uv2Scale;
l9_2412=l9_2413;
float2 l9_2414=float2(0.0);
l9_2414=l9_2412;
float2 l9_2415=float2(0.0);
float2 l9_2416=(*sc_set2.UserUniforms).uv2Offset;
l9_2415=l9_2416;
float2 l9_2417=float2(0.0);
l9_2417=l9_2415;
float2 l9_2418=float2(0.0);
l9_2418=(l9_2401*l9_2414)+l9_2417;
float2 l9_2419=float2(0.0);
l9_2419=l9_2418+(l9_2417*(l9_2399.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2397=l9_2419;
l9_2400=l9_2397;
}
else
{
float2 l9_2420=float2(0.0);
float2 l9_2421=float2(0.0);
float2 l9_2422=float2(0.0);
float2 l9_2423=float2(0.0);
float2 l9_2424=float2(0.0);
ssGlobals l9_2425=l9_2399;
float2 l9_2426;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2427=float2(0.0);
l9_2427=l9_2425.Surface_UVCoord0;
l9_2421=l9_2427;
l9_2426=l9_2421;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2428=float2(0.0);
l9_2428=l9_2425.Surface_UVCoord1;
l9_2422=l9_2428;
l9_2426=l9_2422;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2429=float2(0.0);
l9_2429=l9_2425.gScreenCoord;
l9_2423=l9_2429;
l9_2426=l9_2423;
}
else
{
float2 l9_2430=float2(0.0);
l9_2430=l9_2425.Surface_UVCoord0;
l9_2424=l9_2430;
l9_2426=l9_2424;
}
}
}
l9_2420=l9_2426;
float2 l9_2431=float2(0.0);
float2 l9_2432=(*sc_set2.UserUniforms).uv2Scale;
l9_2431=l9_2432;
float2 l9_2433=float2(0.0);
l9_2433=l9_2431;
float2 l9_2434=float2(0.0);
float2 l9_2435=(*sc_set2.UserUniforms).uv2Offset;
l9_2434=l9_2435;
float2 l9_2436=float2(0.0);
l9_2436=l9_2434;
float2 l9_2437=float2(0.0);
l9_2437=(l9_2420*l9_2433)+l9_2436;
l9_2398=l9_2437;
l9_2400=l9_2398;
}
l9_2396=l9_2400;
l9_2392=l9_2396;
l9_2395=l9_2392;
}
else
{
float2 l9_2438=float2(0.0);
l9_2438=l9_2394.Surface_UVCoord0;
l9_2393=l9_2438;
l9_2395=l9_2393;
}
l9_2391=l9_2395;
float2 l9_2439=float2(0.0);
l9_2439=l9_2391;
float2 l9_2440=float2(0.0);
l9_2440=l9_2439;
l9_2384=l9_2440;
l9_2387=l9_2384;
}
else
{
float2 l9_2441=float2(0.0);
l9_2441=l9_2386.Surface_UVCoord0;
l9_2385=l9_2441;
l9_2387=l9_2385;
}
}
}
}
l9_2380=l9_2387;
float2 l9_2442=float2(0.0);
float2 l9_2443=(*sc_set2.UserUniforms).uv3Scale;
l9_2442=l9_2443;
float2 l9_2444=float2(0.0);
l9_2444=l9_2442;
float2 l9_2445=float2(0.0);
float2 l9_2446=(*sc_set2.UserUniforms).uv3Offset;
l9_2445=l9_2446;
float2 l9_2447=float2(0.0);
l9_2447=l9_2445;
float2 l9_2448=float2(0.0);
l9_2448=(l9_2380*l9_2444)+l9_2447;
float2 l9_2449=float2(0.0);
l9_2449=l9_2448+(l9_2447*(l9_2378.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_2376=l9_2449;
l9_2379=l9_2376;
}
else
{
float2 l9_2450=float2(0.0);
float2 l9_2451=float2(0.0);
float2 l9_2452=float2(0.0);
float2 l9_2453=float2(0.0);
float2 l9_2454=float2(0.0);
float2 l9_2455=float2(0.0);
ssGlobals l9_2456=l9_2378;
float2 l9_2457;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_2458=float2(0.0);
l9_2458=l9_2456.Surface_UVCoord0;
l9_2451=l9_2458;
l9_2457=l9_2451;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_2459=float2(0.0);
l9_2459=l9_2456.Surface_UVCoord1;
l9_2452=l9_2459;
l9_2457=l9_2452;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_2460=float2(0.0);
l9_2460=l9_2456.gScreenCoord;
l9_2453=l9_2460;
l9_2457=l9_2453;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_2461=float2(0.0);
float2 l9_2462=float2(0.0);
float2 l9_2463=float2(0.0);
ssGlobals l9_2464=l9_2456;
float2 l9_2465;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2466=float2(0.0);
float2 l9_2467=float2(0.0);
float2 l9_2468=float2(0.0);
ssGlobals l9_2469=l9_2464;
float2 l9_2470;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2471=float2(0.0);
float2 l9_2472=float2(0.0);
float2 l9_2473=float2(0.0);
float2 l9_2474=float2(0.0);
float2 l9_2475=float2(0.0);
ssGlobals l9_2476=l9_2469;
float2 l9_2477;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2478=float2(0.0);
l9_2478=l9_2476.Surface_UVCoord0;
l9_2472=l9_2478;
l9_2477=l9_2472;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2479=float2(0.0);
l9_2479=l9_2476.Surface_UVCoord1;
l9_2473=l9_2479;
l9_2477=l9_2473;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2480=float2(0.0);
l9_2480=l9_2476.gScreenCoord;
l9_2474=l9_2480;
l9_2477=l9_2474;
}
else
{
float2 l9_2481=float2(0.0);
l9_2481=l9_2476.Surface_UVCoord0;
l9_2475=l9_2481;
l9_2477=l9_2475;
}
}
}
l9_2471=l9_2477;
float2 l9_2482=float2(0.0);
float2 l9_2483=(*sc_set2.UserUniforms).uv2Scale;
l9_2482=l9_2483;
float2 l9_2484=float2(0.0);
l9_2484=l9_2482;
float2 l9_2485=float2(0.0);
float2 l9_2486=(*sc_set2.UserUniforms).uv2Offset;
l9_2485=l9_2486;
float2 l9_2487=float2(0.0);
l9_2487=l9_2485;
float2 l9_2488=float2(0.0);
l9_2488=(l9_2471*l9_2484)+l9_2487;
float2 l9_2489=float2(0.0);
l9_2489=l9_2488+(l9_2487*(l9_2469.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2467=l9_2489;
l9_2470=l9_2467;
}
else
{
float2 l9_2490=float2(0.0);
float2 l9_2491=float2(0.0);
float2 l9_2492=float2(0.0);
float2 l9_2493=float2(0.0);
float2 l9_2494=float2(0.0);
ssGlobals l9_2495=l9_2469;
float2 l9_2496;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2497=float2(0.0);
l9_2497=l9_2495.Surface_UVCoord0;
l9_2491=l9_2497;
l9_2496=l9_2491;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2498=float2(0.0);
l9_2498=l9_2495.Surface_UVCoord1;
l9_2492=l9_2498;
l9_2496=l9_2492;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2499=float2(0.0);
l9_2499=l9_2495.gScreenCoord;
l9_2493=l9_2499;
l9_2496=l9_2493;
}
else
{
float2 l9_2500=float2(0.0);
l9_2500=l9_2495.Surface_UVCoord0;
l9_2494=l9_2500;
l9_2496=l9_2494;
}
}
}
l9_2490=l9_2496;
float2 l9_2501=float2(0.0);
float2 l9_2502=(*sc_set2.UserUniforms).uv2Scale;
l9_2501=l9_2502;
float2 l9_2503=float2(0.0);
l9_2503=l9_2501;
float2 l9_2504=float2(0.0);
float2 l9_2505=(*sc_set2.UserUniforms).uv2Offset;
l9_2504=l9_2505;
float2 l9_2506=float2(0.0);
l9_2506=l9_2504;
float2 l9_2507=float2(0.0);
l9_2507=(l9_2490*l9_2503)+l9_2506;
l9_2468=l9_2507;
l9_2470=l9_2468;
}
l9_2466=l9_2470;
l9_2462=l9_2466;
l9_2465=l9_2462;
}
else
{
float2 l9_2508=float2(0.0);
l9_2508=l9_2464.Surface_UVCoord0;
l9_2463=l9_2508;
l9_2465=l9_2463;
}
l9_2461=l9_2465;
float2 l9_2509=float2(0.0);
l9_2509=l9_2461;
float2 l9_2510=float2(0.0);
l9_2510=l9_2509;
l9_2454=l9_2510;
l9_2457=l9_2454;
}
else
{
float2 l9_2511=float2(0.0);
l9_2511=l9_2456.Surface_UVCoord0;
l9_2455=l9_2511;
l9_2457=l9_2455;
}
}
}
}
l9_2450=l9_2457;
float2 l9_2512=float2(0.0);
float2 l9_2513=(*sc_set2.UserUniforms).uv3Scale;
l9_2512=l9_2513;
float2 l9_2514=float2(0.0);
l9_2514=l9_2512;
float2 l9_2515=float2(0.0);
float2 l9_2516=(*sc_set2.UserUniforms).uv3Offset;
l9_2515=l9_2516;
float2 l9_2517=float2(0.0);
l9_2517=l9_2515;
float2 l9_2518=float2(0.0);
l9_2518=(l9_2450*l9_2514)+l9_2517;
l9_2377=l9_2518;
l9_2379=l9_2377;
}
l9_2375=l9_2379;
l9_2371=l9_2375;
l9_2374=l9_2371;
}
else
{
float2 l9_2519=float2(0.0);
l9_2519=l9_2373.Surface_UVCoord0;
l9_2372=l9_2519;
l9_2374=l9_2372;
}
l9_2370=l9_2374;
float2 l9_2520=float2(0.0);
l9_2520=l9_2370;
float2 l9_2521=float2(0.0);
l9_2521=l9_2520;
l9_2314=l9_2521;
l9_2317=l9_2314;
}
else
{
float2 l9_2522=float2(0.0);
l9_2522=l9_2316.Surface_UVCoord0;
l9_2315=l9_2522;
l9_2317=l9_2315;
}
}
}
}
l9_2310=l9_2317;
float4 l9_2523=float4(0.0);
float2 l9_2524=l9_2310;
int l9_2525=0;
if ((int(detailNormalTexHasSwappedViews_tmp)!=0))
{
int l9_2526=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2526=0;
}
else
{
l9_2526=in.varStereoViewID;
}
int l9_2527=l9_2526;
l9_2525=1-l9_2527;
}
else
{
int l9_2528=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2528=0;
}
else
{
l9_2528=in.varStereoViewID;
}
int l9_2529=l9_2528;
l9_2525=l9_2529;
}
int l9_2530=l9_2525;
int l9_2531=detailNormalTexLayout_tmp;
int l9_2532=l9_2530;
float2 l9_2533=l9_2524;
bool l9_2534=(int(SC_USE_UV_TRANSFORM_detailNormalTex_tmp)!=0);
float3x3 l9_2535=(*sc_set2.UserUniforms).detailNormalTexTransform;
int2 l9_2536=int2(SC_SOFTWARE_WRAP_MODE_U_detailNormalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_detailNormalTex_tmp);
bool l9_2537=(int(SC_USE_UV_MIN_MAX_detailNormalTex_tmp)!=0);
float4 l9_2538=(*sc_set2.UserUniforms).detailNormalTexUvMinMax;
bool l9_2539=(int(SC_USE_CLAMP_TO_BORDER_detailNormalTex_tmp)!=0);
float4 l9_2540=(*sc_set2.UserUniforms).detailNormalTexBorderColor;
float l9_2541=0.0;
bool l9_2542=l9_2539&&(!l9_2537);
float l9_2543=1.0;
float l9_2544=l9_2533.x;
int l9_2545=l9_2536.x;
if (l9_2545==1)
{
l9_2544=fract(l9_2544);
}
else
{
if (l9_2545==2)
{
float l9_2546=fract(l9_2544);
float l9_2547=l9_2544-l9_2546;
float l9_2548=step(0.25,fract(l9_2547*0.5));
l9_2544=mix(l9_2546,1.0-l9_2546,fast::clamp(l9_2548,0.0,1.0));
}
}
l9_2533.x=l9_2544;
float l9_2549=l9_2533.y;
int l9_2550=l9_2536.y;
if (l9_2550==1)
{
l9_2549=fract(l9_2549);
}
else
{
if (l9_2550==2)
{
float l9_2551=fract(l9_2549);
float l9_2552=l9_2549-l9_2551;
float l9_2553=step(0.25,fract(l9_2552*0.5));
l9_2549=mix(l9_2551,1.0-l9_2551,fast::clamp(l9_2553,0.0,1.0));
}
}
l9_2533.y=l9_2549;
if (l9_2537)
{
bool l9_2554=l9_2539;
bool l9_2555;
if (l9_2554)
{
l9_2555=l9_2536.x==3;
}
else
{
l9_2555=l9_2554;
}
float l9_2556=l9_2533.x;
float l9_2557=l9_2538.x;
float l9_2558=l9_2538.z;
bool l9_2559=l9_2555;
float l9_2560=l9_2543;
float l9_2561=fast::clamp(l9_2556,l9_2557,l9_2558);
float l9_2562=step(abs(l9_2556-l9_2561),9.9999997e-06);
l9_2560*=(l9_2562+((1.0-float(l9_2559))*(1.0-l9_2562)));
l9_2556=l9_2561;
l9_2533.x=l9_2556;
l9_2543=l9_2560;
bool l9_2563=l9_2539;
bool l9_2564;
if (l9_2563)
{
l9_2564=l9_2536.y==3;
}
else
{
l9_2564=l9_2563;
}
float l9_2565=l9_2533.y;
float l9_2566=l9_2538.y;
float l9_2567=l9_2538.w;
bool l9_2568=l9_2564;
float l9_2569=l9_2543;
float l9_2570=fast::clamp(l9_2565,l9_2566,l9_2567);
float l9_2571=step(abs(l9_2565-l9_2570),9.9999997e-06);
l9_2569*=(l9_2571+((1.0-float(l9_2568))*(1.0-l9_2571)));
l9_2565=l9_2570;
l9_2533.y=l9_2565;
l9_2543=l9_2569;
}
float2 l9_2572=l9_2533;
bool l9_2573=l9_2534;
float3x3 l9_2574=l9_2535;
if (l9_2573)
{
l9_2572=float2((l9_2574*float3(l9_2572,1.0)).xy);
}
float2 l9_2575=l9_2572;
float2 l9_2576=l9_2575;
float2 l9_2577=l9_2576;
l9_2533=l9_2577;
float l9_2578=l9_2533.x;
int l9_2579=l9_2536.x;
bool l9_2580=l9_2542;
float l9_2581=l9_2543;
if ((l9_2579==0)||(l9_2579==3))
{
float l9_2582=l9_2578;
float l9_2583=0.0;
float l9_2584=1.0;
bool l9_2585=l9_2580;
float l9_2586=l9_2581;
float l9_2587=fast::clamp(l9_2582,l9_2583,l9_2584);
float l9_2588=step(abs(l9_2582-l9_2587),9.9999997e-06);
l9_2586*=(l9_2588+((1.0-float(l9_2585))*(1.0-l9_2588)));
l9_2582=l9_2587;
l9_2578=l9_2582;
l9_2581=l9_2586;
}
l9_2533.x=l9_2578;
l9_2543=l9_2581;
float l9_2589=l9_2533.y;
int l9_2590=l9_2536.y;
bool l9_2591=l9_2542;
float l9_2592=l9_2543;
if ((l9_2590==0)||(l9_2590==3))
{
float l9_2593=l9_2589;
float l9_2594=0.0;
float l9_2595=1.0;
bool l9_2596=l9_2591;
float l9_2597=l9_2592;
float l9_2598=fast::clamp(l9_2593,l9_2594,l9_2595);
float l9_2599=step(abs(l9_2593-l9_2598),9.9999997e-06);
l9_2597*=(l9_2599+((1.0-float(l9_2596))*(1.0-l9_2599)));
l9_2593=l9_2598;
l9_2589=l9_2593;
l9_2592=l9_2597;
}
l9_2533.y=l9_2589;
l9_2543=l9_2592;
float2 l9_2600=l9_2533;
int l9_2601=l9_2531;
int l9_2602=l9_2532;
float l9_2603=l9_2541;
float2 l9_2604=l9_2600;
int l9_2605=l9_2601;
int l9_2606=l9_2602;
float3 l9_2607=float3(0.0);
if (l9_2605==0)
{
l9_2607=float3(l9_2604,0.0);
}
else
{
if (l9_2605==1)
{
l9_2607=float3(l9_2604.x,(l9_2604.y*0.5)+(0.5-(float(l9_2606)*0.5)),0.0);
}
else
{
l9_2607=float3(l9_2604,float(l9_2606));
}
}
float3 l9_2608=l9_2607;
float3 l9_2609=l9_2608;
float2 l9_2610=l9_2609.xy;
float l9_2611=l9_2603;
float4 l9_2612=sc_set2.detailNormalTex.sample(sc_set2.detailNormalTexSmpSC,l9_2610,bias(l9_2611));
float4 l9_2613=l9_2612;
float4 l9_2614=l9_2613;
if (l9_2539)
{
l9_2614=mix(l9_2540,l9_2614,float4(l9_2543));
}
float4 l9_2615=l9_2614;
float4 l9_2616=l9_2615;
float3 l9_2617=(l9_2616.xyz*1.9921875)-float3(1.0);
l9_2616=float4(l9_2617.x,l9_2617.y,l9_2617.z,l9_2616.w);
l9_2523=l9_2616;
l9_2306=l9_2523.xyz;
l9_2309=l9_2306;
}
else
{
l9_2309=l9_2307;
}
l9_2305=l9_2309;
float3 l9_2618=float3(0.0);
float3 l9_2619=l9_2210.xyz;
float l9_2620=(*sc_set2.UserUniforms).Port_Strength1_N200;
float3 l9_2621=l9_2305;
float l9_2622=(*sc_set2.UserUniforms).Port_Strength2_N200;
float3 l9_2623=l9_2619;
float l9_2624=l9_2620;
float3 l9_2625=l9_2621;
float l9_2626=l9_2622;
float3 l9_2627=mix(float3(0.0,0.0,1.0),l9_2623,float3(l9_2624))+float3(0.0,0.0,1.0);
float3 l9_2628=mix(float3(0.0,0.0,1.0),l9_2625,float3(l9_2626))*float3(-1.0,-1.0,1.0);
float3 l9_2629=normalize((l9_2627*dot(l9_2627,l9_2628))-(l9_2628*l9_2627.z));
l9_2621=l9_2629;
float3 l9_2630=l9_2621;
l9_2618=l9_2630;
float3 l9_2631=float3(0.0);
l9_2631=l9_1996*l9_2618;
float3 l9_2632=float3(0.0);
float3 l9_2633=l9_2631;
float l9_2634=dot(l9_2633,l9_2633);
float l9_2635;
if (l9_2634>0.0)
{
l9_2635=1.0/sqrt(l9_2634);
}
else
{
l9_2635=0.0;
}
float l9_2636=l9_2635;
float3 l9_2637=l9_2633*l9_2636;
l9_2632=l9_2637;
l9_1989=l9_2632;
l9_1992=l9_1989;
}
else
{
float3 l9_2638=float3(0.0);
l9_2638=l9_1991.VertexNormal_WorldSpace;
float3 l9_2639=float3(0.0);
float3 l9_2640=l9_2638;
float l9_2641=dot(l9_2640,l9_2640);
float l9_2642;
if (l9_2641>0.0)
{
l9_2642=1.0/sqrt(l9_2641);
}
else
{
l9_2642=0.0;
}
float l9_2643=l9_2642;
float3 l9_2644=l9_2640*l9_2643;
l9_2639=l9_2644;
l9_1990=l9_2639;
l9_1992=l9_1990;
}
l9_1988=l9_1992;
float3 l9_2645=float3(0.0);
l9_2645=l9_1988;
float3 l9_2646=float3(0.0);
l9_2646=l9_2645;
float3 l9_2647=float3(0.0);
l9_2647=reflect(l9_1987,l9_2646);
float3 l9_2648=float3(0.0);
l9_2648=l9_2647*(*sc_set2.UserUniforms).Port_Input1_N257;
float3 l9_2649=float3(0.0);
l9_2649=l9_2648;
float2 l9_2650=float2(0.0);
l9_2650=float2(l9_2649.x,l9_2649.y);
float l9_2651=0.0;
float l9_2652=0.0;
float l9_2653=0.0;
float3 l9_2654=l9_2649;
float l9_2655=l9_2654.x;
float l9_2656=l9_2654.y;
float l9_2657=l9_2654.z;
l9_2651=l9_2655;
l9_2652=l9_2656;
l9_2653=l9_2657;
float l9_2658=0.0;
l9_2658=l9_2651*l9_2651;
float l9_2659=0.0;
l9_2659=l9_2652*l9_2652;
float l9_2660=0.0;
l9_2660=l9_2653+(*sc_set2.UserUniforms).Port_Input1_N264;
float l9_2661=0.0;
l9_2661=l9_2660*l9_2660;
float l9_2662=0.0;
l9_2662=(l9_2658+l9_2659)+l9_2661;
float l9_2663=0.0;
float l9_2664;
if (l9_2662<=0.0)
{
l9_2664=0.0;
}
else
{
l9_2664=sqrt(l9_2662);
}
l9_2663=l9_2664;
float l9_2665=0.0;
l9_2665=l9_2663*(*sc_set2.UserUniforms).Port_Input1_N268;
float2 l9_2666=float2(0.0);
l9_2666=l9_2650/float2(l9_2665);
float2 l9_2667=float2(0.0);
l9_2667=l9_2666+float2((*sc_set2.UserUniforms).Port_Input1_N270);
float2 l9_2668=float2(0.0);
l9_2668=float2(1.0)-l9_2667;
float2 l9_2669=float2(0.0);
l9_2669=l9_2668;
float4 l9_2670=float4(0.0);
int l9_2671=0;
if ((int(reflectionTexHasSwappedViews_tmp)!=0))
{
int l9_2672=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2672=0;
}
else
{
l9_2672=in.varStereoViewID;
}
int l9_2673=l9_2672;
l9_2671=1-l9_2673;
}
else
{
int l9_2674=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2674=0;
}
else
{
l9_2674=in.varStereoViewID;
}
int l9_2675=l9_2674;
l9_2671=l9_2675;
}
int l9_2676=l9_2671;
int l9_2677=reflectionTexLayout_tmp;
int l9_2678=l9_2676;
float2 l9_2679=l9_2669;
bool l9_2680=(int(SC_USE_UV_TRANSFORM_reflectionTex_tmp)!=0);
float3x3 l9_2681=(*sc_set2.UserUniforms).reflectionTexTransform;
int2 l9_2682=int2(SC_SOFTWARE_WRAP_MODE_U_reflectionTex_tmp,SC_SOFTWARE_WRAP_MODE_V_reflectionTex_tmp);
bool l9_2683=(int(SC_USE_UV_MIN_MAX_reflectionTex_tmp)!=0);
float4 l9_2684=(*sc_set2.UserUniforms).reflectionTexUvMinMax;
bool l9_2685=(int(SC_USE_CLAMP_TO_BORDER_reflectionTex_tmp)!=0);
float4 l9_2686=(*sc_set2.UserUniforms).reflectionTexBorderColor;
float l9_2687=0.0;
bool l9_2688=l9_2685&&(!l9_2683);
float l9_2689=1.0;
float l9_2690=l9_2679.x;
int l9_2691=l9_2682.x;
if (l9_2691==1)
{
l9_2690=fract(l9_2690);
}
else
{
if (l9_2691==2)
{
float l9_2692=fract(l9_2690);
float l9_2693=l9_2690-l9_2692;
float l9_2694=step(0.25,fract(l9_2693*0.5));
l9_2690=mix(l9_2692,1.0-l9_2692,fast::clamp(l9_2694,0.0,1.0));
}
}
l9_2679.x=l9_2690;
float l9_2695=l9_2679.y;
int l9_2696=l9_2682.y;
if (l9_2696==1)
{
l9_2695=fract(l9_2695);
}
else
{
if (l9_2696==2)
{
float l9_2697=fract(l9_2695);
float l9_2698=l9_2695-l9_2697;
float l9_2699=step(0.25,fract(l9_2698*0.5));
l9_2695=mix(l9_2697,1.0-l9_2697,fast::clamp(l9_2699,0.0,1.0));
}
}
l9_2679.y=l9_2695;
if (l9_2683)
{
bool l9_2700=l9_2685;
bool l9_2701;
if (l9_2700)
{
l9_2701=l9_2682.x==3;
}
else
{
l9_2701=l9_2700;
}
float l9_2702=l9_2679.x;
float l9_2703=l9_2684.x;
float l9_2704=l9_2684.z;
bool l9_2705=l9_2701;
float l9_2706=l9_2689;
float l9_2707=fast::clamp(l9_2702,l9_2703,l9_2704);
float l9_2708=step(abs(l9_2702-l9_2707),9.9999997e-06);
l9_2706*=(l9_2708+((1.0-float(l9_2705))*(1.0-l9_2708)));
l9_2702=l9_2707;
l9_2679.x=l9_2702;
l9_2689=l9_2706;
bool l9_2709=l9_2685;
bool l9_2710;
if (l9_2709)
{
l9_2710=l9_2682.y==3;
}
else
{
l9_2710=l9_2709;
}
float l9_2711=l9_2679.y;
float l9_2712=l9_2684.y;
float l9_2713=l9_2684.w;
bool l9_2714=l9_2710;
float l9_2715=l9_2689;
float l9_2716=fast::clamp(l9_2711,l9_2712,l9_2713);
float l9_2717=step(abs(l9_2711-l9_2716),9.9999997e-06);
l9_2715*=(l9_2717+((1.0-float(l9_2714))*(1.0-l9_2717)));
l9_2711=l9_2716;
l9_2679.y=l9_2711;
l9_2689=l9_2715;
}
float2 l9_2718=l9_2679;
bool l9_2719=l9_2680;
float3x3 l9_2720=l9_2681;
if (l9_2719)
{
l9_2718=float2((l9_2720*float3(l9_2718,1.0)).xy);
}
float2 l9_2721=l9_2718;
float2 l9_2722=l9_2721;
float2 l9_2723=l9_2722;
l9_2679=l9_2723;
float l9_2724=l9_2679.x;
int l9_2725=l9_2682.x;
bool l9_2726=l9_2688;
float l9_2727=l9_2689;
if ((l9_2725==0)||(l9_2725==3))
{
float l9_2728=l9_2724;
float l9_2729=0.0;
float l9_2730=1.0;
bool l9_2731=l9_2726;
float l9_2732=l9_2727;
float l9_2733=fast::clamp(l9_2728,l9_2729,l9_2730);
float l9_2734=step(abs(l9_2728-l9_2733),9.9999997e-06);
l9_2732*=(l9_2734+((1.0-float(l9_2731))*(1.0-l9_2734)));
l9_2728=l9_2733;
l9_2724=l9_2728;
l9_2727=l9_2732;
}
l9_2679.x=l9_2724;
l9_2689=l9_2727;
float l9_2735=l9_2679.y;
int l9_2736=l9_2682.y;
bool l9_2737=l9_2688;
float l9_2738=l9_2689;
if ((l9_2736==0)||(l9_2736==3))
{
float l9_2739=l9_2735;
float l9_2740=0.0;
float l9_2741=1.0;
bool l9_2742=l9_2737;
float l9_2743=l9_2738;
float l9_2744=fast::clamp(l9_2739,l9_2740,l9_2741);
float l9_2745=step(abs(l9_2739-l9_2744),9.9999997e-06);
l9_2743*=(l9_2745+((1.0-float(l9_2742))*(1.0-l9_2745)));
l9_2739=l9_2744;
l9_2735=l9_2739;
l9_2738=l9_2743;
}
l9_2679.y=l9_2735;
l9_2689=l9_2738;
float2 l9_2746=l9_2679;
int l9_2747=l9_2677;
int l9_2748=l9_2678;
float l9_2749=l9_2687;
float2 l9_2750=l9_2746;
int l9_2751=l9_2747;
int l9_2752=l9_2748;
float3 l9_2753=float3(0.0);
if (l9_2751==0)
{
l9_2753=float3(l9_2750,0.0);
}
else
{
if (l9_2751==1)
{
l9_2753=float3(l9_2750.x,(l9_2750.y*0.5)+(0.5-(float(l9_2752)*0.5)),0.0);
}
else
{
l9_2753=float3(l9_2750,float(l9_2752));
}
}
float3 l9_2754=l9_2753;
float3 l9_2755=l9_2754;
float2 l9_2756=l9_2755.xy;
float l9_2757=l9_2749;
float4 l9_2758=sc_set2.reflectionTex.sample(sc_set2.reflectionTexSmpSC,l9_2756,bias(l9_2757));
float4 l9_2759=l9_2758;
float4 l9_2760=l9_2759;
if (l9_2685)
{
l9_2760=mix(l9_2686,l9_2760,float4(l9_2689));
}
float4 l9_2761=l9_2760;
l9_2670=l9_2761;
float3 l9_2762=float3(0.0);
float3 l9_2763=float3(0.0);
float3 l9_2764=(*sc_set2.UserUniforms).Port_Default_N041;
ssGlobals l9_2765=param_11;
float3 l9_2766;
if ((int(ENABLE_REFLECTION_MODULATION_TEX_tmp)!=0))
{
float2 l9_2767=float2(0.0);
float2 l9_2768=float2(0.0);
float2 l9_2769=float2(0.0);
float2 l9_2770=float2(0.0);
float2 l9_2771=float2(0.0);
float2 l9_2772=float2(0.0);
ssGlobals l9_2773=l9_2765;
float2 l9_2774;
if (NODE_228_DROPLIST_ITEM_tmp==0)
{
float2 l9_2775=float2(0.0);
l9_2775=l9_2773.Surface_UVCoord0;
l9_2768=l9_2775;
l9_2774=l9_2768;
}
else
{
if (NODE_228_DROPLIST_ITEM_tmp==1)
{
float2 l9_2776=float2(0.0);
l9_2776=l9_2773.Surface_UVCoord1;
l9_2769=l9_2776;
l9_2774=l9_2769;
}
else
{
if (NODE_228_DROPLIST_ITEM_tmp==2)
{
float2 l9_2777=float2(0.0);
float2 l9_2778=float2(0.0);
float2 l9_2779=float2(0.0);
ssGlobals l9_2780=l9_2773;
float2 l9_2781;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2782=float2(0.0);
float2 l9_2783=float2(0.0);
float2 l9_2784=float2(0.0);
ssGlobals l9_2785=l9_2780;
float2 l9_2786;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2787=float2(0.0);
float2 l9_2788=float2(0.0);
float2 l9_2789=float2(0.0);
float2 l9_2790=float2(0.0);
float2 l9_2791=float2(0.0);
ssGlobals l9_2792=l9_2785;
float2 l9_2793;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2794=float2(0.0);
l9_2794=l9_2792.Surface_UVCoord0;
l9_2788=l9_2794;
l9_2793=l9_2788;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2795=float2(0.0);
l9_2795=l9_2792.Surface_UVCoord1;
l9_2789=l9_2795;
l9_2793=l9_2789;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2796=float2(0.0);
l9_2796=l9_2792.gScreenCoord;
l9_2790=l9_2796;
l9_2793=l9_2790;
}
else
{
float2 l9_2797=float2(0.0);
l9_2797=l9_2792.Surface_UVCoord0;
l9_2791=l9_2797;
l9_2793=l9_2791;
}
}
}
l9_2787=l9_2793;
float2 l9_2798=float2(0.0);
float2 l9_2799=(*sc_set2.UserUniforms).uv2Scale;
l9_2798=l9_2799;
float2 l9_2800=float2(0.0);
l9_2800=l9_2798;
float2 l9_2801=float2(0.0);
float2 l9_2802=(*sc_set2.UserUniforms).uv2Offset;
l9_2801=l9_2802;
float2 l9_2803=float2(0.0);
l9_2803=l9_2801;
float2 l9_2804=float2(0.0);
l9_2804=(l9_2787*l9_2800)+l9_2803;
float2 l9_2805=float2(0.0);
l9_2805=l9_2804+(l9_2803*(l9_2785.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2783=l9_2805;
l9_2786=l9_2783;
}
else
{
float2 l9_2806=float2(0.0);
float2 l9_2807=float2(0.0);
float2 l9_2808=float2(0.0);
float2 l9_2809=float2(0.0);
float2 l9_2810=float2(0.0);
ssGlobals l9_2811=l9_2785;
float2 l9_2812;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2813=float2(0.0);
l9_2813=l9_2811.Surface_UVCoord0;
l9_2807=l9_2813;
l9_2812=l9_2807;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2814=float2(0.0);
l9_2814=l9_2811.Surface_UVCoord1;
l9_2808=l9_2814;
l9_2812=l9_2808;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2815=float2(0.0);
l9_2815=l9_2811.gScreenCoord;
l9_2809=l9_2815;
l9_2812=l9_2809;
}
else
{
float2 l9_2816=float2(0.0);
l9_2816=l9_2811.Surface_UVCoord0;
l9_2810=l9_2816;
l9_2812=l9_2810;
}
}
}
l9_2806=l9_2812;
float2 l9_2817=float2(0.0);
float2 l9_2818=(*sc_set2.UserUniforms).uv2Scale;
l9_2817=l9_2818;
float2 l9_2819=float2(0.0);
l9_2819=l9_2817;
float2 l9_2820=float2(0.0);
float2 l9_2821=(*sc_set2.UserUniforms).uv2Offset;
l9_2820=l9_2821;
float2 l9_2822=float2(0.0);
l9_2822=l9_2820;
float2 l9_2823=float2(0.0);
l9_2823=(l9_2806*l9_2819)+l9_2822;
l9_2784=l9_2823;
l9_2786=l9_2784;
}
l9_2782=l9_2786;
l9_2778=l9_2782;
l9_2781=l9_2778;
}
else
{
float2 l9_2824=float2(0.0);
l9_2824=l9_2780.Surface_UVCoord0;
l9_2779=l9_2824;
l9_2781=l9_2779;
}
l9_2777=l9_2781;
float2 l9_2825=float2(0.0);
l9_2825=l9_2777;
float2 l9_2826=float2(0.0);
l9_2826=l9_2825;
l9_2770=l9_2826;
l9_2774=l9_2770;
}
else
{
if (NODE_228_DROPLIST_ITEM_tmp==3)
{
float2 l9_2827=float2(0.0);
float2 l9_2828=float2(0.0);
float2 l9_2829=float2(0.0);
ssGlobals l9_2830=l9_2773;
float2 l9_2831;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_2832=float2(0.0);
float2 l9_2833=float2(0.0);
float2 l9_2834=float2(0.0);
ssGlobals l9_2835=l9_2830;
float2 l9_2836;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_2837=float2(0.0);
float2 l9_2838=float2(0.0);
float2 l9_2839=float2(0.0);
float2 l9_2840=float2(0.0);
float2 l9_2841=float2(0.0);
float2 l9_2842=float2(0.0);
ssGlobals l9_2843=l9_2835;
float2 l9_2844;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_2845=float2(0.0);
l9_2845=l9_2843.Surface_UVCoord0;
l9_2838=l9_2845;
l9_2844=l9_2838;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_2846=float2(0.0);
l9_2846=l9_2843.Surface_UVCoord1;
l9_2839=l9_2846;
l9_2844=l9_2839;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_2847=float2(0.0);
l9_2847=l9_2843.gScreenCoord;
l9_2840=l9_2847;
l9_2844=l9_2840;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_2848=float2(0.0);
float2 l9_2849=float2(0.0);
float2 l9_2850=float2(0.0);
ssGlobals l9_2851=l9_2843;
float2 l9_2852;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2853=float2(0.0);
float2 l9_2854=float2(0.0);
float2 l9_2855=float2(0.0);
ssGlobals l9_2856=l9_2851;
float2 l9_2857;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2858=float2(0.0);
float2 l9_2859=float2(0.0);
float2 l9_2860=float2(0.0);
float2 l9_2861=float2(0.0);
float2 l9_2862=float2(0.0);
ssGlobals l9_2863=l9_2856;
float2 l9_2864;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2865=float2(0.0);
l9_2865=l9_2863.Surface_UVCoord0;
l9_2859=l9_2865;
l9_2864=l9_2859;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2866=float2(0.0);
l9_2866=l9_2863.Surface_UVCoord1;
l9_2860=l9_2866;
l9_2864=l9_2860;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2867=float2(0.0);
l9_2867=l9_2863.gScreenCoord;
l9_2861=l9_2867;
l9_2864=l9_2861;
}
else
{
float2 l9_2868=float2(0.0);
l9_2868=l9_2863.Surface_UVCoord0;
l9_2862=l9_2868;
l9_2864=l9_2862;
}
}
}
l9_2858=l9_2864;
float2 l9_2869=float2(0.0);
float2 l9_2870=(*sc_set2.UserUniforms).uv2Scale;
l9_2869=l9_2870;
float2 l9_2871=float2(0.0);
l9_2871=l9_2869;
float2 l9_2872=float2(0.0);
float2 l9_2873=(*sc_set2.UserUniforms).uv2Offset;
l9_2872=l9_2873;
float2 l9_2874=float2(0.0);
l9_2874=l9_2872;
float2 l9_2875=float2(0.0);
l9_2875=(l9_2858*l9_2871)+l9_2874;
float2 l9_2876=float2(0.0);
l9_2876=l9_2875+(l9_2874*(l9_2856.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2854=l9_2876;
l9_2857=l9_2854;
}
else
{
float2 l9_2877=float2(0.0);
float2 l9_2878=float2(0.0);
float2 l9_2879=float2(0.0);
float2 l9_2880=float2(0.0);
float2 l9_2881=float2(0.0);
ssGlobals l9_2882=l9_2856;
float2 l9_2883;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2884=float2(0.0);
l9_2884=l9_2882.Surface_UVCoord0;
l9_2878=l9_2884;
l9_2883=l9_2878;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2885=float2(0.0);
l9_2885=l9_2882.Surface_UVCoord1;
l9_2879=l9_2885;
l9_2883=l9_2879;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2886=float2(0.0);
l9_2886=l9_2882.gScreenCoord;
l9_2880=l9_2886;
l9_2883=l9_2880;
}
else
{
float2 l9_2887=float2(0.0);
l9_2887=l9_2882.Surface_UVCoord0;
l9_2881=l9_2887;
l9_2883=l9_2881;
}
}
}
l9_2877=l9_2883;
float2 l9_2888=float2(0.0);
float2 l9_2889=(*sc_set2.UserUniforms).uv2Scale;
l9_2888=l9_2889;
float2 l9_2890=float2(0.0);
l9_2890=l9_2888;
float2 l9_2891=float2(0.0);
float2 l9_2892=(*sc_set2.UserUniforms).uv2Offset;
l9_2891=l9_2892;
float2 l9_2893=float2(0.0);
l9_2893=l9_2891;
float2 l9_2894=float2(0.0);
l9_2894=(l9_2877*l9_2890)+l9_2893;
l9_2855=l9_2894;
l9_2857=l9_2855;
}
l9_2853=l9_2857;
l9_2849=l9_2853;
l9_2852=l9_2849;
}
else
{
float2 l9_2895=float2(0.0);
l9_2895=l9_2851.Surface_UVCoord0;
l9_2850=l9_2895;
l9_2852=l9_2850;
}
l9_2848=l9_2852;
float2 l9_2896=float2(0.0);
l9_2896=l9_2848;
float2 l9_2897=float2(0.0);
l9_2897=l9_2896;
l9_2841=l9_2897;
l9_2844=l9_2841;
}
else
{
float2 l9_2898=float2(0.0);
l9_2898=l9_2843.Surface_UVCoord0;
l9_2842=l9_2898;
l9_2844=l9_2842;
}
}
}
}
l9_2837=l9_2844;
float2 l9_2899=float2(0.0);
float2 l9_2900=(*sc_set2.UserUniforms).uv3Scale;
l9_2899=l9_2900;
float2 l9_2901=float2(0.0);
l9_2901=l9_2899;
float2 l9_2902=float2(0.0);
float2 l9_2903=(*sc_set2.UserUniforms).uv3Offset;
l9_2902=l9_2903;
float2 l9_2904=float2(0.0);
l9_2904=l9_2902;
float2 l9_2905=float2(0.0);
l9_2905=(l9_2837*l9_2901)+l9_2904;
float2 l9_2906=float2(0.0);
l9_2906=l9_2905+(l9_2904*(l9_2835.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_2833=l9_2906;
l9_2836=l9_2833;
}
else
{
float2 l9_2907=float2(0.0);
float2 l9_2908=float2(0.0);
float2 l9_2909=float2(0.0);
float2 l9_2910=float2(0.0);
float2 l9_2911=float2(0.0);
float2 l9_2912=float2(0.0);
ssGlobals l9_2913=l9_2835;
float2 l9_2914;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_2915=float2(0.0);
l9_2915=l9_2913.Surface_UVCoord0;
l9_2908=l9_2915;
l9_2914=l9_2908;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_2916=float2(0.0);
l9_2916=l9_2913.Surface_UVCoord1;
l9_2909=l9_2916;
l9_2914=l9_2909;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_2917=float2(0.0);
l9_2917=l9_2913.gScreenCoord;
l9_2910=l9_2917;
l9_2914=l9_2910;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_2918=float2(0.0);
float2 l9_2919=float2(0.0);
float2 l9_2920=float2(0.0);
ssGlobals l9_2921=l9_2913;
float2 l9_2922;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_2923=float2(0.0);
float2 l9_2924=float2(0.0);
float2 l9_2925=float2(0.0);
ssGlobals l9_2926=l9_2921;
float2 l9_2927;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_2928=float2(0.0);
float2 l9_2929=float2(0.0);
float2 l9_2930=float2(0.0);
float2 l9_2931=float2(0.0);
float2 l9_2932=float2(0.0);
ssGlobals l9_2933=l9_2926;
float2 l9_2934;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2935=float2(0.0);
l9_2935=l9_2933.Surface_UVCoord0;
l9_2929=l9_2935;
l9_2934=l9_2929;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2936=float2(0.0);
l9_2936=l9_2933.Surface_UVCoord1;
l9_2930=l9_2936;
l9_2934=l9_2930;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2937=float2(0.0);
l9_2937=l9_2933.gScreenCoord;
l9_2931=l9_2937;
l9_2934=l9_2931;
}
else
{
float2 l9_2938=float2(0.0);
l9_2938=l9_2933.Surface_UVCoord0;
l9_2932=l9_2938;
l9_2934=l9_2932;
}
}
}
l9_2928=l9_2934;
float2 l9_2939=float2(0.0);
float2 l9_2940=(*sc_set2.UserUniforms).uv2Scale;
l9_2939=l9_2940;
float2 l9_2941=float2(0.0);
l9_2941=l9_2939;
float2 l9_2942=float2(0.0);
float2 l9_2943=(*sc_set2.UserUniforms).uv2Offset;
l9_2942=l9_2943;
float2 l9_2944=float2(0.0);
l9_2944=l9_2942;
float2 l9_2945=float2(0.0);
l9_2945=(l9_2928*l9_2941)+l9_2944;
float2 l9_2946=float2(0.0);
l9_2946=l9_2945+(l9_2944*(l9_2926.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_2924=l9_2946;
l9_2927=l9_2924;
}
else
{
float2 l9_2947=float2(0.0);
float2 l9_2948=float2(0.0);
float2 l9_2949=float2(0.0);
float2 l9_2950=float2(0.0);
float2 l9_2951=float2(0.0);
ssGlobals l9_2952=l9_2926;
float2 l9_2953;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_2954=float2(0.0);
l9_2954=l9_2952.Surface_UVCoord0;
l9_2948=l9_2954;
l9_2953=l9_2948;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_2955=float2(0.0);
l9_2955=l9_2952.Surface_UVCoord1;
l9_2949=l9_2955;
l9_2953=l9_2949;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_2956=float2(0.0);
l9_2956=l9_2952.gScreenCoord;
l9_2950=l9_2956;
l9_2953=l9_2950;
}
else
{
float2 l9_2957=float2(0.0);
l9_2957=l9_2952.Surface_UVCoord0;
l9_2951=l9_2957;
l9_2953=l9_2951;
}
}
}
l9_2947=l9_2953;
float2 l9_2958=float2(0.0);
float2 l9_2959=(*sc_set2.UserUniforms).uv2Scale;
l9_2958=l9_2959;
float2 l9_2960=float2(0.0);
l9_2960=l9_2958;
float2 l9_2961=float2(0.0);
float2 l9_2962=(*sc_set2.UserUniforms).uv2Offset;
l9_2961=l9_2962;
float2 l9_2963=float2(0.0);
l9_2963=l9_2961;
float2 l9_2964=float2(0.0);
l9_2964=(l9_2947*l9_2960)+l9_2963;
l9_2925=l9_2964;
l9_2927=l9_2925;
}
l9_2923=l9_2927;
l9_2919=l9_2923;
l9_2922=l9_2919;
}
else
{
float2 l9_2965=float2(0.0);
l9_2965=l9_2921.Surface_UVCoord0;
l9_2920=l9_2965;
l9_2922=l9_2920;
}
l9_2918=l9_2922;
float2 l9_2966=float2(0.0);
l9_2966=l9_2918;
float2 l9_2967=float2(0.0);
l9_2967=l9_2966;
l9_2911=l9_2967;
l9_2914=l9_2911;
}
else
{
float2 l9_2968=float2(0.0);
l9_2968=l9_2913.Surface_UVCoord0;
l9_2912=l9_2968;
l9_2914=l9_2912;
}
}
}
}
l9_2907=l9_2914;
float2 l9_2969=float2(0.0);
float2 l9_2970=(*sc_set2.UserUniforms).uv3Scale;
l9_2969=l9_2970;
float2 l9_2971=float2(0.0);
l9_2971=l9_2969;
float2 l9_2972=float2(0.0);
float2 l9_2973=(*sc_set2.UserUniforms).uv3Offset;
l9_2972=l9_2973;
float2 l9_2974=float2(0.0);
l9_2974=l9_2972;
float2 l9_2975=float2(0.0);
l9_2975=(l9_2907*l9_2971)+l9_2974;
l9_2834=l9_2975;
l9_2836=l9_2834;
}
l9_2832=l9_2836;
l9_2828=l9_2832;
l9_2831=l9_2828;
}
else
{
float2 l9_2976=float2(0.0);
l9_2976=l9_2830.Surface_UVCoord0;
l9_2829=l9_2976;
l9_2831=l9_2829;
}
l9_2827=l9_2831;
float2 l9_2977=float2(0.0);
l9_2977=l9_2827;
float2 l9_2978=float2(0.0);
l9_2978=l9_2977;
l9_2771=l9_2978;
l9_2774=l9_2771;
}
else
{
float2 l9_2979=float2(0.0);
l9_2979=l9_2773.Surface_UVCoord0;
l9_2772=l9_2979;
l9_2774=l9_2772;
}
}
}
}
l9_2767=l9_2774;
float4 l9_2980=float4(0.0);
int l9_2981=0;
if ((int(reflectionModulationTexHasSwappedViews_tmp)!=0))
{
int l9_2982=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2982=0;
}
else
{
l9_2982=in.varStereoViewID;
}
int l9_2983=l9_2982;
l9_2981=1-l9_2983;
}
else
{
int l9_2984=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2984=0;
}
else
{
l9_2984=in.varStereoViewID;
}
int l9_2985=l9_2984;
l9_2981=l9_2985;
}
int l9_2986=l9_2981;
int l9_2987=reflectionModulationTexLayout_tmp;
int l9_2988=l9_2986;
float2 l9_2989=l9_2767;
bool l9_2990=(int(SC_USE_UV_TRANSFORM_reflectionModulationTex_tmp)!=0);
float3x3 l9_2991=(*sc_set2.UserUniforms).reflectionModulationTexTransform;
int2 l9_2992=int2(SC_SOFTWARE_WRAP_MODE_U_reflectionModulationTex_tmp,SC_SOFTWARE_WRAP_MODE_V_reflectionModulationTex_tmp);
bool l9_2993=(int(SC_USE_UV_MIN_MAX_reflectionModulationTex_tmp)!=0);
float4 l9_2994=(*sc_set2.UserUniforms).reflectionModulationTexUvMinMax;
bool l9_2995=(int(SC_USE_CLAMP_TO_BORDER_reflectionModulationTex_tmp)!=0);
float4 l9_2996=(*sc_set2.UserUniforms).reflectionModulationTexBorderColor;
float l9_2997=0.0;
bool l9_2998=l9_2995&&(!l9_2993);
float l9_2999=1.0;
float l9_3000=l9_2989.x;
int l9_3001=l9_2992.x;
if (l9_3001==1)
{
l9_3000=fract(l9_3000);
}
else
{
if (l9_3001==2)
{
float l9_3002=fract(l9_3000);
float l9_3003=l9_3000-l9_3002;
float l9_3004=step(0.25,fract(l9_3003*0.5));
l9_3000=mix(l9_3002,1.0-l9_3002,fast::clamp(l9_3004,0.0,1.0));
}
}
l9_2989.x=l9_3000;
float l9_3005=l9_2989.y;
int l9_3006=l9_2992.y;
if (l9_3006==1)
{
l9_3005=fract(l9_3005);
}
else
{
if (l9_3006==2)
{
float l9_3007=fract(l9_3005);
float l9_3008=l9_3005-l9_3007;
float l9_3009=step(0.25,fract(l9_3008*0.5));
l9_3005=mix(l9_3007,1.0-l9_3007,fast::clamp(l9_3009,0.0,1.0));
}
}
l9_2989.y=l9_3005;
if (l9_2993)
{
bool l9_3010=l9_2995;
bool l9_3011;
if (l9_3010)
{
l9_3011=l9_2992.x==3;
}
else
{
l9_3011=l9_3010;
}
float l9_3012=l9_2989.x;
float l9_3013=l9_2994.x;
float l9_3014=l9_2994.z;
bool l9_3015=l9_3011;
float l9_3016=l9_2999;
float l9_3017=fast::clamp(l9_3012,l9_3013,l9_3014);
float l9_3018=step(abs(l9_3012-l9_3017),9.9999997e-06);
l9_3016*=(l9_3018+((1.0-float(l9_3015))*(1.0-l9_3018)));
l9_3012=l9_3017;
l9_2989.x=l9_3012;
l9_2999=l9_3016;
bool l9_3019=l9_2995;
bool l9_3020;
if (l9_3019)
{
l9_3020=l9_2992.y==3;
}
else
{
l9_3020=l9_3019;
}
float l9_3021=l9_2989.y;
float l9_3022=l9_2994.y;
float l9_3023=l9_2994.w;
bool l9_3024=l9_3020;
float l9_3025=l9_2999;
float l9_3026=fast::clamp(l9_3021,l9_3022,l9_3023);
float l9_3027=step(abs(l9_3021-l9_3026),9.9999997e-06);
l9_3025*=(l9_3027+((1.0-float(l9_3024))*(1.0-l9_3027)));
l9_3021=l9_3026;
l9_2989.y=l9_3021;
l9_2999=l9_3025;
}
float2 l9_3028=l9_2989;
bool l9_3029=l9_2990;
float3x3 l9_3030=l9_2991;
if (l9_3029)
{
l9_3028=float2((l9_3030*float3(l9_3028,1.0)).xy);
}
float2 l9_3031=l9_3028;
float2 l9_3032=l9_3031;
float2 l9_3033=l9_3032;
l9_2989=l9_3033;
float l9_3034=l9_2989.x;
int l9_3035=l9_2992.x;
bool l9_3036=l9_2998;
float l9_3037=l9_2999;
if ((l9_3035==0)||(l9_3035==3))
{
float l9_3038=l9_3034;
float l9_3039=0.0;
float l9_3040=1.0;
bool l9_3041=l9_3036;
float l9_3042=l9_3037;
float l9_3043=fast::clamp(l9_3038,l9_3039,l9_3040);
float l9_3044=step(abs(l9_3038-l9_3043),9.9999997e-06);
l9_3042*=(l9_3044+((1.0-float(l9_3041))*(1.0-l9_3044)));
l9_3038=l9_3043;
l9_3034=l9_3038;
l9_3037=l9_3042;
}
l9_2989.x=l9_3034;
l9_2999=l9_3037;
float l9_3045=l9_2989.y;
int l9_3046=l9_2992.y;
bool l9_3047=l9_2998;
float l9_3048=l9_2999;
if ((l9_3046==0)||(l9_3046==3))
{
float l9_3049=l9_3045;
float l9_3050=0.0;
float l9_3051=1.0;
bool l9_3052=l9_3047;
float l9_3053=l9_3048;
float l9_3054=fast::clamp(l9_3049,l9_3050,l9_3051);
float l9_3055=step(abs(l9_3049-l9_3054),9.9999997e-06);
l9_3053*=(l9_3055+((1.0-float(l9_3052))*(1.0-l9_3055)));
l9_3049=l9_3054;
l9_3045=l9_3049;
l9_3048=l9_3053;
}
l9_2989.y=l9_3045;
l9_2999=l9_3048;
float2 l9_3056=l9_2989;
int l9_3057=l9_2987;
int l9_3058=l9_2988;
float l9_3059=l9_2997;
float2 l9_3060=l9_3056;
int l9_3061=l9_3057;
int l9_3062=l9_3058;
float3 l9_3063=float3(0.0);
if (l9_3061==0)
{
l9_3063=float3(l9_3060,0.0);
}
else
{
if (l9_3061==1)
{
l9_3063=float3(l9_3060.x,(l9_3060.y*0.5)+(0.5-(float(l9_3062)*0.5)),0.0);
}
else
{
l9_3063=float3(l9_3060,float(l9_3062));
}
}
float3 l9_3064=l9_3063;
float3 l9_3065=l9_3064;
float2 l9_3066=l9_3065.xy;
float l9_3067=l9_3059;
float4 l9_3068=sc_set2.reflectionModulationTex.sample(sc_set2.reflectionModulationTexSmpSC,l9_3066,bias(l9_3067));
float4 l9_3069=l9_3068;
float4 l9_3070=l9_3069;
if (l9_2995)
{
l9_3070=mix(l9_2996,l9_3070,float4(l9_2999));
}
float4 l9_3071=l9_3070;
l9_2980=l9_3071;
l9_2763=l9_2980.xyz;
l9_2766=l9_2763;
}
else
{
l9_2766=l9_2764;
}
l9_2762=l9_2766;
float3 l9_3072=float3(0.0);
l9_3072=l9_2670.xyz*l9_2762;
float3 l9_3073=float3(0.0);
float3 l9_3074=l9_3072;
float3 l9_3075;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_3075=float3(pow(l9_3074.x,2.2),pow(l9_3074.y,2.2),pow(l9_3074.z,2.2));
}
else
{
l9_3075=l9_3074*l9_3074;
}
float3 l9_3076=l9_3075;
l9_3073=l9_3076;
float3 l9_3077=float3(0.0);
l9_3077=float3(l9_1986)*l9_3073;
param_8=l9_3077;
param_10=param_8;
}
else
{
param_10=param_9;
}
Result_N134=param_10;
float3 Export_N303=float3(0.0);
Export_N303=Result_N134;
float3 Value_N298=float3(0.0);
Value_N298=Export_N303;
float3 Result_N173=float3(0.0);
float3 param_12=float3(0.0);
float3 param_13=(*sc_set2.UserUniforms).Port_Default_N173;
ssGlobals param_15=Globals;
float3 param_14;
if ((int(ENABLE_RIM_HIGHLIGHT_tmp)!=0))
{
float3 l9_3078=float3(0.0);
float3 l9_3079=(*sc_set2.UserUniforms).rimColor;
l9_3078=l9_3079;
float3 l9_3080=float3(0.0);
l9_3080=l9_3078;
float l9_3081=0.0;
float l9_3082=(*sc_set2.UserUniforms).rimIntensity;
l9_3081=l9_3082;
float l9_3083=0.0;
l9_3083=l9_3081;
float3 l9_3084=float3(0.0);
float3 l9_3085=float3(0.0);
float3 l9_3086=(*sc_set2.UserUniforms).Port_Default_N170;
ssGlobals l9_3087=param_15;
float3 l9_3088;
if ((int(ENABLE_RIM_COLOR_TEX_tmp)!=0))
{
float2 l9_3089=float2(0.0);
float2 l9_3090=float2(0.0);
float2 l9_3091=float2(0.0);
float2 l9_3092=float2(0.0);
float2 l9_3093=float2(0.0);
float2 l9_3094=float2(0.0);
ssGlobals l9_3095=l9_3087;
float2 l9_3096;
if (NODE_315_DROPLIST_ITEM_tmp==0)
{
float2 l9_3097=float2(0.0);
l9_3097=l9_3095.Surface_UVCoord0;
l9_3090=l9_3097;
l9_3096=l9_3090;
}
else
{
if (NODE_315_DROPLIST_ITEM_tmp==1)
{
float2 l9_3098=float2(0.0);
l9_3098=l9_3095.Surface_UVCoord1;
l9_3091=l9_3098;
l9_3096=l9_3091;
}
else
{
if (NODE_315_DROPLIST_ITEM_tmp==2)
{
float2 l9_3099=float2(0.0);
float2 l9_3100=float2(0.0);
float2 l9_3101=float2(0.0);
ssGlobals l9_3102=l9_3095;
float2 l9_3103;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3104=float2(0.0);
float2 l9_3105=float2(0.0);
float2 l9_3106=float2(0.0);
ssGlobals l9_3107=l9_3102;
float2 l9_3108;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3109=float2(0.0);
float2 l9_3110=float2(0.0);
float2 l9_3111=float2(0.0);
float2 l9_3112=float2(0.0);
float2 l9_3113=float2(0.0);
ssGlobals l9_3114=l9_3107;
float2 l9_3115;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3116=float2(0.0);
l9_3116=l9_3114.Surface_UVCoord0;
l9_3110=l9_3116;
l9_3115=l9_3110;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3117=float2(0.0);
l9_3117=l9_3114.Surface_UVCoord1;
l9_3111=l9_3117;
l9_3115=l9_3111;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3118=float2(0.0);
l9_3118=l9_3114.gScreenCoord;
l9_3112=l9_3118;
l9_3115=l9_3112;
}
else
{
float2 l9_3119=float2(0.0);
l9_3119=l9_3114.Surface_UVCoord0;
l9_3113=l9_3119;
l9_3115=l9_3113;
}
}
}
l9_3109=l9_3115;
float2 l9_3120=float2(0.0);
float2 l9_3121=(*sc_set2.UserUniforms).uv2Scale;
l9_3120=l9_3121;
float2 l9_3122=float2(0.0);
l9_3122=l9_3120;
float2 l9_3123=float2(0.0);
float2 l9_3124=(*sc_set2.UserUniforms).uv2Offset;
l9_3123=l9_3124;
float2 l9_3125=float2(0.0);
l9_3125=l9_3123;
float2 l9_3126=float2(0.0);
l9_3126=(l9_3109*l9_3122)+l9_3125;
float2 l9_3127=float2(0.0);
l9_3127=l9_3126+(l9_3125*(l9_3107.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3105=l9_3127;
l9_3108=l9_3105;
}
else
{
float2 l9_3128=float2(0.0);
float2 l9_3129=float2(0.0);
float2 l9_3130=float2(0.0);
float2 l9_3131=float2(0.0);
float2 l9_3132=float2(0.0);
ssGlobals l9_3133=l9_3107;
float2 l9_3134;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3135=float2(0.0);
l9_3135=l9_3133.Surface_UVCoord0;
l9_3129=l9_3135;
l9_3134=l9_3129;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3136=float2(0.0);
l9_3136=l9_3133.Surface_UVCoord1;
l9_3130=l9_3136;
l9_3134=l9_3130;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3137=float2(0.0);
l9_3137=l9_3133.gScreenCoord;
l9_3131=l9_3137;
l9_3134=l9_3131;
}
else
{
float2 l9_3138=float2(0.0);
l9_3138=l9_3133.Surface_UVCoord0;
l9_3132=l9_3138;
l9_3134=l9_3132;
}
}
}
l9_3128=l9_3134;
float2 l9_3139=float2(0.0);
float2 l9_3140=(*sc_set2.UserUniforms).uv2Scale;
l9_3139=l9_3140;
float2 l9_3141=float2(0.0);
l9_3141=l9_3139;
float2 l9_3142=float2(0.0);
float2 l9_3143=(*sc_set2.UserUniforms).uv2Offset;
l9_3142=l9_3143;
float2 l9_3144=float2(0.0);
l9_3144=l9_3142;
float2 l9_3145=float2(0.0);
l9_3145=(l9_3128*l9_3141)+l9_3144;
l9_3106=l9_3145;
l9_3108=l9_3106;
}
l9_3104=l9_3108;
l9_3100=l9_3104;
l9_3103=l9_3100;
}
else
{
float2 l9_3146=float2(0.0);
l9_3146=l9_3102.Surface_UVCoord0;
l9_3101=l9_3146;
l9_3103=l9_3101;
}
l9_3099=l9_3103;
float2 l9_3147=float2(0.0);
l9_3147=l9_3099;
float2 l9_3148=float2(0.0);
l9_3148=l9_3147;
l9_3092=l9_3148;
l9_3096=l9_3092;
}
else
{
if (NODE_315_DROPLIST_ITEM_tmp==3)
{
float2 l9_3149=float2(0.0);
float2 l9_3150=float2(0.0);
float2 l9_3151=float2(0.0);
ssGlobals l9_3152=l9_3095;
float2 l9_3153;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_3154=float2(0.0);
float2 l9_3155=float2(0.0);
float2 l9_3156=float2(0.0);
ssGlobals l9_3157=l9_3152;
float2 l9_3158;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_3159=float2(0.0);
float2 l9_3160=float2(0.0);
float2 l9_3161=float2(0.0);
float2 l9_3162=float2(0.0);
float2 l9_3163=float2(0.0);
float2 l9_3164=float2(0.0);
ssGlobals l9_3165=l9_3157;
float2 l9_3166;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_3167=float2(0.0);
l9_3167=l9_3165.Surface_UVCoord0;
l9_3160=l9_3167;
l9_3166=l9_3160;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_3168=float2(0.0);
l9_3168=l9_3165.Surface_UVCoord1;
l9_3161=l9_3168;
l9_3166=l9_3161;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_3169=float2(0.0);
l9_3169=l9_3165.gScreenCoord;
l9_3162=l9_3169;
l9_3166=l9_3162;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_3170=float2(0.0);
float2 l9_3171=float2(0.0);
float2 l9_3172=float2(0.0);
ssGlobals l9_3173=l9_3165;
float2 l9_3174;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3175=float2(0.0);
float2 l9_3176=float2(0.0);
float2 l9_3177=float2(0.0);
ssGlobals l9_3178=l9_3173;
float2 l9_3179;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3180=float2(0.0);
float2 l9_3181=float2(0.0);
float2 l9_3182=float2(0.0);
float2 l9_3183=float2(0.0);
float2 l9_3184=float2(0.0);
ssGlobals l9_3185=l9_3178;
float2 l9_3186;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3187=float2(0.0);
l9_3187=l9_3185.Surface_UVCoord0;
l9_3181=l9_3187;
l9_3186=l9_3181;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3188=float2(0.0);
l9_3188=l9_3185.Surface_UVCoord1;
l9_3182=l9_3188;
l9_3186=l9_3182;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3189=float2(0.0);
l9_3189=l9_3185.gScreenCoord;
l9_3183=l9_3189;
l9_3186=l9_3183;
}
else
{
float2 l9_3190=float2(0.0);
l9_3190=l9_3185.Surface_UVCoord0;
l9_3184=l9_3190;
l9_3186=l9_3184;
}
}
}
l9_3180=l9_3186;
float2 l9_3191=float2(0.0);
float2 l9_3192=(*sc_set2.UserUniforms).uv2Scale;
l9_3191=l9_3192;
float2 l9_3193=float2(0.0);
l9_3193=l9_3191;
float2 l9_3194=float2(0.0);
float2 l9_3195=(*sc_set2.UserUniforms).uv2Offset;
l9_3194=l9_3195;
float2 l9_3196=float2(0.0);
l9_3196=l9_3194;
float2 l9_3197=float2(0.0);
l9_3197=(l9_3180*l9_3193)+l9_3196;
float2 l9_3198=float2(0.0);
l9_3198=l9_3197+(l9_3196*(l9_3178.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3176=l9_3198;
l9_3179=l9_3176;
}
else
{
float2 l9_3199=float2(0.0);
float2 l9_3200=float2(0.0);
float2 l9_3201=float2(0.0);
float2 l9_3202=float2(0.0);
float2 l9_3203=float2(0.0);
ssGlobals l9_3204=l9_3178;
float2 l9_3205;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3206=float2(0.0);
l9_3206=l9_3204.Surface_UVCoord0;
l9_3200=l9_3206;
l9_3205=l9_3200;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3207=float2(0.0);
l9_3207=l9_3204.Surface_UVCoord1;
l9_3201=l9_3207;
l9_3205=l9_3201;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3208=float2(0.0);
l9_3208=l9_3204.gScreenCoord;
l9_3202=l9_3208;
l9_3205=l9_3202;
}
else
{
float2 l9_3209=float2(0.0);
l9_3209=l9_3204.Surface_UVCoord0;
l9_3203=l9_3209;
l9_3205=l9_3203;
}
}
}
l9_3199=l9_3205;
float2 l9_3210=float2(0.0);
float2 l9_3211=(*sc_set2.UserUniforms).uv2Scale;
l9_3210=l9_3211;
float2 l9_3212=float2(0.0);
l9_3212=l9_3210;
float2 l9_3213=float2(0.0);
float2 l9_3214=(*sc_set2.UserUniforms).uv2Offset;
l9_3213=l9_3214;
float2 l9_3215=float2(0.0);
l9_3215=l9_3213;
float2 l9_3216=float2(0.0);
l9_3216=(l9_3199*l9_3212)+l9_3215;
l9_3177=l9_3216;
l9_3179=l9_3177;
}
l9_3175=l9_3179;
l9_3171=l9_3175;
l9_3174=l9_3171;
}
else
{
float2 l9_3217=float2(0.0);
l9_3217=l9_3173.Surface_UVCoord0;
l9_3172=l9_3217;
l9_3174=l9_3172;
}
l9_3170=l9_3174;
float2 l9_3218=float2(0.0);
l9_3218=l9_3170;
float2 l9_3219=float2(0.0);
l9_3219=l9_3218;
l9_3163=l9_3219;
l9_3166=l9_3163;
}
else
{
float2 l9_3220=float2(0.0);
l9_3220=l9_3165.Surface_UVCoord0;
l9_3164=l9_3220;
l9_3166=l9_3164;
}
}
}
}
l9_3159=l9_3166;
float2 l9_3221=float2(0.0);
float2 l9_3222=(*sc_set2.UserUniforms).uv3Scale;
l9_3221=l9_3222;
float2 l9_3223=float2(0.0);
l9_3223=l9_3221;
float2 l9_3224=float2(0.0);
float2 l9_3225=(*sc_set2.UserUniforms).uv3Offset;
l9_3224=l9_3225;
float2 l9_3226=float2(0.0);
l9_3226=l9_3224;
float2 l9_3227=float2(0.0);
l9_3227=(l9_3159*l9_3223)+l9_3226;
float2 l9_3228=float2(0.0);
l9_3228=l9_3227+(l9_3226*(l9_3157.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_3155=l9_3228;
l9_3158=l9_3155;
}
else
{
float2 l9_3229=float2(0.0);
float2 l9_3230=float2(0.0);
float2 l9_3231=float2(0.0);
float2 l9_3232=float2(0.0);
float2 l9_3233=float2(0.0);
float2 l9_3234=float2(0.0);
ssGlobals l9_3235=l9_3157;
float2 l9_3236;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_3237=float2(0.0);
l9_3237=l9_3235.Surface_UVCoord0;
l9_3230=l9_3237;
l9_3236=l9_3230;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_3238=float2(0.0);
l9_3238=l9_3235.Surface_UVCoord1;
l9_3231=l9_3238;
l9_3236=l9_3231;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_3239=float2(0.0);
l9_3239=l9_3235.gScreenCoord;
l9_3232=l9_3239;
l9_3236=l9_3232;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_3240=float2(0.0);
float2 l9_3241=float2(0.0);
float2 l9_3242=float2(0.0);
ssGlobals l9_3243=l9_3235;
float2 l9_3244;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3245=float2(0.0);
float2 l9_3246=float2(0.0);
float2 l9_3247=float2(0.0);
ssGlobals l9_3248=l9_3243;
float2 l9_3249;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3250=float2(0.0);
float2 l9_3251=float2(0.0);
float2 l9_3252=float2(0.0);
float2 l9_3253=float2(0.0);
float2 l9_3254=float2(0.0);
ssGlobals l9_3255=l9_3248;
float2 l9_3256;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3257=float2(0.0);
l9_3257=l9_3255.Surface_UVCoord0;
l9_3251=l9_3257;
l9_3256=l9_3251;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3258=float2(0.0);
l9_3258=l9_3255.Surface_UVCoord1;
l9_3252=l9_3258;
l9_3256=l9_3252;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3259=float2(0.0);
l9_3259=l9_3255.gScreenCoord;
l9_3253=l9_3259;
l9_3256=l9_3253;
}
else
{
float2 l9_3260=float2(0.0);
l9_3260=l9_3255.Surface_UVCoord0;
l9_3254=l9_3260;
l9_3256=l9_3254;
}
}
}
l9_3250=l9_3256;
float2 l9_3261=float2(0.0);
float2 l9_3262=(*sc_set2.UserUniforms).uv2Scale;
l9_3261=l9_3262;
float2 l9_3263=float2(0.0);
l9_3263=l9_3261;
float2 l9_3264=float2(0.0);
float2 l9_3265=(*sc_set2.UserUniforms).uv2Offset;
l9_3264=l9_3265;
float2 l9_3266=float2(0.0);
l9_3266=l9_3264;
float2 l9_3267=float2(0.0);
l9_3267=(l9_3250*l9_3263)+l9_3266;
float2 l9_3268=float2(0.0);
l9_3268=l9_3267+(l9_3266*(l9_3248.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3246=l9_3268;
l9_3249=l9_3246;
}
else
{
float2 l9_3269=float2(0.0);
float2 l9_3270=float2(0.0);
float2 l9_3271=float2(0.0);
float2 l9_3272=float2(0.0);
float2 l9_3273=float2(0.0);
ssGlobals l9_3274=l9_3248;
float2 l9_3275;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3276=float2(0.0);
l9_3276=l9_3274.Surface_UVCoord0;
l9_3270=l9_3276;
l9_3275=l9_3270;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3277=float2(0.0);
l9_3277=l9_3274.Surface_UVCoord1;
l9_3271=l9_3277;
l9_3275=l9_3271;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3278=float2(0.0);
l9_3278=l9_3274.gScreenCoord;
l9_3272=l9_3278;
l9_3275=l9_3272;
}
else
{
float2 l9_3279=float2(0.0);
l9_3279=l9_3274.Surface_UVCoord0;
l9_3273=l9_3279;
l9_3275=l9_3273;
}
}
}
l9_3269=l9_3275;
float2 l9_3280=float2(0.0);
float2 l9_3281=(*sc_set2.UserUniforms).uv2Scale;
l9_3280=l9_3281;
float2 l9_3282=float2(0.0);
l9_3282=l9_3280;
float2 l9_3283=float2(0.0);
float2 l9_3284=(*sc_set2.UserUniforms).uv2Offset;
l9_3283=l9_3284;
float2 l9_3285=float2(0.0);
l9_3285=l9_3283;
float2 l9_3286=float2(0.0);
l9_3286=(l9_3269*l9_3282)+l9_3285;
l9_3247=l9_3286;
l9_3249=l9_3247;
}
l9_3245=l9_3249;
l9_3241=l9_3245;
l9_3244=l9_3241;
}
else
{
float2 l9_3287=float2(0.0);
l9_3287=l9_3243.Surface_UVCoord0;
l9_3242=l9_3287;
l9_3244=l9_3242;
}
l9_3240=l9_3244;
float2 l9_3288=float2(0.0);
l9_3288=l9_3240;
float2 l9_3289=float2(0.0);
l9_3289=l9_3288;
l9_3233=l9_3289;
l9_3236=l9_3233;
}
else
{
float2 l9_3290=float2(0.0);
l9_3290=l9_3235.Surface_UVCoord0;
l9_3234=l9_3290;
l9_3236=l9_3234;
}
}
}
}
l9_3229=l9_3236;
float2 l9_3291=float2(0.0);
float2 l9_3292=(*sc_set2.UserUniforms).uv3Scale;
l9_3291=l9_3292;
float2 l9_3293=float2(0.0);
l9_3293=l9_3291;
float2 l9_3294=float2(0.0);
float2 l9_3295=(*sc_set2.UserUniforms).uv3Offset;
l9_3294=l9_3295;
float2 l9_3296=float2(0.0);
l9_3296=l9_3294;
float2 l9_3297=float2(0.0);
l9_3297=(l9_3229*l9_3293)+l9_3296;
l9_3156=l9_3297;
l9_3158=l9_3156;
}
l9_3154=l9_3158;
l9_3150=l9_3154;
l9_3153=l9_3150;
}
else
{
float2 l9_3298=float2(0.0);
l9_3298=l9_3152.Surface_UVCoord0;
l9_3151=l9_3298;
l9_3153=l9_3151;
}
l9_3149=l9_3153;
float2 l9_3299=float2(0.0);
l9_3299=l9_3149;
float2 l9_3300=float2(0.0);
l9_3300=l9_3299;
l9_3093=l9_3300;
l9_3096=l9_3093;
}
else
{
float2 l9_3301=float2(0.0);
l9_3301=l9_3095.Surface_UVCoord0;
l9_3094=l9_3301;
l9_3096=l9_3094;
}
}
}
}
l9_3089=l9_3096;
float4 l9_3302=float4(0.0);
int l9_3303=0;
if ((int(rimColorTexHasSwappedViews_tmp)!=0))
{
int l9_3304=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3304=0;
}
else
{
l9_3304=in.varStereoViewID;
}
int l9_3305=l9_3304;
l9_3303=1-l9_3305;
}
else
{
int l9_3306=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3306=0;
}
else
{
l9_3306=in.varStereoViewID;
}
int l9_3307=l9_3306;
l9_3303=l9_3307;
}
int l9_3308=l9_3303;
int l9_3309=rimColorTexLayout_tmp;
int l9_3310=l9_3308;
float2 l9_3311=l9_3089;
bool l9_3312=(int(SC_USE_UV_TRANSFORM_rimColorTex_tmp)!=0);
float3x3 l9_3313=(*sc_set2.UserUniforms).rimColorTexTransform;
int2 l9_3314=int2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex_tmp,SC_SOFTWARE_WRAP_MODE_V_rimColorTex_tmp);
bool l9_3315=(int(SC_USE_UV_MIN_MAX_rimColorTex_tmp)!=0);
float4 l9_3316=(*sc_set2.UserUniforms).rimColorTexUvMinMax;
bool l9_3317=(int(SC_USE_CLAMP_TO_BORDER_rimColorTex_tmp)!=0);
float4 l9_3318=(*sc_set2.UserUniforms).rimColorTexBorderColor;
float l9_3319=0.0;
bool l9_3320=l9_3317&&(!l9_3315);
float l9_3321=1.0;
float l9_3322=l9_3311.x;
int l9_3323=l9_3314.x;
if (l9_3323==1)
{
l9_3322=fract(l9_3322);
}
else
{
if (l9_3323==2)
{
float l9_3324=fract(l9_3322);
float l9_3325=l9_3322-l9_3324;
float l9_3326=step(0.25,fract(l9_3325*0.5));
l9_3322=mix(l9_3324,1.0-l9_3324,fast::clamp(l9_3326,0.0,1.0));
}
}
l9_3311.x=l9_3322;
float l9_3327=l9_3311.y;
int l9_3328=l9_3314.y;
if (l9_3328==1)
{
l9_3327=fract(l9_3327);
}
else
{
if (l9_3328==2)
{
float l9_3329=fract(l9_3327);
float l9_3330=l9_3327-l9_3329;
float l9_3331=step(0.25,fract(l9_3330*0.5));
l9_3327=mix(l9_3329,1.0-l9_3329,fast::clamp(l9_3331,0.0,1.0));
}
}
l9_3311.y=l9_3327;
if (l9_3315)
{
bool l9_3332=l9_3317;
bool l9_3333;
if (l9_3332)
{
l9_3333=l9_3314.x==3;
}
else
{
l9_3333=l9_3332;
}
float l9_3334=l9_3311.x;
float l9_3335=l9_3316.x;
float l9_3336=l9_3316.z;
bool l9_3337=l9_3333;
float l9_3338=l9_3321;
float l9_3339=fast::clamp(l9_3334,l9_3335,l9_3336);
float l9_3340=step(abs(l9_3334-l9_3339),9.9999997e-06);
l9_3338*=(l9_3340+((1.0-float(l9_3337))*(1.0-l9_3340)));
l9_3334=l9_3339;
l9_3311.x=l9_3334;
l9_3321=l9_3338;
bool l9_3341=l9_3317;
bool l9_3342;
if (l9_3341)
{
l9_3342=l9_3314.y==3;
}
else
{
l9_3342=l9_3341;
}
float l9_3343=l9_3311.y;
float l9_3344=l9_3316.y;
float l9_3345=l9_3316.w;
bool l9_3346=l9_3342;
float l9_3347=l9_3321;
float l9_3348=fast::clamp(l9_3343,l9_3344,l9_3345);
float l9_3349=step(abs(l9_3343-l9_3348),9.9999997e-06);
l9_3347*=(l9_3349+((1.0-float(l9_3346))*(1.0-l9_3349)));
l9_3343=l9_3348;
l9_3311.y=l9_3343;
l9_3321=l9_3347;
}
float2 l9_3350=l9_3311;
bool l9_3351=l9_3312;
float3x3 l9_3352=l9_3313;
if (l9_3351)
{
l9_3350=float2((l9_3352*float3(l9_3350,1.0)).xy);
}
float2 l9_3353=l9_3350;
float2 l9_3354=l9_3353;
float2 l9_3355=l9_3354;
l9_3311=l9_3355;
float l9_3356=l9_3311.x;
int l9_3357=l9_3314.x;
bool l9_3358=l9_3320;
float l9_3359=l9_3321;
if ((l9_3357==0)||(l9_3357==3))
{
float l9_3360=l9_3356;
float l9_3361=0.0;
float l9_3362=1.0;
bool l9_3363=l9_3358;
float l9_3364=l9_3359;
float l9_3365=fast::clamp(l9_3360,l9_3361,l9_3362);
float l9_3366=step(abs(l9_3360-l9_3365),9.9999997e-06);
l9_3364*=(l9_3366+((1.0-float(l9_3363))*(1.0-l9_3366)));
l9_3360=l9_3365;
l9_3356=l9_3360;
l9_3359=l9_3364;
}
l9_3311.x=l9_3356;
l9_3321=l9_3359;
float l9_3367=l9_3311.y;
int l9_3368=l9_3314.y;
bool l9_3369=l9_3320;
float l9_3370=l9_3321;
if ((l9_3368==0)||(l9_3368==3))
{
float l9_3371=l9_3367;
float l9_3372=0.0;
float l9_3373=1.0;
bool l9_3374=l9_3369;
float l9_3375=l9_3370;
float l9_3376=fast::clamp(l9_3371,l9_3372,l9_3373);
float l9_3377=step(abs(l9_3371-l9_3376),9.9999997e-06);
l9_3375*=(l9_3377+((1.0-float(l9_3374))*(1.0-l9_3377)));
l9_3371=l9_3376;
l9_3367=l9_3371;
l9_3370=l9_3375;
}
l9_3311.y=l9_3367;
l9_3321=l9_3370;
float2 l9_3378=l9_3311;
int l9_3379=l9_3309;
int l9_3380=l9_3310;
float l9_3381=l9_3319;
float2 l9_3382=l9_3378;
int l9_3383=l9_3379;
int l9_3384=l9_3380;
float3 l9_3385=float3(0.0);
if (l9_3383==0)
{
l9_3385=float3(l9_3382,0.0);
}
else
{
if (l9_3383==1)
{
l9_3385=float3(l9_3382.x,(l9_3382.y*0.5)+(0.5-(float(l9_3384)*0.5)),0.0);
}
else
{
l9_3385=float3(l9_3382,float(l9_3384));
}
}
float3 l9_3386=l9_3385;
float3 l9_3387=l9_3386;
float2 l9_3388=l9_3387.xy;
float l9_3389=l9_3381;
float4 l9_3390=sc_set2.rimColorTex.sample(sc_set2.rimColorTexSmpSC,l9_3388,bias(l9_3389));
float4 l9_3391=l9_3390;
float4 l9_3392=l9_3391;
if (l9_3317)
{
l9_3392=mix(l9_3318,l9_3392,float4(l9_3321));
}
float4 l9_3393=l9_3392;
l9_3302=l9_3393;
l9_3085=l9_3302.xyz;
l9_3088=l9_3085;
}
else
{
l9_3088=l9_3086;
}
l9_3084=l9_3088;
float3 l9_3394=float3(0.0);
l9_3394=(l9_3080*float3(l9_3083))*l9_3084;
float3 l9_3395=float3(0.0);
float3 l9_3396=l9_3394;
float3 l9_3397;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_3397=float3(pow(l9_3396.x,2.2),pow(l9_3396.y,2.2),pow(l9_3396.z,2.2));
}
else
{
l9_3397=l9_3396*l9_3396;
}
float3 l9_3398=l9_3397;
l9_3395=l9_3398;
float l9_3399=0.0;
float l9_3400=0.0;
float l9_3401=0.0;
ssGlobals l9_3402=param_15;
float l9_3403;
if ((int(ENABLE_RIM_INVERT_tmp)!=0))
{
float3 l9_3404=float3(0.0);
float3 l9_3405=float3(0.0);
float3 l9_3406=float3(0.0);
ssGlobals l9_3407=l9_3402;
float3 l9_3408;
if ((int(ENABLE_NORMALMAP_tmp)!=0))
{
float3 l9_3409=float3(0.0);
l9_3409=l9_3407.VertexTangent_WorldSpace;
float3 l9_3410=float3(0.0);
l9_3410=l9_3407.VertexBinormal_WorldSpace;
float3 l9_3411=float3(0.0);
l9_3411=l9_3407.VertexNormal_WorldSpace;
float3x3 l9_3412=float3x3(float3(0.0),float3(0.0),float3(0.0));
l9_3412=float3x3(float3(l9_3409),float3(l9_3410),float3(l9_3411));
float2 l9_3413=float2(0.0);
float2 l9_3414=float2(0.0);
float2 l9_3415=float2(0.0);
float2 l9_3416=float2(0.0);
float2 l9_3417=float2(0.0);
float2 l9_3418=float2(0.0);
ssGlobals l9_3419=l9_3407;
float2 l9_3420;
if (NODE_181_DROPLIST_ITEM_tmp==0)
{
float2 l9_3421=float2(0.0);
l9_3421=l9_3419.Surface_UVCoord0;
l9_3414=l9_3421;
l9_3420=l9_3414;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==1)
{
float2 l9_3422=float2(0.0);
l9_3422=l9_3419.Surface_UVCoord1;
l9_3415=l9_3422;
l9_3420=l9_3415;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==2)
{
float2 l9_3423=float2(0.0);
float2 l9_3424=float2(0.0);
float2 l9_3425=float2(0.0);
ssGlobals l9_3426=l9_3419;
float2 l9_3427;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3428=float2(0.0);
float2 l9_3429=float2(0.0);
float2 l9_3430=float2(0.0);
ssGlobals l9_3431=l9_3426;
float2 l9_3432;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3433=float2(0.0);
float2 l9_3434=float2(0.0);
float2 l9_3435=float2(0.0);
float2 l9_3436=float2(0.0);
float2 l9_3437=float2(0.0);
ssGlobals l9_3438=l9_3431;
float2 l9_3439;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3440=float2(0.0);
l9_3440=l9_3438.Surface_UVCoord0;
l9_3434=l9_3440;
l9_3439=l9_3434;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3441=float2(0.0);
l9_3441=l9_3438.Surface_UVCoord1;
l9_3435=l9_3441;
l9_3439=l9_3435;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3442=float2(0.0);
l9_3442=l9_3438.gScreenCoord;
l9_3436=l9_3442;
l9_3439=l9_3436;
}
else
{
float2 l9_3443=float2(0.0);
l9_3443=l9_3438.Surface_UVCoord0;
l9_3437=l9_3443;
l9_3439=l9_3437;
}
}
}
l9_3433=l9_3439;
float2 l9_3444=float2(0.0);
float2 l9_3445=(*sc_set2.UserUniforms).uv2Scale;
l9_3444=l9_3445;
float2 l9_3446=float2(0.0);
l9_3446=l9_3444;
float2 l9_3447=float2(0.0);
float2 l9_3448=(*sc_set2.UserUniforms).uv2Offset;
l9_3447=l9_3448;
float2 l9_3449=float2(0.0);
l9_3449=l9_3447;
float2 l9_3450=float2(0.0);
l9_3450=(l9_3433*l9_3446)+l9_3449;
float2 l9_3451=float2(0.0);
l9_3451=l9_3450+(l9_3449*(l9_3431.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3429=l9_3451;
l9_3432=l9_3429;
}
else
{
float2 l9_3452=float2(0.0);
float2 l9_3453=float2(0.0);
float2 l9_3454=float2(0.0);
float2 l9_3455=float2(0.0);
float2 l9_3456=float2(0.0);
ssGlobals l9_3457=l9_3431;
float2 l9_3458;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3459=float2(0.0);
l9_3459=l9_3457.Surface_UVCoord0;
l9_3453=l9_3459;
l9_3458=l9_3453;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3460=float2(0.0);
l9_3460=l9_3457.Surface_UVCoord1;
l9_3454=l9_3460;
l9_3458=l9_3454;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3461=float2(0.0);
l9_3461=l9_3457.gScreenCoord;
l9_3455=l9_3461;
l9_3458=l9_3455;
}
else
{
float2 l9_3462=float2(0.0);
l9_3462=l9_3457.Surface_UVCoord0;
l9_3456=l9_3462;
l9_3458=l9_3456;
}
}
}
l9_3452=l9_3458;
float2 l9_3463=float2(0.0);
float2 l9_3464=(*sc_set2.UserUniforms).uv2Scale;
l9_3463=l9_3464;
float2 l9_3465=float2(0.0);
l9_3465=l9_3463;
float2 l9_3466=float2(0.0);
float2 l9_3467=(*sc_set2.UserUniforms).uv2Offset;
l9_3466=l9_3467;
float2 l9_3468=float2(0.0);
l9_3468=l9_3466;
float2 l9_3469=float2(0.0);
l9_3469=(l9_3452*l9_3465)+l9_3468;
l9_3430=l9_3469;
l9_3432=l9_3430;
}
l9_3428=l9_3432;
l9_3424=l9_3428;
l9_3427=l9_3424;
}
else
{
float2 l9_3470=float2(0.0);
l9_3470=l9_3426.Surface_UVCoord0;
l9_3425=l9_3470;
l9_3427=l9_3425;
}
l9_3423=l9_3427;
float2 l9_3471=float2(0.0);
l9_3471=l9_3423;
float2 l9_3472=float2(0.0);
l9_3472=l9_3471;
l9_3416=l9_3472;
l9_3420=l9_3416;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==3)
{
float2 l9_3473=float2(0.0);
float2 l9_3474=float2(0.0);
float2 l9_3475=float2(0.0);
ssGlobals l9_3476=l9_3419;
float2 l9_3477;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_3478=float2(0.0);
float2 l9_3479=float2(0.0);
float2 l9_3480=float2(0.0);
ssGlobals l9_3481=l9_3476;
float2 l9_3482;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_3483=float2(0.0);
float2 l9_3484=float2(0.0);
float2 l9_3485=float2(0.0);
float2 l9_3486=float2(0.0);
float2 l9_3487=float2(0.0);
float2 l9_3488=float2(0.0);
ssGlobals l9_3489=l9_3481;
float2 l9_3490;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_3491=float2(0.0);
l9_3491=l9_3489.Surface_UVCoord0;
l9_3484=l9_3491;
l9_3490=l9_3484;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_3492=float2(0.0);
l9_3492=l9_3489.Surface_UVCoord1;
l9_3485=l9_3492;
l9_3490=l9_3485;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_3493=float2(0.0);
l9_3493=l9_3489.gScreenCoord;
l9_3486=l9_3493;
l9_3490=l9_3486;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_3494=float2(0.0);
float2 l9_3495=float2(0.0);
float2 l9_3496=float2(0.0);
ssGlobals l9_3497=l9_3489;
float2 l9_3498;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3499=float2(0.0);
float2 l9_3500=float2(0.0);
float2 l9_3501=float2(0.0);
ssGlobals l9_3502=l9_3497;
float2 l9_3503;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3504=float2(0.0);
float2 l9_3505=float2(0.0);
float2 l9_3506=float2(0.0);
float2 l9_3507=float2(0.0);
float2 l9_3508=float2(0.0);
ssGlobals l9_3509=l9_3502;
float2 l9_3510;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3511=float2(0.0);
l9_3511=l9_3509.Surface_UVCoord0;
l9_3505=l9_3511;
l9_3510=l9_3505;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3512=float2(0.0);
l9_3512=l9_3509.Surface_UVCoord1;
l9_3506=l9_3512;
l9_3510=l9_3506;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3513=float2(0.0);
l9_3513=l9_3509.gScreenCoord;
l9_3507=l9_3513;
l9_3510=l9_3507;
}
else
{
float2 l9_3514=float2(0.0);
l9_3514=l9_3509.Surface_UVCoord0;
l9_3508=l9_3514;
l9_3510=l9_3508;
}
}
}
l9_3504=l9_3510;
float2 l9_3515=float2(0.0);
float2 l9_3516=(*sc_set2.UserUniforms).uv2Scale;
l9_3515=l9_3516;
float2 l9_3517=float2(0.0);
l9_3517=l9_3515;
float2 l9_3518=float2(0.0);
float2 l9_3519=(*sc_set2.UserUniforms).uv2Offset;
l9_3518=l9_3519;
float2 l9_3520=float2(0.0);
l9_3520=l9_3518;
float2 l9_3521=float2(0.0);
l9_3521=(l9_3504*l9_3517)+l9_3520;
float2 l9_3522=float2(0.0);
l9_3522=l9_3521+(l9_3520*(l9_3502.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3500=l9_3522;
l9_3503=l9_3500;
}
else
{
float2 l9_3523=float2(0.0);
float2 l9_3524=float2(0.0);
float2 l9_3525=float2(0.0);
float2 l9_3526=float2(0.0);
float2 l9_3527=float2(0.0);
ssGlobals l9_3528=l9_3502;
float2 l9_3529;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3530=float2(0.0);
l9_3530=l9_3528.Surface_UVCoord0;
l9_3524=l9_3530;
l9_3529=l9_3524;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3531=float2(0.0);
l9_3531=l9_3528.Surface_UVCoord1;
l9_3525=l9_3531;
l9_3529=l9_3525;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3532=float2(0.0);
l9_3532=l9_3528.gScreenCoord;
l9_3526=l9_3532;
l9_3529=l9_3526;
}
else
{
float2 l9_3533=float2(0.0);
l9_3533=l9_3528.Surface_UVCoord0;
l9_3527=l9_3533;
l9_3529=l9_3527;
}
}
}
l9_3523=l9_3529;
float2 l9_3534=float2(0.0);
float2 l9_3535=(*sc_set2.UserUniforms).uv2Scale;
l9_3534=l9_3535;
float2 l9_3536=float2(0.0);
l9_3536=l9_3534;
float2 l9_3537=float2(0.0);
float2 l9_3538=(*sc_set2.UserUniforms).uv2Offset;
l9_3537=l9_3538;
float2 l9_3539=float2(0.0);
l9_3539=l9_3537;
float2 l9_3540=float2(0.0);
l9_3540=(l9_3523*l9_3536)+l9_3539;
l9_3501=l9_3540;
l9_3503=l9_3501;
}
l9_3499=l9_3503;
l9_3495=l9_3499;
l9_3498=l9_3495;
}
else
{
float2 l9_3541=float2(0.0);
l9_3541=l9_3497.Surface_UVCoord0;
l9_3496=l9_3541;
l9_3498=l9_3496;
}
l9_3494=l9_3498;
float2 l9_3542=float2(0.0);
l9_3542=l9_3494;
float2 l9_3543=float2(0.0);
l9_3543=l9_3542;
l9_3487=l9_3543;
l9_3490=l9_3487;
}
else
{
float2 l9_3544=float2(0.0);
l9_3544=l9_3489.Surface_UVCoord0;
l9_3488=l9_3544;
l9_3490=l9_3488;
}
}
}
}
l9_3483=l9_3490;
float2 l9_3545=float2(0.0);
float2 l9_3546=(*sc_set2.UserUniforms).uv3Scale;
l9_3545=l9_3546;
float2 l9_3547=float2(0.0);
l9_3547=l9_3545;
float2 l9_3548=float2(0.0);
float2 l9_3549=(*sc_set2.UserUniforms).uv3Offset;
l9_3548=l9_3549;
float2 l9_3550=float2(0.0);
l9_3550=l9_3548;
float2 l9_3551=float2(0.0);
l9_3551=(l9_3483*l9_3547)+l9_3550;
float2 l9_3552=float2(0.0);
l9_3552=l9_3551+(l9_3550*(l9_3481.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_3479=l9_3552;
l9_3482=l9_3479;
}
else
{
float2 l9_3553=float2(0.0);
float2 l9_3554=float2(0.0);
float2 l9_3555=float2(0.0);
float2 l9_3556=float2(0.0);
float2 l9_3557=float2(0.0);
float2 l9_3558=float2(0.0);
ssGlobals l9_3559=l9_3481;
float2 l9_3560;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_3561=float2(0.0);
l9_3561=l9_3559.Surface_UVCoord0;
l9_3554=l9_3561;
l9_3560=l9_3554;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_3562=float2(0.0);
l9_3562=l9_3559.Surface_UVCoord1;
l9_3555=l9_3562;
l9_3560=l9_3555;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_3563=float2(0.0);
l9_3563=l9_3559.gScreenCoord;
l9_3556=l9_3563;
l9_3560=l9_3556;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_3564=float2(0.0);
float2 l9_3565=float2(0.0);
float2 l9_3566=float2(0.0);
ssGlobals l9_3567=l9_3559;
float2 l9_3568;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3569=float2(0.0);
float2 l9_3570=float2(0.0);
float2 l9_3571=float2(0.0);
ssGlobals l9_3572=l9_3567;
float2 l9_3573;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3574=float2(0.0);
float2 l9_3575=float2(0.0);
float2 l9_3576=float2(0.0);
float2 l9_3577=float2(0.0);
float2 l9_3578=float2(0.0);
ssGlobals l9_3579=l9_3572;
float2 l9_3580;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3581=float2(0.0);
l9_3581=l9_3579.Surface_UVCoord0;
l9_3575=l9_3581;
l9_3580=l9_3575;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3582=float2(0.0);
l9_3582=l9_3579.Surface_UVCoord1;
l9_3576=l9_3582;
l9_3580=l9_3576;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3583=float2(0.0);
l9_3583=l9_3579.gScreenCoord;
l9_3577=l9_3583;
l9_3580=l9_3577;
}
else
{
float2 l9_3584=float2(0.0);
l9_3584=l9_3579.Surface_UVCoord0;
l9_3578=l9_3584;
l9_3580=l9_3578;
}
}
}
l9_3574=l9_3580;
float2 l9_3585=float2(0.0);
float2 l9_3586=(*sc_set2.UserUniforms).uv2Scale;
l9_3585=l9_3586;
float2 l9_3587=float2(0.0);
l9_3587=l9_3585;
float2 l9_3588=float2(0.0);
float2 l9_3589=(*sc_set2.UserUniforms).uv2Offset;
l9_3588=l9_3589;
float2 l9_3590=float2(0.0);
l9_3590=l9_3588;
float2 l9_3591=float2(0.0);
l9_3591=(l9_3574*l9_3587)+l9_3590;
float2 l9_3592=float2(0.0);
l9_3592=l9_3591+(l9_3590*(l9_3572.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3570=l9_3592;
l9_3573=l9_3570;
}
else
{
float2 l9_3593=float2(0.0);
float2 l9_3594=float2(0.0);
float2 l9_3595=float2(0.0);
float2 l9_3596=float2(0.0);
float2 l9_3597=float2(0.0);
ssGlobals l9_3598=l9_3572;
float2 l9_3599;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3600=float2(0.0);
l9_3600=l9_3598.Surface_UVCoord0;
l9_3594=l9_3600;
l9_3599=l9_3594;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3601=float2(0.0);
l9_3601=l9_3598.Surface_UVCoord1;
l9_3595=l9_3601;
l9_3599=l9_3595;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3602=float2(0.0);
l9_3602=l9_3598.gScreenCoord;
l9_3596=l9_3602;
l9_3599=l9_3596;
}
else
{
float2 l9_3603=float2(0.0);
l9_3603=l9_3598.Surface_UVCoord0;
l9_3597=l9_3603;
l9_3599=l9_3597;
}
}
}
l9_3593=l9_3599;
float2 l9_3604=float2(0.0);
float2 l9_3605=(*sc_set2.UserUniforms).uv2Scale;
l9_3604=l9_3605;
float2 l9_3606=float2(0.0);
l9_3606=l9_3604;
float2 l9_3607=float2(0.0);
float2 l9_3608=(*sc_set2.UserUniforms).uv2Offset;
l9_3607=l9_3608;
float2 l9_3609=float2(0.0);
l9_3609=l9_3607;
float2 l9_3610=float2(0.0);
l9_3610=(l9_3593*l9_3606)+l9_3609;
l9_3571=l9_3610;
l9_3573=l9_3571;
}
l9_3569=l9_3573;
l9_3565=l9_3569;
l9_3568=l9_3565;
}
else
{
float2 l9_3611=float2(0.0);
l9_3611=l9_3567.Surface_UVCoord0;
l9_3566=l9_3611;
l9_3568=l9_3566;
}
l9_3564=l9_3568;
float2 l9_3612=float2(0.0);
l9_3612=l9_3564;
float2 l9_3613=float2(0.0);
l9_3613=l9_3612;
l9_3557=l9_3613;
l9_3560=l9_3557;
}
else
{
float2 l9_3614=float2(0.0);
l9_3614=l9_3559.Surface_UVCoord0;
l9_3558=l9_3614;
l9_3560=l9_3558;
}
}
}
}
l9_3553=l9_3560;
float2 l9_3615=float2(0.0);
float2 l9_3616=(*sc_set2.UserUniforms).uv3Scale;
l9_3615=l9_3616;
float2 l9_3617=float2(0.0);
l9_3617=l9_3615;
float2 l9_3618=float2(0.0);
float2 l9_3619=(*sc_set2.UserUniforms).uv3Offset;
l9_3618=l9_3619;
float2 l9_3620=float2(0.0);
l9_3620=l9_3618;
float2 l9_3621=float2(0.0);
l9_3621=(l9_3553*l9_3617)+l9_3620;
l9_3480=l9_3621;
l9_3482=l9_3480;
}
l9_3478=l9_3482;
l9_3474=l9_3478;
l9_3477=l9_3474;
}
else
{
float2 l9_3622=float2(0.0);
l9_3622=l9_3476.Surface_UVCoord0;
l9_3475=l9_3622;
l9_3477=l9_3475;
}
l9_3473=l9_3477;
float2 l9_3623=float2(0.0);
l9_3623=l9_3473;
float2 l9_3624=float2(0.0);
l9_3624=l9_3623;
l9_3417=l9_3624;
l9_3420=l9_3417;
}
else
{
float2 l9_3625=float2(0.0);
l9_3625=l9_3419.Surface_UVCoord0;
l9_3418=l9_3625;
l9_3420=l9_3418;
}
}
}
}
l9_3413=l9_3420;
float4 l9_3626=float4(0.0);
float2 l9_3627=l9_3413;
int l9_3628=0;
if ((int(normalTexHasSwappedViews_tmp)!=0))
{
int l9_3629=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3629=0;
}
else
{
l9_3629=in.varStereoViewID;
}
int l9_3630=l9_3629;
l9_3628=1-l9_3630;
}
else
{
int l9_3631=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3631=0;
}
else
{
l9_3631=in.varStereoViewID;
}
int l9_3632=l9_3631;
l9_3628=l9_3632;
}
int l9_3633=l9_3628;
int l9_3634=normalTexLayout_tmp;
int l9_3635=l9_3633;
float2 l9_3636=l9_3627;
bool l9_3637=(int(SC_USE_UV_TRANSFORM_normalTex_tmp)!=0);
float3x3 l9_3638=(*sc_set2.UserUniforms).normalTexTransform;
int2 l9_3639=int2(SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp);
bool l9_3640=(int(SC_USE_UV_MIN_MAX_normalTex_tmp)!=0);
float4 l9_3641=(*sc_set2.UserUniforms).normalTexUvMinMax;
bool l9_3642=(int(SC_USE_CLAMP_TO_BORDER_normalTex_tmp)!=0);
float4 l9_3643=(*sc_set2.UserUniforms).normalTexBorderColor;
float l9_3644=0.0;
bool l9_3645=l9_3642&&(!l9_3640);
float l9_3646=1.0;
float l9_3647=l9_3636.x;
int l9_3648=l9_3639.x;
if (l9_3648==1)
{
l9_3647=fract(l9_3647);
}
else
{
if (l9_3648==2)
{
float l9_3649=fract(l9_3647);
float l9_3650=l9_3647-l9_3649;
float l9_3651=step(0.25,fract(l9_3650*0.5));
l9_3647=mix(l9_3649,1.0-l9_3649,fast::clamp(l9_3651,0.0,1.0));
}
}
l9_3636.x=l9_3647;
float l9_3652=l9_3636.y;
int l9_3653=l9_3639.y;
if (l9_3653==1)
{
l9_3652=fract(l9_3652);
}
else
{
if (l9_3653==2)
{
float l9_3654=fract(l9_3652);
float l9_3655=l9_3652-l9_3654;
float l9_3656=step(0.25,fract(l9_3655*0.5));
l9_3652=mix(l9_3654,1.0-l9_3654,fast::clamp(l9_3656,0.0,1.0));
}
}
l9_3636.y=l9_3652;
if (l9_3640)
{
bool l9_3657=l9_3642;
bool l9_3658;
if (l9_3657)
{
l9_3658=l9_3639.x==3;
}
else
{
l9_3658=l9_3657;
}
float l9_3659=l9_3636.x;
float l9_3660=l9_3641.x;
float l9_3661=l9_3641.z;
bool l9_3662=l9_3658;
float l9_3663=l9_3646;
float l9_3664=fast::clamp(l9_3659,l9_3660,l9_3661);
float l9_3665=step(abs(l9_3659-l9_3664),9.9999997e-06);
l9_3663*=(l9_3665+((1.0-float(l9_3662))*(1.0-l9_3665)));
l9_3659=l9_3664;
l9_3636.x=l9_3659;
l9_3646=l9_3663;
bool l9_3666=l9_3642;
bool l9_3667;
if (l9_3666)
{
l9_3667=l9_3639.y==3;
}
else
{
l9_3667=l9_3666;
}
float l9_3668=l9_3636.y;
float l9_3669=l9_3641.y;
float l9_3670=l9_3641.w;
bool l9_3671=l9_3667;
float l9_3672=l9_3646;
float l9_3673=fast::clamp(l9_3668,l9_3669,l9_3670);
float l9_3674=step(abs(l9_3668-l9_3673),9.9999997e-06);
l9_3672*=(l9_3674+((1.0-float(l9_3671))*(1.0-l9_3674)));
l9_3668=l9_3673;
l9_3636.y=l9_3668;
l9_3646=l9_3672;
}
float2 l9_3675=l9_3636;
bool l9_3676=l9_3637;
float3x3 l9_3677=l9_3638;
if (l9_3676)
{
l9_3675=float2((l9_3677*float3(l9_3675,1.0)).xy);
}
float2 l9_3678=l9_3675;
float2 l9_3679=l9_3678;
float2 l9_3680=l9_3679;
l9_3636=l9_3680;
float l9_3681=l9_3636.x;
int l9_3682=l9_3639.x;
bool l9_3683=l9_3645;
float l9_3684=l9_3646;
if ((l9_3682==0)||(l9_3682==3))
{
float l9_3685=l9_3681;
float l9_3686=0.0;
float l9_3687=1.0;
bool l9_3688=l9_3683;
float l9_3689=l9_3684;
float l9_3690=fast::clamp(l9_3685,l9_3686,l9_3687);
float l9_3691=step(abs(l9_3685-l9_3690),9.9999997e-06);
l9_3689*=(l9_3691+((1.0-float(l9_3688))*(1.0-l9_3691)));
l9_3685=l9_3690;
l9_3681=l9_3685;
l9_3684=l9_3689;
}
l9_3636.x=l9_3681;
l9_3646=l9_3684;
float l9_3692=l9_3636.y;
int l9_3693=l9_3639.y;
bool l9_3694=l9_3645;
float l9_3695=l9_3646;
if ((l9_3693==0)||(l9_3693==3))
{
float l9_3696=l9_3692;
float l9_3697=0.0;
float l9_3698=1.0;
bool l9_3699=l9_3694;
float l9_3700=l9_3695;
float l9_3701=fast::clamp(l9_3696,l9_3697,l9_3698);
float l9_3702=step(abs(l9_3696-l9_3701),9.9999997e-06);
l9_3700*=(l9_3702+((1.0-float(l9_3699))*(1.0-l9_3702)));
l9_3696=l9_3701;
l9_3692=l9_3696;
l9_3695=l9_3700;
}
l9_3636.y=l9_3692;
l9_3646=l9_3695;
float2 l9_3703=l9_3636;
int l9_3704=l9_3634;
int l9_3705=l9_3635;
float l9_3706=l9_3644;
float2 l9_3707=l9_3703;
int l9_3708=l9_3704;
int l9_3709=l9_3705;
float3 l9_3710=float3(0.0);
if (l9_3708==0)
{
l9_3710=float3(l9_3707,0.0);
}
else
{
if (l9_3708==1)
{
l9_3710=float3(l9_3707.x,(l9_3707.y*0.5)+(0.5-(float(l9_3709)*0.5)),0.0);
}
else
{
l9_3710=float3(l9_3707,float(l9_3709));
}
}
float3 l9_3711=l9_3710;
float3 l9_3712=l9_3711;
float2 l9_3713=l9_3712.xy;
float l9_3714=l9_3706;
float4 l9_3715=sc_set2.normalTex.sample(sc_set2.normalTexSmpSC,l9_3713,bias(l9_3714));
float4 l9_3716=l9_3715;
float4 l9_3717=l9_3716;
if (l9_3642)
{
l9_3717=mix(l9_3643,l9_3717,float4(l9_3646));
}
float4 l9_3718=l9_3717;
float4 l9_3719=l9_3718;
float3 l9_3720=(l9_3719.xyz*1.9921875)-float3(1.0);
l9_3719=float4(l9_3720.x,l9_3720.y,l9_3720.z,l9_3719.w);
l9_3626=l9_3719;
float3 l9_3721=float3(0.0);
float3 l9_3722=float3(0.0);
float3 l9_3723=(*sc_set2.UserUniforms).Port_Default_N113;
ssGlobals l9_3724=l9_3407;
float3 l9_3725;
if ((int(ENABLE_DETAIL_NORMAL_tmp)!=0))
{
float2 l9_3726=float2(0.0);
float2 l9_3727=float2(0.0);
float2 l9_3728=float2(0.0);
float2 l9_3729=float2(0.0);
float2 l9_3730=float2(0.0);
float2 l9_3731=float2(0.0);
ssGlobals l9_3732=l9_3724;
float2 l9_3733;
if (NODE_184_DROPLIST_ITEM_tmp==0)
{
float2 l9_3734=float2(0.0);
l9_3734=l9_3732.Surface_UVCoord0;
l9_3727=l9_3734;
l9_3733=l9_3727;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==1)
{
float2 l9_3735=float2(0.0);
l9_3735=l9_3732.Surface_UVCoord1;
l9_3728=l9_3735;
l9_3733=l9_3728;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==2)
{
float2 l9_3736=float2(0.0);
float2 l9_3737=float2(0.0);
float2 l9_3738=float2(0.0);
ssGlobals l9_3739=l9_3732;
float2 l9_3740;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3741=float2(0.0);
float2 l9_3742=float2(0.0);
float2 l9_3743=float2(0.0);
ssGlobals l9_3744=l9_3739;
float2 l9_3745;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3746=float2(0.0);
float2 l9_3747=float2(0.0);
float2 l9_3748=float2(0.0);
float2 l9_3749=float2(0.0);
float2 l9_3750=float2(0.0);
ssGlobals l9_3751=l9_3744;
float2 l9_3752;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3753=float2(0.0);
l9_3753=l9_3751.Surface_UVCoord0;
l9_3747=l9_3753;
l9_3752=l9_3747;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3754=float2(0.0);
l9_3754=l9_3751.Surface_UVCoord1;
l9_3748=l9_3754;
l9_3752=l9_3748;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3755=float2(0.0);
l9_3755=l9_3751.gScreenCoord;
l9_3749=l9_3755;
l9_3752=l9_3749;
}
else
{
float2 l9_3756=float2(0.0);
l9_3756=l9_3751.Surface_UVCoord0;
l9_3750=l9_3756;
l9_3752=l9_3750;
}
}
}
l9_3746=l9_3752;
float2 l9_3757=float2(0.0);
float2 l9_3758=(*sc_set2.UserUniforms).uv2Scale;
l9_3757=l9_3758;
float2 l9_3759=float2(0.0);
l9_3759=l9_3757;
float2 l9_3760=float2(0.0);
float2 l9_3761=(*sc_set2.UserUniforms).uv2Offset;
l9_3760=l9_3761;
float2 l9_3762=float2(0.0);
l9_3762=l9_3760;
float2 l9_3763=float2(0.0);
l9_3763=(l9_3746*l9_3759)+l9_3762;
float2 l9_3764=float2(0.0);
l9_3764=l9_3763+(l9_3762*(l9_3744.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3742=l9_3764;
l9_3745=l9_3742;
}
else
{
float2 l9_3765=float2(0.0);
float2 l9_3766=float2(0.0);
float2 l9_3767=float2(0.0);
float2 l9_3768=float2(0.0);
float2 l9_3769=float2(0.0);
ssGlobals l9_3770=l9_3744;
float2 l9_3771;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3772=float2(0.0);
l9_3772=l9_3770.Surface_UVCoord0;
l9_3766=l9_3772;
l9_3771=l9_3766;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3773=float2(0.0);
l9_3773=l9_3770.Surface_UVCoord1;
l9_3767=l9_3773;
l9_3771=l9_3767;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3774=float2(0.0);
l9_3774=l9_3770.gScreenCoord;
l9_3768=l9_3774;
l9_3771=l9_3768;
}
else
{
float2 l9_3775=float2(0.0);
l9_3775=l9_3770.Surface_UVCoord0;
l9_3769=l9_3775;
l9_3771=l9_3769;
}
}
}
l9_3765=l9_3771;
float2 l9_3776=float2(0.0);
float2 l9_3777=(*sc_set2.UserUniforms).uv2Scale;
l9_3776=l9_3777;
float2 l9_3778=float2(0.0);
l9_3778=l9_3776;
float2 l9_3779=float2(0.0);
float2 l9_3780=(*sc_set2.UserUniforms).uv2Offset;
l9_3779=l9_3780;
float2 l9_3781=float2(0.0);
l9_3781=l9_3779;
float2 l9_3782=float2(0.0);
l9_3782=(l9_3765*l9_3778)+l9_3781;
l9_3743=l9_3782;
l9_3745=l9_3743;
}
l9_3741=l9_3745;
l9_3737=l9_3741;
l9_3740=l9_3737;
}
else
{
float2 l9_3783=float2(0.0);
l9_3783=l9_3739.Surface_UVCoord0;
l9_3738=l9_3783;
l9_3740=l9_3738;
}
l9_3736=l9_3740;
float2 l9_3784=float2(0.0);
l9_3784=l9_3736;
float2 l9_3785=float2(0.0);
l9_3785=l9_3784;
l9_3729=l9_3785;
l9_3733=l9_3729;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==3)
{
float2 l9_3786=float2(0.0);
float2 l9_3787=float2(0.0);
float2 l9_3788=float2(0.0);
ssGlobals l9_3789=l9_3732;
float2 l9_3790;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_3791=float2(0.0);
float2 l9_3792=float2(0.0);
float2 l9_3793=float2(0.0);
ssGlobals l9_3794=l9_3789;
float2 l9_3795;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_3796=float2(0.0);
float2 l9_3797=float2(0.0);
float2 l9_3798=float2(0.0);
float2 l9_3799=float2(0.0);
float2 l9_3800=float2(0.0);
float2 l9_3801=float2(0.0);
ssGlobals l9_3802=l9_3794;
float2 l9_3803;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_3804=float2(0.0);
l9_3804=l9_3802.Surface_UVCoord0;
l9_3797=l9_3804;
l9_3803=l9_3797;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_3805=float2(0.0);
l9_3805=l9_3802.Surface_UVCoord1;
l9_3798=l9_3805;
l9_3803=l9_3798;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_3806=float2(0.0);
l9_3806=l9_3802.gScreenCoord;
l9_3799=l9_3806;
l9_3803=l9_3799;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_3807=float2(0.0);
float2 l9_3808=float2(0.0);
float2 l9_3809=float2(0.0);
ssGlobals l9_3810=l9_3802;
float2 l9_3811;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3812=float2(0.0);
float2 l9_3813=float2(0.0);
float2 l9_3814=float2(0.0);
ssGlobals l9_3815=l9_3810;
float2 l9_3816;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3817=float2(0.0);
float2 l9_3818=float2(0.0);
float2 l9_3819=float2(0.0);
float2 l9_3820=float2(0.0);
float2 l9_3821=float2(0.0);
ssGlobals l9_3822=l9_3815;
float2 l9_3823;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3824=float2(0.0);
l9_3824=l9_3822.Surface_UVCoord0;
l9_3818=l9_3824;
l9_3823=l9_3818;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3825=float2(0.0);
l9_3825=l9_3822.Surface_UVCoord1;
l9_3819=l9_3825;
l9_3823=l9_3819;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3826=float2(0.0);
l9_3826=l9_3822.gScreenCoord;
l9_3820=l9_3826;
l9_3823=l9_3820;
}
else
{
float2 l9_3827=float2(0.0);
l9_3827=l9_3822.Surface_UVCoord0;
l9_3821=l9_3827;
l9_3823=l9_3821;
}
}
}
l9_3817=l9_3823;
float2 l9_3828=float2(0.0);
float2 l9_3829=(*sc_set2.UserUniforms).uv2Scale;
l9_3828=l9_3829;
float2 l9_3830=float2(0.0);
l9_3830=l9_3828;
float2 l9_3831=float2(0.0);
float2 l9_3832=(*sc_set2.UserUniforms).uv2Offset;
l9_3831=l9_3832;
float2 l9_3833=float2(0.0);
l9_3833=l9_3831;
float2 l9_3834=float2(0.0);
l9_3834=(l9_3817*l9_3830)+l9_3833;
float2 l9_3835=float2(0.0);
l9_3835=l9_3834+(l9_3833*(l9_3815.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3813=l9_3835;
l9_3816=l9_3813;
}
else
{
float2 l9_3836=float2(0.0);
float2 l9_3837=float2(0.0);
float2 l9_3838=float2(0.0);
float2 l9_3839=float2(0.0);
float2 l9_3840=float2(0.0);
ssGlobals l9_3841=l9_3815;
float2 l9_3842;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3843=float2(0.0);
l9_3843=l9_3841.Surface_UVCoord0;
l9_3837=l9_3843;
l9_3842=l9_3837;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3844=float2(0.0);
l9_3844=l9_3841.Surface_UVCoord1;
l9_3838=l9_3844;
l9_3842=l9_3838;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3845=float2(0.0);
l9_3845=l9_3841.gScreenCoord;
l9_3839=l9_3845;
l9_3842=l9_3839;
}
else
{
float2 l9_3846=float2(0.0);
l9_3846=l9_3841.Surface_UVCoord0;
l9_3840=l9_3846;
l9_3842=l9_3840;
}
}
}
l9_3836=l9_3842;
float2 l9_3847=float2(0.0);
float2 l9_3848=(*sc_set2.UserUniforms).uv2Scale;
l9_3847=l9_3848;
float2 l9_3849=float2(0.0);
l9_3849=l9_3847;
float2 l9_3850=float2(0.0);
float2 l9_3851=(*sc_set2.UserUniforms).uv2Offset;
l9_3850=l9_3851;
float2 l9_3852=float2(0.0);
l9_3852=l9_3850;
float2 l9_3853=float2(0.0);
l9_3853=(l9_3836*l9_3849)+l9_3852;
l9_3814=l9_3853;
l9_3816=l9_3814;
}
l9_3812=l9_3816;
l9_3808=l9_3812;
l9_3811=l9_3808;
}
else
{
float2 l9_3854=float2(0.0);
l9_3854=l9_3810.Surface_UVCoord0;
l9_3809=l9_3854;
l9_3811=l9_3809;
}
l9_3807=l9_3811;
float2 l9_3855=float2(0.0);
l9_3855=l9_3807;
float2 l9_3856=float2(0.0);
l9_3856=l9_3855;
l9_3800=l9_3856;
l9_3803=l9_3800;
}
else
{
float2 l9_3857=float2(0.0);
l9_3857=l9_3802.Surface_UVCoord0;
l9_3801=l9_3857;
l9_3803=l9_3801;
}
}
}
}
l9_3796=l9_3803;
float2 l9_3858=float2(0.0);
float2 l9_3859=(*sc_set2.UserUniforms).uv3Scale;
l9_3858=l9_3859;
float2 l9_3860=float2(0.0);
l9_3860=l9_3858;
float2 l9_3861=float2(0.0);
float2 l9_3862=(*sc_set2.UserUniforms).uv3Offset;
l9_3861=l9_3862;
float2 l9_3863=float2(0.0);
l9_3863=l9_3861;
float2 l9_3864=float2(0.0);
l9_3864=(l9_3796*l9_3860)+l9_3863;
float2 l9_3865=float2(0.0);
l9_3865=l9_3864+(l9_3863*(l9_3794.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_3792=l9_3865;
l9_3795=l9_3792;
}
else
{
float2 l9_3866=float2(0.0);
float2 l9_3867=float2(0.0);
float2 l9_3868=float2(0.0);
float2 l9_3869=float2(0.0);
float2 l9_3870=float2(0.0);
float2 l9_3871=float2(0.0);
ssGlobals l9_3872=l9_3794;
float2 l9_3873;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_3874=float2(0.0);
l9_3874=l9_3872.Surface_UVCoord0;
l9_3867=l9_3874;
l9_3873=l9_3867;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_3875=float2(0.0);
l9_3875=l9_3872.Surface_UVCoord1;
l9_3868=l9_3875;
l9_3873=l9_3868;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_3876=float2(0.0);
l9_3876=l9_3872.gScreenCoord;
l9_3869=l9_3876;
l9_3873=l9_3869;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_3877=float2(0.0);
float2 l9_3878=float2(0.0);
float2 l9_3879=float2(0.0);
ssGlobals l9_3880=l9_3872;
float2 l9_3881;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_3882=float2(0.0);
float2 l9_3883=float2(0.0);
float2 l9_3884=float2(0.0);
ssGlobals l9_3885=l9_3880;
float2 l9_3886;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_3887=float2(0.0);
float2 l9_3888=float2(0.0);
float2 l9_3889=float2(0.0);
float2 l9_3890=float2(0.0);
float2 l9_3891=float2(0.0);
ssGlobals l9_3892=l9_3885;
float2 l9_3893;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3894=float2(0.0);
l9_3894=l9_3892.Surface_UVCoord0;
l9_3888=l9_3894;
l9_3893=l9_3888;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3895=float2(0.0);
l9_3895=l9_3892.Surface_UVCoord1;
l9_3889=l9_3895;
l9_3893=l9_3889;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3896=float2(0.0);
l9_3896=l9_3892.gScreenCoord;
l9_3890=l9_3896;
l9_3893=l9_3890;
}
else
{
float2 l9_3897=float2(0.0);
l9_3897=l9_3892.Surface_UVCoord0;
l9_3891=l9_3897;
l9_3893=l9_3891;
}
}
}
l9_3887=l9_3893;
float2 l9_3898=float2(0.0);
float2 l9_3899=(*sc_set2.UserUniforms).uv2Scale;
l9_3898=l9_3899;
float2 l9_3900=float2(0.0);
l9_3900=l9_3898;
float2 l9_3901=float2(0.0);
float2 l9_3902=(*sc_set2.UserUniforms).uv2Offset;
l9_3901=l9_3902;
float2 l9_3903=float2(0.0);
l9_3903=l9_3901;
float2 l9_3904=float2(0.0);
l9_3904=(l9_3887*l9_3900)+l9_3903;
float2 l9_3905=float2(0.0);
l9_3905=l9_3904+(l9_3903*(l9_3885.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_3883=l9_3905;
l9_3886=l9_3883;
}
else
{
float2 l9_3906=float2(0.0);
float2 l9_3907=float2(0.0);
float2 l9_3908=float2(0.0);
float2 l9_3909=float2(0.0);
float2 l9_3910=float2(0.0);
ssGlobals l9_3911=l9_3885;
float2 l9_3912;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_3913=float2(0.0);
l9_3913=l9_3911.Surface_UVCoord0;
l9_3907=l9_3913;
l9_3912=l9_3907;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_3914=float2(0.0);
l9_3914=l9_3911.Surface_UVCoord1;
l9_3908=l9_3914;
l9_3912=l9_3908;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_3915=float2(0.0);
l9_3915=l9_3911.gScreenCoord;
l9_3909=l9_3915;
l9_3912=l9_3909;
}
else
{
float2 l9_3916=float2(0.0);
l9_3916=l9_3911.Surface_UVCoord0;
l9_3910=l9_3916;
l9_3912=l9_3910;
}
}
}
l9_3906=l9_3912;
float2 l9_3917=float2(0.0);
float2 l9_3918=(*sc_set2.UserUniforms).uv2Scale;
l9_3917=l9_3918;
float2 l9_3919=float2(0.0);
l9_3919=l9_3917;
float2 l9_3920=float2(0.0);
float2 l9_3921=(*sc_set2.UserUniforms).uv2Offset;
l9_3920=l9_3921;
float2 l9_3922=float2(0.0);
l9_3922=l9_3920;
float2 l9_3923=float2(0.0);
l9_3923=(l9_3906*l9_3919)+l9_3922;
l9_3884=l9_3923;
l9_3886=l9_3884;
}
l9_3882=l9_3886;
l9_3878=l9_3882;
l9_3881=l9_3878;
}
else
{
float2 l9_3924=float2(0.0);
l9_3924=l9_3880.Surface_UVCoord0;
l9_3879=l9_3924;
l9_3881=l9_3879;
}
l9_3877=l9_3881;
float2 l9_3925=float2(0.0);
l9_3925=l9_3877;
float2 l9_3926=float2(0.0);
l9_3926=l9_3925;
l9_3870=l9_3926;
l9_3873=l9_3870;
}
else
{
float2 l9_3927=float2(0.0);
l9_3927=l9_3872.Surface_UVCoord0;
l9_3871=l9_3927;
l9_3873=l9_3871;
}
}
}
}
l9_3866=l9_3873;
float2 l9_3928=float2(0.0);
float2 l9_3929=(*sc_set2.UserUniforms).uv3Scale;
l9_3928=l9_3929;
float2 l9_3930=float2(0.0);
l9_3930=l9_3928;
float2 l9_3931=float2(0.0);
float2 l9_3932=(*sc_set2.UserUniforms).uv3Offset;
l9_3931=l9_3932;
float2 l9_3933=float2(0.0);
l9_3933=l9_3931;
float2 l9_3934=float2(0.0);
l9_3934=(l9_3866*l9_3930)+l9_3933;
l9_3793=l9_3934;
l9_3795=l9_3793;
}
l9_3791=l9_3795;
l9_3787=l9_3791;
l9_3790=l9_3787;
}
else
{
float2 l9_3935=float2(0.0);
l9_3935=l9_3789.Surface_UVCoord0;
l9_3788=l9_3935;
l9_3790=l9_3788;
}
l9_3786=l9_3790;
float2 l9_3936=float2(0.0);
l9_3936=l9_3786;
float2 l9_3937=float2(0.0);
l9_3937=l9_3936;
l9_3730=l9_3937;
l9_3733=l9_3730;
}
else
{
float2 l9_3938=float2(0.0);
l9_3938=l9_3732.Surface_UVCoord0;
l9_3731=l9_3938;
l9_3733=l9_3731;
}
}
}
}
l9_3726=l9_3733;
float4 l9_3939=float4(0.0);
float2 l9_3940=l9_3726;
int l9_3941=0;
if ((int(detailNormalTexHasSwappedViews_tmp)!=0))
{
int l9_3942=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3942=0;
}
else
{
l9_3942=in.varStereoViewID;
}
int l9_3943=l9_3942;
l9_3941=1-l9_3943;
}
else
{
int l9_3944=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3944=0;
}
else
{
l9_3944=in.varStereoViewID;
}
int l9_3945=l9_3944;
l9_3941=l9_3945;
}
int l9_3946=l9_3941;
int l9_3947=detailNormalTexLayout_tmp;
int l9_3948=l9_3946;
float2 l9_3949=l9_3940;
bool l9_3950=(int(SC_USE_UV_TRANSFORM_detailNormalTex_tmp)!=0);
float3x3 l9_3951=(*sc_set2.UserUniforms).detailNormalTexTransform;
int2 l9_3952=int2(SC_SOFTWARE_WRAP_MODE_U_detailNormalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_detailNormalTex_tmp);
bool l9_3953=(int(SC_USE_UV_MIN_MAX_detailNormalTex_tmp)!=0);
float4 l9_3954=(*sc_set2.UserUniforms).detailNormalTexUvMinMax;
bool l9_3955=(int(SC_USE_CLAMP_TO_BORDER_detailNormalTex_tmp)!=0);
float4 l9_3956=(*sc_set2.UserUniforms).detailNormalTexBorderColor;
float l9_3957=0.0;
bool l9_3958=l9_3955&&(!l9_3953);
float l9_3959=1.0;
float l9_3960=l9_3949.x;
int l9_3961=l9_3952.x;
if (l9_3961==1)
{
l9_3960=fract(l9_3960);
}
else
{
if (l9_3961==2)
{
float l9_3962=fract(l9_3960);
float l9_3963=l9_3960-l9_3962;
float l9_3964=step(0.25,fract(l9_3963*0.5));
l9_3960=mix(l9_3962,1.0-l9_3962,fast::clamp(l9_3964,0.0,1.0));
}
}
l9_3949.x=l9_3960;
float l9_3965=l9_3949.y;
int l9_3966=l9_3952.y;
if (l9_3966==1)
{
l9_3965=fract(l9_3965);
}
else
{
if (l9_3966==2)
{
float l9_3967=fract(l9_3965);
float l9_3968=l9_3965-l9_3967;
float l9_3969=step(0.25,fract(l9_3968*0.5));
l9_3965=mix(l9_3967,1.0-l9_3967,fast::clamp(l9_3969,0.0,1.0));
}
}
l9_3949.y=l9_3965;
if (l9_3953)
{
bool l9_3970=l9_3955;
bool l9_3971;
if (l9_3970)
{
l9_3971=l9_3952.x==3;
}
else
{
l9_3971=l9_3970;
}
float l9_3972=l9_3949.x;
float l9_3973=l9_3954.x;
float l9_3974=l9_3954.z;
bool l9_3975=l9_3971;
float l9_3976=l9_3959;
float l9_3977=fast::clamp(l9_3972,l9_3973,l9_3974);
float l9_3978=step(abs(l9_3972-l9_3977),9.9999997e-06);
l9_3976*=(l9_3978+((1.0-float(l9_3975))*(1.0-l9_3978)));
l9_3972=l9_3977;
l9_3949.x=l9_3972;
l9_3959=l9_3976;
bool l9_3979=l9_3955;
bool l9_3980;
if (l9_3979)
{
l9_3980=l9_3952.y==3;
}
else
{
l9_3980=l9_3979;
}
float l9_3981=l9_3949.y;
float l9_3982=l9_3954.y;
float l9_3983=l9_3954.w;
bool l9_3984=l9_3980;
float l9_3985=l9_3959;
float l9_3986=fast::clamp(l9_3981,l9_3982,l9_3983);
float l9_3987=step(abs(l9_3981-l9_3986),9.9999997e-06);
l9_3985*=(l9_3987+((1.0-float(l9_3984))*(1.0-l9_3987)));
l9_3981=l9_3986;
l9_3949.y=l9_3981;
l9_3959=l9_3985;
}
float2 l9_3988=l9_3949;
bool l9_3989=l9_3950;
float3x3 l9_3990=l9_3951;
if (l9_3989)
{
l9_3988=float2((l9_3990*float3(l9_3988,1.0)).xy);
}
float2 l9_3991=l9_3988;
float2 l9_3992=l9_3991;
float2 l9_3993=l9_3992;
l9_3949=l9_3993;
float l9_3994=l9_3949.x;
int l9_3995=l9_3952.x;
bool l9_3996=l9_3958;
float l9_3997=l9_3959;
if ((l9_3995==0)||(l9_3995==3))
{
float l9_3998=l9_3994;
float l9_3999=0.0;
float l9_4000=1.0;
bool l9_4001=l9_3996;
float l9_4002=l9_3997;
float l9_4003=fast::clamp(l9_3998,l9_3999,l9_4000);
float l9_4004=step(abs(l9_3998-l9_4003),9.9999997e-06);
l9_4002*=(l9_4004+((1.0-float(l9_4001))*(1.0-l9_4004)));
l9_3998=l9_4003;
l9_3994=l9_3998;
l9_3997=l9_4002;
}
l9_3949.x=l9_3994;
l9_3959=l9_3997;
float l9_4005=l9_3949.y;
int l9_4006=l9_3952.y;
bool l9_4007=l9_3958;
float l9_4008=l9_3959;
if ((l9_4006==0)||(l9_4006==3))
{
float l9_4009=l9_4005;
float l9_4010=0.0;
float l9_4011=1.0;
bool l9_4012=l9_4007;
float l9_4013=l9_4008;
float l9_4014=fast::clamp(l9_4009,l9_4010,l9_4011);
float l9_4015=step(abs(l9_4009-l9_4014),9.9999997e-06);
l9_4013*=(l9_4015+((1.0-float(l9_4012))*(1.0-l9_4015)));
l9_4009=l9_4014;
l9_4005=l9_4009;
l9_4008=l9_4013;
}
l9_3949.y=l9_4005;
l9_3959=l9_4008;
float2 l9_4016=l9_3949;
int l9_4017=l9_3947;
int l9_4018=l9_3948;
float l9_4019=l9_3957;
float2 l9_4020=l9_4016;
int l9_4021=l9_4017;
int l9_4022=l9_4018;
float3 l9_4023=float3(0.0);
if (l9_4021==0)
{
l9_4023=float3(l9_4020,0.0);
}
else
{
if (l9_4021==1)
{
l9_4023=float3(l9_4020.x,(l9_4020.y*0.5)+(0.5-(float(l9_4022)*0.5)),0.0);
}
else
{
l9_4023=float3(l9_4020,float(l9_4022));
}
}
float3 l9_4024=l9_4023;
float3 l9_4025=l9_4024;
float2 l9_4026=l9_4025.xy;
float l9_4027=l9_4019;
float4 l9_4028=sc_set2.detailNormalTex.sample(sc_set2.detailNormalTexSmpSC,l9_4026,bias(l9_4027));
float4 l9_4029=l9_4028;
float4 l9_4030=l9_4029;
if (l9_3955)
{
l9_4030=mix(l9_3956,l9_4030,float4(l9_3959));
}
float4 l9_4031=l9_4030;
float4 l9_4032=l9_4031;
float3 l9_4033=(l9_4032.xyz*1.9921875)-float3(1.0);
l9_4032=float4(l9_4033.x,l9_4033.y,l9_4033.z,l9_4032.w);
l9_3939=l9_4032;
l9_3722=l9_3939.xyz;
l9_3725=l9_3722;
}
else
{
l9_3725=l9_3723;
}
l9_3721=l9_3725;
float3 l9_4034=float3(0.0);
float3 l9_4035=l9_3626.xyz;
float l9_4036=(*sc_set2.UserUniforms).Port_Strength1_N200;
float3 l9_4037=l9_3721;
float l9_4038=(*sc_set2.UserUniforms).Port_Strength2_N200;
float3 l9_4039=l9_4035;
float l9_4040=l9_4036;
float3 l9_4041=l9_4037;
float l9_4042=l9_4038;
float3 l9_4043=mix(float3(0.0,0.0,1.0),l9_4039,float3(l9_4040))+float3(0.0,0.0,1.0);
float3 l9_4044=mix(float3(0.0,0.0,1.0),l9_4041,float3(l9_4042))*float3(-1.0,-1.0,1.0);
float3 l9_4045=normalize((l9_4043*dot(l9_4043,l9_4044))-(l9_4044*l9_4043.z));
l9_4037=l9_4045;
float3 l9_4046=l9_4037;
l9_4034=l9_4046;
float3 l9_4047=float3(0.0);
l9_4047=l9_3412*l9_4034;
float3 l9_4048=float3(0.0);
float3 l9_4049=l9_4047;
float l9_4050=dot(l9_4049,l9_4049);
float l9_4051;
if (l9_4050>0.0)
{
l9_4051=1.0/sqrt(l9_4050);
}
else
{
l9_4051=0.0;
}
float l9_4052=l9_4051;
float3 l9_4053=l9_4049*l9_4052;
l9_4048=l9_4053;
l9_3405=l9_4048;
l9_3408=l9_3405;
}
else
{
float3 l9_4054=float3(0.0);
l9_4054=l9_3407.VertexNormal_WorldSpace;
float3 l9_4055=float3(0.0);
float3 l9_4056=l9_4054;
float l9_4057=dot(l9_4056,l9_4056);
float l9_4058;
if (l9_4057>0.0)
{
l9_4058=1.0/sqrt(l9_4057);
}
else
{
l9_4058=0.0;
}
float l9_4059=l9_4058;
float3 l9_4060=l9_4056*l9_4059;
l9_4055=l9_4060;
l9_3406=l9_4055;
l9_3408=l9_3406;
}
l9_3404=l9_3408;
float3 l9_4061=float3(0.0);
l9_4061=l9_3404;
float3 l9_4062=float3(0.0);
l9_4062=l9_4061;
float3 l9_4063=float3(0.0);
l9_4063=-l9_3402.ViewDirWS;
float l9_4064=0.0;
l9_4064=dot(l9_4062,l9_4063);
float l9_4065=0.0;
l9_4065=abs(l9_4064);
l9_3400=l9_4065;
l9_3403=l9_3400;
}
else
{
float3 l9_4066=float3(0.0);
float3 l9_4067=float3(0.0);
float3 l9_4068=float3(0.0);
ssGlobals l9_4069=l9_3402;
float3 l9_4070;
if ((int(ENABLE_NORMALMAP_tmp)!=0))
{
float3 l9_4071=float3(0.0);
l9_4071=l9_4069.VertexTangent_WorldSpace;
float3 l9_4072=float3(0.0);
l9_4072=l9_4069.VertexBinormal_WorldSpace;
float3 l9_4073=float3(0.0);
l9_4073=l9_4069.VertexNormal_WorldSpace;
float3x3 l9_4074=float3x3(float3(0.0),float3(0.0),float3(0.0));
l9_4074=float3x3(float3(l9_4071),float3(l9_4072),float3(l9_4073));
float2 l9_4075=float2(0.0);
float2 l9_4076=float2(0.0);
float2 l9_4077=float2(0.0);
float2 l9_4078=float2(0.0);
float2 l9_4079=float2(0.0);
float2 l9_4080=float2(0.0);
ssGlobals l9_4081=l9_4069;
float2 l9_4082;
if (NODE_181_DROPLIST_ITEM_tmp==0)
{
float2 l9_4083=float2(0.0);
l9_4083=l9_4081.Surface_UVCoord0;
l9_4076=l9_4083;
l9_4082=l9_4076;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==1)
{
float2 l9_4084=float2(0.0);
l9_4084=l9_4081.Surface_UVCoord1;
l9_4077=l9_4084;
l9_4082=l9_4077;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==2)
{
float2 l9_4085=float2(0.0);
float2 l9_4086=float2(0.0);
float2 l9_4087=float2(0.0);
ssGlobals l9_4088=l9_4081;
float2 l9_4089;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4090=float2(0.0);
float2 l9_4091=float2(0.0);
float2 l9_4092=float2(0.0);
ssGlobals l9_4093=l9_4088;
float2 l9_4094;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4095=float2(0.0);
float2 l9_4096=float2(0.0);
float2 l9_4097=float2(0.0);
float2 l9_4098=float2(0.0);
float2 l9_4099=float2(0.0);
ssGlobals l9_4100=l9_4093;
float2 l9_4101;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4102=float2(0.0);
l9_4102=l9_4100.Surface_UVCoord0;
l9_4096=l9_4102;
l9_4101=l9_4096;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4103=float2(0.0);
l9_4103=l9_4100.Surface_UVCoord1;
l9_4097=l9_4103;
l9_4101=l9_4097;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4104=float2(0.0);
l9_4104=l9_4100.gScreenCoord;
l9_4098=l9_4104;
l9_4101=l9_4098;
}
else
{
float2 l9_4105=float2(0.0);
l9_4105=l9_4100.Surface_UVCoord0;
l9_4099=l9_4105;
l9_4101=l9_4099;
}
}
}
l9_4095=l9_4101;
float2 l9_4106=float2(0.0);
float2 l9_4107=(*sc_set2.UserUniforms).uv2Scale;
l9_4106=l9_4107;
float2 l9_4108=float2(0.0);
l9_4108=l9_4106;
float2 l9_4109=float2(0.0);
float2 l9_4110=(*sc_set2.UserUniforms).uv2Offset;
l9_4109=l9_4110;
float2 l9_4111=float2(0.0);
l9_4111=l9_4109;
float2 l9_4112=float2(0.0);
l9_4112=(l9_4095*l9_4108)+l9_4111;
float2 l9_4113=float2(0.0);
l9_4113=l9_4112+(l9_4111*(l9_4093.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4091=l9_4113;
l9_4094=l9_4091;
}
else
{
float2 l9_4114=float2(0.0);
float2 l9_4115=float2(0.0);
float2 l9_4116=float2(0.0);
float2 l9_4117=float2(0.0);
float2 l9_4118=float2(0.0);
ssGlobals l9_4119=l9_4093;
float2 l9_4120;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4121=float2(0.0);
l9_4121=l9_4119.Surface_UVCoord0;
l9_4115=l9_4121;
l9_4120=l9_4115;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4122=float2(0.0);
l9_4122=l9_4119.Surface_UVCoord1;
l9_4116=l9_4122;
l9_4120=l9_4116;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4123=float2(0.0);
l9_4123=l9_4119.gScreenCoord;
l9_4117=l9_4123;
l9_4120=l9_4117;
}
else
{
float2 l9_4124=float2(0.0);
l9_4124=l9_4119.Surface_UVCoord0;
l9_4118=l9_4124;
l9_4120=l9_4118;
}
}
}
l9_4114=l9_4120;
float2 l9_4125=float2(0.0);
float2 l9_4126=(*sc_set2.UserUniforms).uv2Scale;
l9_4125=l9_4126;
float2 l9_4127=float2(0.0);
l9_4127=l9_4125;
float2 l9_4128=float2(0.0);
float2 l9_4129=(*sc_set2.UserUniforms).uv2Offset;
l9_4128=l9_4129;
float2 l9_4130=float2(0.0);
l9_4130=l9_4128;
float2 l9_4131=float2(0.0);
l9_4131=(l9_4114*l9_4127)+l9_4130;
l9_4092=l9_4131;
l9_4094=l9_4092;
}
l9_4090=l9_4094;
l9_4086=l9_4090;
l9_4089=l9_4086;
}
else
{
float2 l9_4132=float2(0.0);
l9_4132=l9_4088.Surface_UVCoord0;
l9_4087=l9_4132;
l9_4089=l9_4087;
}
l9_4085=l9_4089;
float2 l9_4133=float2(0.0);
l9_4133=l9_4085;
float2 l9_4134=float2(0.0);
l9_4134=l9_4133;
l9_4078=l9_4134;
l9_4082=l9_4078;
}
else
{
if (NODE_181_DROPLIST_ITEM_tmp==3)
{
float2 l9_4135=float2(0.0);
float2 l9_4136=float2(0.0);
float2 l9_4137=float2(0.0);
ssGlobals l9_4138=l9_4081;
float2 l9_4139;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_4140=float2(0.0);
float2 l9_4141=float2(0.0);
float2 l9_4142=float2(0.0);
ssGlobals l9_4143=l9_4138;
float2 l9_4144;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_4145=float2(0.0);
float2 l9_4146=float2(0.0);
float2 l9_4147=float2(0.0);
float2 l9_4148=float2(0.0);
float2 l9_4149=float2(0.0);
float2 l9_4150=float2(0.0);
ssGlobals l9_4151=l9_4143;
float2 l9_4152;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_4153=float2(0.0);
l9_4153=l9_4151.Surface_UVCoord0;
l9_4146=l9_4153;
l9_4152=l9_4146;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_4154=float2(0.0);
l9_4154=l9_4151.Surface_UVCoord1;
l9_4147=l9_4154;
l9_4152=l9_4147;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_4155=float2(0.0);
l9_4155=l9_4151.gScreenCoord;
l9_4148=l9_4155;
l9_4152=l9_4148;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_4156=float2(0.0);
float2 l9_4157=float2(0.0);
float2 l9_4158=float2(0.0);
ssGlobals l9_4159=l9_4151;
float2 l9_4160;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4161=float2(0.0);
float2 l9_4162=float2(0.0);
float2 l9_4163=float2(0.0);
ssGlobals l9_4164=l9_4159;
float2 l9_4165;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4166=float2(0.0);
float2 l9_4167=float2(0.0);
float2 l9_4168=float2(0.0);
float2 l9_4169=float2(0.0);
float2 l9_4170=float2(0.0);
ssGlobals l9_4171=l9_4164;
float2 l9_4172;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4173=float2(0.0);
l9_4173=l9_4171.Surface_UVCoord0;
l9_4167=l9_4173;
l9_4172=l9_4167;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4174=float2(0.0);
l9_4174=l9_4171.Surface_UVCoord1;
l9_4168=l9_4174;
l9_4172=l9_4168;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4175=float2(0.0);
l9_4175=l9_4171.gScreenCoord;
l9_4169=l9_4175;
l9_4172=l9_4169;
}
else
{
float2 l9_4176=float2(0.0);
l9_4176=l9_4171.Surface_UVCoord0;
l9_4170=l9_4176;
l9_4172=l9_4170;
}
}
}
l9_4166=l9_4172;
float2 l9_4177=float2(0.0);
float2 l9_4178=(*sc_set2.UserUniforms).uv2Scale;
l9_4177=l9_4178;
float2 l9_4179=float2(0.0);
l9_4179=l9_4177;
float2 l9_4180=float2(0.0);
float2 l9_4181=(*sc_set2.UserUniforms).uv2Offset;
l9_4180=l9_4181;
float2 l9_4182=float2(0.0);
l9_4182=l9_4180;
float2 l9_4183=float2(0.0);
l9_4183=(l9_4166*l9_4179)+l9_4182;
float2 l9_4184=float2(0.0);
l9_4184=l9_4183+(l9_4182*(l9_4164.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4162=l9_4184;
l9_4165=l9_4162;
}
else
{
float2 l9_4185=float2(0.0);
float2 l9_4186=float2(0.0);
float2 l9_4187=float2(0.0);
float2 l9_4188=float2(0.0);
float2 l9_4189=float2(0.0);
ssGlobals l9_4190=l9_4164;
float2 l9_4191;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4192=float2(0.0);
l9_4192=l9_4190.Surface_UVCoord0;
l9_4186=l9_4192;
l9_4191=l9_4186;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4193=float2(0.0);
l9_4193=l9_4190.Surface_UVCoord1;
l9_4187=l9_4193;
l9_4191=l9_4187;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4194=float2(0.0);
l9_4194=l9_4190.gScreenCoord;
l9_4188=l9_4194;
l9_4191=l9_4188;
}
else
{
float2 l9_4195=float2(0.0);
l9_4195=l9_4190.Surface_UVCoord0;
l9_4189=l9_4195;
l9_4191=l9_4189;
}
}
}
l9_4185=l9_4191;
float2 l9_4196=float2(0.0);
float2 l9_4197=(*sc_set2.UserUniforms).uv2Scale;
l9_4196=l9_4197;
float2 l9_4198=float2(0.0);
l9_4198=l9_4196;
float2 l9_4199=float2(0.0);
float2 l9_4200=(*sc_set2.UserUniforms).uv2Offset;
l9_4199=l9_4200;
float2 l9_4201=float2(0.0);
l9_4201=l9_4199;
float2 l9_4202=float2(0.0);
l9_4202=(l9_4185*l9_4198)+l9_4201;
l9_4163=l9_4202;
l9_4165=l9_4163;
}
l9_4161=l9_4165;
l9_4157=l9_4161;
l9_4160=l9_4157;
}
else
{
float2 l9_4203=float2(0.0);
l9_4203=l9_4159.Surface_UVCoord0;
l9_4158=l9_4203;
l9_4160=l9_4158;
}
l9_4156=l9_4160;
float2 l9_4204=float2(0.0);
l9_4204=l9_4156;
float2 l9_4205=float2(0.0);
l9_4205=l9_4204;
l9_4149=l9_4205;
l9_4152=l9_4149;
}
else
{
float2 l9_4206=float2(0.0);
l9_4206=l9_4151.Surface_UVCoord0;
l9_4150=l9_4206;
l9_4152=l9_4150;
}
}
}
}
l9_4145=l9_4152;
float2 l9_4207=float2(0.0);
float2 l9_4208=(*sc_set2.UserUniforms).uv3Scale;
l9_4207=l9_4208;
float2 l9_4209=float2(0.0);
l9_4209=l9_4207;
float2 l9_4210=float2(0.0);
float2 l9_4211=(*sc_set2.UserUniforms).uv3Offset;
l9_4210=l9_4211;
float2 l9_4212=float2(0.0);
l9_4212=l9_4210;
float2 l9_4213=float2(0.0);
l9_4213=(l9_4145*l9_4209)+l9_4212;
float2 l9_4214=float2(0.0);
l9_4214=l9_4213+(l9_4212*(l9_4143.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_4141=l9_4214;
l9_4144=l9_4141;
}
else
{
float2 l9_4215=float2(0.0);
float2 l9_4216=float2(0.0);
float2 l9_4217=float2(0.0);
float2 l9_4218=float2(0.0);
float2 l9_4219=float2(0.0);
float2 l9_4220=float2(0.0);
ssGlobals l9_4221=l9_4143;
float2 l9_4222;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_4223=float2(0.0);
l9_4223=l9_4221.Surface_UVCoord0;
l9_4216=l9_4223;
l9_4222=l9_4216;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_4224=float2(0.0);
l9_4224=l9_4221.Surface_UVCoord1;
l9_4217=l9_4224;
l9_4222=l9_4217;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_4225=float2(0.0);
l9_4225=l9_4221.gScreenCoord;
l9_4218=l9_4225;
l9_4222=l9_4218;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_4226=float2(0.0);
float2 l9_4227=float2(0.0);
float2 l9_4228=float2(0.0);
ssGlobals l9_4229=l9_4221;
float2 l9_4230;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4231=float2(0.0);
float2 l9_4232=float2(0.0);
float2 l9_4233=float2(0.0);
ssGlobals l9_4234=l9_4229;
float2 l9_4235;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4236=float2(0.0);
float2 l9_4237=float2(0.0);
float2 l9_4238=float2(0.0);
float2 l9_4239=float2(0.0);
float2 l9_4240=float2(0.0);
ssGlobals l9_4241=l9_4234;
float2 l9_4242;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4243=float2(0.0);
l9_4243=l9_4241.Surface_UVCoord0;
l9_4237=l9_4243;
l9_4242=l9_4237;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4244=float2(0.0);
l9_4244=l9_4241.Surface_UVCoord1;
l9_4238=l9_4244;
l9_4242=l9_4238;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4245=float2(0.0);
l9_4245=l9_4241.gScreenCoord;
l9_4239=l9_4245;
l9_4242=l9_4239;
}
else
{
float2 l9_4246=float2(0.0);
l9_4246=l9_4241.Surface_UVCoord0;
l9_4240=l9_4246;
l9_4242=l9_4240;
}
}
}
l9_4236=l9_4242;
float2 l9_4247=float2(0.0);
float2 l9_4248=(*sc_set2.UserUniforms).uv2Scale;
l9_4247=l9_4248;
float2 l9_4249=float2(0.0);
l9_4249=l9_4247;
float2 l9_4250=float2(0.0);
float2 l9_4251=(*sc_set2.UserUniforms).uv2Offset;
l9_4250=l9_4251;
float2 l9_4252=float2(0.0);
l9_4252=l9_4250;
float2 l9_4253=float2(0.0);
l9_4253=(l9_4236*l9_4249)+l9_4252;
float2 l9_4254=float2(0.0);
l9_4254=l9_4253+(l9_4252*(l9_4234.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4232=l9_4254;
l9_4235=l9_4232;
}
else
{
float2 l9_4255=float2(0.0);
float2 l9_4256=float2(0.0);
float2 l9_4257=float2(0.0);
float2 l9_4258=float2(0.0);
float2 l9_4259=float2(0.0);
ssGlobals l9_4260=l9_4234;
float2 l9_4261;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4262=float2(0.0);
l9_4262=l9_4260.Surface_UVCoord0;
l9_4256=l9_4262;
l9_4261=l9_4256;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4263=float2(0.0);
l9_4263=l9_4260.Surface_UVCoord1;
l9_4257=l9_4263;
l9_4261=l9_4257;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4264=float2(0.0);
l9_4264=l9_4260.gScreenCoord;
l9_4258=l9_4264;
l9_4261=l9_4258;
}
else
{
float2 l9_4265=float2(0.0);
l9_4265=l9_4260.Surface_UVCoord0;
l9_4259=l9_4265;
l9_4261=l9_4259;
}
}
}
l9_4255=l9_4261;
float2 l9_4266=float2(0.0);
float2 l9_4267=(*sc_set2.UserUniforms).uv2Scale;
l9_4266=l9_4267;
float2 l9_4268=float2(0.0);
l9_4268=l9_4266;
float2 l9_4269=float2(0.0);
float2 l9_4270=(*sc_set2.UserUniforms).uv2Offset;
l9_4269=l9_4270;
float2 l9_4271=float2(0.0);
l9_4271=l9_4269;
float2 l9_4272=float2(0.0);
l9_4272=(l9_4255*l9_4268)+l9_4271;
l9_4233=l9_4272;
l9_4235=l9_4233;
}
l9_4231=l9_4235;
l9_4227=l9_4231;
l9_4230=l9_4227;
}
else
{
float2 l9_4273=float2(0.0);
l9_4273=l9_4229.Surface_UVCoord0;
l9_4228=l9_4273;
l9_4230=l9_4228;
}
l9_4226=l9_4230;
float2 l9_4274=float2(0.0);
l9_4274=l9_4226;
float2 l9_4275=float2(0.0);
l9_4275=l9_4274;
l9_4219=l9_4275;
l9_4222=l9_4219;
}
else
{
float2 l9_4276=float2(0.0);
l9_4276=l9_4221.Surface_UVCoord0;
l9_4220=l9_4276;
l9_4222=l9_4220;
}
}
}
}
l9_4215=l9_4222;
float2 l9_4277=float2(0.0);
float2 l9_4278=(*sc_set2.UserUniforms).uv3Scale;
l9_4277=l9_4278;
float2 l9_4279=float2(0.0);
l9_4279=l9_4277;
float2 l9_4280=float2(0.0);
float2 l9_4281=(*sc_set2.UserUniforms).uv3Offset;
l9_4280=l9_4281;
float2 l9_4282=float2(0.0);
l9_4282=l9_4280;
float2 l9_4283=float2(0.0);
l9_4283=(l9_4215*l9_4279)+l9_4282;
l9_4142=l9_4283;
l9_4144=l9_4142;
}
l9_4140=l9_4144;
l9_4136=l9_4140;
l9_4139=l9_4136;
}
else
{
float2 l9_4284=float2(0.0);
l9_4284=l9_4138.Surface_UVCoord0;
l9_4137=l9_4284;
l9_4139=l9_4137;
}
l9_4135=l9_4139;
float2 l9_4285=float2(0.0);
l9_4285=l9_4135;
float2 l9_4286=float2(0.0);
l9_4286=l9_4285;
l9_4079=l9_4286;
l9_4082=l9_4079;
}
else
{
float2 l9_4287=float2(0.0);
l9_4287=l9_4081.Surface_UVCoord0;
l9_4080=l9_4287;
l9_4082=l9_4080;
}
}
}
}
l9_4075=l9_4082;
float4 l9_4288=float4(0.0);
float2 l9_4289=l9_4075;
int l9_4290=0;
if ((int(normalTexHasSwappedViews_tmp)!=0))
{
int l9_4291=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4291=0;
}
else
{
l9_4291=in.varStereoViewID;
}
int l9_4292=l9_4291;
l9_4290=1-l9_4292;
}
else
{
int l9_4293=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4293=0;
}
else
{
l9_4293=in.varStereoViewID;
}
int l9_4294=l9_4293;
l9_4290=l9_4294;
}
int l9_4295=l9_4290;
int l9_4296=normalTexLayout_tmp;
int l9_4297=l9_4295;
float2 l9_4298=l9_4289;
bool l9_4299=(int(SC_USE_UV_TRANSFORM_normalTex_tmp)!=0);
float3x3 l9_4300=(*sc_set2.UserUniforms).normalTexTransform;
int2 l9_4301=int2(SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp);
bool l9_4302=(int(SC_USE_UV_MIN_MAX_normalTex_tmp)!=0);
float4 l9_4303=(*sc_set2.UserUniforms).normalTexUvMinMax;
bool l9_4304=(int(SC_USE_CLAMP_TO_BORDER_normalTex_tmp)!=0);
float4 l9_4305=(*sc_set2.UserUniforms).normalTexBorderColor;
float l9_4306=0.0;
bool l9_4307=l9_4304&&(!l9_4302);
float l9_4308=1.0;
float l9_4309=l9_4298.x;
int l9_4310=l9_4301.x;
if (l9_4310==1)
{
l9_4309=fract(l9_4309);
}
else
{
if (l9_4310==2)
{
float l9_4311=fract(l9_4309);
float l9_4312=l9_4309-l9_4311;
float l9_4313=step(0.25,fract(l9_4312*0.5));
l9_4309=mix(l9_4311,1.0-l9_4311,fast::clamp(l9_4313,0.0,1.0));
}
}
l9_4298.x=l9_4309;
float l9_4314=l9_4298.y;
int l9_4315=l9_4301.y;
if (l9_4315==1)
{
l9_4314=fract(l9_4314);
}
else
{
if (l9_4315==2)
{
float l9_4316=fract(l9_4314);
float l9_4317=l9_4314-l9_4316;
float l9_4318=step(0.25,fract(l9_4317*0.5));
l9_4314=mix(l9_4316,1.0-l9_4316,fast::clamp(l9_4318,0.0,1.0));
}
}
l9_4298.y=l9_4314;
if (l9_4302)
{
bool l9_4319=l9_4304;
bool l9_4320;
if (l9_4319)
{
l9_4320=l9_4301.x==3;
}
else
{
l9_4320=l9_4319;
}
float l9_4321=l9_4298.x;
float l9_4322=l9_4303.x;
float l9_4323=l9_4303.z;
bool l9_4324=l9_4320;
float l9_4325=l9_4308;
float l9_4326=fast::clamp(l9_4321,l9_4322,l9_4323);
float l9_4327=step(abs(l9_4321-l9_4326),9.9999997e-06);
l9_4325*=(l9_4327+((1.0-float(l9_4324))*(1.0-l9_4327)));
l9_4321=l9_4326;
l9_4298.x=l9_4321;
l9_4308=l9_4325;
bool l9_4328=l9_4304;
bool l9_4329;
if (l9_4328)
{
l9_4329=l9_4301.y==3;
}
else
{
l9_4329=l9_4328;
}
float l9_4330=l9_4298.y;
float l9_4331=l9_4303.y;
float l9_4332=l9_4303.w;
bool l9_4333=l9_4329;
float l9_4334=l9_4308;
float l9_4335=fast::clamp(l9_4330,l9_4331,l9_4332);
float l9_4336=step(abs(l9_4330-l9_4335),9.9999997e-06);
l9_4334*=(l9_4336+((1.0-float(l9_4333))*(1.0-l9_4336)));
l9_4330=l9_4335;
l9_4298.y=l9_4330;
l9_4308=l9_4334;
}
float2 l9_4337=l9_4298;
bool l9_4338=l9_4299;
float3x3 l9_4339=l9_4300;
if (l9_4338)
{
l9_4337=float2((l9_4339*float3(l9_4337,1.0)).xy);
}
float2 l9_4340=l9_4337;
float2 l9_4341=l9_4340;
float2 l9_4342=l9_4341;
l9_4298=l9_4342;
float l9_4343=l9_4298.x;
int l9_4344=l9_4301.x;
bool l9_4345=l9_4307;
float l9_4346=l9_4308;
if ((l9_4344==0)||(l9_4344==3))
{
float l9_4347=l9_4343;
float l9_4348=0.0;
float l9_4349=1.0;
bool l9_4350=l9_4345;
float l9_4351=l9_4346;
float l9_4352=fast::clamp(l9_4347,l9_4348,l9_4349);
float l9_4353=step(abs(l9_4347-l9_4352),9.9999997e-06);
l9_4351*=(l9_4353+((1.0-float(l9_4350))*(1.0-l9_4353)));
l9_4347=l9_4352;
l9_4343=l9_4347;
l9_4346=l9_4351;
}
l9_4298.x=l9_4343;
l9_4308=l9_4346;
float l9_4354=l9_4298.y;
int l9_4355=l9_4301.y;
bool l9_4356=l9_4307;
float l9_4357=l9_4308;
if ((l9_4355==0)||(l9_4355==3))
{
float l9_4358=l9_4354;
float l9_4359=0.0;
float l9_4360=1.0;
bool l9_4361=l9_4356;
float l9_4362=l9_4357;
float l9_4363=fast::clamp(l9_4358,l9_4359,l9_4360);
float l9_4364=step(abs(l9_4358-l9_4363),9.9999997e-06);
l9_4362*=(l9_4364+((1.0-float(l9_4361))*(1.0-l9_4364)));
l9_4358=l9_4363;
l9_4354=l9_4358;
l9_4357=l9_4362;
}
l9_4298.y=l9_4354;
l9_4308=l9_4357;
float2 l9_4365=l9_4298;
int l9_4366=l9_4296;
int l9_4367=l9_4297;
float l9_4368=l9_4306;
float2 l9_4369=l9_4365;
int l9_4370=l9_4366;
int l9_4371=l9_4367;
float3 l9_4372=float3(0.0);
if (l9_4370==0)
{
l9_4372=float3(l9_4369,0.0);
}
else
{
if (l9_4370==1)
{
l9_4372=float3(l9_4369.x,(l9_4369.y*0.5)+(0.5-(float(l9_4371)*0.5)),0.0);
}
else
{
l9_4372=float3(l9_4369,float(l9_4371));
}
}
float3 l9_4373=l9_4372;
float3 l9_4374=l9_4373;
float2 l9_4375=l9_4374.xy;
float l9_4376=l9_4368;
float4 l9_4377=sc_set2.normalTex.sample(sc_set2.normalTexSmpSC,l9_4375,bias(l9_4376));
float4 l9_4378=l9_4377;
float4 l9_4379=l9_4378;
if (l9_4304)
{
l9_4379=mix(l9_4305,l9_4379,float4(l9_4308));
}
float4 l9_4380=l9_4379;
float4 l9_4381=l9_4380;
float3 l9_4382=(l9_4381.xyz*1.9921875)-float3(1.0);
l9_4381=float4(l9_4382.x,l9_4382.y,l9_4382.z,l9_4381.w);
l9_4288=l9_4381;
float3 l9_4383=float3(0.0);
float3 l9_4384=float3(0.0);
float3 l9_4385=(*sc_set2.UserUniforms).Port_Default_N113;
ssGlobals l9_4386=l9_4069;
float3 l9_4387;
if ((int(ENABLE_DETAIL_NORMAL_tmp)!=0))
{
float2 l9_4388=float2(0.0);
float2 l9_4389=float2(0.0);
float2 l9_4390=float2(0.0);
float2 l9_4391=float2(0.0);
float2 l9_4392=float2(0.0);
float2 l9_4393=float2(0.0);
ssGlobals l9_4394=l9_4386;
float2 l9_4395;
if (NODE_184_DROPLIST_ITEM_tmp==0)
{
float2 l9_4396=float2(0.0);
l9_4396=l9_4394.Surface_UVCoord0;
l9_4389=l9_4396;
l9_4395=l9_4389;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==1)
{
float2 l9_4397=float2(0.0);
l9_4397=l9_4394.Surface_UVCoord1;
l9_4390=l9_4397;
l9_4395=l9_4390;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==2)
{
float2 l9_4398=float2(0.0);
float2 l9_4399=float2(0.0);
float2 l9_4400=float2(0.0);
ssGlobals l9_4401=l9_4394;
float2 l9_4402;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4403=float2(0.0);
float2 l9_4404=float2(0.0);
float2 l9_4405=float2(0.0);
ssGlobals l9_4406=l9_4401;
float2 l9_4407;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4408=float2(0.0);
float2 l9_4409=float2(0.0);
float2 l9_4410=float2(0.0);
float2 l9_4411=float2(0.0);
float2 l9_4412=float2(0.0);
ssGlobals l9_4413=l9_4406;
float2 l9_4414;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4415=float2(0.0);
l9_4415=l9_4413.Surface_UVCoord0;
l9_4409=l9_4415;
l9_4414=l9_4409;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4416=float2(0.0);
l9_4416=l9_4413.Surface_UVCoord1;
l9_4410=l9_4416;
l9_4414=l9_4410;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4417=float2(0.0);
l9_4417=l9_4413.gScreenCoord;
l9_4411=l9_4417;
l9_4414=l9_4411;
}
else
{
float2 l9_4418=float2(0.0);
l9_4418=l9_4413.Surface_UVCoord0;
l9_4412=l9_4418;
l9_4414=l9_4412;
}
}
}
l9_4408=l9_4414;
float2 l9_4419=float2(0.0);
float2 l9_4420=(*sc_set2.UserUniforms).uv2Scale;
l9_4419=l9_4420;
float2 l9_4421=float2(0.0);
l9_4421=l9_4419;
float2 l9_4422=float2(0.0);
float2 l9_4423=(*sc_set2.UserUniforms).uv2Offset;
l9_4422=l9_4423;
float2 l9_4424=float2(0.0);
l9_4424=l9_4422;
float2 l9_4425=float2(0.0);
l9_4425=(l9_4408*l9_4421)+l9_4424;
float2 l9_4426=float2(0.0);
l9_4426=l9_4425+(l9_4424*(l9_4406.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4404=l9_4426;
l9_4407=l9_4404;
}
else
{
float2 l9_4427=float2(0.0);
float2 l9_4428=float2(0.0);
float2 l9_4429=float2(0.0);
float2 l9_4430=float2(0.0);
float2 l9_4431=float2(0.0);
ssGlobals l9_4432=l9_4406;
float2 l9_4433;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4434=float2(0.0);
l9_4434=l9_4432.Surface_UVCoord0;
l9_4428=l9_4434;
l9_4433=l9_4428;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4435=float2(0.0);
l9_4435=l9_4432.Surface_UVCoord1;
l9_4429=l9_4435;
l9_4433=l9_4429;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4436=float2(0.0);
l9_4436=l9_4432.gScreenCoord;
l9_4430=l9_4436;
l9_4433=l9_4430;
}
else
{
float2 l9_4437=float2(0.0);
l9_4437=l9_4432.Surface_UVCoord0;
l9_4431=l9_4437;
l9_4433=l9_4431;
}
}
}
l9_4427=l9_4433;
float2 l9_4438=float2(0.0);
float2 l9_4439=(*sc_set2.UserUniforms).uv2Scale;
l9_4438=l9_4439;
float2 l9_4440=float2(0.0);
l9_4440=l9_4438;
float2 l9_4441=float2(0.0);
float2 l9_4442=(*sc_set2.UserUniforms).uv2Offset;
l9_4441=l9_4442;
float2 l9_4443=float2(0.0);
l9_4443=l9_4441;
float2 l9_4444=float2(0.0);
l9_4444=(l9_4427*l9_4440)+l9_4443;
l9_4405=l9_4444;
l9_4407=l9_4405;
}
l9_4403=l9_4407;
l9_4399=l9_4403;
l9_4402=l9_4399;
}
else
{
float2 l9_4445=float2(0.0);
l9_4445=l9_4401.Surface_UVCoord0;
l9_4400=l9_4445;
l9_4402=l9_4400;
}
l9_4398=l9_4402;
float2 l9_4446=float2(0.0);
l9_4446=l9_4398;
float2 l9_4447=float2(0.0);
l9_4447=l9_4446;
l9_4391=l9_4447;
l9_4395=l9_4391;
}
else
{
if (NODE_184_DROPLIST_ITEM_tmp==3)
{
float2 l9_4448=float2(0.0);
float2 l9_4449=float2(0.0);
float2 l9_4450=float2(0.0);
ssGlobals l9_4451=l9_4394;
float2 l9_4452;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_4453=float2(0.0);
float2 l9_4454=float2(0.0);
float2 l9_4455=float2(0.0);
ssGlobals l9_4456=l9_4451;
float2 l9_4457;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_4458=float2(0.0);
float2 l9_4459=float2(0.0);
float2 l9_4460=float2(0.0);
float2 l9_4461=float2(0.0);
float2 l9_4462=float2(0.0);
float2 l9_4463=float2(0.0);
ssGlobals l9_4464=l9_4456;
float2 l9_4465;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_4466=float2(0.0);
l9_4466=l9_4464.Surface_UVCoord0;
l9_4459=l9_4466;
l9_4465=l9_4459;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_4467=float2(0.0);
l9_4467=l9_4464.Surface_UVCoord1;
l9_4460=l9_4467;
l9_4465=l9_4460;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_4468=float2(0.0);
l9_4468=l9_4464.gScreenCoord;
l9_4461=l9_4468;
l9_4465=l9_4461;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_4469=float2(0.0);
float2 l9_4470=float2(0.0);
float2 l9_4471=float2(0.0);
ssGlobals l9_4472=l9_4464;
float2 l9_4473;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4474=float2(0.0);
float2 l9_4475=float2(0.0);
float2 l9_4476=float2(0.0);
ssGlobals l9_4477=l9_4472;
float2 l9_4478;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4479=float2(0.0);
float2 l9_4480=float2(0.0);
float2 l9_4481=float2(0.0);
float2 l9_4482=float2(0.0);
float2 l9_4483=float2(0.0);
ssGlobals l9_4484=l9_4477;
float2 l9_4485;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4486=float2(0.0);
l9_4486=l9_4484.Surface_UVCoord0;
l9_4480=l9_4486;
l9_4485=l9_4480;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4487=float2(0.0);
l9_4487=l9_4484.Surface_UVCoord1;
l9_4481=l9_4487;
l9_4485=l9_4481;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4488=float2(0.0);
l9_4488=l9_4484.gScreenCoord;
l9_4482=l9_4488;
l9_4485=l9_4482;
}
else
{
float2 l9_4489=float2(0.0);
l9_4489=l9_4484.Surface_UVCoord0;
l9_4483=l9_4489;
l9_4485=l9_4483;
}
}
}
l9_4479=l9_4485;
float2 l9_4490=float2(0.0);
float2 l9_4491=(*sc_set2.UserUniforms).uv2Scale;
l9_4490=l9_4491;
float2 l9_4492=float2(0.0);
l9_4492=l9_4490;
float2 l9_4493=float2(0.0);
float2 l9_4494=(*sc_set2.UserUniforms).uv2Offset;
l9_4493=l9_4494;
float2 l9_4495=float2(0.0);
l9_4495=l9_4493;
float2 l9_4496=float2(0.0);
l9_4496=(l9_4479*l9_4492)+l9_4495;
float2 l9_4497=float2(0.0);
l9_4497=l9_4496+(l9_4495*(l9_4477.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4475=l9_4497;
l9_4478=l9_4475;
}
else
{
float2 l9_4498=float2(0.0);
float2 l9_4499=float2(0.0);
float2 l9_4500=float2(0.0);
float2 l9_4501=float2(0.0);
float2 l9_4502=float2(0.0);
ssGlobals l9_4503=l9_4477;
float2 l9_4504;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4505=float2(0.0);
l9_4505=l9_4503.Surface_UVCoord0;
l9_4499=l9_4505;
l9_4504=l9_4499;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4506=float2(0.0);
l9_4506=l9_4503.Surface_UVCoord1;
l9_4500=l9_4506;
l9_4504=l9_4500;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4507=float2(0.0);
l9_4507=l9_4503.gScreenCoord;
l9_4501=l9_4507;
l9_4504=l9_4501;
}
else
{
float2 l9_4508=float2(0.0);
l9_4508=l9_4503.Surface_UVCoord0;
l9_4502=l9_4508;
l9_4504=l9_4502;
}
}
}
l9_4498=l9_4504;
float2 l9_4509=float2(0.0);
float2 l9_4510=(*sc_set2.UserUniforms).uv2Scale;
l9_4509=l9_4510;
float2 l9_4511=float2(0.0);
l9_4511=l9_4509;
float2 l9_4512=float2(0.0);
float2 l9_4513=(*sc_set2.UserUniforms).uv2Offset;
l9_4512=l9_4513;
float2 l9_4514=float2(0.0);
l9_4514=l9_4512;
float2 l9_4515=float2(0.0);
l9_4515=(l9_4498*l9_4511)+l9_4514;
l9_4476=l9_4515;
l9_4478=l9_4476;
}
l9_4474=l9_4478;
l9_4470=l9_4474;
l9_4473=l9_4470;
}
else
{
float2 l9_4516=float2(0.0);
l9_4516=l9_4472.Surface_UVCoord0;
l9_4471=l9_4516;
l9_4473=l9_4471;
}
l9_4469=l9_4473;
float2 l9_4517=float2(0.0);
l9_4517=l9_4469;
float2 l9_4518=float2(0.0);
l9_4518=l9_4517;
l9_4462=l9_4518;
l9_4465=l9_4462;
}
else
{
float2 l9_4519=float2(0.0);
l9_4519=l9_4464.Surface_UVCoord0;
l9_4463=l9_4519;
l9_4465=l9_4463;
}
}
}
}
l9_4458=l9_4465;
float2 l9_4520=float2(0.0);
float2 l9_4521=(*sc_set2.UserUniforms).uv3Scale;
l9_4520=l9_4521;
float2 l9_4522=float2(0.0);
l9_4522=l9_4520;
float2 l9_4523=float2(0.0);
float2 l9_4524=(*sc_set2.UserUniforms).uv3Offset;
l9_4523=l9_4524;
float2 l9_4525=float2(0.0);
l9_4525=l9_4523;
float2 l9_4526=float2(0.0);
l9_4526=(l9_4458*l9_4522)+l9_4525;
float2 l9_4527=float2(0.0);
l9_4527=l9_4526+(l9_4525*(l9_4456.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_4454=l9_4527;
l9_4457=l9_4454;
}
else
{
float2 l9_4528=float2(0.0);
float2 l9_4529=float2(0.0);
float2 l9_4530=float2(0.0);
float2 l9_4531=float2(0.0);
float2 l9_4532=float2(0.0);
float2 l9_4533=float2(0.0);
ssGlobals l9_4534=l9_4456;
float2 l9_4535;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_4536=float2(0.0);
l9_4536=l9_4534.Surface_UVCoord0;
l9_4529=l9_4536;
l9_4535=l9_4529;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_4537=float2(0.0);
l9_4537=l9_4534.Surface_UVCoord1;
l9_4530=l9_4537;
l9_4535=l9_4530;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_4538=float2(0.0);
l9_4538=l9_4534.gScreenCoord;
l9_4531=l9_4538;
l9_4535=l9_4531;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_4539=float2(0.0);
float2 l9_4540=float2(0.0);
float2 l9_4541=float2(0.0);
ssGlobals l9_4542=l9_4534;
float2 l9_4543;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4544=float2(0.0);
float2 l9_4545=float2(0.0);
float2 l9_4546=float2(0.0);
ssGlobals l9_4547=l9_4542;
float2 l9_4548;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4549=float2(0.0);
float2 l9_4550=float2(0.0);
float2 l9_4551=float2(0.0);
float2 l9_4552=float2(0.0);
float2 l9_4553=float2(0.0);
ssGlobals l9_4554=l9_4547;
float2 l9_4555;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4556=float2(0.0);
l9_4556=l9_4554.Surface_UVCoord0;
l9_4550=l9_4556;
l9_4555=l9_4550;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4557=float2(0.0);
l9_4557=l9_4554.Surface_UVCoord1;
l9_4551=l9_4557;
l9_4555=l9_4551;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4558=float2(0.0);
l9_4558=l9_4554.gScreenCoord;
l9_4552=l9_4558;
l9_4555=l9_4552;
}
else
{
float2 l9_4559=float2(0.0);
l9_4559=l9_4554.Surface_UVCoord0;
l9_4553=l9_4559;
l9_4555=l9_4553;
}
}
}
l9_4549=l9_4555;
float2 l9_4560=float2(0.0);
float2 l9_4561=(*sc_set2.UserUniforms).uv2Scale;
l9_4560=l9_4561;
float2 l9_4562=float2(0.0);
l9_4562=l9_4560;
float2 l9_4563=float2(0.0);
float2 l9_4564=(*sc_set2.UserUniforms).uv2Offset;
l9_4563=l9_4564;
float2 l9_4565=float2(0.0);
l9_4565=l9_4563;
float2 l9_4566=float2(0.0);
l9_4566=(l9_4549*l9_4562)+l9_4565;
float2 l9_4567=float2(0.0);
l9_4567=l9_4566+(l9_4565*(l9_4547.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4545=l9_4567;
l9_4548=l9_4545;
}
else
{
float2 l9_4568=float2(0.0);
float2 l9_4569=float2(0.0);
float2 l9_4570=float2(0.0);
float2 l9_4571=float2(0.0);
float2 l9_4572=float2(0.0);
ssGlobals l9_4573=l9_4547;
float2 l9_4574;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4575=float2(0.0);
l9_4575=l9_4573.Surface_UVCoord0;
l9_4569=l9_4575;
l9_4574=l9_4569;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4576=float2(0.0);
l9_4576=l9_4573.Surface_UVCoord1;
l9_4570=l9_4576;
l9_4574=l9_4570;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4577=float2(0.0);
l9_4577=l9_4573.gScreenCoord;
l9_4571=l9_4577;
l9_4574=l9_4571;
}
else
{
float2 l9_4578=float2(0.0);
l9_4578=l9_4573.Surface_UVCoord0;
l9_4572=l9_4578;
l9_4574=l9_4572;
}
}
}
l9_4568=l9_4574;
float2 l9_4579=float2(0.0);
float2 l9_4580=(*sc_set2.UserUniforms).uv2Scale;
l9_4579=l9_4580;
float2 l9_4581=float2(0.0);
l9_4581=l9_4579;
float2 l9_4582=float2(0.0);
float2 l9_4583=(*sc_set2.UserUniforms).uv2Offset;
l9_4582=l9_4583;
float2 l9_4584=float2(0.0);
l9_4584=l9_4582;
float2 l9_4585=float2(0.0);
l9_4585=(l9_4568*l9_4581)+l9_4584;
l9_4546=l9_4585;
l9_4548=l9_4546;
}
l9_4544=l9_4548;
l9_4540=l9_4544;
l9_4543=l9_4540;
}
else
{
float2 l9_4586=float2(0.0);
l9_4586=l9_4542.Surface_UVCoord0;
l9_4541=l9_4586;
l9_4543=l9_4541;
}
l9_4539=l9_4543;
float2 l9_4587=float2(0.0);
l9_4587=l9_4539;
float2 l9_4588=float2(0.0);
l9_4588=l9_4587;
l9_4532=l9_4588;
l9_4535=l9_4532;
}
else
{
float2 l9_4589=float2(0.0);
l9_4589=l9_4534.Surface_UVCoord0;
l9_4533=l9_4589;
l9_4535=l9_4533;
}
}
}
}
l9_4528=l9_4535;
float2 l9_4590=float2(0.0);
float2 l9_4591=(*sc_set2.UserUniforms).uv3Scale;
l9_4590=l9_4591;
float2 l9_4592=float2(0.0);
l9_4592=l9_4590;
float2 l9_4593=float2(0.0);
float2 l9_4594=(*sc_set2.UserUniforms).uv3Offset;
l9_4593=l9_4594;
float2 l9_4595=float2(0.0);
l9_4595=l9_4593;
float2 l9_4596=float2(0.0);
l9_4596=(l9_4528*l9_4592)+l9_4595;
l9_4455=l9_4596;
l9_4457=l9_4455;
}
l9_4453=l9_4457;
l9_4449=l9_4453;
l9_4452=l9_4449;
}
else
{
float2 l9_4597=float2(0.0);
l9_4597=l9_4451.Surface_UVCoord0;
l9_4450=l9_4597;
l9_4452=l9_4450;
}
l9_4448=l9_4452;
float2 l9_4598=float2(0.0);
l9_4598=l9_4448;
float2 l9_4599=float2(0.0);
l9_4599=l9_4598;
l9_4392=l9_4599;
l9_4395=l9_4392;
}
else
{
float2 l9_4600=float2(0.0);
l9_4600=l9_4394.Surface_UVCoord0;
l9_4393=l9_4600;
l9_4395=l9_4393;
}
}
}
}
l9_4388=l9_4395;
float4 l9_4601=float4(0.0);
float2 l9_4602=l9_4388;
int l9_4603=0;
if ((int(detailNormalTexHasSwappedViews_tmp)!=0))
{
int l9_4604=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4604=0;
}
else
{
l9_4604=in.varStereoViewID;
}
int l9_4605=l9_4604;
l9_4603=1-l9_4605;
}
else
{
int l9_4606=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4606=0;
}
else
{
l9_4606=in.varStereoViewID;
}
int l9_4607=l9_4606;
l9_4603=l9_4607;
}
int l9_4608=l9_4603;
int l9_4609=detailNormalTexLayout_tmp;
int l9_4610=l9_4608;
float2 l9_4611=l9_4602;
bool l9_4612=(int(SC_USE_UV_TRANSFORM_detailNormalTex_tmp)!=0);
float3x3 l9_4613=(*sc_set2.UserUniforms).detailNormalTexTransform;
int2 l9_4614=int2(SC_SOFTWARE_WRAP_MODE_U_detailNormalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_detailNormalTex_tmp);
bool l9_4615=(int(SC_USE_UV_MIN_MAX_detailNormalTex_tmp)!=0);
float4 l9_4616=(*sc_set2.UserUniforms).detailNormalTexUvMinMax;
bool l9_4617=(int(SC_USE_CLAMP_TO_BORDER_detailNormalTex_tmp)!=0);
float4 l9_4618=(*sc_set2.UserUniforms).detailNormalTexBorderColor;
float l9_4619=0.0;
bool l9_4620=l9_4617&&(!l9_4615);
float l9_4621=1.0;
float l9_4622=l9_4611.x;
int l9_4623=l9_4614.x;
if (l9_4623==1)
{
l9_4622=fract(l9_4622);
}
else
{
if (l9_4623==2)
{
float l9_4624=fract(l9_4622);
float l9_4625=l9_4622-l9_4624;
float l9_4626=step(0.25,fract(l9_4625*0.5));
l9_4622=mix(l9_4624,1.0-l9_4624,fast::clamp(l9_4626,0.0,1.0));
}
}
l9_4611.x=l9_4622;
float l9_4627=l9_4611.y;
int l9_4628=l9_4614.y;
if (l9_4628==1)
{
l9_4627=fract(l9_4627);
}
else
{
if (l9_4628==2)
{
float l9_4629=fract(l9_4627);
float l9_4630=l9_4627-l9_4629;
float l9_4631=step(0.25,fract(l9_4630*0.5));
l9_4627=mix(l9_4629,1.0-l9_4629,fast::clamp(l9_4631,0.0,1.0));
}
}
l9_4611.y=l9_4627;
if (l9_4615)
{
bool l9_4632=l9_4617;
bool l9_4633;
if (l9_4632)
{
l9_4633=l9_4614.x==3;
}
else
{
l9_4633=l9_4632;
}
float l9_4634=l9_4611.x;
float l9_4635=l9_4616.x;
float l9_4636=l9_4616.z;
bool l9_4637=l9_4633;
float l9_4638=l9_4621;
float l9_4639=fast::clamp(l9_4634,l9_4635,l9_4636);
float l9_4640=step(abs(l9_4634-l9_4639),9.9999997e-06);
l9_4638*=(l9_4640+((1.0-float(l9_4637))*(1.0-l9_4640)));
l9_4634=l9_4639;
l9_4611.x=l9_4634;
l9_4621=l9_4638;
bool l9_4641=l9_4617;
bool l9_4642;
if (l9_4641)
{
l9_4642=l9_4614.y==3;
}
else
{
l9_4642=l9_4641;
}
float l9_4643=l9_4611.y;
float l9_4644=l9_4616.y;
float l9_4645=l9_4616.w;
bool l9_4646=l9_4642;
float l9_4647=l9_4621;
float l9_4648=fast::clamp(l9_4643,l9_4644,l9_4645);
float l9_4649=step(abs(l9_4643-l9_4648),9.9999997e-06);
l9_4647*=(l9_4649+((1.0-float(l9_4646))*(1.0-l9_4649)));
l9_4643=l9_4648;
l9_4611.y=l9_4643;
l9_4621=l9_4647;
}
float2 l9_4650=l9_4611;
bool l9_4651=l9_4612;
float3x3 l9_4652=l9_4613;
if (l9_4651)
{
l9_4650=float2((l9_4652*float3(l9_4650,1.0)).xy);
}
float2 l9_4653=l9_4650;
float2 l9_4654=l9_4653;
float2 l9_4655=l9_4654;
l9_4611=l9_4655;
float l9_4656=l9_4611.x;
int l9_4657=l9_4614.x;
bool l9_4658=l9_4620;
float l9_4659=l9_4621;
if ((l9_4657==0)||(l9_4657==3))
{
float l9_4660=l9_4656;
float l9_4661=0.0;
float l9_4662=1.0;
bool l9_4663=l9_4658;
float l9_4664=l9_4659;
float l9_4665=fast::clamp(l9_4660,l9_4661,l9_4662);
float l9_4666=step(abs(l9_4660-l9_4665),9.9999997e-06);
l9_4664*=(l9_4666+((1.0-float(l9_4663))*(1.0-l9_4666)));
l9_4660=l9_4665;
l9_4656=l9_4660;
l9_4659=l9_4664;
}
l9_4611.x=l9_4656;
l9_4621=l9_4659;
float l9_4667=l9_4611.y;
int l9_4668=l9_4614.y;
bool l9_4669=l9_4620;
float l9_4670=l9_4621;
if ((l9_4668==0)||(l9_4668==3))
{
float l9_4671=l9_4667;
float l9_4672=0.0;
float l9_4673=1.0;
bool l9_4674=l9_4669;
float l9_4675=l9_4670;
float l9_4676=fast::clamp(l9_4671,l9_4672,l9_4673);
float l9_4677=step(abs(l9_4671-l9_4676),9.9999997e-06);
l9_4675*=(l9_4677+((1.0-float(l9_4674))*(1.0-l9_4677)));
l9_4671=l9_4676;
l9_4667=l9_4671;
l9_4670=l9_4675;
}
l9_4611.y=l9_4667;
l9_4621=l9_4670;
float2 l9_4678=l9_4611;
int l9_4679=l9_4609;
int l9_4680=l9_4610;
float l9_4681=l9_4619;
float2 l9_4682=l9_4678;
int l9_4683=l9_4679;
int l9_4684=l9_4680;
float3 l9_4685=float3(0.0);
if (l9_4683==0)
{
l9_4685=float3(l9_4682,0.0);
}
else
{
if (l9_4683==1)
{
l9_4685=float3(l9_4682.x,(l9_4682.y*0.5)+(0.5-(float(l9_4684)*0.5)),0.0);
}
else
{
l9_4685=float3(l9_4682,float(l9_4684));
}
}
float3 l9_4686=l9_4685;
float3 l9_4687=l9_4686;
float2 l9_4688=l9_4687.xy;
float l9_4689=l9_4681;
float4 l9_4690=sc_set2.detailNormalTex.sample(sc_set2.detailNormalTexSmpSC,l9_4688,bias(l9_4689));
float4 l9_4691=l9_4690;
float4 l9_4692=l9_4691;
if (l9_4617)
{
l9_4692=mix(l9_4618,l9_4692,float4(l9_4621));
}
float4 l9_4693=l9_4692;
float4 l9_4694=l9_4693;
float3 l9_4695=(l9_4694.xyz*1.9921875)-float3(1.0);
l9_4694=float4(l9_4695.x,l9_4695.y,l9_4695.z,l9_4694.w);
l9_4601=l9_4694;
l9_4384=l9_4601.xyz;
l9_4387=l9_4384;
}
else
{
l9_4387=l9_4385;
}
l9_4383=l9_4387;
float3 l9_4696=float3(0.0);
float3 l9_4697=l9_4288.xyz;
float l9_4698=(*sc_set2.UserUniforms).Port_Strength1_N200;
float3 l9_4699=l9_4383;
float l9_4700=(*sc_set2.UserUniforms).Port_Strength2_N200;
float3 l9_4701=l9_4697;
float l9_4702=l9_4698;
float3 l9_4703=l9_4699;
float l9_4704=l9_4700;
float3 l9_4705=mix(float3(0.0,0.0,1.0),l9_4701,float3(l9_4702))+float3(0.0,0.0,1.0);
float3 l9_4706=mix(float3(0.0,0.0,1.0),l9_4703,float3(l9_4704))*float3(-1.0,-1.0,1.0);
float3 l9_4707=normalize((l9_4705*dot(l9_4705,l9_4706))-(l9_4706*l9_4705.z));
l9_4699=l9_4707;
float3 l9_4708=l9_4699;
l9_4696=l9_4708;
float3 l9_4709=float3(0.0);
l9_4709=l9_4074*l9_4696;
float3 l9_4710=float3(0.0);
float3 l9_4711=l9_4709;
float l9_4712=dot(l9_4711,l9_4711);
float l9_4713;
if (l9_4712>0.0)
{
l9_4713=1.0/sqrt(l9_4712);
}
else
{
l9_4713=0.0;
}
float l9_4714=l9_4713;
float3 l9_4715=l9_4711*l9_4714;
l9_4710=l9_4715;
l9_4067=l9_4710;
l9_4070=l9_4067;
}
else
{
float3 l9_4716=float3(0.0);
l9_4716=l9_4069.VertexNormal_WorldSpace;
float3 l9_4717=float3(0.0);
float3 l9_4718=l9_4716;
float l9_4719=dot(l9_4718,l9_4718);
float l9_4720;
if (l9_4719>0.0)
{
l9_4720=1.0/sqrt(l9_4719);
}
else
{
l9_4720=0.0;
}
float l9_4721=l9_4720;
float3 l9_4722=l9_4718*l9_4721;
l9_4717=l9_4722;
l9_4068=l9_4717;
l9_4070=l9_4068;
}
l9_4066=l9_4070;
float3 l9_4723=float3(0.0);
l9_4723=l9_4066;
float3 l9_4724=float3(0.0);
l9_4724=l9_4723;
float3 l9_4725=float3(0.0);
l9_4725=-l9_3402.ViewDirWS;
float l9_4726=0.0;
l9_4726=dot(l9_4724,l9_4725);
float l9_4727=0.0;
l9_4727=abs(l9_4726);
float l9_4728=0.0;
l9_4728=1.0-l9_4727;
l9_3401=l9_4728;
l9_3403=l9_3401;
}
l9_3399=l9_3403;
float l9_4729=0.0;
float l9_4730=(*sc_set2.UserUniforms).rimExponent;
l9_4729=l9_4730;
float l9_4731=0.0;
l9_4731=l9_4729;
float l9_4732=0.0;
float l9_4733;
if (l9_3399<=0.0)
{
l9_4733=0.0;
}
else
{
l9_4733=pow(l9_3399,l9_4731);
}
l9_4732=l9_4733;
float3 l9_4734=float3(0.0);
l9_4734=l9_3395*float3(l9_4732);
param_12=l9_4734;
param_14=param_12;
}
else
{
param_14=param_13;
}
Result_N173=param_14;
float3 Export_N347=float3(0.0);
Export_N347=Result_N173;
float3 Value_N306=float3(0.0);
Value_N306=Export_N347;
float3 Output_N299=float3(0.0);
Output_N299=(Result_N97+Value_N298)+Value_N306;
float3 Output_N251=float3(0.0);
float3 param_16=Output_N299;
float3 l9_4735;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_4735=float3(pow(param_16.x,0.45454544),pow(param_16.y,0.45454544),pow(param_16.z,0.45454544));
}
else
{
l9_4735=sqrt(param_16);
}
float3 l9_4736=l9_4735;
Output_N251=l9_4736;
float3 Export_N300=float3(0.0);
Export_N300=Output_N251;
float3 Output_N1=float3(0.0);
Output_N1=Export_N364.xyz+Export_N300;
float4 Output_N5=float4(0.0);
float4 param_17=(*sc_set2.UserUniforms).baseColor;
Output_N5=param_17;
float4 Value_N384=float4(0.0);
Value_N384=Output_N5;
float4 Result_N369=float4(0.0);
float4 param_18=float4(0.0);
float4 param_19=(*sc_set2.UserUniforms).Port_Default_N369;
ssGlobals param_21=Globals;
float4 param_20;
if ((int(ENABLE_BASE_TEX_tmp)!=0))
{
float2 l9_4737=float2(0.0);
float2 l9_4738=float2(0.0);
float2 l9_4739=float2(0.0);
float2 l9_4740=float2(0.0);
float2 l9_4741=float2(0.0);
float2 l9_4742=float2(0.0);
ssGlobals l9_4743=param_21;
float2 l9_4744;
if (NODE_27_DROPLIST_ITEM_tmp==0)
{
float2 l9_4745=float2(0.0);
l9_4745=l9_4743.Surface_UVCoord0;
l9_4738=l9_4745;
l9_4744=l9_4738;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==1)
{
float2 l9_4746=float2(0.0);
l9_4746=l9_4743.Surface_UVCoord1;
l9_4739=l9_4746;
l9_4744=l9_4739;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==2)
{
float2 l9_4747=float2(0.0);
float2 l9_4748=float2(0.0);
float2 l9_4749=float2(0.0);
ssGlobals l9_4750=l9_4743;
float2 l9_4751;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4752=float2(0.0);
float2 l9_4753=float2(0.0);
float2 l9_4754=float2(0.0);
ssGlobals l9_4755=l9_4750;
float2 l9_4756;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4757=float2(0.0);
float2 l9_4758=float2(0.0);
float2 l9_4759=float2(0.0);
float2 l9_4760=float2(0.0);
float2 l9_4761=float2(0.0);
ssGlobals l9_4762=l9_4755;
float2 l9_4763;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4764=float2(0.0);
l9_4764=l9_4762.Surface_UVCoord0;
l9_4758=l9_4764;
l9_4763=l9_4758;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4765=float2(0.0);
l9_4765=l9_4762.Surface_UVCoord1;
l9_4759=l9_4765;
l9_4763=l9_4759;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4766=float2(0.0);
l9_4766=l9_4762.gScreenCoord;
l9_4760=l9_4766;
l9_4763=l9_4760;
}
else
{
float2 l9_4767=float2(0.0);
l9_4767=l9_4762.Surface_UVCoord0;
l9_4761=l9_4767;
l9_4763=l9_4761;
}
}
}
l9_4757=l9_4763;
float2 l9_4768=float2(0.0);
float2 l9_4769=(*sc_set2.UserUniforms).uv2Scale;
l9_4768=l9_4769;
float2 l9_4770=float2(0.0);
l9_4770=l9_4768;
float2 l9_4771=float2(0.0);
float2 l9_4772=(*sc_set2.UserUniforms).uv2Offset;
l9_4771=l9_4772;
float2 l9_4773=float2(0.0);
l9_4773=l9_4771;
float2 l9_4774=float2(0.0);
l9_4774=(l9_4757*l9_4770)+l9_4773;
float2 l9_4775=float2(0.0);
l9_4775=l9_4774+(l9_4773*(l9_4755.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4753=l9_4775;
l9_4756=l9_4753;
}
else
{
float2 l9_4776=float2(0.0);
float2 l9_4777=float2(0.0);
float2 l9_4778=float2(0.0);
float2 l9_4779=float2(0.0);
float2 l9_4780=float2(0.0);
ssGlobals l9_4781=l9_4755;
float2 l9_4782;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4783=float2(0.0);
l9_4783=l9_4781.Surface_UVCoord0;
l9_4777=l9_4783;
l9_4782=l9_4777;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4784=float2(0.0);
l9_4784=l9_4781.Surface_UVCoord1;
l9_4778=l9_4784;
l9_4782=l9_4778;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4785=float2(0.0);
l9_4785=l9_4781.gScreenCoord;
l9_4779=l9_4785;
l9_4782=l9_4779;
}
else
{
float2 l9_4786=float2(0.0);
l9_4786=l9_4781.Surface_UVCoord0;
l9_4780=l9_4786;
l9_4782=l9_4780;
}
}
}
l9_4776=l9_4782;
float2 l9_4787=float2(0.0);
float2 l9_4788=(*sc_set2.UserUniforms).uv2Scale;
l9_4787=l9_4788;
float2 l9_4789=float2(0.0);
l9_4789=l9_4787;
float2 l9_4790=float2(0.0);
float2 l9_4791=(*sc_set2.UserUniforms).uv2Offset;
l9_4790=l9_4791;
float2 l9_4792=float2(0.0);
l9_4792=l9_4790;
float2 l9_4793=float2(0.0);
l9_4793=(l9_4776*l9_4789)+l9_4792;
l9_4754=l9_4793;
l9_4756=l9_4754;
}
l9_4752=l9_4756;
l9_4748=l9_4752;
l9_4751=l9_4748;
}
else
{
float2 l9_4794=float2(0.0);
l9_4794=l9_4750.Surface_UVCoord0;
l9_4749=l9_4794;
l9_4751=l9_4749;
}
l9_4747=l9_4751;
float2 l9_4795=float2(0.0);
l9_4795=l9_4747;
float2 l9_4796=float2(0.0);
l9_4796=l9_4795;
l9_4740=l9_4796;
l9_4744=l9_4740;
}
else
{
if (NODE_27_DROPLIST_ITEM_tmp==3)
{
float2 l9_4797=float2(0.0);
float2 l9_4798=float2(0.0);
float2 l9_4799=float2(0.0);
ssGlobals l9_4800=l9_4743;
float2 l9_4801;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_4802=float2(0.0);
float2 l9_4803=float2(0.0);
float2 l9_4804=float2(0.0);
ssGlobals l9_4805=l9_4800;
float2 l9_4806;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_4807=float2(0.0);
float2 l9_4808=float2(0.0);
float2 l9_4809=float2(0.0);
float2 l9_4810=float2(0.0);
float2 l9_4811=float2(0.0);
float2 l9_4812=float2(0.0);
ssGlobals l9_4813=l9_4805;
float2 l9_4814;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_4815=float2(0.0);
l9_4815=l9_4813.Surface_UVCoord0;
l9_4808=l9_4815;
l9_4814=l9_4808;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_4816=float2(0.0);
l9_4816=l9_4813.Surface_UVCoord1;
l9_4809=l9_4816;
l9_4814=l9_4809;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_4817=float2(0.0);
l9_4817=l9_4813.gScreenCoord;
l9_4810=l9_4817;
l9_4814=l9_4810;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_4818=float2(0.0);
float2 l9_4819=float2(0.0);
float2 l9_4820=float2(0.0);
ssGlobals l9_4821=l9_4813;
float2 l9_4822;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4823=float2(0.0);
float2 l9_4824=float2(0.0);
float2 l9_4825=float2(0.0);
ssGlobals l9_4826=l9_4821;
float2 l9_4827;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4828=float2(0.0);
float2 l9_4829=float2(0.0);
float2 l9_4830=float2(0.0);
float2 l9_4831=float2(0.0);
float2 l9_4832=float2(0.0);
ssGlobals l9_4833=l9_4826;
float2 l9_4834;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4835=float2(0.0);
l9_4835=l9_4833.Surface_UVCoord0;
l9_4829=l9_4835;
l9_4834=l9_4829;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4836=float2(0.0);
l9_4836=l9_4833.Surface_UVCoord1;
l9_4830=l9_4836;
l9_4834=l9_4830;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4837=float2(0.0);
l9_4837=l9_4833.gScreenCoord;
l9_4831=l9_4837;
l9_4834=l9_4831;
}
else
{
float2 l9_4838=float2(0.0);
l9_4838=l9_4833.Surface_UVCoord0;
l9_4832=l9_4838;
l9_4834=l9_4832;
}
}
}
l9_4828=l9_4834;
float2 l9_4839=float2(0.0);
float2 l9_4840=(*sc_set2.UserUniforms).uv2Scale;
l9_4839=l9_4840;
float2 l9_4841=float2(0.0);
l9_4841=l9_4839;
float2 l9_4842=float2(0.0);
float2 l9_4843=(*sc_set2.UserUniforms).uv2Offset;
l9_4842=l9_4843;
float2 l9_4844=float2(0.0);
l9_4844=l9_4842;
float2 l9_4845=float2(0.0);
l9_4845=(l9_4828*l9_4841)+l9_4844;
float2 l9_4846=float2(0.0);
l9_4846=l9_4845+(l9_4844*(l9_4826.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4824=l9_4846;
l9_4827=l9_4824;
}
else
{
float2 l9_4847=float2(0.0);
float2 l9_4848=float2(0.0);
float2 l9_4849=float2(0.0);
float2 l9_4850=float2(0.0);
float2 l9_4851=float2(0.0);
ssGlobals l9_4852=l9_4826;
float2 l9_4853;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4854=float2(0.0);
l9_4854=l9_4852.Surface_UVCoord0;
l9_4848=l9_4854;
l9_4853=l9_4848;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4855=float2(0.0);
l9_4855=l9_4852.Surface_UVCoord1;
l9_4849=l9_4855;
l9_4853=l9_4849;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4856=float2(0.0);
l9_4856=l9_4852.gScreenCoord;
l9_4850=l9_4856;
l9_4853=l9_4850;
}
else
{
float2 l9_4857=float2(0.0);
l9_4857=l9_4852.Surface_UVCoord0;
l9_4851=l9_4857;
l9_4853=l9_4851;
}
}
}
l9_4847=l9_4853;
float2 l9_4858=float2(0.0);
float2 l9_4859=(*sc_set2.UserUniforms).uv2Scale;
l9_4858=l9_4859;
float2 l9_4860=float2(0.0);
l9_4860=l9_4858;
float2 l9_4861=float2(0.0);
float2 l9_4862=(*sc_set2.UserUniforms).uv2Offset;
l9_4861=l9_4862;
float2 l9_4863=float2(0.0);
l9_4863=l9_4861;
float2 l9_4864=float2(0.0);
l9_4864=(l9_4847*l9_4860)+l9_4863;
l9_4825=l9_4864;
l9_4827=l9_4825;
}
l9_4823=l9_4827;
l9_4819=l9_4823;
l9_4822=l9_4819;
}
else
{
float2 l9_4865=float2(0.0);
l9_4865=l9_4821.Surface_UVCoord0;
l9_4820=l9_4865;
l9_4822=l9_4820;
}
l9_4818=l9_4822;
float2 l9_4866=float2(0.0);
l9_4866=l9_4818;
float2 l9_4867=float2(0.0);
l9_4867=l9_4866;
l9_4811=l9_4867;
l9_4814=l9_4811;
}
else
{
float2 l9_4868=float2(0.0);
l9_4868=l9_4813.Surface_UVCoord0;
l9_4812=l9_4868;
l9_4814=l9_4812;
}
}
}
}
l9_4807=l9_4814;
float2 l9_4869=float2(0.0);
float2 l9_4870=(*sc_set2.UserUniforms).uv3Scale;
l9_4869=l9_4870;
float2 l9_4871=float2(0.0);
l9_4871=l9_4869;
float2 l9_4872=float2(0.0);
float2 l9_4873=(*sc_set2.UserUniforms).uv3Offset;
l9_4872=l9_4873;
float2 l9_4874=float2(0.0);
l9_4874=l9_4872;
float2 l9_4875=float2(0.0);
l9_4875=(l9_4807*l9_4871)+l9_4874;
float2 l9_4876=float2(0.0);
l9_4876=l9_4875+(l9_4874*(l9_4805.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_4803=l9_4876;
l9_4806=l9_4803;
}
else
{
float2 l9_4877=float2(0.0);
float2 l9_4878=float2(0.0);
float2 l9_4879=float2(0.0);
float2 l9_4880=float2(0.0);
float2 l9_4881=float2(0.0);
float2 l9_4882=float2(0.0);
ssGlobals l9_4883=l9_4805;
float2 l9_4884;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_4885=float2(0.0);
l9_4885=l9_4883.Surface_UVCoord0;
l9_4878=l9_4885;
l9_4884=l9_4878;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_4886=float2(0.0);
l9_4886=l9_4883.Surface_UVCoord1;
l9_4879=l9_4886;
l9_4884=l9_4879;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_4887=float2(0.0);
l9_4887=l9_4883.gScreenCoord;
l9_4880=l9_4887;
l9_4884=l9_4880;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_4888=float2(0.0);
float2 l9_4889=float2(0.0);
float2 l9_4890=float2(0.0);
ssGlobals l9_4891=l9_4883;
float2 l9_4892;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_4893=float2(0.0);
float2 l9_4894=float2(0.0);
float2 l9_4895=float2(0.0);
ssGlobals l9_4896=l9_4891;
float2 l9_4897;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_4898=float2(0.0);
float2 l9_4899=float2(0.0);
float2 l9_4900=float2(0.0);
float2 l9_4901=float2(0.0);
float2 l9_4902=float2(0.0);
ssGlobals l9_4903=l9_4896;
float2 l9_4904;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4905=float2(0.0);
l9_4905=l9_4903.Surface_UVCoord0;
l9_4899=l9_4905;
l9_4904=l9_4899;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4906=float2(0.0);
l9_4906=l9_4903.Surface_UVCoord1;
l9_4900=l9_4906;
l9_4904=l9_4900;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4907=float2(0.0);
l9_4907=l9_4903.gScreenCoord;
l9_4901=l9_4907;
l9_4904=l9_4901;
}
else
{
float2 l9_4908=float2(0.0);
l9_4908=l9_4903.Surface_UVCoord0;
l9_4902=l9_4908;
l9_4904=l9_4902;
}
}
}
l9_4898=l9_4904;
float2 l9_4909=float2(0.0);
float2 l9_4910=(*sc_set2.UserUniforms).uv2Scale;
l9_4909=l9_4910;
float2 l9_4911=float2(0.0);
l9_4911=l9_4909;
float2 l9_4912=float2(0.0);
float2 l9_4913=(*sc_set2.UserUniforms).uv2Offset;
l9_4912=l9_4913;
float2 l9_4914=float2(0.0);
l9_4914=l9_4912;
float2 l9_4915=float2(0.0);
l9_4915=(l9_4898*l9_4911)+l9_4914;
float2 l9_4916=float2(0.0);
l9_4916=l9_4915+(l9_4914*(l9_4896.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_4894=l9_4916;
l9_4897=l9_4894;
}
else
{
float2 l9_4917=float2(0.0);
float2 l9_4918=float2(0.0);
float2 l9_4919=float2(0.0);
float2 l9_4920=float2(0.0);
float2 l9_4921=float2(0.0);
ssGlobals l9_4922=l9_4896;
float2 l9_4923;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_4924=float2(0.0);
l9_4924=l9_4922.Surface_UVCoord0;
l9_4918=l9_4924;
l9_4923=l9_4918;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_4925=float2(0.0);
l9_4925=l9_4922.Surface_UVCoord1;
l9_4919=l9_4925;
l9_4923=l9_4919;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_4926=float2(0.0);
l9_4926=l9_4922.gScreenCoord;
l9_4920=l9_4926;
l9_4923=l9_4920;
}
else
{
float2 l9_4927=float2(0.0);
l9_4927=l9_4922.Surface_UVCoord0;
l9_4921=l9_4927;
l9_4923=l9_4921;
}
}
}
l9_4917=l9_4923;
float2 l9_4928=float2(0.0);
float2 l9_4929=(*sc_set2.UserUniforms).uv2Scale;
l9_4928=l9_4929;
float2 l9_4930=float2(0.0);
l9_4930=l9_4928;
float2 l9_4931=float2(0.0);
float2 l9_4932=(*sc_set2.UserUniforms).uv2Offset;
l9_4931=l9_4932;
float2 l9_4933=float2(0.0);
l9_4933=l9_4931;
float2 l9_4934=float2(0.0);
l9_4934=(l9_4917*l9_4930)+l9_4933;
l9_4895=l9_4934;
l9_4897=l9_4895;
}
l9_4893=l9_4897;
l9_4889=l9_4893;
l9_4892=l9_4889;
}
else
{
float2 l9_4935=float2(0.0);
l9_4935=l9_4891.Surface_UVCoord0;
l9_4890=l9_4935;
l9_4892=l9_4890;
}
l9_4888=l9_4892;
float2 l9_4936=float2(0.0);
l9_4936=l9_4888;
float2 l9_4937=float2(0.0);
l9_4937=l9_4936;
l9_4881=l9_4937;
l9_4884=l9_4881;
}
else
{
float2 l9_4938=float2(0.0);
l9_4938=l9_4883.Surface_UVCoord0;
l9_4882=l9_4938;
l9_4884=l9_4882;
}
}
}
}
l9_4877=l9_4884;
float2 l9_4939=float2(0.0);
float2 l9_4940=(*sc_set2.UserUniforms).uv3Scale;
l9_4939=l9_4940;
float2 l9_4941=float2(0.0);
l9_4941=l9_4939;
float2 l9_4942=float2(0.0);
float2 l9_4943=(*sc_set2.UserUniforms).uv3Offset;
l9_4942=l9_4943;
float2 l9_4944=float2(0.0);
l9_4944=l9_4942;
float2 l9_4945=float2(0.0);
l9_4945=(l9_4877*l9_4941)+l9_4944;
l9_4804=l9_4945;
l9_4806=l9_4804;
}
l9_4802=l9_4806;
l9_4798=l9_4802;
l9_4801=l9_4798;
}
else
{
float2 l9_4946=float2(0.0);
l9_4946=l9_4800.Surface_UVCoord0;
l9_4799=l9_4946;
l9_4801=l9_4799;
}
l9_4797=l9_4801;
float2 l9_4947=float2(0.0);
l9_4947=l9_4797;
float2 l9_4948=float2(0.0);
l9_4948=l9_4947;
l9_4741=l9_4948;
l9_4744=l9_4741;
}
else
{
float2 l9_4949=float2(0.0);
l9_4949=l9_4743.Surface_UVCoord0;
l9_4742=l9_4949;
l9_4744=l9_4742;
}
}
}
}
l9_4737=l9_4744;
float4 l9_4950=float4(0.0);
int l9_4951=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_4952=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4952=0;
}
else
{
l9_4952=in.varStereoViewID;
}
int l9_4953=l9_4952;
l9_4951=1-l9_4953;
}
else
{
int l9_4954=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4954=0;
}
else
{
l9_4954=in.varStereoViewID;
}
int l9_4955=l9_4954;
l9_4951=l9_4955;
}
int l9_4956=l9_4951;
int l9_4957=baseTexLayout_tmp;
int l9_4958=l9_4956;
float2 l9_4959=l9_4737;
bool l9_4960=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_4961=(*sc_set2.UserUniforms).baseTexTransform;
int2 l9_4962=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_4963=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_4964=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool l9_4965=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_4966=(*sc_set2.UserUniforms).baseTexBorderColor;
float l9_4967=0.0;
bool l9_4968=l9_4965&&(!l9_4963);
float l9_4969=1.0;
float l9_4970=l9_4959.x;
int l9_4971=l9_4962.x;
if (l9_4971==1)
{
l9_4970=fract(l9_4970);
}
else
{
if (l9_4971==2)
{
float l9_4972=fract(l9_4970);
float l9_4973=l9_4970-l9_4972;
float l9_4974=step(0.25,fract(l9_4973*0.5));
l9_4970=mix(l9_4972,1.0-l9_4972,fast::clamp(l9_4974,0.0,1.0));
}
}
l9_4959.x=l9_4970;
float l9_4975=l9_4959.y;
int l9_4976=l9_4962.y;
if (l9_4976==1)
{
l9_4975=fract(l9_4975);
}
else
{
if (l9_4976==2)
{
float l9_4977=fract(l9_4975);
float l9_4978=l9_4975-l9_4977;
float l9_4979=step(0.25,fract(l9_4978*0.5));
l9_4975=mix(l9_4977,1.0-l9_4977,fast::clamp(l9_4979,0.0,1.0));
}
}
l9_4959.y=l9_4975;
if (l9_4963)
{
bool l9_4980=l9_4965;
bool l9_4981;
if (l9_4980)
{
l9_4981=l9_4962.x==3;
}
else
{
l9_4981=l9_4980;
}
float l9_4982=l9_4959.x;
float l9_4983=l9_4964.x;
float l9_4984=l9_4964.z;
bool l9_4985=l9_4981;
float l9_4986=l9_4969;
float l9_4987=fast::clamp(l9_4982,l9_4983,l9_4984);
float l9_4988=step(abs(l9_4982-l9_4987),9.9999997e-06);
l9_4986*=(l9_4988+((1.0-float(l9_4985))*(1.0-l9_4988)));
l9_4982=l9_4987;
l9_4959.x=l9_4982;
l9_4969=l9_4986;
bool l9_4989=l9_4965;
bool l9_4990;
if (l9_4989)
{
l9_4990=l9_4962.y==3;
}
else
{
l9_4990=l9_4989;
}
float l9_4991=l9_4959.y;
float l9_4992=l9_4964.y;
float l9_4993=l9_4964.w;
bool l9_4994=l9_4990;
float l9_4995=l9_4969;
float l9_4996=fast::clamp(l9_4991,l9_4992,l9_4993);
float l9_4997=step(abs(l9_4991-l9_4996),9.9999997e-06);
l9_4995*=(l9_4997+((1.0-float(l9_4994))*(1.0-l9_4997)));
l9_4991=l9_4996;
l9_4959.y=l9_4991;
l9_4969=l9_4995;
}
float2 l9_4998=l9_4959;
bool l9_4999=l9_4960;
float3x3 l9_5000=l9_4961;
if (l9_4999)
{
l9_4998=float2((l9_5000*float3(l9_4998,1.0)).xy);
}
float2 l9_5001=l9_4998;
float2 l9_5002=l9_5001;
float2 l9_5003=l9_5002;
l9_4959=l9_5003;
float l9_5004=l9_4959.x;
int l9_5005=l9_4962.x;
bool l9_5006=l9_4968;
float l9_5007=l9_4969;
if ((l9_5005==0)||(l9_5005==3))
{
float l9_5008=l9_5004;
float l9_5009=0.0;
float l9_5010=1.0;
bool l9_5011=l9_5006;
float l9_5012=l9_5007;
float l9_5013=fast::clamp(l9_5008,l9_5009,l9_5010);
float l9_5014=step(abs(l9_5008-l9_5013),9.9999997e-06);
l9_5012*=(l9_5014+((1.0-float(l9_5011))*(1.0-l9_5014)));
l9_5008=l9_5013;
l9_5004=l9_5008;
l9_5007=l9_5012;
}
l9_4959.x=l9_5004;
l9_4969=l9_5007;
float l9_5015=l9_4959.y;
int l9_5016=l9_4962.y;
bool l9_5017=l9_4968;
float l9_5018=l9_4969;
if ((l9_5016==0)||(l9_5016==3))
{
float l9_5019=l9_5015;
float l9_5020=0.0;
float l9_5021=1.0;
bool l9_5022=l9_5017;
float l9_5023=l9_5018;
float l9_5024=fast::clamp(l9_5019,l9_5020,l9_5021);
float l9_5025=step(abs(l9_5019-l9_5024),9.9999997e-06);
l9_5023*=(l9_5025+((1.0-float(l9_5022))*(1.0-l9_5025)));
l9_5019=l9_5024;
l9_5015=l9_5019;
l9_5018=l9_5023;
}
l9_4959.y=l9_5015;
l9_4969=l9_5018;
float2 l9_5026=l9_4959;
int l9_5027=l9_4957;
int l9_5028=l9_4958;
float l9_5029=l9_4967;
float2 l9_5030=l9_5026;
int l9_5031=l9_5027;
int l9_5032=l9_5028;
float3 l9_5033=float3(0.0);
if (l9_5031==0)
{
l9_5033=float3(l9_5030,0.0);
}
else
{
if (l9_5031==1)
{
l9_5033=float3(l9_5030.x,(l9_5030.y*0.5)+(0.5-(float(l9_5032)*0.5)),0.0);
}
else
{
l9_5033=float3(l9_5030,float(l9_5032));
}
}
float3 l9_5034=l9_5033;
float3 l9_5035=l9_5034;
float2 l9_5036=l9_5035.xy;
float l9_5037=l9_5029;
float4 l9_5038=sc_set2.baseTex.sample(sc_set2.baseTexSmpSC,l9_5036,bias(l9_5037));
float4 l9_5039=l9_5038;
float4 l9_5040=l9_5039;
if (l9_4965)
{
l9_5040=mix(l9_4966,l9_5040,float4(l9_4969));
}
float4 l9_5041=l9_5040;
l9_4950=l9_5041;
param_18=l9_4950;
param_20=param_18;
}
else
{
param_20=param_19;
}
Result_N369=param_20;
float4 Output_N148=float4(0.0);
Output_N148=Value_N384*Result_N369;
float4 Export_N385=float4(0.0);
Export_N385=Output_N148;
float4 Value_N166=float4(0.0);
Value_N166=Export_N385;
float Output_N168=0.0;
Output_N168=Value_N166.w;
float Result_N204=0.0;
float param_22=0.0;
float param_23=(*sc_set2.UserUniforms).Port_Default_N204;
ssGlobals param_25=Globals;
float param_24;
if ((int(ENABLE_OPACITY_TEX_tmp)!=0))
{
float2 l9_5042=float2(0.0);
float2 l9_5043=float2(0.0);
float2 l9_5044=float2(0.0);
float2 l9_5045=float2(0.0);
float2 l9_5046=float2(0.0);
float2 l9_5047=float2(0.0);
ssGlobals l9_5048=param_25;
float2 l9_5049;
if (NODE_69_DROPLIST_ITEM_tmp==0)
{
float2 l9_5050=float2(0.0);
l9_5050=l9_5048.Surface_UVCoord0;
l9_5043=l9_5050;
l9_5049=l9_5043;
}
else
{
if (NODE_69_DROPLIST_ITEM_tmp==1)
{
float2 l9_5051=float2(0.0);
l9_5051=l9_5048.Surface_UVCoord1;
l9_5044=l9_5051;
l9_5049=l9_5044;
}
else
{
if (NODE_69_DROPLIST_ITEM_tmp==2)
{
float2 l9_5052=float2(0.0);
float2 l9_5053=float2(0.0);
float2 l9_5054=float2(0.0);
ssGlobals l9_5055=l9_5048;
float2 l9_5056;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_5057=float2(0.0);
float2 l9_5058=float2(0.0);
float2 l9_5059=float2(0.0);
ssGlobals l9_5060=l9_5055;
float2 l9_5061;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_5062=float2(0.0);
float2 l9_5063=float2(0.0);
float2 l9_5064=float2(0.0);
float2 l9_5065=float2(0.0);
float2 l9_5066=float2(0.0);
ssGlobals l9_5067=l9_5060;
float2 l9_5068;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_5069=float2(0.0);
l9_5069=l9_5067.Surface_UVCoord0;
l9_5063=l9_5069;
l9_5068=l9_5063;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_5070=float2(0.0);
l9_5070=l9_5067.Surface_UVCoord1;
l9_5064=l9_5070;
l9_5068=l9_5064;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_5071=float2(0.0);
l9_5071=l9_5067.gScreenCoord;
l9_5065=l9_5071;
l9_5068=l9_5065;
}
else
{
float2 l9_5072=float2(0.0);
l9_5072=l9_5067.Surface_UVCoord0;
l9_5066=l9_5072;
l9_5068=l9_5066;
}
}
}
l9_5062=l9_5068;
float2 l9_5073=float2(0.0);
float2 l9_5074=(*sc_set2.UserUniforms).uv2Scale;
l9_5073=l9_5074;
float2 l9_5075=float2(0.0);
l9_5075=l9_5073;
float2 l9_5076=float2(0.0);
float2 l9_5077=(*sc_set2.UserUniforms).uv2Offset;
l9_5076=l9_5077;
float2 l9_5078=float2(0.0);
l9_5078=l9_5076;
float2 l9_5079=float2(0.0);
l9_5079=(l9_5062*l9_5075)+l9_5078;
float2 l9_5080=float2(0.0);
l9_5080=l9_5079+(l9_5078*(l9_5060.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_5058=l9_5080;
l9_5061=l9_5058;
}
else
{
float2 l9_5081=float2(0.0);
float2 l9_5082=float2(0.0);
float2 l9_5083=float2(0.0);
float2 l9_5084=float2(0.0);
float2 l9_5085=float2(0.0);
ssGlobals l9_5086=l9_5060;
float2 l9_5087;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_5088=float2(0.0);
l9_5088=l9_5086.Surface_UVCoord0;
l9_5082=l9_5088;
l9_5087=l9_5082;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_5089=float2(0.0);
l9_5089=l9_5086.Surface_UVCoord1;
l9_5083=l9_5089;
l9_5087=l9_5083;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_5090=float2(0.0);
l9_5090=l9_5086.gScreenCoord;
l9_5084=l9_5090;
l9_5087=l9_5084;
}
else
{
float2 l9_5091=float2(0.0);
l9_5091=l9_5086.Surface_UVCoord0;
l9_5085=l9_5091;
l9_5087=l9_5085;
}
}
}
l9_5081=l9_5087;
float2 l9_5092=float2(0.0);
float2 l9_5093=(*sc_set2.UserUniforms).uv2Scale;
l9_5092=l9_5093;
float2 l9_5094=float2(0.0);
l9_5094=l9_5092;
float2 l9_5095=float2(0.0);
float2 l9_5096=(*sc_set2.UserUniforms).uv2Offset;
l9_5095=l9_5096;
float2 l9_5097=float2(0.0);
l9_5097=l9_5095;
float2 l9_5098=float2(0.0);
l9_5098=(l9_5081*l9_5094)+l9_5097;
l9_5059=l9_5098;
l9_5061=l9_5059;
}
l9_5057=l9_5061;
l9_5053=l9_5057;
l9_5056=l9_5053;
}
else
{
float2 l9_5099=float2(0.0);
l9_5099=l9_5055.Surface_UVCoord0;
l9_5054=l9_5099;
l9_5056=l9_5054;
}
l9_5052=l9_5056;
float2 l9_5100=float2(0.0);
l9_5100=l9_5052;
float2 l9_5101=float2(0.0);
l9_5101=l9_5100;
l9_5045=l9_5101;
l9_5049=l9_5045;
}
else
{
if (NODE_69_DROPLIST_ITEM_tmp==3)
{
float2 l9_5102=float2(0.0);
float2 l9_5103=float2(0.0);
float2 l9_5104=float2(0.0);
ssGlobals l9_5105=l9_5048;
float2 l9_5106;
if ((int(ENABLE_UV3_tmp)!=0))
{
float2 l9_5107=float2(0.0);
float2 l9_5108=float2(0.0);
float2 l9_5109=float2(0.0);
ssGlobals l9_5110=l9_5105;
float2 l9_5111;
if ((int(ENABLE_UV3_ANIMATION_tmp)!=0))
{
float2 l9_5112=float2(0.0);
float2 l9_5113=float2(0.0);
float2 l9_5114=float2(0.0);
float2 l9_5115=float2(0.0);
float2 l9_5116=float2(0.0);
float2 l9_5117=float2(0.0);
ssGlobals l9_5118=l9_5110;
float2 l9_5119;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_5120=float2(0.0);
l9_5120=l9_5118.Surface_UVCoord0;
l9_5113=l9_5120;
l9_5119=l9_5113;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_5121=float2(0.0);
l9_5121=l9_5118.Surface_UVCoord1;
l9_5114=l9_5121;
l9_5119=l9_5114;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_5122=float2(0.0);
l9_5122=l9_5118.gScreenCoord;
l9_5115=l9_5122;
l9_5119=l9_5115;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_5123=float2(0.0);
float2 l9_5124=float2(0.0);
float2 l9_5125=float2(0.0);
ssGlobals l9_5126=l9_5118;
float2 l9_5127;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_5128=float2(0.0);
float2 l9_5129=float2(0.0);
float2 l9_5130=float2(0.0);
ssGlobals l9_5131=l9_5126;
float2 l9_5132;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_5133=float2(0.0);
float2 l9_5134=float2(0.0);
float2 l9_5135=float2(0.0);
float2 l9_5136=float2(0.0);
float2 l9_5137=float2(0.0);
ssGlobals l9_5138=l9_5131;
float2 l9_5139;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_5140=float2(0.0);
l9_5140=l9_5138.Surface_UVCoord0;
l9_5134=l9_5140;
l9_5139=l9_5134;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_5141=float2(0.0);
l9_5141=l9_5138.Surface_UVCoord1;
l9_5135=l9_5141;
l9_5139=l9_5135;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_5142=float2(0.0);
l9_5142=l9_5138.gScreenCoord;
l9_5136=l9_5142;
l9_5139=l9_5136;
}
else
{
float2 l9_5143=float2(0.0);
l9_5143=l9_5138.Surface_UVCoord0;
l9_5137=l9_5143;
l9_5139=l9_5137;
}
}
}
l9_5133=l9_5139;
float2 l9_5144=float2(0.0);
float2 l9_5145=(*sc_set2.UserUniforms).uv2Scale;
l9_5144=l9_5145;
float2 l9_5146=float2(0.0);
l9_5146=l9_5144;
float2 l9_5147=float2(0.0);
float2 l9_5148=(*sc_set2.UserUniforms).uv2Offset;
l9_5147=l9_5148;
float2 l9_5149=float2(0.0);
l9_5149=l9_5147;
float2 l9_5150=float2(0.0);
l9_5150=(l9_5133*l9_5146)+l9_5149;
float2 l9_5151=float2(0.0);
l9_5151=l9_5150+(l9_5149*(l9_5131.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_5129=l9_5151;
l9_5132=l9_5129;
}
else
{
float2 l9_5152=float2(0.0);
float2 l9_5153=float2(0.0);
float2 l9_5154=float2(0.0);
float2 l9_5155=float2(0.0);
float2 l9_5156=float2(0.0);
ssGlobals l9_5157=l9_5131;
float2 l9_5158;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_5159=float2(0.0);
l9_5159=l9_5157.Surface_UVCoord0;
l9_5153=l9_5159;
l9_5158=l9_5153;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_5160=float2(0.0);
l9_5160=l9_5157.Surface_UVCoord1;
l9_5154=l9_5160;
l9_5158=l9_5154;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_5161=float2(0.0);
l9_5161=l9_5157.gScreenCoord;
l9_5155=l9_5161;
l9_5158=l9_5155;
}
else
{
float2 l9_5162=float2(0.0);
l9_5162=l9_5157.Surface_UVCoord0;
l9_5156=l9_5162;
l9_5158=l9_5156;
}
}
}
l9_5152=l9_5158;
float2 l9_5163=float2(0.0);
float2 l9_5164=(*sc_set2.UserUniforms).uv2Scale;
l9_5163=l9_5164;
float2 l9_5165=float2(0.0);
l9_5165=l9_5163;
float2 l9_5166=float2(0.0);
float2 l9_5167=(*sc_set2.UserUniforms).uv2Offset;
l9_5166=l9_5167;
float2 l9_5168=float2(0.0);
l9_5168=l9_5166;
float2 l9_5169=float2(0.0);
l9_5169=(l9_5152*l9_5165)+l9_5168;
l9_5130=l9_5169;
l9_5132=l9_5130;
}
l9_5128=l9_5132;
l9_5124=l9_5128;
l9_5127=l9_5124;
}
else
{
float2 l9_5170=float2(0.0);
l9_5170=l9_5126.Surface_UVCoord0;
l9_5125=l9_5170;
l9_5127=l9_5125;
}
l9_5123=l9_5127;
float2 l9_5171=float2(0.0);
l9_5171=l9_5123;
float2 l9_5172=float2(0.0);
l9_5172=l9_5171;
l9_5116=l9_5172;
l9_5119=l9_5116;
}
else
{
float2 l9_5173=float2(0.0);
l9_5173=l9_5118.Surface_UVCoord0;
l9_5117=l9_5173;
l9_5119=l9_5117;
}
}
}
}
l9_5112=l9_5119;
float2 l9_5174=float2(0.0);
float2 l9_5175=(*sc_set2.UserUniforms).uv3Scale;
l9_5174=l9_5175;
float2 l9_5176=float2(0.0);
l9_5176=l9_5174;
float2 l9_5177=float2(0.0);
float2 l9_5178=(*sc_set2.UserUniforms).uv3Offset;
l9_5177=l9_5178;
float2 l9_5179=float2(0.0);
l9_5179=l9_5177;
float2 l9_5180=float2(0.0);
l9_5180=(l9_5112*l9_5176)+l9_5179;
float2 l9_5181=float2(0.0);
l9_5181=l9_5180+(l9_5179*(l9_5110.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N063));
l9_5108=l9_5181;
l9_5111=l9_5108;
}
else
{
float2 l9_5182=float2(0.0);
float2 l9_5183=float2(0.0);
float2 l9_5184=float2(0.0);
float2 l9_5185=float2(0.0);
float2 l9_5186=float2(0.0);
float2 l9_5187=float2(0.0);
ssGlobals l9_5188=l9_5110;
float2 l9_5189;
if (NODE_49_DROPLIST_ITEM_tmp==0)
{
float2 l9_5190=float2(0.0);
l9_5190=l9_5188.Surface_UVCoord0;
l9_5183=l9_5190;
l9_5189=l9_5183;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==1)
{
float2 l9_5191=float2(0.0);
l9_5191=l9_5188.Surface_UVCoord1;
l9_5184=l9_5191;
l9_5189=l9_5184;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==2)
{
float2 l9_5192=float2(0.0);
l9_5192=l9_5188.gScreenCoord;
l9_5185=l9_5192;
l9_5189=l9_5185;
}
else
{
if (NODE_49_DROPLIST_ITEM_tmp==3)
{
float2 l9_5193=float2(0.0);
float2 l9_5194=float2(0.0);
float2 l9_5195=float2(0.0);
ssGlobals l9_5196=l9_5188;
float2 l9_5197;
if ((int(ENABLE_UV2_tmp)!=0))
{
float2 l9_5198=float2(0.0);
float2 l9_5199=float2(0.0);
float2 l9_5200=float2(0.0);
ssGlobals l9_5201=l9_5196;
float2 l9_5202;
if ((int(ENABLE_UV2_ANIMATION_tmp)!=0))
{
float2 l9_5203=float2(0.0);
float2 l9_5204=float2(0.0);
float2 l9_5205=float2(0.0);
float2 l9_5206=float2(0.0);
float2 l9_5207=float2(0.0);
ssGlobals l9_5208=l9_5201;
float2 l9_5209;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_5210=float2(0.0);
l9_5210=l9_5208.Surface_UVCoord0;
l9_5204=l9_5210;
l9_5209=l9_5204;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_5211=float2(0.0);
l9_5211=l9_5208.Surface_UVCoord1;
l9_5205=l9_5211;
l9_5209=l9_5205;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_5212=float2(0.0);
l9_5212=l9_5208.gScreenCoord;
l9_5206=l9_5212;
l9_5209=l9_5206;
}
else
{
float2 l9_5213=float2(0.0);
l9_5213=l9_5208.Surface_UVCoord0;
l9_5207=l9_5213;
l9_5209=l9_5207;
}
}
}
l9_5203=l9_5209;
float2 l9_5214=float2(0.0);
float2 l9_5215=(*sc_set2.UserUniforms).uv2Scale;
l9_5214=l9_5215;
float2 l9_5216=float2(0.0);
l9_5216=l9_5214;
float2 l9_5217=float2(0.0);
float2 l9_5218=(*sc_set2.UserUniforms).uv2Offset;
l9_5217=l9_5218;
float2 l9_5219=float2(0.0);
l9_5219=l9_5217;
float2 l9_5220=float2(0.0);
l9_5220=(l9_5203*l9_5216)+l9_5219;
float2 l9_5221=float2(0.0);
l9_5221=l9_5220+(l9_5219*(l9_5201.gTimeElapsed*(*sc_set2.UserUniforms).Port_Speed_N022));
l9_5199=l9_5221;
l9_5202=l9_5199;
}
else
{
float2 l9_5222=float2(0.0);
float2 l9_5223=float2(0.0);
float2 l9_5224=float2(0.0);
float2 l9_5225=float2(0.0);
float2 l9_5226=float2(0.0);
ssGlobals l9_5227=l9_5201;
float2 l9_5228;
if (NODE_13_DROPLIST_ITEM_tmp==0)
{
float2 l9_5229=float2(0.0);
l9_5229=l9_5227.Surface_UVCoord0;
l9_5223=l9_5229;
l9_5228=l9_5223;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==1)
{
float2 l9_5230=float2(0.0);
l9_5230=l9_5227.Surface_UVCoord1;
l9_5224=l9_5230;
l9_5228=l9_5224;
}
else
{
if (NODE_13_DROPLIST_ITEM_tmp==2)
{
float2 l9_5231=float2(0.0);
l9_5231=l9_5227.gScreenCoord;
l9_5225=l9_5231;
l9_5228=l9_5225;
}
else
{
float2 l9_5232=float2(0.0);
l9_5232=l9_5227.Surface_UVCoord0;
l9_5226=l9_5232;
l9_5228=l9_5226;
}
}
}
l9_5222=l9_5228;
float2 l9_5233=float2(0.0);
float2 l9_5234=(*sc_set2.UserUniforms).uv2Scale;
l9_5233=l9_5234;
float2 l9_5235=float2(0.0);
l9_5235=l9_5233;
float2 l9_5236=float2(0.0);
float2 l9_5237=(*sc_set2.UserUniforms).uv2Offset;
l9_5236=l9_5237;
float2 l9_5238=float2(0.0);
l9_5238=l9_5236;
float2 l9_5239=float2(0.0);
l9_5239=(l9_5222*l9_5235)+l9_5238;
l9_5200=l9_5239;
l9_5202=l9_5200;
}
l9_5198=l9_5202;
l9_5194=l9_5198;
l9_5197=l9_5194;
}
else
{
float2 l9_5240=float2(0.0);
l9_5240=l9_5196.Surface_UVCoord0;
l9_5195=l9_5240;
l9_5197=l9_5195;
}
l9_5193=l9_5197;
float2 l9_5241=float2(0.0);
l9_5241=l9_5193;
float2 l9_5242=float2(0.0);
l9_5242=l9_5241;
l9_5186=l9_5242;
l9_5189=l9_5186;
}
else
{
float2 l9_5243=float2(0.0);
l9_5243=l9_5188.Surface_UVCoord0;
l9_5187=l9_5243;
l9_5189=l9_5187;
}
}
}
}
l9_5182=l9_5189;
float2 l9_5244=float2(0.0);
float2 l9_5245=(*sc_set2.UserUniforms).uv3Scale;
l9_5244=l9_5245;
float2 l9_5246=float2(0.0);
l9_5246=l9_5244;
float2 l9_5247=float2(0.0);
float2 l9_5248=(*sc_set2.UserUniforms).uv3Offset;
l9_5247=l9_5248;
float2 l9_5249=float2(0.0);
l9_5249=l9_5247;
float2 l9_5250=float2(0.0);
l9_5250=(l9_5182*l9_5246)+l9_5249;
l9_5109=l9_5250;
l9_5111=l9_5109;
}
l9_5107=l9_5111;
l9_5103=l9_5107;
l9_5106=l9_5103;
}
else
{
float2 l9_5251=float2(0.0);
l9_5251=l9_5105.Surface_UVCoord0;
l9_5104=l9_5251;
l9_5106=l9_5104;
}
l9_5102=l9_5106;
float2 l9_5252=float2(0.0);
l9_5252=l9_5102;
float2 l9_5253=float2(0.0);
l9_5253=l9_5252;
l9_5046=l9_5253;
l9_5049=l9_5046;
}
else
{
float2 l9_5254=float2(0.0);
l9_5254=l9_5048.Surface_UVCoord0;
l9_5047=l9_5254;
l9_5049=l9_5047;
}
}
}
}
l9_5042=l9_5049;
float4 l9_5255=float4(0.0);
int l9_5256=0;
if ((int(opacityTexHasSwappedViews_tmp)!=0))
{
int l9_5257=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_5257=0;
}
else
{
l9_5257=in.varStereoViewID;
}
int l9_5258=l9_5257;
l9_5256=1-l9_5258;
}
else
{
int l9_5259=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_5259=0;
}
else
{
l9_5259=in.varStereoViewID;
}
int l9_5260=l9_5259;
l9_5256=l9_5260;
}
int l9_5261=l9_5256;
int l9_5262=opacityTexLayout_tmp;
int l9_5263=l9_5261;
float2 l9_5264=l9_5042;
bool l9_5265=(int(SC_USE_UV_TRANSFORM_opacityTex_tmp)!=0);
float3x3 l9_5266=(*sc_set2.UserUniforms).opacityTexTransform;
int2 l9_5267=int2(SC_SOFTWARE_WRAP_MODE_U_opacityTex_tmp,SC_SOFTWARE_WRAP_MODE_V_opacityTex_tmp);
bool l9_5268=(int(SC_USE_UV_MIN_MAX_opacityTex_tmp)!=0);
float4 l9_5269=(*sc_set2.UserUniforms).opacityTexUvMinMax;
bool l9_5270=(int(SC_USE_CLAMP_TO_BORDER_opacityTex_tmp)!=0);
float4 l9_5271=(*sc_set2.UserUniforms).opacityTexBorderColor;
float l9_5272=0.0;
bool l9_5273=l9_5270&&(!l9_5268);
float l9_5274=1.0;
float l9_5275=l9_5264.x;
int l9_5276=l9_5267.x;
if (l9_5276==1)
{
l9_5275=fract(l9_5275);
}
else
{
if (l9_5276==2)
{
float l9_5277=fract(l9_5275);
float l9_5278=l9_5275-l9_5277;
float l9_5279=step(0.25,fract(l9_5278*0.5));
l9_5275=mix(l9_5277,1.0-l9_5277,fast::clamp(l9_5279,0.0,1.0));
}
}
l9_5264.x=l9_5275;
float l9_5280=l9_5264.y;
int l9_5281=l9_5267.y;
if (l9_5281==1)
{
l9_5280=fract(l9_5280);
}
else
{
if (l9_5281==2)
{
float l9_5282=fract(l9_5280);
float l9_5283=l9_5280-l9_5282;
float l9_5284=step(0.25,fract(l9_5283*0.5));
l9_5280=mix(l9_5282,1.0-l9_5282,fast::clamp(l9_5284,0.0,1.0));
}
}
l9_5264.y=l9_5280;
if (l9_5268)
{
bool l9_5285=l9_5270;
bool l9_5286;
if (l9_5285)
{
l9_5286=l9_5267.x==3;
}
else
{
l9_5286=l9_5285;
}
float l9_5287=l9_5264.x;
float l9_5288=l9_5269.x;
float l9_5289=l9_5269.z;
bool l9_5290=l9_5286;
float l9_5291=l9_5274;
float l9_5292=fast::clamp(l9_5287,l9_5288,l9_5289);
float l9_5293=step(abs(l9_5287-l9_5292),9.9999997e-06);
l9_5291*=(l9_5293+((1.0-float(l9_5290))*(1.0-l9_5293)));
l9_5287=l9_5292;
l9_5264.x=l9_5287;
l9_5274=l9_5291;
bool l9_5294=l9_5270;
bool l9_5295;
if (l9_5294)
{
l9_5295=l9_5267.y==3;
}
else
{
l9_5295=l9_5294;
}
float l9_5296=l9_5264.y;
float l9_5297=l9_5269.y;
float l9_5298=l9_5269.w;
bool l9_5299=l9_5295;
float l9_5300=l9_5274;
float l9_5301=fast::clamp(l9_5296,l9_5297,l9_5298);
float l9_5302=step(abs(l9_5296-l9_5301),9.9999997e-06);
l9_5300*=(l9_5302+((1.0-float(l9_5299))*(1.0-l9_5302)));
l9_5296=l9_5301;
l9_5264.y=l9_5296;
l9_5274=l9_5300;
}
float2 l9_5303=l9_5264;
bool l9_5304=l9_5265;
float3x3 l9_5305=l9_5266;
if (l9_5304)
{
l9_5303=float2((l9_5305*float3(l9_5303,1.0)).xy);
}
float2 l9_5306=l9_5303;
float2 l9_5307=l9_5306;
float2 l9_5308=l9_5307;
l9_5264=l9_5308;
float l9_5309=l9_5264.x;
int l9_5310=l9_5267.x;
bool l9_5311=l9_5273;
float l9_5312=l9_5274;
if ((l9_5310==0)||(l9_5310==3))
{
float l9_5313=l9_5309;
float l9_5314=0.0;
float l9_5315=1.0;
bool l9_5316=l9_5311;
float l9_5317=l9_5312;
float l9_5318=fast::clamp(l9_5313,l9_5314,l9_5315);
float l9_5319=step(abs(l9_5313-l9_5318),9.9999997e-06);
l9_5317*=(l9_5319+((1.0-float(l9_5316))*(1.0-l9_5319)));
l9_5313=l9_5318;
l9_5309=l9_5313;
l9_5312=l9_5317;
}
l9_5264.x=l9_5309;
l9_5274=l9_5312;
float l9_5320=l9_5264.y;
int l9_5321=l9_5267.y;
bool l9_5322=l9_5273;
float l9_5323=l9_5274;
if ((l9_5321==0)||(l9_5321==3))
{
float l9_5324=l9_5320;
float l9_5325=0.0;
float l9_5326=1.0;
bool l9_5327=l9_5322;
float l9_5328=l9_5323;
float l9_5329=fast::clamp(l9_5324,l9_5325,l9_5326);
float l9_5330=step(abs(l9_5324-l9_5329),9.9999997e-06);
l9_5328*=(l9_5330+((1.0-float(l9_5327))*(1.0-l9_5330)));
l9_5324=l9_5329;
l9_5320=l9_5324;
l9_5323=l9_5328;
}
l9_5264.y=l9_5320;
l9_5274=l9_5323;
float2 l9_5331=l9_5264;
int l9_5332=l9_5262;
int l9_5333=l9_5263;
float l9_5334=l9_5272;
float2 l9_5335=l9_5331;
int l9_5336=l9_5332;
int l9_5337=l9_5333;
float3 l9_5338=float3(0.0);
if (l9_5336==0)
{
l9_5338=float3(l9_5335,0.0);
}
else
{
if (l9_5336==1)
{
l9_5338=float3(l9_5335.x,(l9_5335.y*0.5)+(0.5-(float(l9_5337)*0.5)),0.0);
}
else
{
l9_5338=float3(l9_5335,float(l9_5337));
}
}
float3 l9_5339=l9_5338;
float3 l9_5340=l9_5339;
float2 l9_5341=l9_5340.xy;
float l9_5342=l9_5334;
float4 l9_5343=sc_set2.opacityTex.sample(sc_set2.opacityTexSmpSC,l9_5341,bias(l9_5342));
float4 l9_5344=l9_5343;
float4 l9_5345=l9_5344;
if (l9_5270)
{
l9_5345=mix(l9_5271,l9_5345,float4(l9_5274));
}
float4 l9_5346=l9_5345;
l9_5255=l9_5346;
float l9_5347=0.0;
l9_5347=l9_5255.x;
param_22=l9_5347;
param_24=param_22;
}
else
{
param_24=param_23;
}
Result_N204=param_24;
float Output_N72=0.0;
float param_26=1.0;
float param_27=(*sc_set2.UserUniforms).Port_Input2_N072;
ssGlobals param_29=Globals;
float param_28;
if (NODE_38_DROPLIST_ITEM_tmp==1)
{
float4 l9_5348=float4(0.0);
l9_5348=param_29.VertexColor;
float l9_5349=0.0;
l9_5349=l9_5348.w;
param_26=l9_5349;
param_28=param_26;
}
else
{
param_28=param_27;
}
Output_N72=param_28;
float Output_N205=0.0;
Output_N205=(Output_N168*Result_N204)*Output_N72;
float Export_N158=0.0;
Export_N158=Output_N205;
float4 Value_N2=float4(0.0);
Value_N2=float4(Output_N1.x,Output_N1.y,Output_N1.z,Value_N2.w);
Value_N2.w=Export_N158;
FinalColor=Value_N2;
float param_30=FinalColor.w;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (param_30<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_5350=gl_FragCoord;
float2 l9_5351=floor(mod(l9_5350.xy,float2(4.0)));
float l9_5352=(mod(dot(l9_5351,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (param_30<l9_5352)
{
discard_fragment();
}
}
bool l9_5353=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_5353)
{
float4 param_31=FinalColor;
if ((int(sc_ProxyAlphaOne_tmp)!=0))
{
param_31.w=1.0;
}
float4 l9_5354=fast::max(param_31,float4(0.0));
float4 param_32=l9_5354;
out.FragColor0=param_32;
return out;
}
float4 param_33=FinalColor;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_5355=param_33;
float4 l9_5356=l9_5355;
float l9_5357=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_5357=l9_5356.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_5357=fast::clamp(l9_5356.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_5357=fast::clamp(dot(l9_5356.xyz,float3(l9_5356.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_5357=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_5357=(1.0-dot(l9_5356.xyz,float3(0.33333001)))*l9_5356.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_5357=(1.0-fast::clamp(dot(l9_5356.xyz,float3(1.0)),0.0,1.0))*l9_5356.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_5357=fast::clamp(dot(l9_5356.xyz,float3(1.0)),0.0,1.0)*l9_5356.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_5357=fast::clamp(dot(l9_5356.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_5357=fast::clamp(dot(l9_5356.xyz,float3(1.0)),0.0,1.0)*l9_5356.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_5357=dot(l9_5356.xyz,float3(0.33333001))*l9_5356.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_5357=1.0-fast::clamp(dot(l9_5356.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_5357=fast::clamp(dot(l9_5356.xyz,float3(1.0)),0.0,1.0);
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
float l9_5358=l9_5357;
float l9_5359=l9_5358;
float l9_5360=(*sc_set2.UserUniforms).sc_ShadowDensity*l9_5359;
float3 l9_5361=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_5355.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float4 l9_5362=float4(l9_5361.x,l9_5361.y,l9_5361.z,l9_5360);
param_33=l9_5362;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_33=float4(param_33.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_5363=param_33;
float4 l9_5364=float4(0.0);
float4 l9_5365=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_5366=out.FragColor0;
float4 l9_5367=l9_5366;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_5367.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_5368=l9_5367;
l9_5365=l9_5368;
}
else
{
float4 l9_5369=gl_FragCoord;
float2 l9_5370=(l9_5369.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_5371=l9_5370;
float2 l9_5372=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_5373=1;
int l9_5374=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_5374=0;
}
else
{
l9_5374=in.varStereoViewID;
}
int l9_5375=l9_5374;
int l9_5376=l9_5375;
float3 l9_5377=float3(l9_5371,0.0);
int l9_5378=l9_5373;
int l9_5379=l9_5376;
if (l9_5378==1)
{
l9_5377.y=((2.0*l9_5377.y)+float(l9_5379))-1.0;
}
float2 l9_5380=l9_5377.xy;
l9_5372=l9_5380;
}
else
{
l9_5372=l9_5371;
}
float2 l9_5381=l9_5372;
float2 l9_5382=l9_5381;
float2 l9_5383=l9_5382;
int l9_5384=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_5385=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_5385=0;
}
else
{
l9_5385=in.varStereoViewID;
}
int l9_5386=l9_5385;
l9_5384=1-l9_5386;
}
else
{
int l9_5387=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_5387=0;
}
else
{
l9_5387=in.varStereoViewID;
}
int l9_5388=l9_5387;
l9_5384=l9_5388;
}
int l9_5389=l9_5384;
float2 l9_5390=l9_5383;
int l9_5391=l9_5389;
float2 l9_5392=l9_5390;
int l9_5393=l9_5391;
float l9_5394=0.0;
float4 l9_5395=float4(0.0);
float2 l9_5396=l9_5392;
int l9_5397=sc_ScreenTextureLayout_tmp;
int l9_5398=l9_5393;
float l9_5399=l9_5394;
float2 l9_5400=l9_5396;
int l9_5401=l9_5397;
int l9_5402=l9_5398;
float3 l9_5403=float3(0.0);
if (l9_5401==0)
{
l9_5403=float3(l9_5400,0.0);
}
else
{
if (l9_5401==1)
{
l9_5403=float3(l9_5400.x,(l9_5400.y*0.5)+(0.5-(float(l9_5402)*0.5)),0.0);
}
else
{
l9_5403=float3(l9_5400,float(l9_5402));
}
}
float3 l9_5404=l9_5403;
float3 l9_5405=l9_5404;
float2 l9_5406=l9_5405.xy;
float l9_5407=l9_5399;
float4 l9_5408=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_5406,bias(l9_5407));
float4 l9_5409=l9_5408;
l9_5395=l9_5409;
float4 l9_5410=l9_5395;
float4 l9_5411=l9_5410;
float4 l9_5412=l9_5411;
l9_5365=l9_5412;
}
float4 l9_5413=l9_5365;
float4 l9_5414=l9_5413;
float3 l9_5415=l9_5414.xyz;
float3 l9_5416=l9_5415;
float3 l9_5417=l9_5363.xyz;
float3 l9_5418=definedBlend(l9_5416,l9_5417,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.intensityTexture,sc_set2.intensityTextureSmpSC);
l9_5364=float4(l9_5418.x,l9_5418.y,l9_5418.z,l9_5364.w);
float3 l9_5419=mix(l9_5415,l9_5364.xyz,float3(l9_5363.w));
l9_5364=float4(l9_5419.x,l9_5419.y,l9_5419.z,l9_5364.w);
l9_5364.w=1.0;
float4 l9_5420=l9_5364;
param_33=l9_5420;
}
else
{
float4 l9_5421=param_33;
float4 l9_5422=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_5422=float4(mix(float3(1.0),l9_5421.xyz,float3(l9_5421.w)),l9_5421.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_5423=l9_5421.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_5423=fast::clamp(l9_5423,0.0,1.0);
}
l9_5422=float4(l9_5421.xyz*l9_5423,l9_5423);
}
else
{
l9_5422=l9_5421;
}
}
float4 l9_5424=l9_5422;
param_33=l9_5424;
}
}
}
float4 l9_5425=param_33;
FinalColor=l9_5425;
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
float4 l9_5426=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_5426=float4((*sc_set2.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_5426=float4(0.0);
}
float4 l9_5427=l9_5426;
float4 Cost=l9_5427;
if (Cost.w>0.0)
{
FinalColor=Cost;
}
FinalColor=fast::max(FinalColor,float4(0.0));
float3 param_34=in.varPos;
float4 param_35=FinalColor;
FinalColor=outputMotionVectorsIfNeeded(param_34,param_35,in.varStereoViewID,(*sc_set2.UserUniforms));
float4 param_36=FinalColor;
float4 l9_5428=param_36;
out.FragColor0=l9_5428;
return out;
}
} // FRAGMENT SHADER
