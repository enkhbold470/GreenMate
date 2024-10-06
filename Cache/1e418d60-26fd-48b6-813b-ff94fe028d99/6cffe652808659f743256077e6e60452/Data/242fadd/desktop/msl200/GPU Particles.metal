#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_BACKEND_SHADER_FLAGS_END__
#endif
//efine SC_DISABLE_FRUSTUM_CULLING
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
//sampler sampler colorRampTextureSmpSC 2:25
//sampler sampler intensityTextureSmpSC 2:26
//sampler sampler mainTextureSmpSC 2:27
//sampler sampler normalTexSmpSC 2:28
//sampler sampler sc_EnvmapDiffuseSmpSC 2:29
//sampler sampler sc_EnvmapSpecularSmpSC 2:30
//sampler sampler sc_RayTracedAoTextureSmpSC 2:32
//sampler sampler sc_RayTracedDiffIndTextureSmpSC 2:33
//sampler sampler sc_RayTracedReflectionTextureSmpSC 2:34
//sampler sampler sc_RayTracedShadowTextureSmpSC 2:35
//sampler sampler sc_SSAOTextureSmpSC 2:36
//sampler sampler sc_ScreenTextureSmpSC 2:37
//sampler sampler sc_ShadowTextureSmpSC 2:38
//sampler sampler sizeRampTextureSmpSC 2:40
//sampler sampler velRampTextureSmpSC 2:41
//texture texture2D colorRampTexture 2:1:2:25
//texture texture2D intensityTexture 2:2:2:26
//texture texture2D mainTexture 2:3:2:27
//texture texture2D normalTex 2:4:2:28
//texture texture2D sc_EnvmapDiffuse 2:5:2:29
//texture texture2D sc_EnvmapSpecular 2:6:2:30
//texture texture2D sc_RayTracedAoTexture 2:15:2:32
//texture texture2D sc_RayTracedDiffIndTexture 2:16:2:33
//texture texture2D sc_RayTracedReflectionTexture 2:17:2:34
//texture texture2D sc_RayTracedShadowTexture 2:18:2:35
//texture texture2D sc_SSAOTexture 2:19:2:36
//texture texture2D sc_ScreenTexture 2:20:2:37
//texture texture2D sc_ShadowTexture 2:21:2:38
//texture texture2D sizeRampTexture 2:23:2:40
//texture texture2D velRampTexture 2:24:2:41
//ubo float sc_BonesUBO 2:0:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:42:5664 {
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
//bool receivesRayTracedShadows 3748
//bool receivesRayTracedDiffuseIndirect 3752
//bool receivesRayTracedAo 3756
//float4 sc_RayTracedReflectionTextureSize 3760
//float4 sc_RayTracedReflectionTextureDims 3776
//float4 sc_RayTracedReflectionTextureView 3792
//float4 sc_RayTracedShadowTextureSize 3808
//float4 sc_RayTracedShadowTextureDims 3824
//float4 sc_RayTracedShadowTextureView 3840
//float4 sc_RayTracedDiffIndTextureSize 3856
//float4 sc_RayTracedDiffIndTextureDims 3872
//float4 sc_RayTracedDiffIndTextureView 3888
//float4 sc_RayTracedAoTextureSize 3904
//float4 sc_RayTracedAoTextureDims 3920
//float4 sc_RayTracedAoTextureView 3936
//float receiver_mask 3952
//float3 OriginNormalizationScale 3968
//float3 OriginNormalizationScaleInv 3984
//float3 OriginNormalizationOffset 4000
//int receiverId 4016
//float correctedIntensity 4020
//float4 intensityTextureSize 4032
//float4 intensityTextureDims 4048
//float4 intensityTextureView 4064
//float3x3 intensityTextureTransform 4080
//float4 intensityTextureUvMinMax 4128
//float4 intensityTextureBorderColor 4144
//float reflBlurWidth 4160
//float reflBlurMinRough 4164
//float reflBlurMaxRough 4168
//int overrideTimeEnabled 4172
//float overrideTimeElapsed 4176
//float overrideTimeDelta 4180
//int PreviewEnabled 4184
//int PreviewNodeID 4188
//float alphaTestThreshold 4192
//float timeGlobal 4196
//float externalTimeInput 4200
//float externalSeed 4204
//float lifeTimeConstant 4208
//float2 lifeTimeMinMax 4216
//float spawnDuration 4224
//float3 spawnLocation 4240
//float3 spawnBox 4256
//float3 spawnSphere 4272
//float3 noiseMult 4288
//float3 noiseFrequency 4304
//float3 sNoiseMult 4320
//float3 sNoiseFrequency 4336
//float3 velocityMin 4352
//float3 velocityMax 4368
//float3 velocityDrag 4384
//float4 velRampTextureSize 4400
//float4 velRampTextureDims 4416
//float4 velRampTextureView 4432
//float3x3 velRampTextureTransform 4448
//float4 velRampTextureUvMinMax 4496
//float4 velRampTextureBorderColor 4512
//float2 sizeStart 4528
//float3 sizeStart3D 4544
//float2 sizeEnd 4560
//float3 sizeEnd3D 4576
//float2 sizeStartMin 4592
//float3 sizeStartMin3D 4608
//float2 sizeStartMax 4624
//float3 sizeStartMax3D 4640
//float2 sizeEndMin 4656
//float3 sizeEndMin3D 4672
//float2 sizeEndMax 4688
//float3 sizeEndMax3D 4704
//float sizeSpeed 4720
//float4 sizeRampTextureSize 4736
//float4 sizeRampTextureDims 4752
//float4 sizeRampTextureView 4768
//float3x3 sizeRampTextureTransform 4784
//float4 sizeRampTextureUvMinMax 4832
//float4 sizeRampTextureBorderColor 4848
//float gravity 4864
//float3 localForce 4880
//float sizeVelScale 4896
//bool ALIGNTOX 4900
//bool ALIGNTOY 4904
//bool ALIGNTOZ 4908
//float2 rotationRandomX 4912
//float2 rotationRateX 4920
//float2 randomRotationY 4928
//float2 rotationRateY 4936
//float2 rotationRandom 4944
//float2 randomRotationZ 4952
//float2 rotationRate 4960
//float2 rotationRateZ 4968
//float rotationDrag 4976
//bool CENTER_BBOX 4980
//float fadeDistanceVisible 4984
//float fadeDistanceInvisible 4988
//float3 colorStart 4992
//float3 colorEnd 5008
//float3 colorMinStart 5024
//float3 colorMinEnd 5040
//float3 colorMaxStart 5056
//float3 colorMaxEnd 5072
//float alphaStart 5088
//float alphaEnd 5092
//float alphaMinStart 5096
//float alphaMinEnd 5100
//float alphaMaxStart 5104
//float alphaMaxEnd 5108
//float alphaDissolveMult 5112
//float numValidFrames 5116
//float2 gridSize 5120
//float flipBookSpeedMult 5128
//float flipBookRandomStart 5132
//float4 colorRampTextureSize 5136
//float4 colorRampTextureDims 5152
//float4 colorRampTextureView 5168
//float3x3 colorRampTextureTransform 5184
//float4 colorRampTextureUvMinMax 5232
//float4 colorRampTextureBorderColor 5248
//float4 colorRampMult 5264
//float4 mainTextureSize 5280
//float4 mainTextureDims 5296
//float4 mainTextureView 5312
//float3x3 mainTextureTransform 5328
//float4 mainTextureUvMinMax 5376
//float4 mainTextureBorderColor 5392
//float4 normalTexSize 5408
//float4 normalTexDims 5424
//float4 normalTexView 5440
//float3x3 normalTexTransform 5456
//float4 normalTexUvMinMax 5504
//float4 normalTexBorderColor 5520
//float metallic 5536
//float roughness 5540
//float Port_Input1_N119 5544
//float2 Port_Input1_N138 5552
//float2 Port_Input1_N139 5560
//float2 Port_Input1_N140 5568
//float2 Port_Input1_N144 5576
//float Port_Input1_N069 5584
//float Port_Input1_N068 5588
//float Port_Input1_N110 5592
//float Port_Input1_N154 5596
//float3 Port_Default_N167 5600
//float3 Port_Emissive_N014 5616
//float3 Port_AO_N014 5632
//float3 Port_SpecularAO_N014 5648
//}
//spec_const bool ALPHADISSOLVE 1000
//spec_const bool ALPHAMINMAX 1001
//spec_const bool BASETEXTURE 1002
//spec_const bool BLACKASALPHA 1003
//spec_const bool BLEND_MODE_AVERAGE 1004
//spec_const bool BLEND_MODE_BRIGHT 1005
//spec_const bool BLEND_MODE_COLOR_BURN 1006
//spec_const bool BLEND_MODE_COLOR_DODGE 1007
//spec_const bool BLEND_MODE_COLOR 1008
//spec_const bool BLEND_MODE_DARKEN 1009
//spec_const bool BLEND_MODE_DIFFERENCE 1010
//spec_const bool BLEND_MODE_DIVIDE 1011
//spec_const bool BLEND_MODE_DIVISION 1012
//spec_const bool BLEND_MODE_EXCLUSION 1013
//spec_const bool BLEND_MODE_FORGRAY 1014
//spec_const bool BLEND_MODE_HARD_GLOW 1015
//spec_const bool BLEND_MODE_HARD_LIGHT 1016
//spec_const bool BLEND_MODE_HARD_MIX 1017
//spec_const bool BLEND_MODE_HARD_PHOENIX 1018
//spec_const bool BLEND_MODE_HARD_REFLECT 1019
//spec_const bool BLEND_MODE_HUE 1020
//spec_const bool BLEND_MODE_INTENSE 1021
//spec_const bool BLEND_MODE_LIGHTEN 1022
//spec_const bool BLEND_MODE_LINEAR_LIGHT 1023
//spec_const bool BLEND_MODE_LUMINOSITY 1024
//spec_const bool BLEND_MODE_NEGATION 1025
//spec_const bool BLEND_MODE_NOTBRIGHT 1026
//spec_const bool BLEND_MODE_OVERLAY 1027
//spec_const bool BLEND_MODE_PIN_LIGHT 1028
//spec_const bool BLEND_MODE_REALISTIC 1029
//spec_const bool BLEND_MODE_SATURATION 1030
//spec_const bool BLEND_MODE_SOFT_LIGHT 1031
//spec_const bool BLEND_MODE_SUBTRACT 1032
//spec_const bool BLEND_MODE_VIVID_LIGHT 1033
//spec_const bool BOXSPAWN 1034
//spec_const bool COLORMINMAX 1035
//spec_const bool COLORMONOMIN 1036
//spec_const bool COLORRAMP 1037
//spec_const bool ENABLE_STIPPLE_PATTERN_TEST 1038
//spec_const bool EXTERNALTIME 1039
//spec_const bool FLIPBOOKBLEND 1040
//spec_const bool FLIPBOOKBYLIFE 1041
//spec_const bool FLIPBOOK 1042
//spec_const bool FORCE 1043
//spec_const bool IGNORETRANSFORMSCALE 1044
//spec_const bool IGNOREVEL 1045
//spec_const bool INILOCATION 1046
//spec_const bool INSTANTSPAWN 1047
//spec_const bool LIFETIMEMINMAX 1048
//spec_const bool NOISE 1049
//spec_const bool NORANDOFFSET 1050
//spec_const bool NORMALTEX 1051
//spec_const bool PBR 1052
//spec_const bool PREMULTIPLIEDCOLOR 1053
//spec_const bool SCREENFADE 1054
//spec_const bool SC_USE_CLAMP_TO_BORDER_colorRampTexture 1055
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 1056
//spec_const bool SC_USE_CLAMP_TO_BORDER_mainTexture 1057
//spec_const bool SC_USE_CLAMP_TO_BORDER_normalTex 1058
//spec_const bool SC_USE_CLAMP_TO_BORDER_sizeRampTexture 1059
//spec_const bool SC_USE_CLAMP_TO_BORDER_velRampTexture 1060
//spec_const bool SC_USE_UV_MIN_MAX_colorRampTexture 1061
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 1062
//spec_const bool SC_USE_UV_MIN_MAX_mainTexture 1063
//spec_const bool SC_USE_UV_MIN_MAX_normalTex 1064
//spec_const bool SC_USE_UV_MIN_MAX_sizeRampTexture 1065
//spec_const bool SC_USE_UV_MIN_MAX_velRampTexture 1066
//spec_const bool SC_USE_UV_TRANSFORM_colorRampTexture 1067
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 1068
//spec_const bool SC_USE_UV_TRANSFORM_mainTexture 1069
//spec_const bool SC_USE_UV_TRANSFORM_normalTex 1070
//spec_const bool SC_USE_UV_TRANSFORM_sizeRampTexture 1071
//spec_const bool SC_USE_UV_TRANSFORM_velRampTexture 1072
//spec_const bool SIZEMINMAX 1073
//spec_const bool SIZERAMP 1074
//spec_const bool SNOISE 1075
//spec_const bool SPHERESPAWN 1076
//spec_const bool UseViewSpaceDepthVariant 1077
//spec_const bool VELOCITYDIR 1078
//spec_const bool VELRAMP 1079
//spec_const bool WORLDPOSSEED 1080
//spec_const bool colorRampTextureHasSwappedViews 1081
//spec_const bool intensityTextureHasSwappedViews 1082
//spec_const bool mainTextureHasSwappedViews 1083
//spec_const bool normalTexHasSwappedViews 1084
//spec_const bool sc_BlendMode_AddWithAlphaFactor 1085
//spec_const bool sc_BlendMode_Add 1086
//spec_const bool sc_BlendMode_AlphaTest 1087
//spec_const bool sc_BlendMode_AlphaToCoverage 1088
//spec_const bool sc_BlendMode_ColoredGlass 1089
//spec_const bool sc_BlendMode_Custom 1090
//spec_const bool sc_BlendMode_Max 1091
//spec_const bool sc_BlendMode_Min 1092
//spec_const bool sc_BlendMode_MultiplyOriginal 1093
//spec_const bool sc_BlendMode_Multiply 1094
//spec_const bool sc_BlendMode_Normal 1095
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 1096
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 1097
//spec_const bool sc_BlendMode_PremultipliedAlpha 1098
//spec_const bool sc_BlendMode_Screen 1099
//spec_const bool sc_DepthOnly 1100
//spec_const bool sc_EnvmapDiffuseHasSwappedViews 1101
//spec_const bool sc_EnvmapSpecularHasSwappedViews 1102
//spec_const bool sc_FramebufferFetch 1103
//spec_const bool sc_HasDiffuseEnvmap 1104
//spec_const bool sc_LightEstimation 1105
//spec_const bool sc_MotionVectorsPass 1106
//spec_const bool sc_OITCompositingPass 1107
//spec_const bool sc_OITDepthBoundsPass 1108
//spec_const bool sc_OITDepthGatherPass 1109
//spec_const bool sc_ProjectiveShadowsCaster 1110
//spec_const bool sc_ProjectiveShadowsReceiver 1111
//spec_const bool sc_RayTracedAoTextureHasSwappedViews 1112
//spec_const bool sc_RayTracedDiffIndTextureHasSwappedViews 1113
//spec_const bool sc_RayTracedReflectionTextureHasSwappedViews 1114
//spec_const bool sc_RayTracedShadowTextureHasSwappedViews 1115
//spec_const bool sc_RenderAlphaToColor 1116
//spec_const bool sc_SSAOEnabled 1117
//spec_const bool sc_ScreenTextureHasSwappedViews 1118
//spec_const bool sc_ShaderComplexityAnalyzer 1119
//spec_const bool sc_UseFramebufferFetchMarker 1120
//spec_const bool sc_VertexBlendingUseNormals 1121
//spec_const bool sc_VertexBlending 1122
//spec_const bool sizeRampTextureHasSwappedViews 1123
//spec_const bool velRampTextureHasSwappedViews 1124
//spec_const int MESHTYPE 1125
//spec_const int SC_DEVICE_CLASS 1126
//spec_const int SC_SOFTWARE_WRAP_MODE_U_colorRampTexture 1127
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 1128
//spec_const int SC_SOFTWARE_WRAP_MODE_U_mainTexture 1129
//spec_const int SC_SOFTWARE_WRAP_MODE_U_normalTex 1130
//spec_const int SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture 1131
//spec_const int SC_SOFTWARE_WRAP_MODE_U_velRampTexture 1132
//spec_const int SC_SOFTWARE_WRAP_MODE_V_colorRampTexture 1133
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 1134
//spec_const int SC_SOFTWARE_WRAP_MODE_V_mainTexture 1135
//spec_const int SC_SOFTWARE_WRAP_MODE_V_normalTex 1136
//spec_const int SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture 1137
//spec_const int SC_SOFTWARE_WRAP_MODE_V_velRampTexture 1138
//spec_const int colorRampTextureLayout 1139
//spec_const int intensityTextureLayout 1140
//spec_const int mainTextureLayout 1141
//spec_const int normalTexLayout 1142
//spec_const int rotationSpace 1143
//spec_const int sc_AmbientLightMode0 1144
//spec_const int sc_AmbientLightMode1 1145
//spec_const int sc_AmbientLightMode2 1146
//spec_const int sc_AmbientLightMode_Constant 1147
//spec_const int sc_AmbientLightMode_EnvironmentMap 1148
//spec_const int sc_AmbientLightMode_FromCamera 1149
//spec_const int sc_AmbientLightMode_SphericalHarmonics 1150
//spec_const int sc_AmbientLightsCount 1151
//spec_const int sc_DepthBufferMode 1152
//spec_const int sc_DirectionalLightsCount 1153
//spec_const int sc_EnvLightMode 1154
//spec_const int sc_EnvmapDiffuseLayout 1155
//spec_const int sc_EnvmapSpecularLayout 1156
//spec_const int sc_LightEstimationSGCount 1157
//spec_const int sc_MaxTextureImageUnits 1158
//spec_const int sc_PointLightsCount 1159
//spec_const int sc_RayTracedAoTextureLayout 1160
//spec_const int sc_RayTracedDiffIndTextureLayout 1161
//spec_const int sc_RayTracedReflectionTextureLayout 1162
//spec_const int sc_RayTracedShadowTextureLayout 1163
//spec_const int sc_RenderingSpace 1164
//spec_const int sc_ScreenTextureLayout 1165
//spec_const int sc_SkinBonesCount 1166
//spec_const int sc_StereoRenderingMode 1167
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1168
//spec_const int sizeRampTextureLayout 1169
//spec_const int velRampTextureLayout 1170
//SG_REFLECTION_END
constant bool ALPHADISSOLVE [[function_constant(1000)]];
constant bool ALPHADISSOLVE_tmp = is_function_constant_defined(ALPHADISSOLVE) ? ALPHADISSOLVE : false;
constant bool ALPHAMINMAX [[function_constant(1001)]];
constant bool ALPHAMINMAX_tmp = is_function_constant_defined(ALPHAMINMAX) ? ALPHAMINMAX : false;
constant bool BASETEXTURE [[function_constant(1002)]];
constant bool BASETEXTURE_tmp = is_function_constant_defined(BASETEXTURE) ? BASETEXTURE : false;
constant bool BLACKASALPHA [[function_constant(1003)]];
constant bool BLACKASALPHA_tmp = is_function_constant_defined(BLACKASALPHA) ? BLACKASALPHA : false;
constant bool BLEND_MODE_AVERAGE [[function_constant(1004)]];
constant bool BLEND_MODE_AVERAGE_tmp = is_function_constant_defined(BLEND_MODE_AVERAGE) ? BLEND_MODE_AVERAGE : false;
constant bool BLEND_MODE_BRIGHT [[function_constant(1005)]];
constant bool BLEND_MODE_BRIGHT_tmp = is_function_constant_defined(BLEND_MODE_BRIGHT) ? BLEND_MODE_BRIGHT : false;
constant bool BLEND_MODE_COLOR_BURN [[function_constant(1006)]];
constant bool BLEND_MODE_COLOR_BURN_tmp = is_function_constant_defined(BLEND_MODE_COLOR_BURN) ? BLEND_MODE_COLOR_BURN : false;
constant bool BLEND_MODE_COLOR_DODGE [[function_constant(1007)]];
constant bool BLEND_MODE_COLOR_DODGE_tmp = is_function_constant_defined(BLEND_MODE_COLOR_DODGE) ? BLEND_MODE_COLOR_DODGE : false;
constant bool BLEND_MODE_COLOR [[function_constant(1008)]];
constant bool BLEND_MODE_COLOR_tmp = is_function_constant_defined(BLEND_MODE_COLOR) ? BLEND_MODE_COLOR : false;
constant bool BLEND_MODE_DARKEN [[function_constant(1009)]];
constant bool BLEND_MODE_DARKEN_tmp = is_function_constant_defined(BLEND_MODE_DARKEN) ? BLEND_MODE_DARKEN : false;
constant bool BLEND_MODE_DIFFERENCE [[function_constant(1010)]];
constant bool BLEND_MODE_DIFFERENCE_tmp = is_function_constant_defined(BLEND_MODE_DIFFERENCE) ? BLEND_MODE_DIFFERENCE : false;
constant bool BLEND_MODE_DIVIDE [[function_constant(1011)]];
constant bool BLEND_MODE_DIVIDE_tmp = is_function_constant_defined(BLEND_MODE_DIVIDE) ? BLEND_MODE_DIVIDE : false;
constant bool BLEND_MODE_DIVISION [[function_constant(1012)]];
constant bool BLEND_MODE_DIVISION_tmp = is_function_constant_defined(BLEND_MODE_DIVISION) ? BLEND_MODE_DIVISION : false;
constant bool BLEND_MODE_EXCLUSION [[function_constant(1013)]];
constant bool BLEND_MODE_EXCLUSION_tmp = is_function_constant_defined(BLEND_MODE_EXCLUSION) ? BLEND_MODE_EXCLUSION : false;
constant bool BLEND_MODE_FORGRAY [[function_constant(1014)]];
constant bool BLEND_MODE_FORGRAY_tmp = is_function_constant_defined(BLEND_MODE_FORGRAY) ? BLEND_MODE_FORGRAY : false;
constant bool BLEND_MODE_HARD_GLOW [[function_constant(1015)]];
constant bool BLEND_MODE_HARD_GLOW_tmp = is_function_constant_defined(BLEND_MODE_HARD_GLOW) ? BLEND_MODE_HARD_GLOW : false;
constant bool BLEND_MODE_HARD_LIGHT [[function_constant(1016)]];
constant bool BLEND_MODE_HARD_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_HARD_LIGHT) ? BLEND_MODE_HARD_LIGHT : false;
constant bool BLEND_MODE_HARD_MIX [[function_constant(1017)]];
constant bool BLEND_MODE_HARD_MIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_MIX) ? BLEND_MODE_HARD_MIX : false;
constant bool BLEND_MODE_HARD_PHOENIX [[function_constant(1018)]];
constant bool BLEND_MODE_HARD_PHOENIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_PHOENIX) ? BLEND_MODE_HARD_PHOENIX : false;
constant bool BLEND_MODE_HARD_REFLECT [[function_constant(1019)]];
constant bool BLEND_MODE_HARD_REFLECT_tmp = is_function_constant_defined(BLEND_MODE_HARD_REFLECT) ? BLEND_MODE_HARD_REFLECT : false;
constant bool BLEND_MODE_HUE [[function_constant(1020)]];
constant bool BLEND_MODE_HUE_tmp = is_function_constant_defined(BLEND_MODE_HUE) ? BLEND_MODE_HUE : false;
constant bool BLEND_MODE_INTENSE [[function_constant(1021)]];
constant bool BLEND_MODE_INTENSE_tmp = is_function_constant_defined(BLEND_MODE_INTENSE) ? BLEND_MODE_INTENSE : false;
constant bool BLEND_MODE_LIGHTEN [[function_constant(1022)]];
constant bool BLEND_MODE_LIGHTEN_tmp = is_function_constant_defined(BLEND_MODE_LIGHTEN) ? BLEND_MODE_LIGHTEN : false;
constant bool BLEND_MODE_LINEAR_LIGHT [[function_constant(1023)]];
constant bool BLEND_MODE_LINEAR_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_LINEAR_LIGHT) ? BLEND_MODE_LINEAR_LIGHT : false;
constant bool BLEND_MODE_LUMINOSITY [[function_constant(1024)]];
constant bool BLEND_MODE_LUMINOSITY_tmp = is_function_constant_defined(BLEND_MODE_LUMINOSITY) ? BLEND_MODE_LUMINOSITY : false;
constant bool BLEND_MODE_NEGATION [[function_constant(1025)]];
constant bool BLEND_MODE_NEGATION_tmp = is_function_constant_defined(BLEND_MODE_NEGATION) ? BLEND_MODE_NEGATION : false;
constant bool BLEND_MODE_NOTBRIGHT [[function_constant(1026)]];
constant bool BLEND_MODE_NOTBRIGHT_tmp = is_function_constant_defined(BLEND_MODE_NOTBRIGHT) ? BLEND_MODE_NOTBRIGHT : false;
constant bool BLEND_MODE_OVERLAY [[function_constant(1027)]];
constant bool BLEND_MODE_OVERLAY_tmp = is_function_constant_defined(BLEND_MODE_OVERLAY) ? BLEND_MODE_OVERLAY : false;
constant bool BLEND_MODE_PIN_LIGHT [[function_constant(1028)]];
constant bool BLEND_MODE_PIN_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_PIN_LIGHT) ? BLEND_MODE_PIN_LIGHT : false;
constant bool BLEND_MODE_REALISTIC [[function_constant(1029)]];
constant bool BLEND_MODE_REALISTIC_tmp = is_function_constant_defined(BLEND_MODE_REALISTIC) ? BLEND_MODE_REALISTIC : false;
constant bool BLEND_MODE_SATURATION [[function_constant(1030)]];
constant bool BLEND_MODE_SATURATION_tmp = is_function_constant_defined(BLEND_MODE_SATURATION) ? BLEND_MODE_SATURATION : false;
constant bool BLEND_MODE_SOFT_LIGHT [[function_constant(1031)]];
constant bool BLEND_MODE_SOFT_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_SOFT_LIGHT) ? BLEND_MODE_SOFT_LIGHT : false;
constant bool BLEND_MODE_SUBTRACT [[function_constant(1032)]];
constant bool BLEND_MODE_SUBTRACT_tmp = is_function_constant_defined(BLEND_MODE_SUBTRACT) ? BLEND_MODE_SUBTRACT : false;
constant bool BLEND_MODE_VIVID_LIGHT [[function_constant(1033)]];
constant bool BLEND_MODE_VIVID_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_VIVID_LIGHT) ? BLEND_MODE_VIVID_LIGHT : false;
constant bool BOXSPAWN [[function_constant(1034)]];
constant bool BOXSPAWN_tmp = is_function_constant_defined(BOXSPAWN) ? BOXSPAWN : false;
constant bool COLORMINMAX [[function_constant(1035)]];
constant bool COLORMINMAX_tmp = is_function_constant_defined(COLORMINMAX) ? COLORMINMAX : false;
constant bool COLORMONOMIN [[function_constant(1036)]];
constant bool COLORMONOMIN_tmp = is_function_constant_defined(COLORMONOMIN) ? COLORMONOMIN : false;
constant bool COLORRAMP [[function_constant(1037)]];
constant bool COLORRAMP_tmp = is_function_constant_defined(COLORRAMP) ? COLORRAMP : false;
constant bool ENABLE_STIPPLE_PATTERN_TEST [[function_constant(1038)]];
constant bool ENABLE_STIPPLE_PATTERN_TEST_tmp = is_function_constant_defined(ENABLE_STIPPLE_PATTERN_TEST) ? ENABLE_STIPPLE_PATTERN_TEST : false;
constant bool EXTERNALTIME [[function_constant(1039)]];
constant bool EXTERNALTIME_tmp = is_function_constant_defined(EXTERNALTIME) ? EXTERNALTIME : false;
constant bool FLIPBOOKBLEND [[function_constant(1040)]];
constant bool FLIPBOOKBLEND_tmp = is_function_constant_defined(FLIPBOOKBLEND) ? FLIPBOOKBLEND : false;
constant bool FLIPBOOKBYLIFE [[function_constant(1041)]];
constant bool FLIPBOOKBYLIFE_tmp = is_function_constant_defined(FLIPBOOKBYLIFE) ? FLIPBOOKBYLIFE : false;
constant bool FLIPBOOK [[function_constant(1042)]];
constant bool FLIPBOOK_tmp = is_function_constant_defined(FLIPBOOK) ? FLIPBOOK : false;
constant bool FORCE [[function_constant(1043)]];
constant bool FORCE_tmp = is_function_constant_defined(FORCE) ? FORCE : false;
constant bool IGNORETRANSFORMSCALE [[function_constant(1044)]];
constant bool IGNORETRANSFORMSCALE_tmp = is_function_constant_defined(IGNORETRANSFORMSCALE) ? IGNORETRANSFORMSCALE : false;
constant bool IGNOREVEL [[function_constant(1045)]];
constant bool IGNOREVEL_tmp = is_function_constant_defined(IGNOREVEL) ? IGNOREVEL : false;
constant bool INILOCATION [[function_constant(1046)]];
constant bool INILOCATION_tmp = is_function_constant_defined(INILOCATION) ? INILOCATION : false;
constant bool INSTANTSPAWN [[function_constant(1047)]];
constant bool INSTANTSPAWN_tmp = is_function_constant_defined(INSTANTSPAWN) ? INSTANTSPAWN : false;
constant bool LIFETIMEMINMAX [[function_constant(1048)]];
constant bool LIFETIMEMINMAX_tmp = is_function_constant_defined(LIFETIMEMINMAX) ? LIFETIMEMINMAX : false;
constant bool NOISE [[function_constant(1049)]];
constant bool NOISE_tmp = is_function_constant_defined(NOISE) ? NOISE : false;
constant bool NORANDOFFSET [[function_constant(1050)]];
constant bool NORANDOFFSET_tmp = is_function_constant_defined(NORANDOFFSET) ? NORANDOFFSET : false;
constant bool NORMALTEX [[function_constant(1051)]];
constant bool NORMALTEX_tmp = is_function_constant_defined(NORMALTEX) ? NORMALTEX : false;
constant bool PBR [[function_constant(1052)]];
constant bool PBR_tmp = is_function_constant_defined(PBR) ? PBR : false;
constant bool PREMULTIPLIEDCOLOR [[function_constant(1053)]];
constant bool PREMULTIPLIEDCOLOR_tmp = is_function_constant_defined(PREMULTIPLIEDCOLOR) ? PREMULTIPLIEDCOLOR : false;
constant bool SCREENFADE [[function_constant(1054)]];
constant bool SCREENFADE_tmp = is_function_constant_defined(SCREENFADE) ? SCREENFADE : false;
constant bool SC_USE_CLAMP_TO_BORDER_colorRampTexture [[function_constant(1055)]];
constant bool SC_USE_CLAMP_TO_BORDER_colorRampTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_colorRampTexture) ? SC_USE_CLAMP_TO_BORDER_colorRampTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(1056)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_mainTexture [[function_constant(1057)]];
constant bool SC_USE_CLAMP_TO_BORDER_mainTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_mainTexture) ? SC_USE_CLAMP_TO_BORDER_mainTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_normalTex [[function_constant(1058)]];
constant bool SC_USE_CLAMP_TO_BORDER_normalTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_normalTex) ? SC_USE_CLAMP_TO_BORDER_normalTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_sizeRampTexture [[function_constant(1059)]];
constant bool SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_sizeRampTexture) ? SC_USE_CLAMP_TO_BORDER_sizeRampTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_velRampTexture [[function_constant(1060)]];
constant bool SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_velRampTexture) ? SC_USE_CLAMP_TO_BORDER_velRampTexture : false;
constant bool SC_USE_UV_MIN_MAX_colorRampTexture [[function_constant(1061)]];
constant bool SC_USE_UV_MIN_MAX_colorRampTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_colorRampTexture) ? SC_USE_UV_MIN_MAX_colorRampTexture : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(1062)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_mainTexture [[function_constant(1063)]];
constant bool SC_USE_UV_MIN_MAX_mainTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_mainTexture) ? SC_USE_UV_MIN_MAX_mainTexture : false;
constant bool SC_USE_UV_MIN_MAX_normalTex [[function_constant(1064)]];
constant bool SC_USE_UV_MIN_MAX_normalTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_normalTex) ? SC_USE_UV_MIN_MAX_normalTex : false;
constant bool SC_USE_UV_MIN_MAX_sizeRampTexture [[function_constant(1065)]];
constant bool SC_USE_UV_MIN_MAX_sizeRampTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_sizeRampTexture) ? SC_USE_UV_MIN_MAX_sizeRampTexture : false;
constant bool SC_USE_UV_MIN_MAX_velRampTexture [[function_constant(1066)]];
constant bool SC_USE_UV_MIN_MAX_velRampTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_velRampTexture) ? SC_USE_UV_MIN_MAX_velRampTexture : false;
constant bool SC_USE_UV_TRANSFORM_colorRampTexture [[function_constant(1067)]];
constant bool SC_USE_UV_TRANSFORM_colorRampTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_colorRampTexture) ? SC_USE_UV_TRANSFORM_colorRampTexture : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(1068)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_mainTexture [[function_constant(1069)]];
constant bool SC_USE_UV_TRANSFORM_mainTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_mainTexture) ? SC_USE_UV_TRANSFORM_mainTexture : false;
constant bool SC_USE_UV_TRANSFORM_normalTex [[function_constant(1070)]];
constant bool SC_USE_UV_TRANSFORM_normalTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_normalTex) ? SC_USE_UV_TRANSFORM_normalTex : false;
constant bool SC_USE_UV_TRANSFORM_sizeRampTexture [[function_constant(1071)]];
constant bool SC_USE_UV_TRANSFORM_sizeRampTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_sizeRampTexture) ? SC_USE_UV_TRANSFORM_sizeRampTexture : false;
constant bool SC_USE_UV_TRANSFORM_velRampTexture [[function_constant(1072)]];
constant bool SC_USE_UV_TRANSFORM_velRampTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_velRampTexture) ? SC_USE_UV_TRANSFORM_velRampTexture : false;
constant bool SIZEMINMAX [[function_constant(1073)]];
constant bool SIZEMINMAX_tmp = is_function_constant_defined(SIZEMINMAX) ? SIZEMINMAX : false;
constant bool SIZERAMP [[function_constant(1074)]];
constant bool SIZERAMP_tmp = is_function_constant_defined(SIZERAMP) ? SIZERAMP : false;
constant bool SNOISE [[function_constant(1075)]];
constant bool SNOISE_tmp = is_function_constant_defined(SNOISE) ? SNOISE : false;
constant bool SPHERESPAWN [[function_constant(1076)]];
constant bool SPHERESPAWN_tmp = is_function_constant_defined(SPHERESPAWN) ? SPHERESPAWN : false;
constant bool UseViewSpaceDepthVariant [[function_constant(1077)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool VELOCITYDIR [[function_constant(1078)]];
constant bool VELOCITYDIR_tmp = is_function_constant_defined(VELOCITYDIR) ? VELOCITYDIR : false;
constant bool VELRAMP [[function_constant(1079)]];
constant bool VELRAMP_tmp = is_function_constant_defined(VELRAMP) ? VELRAMP : false;
constant bool WORLDPOSSEED [[function_constant(1080)]];
constant bool WORLDPOSSEED_tmp = is_function_constant_defined(WORLDPOSSEED) ? WORLDPOSSEED : false;
constant bool colorRampTextureHasSwappedViews [[function_constant(1081)]];
constant bool colorRampTextureHasSwappedViews_tmp = is_function_constant_defined(colorRampTextureHasSwappedViews) ? colorRampTextureHasSwappedViews : false;
constant bool intensityTextureHasSwappedViews [[function_constant(1082)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool mainTextureHasSwappedViews [[function_constant(1083)]];
constant bool mainTextureHasSwappedViews_tmp = is_function_constant_defined(mainTextureHasSwappedViews) ? mainTextureHasSwappedViews : false;
constant bool normalTexHasSwappedViews [[function_constant(1084)]];
constant bool normalTexHasSwappedViews_tmp = is_function_constant_defined(normalTexHasSwappedViews) ? normalTexHasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(1085)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(1086)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(1087)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(1088)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(1089)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(1090)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(1091)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(1092)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(1093)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(1094)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(1095)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(1096)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(1097)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(1098)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(1099)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_DepthOnly [[function_constant(1100)]];
constant bool sc_DepthOnly_tmp = is_function_constant_defined(sc_DepthOnly) ? sc_DepthOnly : false;
constant bool sc_EnvmapDiffuseHasSwappedViews [[function_constant(1101)]];
constant bool sc_EnvmapDiffuseHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapDiffuseHasSwappedViews) ? sc_EnvmapDiffuseHasSwappedViews : false;
constant bool sc_EnvmapSpecularHasSwappedViews [[function_constant(1102)]];
constant bool sc_EnvmapSpecularHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapSpecularHasSwappedViews) ? sc_EnvmapSpecularHasSwappedViews : false;
constant bool sc_FramebufferFetch [[function_constant(1103)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_HasDiffuseEnvmap [[function_constant(1104)]];
constant bool sc_HasDiffuseEnvmap_tmp = is_function_constant_defined(sc_HasDiffuseEnvmap) ? sc_HasDiffuseEnvmap : false;
constant bool sc_LightEstimation [[function_constant(1105)]];
constant bool sc_LightEstimation_tmp = is_function_constant_defined(sc_LightEstimation) ? sc_LightEstimation : false;
constant bool sc_MotionVectorsPass [[function_constant(1106)]];
constant bool sc_MotionVectorsPass_tmp = is_function_constant_defined(sc_MotionVectorsPass) ? sc_MotionVectorsPass : false;
constant bool sc_OITCompositingPass [[function_constant(1107)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(1108)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(1109)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(1110)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_ProjectiveShadowsReceiver [[function_constant(1111)]];
constant bool sc_ProjectiveShadowsReceiver_tmp = is_function_constant_defined(sc_ProjectiveShadowsReceiver) ? sc_ProjectiveShadowsReceiver : false;
constant bool sc_RayTracedAoTextureHasSwappedViews [[function_constant(1112)]];
constant bool sc_RayTracedAoTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedAoTextureHasSwappedViews) ? sc_RayTracedAoTextureHasSwappedViews : false;
constant bool sc_RayTracedDiffIndTextureHasSwappedViews [[function_constant(1113)]];
constant bool sc_RayTracedDiffIndTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureHasSwappedViews) ? sc_RayTracedDiffIndTextureHasSwappedViews : false;
constant bool sc_RayTracedReflectionTextureHasSwappedViews [[function_constant(1114)]];
constant bool sc_RayTracedReflectionTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureHasSwappedViews) ? sc_RayTracedReflectionTextureHasSwappedViews : false;
constant bool sc_RayTracedShadowTextureHasSwappedViews [[function_constant(1115)]];
constant bool sc_RayTracedShadowTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedShadowTextureHasSwappedViews) ? sc_RayTracedShadowTextureHasSwappedViews : false;
constant bool sc_RenderAlphaToColor [[function_constant(1116)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_SSAOEnabled [[function_constant(1117)]];
constant bool sc_SSAOEnabled_tmp = is_function_constant_defined(sc_SSAOEnabled) ? sc_SSAOEnabled : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(1118)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(1119)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(1120)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant bool sc_VertexBlendingUseNormals [[function_constant(1121)]];
constant bool sc_VertexBlendingUseNormals_tmp = is_function_constant_defined(sc_VertexBlendingUseNormals) ? sc_VertexBlendingUseNormals : false;
constant bool sc_VertexBlending [[function_constant(1122)]];
constant bool sc_VertexBlending_tmp = is_function_constant_defined(sc_VertexBlending) ? sc_VertexBlending : false;
constant bool sizeRampTextureHasSwappedViews [[function_constant(1123)]];
constant bool sizeRampTextureHasSwappedViews_tmp = is_function_constant_defined(sizeRampTextureHasSwappedViews) ? sizeRampTextureHasSwappedViews : false;
constant bool velRampTextureHasSwappedViews [[function_constant(1124)]];
constant bool velRampTextureHasSwappedViews_tmp = is_function_constant_defined(velRampTextureHasSwappedViews) ? velRampTextureHasSwappedViews : false;
constant int MESHTYPE [[function_constant(1125)]];
constant int MESHTYPE_tmp = is_function_constant_defined(MESHTYPE) ? MESHTYPE : 0;
constant int SC_DEVICE_CLASS [[function_constant(1126)]];
constant int SC_DEVICE_CLASS_tmp = is_function_constant_defined(SC_DEVICE_CLASS) ? SC_DEVICE_CLASS : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_colorRampTexture [[function_constant(1127)]];
constant int SC_SOFTWARE_WRAP_MODE_U_colorRampTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture) ? SC_SOFTWARE_WRAP_MODE_U_colorRampTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(1128)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_mainTexture [[function_constant(1129)]];
constant int SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_mainTexture) ? SC_SOFTWARE_WRAP_MODE_U_mainTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_normalTex [[function_constant(1130)]];
constant int SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_normalTex) ? SC_SOFTWARE_WRAP_MODE_U_normalTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture [[function_constant(1131)]];
constant int SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture) ? SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_velRampTexture [[function_constant(1132)]];
constant int SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_velRampTexture) ? SC_SOFTWARE_WRAP_MODE_U_velRampTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_colorRampTexture [[function_constant(1133)]];
constant int SC_SOFTWARE_WRAP_MODE_V_colorRampTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_colorRampTexture) ? SC_SOFTWARE_WRAP_MODE_V_colorRampTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(1134)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_mainTexture [[function_constant(1135)]];
constant int SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_mainTexture) ? SC_SOFTWARE_WRAP_MODE_V_mainTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_normalTex [[function_constant(1136)]];
constant int SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_normalTex) ? SC_SOFTWARE_WRAP_MODE_V_normalTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture [[function_constant(1137)]];
constant int SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture) ? SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_velRampTexture [[function_constant(1138)]];
constant int SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_velRampTexture) ? SC_SOFTWARE_WRAP_MODE_V_velRampTexture : -1;
constant int colorRampTextureLayout [[function_constant(1139)]];
constant int colorRampTextureLayout_tmp = is_function_constant_defined(colorRampTextureLayout) ? colorRampTextureLayout : 0;
constant int intensityTextureLayout [[function_constant(1140)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int mainTextureLayout [[function_constant(1141)]];
constant int mainTextureLayout_tmp = is_function_constant_defined(mainTextureLayout) ? mainTextureLayout : 0;
constant int normalTexLayout [[function_constant(1142)]];
constant int normalTexLayout_tmp = is_function_constant_defined(normalTexLayout) ? normalTexLayout : 0;
constant int rotationSpace [[function_constant(1143)]];
constant int rotationSpace_tmp = is_function_constant_defined(rotationSpace) ? rotationSpace : 0;
constant int sc_AmbientLightMode0 [[function_constant(1144)]];
constant int sc_AmbientLightMode0_tmp = is_function_constant_defined(sc_AmbientLightMode0) ? sc_AmbientLightMode0 : 0;
constant int sc_AmbientLightMode1 [[function_constant(1145)]];
constant int sc_AmbientLightMode1_tmp = is_function_constant_defined(sc_AmbientLightMode1) ? sc_AmbientLightMode1 : 0;
constant int sc_AmbientLightMode2 [[function_constant(1146)]];
constant int sc_AmbientLightMode2_tmp = is_function_constant_defined(sc_AmbientLightMode2) ? sc_AmbientLightMode2 : 0;
constant int sc_AmbientLightMode_Constant [[function_constant(1147)]];
constant int sc_AmbientLightMode_Constant_tmp = is_function_constant_defined(sc_AmbientLightMode_Constant) ? sc_AmbientLightMode_Constant : 0;
constant int sc_AmbientLightMode_EnvironmentMap [[function_constant(1148)]];
constant int sc_AmbientLightMode_EnvironmentMap_tmp = is_function_constant_defined(sc_AmbientLightMode_EnvironmentMap) ? sc_AmbientLightMode_EnvironmentMap : 0;
constant int sc_AmbientLightMode_FromCamera [[function_constant(1149)]];
constant int sc_AmbientLightMode_FromCamera_tmp = is_function_constant_defined(sc_AmbientLightMode_FromCamera) ? sc_AmbientLightMode_FromCamera : 0;
constant int sc_AmbientLightMode_SphericalHarmonics [[function_constant(1150)]];
constant int sc_AmbientLightMode_SphericalHarmonics_tmp = is_function_constant_defined(sc_AmbientLightMode_SphericalHarmonics) ? sc_AmbientLightMode_SphericalHarmonics : 0;
constant int sc_AmbientLightsCount [[function_constant(1151)]];
constant int sc_AmbientLightsCount_tmp = is_function_constant_defined(sc_AmbientLightsCount) ? sc_AmbientLightsCount : 0;
constant int sc_DepthBufferMode [[function_constant(1152)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_DirectionalLightsCount [[function_constant(1153)]];
constant int sc_DirectionalLightsCount_tmp = is_function_constant_defined(sc_DirectionalLightsCount) ? sc_DirectionalLightsCount : 0;
constant int sc_EnvLightMode [[function_constant(1154)]];
constant int sc_EnvLightMode_tmp = is_function_constant_defined(sc_EnvLightMode) ? sc_EnvLightMode : 0;
constant int sc_EnvmapDiffuseLayout [[function_constant(1155)]];
constant int sc_EnvmapDiffuseLayout_tmp = is_function_constant_defined(sc_EnvmapDiffuseLayout) ? sc_EnvmapDiffuseLayout : 0;
constant int sc_EnvmapSpecularLayout [[function_constant(1156)]];
constant int sc_EnvmapSpecularLayout_tmp = is_function_constant_defined(sc_EnvmapSpecularLayout) ? sc_EnvmapSpecularLayout : 0;
constant int sc_LightEstimationSGCount [[function_constant(1157)]];
constant int sc_LightEstimationSGCount_tmp = is_function_constant_defined(sc_LightEstimationSGCount) ? sc_LightEstimationSGCount : 0;
constant int sc_MaxTextureImageUnits [[function_constant(1158)]];
constant int sc_MaxTextureImageUnits_tmp = is_function_constant_defined(sc_MaxTextureImageUnits) ? sc_MaxTextureImageUnits : 0;
constant int sc_PointLightsCount [[function_constant(1159)]];
constant int sc_PointLightsCount_tmp = is_function_constant_defined(sc_PointLightsCount) ? sc_PointLightsCount : 0;
constant int sc_RayTracedAoTextureLayout [[function_constant(1160)]];
constant int sc_RayTracedAoTextureLayout_tmp = is_function_constant_defined(sc_RayTracedAoTextureLayout) ? sc_RayTracedAoTextureLayout : 0;
constant int sc_RayTracedDiffIndTextureLayout [[function_constant(1161)]];
constant int sc_RayTracedDiffIndTextureLayout_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureLayout) ? sc_RayTracedDiffIndTextureLayout : 0;
constant int sc_RayTracedReflectionTextureLayout [[function_constant(1162)]];
constant int sc_RayTracedReflectionTextureLayout_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureLayout) ? sc_RayTracedReflectionTextureLayout : 0;
constant int sc_RayTracedShadowTextureLayout [[function_constant(1163)]];
constant int sc_RayTracedShadowTextureLayout_tmp = is_function_constant_defined(sc_RayTracedShadowTextureLayout) ? sc_RayTracedShadowTextureLayout : 0;
constant int sc_RenderingSpace [[function_constant(1164)]];
constant int sc_RenderingSpace_tmp = is_function_constant_defined(sc_RenderingSpace) ? sc_RenderingSpace : -1;
constant int sc_ScreenTextureLayout [[function_constant(1165)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_SkinBonesCount [[function_constant(1166)]];
constant int sc_SkinBonesCount_tmp = is_function_constant_defined(sc_SkinBonesCount) ? sc_SkinBonesCount : 0;
constant int sc_StereoRenderingMode [[function_constant(1167)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1168)]];
constant int sc_StereoRendering_IsClipDistanceEnabled_tmp = is_function_constant_defined(sc_StereoRendering_IsClipDistanceEnabled) ? sc_StereoRendering_IsClipDistanceEnabled : 0;
constant int sizeRampTextureLayout [[function_constant(1169)]];
constant int sizeRampTextureLayout_tmp = is_function_constant_defined(sizeRampTextureLayout) ? sizeRampTextureLayout : 0;
constant int velRampTextureLayout [[function_constant(1170)]];
constant int velRampTextureLayout_tmp = is_function_constant_defined(velRampTextureLayout) ? velRampTextureLayout : 0;

namespace SNAP_VS {
struct sc_Vertex_t
{
float4 position;
float3 normal;
float3 tangent;
float2 texture0;
float2 texture1;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float2 Surface_UVCoord0;
float4 VertexColor;
float3 SurfacePosition_ObjectSpace;
float3 VertexNormal_WorldSpace;
float3 VertexNormal_ObjectSpace;
float gInstanceID;
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
float timeGlobal;
float externalTimeInput;
float externalSeed;
float lifeTimeConstant;
float2 lifeTimeMinMax;
float spawnDuration;
float3 spawnLocation;
float3 spawnBox;
float3 spawnSphere;
float3 noiseMult;
float3 noiseFrequency;
float3 sNoiseMult;
float3 sNoiseFrequency;
float3 velocityMin;
float3 velocityMax;
float3 velocityDrag;
float4 velRampTextureSize;
float4 velRampTextureDims;
float4 velRampTextureView;
float3x3 velRampTextureTransform;
float4 velRampTextureUvMinMax;
float4 velRampTextureBorderColor;
float2 sizeStart;
float3 sizeStart3D;
float2 sizeEnd;
float3 sizeEnd3D;
float2 sizeStartMin;
float3 sizeStartMin3D;
float2 sizeStartMax;
float3 sizeStartMax3D;
float2 sizeEndMin;
float3 sizeEndMin3D;
float2 sizeEndMax;
float3 sizeEndMax3D;
float sizeSpeed;
float4 sizeRampTextureSize;
float4 sizeRampTextureDims;
float4 sizeRampTextureView;
float3x3 sizeRampTextureTransform;
float4 sizeRampTextureUvMinMax;
float4 sizeRampTextureBorderColor;
float gravity;
float3 localForce;
float sizeVelScale;
int ALIGNTOX;
int ALIGNTOY;
int ALIGNTOZ;
float2 rotationRandomX;
float2 rotationRateX;
float2 randomRotationY;
float2 rotationRateY;
float2 rotationRandom;
float2 randomRotationZ;
float2 rotationRate;
float2 rotationRateZ;
float rotationDrag;
int CENTER_BBOX;
float fadeDistanceVisible;
float fadeDistanceInvisible;
float3 colorStart;
float3 colorEnd;
float3 colorMinStart;
float3 colorMinEnd;
float3 colorMaxStart;
float3 colorMaxEnd;
float alphaStart;
float alphaEnd;
float alphaMinStart;
float alphaMinEnd;
float alphaMaxStart;
float alphaMaxEnd;
float alphaDissolveMult;
float numValidFrames;
float2 gridSize;
float flipBookSpeedMult;
float flipBookRandomStart;
float4 colorRampTextureSize;
float4 colorRampTextureDims;
float4 colorRampTextureView;
float3x3 colorRampTextureTransform;
float4 colorRampTextureUvMinMax;
float4 colorRampTextureBorderColor;
float4 colorRampMult;
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float metallic;
float roughness;
float Port_Input1_N119;
float2 Port_Input1_N138;
float2 Port_Input1_N139;
float2 Port_Input1_N140;
float2 Port_Input1_N144;
float Port_Input1_N069;
float Port_Input1_N068;
float Port_Input1_N110;
float Port_Input1_N154;
float3 Port_Default_N167;
float3 Port_Emissive_N014;
float3 Port_AO_N014;
float3 Port_SpecularAO_N014;
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
struct sc_Set2
{
constant sc_Bones_obj* sc_BonesUBO [[id(0)]];
texture2d<float> colorRampTexture [[id(1)]];
texture2d<float> intensityTexture [[id(2)]];
texture2d<float> mainTexture [[id(3)]];
texture2d<float> normalTex [[id(4)]];
texture2d<float> sc_EnvmapDiffuse [[id(5)]];
texture2d<float> sc_EnvmapSpecular [[id(6)]];
texture2d<float> sc_RayTracedAoTexture [[id(15)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(16)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(17)]];
texture2d<float> sc_RayTracedShadowTexture [[id(18)]];
texture2d<float> sc_SSAOTexture [[id(19)]];
texture2d<float> sc_ScreenTexture [[id(20)]];
texture2d<float> sc_ShadowTexture [[id(21)]];
texture2d<float> sizeRampTexture [[id(23)]];
texture2d<float> velRampTexture [[id(24)]];
sampler colorRampTextureSmpSC [[id(25)]];
sampler intensityTextureSmpSC [[id(26)]];
sampler mainTextureSmpSC [[id(27)]];
sampler normalTexSmpSC [[id(28)]];
sampler sc_EnvmapDiffuseSmpSC [[id(29)]];
sampler sc_EnvmapSpecularSmpSC [[id(30)]];
sampler sc_RayTracedAoTextureSmpSC [[id(32)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(33)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(34)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(35)]];
sampler sc_SSAOTextureSmpSC [[id(36)]];
sampler sc_ScreenTextureSmpSC [[id(37)]];
sampler sc_ShadowTextureSmpSC [[id(38)]];
sampler sizeRampTextureSmpSC [[id(40)]];
sampler velRampTextureSmpSC [[id(41)]];
constant userUniformsObj* UserUniforms [[id(42)]];
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
float Interpolator_gInstanceID [[user(locn13)]];
float4 Interpolator0 [[user(locn14)]];
float4 Interpolator1 [[user(locn15)]];
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
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
bool N111_ENABLE_ALIGNTOX=false;
bool N111_ENABLE_ALIGNTOY=false;
bool N111_ENABLE_ALIGNTOZ=false;
bool N111_ENABLE_CENTER_IN_BBOX=false;
bool N111_MESHTYPE_QUAD=false;
float3 N111_particleSeedIn=float3(0.0);
float N111_globalSeedIn=0.0;
float N111_dieTrigger=0.0;
float4 N111_timeValuesIn=float4(0.0);
float3 N111_positionObjectSpace=float3(0.0);
float3 N111_normalObjectSpace=float3(0.0);
bool N111_ENABLE_INILOCATION=false;
float3 N111_spawnLocation=float3(0.0);
bool N111_ENABLE_BOXSPAWN=false;
float3 N111_spawnBox=float3(0.0);
bool N111_ENABLE_SPHERESPAWN=false;
float3 N111_spawnSphere=float3(0.0);
bool N111_ENABLE_NOISE=false;
float3 N111_noiseMult=float3(0.0);
float3 N111_noiseFrequency=float3(0.0);
bool N111_ENABLE_SNOISE=false;
float3 N111_sNoiseMult=float3(0.0);
float3 N111_sNoiseFrequency=float3(0.0);
bool N111_ENABLE_VELRAMP=false;
float3 N111_velocityMin=float3(0.0);
float3 N111_velocityMax=float3(0.0);
float3 N111_velocityDrag=float3(0.0);
float3 N111_sizeStart=float3(0.0);
float3 N111_sizeEnd=float3(0.0);
bool N111_ENABLE_SIZEMINMAX=false;
float3 N111_sizeStartMin=float3(0.0);
float3 N111_sizeStartMax=float3(0.0);
float3 N111_sizeEndMin=float3(0.0);
float3 N111_sizeEndMax=float3(0.0);
float N111_sizeSpeed=0.0;
bool N111_ENABLE_SIZERAMP=false;
float N111_gravity=0.0;
bool N111_ENABLE_FORCE=false;
float3 N111_localForce=float3(0.0);
bool N111_ENABLE_ALIGNTOVEL=false;
float N111_sizeVelScale=0.0;
bool N111_ENABLE_IGNOREVEL=false;
bool N111_ENABLE_IGNORETRANSFORMSCALE=false;
float2 N111_rotationRandomX=float2(0.0);
float2 N111_rotationRateX=float2(0.0);
float2 N111_rotationRandomY=float2(0.0);
float2 N111_rotationRateY=float2(0.0);
float2 N111_rotationRandomZ=float2(0.0);
float2 N111_rotationRateZ=float2(0.0);
float N111_rotationDrag=0.0;
bool N111_WORLDSPACE=false;
bool N111_WORLDFORCE=false;
bool N111_ENABLE_SCREENFADE=false;
float N111_fadeDistanceVisible=0.0;
float N111_fadeDistanceInvisible=0.0;
float3 N111_particleSeed=float3(0.0);
float N111_globalSeed=0.0;
float4 N111_timeValues=float4(0.0);
float N111_nearCameraFade=0.0;
float3 N111_position=float3(0.0);
float3 N111_normal=float3(0.0);
float N111_EPSILON=1e-06;
float N111_PI=3.1415927;
float N173_timeGlobal=0.0;
bool N173_ENABLE_EXTERNALTIME=false;
float N173_externalTime=0.0;
bool N173_ENABLE_WORLDPOSSEED=false;
float N173_externalSeed=0.0;
bool N173_ENABLE_LIFETIMEMINMAX=false;
float N173_lifeTimeConstant=0.0;
float2 N173_lifeTimeMinMax=float2(0.0);
bool N173_ENABLE_INSTANTSPAWN=false;
float N173_spawnDuration=0.0;
float3 N173_particleSeed=float3(0.0);
float N173_globalSeed=0.0;
float N173_dieTrigger=0.0;
float4 N173_timeValues=float4(0.0);
out.PreviewVertexColor=float4(0.5);
ssPreviewInfo PreviewInfo;
PreviewInfo.Color=float4(0.5);
PreviewInfo.Saved=false;
out.PreviewVertexSaved=0.0;
sc_Vertex_t l9_0;
l9_0.position=in.position;
l9_0.normal=in.normal;
l9_0.tangent=in.tangent.xyz;
l9_0.texture0=in.texture0;
l9_0.texture1=in.texture1;
sc_Vertex_t l9_1=l9_0;
sc_Vertex_t param=l9_1;
sc_Vertex_t l9_2=param;
if ((int(sc_VertexBlending_tmp)!=0))
{
if ((int(sc_VertexBlendingUseNormals_tmp)!=0))
{
sc_Vertex_t l9_3=l9_2;
float3 l9_4=in.blendShape0Pos;
float3 l9_5=in.blendShape0Normal;
float l9_6=(*sc_set2.UserUniforms).weights0.x;
sc_Vertex_t l9_7=l9_3;
float3 l9_8=l9_4;
float l9_9=l9_6;
float3 l9_10=l9_7.position.xyz+(l9_8*l9_9);
l9_7.position=float4(l9_10.x,l9_10.y,l9_10.z,l9_7.position.w);
l9_3=l9_7;
l9_3.normal+=(l9_5*l9_6);
l9_2=l9_3;
sc_Vertex_t l9_11=l9_2;
float3 l9_12=in.blendShape1Pos;
float3 l9_13=in.blendShape1Normal;
float l9_14=(*sc_set2.UserUniforms).weights0.y;
sc_Vertex_t l9_15=l9_11;
float3 l9_16=l9_12;
float l9_17=l9_14;
float3 l9_18=l9_15.position.xyz+(l9_16*l9_17);
l9_15.position=float4(l9_18.x,l9_18.y,l9_18.z,l9_15.position.w);
l9_11=l9_15;
l9_11.normal+=(l9_13*l9_14);
l9_2=l9_11;
sc_Vertex_t l9_19=l9_2;
float3 l9_20=in.blendShape2Pos;
float3 l9_21=in.blendShape2Normal;
float l9_22=(*sc_set2.UserUniforms).weights0.z;
sc_Vertex_t l9_23=l9_19;
float3 l9_24=l9_20;
float l9_25=l9_22;
float3 l9_26=l9_23.position.xyz+(l9_24*l9_25);
l9_23.position=float4(l9_26.x,l9_26.y,l9_26.z,l9_23.position.w);
l9_19=l9_23;
l9_19.normal+=(l9_21*l9_22);
l9_2=l9_19;
}
else
{
sc_Vertex_t l9_27=l9_2;
float3 l9_28=in.blendShape0Pos;
float l9_29=(*sc_set2.UserUniforms).weights0.x;
float3 l9_30=l9_27.position.xyz+(l9_28*l9_29);
l9_27.position=float4(l9_30.x,l9_30.y,l9_30.z,l9_27.position.w);
l9_2=l9_27;
sc_Vertex_t l9_31=l9_2;
float3 l9_32=in.blendShape1Pos;
float l9_33=(*sc_set2.UserUniforms).weights0.y;
float3 l9_34=l9_31.position.xyz+(l9_32*l9_33);
l9_31.position=float4(l9_34.x,l9_34.y,l9_34.z,l9_31.position.w);
l9_2=l9_31;
sc_Vertex_t l9_35=l9_2;
float3 l9_36=in.blendShape2Pos;
float l9_37=(*sc_set2.UserUniforms).weights0.z;
float3 l9_38=l9_35.position.xyz+(l9_36*l9_37);
l9_35.position=float4(l9_38.x,l9_38.y,l9_38.z,l9_35.position.w);
l9_2=l9_35;
sc_Vertex_t l9_39=l9_2;
float3 l9_40=in.blendShape3Pos;
float l9_41=(*sc_set2.UserUniforms).weights0.w;
float3 l9_42=l9_39.position.xyz+(l9_40*l9_41);
l9_39.position=float4(l9_42.x,l9_42.y,l9_42.z,l9_39.position.w);
l9_2=l9_39;
sc_Vertex_t l9_43=l9_2;
float3 l9_44=in.blendShape4Pos;
float l9_45=(*sc_set2.UserUniforms).weights1.x;
float3 l9_46=l9_43.position.xyz+(l9_44*l9_45);
l9_43.position=float4(l9_46.x,l9_46.y,l9_46.z,l9_43.position.w);
l9_2=l9_43;
sc_Vertex_t l9_47=l9_2;
float3 l9_48=in.blendShape5Pos;
float l9_49=(*sc_set2.UserUniforms).weights1.y;
float3 l9_50=l9_47.position.xyz+(l9_48*l9_49);
l9_47.position=float4(l9_50.x,l9_50.y,l9_50.z,l9_47.position.w);
l9_2=l9_47;
}
}
param=l9_2;
sc_Vertex_t l9_51=param;
if (sc_SkinBonesCount_tmp>0)
{
float4 l9_52=float4(0.0);
if (sc_SkinBonesCount_tmp>0)
{
l9_52=float4(1.0,fract(in.boneData.yzw));
l9_52.x-=dot(l9_52.yzw,float3(1.0));
}
float4 l9_53=l9_52;
float4 l9_54=l9_53;
int l9_55=0;
int l9_56=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_56=int(in.boneData[l9_55]);
}
int l9_57=l9_56;
int l9_58=l9_57;
int l9_59=1;
int l9_60=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_60=int(in.boneData[l9_59]);
}
int l9_61=l9_60;
int l9_62=l9_61;
int l9_63=2;
int l9_64=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_64=int(in.boneData[l9_63]);
}
int l9_65=l9_64;
int l9_66=l9_65;
int l9_67=3;
int l9_68=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_68=int(in.boneData[l9_67]);
}
int l9_69=l9_68;
int l9_70=l9_69;
int l9_71=l9_58;
float4 l9_72=l9_51.position;
float3 l9_73=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_74=l9_71;
float4 l9_75=(*sc_set2.sc_BonesUBO).sc_Bones[l9_74].boneMatrix[0];
float4 l9_76=(*sc_set2.sc_BonesUBO).sc_Bones[l9_74].boneMatrix[1];
float4 l9_77=(*sc_set2.sc_BonesUBO).sc_Bones[l9_74].boneMatrix[2];
float4 l9_78[3];
l9_78[0]=l9_75;
l9_78[1]=l9_76;
l9_78[2]=l9_77;
l9_73=float3(dot(l9_72,l9_78[0]),dot(l9_72,l9_78[1]),dot(l9_72,l9_78[2]));
}
else
{
l9_73=l9_72.xyz;
}
float3 l9_79=l9_73;
float3 l9_80=l9_79;
float l9_81=l9_54.x;
int l9_82=l9_62;
float4 l9_83=l9_51.position;
float3 l9_84=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_85=l9_82;
float4 l9_86=(*sc_set2.sc_BonesUBO).sc_Bones[l9_85].boneMatrix[0];
float4 l9_87=(*sc_set2.sc_BonesUBO).sc_Bones[l9_85].boneMatrix[1];
float4 l9_88=(*sc_set2.sc_BonesUBO).sc_Bones[l9_85].boneMatrix[2];
float4 l9_89[3];
l9_89[0]=l9_86;
l9_89[1]=l9_87;
l9_89[2]=l9_88;
l9_84=float3(dot(l9_83,l9_89[0]),dot(l9_83,l9_89[1]),dot(l9_83,l9_89[2]));
}
else
{
l9_84=l9_83.xyz;
}
float3 l9_90=l9_84;
float3 l9_91=l9_90;
float l9_92=l9_54.y;
int l9_93=l9_66;
float4 l9_94=l9_51.position;
float3 l9_95=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_96=l9_93;
float4 l9_97=(*sc_set2.sc_BonesUBO).sc_Bones[l9_96].boneMatrix[0];
float4 l9_98=(*sc_set2.sc_BonesUBO).sc_Bones[l9_96].boneMatrix[1];
float4 l9_99=(*sc_set2.sc_BonesUBO).sc_Bones[l9_96].boneMatrix[2];
float4 l9_100[3];
l9_100[0]=l9_97;
l9_100[1]=l9_98;
l9_100[2]=l9_99;
l9_95=float3(dot(l9_94,l9_100[0]),dot(l9_94,l9_100[1]),dot(l9_94,l9_100[2]));
}
else
{
l9_95=l9_94.xyz;
}
float3 l9_101=l9_95;
float3 l9_102=l9_101;
float l9_103=l9_54.z;
int l9_104=l9_70;
float4 l9_105=l9_51.position;
float3 l9_106=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_107=l9_104;
float4 l9_108=(*sc_set2.sc_BonesUBO).sc_Bones[l9_107].boneMatrix[0];
float4 l9_109=(*sc_set2.sc_BonesUBO).sc_Bones[l9_107].boneMatrix[1];
float4 l9_110=(*sc_set2.sc_BonesUBO).sc_Bones[l9_107].boneMatrix[2];
float4 l9_111[3];
l9_111[0]=l9_108;
l9_111[1]=l9_109;
l9_111[2]=l9_110;
l9_106=float3(dot(l9_105,l9_111[0]),dot(l9_105,l9_111[1]),dot(l9_105,l9_111[2]));
}
else
{
l9_106=l9_105.xyz;
}
float3 l9_112=l9_106;
float3 l9_113=(((l9_80*l9_81)+(l9_91*l9_92))+(l9_102*l9_103))+(l9_112*l9_54.w);
l9_51.position=float4(l9_113.x,l9_113.y,l9_113.z,l9_51.position.w);
int l9_114=l9_58;
float3x3 l9_115=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_114].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_114].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_114].normalMatrix[2].xyz));
float3x3 l9_116=l9_115;
float3x3 l9_117=l9_116;
int l9_118=l9_62;
float3x3 l9_119=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_118].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_118].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_118].normalMatrix[2].xyz));
float3x3 l9_120=l9_119;
float3x3 l9_121=l9_120;
int l9_122=l9_66;
float3x3 l9_123=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_122].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_122].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_122].normalMatrix[2].xyz));
float3x3 l9_124=l9_123;
float3x3 l9_125=l9_124;
int l9_126=l9_70;
float3x3 l9_127=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_126].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_126].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_126].normalMatrix[2].xyz));
float3x3 l9_128=l9_127;
float3x3 l9_129=l9_128;
l9_51.normal=((((l9_117*l9_51.normal)*l9_54.x)+((l9_121*l9_51.normal)*l9_54.y))+((l9_125*l9_51.normal)*l9_54.z))+((l9_129*l9_51.normal)*l9_54.w);
l9_51.tangent=((((l9_117*l9_51.tangent)*l9_54.x)+((l9_121*l9_51.tangent)*l9_54.y))+((l9_125*l9_51.tangent)*l9_54.z))+((l9_129*l9_51.tangent)*l9_54.w);
}
param=l9_51;
if (sc_RenderingSpace_tmp==3)
{
out.varPos=float3(0.0);
out.varNormal=param.normal;
out.varTangent=float4(param.tangent.x,param.tangent.y,param.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==4)
{
out.varPos=float3(0.0);
out.varNormal=param.normal;
out.varTangent=float4(param.tangent.x,param.tangent.y,param.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
out.varPos=param.position.xyz;
out.varNormal=param.normal;
out.varTangent=float4(param.tangent.x,param.tangent.y,param.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
out.varPos=((*sc_set2.UserUniforms).sc_ModelMatrix*param.position).xyz;
out.varNormal=(*sc_set2.UserUniforms).sc_NormalMatrix*param.normal;
float3 l9_130=(*sc_set2.UserUniforms).sc_NormalMatrix*param.tangent;
out.varTangent=float4(l9_130.x,l9_130.y,l9_130.z,out.varTangent.w);
}
}
}
}
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
param.texture0.x=1.0-param.texture0.x;
}
out.varColor=in.color;
sc_Vertex_t v=param;
float l9_131;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_131=(*sc_set2.UserUniforms).overrideTimeElapsed;
}
else
{
l9_131=(*sc_set2.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_131;
float l9_132;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_132=(*sc_set2.UserUniforms).overrideTimeDelta;
}
else
{
l9_132=(*sc_set2.UserUniforms).sc_Time.y;
}
Globals.gTimeDelta=l9_132;
Globals.Surface_UVCoord0=v.texture0;
Globals.VertexColor=out.varColor;
Globals.SurfacePosition_ObjectSpace=((*sc_set2.UserUniforms).sc_ModelMatrixInverse*float4(out.varPos,1.0)).xyz;
Globals.VertexNormal_WorldSpace=out.varNormal;
Globals.VertexNormal_ObjectSpace=normalize(((*sc_set2.UserUniforms).sc_ModelMatrixInverse*float4(Globals.VertexNormal_WorldSpace,0.0)).xyz);
int l9_133=gl_InstanceIndex;
Globals.gInstanceID=float(l9_133)+0.5;
float3 WorldPosition=out.varPos;
float3 WorldNormal=out.varNormal;
float3 WorldTangent=out.varTangent.xyz;
float Output_N3=0.0;
float param_1=(*sc_set2.UserUniforms).timeGlobal;
Output_N3=param_1;
float Output_N5=0.0;
float param_2=(*sc_set2.UserUniforms).externalTimeInput;
Output_N5=param_2;
float Output_N7=0.0;
float param_3=(*sc_set2.UserUniforms).externalSeed;
Output_N7=param_3;
float Output_N9=0.0;
float param_4=(*sc_set2.UserUniforms).lifeTimeConstant;
Output_N9=param_4;
float2 Output_N10=float2(0.0);
float2 param_5=(*sc_set2.UserUniforms).lifeTimeMinMax;
Output_N10=param_5;
float Output_N12=0.0;
float param_6=(*sc_set2.UserUniforms).spawnDuration;
Output_N12=param_6;
float3 particleSeed_N173=float3(0.0);
float globalSeed_N173=0.0;
float dieTrigger_N173=0.0;
float4 timeValues_N173=float4(0.0);
float param_7=Output_N3;
float param_8=Output_N5;
float param_9=Output_N7;
float param_10=Output_N9;
float2 param_11=Output_N10;
float param_12=Output_N12;
ssGlobals param_17=Globals;
ssGlobals tempGlobals=param_17;
float3 param_13=float3(0.0);
float param_14=0.0;
float param_15=0.0;
float4 param_16=float4(0.0);
N173_timeGlobal=param_7;
N173_ENABLE_EXTERNALTIME=(int(EXTERNALTIME_tmp)!=0);
N173_externalTime=param_8;
N173_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N173_externalSeed=param_9;
N173_ENABLE_LIFETIMEMINMAX=(int(LIFETIMEMINMAX_tmp)!=0);
N173_lifeTimeConstant=param_10;
N173_lifeTimeMinMax=param_11;
N173_ENABLE_INSTANTSPAWN=(int(INSTANTSPAWN_tmp)!=0);
N173_spawnDuration=param_12;
float l9_134=0.0;
if (N173_ENABLE_WORLDPOSSEED)
{
float4x4 l9_135=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_134=length(float4(1.0)*l9_135);
}
N173_globalSeed=N173_externalSeed+l9_134;
float l9_136=2000.0;
int l9_137=0;
int l9_138=gl_InstanceIndex;
l9_137=l9_138;
int l9_139=l9_137;
float l9_140=float(l9_139);
float2 l9_141=float2(mod(l9_140,l9_136),floor(l9_140/l9_136));
l9_141/=float2(l9_136);
float2 l9_142=l9_141;
float l9_143=dot(l9_142,float2(0.38253,0.42662001));
float3 l9_144=float3(0.457831,0.62343299,0.97625297)*l9_143;
l9_144=sin(l9_144)*float3(479.371,389.53101,513.03497);
l9_144=fract(l9_144);
l9_144=floor(l9_144*10000.0)*9.9999997e-05;
float3 l9_145=l9_144;
float3 l9_146=l9_145;
N173_particleSeed=l9_146;
float l9_147=fract((N173_particleSeed.y*12.12358)+N173_globalSeed);
float l9_148=fract((N173_particleSeed.z*3.5358)+N173_globalSeed);
float2 l9_149=float2(N173_lifeTimeConstant);
if (N173_ENABLE_LIFETIMEMINMAX)
{
l9_149=N173_lifeTimeMinMax;
}
float l9_150=fast::max(l9_149.x,0.0099999998);
float l9_151=fast::max(l9_149.y,0.0099999998);
float l9_152=tempGlobals.gTimeElapsed;
float l9_153=l9_152;
if (N173_ENABLE_EXTERNALTIME)
{
l9_153=N173_externalTime;
}
float l9_154=l9_153;
if (N173_ENABLE_INSTANTSPAWN)
{
l9_154=N173_timeGlobal*l9_153;
}
else
{
float l9_155=fract(((l9_153*N173_timeGlobal)*(1.0/l9_149.y))+l9_147);
l9_154=l9_155*l9_149.y;
}
float l9_156=mix(l9_154/l9_150,l9_154/l9_151,l9_148);
float l9_157=fast::clamp(l9_156,0.0,1.0);
float l9_158=0.0;
if (!N173_ENABLE_INSTANTSPAWN)
{
if (N173_spawnDuration>0.0)
{
if ((l9_153-N173_spawnDuration)>=l9_154)
{
l9_158=1.0;
}
}
}
float l9_159=l9_156+l9_158;
N173_dieTrigger=1.0;
if (l9_159>0.99989998)
{
N173_dieTrigger=0.0;
}
N173_timeValues=float4(l9_149,l9_154,l9_157);
param_13=N173_particleSeed;
param_14=N173_globalSeed;
param_15=N173_dieTrigger;
param_16=N173_timeValues;
particleSeed_N173=param_13;
globalSeed_N173=param_14;
dieTrigger_N173=param_15;
timeValues_N173=param_16;
float3 Position_N114=float3(0.0);
Position_N114=Globals.SurfacePosition_ObjectSpace;
float3 Normal_N172=float3(0.0);
Normal_N172=Globals.VertexNormal_ObjectSpace;
float3 Output_N16=float3(0.0);
float3 param_18=(*sc_set2.UserUniforms).spawnLocation;
Output_N16=param_18;
float3 Output_N18=float3(0.0);
float3 param_19=(*sc_set2.UserUniforms).spawnBox;
Output_N18=param_19;
float3 Output_N20=float3(0.0);
float3 param_20=(*sc_set2.UserUniforms).spawnSphere;
Output_N20=param_20;
float3 Output_N39=float3(0.0);
float3 param_21=(*sc_set2.UserUniforms).noiseMult;
Output_N39=param_21;
float3 Output_N40=float3(0.0);
float3 param_22=(*sc_set2.UserUniforms).noiseFrequency;
Output_N40=param_22;
float3 Output_N41=float3(0.0);
float3 param_23=(*sc_set2.UserUniforms).sNoiseMult;
Output_N41=param_23;
float3 Output_N42=float3(0.0);
float3 param_24=(*sc_set2.UserUniforms).sNoiseFrequency;
Output_N42=param_24;
float3 Output_N34=float3(0.0);
float3 param_25=(*sc_set2.UserUniforms).velocityMin;
Output_N34=param_25;
float3 Output_N35=float3(0.0);
float3 param_26=(*sc_set2.UserUniforms).velocityMax;
Output_N35=param_26;
float3 Output_N36=float3(0.0);
float3 param_27=(*sc_set2.UserUniforms).velocityDrag;
Output_N36=param_27;
float3 Result_N70=float3(0.0);
float3 param_28=float3(0.0);
float3 param_29=float3(0.0);
float3 param_30;
if (MESHTYPE_tmp==0)
{
float2 l9_160=float2(0.0);
float2 l9_161=(*sc_set2.UserUniforms).sizeStart;
l9_160=l9_161;
param_28=float3(l9_160,0.0);
param_30=param_28;
}
else
{
float3 l9_162=float3(0.0);
float3 l9_163=(*sc_set2.UserUniforms).sizeStart3D;
l9_162=l9_163;
param_29=l9_162;
param_30=param_29;
}
Result_N70=param_30;
float3 Result_N121=float3(0.0);
float3 param_31=float3(0.0);
float3 param_32=float3(0.0);
float3 param_33;
if (MESHTYPE_tmp==0)
{
float2 l9_164=float2(0.0);
float2 l9_165=(*sc_set2.UserUniforms).sizeEnd;
l9_164=l9_165;
param_31=float3(l9_164,0.0);
param_33=param_31;
}
else
{
float3 l9_166=float3(0.0);
float3 l9_167=(*sc_set2.UserUniforms).sizeEnd3D;
l9_166=l9_167;
param_32=l9_166;
param_33=param_32;
}
Result_N121=param_33;
float3 Result_N124=float3(0.0);
float3 param_34=float3(0.0);
float3 param_35=float3(0.0);
float3 param_36;
if (MESHTYPE_tmp==0)
{
float2 l9_168=float2(0.0);
float2 l9_169=(*sc_set2.UserUniforms).sizeStartMin;
l9_168=l9_169;
param_34=float3(l9_168,0.0);
param_36=param_34;
}
else
{
float3 l9_170=float3(0.0);
float3 l9_171=(*sc_set2.UserUniforms).sizeStartMin3D;
l9_170=l9_171;
param_35=l9_170;
param_36=param_35;
}
Result_N124=param_36;
float3 Result_N123=float3(0.0);
float3 param_37=float3(0.0);
float3 param_38=float3(0.0);
float3 param_39;
if (MESHTYPE_tmp==0)
{
float2 l9_172=float2(0.0);
float2 l9_173=(*sc_set2.UserUniforms).sizeStartMax;
l9_172=l9_173;
param_37=float3(l9_172,0.0);
param_39=param_37;
}
else
{
float3 l9_174=float3(0.0);
float3 l9_175=(*sc_set2.UserUniforms).sizeStartMax3D;
l9_174=l9_175;
param_38=l9_174;
param_39=param_38;
}
Result_N123=param_39;
float3 Result_N125=float3(0.0);
float3 param_40=float3(0.0);
float3 param_41=float3(0.0);
float3 param_42;
if (MESHTYPE_tmp==0)
{
float2 l9_176=float2(0.0);
float2 l9_177=(*sc_set2.UserUniforms).sizeEndMin;
l9_176=l9_177;
param_40=float3(l9_176,0.0);
param_42=param_40;
}
else
{
float3 l9_178=float3(0.0);
float3 l9_179=(*sc_set2.UserUniforms).sizeEndMin3D;
l9_178=l9_179;
param_41=l9_178;
param_42=param_41;
}
Result_N125=param_42;
float3 Result_N126=float3(0.0);
float3 param_43=float3(0.0);
float3 param_44=float3(0.0);
float3 param_45;
if (MESHTYPE_tmp==0)
{
float2 l9_180=float2(0.0);
float2 l9_181=(*sc_set2.UserUniforms).sizeEndMax;
l9_180=l9_181;
param_43=float3(l9_180,0.0);
param_45=param_43;
}
else
{
float3 l9_182=float3(0.0);
float3 l9_183=(*sc_set2.UserUniforms).sizeEndMax3D;
l9_182=l9_183;
param_44=l9_182;
param_45=param_44;
}
Result_N126=param_45;
float Output_N27=0.0;
float param_46=(*sc_set2.UserUniforms).sizeSpeed;
Output_N27=param_46;
float Output_N55=0.0;
float param_47=(*sc_set2.UserUniforms).gravity;
Output_N55=param_47;
float3 Output_N46=float3(0.0);
float3 param_48=(*sc_set2.UserUniforms).localForce;
Output_N46=param_48;
float Output_N51=0.0;
float param_49=(*sc_set2.UserUniforms).sizeVelScale;
Output_N51=param_49;
float Output_N48=0.0;
float param_50=float((*sc_set2.UserUniforms).ALIGNTOX!=0);
Output_N48=param_50;
float Output_N49=0.0;
float param_51=float((*sc_set2.UserUniforms).ALIGNTOY!=0);
Output_N49=param_51;
float Output_N50=0.0;
float param_52=float((*sc_set2.UserUniforms).ALIGNTOZ!=0);
Output_N50=param_52;
float2 Output_N138=float2(0.0);
float2 param_53=(*sc_set2.UserUniforms).Port_Input1_N138;
float2 param_54=float2(0.0);
float2 param_55;
if (MESHTYPE_tmp==0)
{
param_55=param_53;
}
else
{
float2 l9_184=float2(0.0);
float2 l9_185=(*sc_set2.UserUniforms).rotationRandomX;
l9_184=l9_185;
param_54=l9_184;
param_55=param_54;
}
Output_N138=param_55;
float2 Output_N139=float2(0.0);
float2 param_56=(*sc_set2.UserUniforms).Port_Input1_N139;
float2 param_57=float2(0.0);
float2 param_58;
if (MESHTYPE_tmp==0)
{
param_58=param_56;
}
else
{
float2 l9_186=float2(0.0);
float2 l9_187=(*sc_set2.UserUniforms).rotationRateX;
l9_186=l9_187;
param_57=l9_186;
param_58=param_57;
}
Output_N139=param_58;
float2 Output_N140=float2(0.0);
float2 param_59=(*sc_set2.UserUniforms).Port_Input1_N140;
float2 param_60=float2(0.0);
float2 param_61;
if (MESHTYPE_tmp==0)
{
param_61=param_59;
}
else
{
float2 l9_188=float2(0.0);
float2 l9_189=(*sc_set2.UserUniforms).randomRotationY;
l9_188=l9_189;
param_60=l9_188;
param_61=param_60;
}
Output_N140=param_61;
float2 Output_N144=float2(0.0);
float2 param_62=(*sc_set2.UserUniforms).Port_Input1_N144;
float2 param_63=float2(0.0);
float2 param_64;
if (MESHTYPE_tmp==0)
{
param_64=param_62;
}
else
{
float2 l9_190=float2(0.0);
float2 l9_191=(*sc_set2.UserUniforms).rotationRateY;
l9_190=l9_191;
param_63=l9_190;
param_64=param_63;
}
Output_N144=param_64;
float2 Output_N135=float2(0.0);
float2 param_65=float2(1.0);
float2 param_66=float2(0.0);
float2 param_67;
if (MESHTYPE_tmp==0)
{
float2 l9_192=float2(0.0);
float2 l9_193=(*sc_set2.UserUniforms).rotationRandom;
l9_192=l9_193;
param_65=l9_192;
param_67=param_65;
}
else
{
float2 l9_194=float2(0.0);
float2 l9_195=(*sc_set2.UserUniforms).randomRotationZ;
l9_194=l9_195;
param_66=l9_194;
param_67=param_66;
}
Output_N135=param_67;
float2 Output_N137=float2(0.0);
float2 param_68=float2(1.0);
float2 param_69=float2(0.0);
float2 param_70;
if (MESHTYPE_tmp==0)
{
float2 l9_196=float2(0.0);
float2 l9_197=(*sc_set2.UserUniforms).rotationRate;
l9_196=l9_197;
param_68=l9_196;
param_70=param_68;
}
else
{
float2 l9_198=float2(0.0);
float2 l9_199=(*sc_set2.UserUniforms).rotationRateZ;
l9_198=l9_199;
param_69=l9_198;
param_70=param_69;
}
Output_N137=param_70;
float Output_N54=0.0;
float param_71=(*sc_set2.UserUniforms).rotationDrag;
Output_N54=param_71;
float Output_N110=0.0;
float param_72=(*sc_set2.UserUniforms).Port_Input1_N110;
float param_73=0.0;
float param_74;
if (MESHTYPE_tmp==0)
{
param_74=param_72;
}
else
{
float l9_200=0.0;
float l9_201=float((*sc_set2.UserUniforms).CENTER_BBOX!=0);
l9_200=l9_201;
param_73=l9_200;
param_74=param_73;
}
Output_N110=param_74;
float Output_N176=0.0;
float param_75=(*sc_set2.UserUniforms).fadeDistanceVisible;
Output_N176=param_75;
float Output_N178=0.0;
float param_76=(*sc_set2.UserUniforms).fadeDistanceInvisible;
Output_N178=param_76;
float3 position_N111=float3(0.0);
float3 param_77=particleSeed_N173;
float param_78=globalSeed_N173;
float param_79=dieTrigger_N173;
float4 param_80=timeValues_N173;
float3 param_81=Position_N114;
float3 param_82=Normal_N172;
float3 param_83=Output_N16;
float3 param_84=Output_N18;
float3 param_85=Output_N20;
float3 param_86=Output_N39;
float3 param_87=Output_N40;
float3 param_88=Output_N41;
float3 param_89=Output_N42;
float3 param_90=Output_N34;
float3 param_91=Output_N35;
float3 param_92=Output_N36;
float3 param_93=Result_N70;
float3 param_94=Result_N121;
float3 param_95=Result_N124;
float3 param_96=Result_N123;
float3 param_97=Result_N125;
float3 param_98=Result_N126;
float param_99=Output_N27;
float param_100=Output_N55;
float3 param_101=Output_N46;
float param_102=Output_N51;
float param_103=Output_N48;
float param_104=Output_N49;
float param_105=Output_N50;
float2 param_106=Output_N138;
float2 param_107=Output_N139;
float2 param_108=Output_N140;
float2 param_109=Output_N144;
float2 param_110=Output_N135;
float2 param_111=Output_N137;
float param_112=Output_N54;
float param_113=Output_N110;
float param_114=Output_N176;
float param_115=Output_N178;
ssGlobals param_117=Globals;
tempGlobals=param_117;
float3 param_116=float3(0.0);
N111_MESHTYPE_QUAD=MESHTYPE_tmp==0;
N111_particleSeedIn=param_77;
N111_globalSeedIn=param_78;
N111_dieTrigger=param_79;
N111_timeValuesIn=param_80;
N111_positionObjectSpace=param_81;
N111_normalObjectSpace=param_82;
N111_ENABLE_INILOCATION=(int(INILOCATION_tmp)!=0);
N111_spawnLocation=param_83;
N111_ENABLE_BOXSPAWN=(int(BOXSPAWN_tmp)!=0);
N111_spawnBox=param_84;
N111_ENABLE_SPHERESPAWN=(int(SPHERESPAWN_tmp)!=0);
N111_spawnSphere=param_85;
N111_ENABLE_NOISE=(int(NOISE_tmp)!=0);
N111_noiseMult=param_86;
N111_noiseFrequency=param_87;
N111_ENABLE_SNOISE=(int(SNOISE_tmp)!=0);
N111_sNoiseMult=param_88;
N111_sNoiseFrequency=param_89;
N111_ENABLE_VELRAMP=(int(VELRAMP_tmp)!=0);
N111_velocityMin=param_90;
N111_velocityMax=param_91;
N111_velocityDrag=param_92;
N111_sizeStart=param_93;
N111_sizeEnd=param_94;
N111_ENABLE_SIZEMINMAX=(int(SIZEMINMAX_tmp)!=0);
N111_sizeStartMin=param_95;
N111_sizeStartMax=param_96;
N111_sizeEndMin=param_97;
N111_sizeEndMax=param_98;
N111_sizeSpeed=param_99;
N111_ENABLE_SIZERAMP=(int(SIZERAMP_tmp)!=0);
N111_gravity=param_100;
N111_ENABLE_FORCE=(int(FORCE_tmp)!=0);
N111_localForce=param_101;
N111_ENABLE_ALIGNTOVEL=(int(VELOCITYDIR_tmp)!=0);
N111_sizeVelScale=param_102;
N111_ENABLE_IGNOREVEL=(int(IGNOREVEL_tmp)!=0);
N111_ENABLE_IGNORETRANSFORMSCALE=(int(IGNORETRANSFORMSCALE_tmp)!=0);
N111_ENABLE_ALIGNTOX=param_103!=0.0;
N111_ENABLE_ALIGNTOY=param_104!=0.0;
N111_ENABLE_ALIGNTOZ=param_105!=0.0;
N111_rotationRandomX=param_106;
N111_rotationRateX=param_107;
N111_rotationRandomY=param_108;
N111_rotationRateY=param_109;
N111_rotationRandomZ=param_110;
N111_rotationRateZ=param_111;
N111_rotationDrag=param_112;
N111_WORLDSPACE=rotationSpace_tmp==1;
N111_WORLDFORCE=rotationSpace_tmp==2;
N111_ENABLE_CENTER_IN_BBOX=param_113!=0.0;
N111_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N111_fadeDistanceVisible=param_114;
N111_fadeDistanceInvisible=param_115;
float3 l9_202=float3(0.0);
N111_particleSeed=N111_particleSeedIn;
N111_globalSeed=N111_globalSeedIn;
float l9_203=N111_particleSeed.x;
float l9_204=N111_particleSeed.y;
float l9_205=N111_particleSeed.z;
float3 l9_206=fract((float3(l9_203,l9_204,l9_205)*3048.28)+float3(N111_globalSeed))-float3(0.5);
float3 l9_207=fract((N111_particleSeed*374.57129)+float3(N111_globalSeed))-float3(0.5);
float3 l9_208=normalize(l9_207+float3(N111_EPSILON));
float l9_209=fract(N111_particleSeed.x+N111_globalSeed);
float l9_210=l9_209;
float l9_211=0.33333334;
float l9_212;
if (l9_210<=0.0)
{
l9_212=0.0;
}
else
{
l9_212=pow(l9_210,l9_211);
}
float l9_213=l9_212;
float l9_214=l9_213;
l9_208*=l9_214;
l9_208/=float3(2.0);
float l9_215=fract((N111_particleSeed.x*334.59122)+N111_globalSeed)-0.5;
float l9_216=fract((N111_particleSeed.y*41.231232)+N111_globalSeed)-0.5;
float l9_217=fract((N111_particleSeed.z*18.984529)+N111_globalSeed);
float l9_218=fract((N111_particleSeed.x*654.15588)+N111_globalSeed);
float l9_219=fract((N111_particleSeed.y*45.722408)+N111_globalSeed);
float3 l9_220=(float3(l9_218,l9_219,l9_217)-float3(0.5))*2.0;
float3 l9_221=float3(l9_218,l9_219,l9_217);
float l9_222=fract((N111_particleSeed.z*15.32451)+N111_globalSeed);
float2 l9_223=N111_timeValuesIn.xy;
float l9_224=N111_timeValuesIn.z;
float l9_225=N111_timeValuesIn.w;
float3 l9_226=l9_202;
float3 l9_227=l9_202;
float3 l9_228=l9_202;
if (N111_ENABLE_INILOCATION)
{
l9_228=N111_spawnLocation;
}
if (N111_ENABLE_BOXSPAWN)
{
l9_226=N111_spawnBox*l9_206;
}
if (N111_ENABLE_SPHERESPAWN)
{
l9_227=N111_spawnSphere*l9_208;
}
float3 l9_229=(l9_228+l9_227)+l9_226;
float3 l9_230=l9_202;
if (N111_ENABLE_NOISE)
{
float3 l9_231=N111_noiseFrequency;
float3 l9_232=N111_noiseMult;
float3 l9_233=l9_220;
float l9_234=l9_225;
float l9_235=sin(l9_234*l9_231.x);
float l9_236=sin(l9_234*l9_231.y);
float l9_237=sin(l9_234*l9_231.z);
float3 l9_238=(float3(l9_235,l9_236,l9_237)*l9_232)*l9_233;
float3 l9_239=l9_238;
l9_230+=l9_239;
}
if (N111_ENABLE_SNOISE)
{
float l9_240=l9_217;
float l9_241=l9_218;
float l9_242=l9_219;
float3 l9_243=N111_sNoiseFrequency;
float3 l9_244=N111_sNoiseMult;
float3 l9_245=l9_220;
float l9_246=l9_224;
float2 l9_247=float2(l9_240*l9_246,l9_243.x);
float2 l9_248=floor(l9_247+float2(dot(l9_247,float2(0.36602542))));
float2 l9_249=(l9_247-l9_248)+float2(dot(l9_248,float2(0.21132487)));
float2 l9_250=float2(0.0);
bool2 l9_251=bool2(l9_249.x>l9_249.y);
l9_250=float2(l9_251.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_251.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_252=l9_249.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_253=l9_252.xy-l9_250;
l9_252=float4(l9_253.x,l9_253.y,l9_252.z,l9_252.w);
l9_248=mod(l9_248,float2(289.0));
float3 l9_254=float3(l9_248.y)+float3(0.0,l9_250.y,1.0);
float3 l9_255=mod(((l9_254*34.0)+float3(1.0))*l9_254,float3(289.0));
float3 l9_256=(l9_255+float3(l9_248.x))+float3(0.0,l9_250.x,1.0);
float3 l9_257=mod(((l9_256*34.0)+float3(1.0))*l9_256,float3(289.0));
float3 l9_258=l9_257;
float3 l9_259=fast::max(float3(0.5)-float3(dot(l9_249,l9_249),dot(l9_252.xy,l9_252.xy),dot(l9_252.zw,l9_252.zw)),float3(0.0));
l9_259*=l9_259;
l9_259*=l9_259;
float3 l9_260=(fract(l9_258*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_261=abs(l9_260)-float3(0.5);
float3 l9_262=floor(l9_260+float3(0.5));
float3 l9_263=l9_260-l9_262;
l9_259*=(float3(1.7928429)-(((l9_263*l9_263)+(l9_261*l9_261))*0.85373473));
float3 l9_264=float3(0.0);
l9_264.x=(l9_263.x*l9_249.x)+(l9_261.x*l9_249.y);
float2 l9_265=(l9_263.yz*l9_252.xz)+(l9_261.yz*l9_252.yw);
l9_264=float3(l9_264.x,l9_265.x,l9_265.y);
float l9_266=130.0*dot(l9_259,l9_264);
float l9_267=l9_266;
float2 l9_268=float2(l9_241*l9_246,l9_243.y);
float2 l9_269=floor(l9_268+float2(dot(l9_268,float2(0.36602542))));
float2 l9_270=(l9_268-l9_269)+float2(dot(l9_269,float2(0.21132487)));
float2 l9_271=float2(0.0);
bool2 l9_272=bool2(l9_270.x>l9_270.y);
l9_271=float2(l9_272.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_272.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_273=l9_270.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_274=l9_273.xy-l9_271;
l9_273=float4(l9_274.x,l9_274.y,l9_273.z,l9_273.w);
l9_269=mod(l9_269,float2(289.0));
float3 l9_275=float3(l9_269.y)+float3(0.0,l9_271.y,1.0);
float3 l9_276=mod(((l9_275*34.0)+float3(1.0))*l9_275,float3(289.0));
float3 l9_277=(l9_276+float3(l9_269.x))+float3(0.0,l9_271.x,1.0);
float3 l9_278=mod(((l9_277*34.0)+float3(1.0))*l9_277,float3(289.0));
float3 l9_279=l9_278;
float3 l9_280=fast::max(float3(0.5)-float3(dot(l9_270,l9_270),dot(l9_273.xy,l9_273.xy),dot(l9_273.zw,l9_273.zw)),float3(0.0));
l9_280*=l9_280;
l9_280*=l9_280;
float3 l9_281=(fract(l9_279*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_282=abs(l9_281)-float3(0.5);
float3 l9_283=floor(l9_281+float3(0.5));
float3 l9_284=l9_281-l9_283;
l9_280*=(float3(1.7928429)-(((l9_284*l9_284)+(l9_282*l9_282))*0.85373473));
float3 l9_285=float3(0.0);
l9_285.x=(l9_284.x*l9_270.x)+(l9_282.x*l9_270.y);
float2 l9_286=(l9_284.yz*l9_273.xz)+(l9_282.yz*l9_273.yw);
l9_285=float3(l9_285.x,l9_286.x,l9_286.y);
float l9_287=130.0*dot(l9_280,l9_285);
float l9_288=l9_287;
float2 l9_289=float2(l9_242*l9_246,l9_243.z);
float2 l9_290=floor(l9_289+float2(dot(l9_289,float2(0.36602542))));
float2 l9_291=(l9_289-l9_290)+float2(dot(l9_290,float2(0.21132487)));
float2 l9_292=float2(0.0);
bool2 l9_293=bool2(l9_291.x>l9_291.y);
l9_292=float2(l9_293.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_293.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_294=l9_291.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_295=l9_294.xy-l9_292;
l9_294=float4(l9_295.x,l9_295.y,l9_294.z,l9_294.w);
l9_290=mod(l9_290,float2(289.0));
float3 l9_296=float3(l9_290.y)+float3(0.0,l9_292.y,1.0);
float3 l9_297=mod(((l9_296*34.0)+float3(1.0))*l9_296,float3(289.0));
float3 l9_298=(l9_297+float3(l9_290.x))+float3(0.0,l9_292.x,1.0);
float3 l9_299=mod(((l9_298*34.0)+float3(1.0))*l9_298,float3(289.0));
float3 l9_300=l9_299;
float3 l9_301=fast::max(float3(0.5)-float3(dot(l9_291,l9_291),dot(l9_294.xy,l9_294.xy),dot(l9_294.zw,l9_294.zw)),float3(0.0));
l9_301*=l9_301;
l9_301*=l9_301;
float3 l9_302=(fract(l9_300*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_303=abs(l9_302)-float3(0.5);
float3 l9_304=floor(l9_302+float3(0.5));
float3 l9_305=l9_302-l9_304;
l9_301*=(float3(1.7928429)-(((l9_305*l9_305)+(l9_303*l9_303))*0.85373473));
float3 l9_306=float3(0.0);
l9_306.x=(l9_305.x*l9_291.x)+(l9_303.x*l9_291.y);
float2 l9_307=(l9_305.yz*l9_294.xz)+(l9_303.yz*l9_294.yw);
l9_306=float3(l9_306.x,l9_307.x,l9_307.y);
float l9_308=130.0*dot(l9_301,l9_306);
float l9_309=l9_308;
float3 l9_310=(float3(l9_267,l9_288,l9_309)*l9_244)*l9_245;
l9_230+=l9_310;
}
float3 l9_311=float3(0.0,((N111_gravity/2.0)*l9_224)*l9_224,0.0);
float3 l9_312=l9_202;
if (N111_ENABLE_FORCE)
{
l9_312=((N111_localForce/float3(2.0))*l9_224)*l9_224;
}
float3 l9_313=l9_202;
float3 l9_314=N111_velocityMin+(((l9_220+float3(1.0))/float3(2.0))*(N111_velocityMax-N111_velocityMin));
if (N111_ENABLE_VELRAMP)
{
l9_314=mix(N111_velocityMin,N111_velocityMax,l9_221);
}
float3 l9_315=l9_314;
float l9_316=l9_224;
float3 l9_317=N111_velocityDrag;
float3 l9_318=l9_230;
float l9_319=l9_225;
float3 l9_320=float3(l9_316,l9_316,l9_316);
float3 l9_321=l9_317;
float l9_322;
if (l9_320.x<=0.0)
{
l9_322=0.0;
}
else
{
l9_322=pow(l9_320.x,l9_321.x);
}
float l9_323=l9_322;
float l9_324;
if (l9_320.y<=0.0)
{
l9_324=0.0;
}
else
{
l9_324=pow(l9_320.y,l9_321.y);
}
float l9_325=l9_324;
float l9_326;
if (l9_320.z<=0.0)
{
l9_326=0.0;
}
else
{
l9_326=pow(l9_320.z,l9_321.z);
}
float3 l9_327=float3(l9_323,l9_325,l9_326);
float3 l9_328=l9_327;
float3 l9_329=(l9_315+l9_318)*l9_328;
if (N111_ENABLE_VELRAMP)
{
float l9_330=floor(l9_319*10000.0)/10000.0;
float2 l9_331=tempGlobals.Surface_UVCoord0;
float2 l9_332=(l9_331/float2(10000.0,1.0))+float2(l9_330,0.0);
float2 l9_333=l9_332;
float4 l9_334=float4(0.0);
int l9_335=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_336=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_336=0;
}
else
{
l9_336=gl_InstanceIndex%2;
}
int l9_337=l9_336;
l9_335=1-l9_337;
}
else
{
int l9_338=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_338=0;
}
else
{
l9_338=gl_InstanceIndex%2;
}
int l9_339=l9_338;
l9_335=l9_339;
}
int l9_340=l9_335;
int l9_341=velRampTextureLayout_tmp;
int l9_342=l9_340;
float2 l9_343=l9_333;
bool l9_344=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_345=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_346=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_347=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_348=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_349=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_350=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_351=0.0;
bool l9_352=l9_349&&(!l9_347);
float l9_353=1.0;
float l9_354=l9_343.x;
int l9_355=l9_346.x;
if (l9_355==1)
{
l9_354=fract(l9_354);
}
else
{
if (l9_355==2)
{
float l9_356=fract(l9_354);
float l9_357=l9_354-l9_356;
float l9_358=step(0.25,fract(l9_357*0.5));
l9_354=mix(l9_356,1.0-l9_356,fast::clamp(l9_358,0.0,1.0));
}
}
l9_343.x=l9_354;
float l9_359=l9_343.y;
int l9_360=l9_346.y;
if (l9_360==1)
{
l9_359=fract(l9_359);
}
else
{
if (l9_360==2)
{
float l9_361=fract(l9_359);
float l9_362=l9_359-l9_361;
float l9_363=step(0.25,fract(l9_362*0.5));
l9_359=mix(l9_361,1.0-l9_361,fast::clamp(l9_363,0.0,1.0));
}
}
l9_343.y=l9_359;
if (l9_347)
{
bool l9_364=l9_349;
bool l9_365;
if (l9_364)
{
l9_365=l9_346.x==3;
}
else
{
l9_365=l9_364;
}
float l9_366=l9_343.x;
float l9_367=l9_348.x;
float l9_368=l9_348.z;
bool l9_369=l9_365;
float l9_370=l9_353;
float l9_371=fast::clamp(l9_366,l9_367,l9_368);
float l9_372=step(abs(l9_366-l9_371),9.9999997e-06);
l9_370*=(l9_372+((1.0-float(l9_369))*(1.0-l9_372)));
l9_366=l9_371;
l9_343.x=l9_366;
l9_353=l9_370;
bool l9_373=l9_349;
bool l9_374;
if (l9_373)
{
l9_374=l9_346.y==3;
}
else
{
l9_374=l9_373;
}
float l9_375=l9_343.y;
float l9_376=l9_348.y;
float l9_377=l9_348.w;
bool l9_378=l9_374;
float l9_379=l9_353;
float l9_380=fast::clamp(l9_375,l9_376,l9_377);
float l9_381=step(abs(l9_375-l9_380),9.9999997e-06);
l9_379*=(l9_381+((1.0-float(l9_378))*(1.0-l9_381)));
l9_375=l9_380;
l9_343.y=l9_375;
l9_353=l9_379;
}
float2 l9_382=l9_343;
bool l9_383=l9_344;
float3x3 l9_384=l9_345;
if (l9_383)
{
l9_382=float2((l9_384*float3(l9_382,1.0)).xy);
}
float2 l9_385=l9_382;
float2 l9_386=l9_385;
float2 l9_387=l9_386;
l9_343=l9_387;
float l9_388=l9_343.x;
int l9_389=l9_346.x;
bool l9_390=l9_352;
float l9_391=l9_353;
if ((l9_389==0)||(l9_389==3))
{
float l9_392=l9_388;
float l9_393=0.0;
float l9_394=1.0;
bool l9_395=l9_390;
float l9_396=l9_391;
float l9_397=fast::clamp(l9_392,l9_393,l9_394);
float l9_398=step(abs(l9_392-l9_397),9.9999997e-06);
l9_396*=(l9_398+((1.0-float(l9_395))*(1.0-l9_398)));
l9_392=l9_397;
l9_388=l9_392;
l9_391=l9_396;
}
l9_343.x=l9_388;
l9_353=l9_391;
float l9_399=l9_343.y;
int l9_400=l9_346.y;
bool l9_401=l9_352;
float l9_402=l9_353;
if ((l9_400==0)||(l9_400==3))
{
float l9_403=l9_399;
float l9_404=0.0;
float l9_405=1.0;
bool l9_406=l9_401;
float l9_407=l9_402;
float l9_408=fast::clamp(l9_403,l9_404,l9_405);
float l9_409=step(abs(l9_403-l9_408),9.9999997e-06);
l9_407*=(l9_409+((1.0-float(l9_406))*(1.0-l9_409)));
l9_403=l9_408;
l9_399=l9_403;
l9_402=l9_407;
}
l9_343.y=l9_399;
l9_353=l9_402;
float2 l9_410=l9_343;
int l9_411=l9_341;
int l9_412=l9_342;
float l9_413=l9_351;
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
float4 l9_422=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_420,level(l9_421));
float4 l9_423=l9_422;
float4 l9_424=l9_423;
if (l9_349)
{
l9_424=mix(l9_350,l9_424,float4(l9_353));
}
float4 l9_425=l9_424;
l9_334=l9_425;
float4 l9_426=l9_334;
float3 l9_427=l9_426.xyz;
l9_329=(l9_315+l9_318)*l9_427;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_329=l9_315*l9_328;
}
}
float3 l9_428=l9_329;
l9_313=l9_428;
float4x4 l9_429=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_430=length(l9_429[0].xyz);
float4x4 l9_431=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_432=length(l9_431[1].xyz);
float4x4 l9_433=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_434=length(l9_433[2].xyz);
float3 l9_435=float3(l9_430,l9_432,l9_434);
float4x4 l9_436=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_437=l9_436;
float4 l9_438=l9_437[0];
float4 l9_439=l9_437[1];
float4 l9_440=l9_437[2];
float3x3 l9_441=float3x3(float3(float3(l9_438.x,l9_439.x,l9_440.x)),float3(float3(l9_438.y,l9_439.y,l9_440.y)),float3(float3(l9_438.z,l9_439.z,l9_440.z)));
float3x3 l9_442=l9_441;
float3 l9_443=((l9_313+l9_311)+l9_312)*l9_442;
if (N111_WORLDFORCE)
{
float4x4 l9_444=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_445=l9_444;
float4 l9_446=l9_445[0];
float4 l9_447=l9_445[1];
float4 l9_448=l9_445[2];
float3x3 l9_449=float3x3(float3(float3(l9_446.x,l9_447.x,l9_448.x)),float3(float3(l9_446.y,l9_447.y,l9_448.y)),float3(float3(l9_446.z,l9_447.z,l9_448.z)));
float3x3 l9_450=l9_449;
l9_443=((l9_313*l9_450)+l9_311)+l9_312;
}
if (N111_WORLDSPACE)
{
l9_443=((l9_313*l9_435)+l9_311)+l9_312;
}
float4x4 l9_451=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3 l9_452=(l9_451*float4(l9_229,1.0)).xyz+l9_443;
float l9_453=mix(N111_rotationRandomZ.x,N111_rotationRandomZ.y,l9_222);
float l9_454=1.0-l9_225;
float l9_455=N111_rotationDrag;
float l9_456;
if (l9_454<=0.0)
{
l9_456=0.0;
}
else
{
l9_456=pow(l9_454,l9_455);
}
float l9_457=l9_456;
float l9_458=l9_457;
float l9_459=mix(N111_rotationRateZ.x,N111_rotationRateZ.y,l9_222);
float l9_460=((l9_459*l9_458)*l9_225)*2.0;
float l9_461=N111_PI*((l9_460+l9_453)-0.5);
float l9_462=1.0;
if (N111_ENABLE_SCREENFADE)
{
float3 l9_463=(*sc_set2.UserUniforms).sc_Camera.position;
float3 l9_464=l9_463-l9_452;
float l9_465=dot(l9_464,l9_464);
float l9_466=(N111_fadeDistanceInvisible+N111_EPSILON)*(N111_fadeDistanceInvisible+N111_EPSILON);
float l9_467=N111_fadeDistanceVisible*N111_fadeDistanceVisible;
float l9_468=fast::min(l9_466,l9_467);
float l9_469=fast::max(l9_466,l9_467);
N111_nearCameraFade=smoothstep(l9_468,l9_469,l9_465);
float l9_470;
if (l9_466>l9_467)
{
l9_470=1.0-N111_nearCameraFade;
}
else
{
l9_470=N111_nearCameraFade;
}
N111_nearCameraFade=l9_470;
if (N111_nearCameraFade<=N111_EPSILON)
{
l9_462=0.0;
}
}
if (N111_MESHTYPE_QUAD)
{
int l9_471=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_471=0;
}
else
{
l9_471=gl_InstanceIndex%2;
}
int l9_472=l9_471;
float4x4 l9_473=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_472];
float3 l9_474=l9_473[2].xyz;
int l9_475=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_475=0;
}
else
{
l9_475=gl_InstanceIndex%2;
}
int l9_476=l9_475;
float3 l9_477=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_476][1].xyz;
float3 l9_478=-l9_477;
float3 l9_479=normalize(cross(l9_474,l9_478));
float l9_480=1.0;
if (N111_ENABLE_ALIGNTOX)
{
l9_479=float3(0.0,0.0,1.0);
l9_478=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_479=float3(1.0,0.0,0.0);
l9_478=float3(0.0,0.0,1.0);
}
if (N111_ENABLE_ALIGNTOZ)
{
l9_479=float3(1.0,0.0,0.0);
l9_478=float3(0.0,1.0,0.0);
}
float2 l9_481=float2(cos(l9_461),sin(l9_461));
float2 l9_482=float2(-sin(l9_461),cos(l9_461));
float3 l9_483=float3((l9_479*l9_481.x)+(l9_478*l9_481.y));
float3 l9_484=float3((l9_479*l9_482.x)+(l9_478*l9_482.y));
if (N111_ENABLE_ALIGNTOVEL)
{
float3 l9_485=normalize(((l9_443+l9_311)+l9_312)+float3(N111_EPSILON));
float3 l9_486=l9_443*(l9_224-0.0099999998);
float3 l9_487=l9_443*(l9_224+0.0099999998);
if (N111_ENABLE_IGNOREVEL)
{
l9_480=fast::max(N111_sizeVelScale,N111_EPSILON);
}
else
{
l9_480=length(l9_487-l9_486)*N111_sizeVelScale;
if (N111_ENABLE_IGNORETRANSFORMSCALE)
{
float4x4 l9_488=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_480=(length(l9_487-l9_486)/length(l9_488[0].xyz))*N111_sizeVelScale;
}
}
l9_483=l9_485;
l9_484=normalize(cross(l9_483,l9_474));
}
float4x4 l9_489=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_490=length(l9_489[0].xyz);
float2 l9_491=tempGlobals.Surface_UVCoord0;
float2 l9_492=l9_491;
float l9_493=N111_dieTrigger;
float l9_494=l9_462;
float2 l9_495=l9_492;
float l9_496=l9_215;
float l9_497=l9_216;
float l9_498=l9_225;
float l9_499=N111_sizeSpeed;
float2 l9_500=N111_sizeStart.xy;
float2 l9_501=N111_sizeEnd.xy;
float l9_502=l9_498;
float l9_503=l9_499;
float l9_504;
if (l9_502<=0.0)
{
l9_504=0.0;
}
else
{
l9_504=pow(l9_502,l9_503);
}
float l9_505=l9_504;
float l9_506=l9_505;
if (N111_ENABLE_SIZEMINMAX)
{
l9_500=mix(N111_sizeStartMin.xy,N111_sizeStartMax.xy,float2(l9_496));
l9_501=mix(N111_sizeEndMin.xy,N111_sizeEndMax.xy,float2(l9_497));
}
float2 l9_507=mix(l9_500,l9_501,float2(l9_506));
if (N111_ENABLE_SIZERAMP)
{
float l9_508=ceil(l9_498*10000.0)/10000.0;
float2 l9_509=tempGlobals.Surface_UVCoord0;
float2 l9_510=(l9_509/float2(10000.0,1.0))+float2(l9_508,0.0);
float2 l9_511=l9_510;
float4 l9_512=float4(0.0);
int l9_513=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_514=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_514=0;
}
else
{
l9_514=gl_InstanceIndex%2;
}
int l9_515=l9_514;
l9_513=1-l9_515;
}
else
{
int l9_516=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_516=0;
}
else
{
l9_516=gl_InstanceIndex%2;
}
int l9_517=l9_516;
l9_513=l9_517;
}
int l9_518=l9_513;
int l9_519=sizeRampTextureLayout_tmp;
int l9_520=l9_518;
float2 l9_521=l9_511;
bool l9_522=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_523=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_524=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_525=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_526=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_527=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_528=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_529=0.0;
bool l9_530=l9_527&&(!l9_525);
float l9_531=1.0;
float l9_532=l9_521.x;
int l9_533=l9_524.x;
if (l9_533==1)
{
l9_532=fract(l9_532);
}
else
{
if (l9_533==2)
{
float l9_534=fract(l9_532);
float l9_535=l9_532-l9_534;
float l9_536=step(0.25,fract(l9_535*0.5));
l9_532=mix(l9_534,1.0-l9_534,fast::clamp(l9_536,0.0,1.0));
}
}
l9_521.x=l9_532;
float l9_537=l9_521.y;
int l9_538=l9_524.y;
if (l9_538==1)
{
l9_537=fract(l9_537);
}
else
{
if (l9_538==2)
{
float l9_539=fract(l9_537);
float l9_540=l9_537-l9_539;
float l9_541=step(0.25,fract(l9_540*0.5));
l9_537=mix(l9_539,1.0-l9_539,fast::clamp(l9_541,0.0,1.0));
}
}
l9_521.y=l9_537;
if (l9_525)
{
bool l9_542=l9_527;
bool l9_543;
if (l9_542)
{
l9_543=l9_524.x==3;
}
else
{
l9_543=l9_542;
}
float l9_544=l9_521.x;
float l9_545=l9_526.x;
float l9_546=l9_526.z;
bool l9_547=l9_543;
float l9_548=l9_531;
float l9_549=fast::clamp(l9_544,l9_545,l9_546);
float l9_550=step(abs(l9_544-l9_549),9.9999997e-06);
l9_548*=(l9_550+((1.0-float(l9_547))*(1.0-l9_550)));
l9_544=l9_549;
l9_521.x=l9_544;
l9_531=l9_548;
bool l9_551=l9_527;
bool l9_552;
if (l9_551)
{
l9_552=l9_524.y==3;
}
else
{
l9_552=l9_551;
}
float l9_553=l9_521.y;
float l9_554=l9_526.y;
float l9_555=l9_526.w;
bool l9_556=l9_552;
float l9_557=l9_531;
float l9_558=fast::clamp(l9_553,l9_554,l9_555);
float l9_559=step(abs(l9_553-l9_558),9.9999997e-06);
l9_557*=(l9_559+((1.0-float(l9_556))*(1.0-l9_559)));
l9_553=l9_558;
l9_521.y=l9_553;
l9_531=l9_557;
}
float2 l9_560=l9_521;
bool l9_561=l9_522;
float3x3 l9_562=l9_523;
if (l9_561)
{
l9_560=float2((l9_562*float3(l9_560,1.0)).xy);
}
float2 l9_563=l9_560;
float2 l9_564=l9_563;
float2 l9_565=l9_564;
l9_521=l9_565;
float l9_566=l9_521.x;
int l9_567=l9_524.x;
bool l9_568=l9_530;
float l9_569=l9_531;
if ((l9_567==0)||(l9_567==3))
{
float l9_570=l9_566;
float l9_571=0.0;
float l9_572=1.0;
bool l9_573=l9_568;
float l9_574=l9_569;
float l9_575=fast::clamp(l9_570,l9_571,l9_572);
float l9_576=step(abs(l9_570-l9_575),9.9999997e-06);
l9_574*=(l9_576+((1.0-float(l9_573))*(1.0-l9_576)));
l9_570=l9_575;
l9_566=l9_570;
l9_569=l9_574;
}
l9_521.x=l9_566;
l9_531=l9_569;
float l9_577=l9_521.y;
int l9_578=l9_524.y;
bool l9_579=l9_530;
float l9_580=l9_531;
if ((l9_578==0)||(l9_578==3))
{
float l9_581=l9_577;
float l9_582=0.0;
float l9_583=1.0;
bool l9_584=l9_579;
float l9_585=l9_580;
float l9_586=fast::clamp(l9_581,l9_582,l9_583);
float l9_587=step(abs(l9_581-l9_586),9.9999997e-06);
l9_585*=(l9_587+((1.0-float(l9_584))*(1.0-l9_587)));
l9_581=l9_586;
l9_577=l9_581;
l9_580=l9_585;
}
l9_521.y=l9_577;
l9_531=l9_580;
float2 l9_588=l9_521;
int l9_589=l9_519;
int l9_590=l9_520;
float l9_591=l9_529;
float2 l9_592=l9_588;
int l9_593=l9_589;
int l9_594=l9_590;
float3 l9_595=float3(0.0);
if (l9_593==0)
{
l9_595=float3(l9_592,0.0);
}
else
{
if (l9_593==1)
{
l9_595=float3(l9_592.x,(l9_592.y*0.5)+(0.5-(float(l9_594)*0.5)),0.0);
}
else
{
l9_595=float3(l9_592,float(l9_594));
}
}
float3 l9_596=l9_595;
float3 l9_597=l9_596;
float2 l9_598=l9_597.xy;
float l9_599=l9_591;
float4 l9_600=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_598,level(l9_599));
float4 l9_601=l9_600;
float4 l9_602=l9_601;
if (l9_527)
{
l9_602=mix(l9_528,l9_602,float4(l9_531));
}
float4 l9_603=l9_602;
l9_512=l9_603;
float4 l9_604=l9_512;
float2 l9_605=l9_604.xy;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_605=float2(1.0);
}
l9_507=l9_605*l9_500;
}
float2 l9_606=l9_507;
float2 l9_607=(((l9_495-float2(0.5))*(l9_493*l9_494))*l9_606)*l9_490;
float3 l9_608=(l9_452+(l9_484*l9_607.x))+(l9_483*(l9_607.y*l9_480));
N111_position=l9_608;
N111_normal=l9_474;
}
else
{
N111_position=N111_positionObjectSpace;
if (N111_ENABLE_CENTER_IN_BBOX)
{
float3 l9_609=(*sc_set2.UserUniforms).sc_LocalAabbMax;
float3 l9_610=(*sc_set2.UserUniforms).sc_LocalAabbMin;
float3 l9_611=(l9_609+l9_610)/float3(2.0);
N111_position-=l9_611;
}
float3 l9_612=N111_position;
float3 l9_613=l9_435;
float l9_614=l9_215;
float l9_615=l9_216;
float l9_616=l9_225;
float l9_617=N111_sizeSpeed;
float3 l9_618=N111_sizeStart;
float3 l9_619=N111_sizeEnd;
float l9_620=l9_616;
float l9_621=l9_617;
float l9_622;
if (l9_620<=0.0)
{
l9_622=0.0;
}
else
{
l9_622=pow(l9_620,l9_621);
}
float l9_623=l9_622;
float l9_624=l9_623;
if (N111_ENABLE_SIZEMINMAX)
{
l9_618=mix(N111_sizeStartMin,N111_sizeStartMax,float3(l9_614));
l9_619=mix(N111_sizeEndMin,N111_sizeEndMax,float3(l9_615));
}
float3 l9_625=mix(l9_618,l9_619,float3(l9_624));
if (N111_ENABLE_SIZERAMP)
{
float l9_626=ceil(l9_616*10000.0)/10000.0;
float2 l9_627=tempGlobals.Surface_UVCoord0;
float2 l9_628=(l9_627/float2(10000.0,1.0))+float2(l9_626,0.0);
float2 l9_629=l9_628;
float4 l9_630=float4(0.0);
int l9_631=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_632=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_632=0;
}
else
{
l9_632=gl_InstanceIndex%2;
}
int l9_633=l9_632;
l9_631=1-l9_633;
}
else
{
int l9_634=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_634=0;
}
else
{
l9_634=gl_InstanceIndex%2;
}
int l9_635=l9_634;
l9_631=l9_635;
}
int l9_636=l9_631;
int l9_637=sizeRampTextureLayout_tmp;
int l9_638=l9_636;
float2 l9_639=l9_629;
bool l9_640=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_641=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_642=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_643=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_644=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_645=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_646=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_647=0.0;
bool l9_648=l9_645&&(!l9_643);
float l9_649=1.0;
float l9_650=l9_639.x;
int l9_651=l9_642.x;
if (l9_651==1)
{
l9_650=fract(l9_650);
}
else
{
if (l9_651==2)
{
float l9_652=fract(l9_650);
float l9_653=l9_650-l9_652;
float l9_654=step(0.25,fract(l9_653*0.5));
l9_650=mix(l9_652,1.0-l9_652,fast::clamp(l9_654,0.0,1.0));
}
}
l9_639.x=l9_650;
float l9_655=l9_639.y;
int l9_656=l9_642.y;
if (l9_656==1)
{
l9_655=fract(l9_655);
}
else
{
if (l9_656==2)
{
float l9_657=fract(l9_655);
float l9_658=l9_655-l9_657;
float l9_659=step(0.25,fract(l9_658*0.5));
l9_655=mix(l9_657,1.0-l9_657,fast::clamp(l9_659,0.0,1.0));
}
}
l9_639.y=l9_655;
if (l9_643)
{
bool l9_660=l9_645;
bool l9_661;
if (l9_660)
{
l9_661=l9_642.x==3;
}
else
{
l9_661=l9_660;
}
float l9_662=l9_639.x;
float l9_663=l9_644.x;
float l9_664=l9_644.z;
bool l9_665=l9_661;
float l9_666=l9_649;
float l9_667=fast::clamp(l9_662,l9_663,l9_664);
float l9_668=step(abs(l9_662-l9_667),9.9999997e-06);
l9_666*=(l9_668+((1.0-float(l9_665))*(1.0-l9_668)));
l9_662=l9_667;
l9_639.x=l9_662;
l9_649=l9_666;
bool l9_669=l9_645;
bool l9_670;
if (l9_669)
{
l9_670=l9_642.y==3;
}
else
{
l9_670=l9_669;
}
float l9_671=l9_639.y;
float l9_672=l9_644.y;
float l9_673=l9_644.w;
bool l9_674=l9_670;
float l9_675=l9_649;
float l9_676=fast::clamp(l9_671,l9_672,l9_673);
float l9_677=step(abs(l9_671-l9_676),9.9999997e-06);
l9_675*=(l9_677+((1.0-float(l9_674))*(1.0-l9_677)));
l9_671=l9_676;
l9_639.y=l9_671;
l9_649=l9_675;
}
float2 l9_678=l9_639;
bool l9_679=l9_640;
float3x3 l9_680=l9_641;
if (l9_679)
{
l9_678=float2((l9_680*float3(l9_678,1.0)).xy);
}
float2 l9_681=l9_678;
float2 l9_682=l9_681;
float2 l9_683=l9_682;
l9_639=l9_683;
float l9_684=l9_639.x;
int l9_685=l9_642.x;
bool l9_686=l9_648;
float l9_687=l9_649;
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
l9_639.x=l9_684;
l9_649=l9_687;
float l9_695=l9_639.y;
int l9_696=l9_642.y;
bool l9_697=l9_648;
float l9_698=l9_649;
if ((l9_696==0)||(l9_696==3))
{
float l9_699=l9_695;
float l9_700=0.0;
float l9_701=1.0;
bool l9_702=l9_697;
float l9_703=l9_698;
float l9_704=fast::clamp(l9_699,l9_700,l9_701);
float l9_705=step(abs(l9_699-l9_704),9.9999997e-06);
l9_703*=(l9_705+((1.0-float(l9_702))*(1.0-l9_705)));
l9_699=l9_704;
l9_695=l9_699;
l9_698=l9_703;
}
l9_639.y=l9_695;
l9_649=l9_698;
float2 l9_706=l9_639;
int l9_707=l9_637;
int l9_708=l9_638;
float l9_709=l9_647;
float2 l9_710=l9_706;
int l9_711=l9_707;
int l9_712=l9_708;
float3 l9_713=float3(0.0);
if (l9_711==0)
{
l9_713=float3(l9_710,0.0);
}
else
{
if (l9_711==1)
{
l9_713=float3(l9_710.x,(l9_710.y*0.5)+(0.5-(float(l9_712)*0.5)),0.0);
}
else
{
l9_713=float3(l9_710,float(l9_712));
}
}
float3 l9_714=l9_713;
float3 l9_715=l9_714;
float2 l9_716=l9_715.xy;
float l9_717=l9_709;
float4 l9_718=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_716,level(l9_717));
float4 l9_719=l9_718;
float4 l9_720=l9_719;
if (l9_645)
{
l9_720=mix(l9_646,l9_720,float4(l9_649));
}
float4 l9_721=l9_720;
l9_630=l9_721;
float4 l9_722=l9_630;
float3 l9_723=l9_722.xyz;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_723=float3(1.0);
}
l9_625=l9_723*l9_618;
}
float3 l9_724=l9_625;
N111_position=(l9_612*l9_613)*l9_724;
if ((N111_dieTrigger<0.5)||(l9_462<0.5))
{
N111_position.x=2.1474836e+09;
}
float3x3 l9_725;
if (((N111_ENABLE_ALIGNTOVEL||N111_ENABLE_ALIGNTOX)||N111_ENABLE_ALIGNTOY)||N111_ENABLE_ALIGNTOZ)
{
if (N111_ENABLE_ALIGNTOZ)
{
l9_725=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
}
else
{
float3 l9_726=float3(0.0);
if (N111_ENABLE_ALIGNTOX)
{
l9_726=float3(1.0,0.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_726=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOVEL)
{
float l9_727=0.001;
float3 l9_728=l9_314;
float l9_729=l9_224-l9_727;
float3 l9_730=N111_velocityDrag;
float3 l9_731=l9_230;
float l9_732=l9_225-l9_727;
float3 l9_733=float3(l9_729,l9_729,l9_729);
float3 l9_734=l9_730;
float l9_735;
if (l9_733.x<=0.0)
{
l9_735=0.0;
}
else
{
l9_735=pow(l9_733.x,l9_734.x);
}
float l9_736=l9_735;
float l9_737;
if (l9_733.y<=0.0)
{
l9_737=0.0;
}
else
{
l9_737=pow(l9_733.y,l9_734.y);
}
float l9_738=l9_737;
float l9_739;
if (l9_733.z<=0.0)
{
l9_739=0.0;
}
else
{
l9_739=pow(l9_733.z,l9_734.z);
}
float3 l9_740=float3(l9_736,l9_738,l9_739);
float3 l9_741=l9_740;
float3 l9_742=(l9_728+l9_731)*l9_741;
if (N111_ENABLE_VELRAMP)
{
float l9_743=floor(l9_732*10000.0)/10000.0;
float2 l9_744=tempGlobals.Surface_UVCoord0;
float2 l9_745=(l9_744/float2(10000.0,1.0))+float2(l9_743,0.0);
float2 l9_746=l9_745;
float4 l9_747=float4(0.0);
int l9_748=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_749=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_749=0;
}
else
{
l9_749=gl_InstanceIndex%2;
}
int l9_750=l9_749;
l9_748=1-l9_750;
}
else
{
int l9_751=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_751=0;
}
else
{
l9_751=gl_InstanceIndex%2;
}
int l9_752=l9_751;
l9_748=l9_752;
}
int l9_753=l9_748;
int l9_754=velRampTextureLayout_tmp;
int l9_755=l9_753;
float2 l9_756=l9_746;
bool l9_757=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_758=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_759=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_760=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_761=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_762=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_763=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_764=0.0;
bool l9_765=l9_762&&(!l9_760);
float l9_766=1.0;
float l9_767=l9_756.x;
int l9_768=l9_759.x;
if (l9_768==1)
{
l9_767=fract(l9_767);
}
else
{
if (l9_768==2)
{
float l9_769=fract(l9_767);
float l9_770=l9_767-l9_769;
float l9_771=step(0.25,fract(l9_770*0.5));
l9_767=mix(l9_769,1.0-l9_769,fast::clamp(l9_771,0.0,1.0));
}
}
l9_756.x=l9_767;
float l9_772=l9_756.y;
int l9_773=l9_759.y;
if (l9_773==1)
{
l9_772=fract(l9_772);
}
else
{
if (l9_773==2)
{
float l9_774=fract(l9_772);
float l9_775=l9_772-l9_774;
float l9_776=step(0.25,fract(l9_775*0.5));
l9_772=mix(l9_774,1.0-l9_774,fast::clamp(l9_776,0.0,1.0));
}
}
l9_756.y=l9_772;
if (l9_760)
{
bool l9_777=l9_762;
bool l9_778;
if (l9_777)
{
l9_778=l9_759.x==3;
}
else
{
l9_778=l9_777;
}
float l9_779=l9_756.x;
float l9_780=l9_761.x;
float l9_781=l9_761.z;
bool l9_782=l9_778;
float l9_783=l9_766;
float l9_784=fast::clamp(l9_779,l9_780,l9_781);
float l9_785=step(abs(l9_779-l9_784),9.9999997e-06);
l9_783*=(l9_785+((1.0-float(l9_782))*(1.0-l9_785)));
l9_779=l9_784;
l9_756.x=l9_779;
l9_766=l9_783;
bool l9_786=l9_762;
bool l9_787;
if (l9_786)
{
l9_787=l9_759.y==3;
}
else
{
l9_787=l9_786;
}
float l9_788=l9_756.y;
float l9_789=l9_761.y;
float l9_790=l9_761.w;
bool l9_791=l9_787;
float l9_792=l9_766;
float l9_793=fast::clamp(l9_788,l9_789,l9_790);
float l9_794=step(abs(l9_788-l9_793),9.9999997e-06);
l9_792*=(l9_794+((1.0-float(l9_791))*(1.0-l9_794)));
l9_788=l9_793;
l9_756.y=l9_788;
l9_766=l9_792;
}
float2 l9_795=l9_756;
bool l9_796=l9_757;
float3x3 l9_797=l9_758;
if (l9_796)
{
l9_795=float2((l9_797*float3(l9_795,1.0)).xy);
}
float2 l9_798=l9_795;
float2 l9_799=l9_798;
float2 l9_800=l9_799;
l9_756=l9_800;
float l9_801=l9_756.x;
int l9_802=l9_759.x;
bool l9_803=l9_765;
float l9_804=l9_766;
if ((l9_802==0)||(l9_802==3))
{
float l9_805=l9_801;
float l9_806=0.0;
float l9_807=1.0;
bool l9_808=l9_803;
float l9_809=l9_804;
float l9_810=fast::clamp(l9_805,l9_806,l9_807);
float l9_811=step(abs(l9_805-l9_810),9.9999997e-06);
l9_809*=(l9_811+((1.0-float(l9_808))*(1.0-l9_811)));
l9_805=l9_810;
l9_801=l9_805;
l9_804=l9_809;
}
l9_756.x=l9_801;
l9_766=l9_804;
float l9_812=l9_756.y;
int l9_813=l9_759.y;
bool l9_814=l9_765;
float l9_815=l9_766;
if ((l9_813==0)||(l9_813==3))
{
float l9_816=l9_812;
float l9_817=0.0;
float l9_818=1.0;
bool l9_819=l9_814;
float l9_820=l9_815;
float l9_821=fast::clamp(l9_816,l9_817,l9_818);
float l9_822=step(abs(l9_816-l9_821),9.9999997e-06);
l9_820*=(l9_822+((1.0-float(l9_819))*(1.0-l9_822)));
l9_816=l9_821;
l9_812=l9_816;
l9_815=l9_820;
}
l9_756.y=l9_812;
l9_766=l9_815;
float2 l9_823=l9_756;
int l9_824=l9_754;
int l9_825=l9_755;
float l9_826=l9_764;
float2 l9_827=l9_823;
int l9_828=l9_824;
int l9_829=l9_825;
float3 l9_830=float3(0.0);
if (l9_828==0)
{
l9_830=float3(l9_827,0.0);
}
else
{
if (l9_828==1)
{
l9_830=float3(l9_827.x,(l9_827.y*0.5)+(0.5-(float(l9_829)*0.5)),0.0);
}
else
{
l9_830=float3(l9_827,float(l9_829));
}
}
float3 l9_831=l9_830;
float3 l9_832=l9_831;
float2 l9_833=l9_832.xy;
float l9_834=l9_826;
float4 l9_835=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_833,level(l9_834));
float4 l9_836=l9_835;
float4 l9_837=l9_836;
if (l9_762)
{
l9_837=mix(l9_763,l9_837,float4(l9_766));
}
float4 l9_838=l9_837;
l9_747=l9_838;
float4 l9_839=l9_747;
float3 l9_840=l9_839.xyz;
l9_742=(l9_728+l9_731)*l9_840;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_742=l9_728*l9_741;
}
}
float3 l9_841=l9_742;
float3 l9_842=l9_841;
float l9_843=((N111_gravity/2.0)*(l9_224-l9_727))*(l9_224-l9_727);
l9_311.y-=l9_843;
if (N111_ENABLE_FORCE)
{
float3 l9_844=float3(((N111_localForce/float3(2.0))*(l9_224-l9_727))*(l9_224-l9_727));
l9_312-=l9_844;
}
if (N111_WORLDFORCE)
{
float4x4 l9_845=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_846=l9_845;
float4 l9_847=l9_846[0];
float4 l9_848=l9_846[1];
float4 l9_849=l9_846[2];
float3x3 l9_850=float3x3(float3(float3(l9_847.x,l9_848.x,l9_849.x)),float3(float3(l9_847.y,l9_848.y,l9_849.y)),float3(float3(l9_847.z,l9_848.z,l9_849.z)));
float3x3 l9_851=l9_850;
l9_726=(((l9_313-l9_842)*l9_851)+l9_311)+l9_312;
}
else
{
if (N111_WORLDSPACE)
{
l9_726=((l9_313-l9_842)+l9_311)+l9_312;
}
else
{
float4x4 l9_852=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_853=l9_852;
float4 l9_854=l9_853[0];
float4 l9_855=l9_853[1];
float4 l9_856=l9_853[2];
float3x3 l9_857=float3x3(float3(float3(l9_854.x,l9_855.x,l9_856.x)),float3(float3(l9_854.y,l9_855.y,l9_856.y)),float3(float3(l9_854.z,l9_855.z,l9_856.z)));
float3x3 l9_858=l9_857;
l9_726=(((l9_313-l9_842)+l9_312)+l9_311)*l9_858;
}
}
l9_726=normalize(l9_726+float3(N111_EPSILON));
}
float3 l9_859=float3(0.0,0.0,1.0);
float3 l9_860=cross(l9_726,l9_859);
float3 l9_861=normalize(l9_860);
float l9_862=length(l9_860);
float l9_863=dot(l9_859,l9_726);
float l9_864=1.0-l9_863;
l9_725=float3x3(float3(((l9_864*l9_861.x)*l9_861.x)+l9_863,((l9_864*l9_861.x)*l9_861.y)-(l9_861.z*l9_862),((l9_864*l9_861.z)*l9_861.x)+(l9_861.y*l9_862)),float3(((l9_864*l9_861.x)*l9_861.y)+(l9_861.z*l9_862),((l9_864*l9_861.y)*l9_861.y)+l9_863,((l9_864*l9_861.y)*l9_861.z)-(l9_861.x*l9_862)),float3(((l9_864*l9_861.z)*l9_861.x)-(l9_861.y*l9_862),((l9_864*l9_861.y)*l9_861.z)+(l9_861.x*l9_862),((l9_864*l9_861.z)*l9_861.z)+l9_863));
}
float3x3 l9_865=float3x3(float3(cos(l9_461),-sin(l9_461),0.0),float3(sin(l9_461),cos(l9_461),0.0),float3(0.0,0.0,1.0));
l9_725=l9_725*l9_865;
if (N111_ENABLE_ALIGNTOVEL&&(!N111_ENABLE_IGNOREVEL))
{
float3 l9_866=l9_443*(l9_224-0.0099999998);
float3 l9_867=l9_443*(l9_224+0.0099999998);
N111_position.z*=(length(l9_867-l9_866)*fast::max(N111_sizeVelScale,0.1));
}
}
else
{
float l9_868=fract((N111_particleSeed.x*92.653008)+N111_globalSeed);
float l9_869=mix(N111_rotationRandomX.x,N111_rotationRandomX.y,l9_868);
float l9_870=mix(N111_rotationRateX.x,N111_rotationRateX.y,l9_868);
float l9_871=((l9_870*l9_458)*l9_225)*2.0;
float l9_872=fract((N111_particleSeed.y*6.7557559)+N111_globalSeed);
float l9_873=mix(N111_rotationRandomY.x,N111_rotationRandomY.y,l9_872);
float l9_874=mix(N111_rotationRateY.x,N111_rotationRateY.y,l9_872);
float l9_875=((l9_874*l9_458)*l9_225)*2.0;
float l9_876=N111_PI*(l9_871+l9_869);
float l9_877=N111_PI*(l9_875+l9_873);
float l9_878=N111_PI*(l9_460+l9_453);
float3 l9_879=float3(l9_876,l9_877,l9_878);
float l9_880=cos(l9_879.x);
float l9_881=sin(l9_879.x);
float l9_882=cos(l9_879.y);
float l9_883=sin(l9_879.y);
float l9_884=cos(l9_879.z);
float l9_885=sin(l9_879.z);
l9_725=float3x3(float3(l9_882*l9_884,(l9_880*l9_885)+((l9_881*l9_883)*l9_884),(l9_881*l9_885)-((l9_880*l9_883)*l9_884)),float3((-l9_882)*l9_885,(l9_880*l9_884)-((l9_881*l9_883)*l9_885),(l9_881*l9_884)+((l9_880*l9_883)*l9_885)),float3(l9_883,(-l9_881)*l9_882,l9_880*l9_882));
}
if ((!N111_WORLDSPACE)&&(!N111_ENABLE_ALIGNTOVEL))
{
float4x4 l9_886=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_887=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_888=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3x3 l9_889=float3x3(float3(l9_886[0].xyz/float3(l9_435.x)),float3(l9_887[1].xyz/float3(l9_435.y)),float3(l9_888[2].xyz/float3(l9_435.z)));
l9_725=l9_889*l9_725;
}
N111_position=l9_725*N111_position;
N111_normal=normalize(l9_725*N111_normalObjectSpace);
N111_position+=l9_452;
}
N111_timeValues=float4(l9_223,l9_224,l9_225);
param_116=N111_position;
position_N111=param_116;
WorldPosition=position_N111;
float Output_N3_1=0.0;
float param_118=(*sc_set2.UserUniforms).timeGlobal;
Output_N3_1=param_118;
float Output_N5_1=0.0;
float param_119=(*sc_set2.UserUniforms).externalTimeInput;
Output_N5_1=param_119;
float Output_N7_1=0.0;
float param_120=(*sc_set2.UserUniforms).externalSeed;
Output_N7_1=param_120;
float Output_N9_1=0.0;
float param_121=(*sc_set2.UserUniforms).lifeTimeConstant;
Output_N9_1=param_121;
float2 Output_N10_1=float2(0.0);
float2 param_122=(*sc_set2.UserUniforms).lifeTimeMinMax;
Output_N10_1=param_122;
float Output_N12_1=0.0;
float param_123=(*sc_set2.UserUniforms).spawnDuration;
Output_N12_1=param_123;
float3 particleSeed_N173_1=float3(0.0);
float globalSeed_N173_1=0.0;
float dieTrigger_N173_1=0.0;
float4 timeValues_N173_1=float4(0.0);
float param_124=Output_N3_1;
float param_125=Output_N5_1;
float param_126=Output_N7_1;
float param_127=Output_N9_1;
float2 param_128=Output_N10_1;
float param_129=Output_N12_1;
ssGlobals param_134=Globals;
tempGlobals=param_134;
float3 param_130=float3(0.0);
float param_131=0.0;
float param_132=0.0;
float4 param_133=float4(0.0);
N173_timeGlobal=param_124;
N173_ENABLE_EXTERNALTIME=(int(EXTERNALTIME_tmp)!=0);
N173_externalTime=param_125;
N173_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N173_externalSeed=param_126;
N173_ENABLE_LIFETIMEMINMAX=(int(LIFETIMEMINMAX_tmp)!=0);
N173_lifeTimeConstant=param_127;
N173_lifeTimeMinMax=param_128;
N173_ENABLE_INSTANTSPAWN=(int(INSTANTSPAWN_tmp)!=0);
N173_spawnDuration=param_129;
float l9_890=0.0;
if (N173_ENABLE_WORLDPOSSEED)
{
float4x4 l9_891=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_890=length(float4(1.0)*l9_891);
}
N173_globalSeed=N173_externalSeed+l9_890;
float l9_892=2000.0;
int l9_893=0;
int l9_894=gl_InstanceIndex;
l9_893=l9_894;
int l9_895=l9_893;
float l9_896=float(l9_895);
float2 l9_897=float2(mod(l9_896,l9_892),floor(l9_896/l9_892));
l9_897/=float2(l9_892);
float2 l9_898=l9_897;
float l9_899=dot(l9_898,float2(0.38253,0.42662001));
float3 l9_900=float3(0.457831,0.62343299,0.97625297)*l9_899;
l9_900=sin(l9_900)*float3(479.371,389.53101,513.03497);
l9_900=fract(l9_900);
l9_900=floor(l9_900*10000.0)*9.9999997e-05;
float3 l9_901=l9_900;
float3 l9_902=l9_901;
N173_particleSeed=l9_902;
float l9_903=fract((N173_particleSeed.y*12.12358)+N173_globalSeed);
float l9_904=fract((N173_particleSeed.z*3.5358)+N173_globalSeed);
float2 l9_905=float2(N173_lifeTimeConstant);
if (N173_ENABLE_LIFETIMEMINMAX)
{
l9_905=N173_lifeTimeMinMax;
}
float l9_906=fast::max(l9_905.x,0.0099999998);
float l9_907=fast::max(l9_905.y,0.0099999998);
float l9_908=tempGlobals.gTimeElapsed;
float l9_909=l9_908;
if (N173_ENABLE_EXTERNALTIME)
{
l9_909=N173_externalTime;
}
float l9_910=l9_909;
if (N173_ENABLE_INSTANTSPAWN)
{
l9_910=N173_timeGlobal*l9_909;
}
else
{
float l9_911=fract(((l9_909*N173_timeGlobal)*(1.0/l9_905.y))+l9_903);
l9_910=l9_911*l9_905.y;
}
float l9_912=mix(l9_910/l9_906,l9_910/l9_907,l9_904);
float l9_913=fast::clamp(l9_912,0.0,1.0);
float l9_914=0.0;
if (!N173_ENABLE_INSTANTSPAWN)
{
if (N173_spawnDuration>0.0)
{
if ((l9_909-N173_spawnDuration)>=l9_910)
{
l9_914=1.0;
}
}
}
float l9_915=l9_912+l9_914;
N173_dieTrigger=1.0;
if (l9_915>0.99989998)
{
N173_dieTrigger=0.0;
}
N173_timeValues=float4(l9_905,l9_910,l9_913);
param_130=N173_particleSeed;
param_131=N173_globalSeed;
param_132=N173_dieTrigger;
param_133=N173_timeValues;
particleSeed_N173_1=param_130;
globalSeed_N173_1=param_131;
dieTrigger_N173_1=param_132;
timeValues_N173_1=param_133;
float3 Position_N114_1=float3(0.0);
Position_N114_1=Globals.SurfacePosition_ObjectSpace;
float3 Normal_N172_1=float3(0.0);
Normal_N172_1=Globals.VertexNormal_ObjectSpace;
float3 Output_N16_1=float3(0.0);
float3 param_135=(*sc_set2.UserUniforms).spawnLocation;
Output_N16_1=param_135;
float3 Output_N18_1=float3(0.0);
float3 param_136=(*sc_set2.UserUniforms).spawnBox;
Output_N18_1=param_136;
float3 Output_N20_1=float3(0.0);
float3 param_137=(*sc_set2.UserUniforms).spawnSphere;
Output_N20_1=param_137;
float3 Output_N39_1=float3(0.0);
float3 param_138=(*sc_set2.UserUniforms).noiseMult;
Output_N39_1=param_138;
float3 Output_N40_1=float3(0.0);
float3 param_139=(*sc_set2.UserUniforms).noiseFrequency;
Output_N40_1=param_139;
float3 Output_N41_1=float3(0.0);
float3 param_140=(*sc_set2.UserUniforms).sNoiseMult;
Output_N41_1=param_140;
float3 Output_N42_1=float3(0.0);
float3 param_141=(*sc_set2.UserUniforms).sNoiseFrequency;
Output_N42_1=param_141;
float3 Output_N34_1=float3(0.0);
float3 param_142=(*sc_set2.UserUniforms).velocityMin;
Output_N34_1=param_142;
float3 Output_N35_1=float3(0.0);
float3 param_143=(*sc_set2.UserUniforms).velocityMax;
Output_N35_1=param_143;
float3 Output_N36_1=float3(0.0);
float3 param_144=(*sc_set2.UserUniforms).velocityDrag;
Output_N36_1=param_144;
float3 Result_N70_1=float3(0.0);
float3 param_145=float3(0.0);
float3 param_146=float3(0.0);
float3 param_147;
if (MESHTYPE_tmp==0)
{
float2 l9_916=float2(0.0);
float2 l9_917=(*sc_set2.UserUniforms).sizeStart;
l9_916=l9_917;
param_145=float3(l9_916,0.0);
param_147=param_145;
}
else
{
float3 l9_918=float3(0.0);
float3 l9_919=(*sc_set2.UserUniforms).sizeStart3D;
l9_918=l9_919;
param_146=l9_918;
param_147=param_146;
}
Result_N70_1=param_147;
float3 Result_N121_1=float3(0.0);
float3 param_148=float3(0.0);
float3 param_149=float3(0.0);
float3 param_150;
if (MESHTYPE_tmp==0)
{
float2 l9_920=float2(0.0);
float2 l9_921=(*sc_set2.UserUniforms).sizeEnd;
l9_920=l9_921;
param_148=float3(l9_920,0.0);
param_150=param_148;
}
else
{
float3 l9_922=float3(0.0);
float3 l9_923=(*sc_set2.UserUniforms).sizeEnd3D;
l9_922=l9_923;
param_149=l9_922;
param_150=param_149;
}
Result_N121_1=param_150;
float3 Result_N124_1=float3(0.0);
float3 param_151=float3(0.0);
float3 param_152=float3(0.0);
float3 param_153;
if (MESHTYPE_tmp==0)
{
float2 l9_924=float2(0.0);
float2 l9_925=(*sc_set2.UserUniforms).sizeStartMin;
l9_924=l9_925;
param_151=float3(l9_924,0.0);
param_153=param_151;
}
else
{
float3 l9_926=float3(0.0);
float3 l9_927=(*sc_set2.UserUniforms).sizeStartMin3D;
l9_926=l9_927;
param_152=l9_926;
param_153=param_152;
}
Result_N124_1=param_153;
float3 Result_N123_1=float3(0.0);
float3 param_154=float3(0.0);
float3 param_155=float3(0.0);
float3 param_156;
if (MESHTYPE_tmp==0)
{
float2 l9_928=float2(0.0);
float2 l9_929=(*sc_set2.UserUniforms).sizeStartMax;
l9_928=l9_929;
param_154=float3(l9_928,0.0);
param_156=param_154;
}
else
{
float3 l9_930=float3(0.0);
float3 l9_931=(*sc_set2.UserUniforms).sizeStartMax3D;
l9_930=l9_931;
param_155=l9_930;
param_156=param_155;
}
Result_N123_1=param_156;
float3 Result_N125_1=float3(0.0);
float3 param_157=float3(0.0);
float3 param_158=float3(0.0);
float3 param_159;
if (MESHTYPE_tmp==0)
{
float2 l9_932=float2(0.0);
float2 l9_933=(*sc_set2.UserUniforms).sizeEndMin;
l9_932=l9_933;
param_157=float3(l9_932,0.0);
param_159=param_157;
}
else
{
float3 l9_934=float3(0.0);
float3 l9_935=(*sc_set2.UserUniforms).sizeEndMin3D;
l9_934=l9_935;
param_158=l9_934;
param_159=param_158;
}
Result_N125_1=param_159;
float3 Result_N126_1=float3(0.0);
float3 param_160=float3(0.0);
float3 param_161=float3(0.0);
float3 param_162;
if (MESHTYPE_tmp==0)
{
float2 l9_936=float2(0.0);
float2 l9_937=(*sc_set2.UserUniforms).sizeEndMax;
l9_936=l9_937;
param_160=float3(l9_936,0.0);
param_162=param_160;
}
else
{
float3 l9_938=float3(0.0);
float3 l9_939=(*sc_set2.UserUniforms).sizeEndMax3D;
l9_938=l9_939;
param_161=l9_938;
param_162=param_161;
}
Result_N126_1=param_162;
float Output_N27_1=0.0;
float param_163=(*sc_set2.UserUniforms).sizeSpeed;
Output_N27_1=param_163;
float Output_N55_1=0.0;
float param_164=(*sc_set2.UserUniforms).gravity;
Output_N55_1=param_164;
float3 Output_N46_1=float3(0.0);
float3 param_165=(*sc_set2.UserUniforms).localForce;
Output_N46_1=param_165;
float Output_N51_1=0.0;
float param_166=(*sc_set2.UserUniforms).sizeVelScale;
Output_N51_1=param_166;
float Output_N48_1=0.0;
float param_167=float((*sc_set2.UserUniforms).ALIGNTOX!=0);
Output_N48_1=param_167;
float Output_N49_1=0.0;
float param_168=float((*sc_set2.UserUniforms).ALIGNTOY!=0);
Output_N49_1=param_168;
float Output_N50_1=0.0;
float param_169=float((*sc_set2.UserUniforms).ALIGNTOZ!=0);
Output_N50_1=param_169;
float2 Output_N138_1=float2(0.0);
float2 param_170=(*sc_set2.UserUniforms).Port_Input1_N138;
float2 param_171=float2(0.0);
float2 param_172;
if (MESHTYPE_tmp==0)
{
param_172=param_170;
}
else
{
float2 l9_940=float2(0.0);
float2 l9_941=(*sc_set2.UserUniforms).rotationRandomX;
l9_940=l9_941;
param_171=l9_940;
param_172=param_171;
}
Output_N138_1=param_172;
float2 Output_N139_1=float2(0.0);
float2 param_173=(*sc_set2.UserUniforms).Port_Input1_N139;
float2 param_174=float2(0.0);
float2 param_175;
if (MESHTYPE_tmp==0)
{
param_175=param_173;
}
else
{
float2 l9_942=float2(0.0);
float2 l9_943=(*sc_set2.UserUniforms).rotationRateX;
l9_942=l9_943;
param_174=l9_942;
param_175=param_174;
}
Output_N139_1=param_175;
float2 Output_N140_1=float2(0.0);
float2 param_176=(*sc_set2.UserUniforms).Port_Input1_N140;
float2 param_177=float2(0.0);
float2 param_178;
if (MESHTYPE_tmp==0)
{
param_178=param_176;
}
else
{
float2 l9_944=float2(0.0);
float2 l9_945=(*sc_set2.UserUniforms).randomRotationY;
l9_944=l9_945;
param_177=l9_944;
param_178=param_177;
}
Output_N140_1=param_178;
float2 Output_N144_1=float2(0.0);
float2 param_179=(*sc_set2.UserUniforms).Port_Input1_N144;
float2 param_180=float2(0.0);
float2 param_181;
if (MESHTYPE_tmp==0)
{
param_181=param_179;
}
else
{
float2 l9_946=float2(0.0);
float2 l9_947=(*sc_set2.UserUniforms).rotationRateY;
l9_946=l9_947;
param_180=l9_946;
param_181=param_180;
}
Output_N144_1=param_181;
float2 Output_N135_1=float2(0.0);
float2 param_182=float2(1.0);
float2 param_183=float2(0.0);
float2 param_184;
if (MESHTYPE_tmp==0)
{
float2 l9_948=float2(0.0);
float2 l9_949=(*sc_set2.UserUniforms).rotationRandom;
l9_948=l9_949;
param_182=l9_948;
param_184=param_182;
}
else
{
float2 l9_950=float2(0.0);
float2 l9_951=(*sc_set2.UserUniforms).randomRotationZ;
l9_950=l9_951;
param_183=l9_950;
param_184=param_183;
}
Output_N135_1=param_184;
float2 Output_N137_1=float2(0.0);
float2 param_185=float2(1.0);
float2 param_186=float2(0.0);
float2 param_187;
if (MESHTYPE_tmp==0)
{
float2 l9_952=float2(0.0);
float2 l9_953=(*sc_set2.UserUniforms).rotationRate;
l9_952=l9_953;
param_185=l9_952;
param_187=param_185;
}
else
{
float2 l9_954=float2(0.0);
float2 l9_955=(*sc_set2.UserUniforms).rotationRateZ;
l9_954=l9_955;
param_186=l9_954;
param_187=param_186;
}
Output_N137_1=param_187;
float Output_N54_1=0.0;
float param_188=(*sc_set2.UserUniforms).rotationDrag;
Output_N54_1=param_188;
float Output_N110_1=0.0;
float param_189=(*sc_set2.UserUniforms).Port_Input1_N110;
float param_190=0.0;
float param_191;
if (MESHTYPE_tmp==0)
{
param_191=param_189;
}
else
{
float l9_956=0.0;
float l9_957=float((*sc_set2.UserUniforms).CENTER_BBOX!=0);
l9_956=l9_957;
param_190=l9_956;
param_191=param_190;
}
Output_N110_1=param_191;
float Output_N176_1=0.0;
float param_192=(*sc_set2.UserUniforms).fadeDistanceVisible;
Output_N176_1=param_192;
float Output_N178_1=0.0;
float param_193=(*sc_set2.UserUniforms).fadeDistanceInvisible;
Output_N178_1=param_193;
float3 normal_N111=float3(0.0);
float3 param_194=particleSeed_N173_1;
float param_195=globalSeed_N173_1;
float param_196=dieTrigger_N173_1;
float4 param_197=timeValues_N173_1;
float3 param_198=Position_N114_1;
float3 param_199=Normal_N172_1;
float3 param_200=Output_N16_1;
float3 param_201=Output_N18_1;
float3 param_202=Output_N20_1;
float3 param_203=Output_N39_1;
float3 param_204=Output_N40_1;
float3 param_205=Output_N41_1;
float3 param_206=Output_N42_1;
float3 param_207=Output_N34_1;
float3 param_208=Output_N35_1;
float3 param_209=Output_N36_1;
float3 param_210=Result_N70_1;
float3 param_211=Result_N121_1;
float3 param_212=Result_N124_1;
float3 param_213=Result_N123_1;
float3 param_214=Result_N125_1;
float3 param_215=Result_N126_1;
float param_216=Output_N27_1;
float param_217=Output_N55_1;
float3 param_218=Output_N46_1;
float param_219=Output_N51_1;
float param_220=Output_N48_1;
float param_221=Output_N49_1;
float param_222=Output_N50_1;
float2 param_223=Output_N138_1;
float2 param_224=Output_N139_1;
float2 param_225=Output_N140_1;
float2 param_226=Output_N144_1;
float2 param_227=Output_N135_1;
float2 param_228=Output_N137_1;
float param_229=Output_N54_1;
float param_230=Output_N110_1;
float param_231=Output_N176_1;
float param_232=Output_N178_1;
ssGlobals param_234=Globals;
tempGlobals=param_234;
float3 param_233=float3(0.0);
N111_MESHTYPE_QUAD=MESHTYPE_tmp==0;
N111_particleSeedIn=param_194;
N111_globalSeedIn=param_195;
N111_dieTrigger=param_196;
N111_timeValuesIn=param_197;
N111_positionObjectSpace=param_198;
N111_normalObjectSpace=param_199;
N111_ENABLE_INILOCATION=(int(INILOCATION_tmp)!=0);
N111_spawnLocation=param_200;
N111_ENABLE_BOXSPAWN=(int(BOXSPAWN_tmp)!=0);
N111_spawnBox=param_201;
N111_ENABLE_SPHERESPAWN=(int(SPHERESPAWN_tmp)!=0);
N111_spawnSphere=param_202;
N111_ENABLE_NOISE=(int(NOISE_tmp)!=0);
N111_noiseMult=param_203;
N111_noiseFrequency=param_204;
N111_ENABLE_SNOISE=(int(SNOISE_tmp)!=0);
N111_sNoiseMult=param_205;
N111_sNoiseFrequency=param_206;
N111_ENABLE_VELRAMP=(int(VELRAMP_tmp)!=0);
N111_velocityMin=param_207;
N111_velocityMax=param_208;
N111_velocityDrag=param_209;
N111_sizeStart=param_210;
N111_sizeEnd=param_211;
N111_ENABLE_SIZEMINMAX=(int(SIZEMINMAX_tmp)!=0);
N111_sizeStartMin=param_212;
N111_sizeStartMax=param_213;
N111_sizeEndMin=param_214;
N111_sizeEndMax=param_215;
N111_sizeSpeed=param_216;
N111_ENABLE_SIZERAMP=(int(SIZERAMP_tmp)!=0);
N111_gravity=param_217;
N111_ENABLE_FORCE=(int(FORCE_tmp)!=0);
N111_localForce=param_218;
N111_ENABLE_ALIGNTOVEL=(int(VELOCITYDIR_tmp)!=0);
N111_sizeVelScale=param_219;
N111_ENABLE_IGNOREVEL=(int(IGNOREVEL_tmp)!=0);
N111_ENABLE_IGNORETRANSFORMSCALE=(int(IGNORETRANSFORMSCALE_tmp)!=0);
N111_ENABLE_ALIGNTOX=param_220!=0.0;
N111_ENABLE_ALIGNTOY=param_221!=0.0;
N111_ENABLE_ALIGNTOZ=param_222!=0.0;
N111_rotationRandomX=param_223;
N111_rotationRateX=param_224;
N111_rotationRandomY=param_225;
N111_rotationRateY=param_226;
N111_rotationRandomZ=param_227;
N111_rotationRateZ=param_228;
N111_rotationDrag=param_229;
N111_WORLDSPACE=rotationSpace_tmp==1;
N111_WORLDFORCE=rotationSpace_tmp==2;
N111_ENABLE_CENTER_IN_BBOX=param_230!=0.0;
N111_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N111_fadeDistanceVisible=param_231;
N111_fadeDistanceInvisible=param_232;
float3 l9_958=float3(0.0);
N111_particleSeed=N111_particleSeedIn;
N111_globalSeed=N111_globalSeedIn;
float l9_959=N111_particleSeed.x;
float l9_960=N111_particleSeed.y;
float l9_961=N111_particleSeed.z;
float3 l9_962=fract((float3(l9_959,l9_960,l9_961)*3048.28)+float3(N111_globalSeed))-float3(0.5);
float3 l9_963=fract((N111_particleSeed*374.57129)+float3(N111_globalSeed))-float3(0.5);
float3 l9_964=normalize(l9_963+float3(N111_EPSILON));
float l9_965=fract(N111_particleSeed.x+N111_globalSeed);
float l9_966=l9_965;
float l9_967=0.33333334;
float l9_968;
if (l9_966<=0.0)
{
l9_968=0.0;
}
else
{
l9_968=pow(l9_966,l9_967);
}
float l9_969=l9_968;
float l9_970=l9_969;
l9_964*=l9_970;
l9_964/=float3(2.0);
float l9_971=fract((N111_particleSeed.x*334.59122)+N111_globalSeed)-0.5;
float l9_972=fract((N111_particleSeed.y*41.231232)+N111_globalSeed)-0.5;
float l9_973=fract((N111_particleSeed.z*18.984529)+N111_globalSeed);
float l9_974=fract((N111_particleSeed.x*654.15588)+N111_globalSeed);
float l9_975=fract((N111_particleSeed.y*45.722408)+N111_globalSeed);
float3 l9_976=(float3(l9_974,l9_975,l9_973)-float3(0.5))*2.0;
float3 l9_977=float3(l9_974,l9_975,l9_973);
float l9_978=fract((N111_particleSeed.z*15.32451)+N111_globalSeed);
float2 l9_979=N111_timeValuesIn.xy;
float l9_980=N111_timeValuesIn.z;
float l9_981=N111_timeValuesIn.w;
float3 l9_982=l9_958;
float3 l9_983=l9_958;
float3 l9_984=l9_958;
if (N111_ENABLE_INILOCATION)
{
l9_984=N111_spawnLocation;
}
if (N111_ENABLE_BOXSPAWN)
{
l9_982=N111_spawnBox*l9_962;
}
if (N111_ENABLE_SPHERESPAWN)
{
l9_983=N111_spawnSphere*l9_964;
}
float3 l9_985=(l9_984+l9_983)+l9_982;
float3 l9_986=l9_958;
if (N111_ENABLE_NOISE)
{
float3 l9_987=N111_noiseFrequency;
float3 l9_988=N111_noiseMult;
float3 l9_989=l9_976;
float l9_990=l9_981;
float l9_991=sin(l9_990*l9_987.x);
float l9_992=sin(l9_990*l9_987.y);
float l9_993=sin(l9_990*l9_987.z);
float3 l9_994=(float3(l9_991,l9_992,l9_993)*l9_988)*l9_989;
float3 l9_995=l9_994;
l9_986+=l9_995;
}
if (N111_ENABLE_SNOISE)
{
float l9_996=l9_973;
float l9_997=l9_974;
float l9_998=l9_975;
float3 l9_999=N111_sNoiseFrequency;
float3 l9_1000=N111_sNoiseMult;
float3 l9_1001=l9_976;
float l9_1002=l9_980;
float2 l9_1003=float2(l9_996*l9_1002,l9_999.x);
float2 l9_1004=floor(l9_1003+float2(dot(l9_1003,float2(0.36602542))));
float2 l9_1005=(l9_1003-l9_1004)+float2(dot(l9_1004,float2(0.21132487)));
float2 l9_1006=float2(0.0);
bool2 l9_1007=bool2(l9_1005.x>l9_1005.y);
l9_1006=float2(l9_1007.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_1007.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_1008=l9_1005.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_1009=l9_1008.xy-l9_1006;
l9_1008=float4(l9_1009.x,l9_1009.y,l9_1008.z,l9_1008.w);
l9_1004=mod(l9_1004,float2(289.0));
float3 l9_1010=float3(l9_1004.y)+float3(0.0,l9_1006.y,1.0);
float3 l9_1011=mod(((l9_1010*34.0)+float3(1.0))*l9_1010,float3(289.0));
float3 l9_1012=(l9_1011+float3(l9_1004.x))+float3(0.0,l9_1006.x,1.0);
float3 l9_1013=mod(((l9_1012*34.0)+float3(1.0))*l9_1012,float3(289.0));
float3 l9_1014=l9_1013;
float3 l9_1015=fast::max(float3(0.5)-float3(dot(l9_1005,l9_1005),dot(l9_1008.xy,l9_1008.xy),dot(l9_1008.zw,l9_1008.zw)),float3(0.0));
l9_1015*=l9_1015;
l9_1015*=l9_1015;
float3 l9_1016=(fract(l9_1014*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_1017=abs(l9_1016)-float3(0.5);
float3 l9_1018=floor(l9_1016+float3(0.5));
float3 l9_1019=l9_1016-l9_1018;
l9_1015*=(float3(1.7928429)-(((l9_1019*l9_1019)+(l9_1017*l9_1017))*0.85373473));
float3 l9_1020=float3(0.0);
l9_1020.x=(l9_1019.x*l9_1005.x)+(l9_1017.x*l9_1005.y);
float2 l9_1021=(l9_1019.yz*l9_1008.xz)+(l9_1017.yz*l9_1008.yw);
l9_1020=float3(l9_1020.x,l9_1021.x,l9_1021.y);
float l9_1022=130.0*dot(l9_1015,l9_1020);
float l9_1023=l9_1022;
float2 l9_1024=float2(l9_997*l9_1002,l9_999.y);
float2 l9_1025=floor(l9_1024+float2(dot(l9_1024,float2(0.36602542))));
float2 l9_1026=(l9_1024-l9_1025)+float2(dot(l9_1025,float2(0.21132487)));
float2 l9_1027=float2(0.0);
bool2 l9_1028=bool2(l9_1026.x>l9_1026.y);
l9_1027=float2(l9_1028.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_1028.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_1029=l9_1026.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_1030=l9_1029.xy-l9_1027;
l9_1029=float4(l9_1030.x,l9_1030.y,l9_1029.z,l9_1029.w);
l9_1025=mod(l9_1025,float2(289.0));
float3 l9_1031=float3(l9_1025.y)+float3(0.0,l9_1027.y,1.0);
float3 l9_1032=mod(((l9_1031*34.0)+float3(1.0))*l9_1031,float3(289.0));
float3 l9_1033=(l9_1032+float3(l9_1025.x))+float3(0.0,l9_1027.x,1.0);
float3 l9_1034=mod(((l9_1033*34.0)+float3(1.0))*l9_1033,float3(289.0));
float3 l9_1035=l9_1034;
float3 l9_1036=fast::max(float3(0.5)-float3(dot(l9_1026,l9_1026),dot(l9_1029.xy,l9_1029.xy),dot(l9_1029.zw,l9_1029.zw)),float3(0.0));
l9_1036*=l9_1036;
l9_1036*=l9_1036;
float3 l9_1037=(fract(l9_1035*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_1038=abs(l9_1037)-float3(0.5);
float3 l9_1039=floor(l9_1037+float3(0.5));
float3 l9_1040=l9_1037-l9_1039;
l9_1036*=(float3(1.7928429)-(((l9_1040*l9_1040)+(l9_1038*l9_1038))*0.85373473));
float3 l9_1041=float3(0.0);
l9_1041.x=(l9_1040.x*l9_1026.x)+(l9_1038.x*l9_1026.y);
float2 l9_1042=(l9_1040.yz*l9_1029.xz)+(l9_1038.yz*l9_1029.yw);
l9_1041=float3(l9_1041.x,l9_1042.x,l9_1042.y);
float l9_1043=130.0*dot(l9_1036,l9_1041);
float l9_1044=l9_1043;
float2 l9_1045=float2(l9_998*l9_1002,l9_999.z);
float2 l9_1046=floor(l9_1045+float2(dot(l9_1045,float2(0.36602542))));
float2 l9_1047=(l9_1045-l9_1046)+float2(dot(l9_1046,float2(0.21132487)));
float2 l9_1048=float2(0.0);
bool2 l9_1049=bool2(l9_1047.x>l9_1047.y);
l9_1048=float2(l9_1049.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_1049.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_1050=l9_1047.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_1051=l9_1050.xy-l9_1048;
l9_1050=float4(l9_1051.x,l9_1051.y,l9_1050.z,l9_1050.w);
l9_1046=mod(l9_1046,float2(289.0));
float3 l9_1052=float3(l9_1046.y)+float3(0.0,l9_1048.y,1.0);
float3 l9_1053=mod(((l9_1052*34.0)+float3(1.0))*l9_1052,float3(289.0));
float3 l9_1054=(l9_1053+float3(l9_1046.x))+float3(0.0,l9_1048.x,1.0);
float3 l9_1055=mod(((l9_1054*34.0)+float3(1.0))*l9_1054,float3(289.0));
float3 l9_1056=l9_1055;
float3 l9_1057=fast::max(float3(0.5)-float3(dot(l9_1047,l9_1047),dot(l9_1050.xy,l9_1050.xy),dot(l9_1050.zw,l9_1050.zw)),float3(0.0));
l9_1057*=l9_1057;
l9_1057*=l9_1057;
float3 l9_1058=(fract(l9_1056*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_1059=abs(l9_1058)-float3(0.5);
float3 l9_1060=floor(l9_1058+float3(0.5));
float3 l9_1061=l9_1058-l9_1060;
l9_1057*=(float3(1.7928429)-(((l9_1061*l9_1061)+(l9_1059*l9_1059))*0.85373473));
float3 l9_1062=float3(0.0);
l9_1062.x=(l9_1061.x*l9_1047.x)+(l9_1059.x*l9_1047.y);
float2 l9_1063=(l9_1061.yz*l9_1050.xz)+(l9_1059.yz*l9_1050.yw);
l9_1062=float3(l9_1062.x,l9_1063.x,l9_1063.y);
float l9_1064=130.0*dot(l9_1057,l9_1062);
float l9_1065=l9_1064;
float3 l9_1066=(float3(l9_1023,l9_1044,l9_1065)*l9_1000)*l9_1001;
l9_986+=l9_1066;
}
float3 l9_1067=float3(0.0,((N111_gravity/2.0)*l9_980)*l9_980,0.0);
float3 l9_1068=l9_958;
if (N111_ENABLE_FORCE)
{
l9_1068=((N111_localForce/float3(2.0))*l9_980)*l9_980;
}
float3 l9_1069=l9_958;
float3 l9_1070=N111_velocityMin+(((l9_976+float3(1.0))/float3(2.0))*(N111_velocityMax-N111_velocityMin));
if (N111_ENABLE_VELRAMP)
{
l9_1070=mix(N111_velocityMin,N111_velocityMax,l9_977);
}
float3 l9_1071=l9_1070;
float l9_1072=l9_980;
float3 l9_1073=N111_velocityDrag;
float3 l9_1074=l9_986;
float l9_1075=l9_981;
float3 l9_1076=float3(l9_1072,l9_1072,l9_1072);
float3 l9_1077=l9_1073;
float l9_1078;
if (l9_1076.x<=0.0)
{
l9_1078=0.0;
}
else
{
l9_1078=pow(l9_1076.x,l9_1077.x);
}
float l9_1079=l9_1078;
float l9_1080;
if (l9_1076.y<=0.0)
{
l9_1080=0.0;
}
else
{
l9_1080=pow(l9_1076.y,l9_1077.y);
}
float l9_1081=l9_1080;
float l9_1082;
if (l9_1076.z<=0.0)
{
l9_1082=0.0;
}
else
{
l9_1082=pow(l9_1076.z,l9_1077.z);
}
float3 l9_1083=float3(l9_1079,l9_1081,l9_1082);
float3 l9_1084=l9_1083;
float3 l9_1085=(l9_1071+l9_1074)*l9_1084;
if (N111_ENABLE_VELRAMP)
{
float l9_1086=floor(l9_1075*10000.0)/10000.0;
float2 l9_1087=tempGlobals.Surface_UVCoord0;
float2 l9_1088=(l9_1087/float2(10000.0,1.0))+float2(l9_1086,0.0);
float2 l9_1089=l9_1088;
float4 l9_1090=float4(0.0);
int l9_1091=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_1092=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1092=0;
}
else
{
l9_1092=gl_InstanceIndex%2;
}
int l9_1093=l9_1092;
l9_1091=1-l9_1093;
}
else
{
int l9_1094=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1094=0;
}
else
{
l9_1094=gl_InstanceIndex%2;
}
int l9_1095=l9_1094;
l9_1091=l9_1095;
}
int l9_1096=l9_1091;
int l9_1097=velRampTextureLayout_tmp;
int l9_1098=l9_1096;
float2 l9_1099=l9_1089;
bool l9_1100=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_1101=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_1102=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_1103=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_1104=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_1105=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_1106=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_1107=0.0;
bool l9_1108=l9_1105&&(!l9_1103);
float l9_1109=1.0;
float l9_1110=l9_1099.x;
int l9_1111=l9_1102.x;
if (l9_1111==1)
{
l9_1110=fract(l9_1110);
}
else
{
if (l9_1111==2)
{
float l9_1112=fract(l9_1110);
float l9_1113=l9_1110-l9_1112;
float l9_1114=step(0.25,fract(l9_1113*0.5));
l9_1110=mix(l9_1112,1.0-l9_1112,fast::clamp(l9_1114,0.0,1.0));
}
}
l9_1099.x=l9_1110;
float l9_1115=l9_1099.y;
int l9_1116=l9_1102.y;
if (l9_1116==1)
{
l9_1115=fract(l9_1115);
}
else
{
if (l9_1116==2)
{
float l9_1117=fract(l9_1115);
float l9_1118=l9_1115-l9_1117;
float l9_1119=step(0.25,fract(l9_1118*0.5));
l9_1115=mix(l9_1117,1.0-l9_1117,fast::clamp(l9_1119,0.0,1.0));
}
}
l9_1099.y=l9_1115;
if (l9_1103)
{
bool l9_1120=l9_1105;
bool l9_1121;
if (l9_1120)
{
l9_1121=l9_1102.x==3;
}
else
{
l9_1121=l9_1120;
}
float l9_1122=l9_1099.x;
float l9_1123=l9_1104.x;
float l9_1124=l9_1104.z;
bool l9_1125=l9_1121;
float l9_1126=l9_1109;
float l9_1127=fast::clamp(l9_1122,l9_1123,l9_1124);
float l9_1128=step(abs(l9_1122-l9_1127),9.9999997e-06);
l9_1126*=(l9_1128+((1.0-float(l9_1125))*(1.0-l9_1128)));
l9_1122=l9_1127;
l9_1099.x=l9_1122;
l9_1109=l9_1126;
bool l9_1129=l9_1105;
bool l9_1130;
if (l9_1129)
{
l9_1130=l9_1102.y==3;
}
else
{
l9_1130=l9_1129;
}
float l9_1131=l9_1099.y;
float l9_1132=l9_1104.y;
float l9_1133=l9_1104.w;
bool l9_1134=l9_1130;
float l9_1135=l9_1109;
float l9_1136=fast::clamp(l9_1131,l9_1132,l9_1133);
float l9_1137=step(abs(l9_1131-l9_1136),9.9999997e-06);
l9_1135*=(l9_1137+((1.0-float(l9_1134))*(1.0-l9_1137)));
l9_1131=l9_1136;
l9_1099.y=l9_1131;
l9_1109=l9_1135;
}
float2 l9_1138=l9_1099;
bool l9_1139=l9_1100;
float3x3 l9_1140=l9_1101;
if (l9_1139)
{
l9_1138=float2((l9_1140*float3(l9_1138,1.0)).xy);
}
float2 l9_1141=l9_1138;
float2 l9_1142=l9_1141;
float2 l9_1143=l9_1142;
l9_1099=l9_1143;
float l9_1144=l9_1099.x;
int l9_1145=l9_1102.x;
bool l9_1146=l9_1108;
float l9_1147=l9_1109;
if ((l9_1145==0)||(l9_1145==3))
{
float l9_1148=l9_1144;
float l9_1149=0.0;
float l9_1150=1.0;
bool l9_1151=l9_1146;
float l9_1152=l9_1147;
float l9_1153=fast::clamp(l9_1148,l9_1149,l9_1150);
float l9_1154=step(abs(l9_1148-l9_1153),9.9999997e-06);
l9_1152*=(l9_1154+((1.0-float(l9_1151))*(1.0-l9_1154)));
l9_1148=l9_1153;
l9_1144=l9_1148;
l9_1147=l9_1152;
}
l9_1099.x=l9_1144;
l9_1109=l9_1147;
float l9_1155=l9_1099.y;
int l9_1156=l9_1102.y;
bool l9_1157=l9_1108;
float l9_1158=l9_1109;
if ((l9_1156==0)||(l9_1156==3))
{
float l9_1159=l9_1155;
float l9_1160=0.0;
float l9_1161=1.0;
bool l9_1162=l9_1157;
float l9_1163=l9_1158;
float l9_1164=fast::clamp(l9_1159,l9_1160,l9_1161);
float l9_1165=step(abs(l9_1159-l9_1164),9.9999997e-06);
l9_1163*=(l9_1165+((1.0-float(l9_1162))*(1.0-l9_1165)));
l9_1159=l9_1164;
l9_1155=l9_1159;
l9_1158=l9_1163;
}
l9_1099.y=l9_1155;
l9_1109=l9_1158;
float2 l9_1166=l9_1099;
int l9_1167=l9_1097;
int l9_1168=l9_1098;
float l9_1169=l9_1107;
float2 l9_1170=l9_1166;
int l9_1171=l9_1167;
int l9_1172=l9_1168;
float3 l9_1173=float3(0.0);
if (l9_1171==0)
{
l9_1173=float3(l9_1170,0.0);
}
else
{
if (l9_1171==1)
{
l9_1173=float3(l9_1170.x,(l9_1170.y*0.5)+(0.5-(float(l9_1172)*0.5)),0.0);
}
else
{
l9_1173=float3(l9_1170,float(l9_1172));
}
}
float3 l9_1174=l9_1173;
float3 l9_1175=l9_1174;
float2 l9_1176=l9_1175.xy;
float l9_1177=l9_1169;
float4 l9_1178=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_1176,level(l9_1177));
float4 l9_1179=l9_1178;
float4 l9_1180=l9_1179;
if (l9_1105)
{
l9_1180=mix(l9_1106,l9_1180,float4(l9_1109));
}
float4 l9_1181=l9_1180;
l9_1090=l9_1181;
float4 l9_1182=l9_1090;
float3 l9_1183=l9_1182.xyz;
l9_1085=(l9_1071+l9_1074)*l9_1183;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_1085=l9_1071*l9_1084;
}
}
float3 l9_1184=l9_1085;
l9_1069=l9_1184;
float4x4 l9_1185=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_1186=length(l9_1185[0].xyz);
float4x4 l9_1187=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_1188=length(l9_1187[1].xyz);
float4x4 l9_1189=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_1190=length(l9_1189[2].xyz);
float3 l9_1191=float3(l9_1186,l9_1188,l9_1190);
float4x4 l9_1192=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_1193=l9_1192;
float4 l9_1194=l9_1193[0];
float4 l9_1195=l9_1193[1];
float4 l9_1196=l9_1193[2];
float3x3 l9_1197=float3x3(float3(float3(l9_1194.x,l9_1195.x,l9_1196.x)),float3(float3(l9_1194.y,l9_1195.y,l9_1196.y)),float3(float3(l9_1194.z,l9_1195.z,l9_1196.z)));
float3x3 l9_1198=l9_1197;
float3 l9_1199=((l9_1069+l9_1067)+l9_1068)*l9_1198;
if (N111_WORLDFORCE)
{
float4x4 l9_1200=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_1201=l9_1200;
float4 l9_1202=l9_1201[0];
float4 l9_1203=l9_1201[1];
float4 l9_1204=l9_1201[2];
float3x3 l9_1205=float3x3(float3(float3(l9_1202.x,l9_1203.x,l9_1204.x)),float3(float3(l9_1202.y,l9_1203.y,l9_1204.y)),float3(float3(l9_1202.z,l9_1203.z,l9_1204.z)));
float3x3 l9_1206=l9_1205;
l9_1199=((l9_1069*l9_1206)+l9_1067)+l9_1068;
}
if (N111_WORLDSPACE)
{
l9_1199=((l9_1069*l9_1191)+l9_1067)+l9_1068;
}
float4x4 l9_1207=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3 l9_1208=(l9_1207*float4(l9_985,1.0)).xyz+l9_1199;
float l9_1209=mix(N111_rotationRandomZ.x,N111_rotationRandomZ.y,l9_978);
float l9_1210=1.0-l9_981;
float l9_1211=N111_rotationDrag;
float l9_1212;
if (l9_1210<=0.0)
{
l9_1212=0.0;
}
else
{
l9_1212=pow(l9_1210,l9_1211);
}
float l9_1213=l9_1212;
float l9_1214=l9_1213;
float l9_1215=mix(N111_rotationRateZ.x,N111_rotationRateZ.y,l9_978);
float l9_1216=((l9_1215*l9_1214)*l9_981)*2.0;
float l9_1217=N111_PI*((l9_1216+l9_1209)-0.5);
float l9_1218=1.0;
if (N111_ENABLE_SCREENFADE)
{
float3 l9_1219=(*sc_set2.UserUniforms).sc_Camera.position;
float3 l9_1220=l9_1219-l9_1208;
float l9_1221=dot(l9_1220,l9_1220);
float l9_1222=(N111_fadeDistanceInvisible+N111_EPSILON)*(N111_fadeDistanceInvisible+N111_EPSILON);
float l9_1223=N111_fadeDistanceVisible*N111_fadeDistanceVisible;
float l9_1224=fast::min(l9_1222,l9_1223);
float l9_1225=fast::max(l9_1222,l9_1223);
N111_nearCameraFade=smoothstep(l9_1224,l9_1225,l9_1221);
float l9_1226;
if (l9_1222>l9_1223)
{
l9_1226=1.0-N111_nearCameraFade;
}
else
{
l9_1226=N111_nearCameraFade;
}
N111_nearCameraFade=l9_1226;
if (N111_nearCameraFade<=N111_EPSILON)
{
l9_1218=0.0;
}
}
if (N111_MESHTYPE_QUAD)
{
int l9_1227=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1227=0;
}
else
{
l9_1227=gl_InstanceIndex%2;
}
int l9_1228=l9_1227;
float4x4 l9_1229=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_1228];
float3 l9_1230=l9_1229[2].xyz;
int l9_1231=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1231=0;
}
else
{
l9_1231=gl_InstanceIndex%2;
}
int l9_1232=l9_1231;
float3 l9_1233=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_1232][1].xyz;
float3 l9_1234=-l9_1233;
float3 l9_1235=normalize(cross(l9_1230,l9_1234));
float l9_1236=1.0;
if (N111_ENABLE_ALIGNTOX)
{
l9_1235=float3(0.0,0.0,1.0);
l9_1234=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_1235=float3(1.0,0.0,0.0);
l9_1234=float3(0.0,0.0,1.0);
}
if (N111_ENABLE_ALIGNTOZ)
{
l9_1235=float3(1.0,0.0,0.0);
l9_1234=float3(0.0,1.0,0.0);
}
float2 l9_1237=float2(cos(l9_1217),sin(l9_1217));
float2 l9_1238=float2(-sin(l9_1217),cos(l9_1217));
float3 l9_1239=float3((l9_1235*l9_1237.x)+(l9_1234*l9_1237.y));
float3 l9_1240=float3((l9_1235*l9_1238.x)+(l9_1234*l9_1238.y));
if (N111_ENABLE_ALIGNTOVEL)
{
float3 l9_1241=normalize(((l9_1199+l9_1067)+l9_1068)+float3(N111_EPSILON));
float3 l9_1242=l9_1199*(l9_980-0.0099999998);
float3 l9_1243=l9_1199*(l9_980+0.0099999998);
if (N111_ENABLE_IGNOREVEL)
{
l9_1236=fast::max(N111_sizeVelScale,N111_EPSILON);
}
else
{
l9_1236=length(l9_1243-l9_1242)*N111_sizeVelScale;
if (N111_ENABLE_IGNORETRANSFORMSCALE)
{
float4x4 l9_1244=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_1236=(length(l9_1243-l9_1242)/length(l9_1244[0].xyz))*N111_sizeVelScale;
}
}
l9_1239=l9_1241;
l9_1240=normalize(cross(l9_1239,l9_1230));
}
float4x4 l9_1245=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_1246=length(l9_1245[0].xyz);
float2 l9_1247=tempGlobals.Surface_UVCoord0;
float2 l9_1248=l9_1247;
float l9_1249=N111_dieTrigger;
float l9_1250=l9_1218;
float2 l9_1251=l9_1248;
float l9_1252=l9_971;
float l9_1253=l9_972;
float l9_1254=l9_981;
float l9_1255=N111_sizeSpeed;
float2 l9_1256=N111_sizeStart.xy;
float2 l9_1257=N111_sizeEnd.xy;
float l9_1258=l9_1254;
float l9_1259=l9_1255;
float l9_1260;
if (l9_1258<=0.0)
{
l9_1260=0.0;
}
else
{
l9_1260=pow(l9_1258,l9_1259);
}
float l9_1261=l9_1260;
float l9_1262=l9_1261;
if (N111_ENABLE_SIZEMINMAX)
{
l9_1256=mix(N111_sizeStartMin.xy,N111_sizeStartMax.xy,float2(l9_1252));
l9_1257=mix(N111_sizeEndMin.xy,N111_sizeEndMax.xy,float2(l9_1253));
}
float2 l9_1263=mix(l9_1256,l9_1257,float2(l9_1262));
if (N111_ENABLE_SIZERAMP)
{
float l9_1264=ceil(l9_1254*10000.0)/10000.0;
float2 l9_1265=tempGlobals.Surface_UVCoord0;
float2 l9_1266=(l9_1265/float2(10000.0,1.0))+float2(l9_1264,0.0);
float2 l9_1267=l9_1266;
float4 l9_1268=float4(0.0);
int l9_1269=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_1270=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1270=0;
}
else
{
l9_1270=gl_InstanceIndex%2;
}
int l9_1271=l9_1270;
l9_1269=1-l9_1271;
}
else
{
int l9_1272=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1272=0;
}
else
{
l9_1272=gl_InstanceIndex%2;
}
int l9_1273=l9_1272;
l9_1269=l9_1273;
}
int l9_1274=l9_1269;
int l9_1275=sizeRampTextureLayout_tmp;
int l9_1276=l9_1274;
float2 l9_1277=l9_1267;
bool l9_1278=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_1279=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_1280=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_1281=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_1282=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_1283=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_1284=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_1285=0.0;
bool l9_1286=l9_1283&&(!l9_1281);
float l9_1287=1.0;
float l9_1288=l9_1277.x;
int l9_1289=l9_1280.x;
if (l9_1289==1)
{
l9_1288=fract(l9_1288);
}
else
{
if (l9_1289==2)
{
float l9_1290=fract(l9_1288);
float l9_1291=l9_1288-l9_1290;
float l9_1292=step(0.25,fract(l9_1291*0.5));
l9_1288=mix(l9_1290,1.0-l9_1290,fast::clamp(l9_1292,0.0,1.0));
}
}
l9_1277.x=l9_1288;
float l9_1293=l9_1277.y;
int l9_1294=l9_1280.y;
if (l9_1294==1)
{
l9_1293=fract(l9_1293);
}
else
{
if (l9_1294==2)
{
float l9_1295=fract(l9_1293);
float l9_1296=l9_1293-l9_1295;
float l9_1297=step(0.25,fract(l9_1296*0.5));
l9_1293=mix(l9_1295,1.0-l9_1295,fast::clamp(l9_1297,0.0,1.0));
}
}
l9_1277.y=l9_1293;
if (l9_1281)
{
bool l9_1298=l9_1283;
bool l9_1299;
if (l9_1298)
{
l9_1299=l9_1280.x==3;
}
else
{
l9_1299=l9_1298;
}
float l9_1300=l9_1277.x;
float l9_1301=l9_1282.x;
float l9_1302=l9_1282.z;
bool l9_1303=l9_1299;
float l9_1304=l9_1287;
float l9_1305=fast::clamp(l9_1300,l9_1301,l9_1302);
float l9_1306=step(abs(l9_1300-l9_1305),9.9999997e-06);
l9_1304*=(l9_1306+((1.0-float(l9_1303))*(1.0-l9_1306)));
l9_1300=l9_1305;
l9_1277.x=l9_1300;
l9_1287=l9_1304;
bool l9_1307=l9_1283;
bool l9_1308;
if (l9_1307)
{
l9_1308=l9_1280.y==3;
}
else
{
l9_1308=l9_1307;
}
float l9_1309=l9_1277.y;
float l9_1310=l9_1282.y;
float l9_1311=l9_1282.w;
bool l9_1312=l9_1308;
float l9_1313=l9_1287;
float l9_1314=fast::clamp(l9_1309,l9_1310,l9_1311);
float l9_1315=step(abs(l9_1309-l9_1314),9.9999997e-06);
l9_1313*=(l9_1315+((1.0-float(l9_1312))*(1.0-l9_1315)));
l9_1309=l9_1314;
l9_1277.y=l9_1309;
l9_1287=l9_1313;
}
float2 l9_1316=l9_1277;
bool l9_1317=l9_1278;
float3x3 l9_1318=l9_1279;
if (l9_1317)
{
l9_1316=float2((l9_1318*float3(l9_1316,1.0)).xy);
}
float2 l9_1319=l9_1316;
float2 l9_1320=l9_1319;
float2 l9_1321=l9_1320;
l9_1277=l9_1321;
float l9_1322=l9_1277.x;
int l9_1323=l9_1280.x;
bool l9_1324=l9_1286;
float l9_1325=l9_1287;
if ((l9_1323==0)||(l9_1323==3))
{
float l9_1326=l9_1322;
float l9_1327=0.0;
float l9_1328=1.0;
bool l9_1329=l9_1324;
float l9_1330=l9_1325;
float l9_1331=fast::clamp(l9_1326,l9_1327,l9_1328);
float l9_1332=step(abs(l9_1326-l9_1331),9.9999997e-06);
l9_1330*=(l9_1332+((1.0-float(l9_1329))*(1.0-l9_1332)));
l9_1326=l9_1331;
l9_1322=l9_1326;
l9_1325=l9_1330;
}
l9_1277.x=l9_1322;
l9_1287=l9_1325;
float l9_1333=l9_1277.y;
int l9_1334=l9_1280.y;
bool l9_1335=l9_1286;
float l9_1336=l9_1287;
if ((l9_1334==0)||(l9_1334==3))
{
float l9_1337=l9_1333;
float l9_1338=0.0;
float l9_1339=1.0;
bool l9_1340=l9_1335;
float l9_1341=l9_1336;
float l9_1342=fast::clamp(l9_1337,l9_1338,l9_1339);
float l9_1343=step(abs(l9_1337-l9_1342),9.9999997e-06);
l9_1341*=(l9_1343+((1.0-float(l9_1340))*(1.0-l9_1343)));
l9_1337=l9_1342;
l9_1333=l9_1337;
l9_1336=l9_1341;
}
l9_1277.y=l9_1333;
l9_1287=l9_1336;
float2 l9_1344=l9_1277;
int l9_1345=l9_1275;
int l9_1346=l9_1276;
float l9_1347=l9_1285;
float2 l9_1348=l9_1344;
int l9_1349=l9_1345;
int l9_1350=l9_1346;
float3 l9_1351=float3(0.0);
if (l9_1349==0)
{
l9_1351=float3(l9_1348,0.0);
}
else
{
if (l9_1349==1)
{
l9_1351=float3(l9_1348.x,(l9_1348.y*0.5)+(0.5-(float(l9_1350)*0.5)),0.0);
}
else
{
l9_1351=float3(l9_1348,float(l9_1350));
}
}
float3 l9_1352=l9_1351;
float3 l9_1353=l9_1352;
float2 l9_1354=l9_1353.xy;
float l9_1355=l9_1347;
float4 l9_1356=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_1354,level(l9_1355));
float4 l9_1357=l9_1356;
float4 l9_1358=l9_1357;
if (l9_1283)
{
l9_1358=mix(l9_1284,l9_1358,float4(l9_1287));
}
float4 l9_1359=l9_1358;
l9_1268=l9_1359;
float4 l9_1360=l9_1268;
float2 l9_1361=l9_1360.xy;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_1361=float2(1.0);
}
l9_1263=l9_1361*l9_1256;
}
float2 l9_1362=l9_1263;
float2 l9_1363=(((l9_1251-float2(0.5))*(l9_1249*l9_1250))*l9_1362)*l9_1246;
float3 l9_1364=(l9_1208+(l9_1240*l9_1363.x))+(l9_1239*(l9_1363.y*l9_1236));
N111_position=l9_1364;
N111_normal=l9_1230;
}
else
{
N111_position=N111_positionObjectSpace;
if (N111_ENABLE_CENTER_IN_BBOX)
{
float3 l9_1365=(*sc_set2.UserUniforms).sc_LocalAabbMax;
float3 l9_1366=(*sc_set2.UserUniforms).sc_LocalAabbMin;
float3 l9_1367=(l9_1365+l9_1366)/float3(2.0);
N111_position-=l9_1367;
}
float3 l9_1368=N111_position;
float3 l9_1369=l9_1191;
float l9_1370=l9_971;
float l9_1371=l9_972;
float l9_1372=l9_981;
float l9_1373=N111_sizeSpeed;
float3 l9_1374=N111_sizeStart;
float3 l9_1375=N111_sizeEnd;
float l9_1376=l9_1372;
float l9_1377=l9_1373;
float l9_1378;
if (l9_1376<=0.0)
{
l9_1378=0.0;
}
else
{
l9_1378=pow(l9_1376,l9_1377);
}
float l9_1379=l9_1378;
float l9_1380=l9_1379;
if (N111_ENABLE_SIZEMINMAX)
{
l9_1374=mix(N111_sizeStartMin,N111_sizeStartMax,float3(l9_1370));
l9_1375=mix(N111_sizeEndMin,N111_sizeEndMax,float3(l9_1371));
}
float3 l9_1381=mix(l9_1374,l9_1375,float3(l9_1380));
if (N111_ENABLE_SIZERAMP)
{
float l9_1382=ceil(l9_1372*10000.0)/10000.0;
float2 l9_1383=tempGlobals.Surface_UVCoord0;
float2 l9_1384=(l9_1383/float2(10000.0,1.0))+float2(l9_1382,0.0);
float2 l9_1385=l9_1384;
float4 l9_1386=float4(0.0);
int l9_1387=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_1388=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1388=0;
}
else
{
l9_1388=gl_InstanceIndex%2;
}
int l9_1389=l9_1388;
l9_1387=1-l9_1389;
}
else
{
int l9_1390=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1390=0;
}
else
{
l9_1390=gl_InstanceIndex%2;
}
int l9_1391=l9_1390;
l9_1387=l9_1391;
}
int l9_1392=l9_1387;
int l9_1393=sizeRampTextureLayout_tmp;
int l9_1394=l9_1392;
float2 l9_1395=l9_1385;
bool l9_1396=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_1397=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_1398=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_1399=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_1400=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_1401=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_1402=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_1403=0.0;
bool l9_1404=l9_1401&&(!l9_1399);
float l9_1405=1.0;
float l9_1406=l9_1395.x;
int l9_1407=l9_1398.x;
if (l9_1407==1)
{
l9_1406=fract(l9_1406);
}
else
{
if (l9_1407==2)
{
float l9_1408=fract(l9_1406);
float l9_1409=l9_1406-l9_1408;
float l9_1410=step(0.25,fract(l9_1409*0.5));
l9_1406=mix(l9_1408,1.0-l9_1408,fast::clamp(l9_1410,0.0,1.0));
}
}
l9_1395.x=l9_1406;
float l9_1411=l9_1395.y;
int l9_1412=l9_1398.y;
if (l9_1412==1)
{
l9_1411=fract(l9_1411);
}
else
{
if (l9_1412==2)
{
float l9_1413=fract(l9_1411);
float l9_1414=l9_1411-l9_1413;
float l9_1415=step(0.25,fract(l9_1414*0.5));
l9_1411=mix(l9_1413,1.0-l9_1413,fast::clamp(l9_1415,0.0,1.0));
}
}
l9_1395.y=l9_1411;
if (l9_1399)
{
bool l9_1416=l9_1401;
bool l9_1417;
if (l9_1416)
{
l9_1417=l9_1398.x==3;
}
else
{
l9_1417=l9_1416;
}
float l9_1418=l9_1395.x;
float l9_1419=l9_1400.x;
float l9_1420=l9_1400.z;
bool l9_1421=l9_1417;
float l9_1422=l9_1405;
float l9_1423=fast::clamp(l9_1418,l9_1419,l9_1420);
float l9_1424=step(abs(l9_1418-l9_1423),9.9999997e-06);
l9_1422*=(l9_1424+((1.0-float(l9_1421))*(1.0-l9_1424)));
l9_1418=l9_1423;
l9_1395.x=l9_1418;
l9_1405=l9_1422;
bool l9_1425=l9_1401;
bool l9_1426;
if (l9_1425)
{
l9_1426=l9_1398.y==3;
}
else
{
l9_1426=l9_1425;
}
float l9_1427=l9_1395.y;
float l9_1428=l9_1400.y;
float l9_1429=l9_1400.w;
bool l9_1430=l9_1426;
float l9_1431=l9_1405;
float l9_1432=fast::clamp(l9_1427,l9_1428,l9_1429);
float l9_1433=step(abs(l9_1427-l9_1432),9.9999997e-06);
l9_1431*=(l9_1433+((1.0-float(l9_1430))*(1.0-l9_1433)));
l9_1427=l9_1432;
l9_1395.y=l9_1427;
l9_1405=l9_1431;
}
float2 l9_1434=l9_1395;
bool l9_1435=l9_1396;
float3x3 l9_1436=l9_1397;
if (l9_1435)
{
l9_1434=float2((l9_1436*float3(l9_1434,1.0)).xy);
}
float2 l9_1437=l9_1434;
float2 l9_1438=l9_1437;
float2 l9_1439=l9_1438;
l9_1395=l9_1439;
float l9_1440=l9_1395.x;
int l9_1441=l9_1398.x;
bool l9_1442=l9_1404;
float l9_1443=l9_1405;
if ((l9_1441==0)||(l9_1441==3))
{
float l9_1444=l9_1440;
float l9_1445=0.0;
float l9_1446=1.0;
bool l9_1447=l9_1442;
float l9_1448=l9_1443;
float l9_1449=fast::clamp(l9_1444,l9_1445,l9_1446);
float l9_1450=step(abs(l9_1444-l9_1449),9.9999997e-06);
l9_1448*=(l9_1450+((1.0-float(l9_1447))*(1.0-l9_1450)));
l9_1444=l9_1449;
l9_1440=l9_1444;
l9_1443=l9_1448;
}
l9_1395.x=l9_1440;
l9_1405=l9_1443;
float l9_1451=l9_1395.y;
int l9_1452=l9_1398.y;
bool l9_1453=l9_1404;
float l9_1454=l9_1405;
if ((l9_1452==0)||(l9_1452==3))
{
float l9_1455=l9_1451;
float l9_1456=0.0;
float l9_1457=1.0;
bool l9_1458=l9_1453;
float l9_1459=l9_1454;
float l9_1460=fast::clamp(l9_1455,l9_1456,l9_1457);
float l9_1461=step(abs(l9_1455-l9_1460),9.9999997e-06);
l9_1459*=(l9_1461+((1.0-float(l9_1458))*(1.0-l9_1461)));
l9_1455=l9_1460;
l9_1451=l9_1455;
l9_1454=l9_1459;
}
l9_1395.y=l9_1451;
l9_1405=l9_1454;
float2 l9_1462=l9_1395;
int l9_1463=l9_1393;
int l9_1464=l9_1394;
float l9_1465=l9_1403;
float2 l9_1466=l9_1462;
int l9_1467=l9_1463;
int l9_1468=l9_1464;
float3 l9_1469=float3(0.0);
if (l9_1467==0)
{
l9_1469=float3(l9_1466,0.0);
}
else
{
if (l9_1467==1)
{
l9_1469=float3(l9_1466.x,(l9_1466.y*0.5)+(0.5-(float(l9_1468)*0.5)),0.0);
}
else
{
l9_1469=float3(l9_1466,float(l9_1468));
}
}
float3 l9_1470=l9_1469;
float3 l9_1471=l9_1470;
float2 l9_1472=l9_1471.xy;
float l9_1473=l9_1465;
float4 l9_1474=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_1472,level(l9_1473));
float4 l9_1475=l9_1474;
float4 l9_1476=l9_1475;
if (l9_1401)
{
l9_1476=mix(l9_1402,l9_1476,float4(l9_1405));
}
float4 l9_1477=l9_1476;
l9_1386=l9_1477;
float4 l9_1478=l9_1386;
float3 l9_1479=l9_1478.xyz;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_1479=float3(1.0);
}
l9_1381=l9_1479*l9_1374;
}
float3 l9_1480=l9_1381;
N111_position=(l9_1368*l9_1369)*l9_1480;
if ((N111_dieTrigger<0.5)||(l9_1218<0.5))
{
N111_position.x=2.1474836e+09;
}
float3x3 l9_1481;
if (((N111_ENABLE_ALIGNTOVEL||N111_ENABLE_ALIGNTOX)||N111_ENABLE_ALIGNTOY)||N111_ENABLE_ALIGNTOZ)
{
if (N111_ENABLE_ALIGNTOZ)
{
l9_1481=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
}
else
{
float3 l9_1482=float3(0.0);
if (N111_ENABLE_ALIGNTOX)
{
l9_1482=float3(1.0,0.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_1482=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOVEL)
{
float l9_1483=0.001;
float3 l9_1484=l9_1070;
float l9_1485=l9_980-l9_1483;
float3 l9_1486=N111_velocityDrag;
float3 l9_1487=l9_986;
float l9_1488=l9_981-l9_1483;
float3 l9_1489=float3(l9_1485,l9_1485,l9_1485);
float3 l9_1490=l9_1486;
float l9_1491;
if (l9_1489.x<=0.0)
{
l9_1491=0.0;
}
else
{
l9_1491=pow(l9_1489.x,l9_1490.x);
}
float l9_1492=l9_1491;
float l9_1493;
if (l9_1489.y<=0.0)
{
l9_1493=0.0;
}
else
{
l9_1493=pow(l9_1489.y,l9_1490.y);
}
float l9_1494=l9_1493;
float l9_1495;
if (l9_1489.z<=0.0)
{
l9_1495=0.0;
}
else
{
l9_1495=pow(l9_1489.z,l9_1490.z);
}
float3 l9_1496=float3(l9_1492,l9_1494,l9_1495);
float3 l9_1497=l9_1496;
float3 l9_1498=(l9_1484+l9_1487)*l9_1497;
if (N111_ENABLE_VELRAMP)
{
float l9_1499=floor(l9_1488*10000.0)/10000.0;
float2 l9_1500=tempGlobals.Surface_UVCoord0;
float2 l9_1501=(l9_1500/float2(10000.0,1.0))+float2(l9_1499,0.0);
float2 l9_1502=l9_1501;
float4 l9_1503=float4(0.0);
int l9_1504=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_1505=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1505=0;
}
else
{
l9_1505=gl_InstanceIndex%2;
}
int l9_1506=l9_1505;
l9_1504=1-l9_1506;
}
else
{
int l9_1507=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1507=0;
}
else
{
l9_1507=gl_InstanceIndex%2;
}
int l9_1508=l9_1507;
l9_1504=l9_1508;
}
int l9_1509=l9_1504;
int l9_1510=velRampTextureLayout_tmp;
int l9_1511=l9_1509;
float2 l9_1512=l9_1502;
bool l9_1513=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_1514=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_1515=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_1516=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_1517=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_1518=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_1519=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_1520=0.0;
bool l9_1521=l9_1518&&(!l9_1516);
float l9_1522=1.0;
float l9_1523=l9_1512.x;
int l9_1524=l9_1515.x;
if (l9_1524==1)
{
l9_1523=fract(l9_1523);
}
else
{
if (l9_1524==2)
{
float l9_1525=fract(l9_1523);
float l9_1526=l9_1523-l9_1525;
float l9_1527=step(0.25,fract(l9_1526*0.5));
l9_1523=mix(l9_1525,1.0-l9_1525,fast::clamp(l9_1527,0.0,1.0));
}
}
l9_1512.x=l9_1523;
float l9_1528=l9_1512.y;
int l9_1529=l9_1515.y;
if (l9_1529==1)
{
l9_1528=fract(l9_1528);
}
else
{
if (l9_1529==2)
{
float l9_1530=fract(l9_1528);
float l9_1531=l9_1528-l9_1530;
float l9_1532=step(0.25,fract(l9_1531*0.5));
l9_1528=mix(l9_1530,1.0-l9_1530,fast::clamp(l9_1532,0.0,1.0));
}
}
l9_1512.y=l9_1528;
if (l9_1516)
{
bool l9_1533=l9_1518;
bool l9_1534;
if (l9_1533)
{
l9_1534=l9_1515.x==3;
}
else
{
l9_1534=l9_1533;
}
float l9_1535=l9_1512.x;
float l9_1536=l9_1517.x;
float l9_1537=l9_1517.z;
bool l9_1538=l9_1534;
float l9_1539=l9_1522;
float l9_1540=fast::clamp(l9_1535,l9_1536,l9_1537);
float l9_1541=step(abs(l9_1535-l9_1540),9.9999997e-06);
l9_1539*=(l9_1541+((1.0-float(l9_1538))*(1.0-l9_1541)));
l9_1535=l9_1540;
l9_1512.x=l9_1535;
l9_1522=l9_1539;
bool l9_1542=l9_1518;
bool l9_1543;
if (l9_1542)
{
l9_1543=l9_1515.y==3;
}
else
{
l9_1543=l9_1542;
}
float l9_1544=l9_1512.y;
float l9_1545=l9_1517.y;
float l9_1546=l9_1517.w;
bool l9_1547=l9_1543;
float l9_1548=l9_1522;
float l9_1549=fast::clamp(l9_1544,l9_1545,l9_1546);
float l9_1550=step(abs(l9_1544-l9_1549),9.9999997e-06);
l9_1548*=(l9_1550+((1.0-float(l9_1547))*(1.0-l9_1550)));
l9_1544=l9_1549;
l9_1512.y=l9_1544;
l9_1522=l9_1548;
}
float2 l9_1551=l9_1512;
bool l9_1552=l9_1513;
float3x3 l9_1553=l9_1514;
if (l9_1552)
{
l9_1551=float2((l9_1553*float3(l9_1551,1.0)).xy);
}
float2 l9_1554=l9_1551;
float2 l9_1555=l9_1554;
float2 l9_1556=l9_1555;
l9_1512=l9_1556;
float l9_1557=l9_1512.x;
int l9_1558=l9_1515.x;
bool l9_1559=l9_1521;
float l9_1560=l9_1522;
if ((l9_1558==0)||(l9_1558==3))
{
float l9_1561=l9_1557;
float l9_1562=0.0;
float l9_1563=1.0;
bool l9_1564=l9_1559;
float l9_1565=l9_1560;
float l9_1566=fast::clamp(l9_1561,l9_1562,l9_1563);
float l9_1567=step(abs(l9_1561-l9_1566),9.9999997e-06);
l9_1565*=(l9_1567+((1.0-float(l9_1564))*(1.0-l9_1567)));
l9_1561=l9_1566;
l9_1557=l9_1561;
l9_1560=l9_1565;
}
l9_1512.x=l9_1557;
l9_1522=l9_1560;
float l9_1568=l9_1512.y;
int l9_1569=l9_1515.y;
bool l9_1570=l9_1521;
float l9_1571=l9_1522;
if ((l9_1569==0)||(l9_1569==3))
{
float l9_1572=l9_1568;
float l9_1573=0.0;
float l9_1574=1.0;
bool l9_1575=l9_1570;
float l9_1576=l9_1571;
float l9_1577=fast::clamp(l9_1572,l9_1573,l9_1574);
float l9_1578=step(abs(l9_1572-l9_1577),9.9999997e-06);
l9_1576*=(l9_1578+((1.0-float(l9_1575))*(1.0-l9_1578)));
l9_1572=l9_1577;
l9_1568=l9_1572;
l9_1571=l9_1576;
}
l9_1512.y=l9_1568;
l9_1522=l9_1571;
float2 l9_1579=l9_1512;
int l9_1580=l9_1510;
int l9_1581=l9_1511;
float l9_1582=l9_1520;
float2 l9_1583=l9_1579;
int l9_1584=l9_1580;
int l9_1585=l9_1581;
float3 l9_1586=float3(0.0);
if (l9_1584==0)
{
l9_1586=float3(l9_1583,0.0);
}
else
{
if (l9_1584==1)
{
l9_1586=float3(l9_1583.x,(l9_1583.y*0.5)+(0.5-(float(l9_1585)*0.5)),0.0);
}
else
{
l9_1586=float3(l9_1583,float(l9_1585));
}
}
float3 l9_1587=l9_1586;
float3 l9_1588=l9_1587;
float2 l9_1589=l9_1588.xy;
float l9_1590=l9_1582;
float4 l9_1591=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_1589,level(l9_1590));
float4 l9_1592=l9_1591;
float4 l9_1593=l9_1592;
if (l9_1518)
{
l9_1593=mix(l9_1519,l9_1593,float4(l9_1522));
}
float4 l9_1594=l9_1593;
l9_1503=l9_1594;
float4 l9_1595=l9_1503;
float3 l9_1596=l9_1595.xyz;
l9_1498=(l9_1484+l9_1487)*l9_1596;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_1498=l9_1484*l9_1497;
}
}
float3 l9_1597=l9_1498;
float3 l9_1598=l9_1597;
float l9_1599=((N111_gravity/2.0)*(l9_980-l9_1483))*(l9_980-l9_1483);
l9_1067.y-=l9_1599;
if (N111_ENABLE_FORCE)
{
float3 l9_1600=float3(((N111_localForce/float3(2.0))*(l9_980-l9_1483))*(l9_980-l9_1483));
l9_1068-=l9_1600;
}
if (N111_WORLDFORCE)
{
float4x4 l9_1601=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_1602=l9_1601;
float4 l9_1603=l9_1602[0];
float4 l9_1604=l9_1602[1];
float4 l9_1605=l9_1602[2];
float3x3 l9_1606=float3x3(float3(float3(l9_1603.x,l9_1604.x,l9_1605.x)),float3(float3(l9_1603.y,l9_1604.y,l9_1605.y)),float3(float3(l9_1603.z,l9_1604.z,l9_1605.z)));
float3x3 l9_1607=l9_1606;
l9_1482=(((l9_1069-l9_1598)*l9_1607)+l9_1067)+l9_1068;
}
else
{
if (N111_WORLDSPACE)
{
l9_1482=((l9_1069-l9_1598)+l9_1067)+l9_1068;
}
else
{
float4x4 l9_1608=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_1609=l9_1608;
float4 l9_1610=l9_1609[0];
float4 l9_1611=l9_1609[1];
float4 l9_1612=l9_1609[2];
float3x3 l9_1613=float3x3(float3(float3(l9_1610.x,l9_1611.x,l9_1612.x)),float3(float3(l9_1610.y,l9_1611.y,l9_1612.y)),float3(float3(l9_1610.z,l9_1611.z,l9_1612.z)));
float3x3 l9_1614=l9_1613;
l9_1482=(((l9_1069-l9_1598)+l9_1068)+l9_1067)*l9_1614;
}
}
l9_1482=normalize(l9_1482+float3(N111_EPSILON));
}
float3 l9_1615=float3(0.0,0.0,1.0);
float3 l9_1616=cross(l9_1482,l9_1615);
float3 l9_1617=normalize(l9_1616);
float l9_1618=length(l9_1616);
float l9_1619=dot(l9_1615,l9_1482);
float l9_1620=1.0-l9_1619;
l9_1481=float3x3(float3(((l9_1620*l9_1617.x)*l9_1617.x)+l9_1619,((l9_1620*l9_1617.x)*l9_1617.y)-(l9_1617.z*l9_1618),((l9_1620*l9_1617.z)*l9_1617.x)+(l9_1617.y*l9_1618)),float3(((l9_1620*l9_1617.x)*l9_1617.y)+(l9_1617.z*l9_1618),((l9_1620*l9_1617.y)*l9_1617.y)+l9_1619,((l9_1620*l9_1617.y)*l9_1617.z)-(l9_1617.x*l9_1618)),float3(((l9_1620*l9_1617.z)*l9_1617.x)-(l9_1617.y*l9_1618),((l9_1620*l9_1617.y)*l9_1617.z)+(l9_1617.x*l9_1618),((l9_1620*l9_1617.z)*l9_1617.z)+l9_1619));
}
float3x3 l9_1621=float3x3(float3(cos(l9_1217),-sin(l9_1217),0.0),float3(sin(l9_1217),cos(l9_1217),0.0),float3(0.0,0.0,1.0));
l9_1481=l9_1481*l9_1621;
if (N111_ENABLE_ALIGNTOVEL&&(!N111_ENABLE_IGNOREVEL))
{
float3 l9_1622=l9_1199*(l9_980-0.0099999998);
float3 l9_1623=l9_1199*(l9_980+0.0099999998);
N111_position.z*=(length(l9_1623-l9_1622)*fast::max(N111_sizeVelScale,0.1));
}
}
else
{
float l9_1624=fract((N111_particleSeed.x*92.653008)+N111_globalSeed);
float l9_1625=mix(N111_rotationRandomX.x,N111_rotationRandomX.y,l9_1624);
float l9_1626=mix(N111_rotationRateX.x,N111_rotationRateX.y,l9_1624);
float l9_1627=((l9_1626*l9_1214)*l9_981)*2.0;
float l9_1628=fract((N111_particleSeed.y*6.7557559)+N111_globalSeed);
float l9_1629=mix(N111_rotationRandomY.x,N111_rotationRandomY.y,l9_1628);
float l9_1630=mix(N111_rotationRateY.x,N111_rotationRateY.y,l9_1628);
float l9_1631=((l9_1630*l9_1214)*l9_981)*2.0;
float l9_1632=N111_PI*(l9_1627+l9_1625);
float l9_1633=N111_PI*(l9_1631+l9_1629);
float l9_1634=N111_PI*(l9_1216+l9_1209);
float3 l9_1635=float3(l9_1632,l9_1633,l9_1634);
float l9_1636=cos(l9_1635.x);
float l9_1637=sin(l9_1635.x);
float l9_1638=cos(l9_1635.y);
float l9_1639=sin(l9_1635.y);
float l9_1640=cos(l9_1635.z);
float l9_1641=sin(l9_1635.z);
l9_1481=float3x3(float3(l9_1638*l9_1640,(l9_1636*l9_1641)+((l9_1637*l9_1639)*l9_1640),(l9_1637*l9_1641)-((l9_1636*l9_1639)*l9_1640)),float3((-l9_1638)*l9_1641,(l9_1636*l9_1640)-((l9_1637*l9_1639)*l9_1641),(l9_1637*l9_1640)+((l9_1636*l9_1639)*l9_1641)),float3(l9_1639,(-l9_1637)*l9_1638,l9_1636*l9_1638));
}
if ((!N111_WORLDSPACE)&&(!N111_ENABLE_ALIGNTOVEL))
{
float4x4 l9_1642=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_1643=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_1644=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3x3 l9_1645=float3x3(float3(l9_1642[0].xyz/float3(l9_1191.x)),float3(l9_1643[1].xyz/float3(l9_1191.y)),float3(l9_1644[2].xyz/float3(l9_1191.z)));
l9_1481=l9_1645*l9_1481;
}
N111_position=l9_1481*N111_position;
N111_normal=normalize(l9_1481*N111_normalObjectSpace);
N111_position+=l9_1208;
}
N111_timeValues=float4(l9_979,l9_980,l9_981);
param_233=N111_normal;
normal_N111=param_233;
WorldNormal=normal_N111;
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
WorldPosition=out.varPos;
WorldNormal=out.varNormal;
WorldTangent=out.varTangent.xyz;
}
sc_Vertex_t param_235=v;
float3 param_236=WorldPosition;
float3 param_237=WorldNormal;
float3 param_238=WorldTangent;
float4 param_239=v.position;
out.varPos=param_236;
out.varNormal=normalize(param_237);
float3 l9_1646=normalize(param_238);
out.varTangent=float4(l9_1646.x,l9_1646.y,l9_1646.z,out.varTangent.w);
out.varTangent.w=in.tangent.w;
if ((int(UseViewSpaceDepthVariant_tmp)!=0)&&(((int(sc_OITDepthGatherPass_tmp)!=0)||(int(sc_OITCompositingPass_tmp)!=0))||(int(sc_OITDepthBoundsPass_tmp)!=0)))
{
float4 l9_1647=param_235.position;
float4 l9_1648=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
int l9_1649=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1649=0;
}
else
{
l9_1649=gl_InstanceIndex%2;
}
int l9_1650=l9_1649;
l9_1648=(*sc_set2.UserUniforms).sc_ProjectionMatrixInverseArray[l9_1650]*l9_1647;
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_1651=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1651=0;
}
else
{
l9_1651=gl_InstanceIndex%2;
}
int l9_1652=l9_1651;
l9_1648=(*sc_set2.UserUniforms).sc_ViewMatrixArray[l9_1652]*l9_1647;
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_1653=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1653=0;
}
else
{
l9_1653=gl_InstanceIndex%2;
}
int l9_1654=l9_1653;
l9_1648=(*sc_set2.UserUniforms).sc_ModelViewMatrixArray[l9_1654]*l9_1647;
}
else
{
l9_1648=l9_1647;
}
}
}
float4 l9_1655=l9_1648;
out.varViewSpaceDepth=-l9_1655.z;
}
float4 l9_1656=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
l9_1656=param_239;
}
else
{
if (sc_RenderingSpace_tmp==4)
{
int l9_1657=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1657=0;
}
else
{
l9_1657=gl_InstanceIndex%2;
}
int l9_1658=l9_1657;
l9_1656=((*sc_set2.UserUniforms).sc_ModelViewMatrixArray[l9_1658]*param_235.position)*float4(1.0/(*sc_set2.UserUniforms).sc_Camera.aspect,1.0,1.0,1.0);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_1659=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1659=0;
}
else
{
l9_1659=gl_InstanceIndex%2;
}
int l9_1660=l9_1659;
l9_1656=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_1660]*float4(out.varPos,1.0);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_1661=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1661=0;
}
else
{
l9_1661=gl_InstanceIndex%2;
}
int l9_1662=l9_1661;
l9_1656=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_1662]*float4(out.varPos,1.0);
}
}
}
}
out.varPackedTex=float4(param_235.texture0,param_235.texture1);
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float4 l9_1663=param_235.position;
float4 l9_1664=l9_1663;
if (sc_RenderingSpace_tmp==1)
{
l9_1664=(*sc_set2.UserUniforms).sc_ModelMatrix*l9_1663;
}
float4 l9_1665=(*sc_set2.UserUniforms).sc_ProjectorMatrix*l9_1664;
float2 l9_1666=((l9_1665.xy/float2(l9_1665.w))*0.5)+float2(0.5);
out.varShadowTex=l9_1666;
}
float4 l9_1667=l9_1656;
if (sc_DepthBufferMode_tmp==1)
{
float l9_1668=2.0/log2((*sc_set2.UserUniforms).sc_Camera.clipPlanes.y+1.0);
l9_1667.z=((log2(fast::max((*sc_set2.UserUniforms).sc_Camera.clipPlanes.x,1.0+l9_1667.w))*l9_1668)-1.0)*l9_1667.w;
}
float4 l9_1669=l9_1667;
l9_1656=l9_1669;
float4 l9_1670=l9_1656;
float4 l9_1671=l9_1670;
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1672=l9_1671;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1673=dot(l9_1672,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1674=l9_1673;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1674;
}
}
float4 l9_1675=float4(l9_1671.x,-l9_1671.y,(l9_1671.z*0.5)+(l9_1671.w*0.5),l9_1671.w);
out.gl_Position=l9_1675;
v=param_235;
out.Interpolator_gInstanceID=Globals.gInstanceID;
ssGlobals param_240=Globals;
float l9_1677=0.0;
float l9_1678=0.0;
float l9_1679=(*sc_set2.UserUniforms).timeGlobal;
l9_1678=l9_1679;
float l9_1680=0.0;
float l9_1681=(*sc_set2.UserUniforms).externalTimeInput;
l9_1680=l9_1681;
float l9_1682=0.0;
float l9_1683=(*sc_set2.UserUniforms).externalSeed;
l9_1682=l9_1683;
float l9_1684=0.0;
float l9_1685=(*sc_set2.UserUniforms).lifeTimeConstant;
l9_1684=l9_1685;
float2 l9_1686=float2(0.0);
float2 l9_1687=(*sc_set2.UserUniforms).lifeTimeMinMax;
l9_1686=l9_1687;
float l9_1688=0.0;
float l9_1689=(*sc_set2.UserUniforms).spawnDuration;
l9_1688=l9_1689;
float3 l9_1690=float3(0.0);
float l9_1691=0.0;
float l9_1692=0.0;
float4 l9_1693=float4(0.0);
float l9_1694=l9_1678;
float l9_1695=l9_1680;
float l9_1696=l9_1682;
float l9_1697=l9_1684;
float2 l9_1698=l9_1686;
float l9_1699=l9_1688;
ssGlobals l9_1700=param_240;
tempGlobals=l9_1700;
float3 l9_1701=float3(0.0);
float l9_1702=0.0;
float l9_1703=0.0;
float4 l9_1704=float4(0.0);
N173_timeGlobal=l9_1694;
N173_ENABLE_EXTERNALTIME=(int(EXTERNALTIME_tmp)!=0);
N173_externalTime=l9_1695;
N173_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N173_externalSeed=l9_1696;
N173_ENABLE_LIFETIMEMINMAX=(int(LIFETIMEMINMAX_tmp)!=0);
N173_lifeTimeConstant=l9_1697;
N173_lifeTimeMinMax=l9_1698;
N173_ENABLE_INSTANTSPAWN=(int(INSTANTSPAWN_tmp)!=0);
N173_spawnDuration=l9_1699;
float l9_1705=0.0;
if (N173_ENABLE_WORLDPOSSEED)
{
float4x4 l9_1706=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_1705=length(float4(1.0)*l9_1706);
}
N173_globalSeed=N173_externalSeed+l9_1705;
float l9_1707=2000.0;
int l9_1708=0;
int l9_1709=gl_InstanceIndex;
l9_1708=l9_1709;
int l9_1710=l9_1708;
float l9_1711=float(l9_1710);
float2 l9_1712=float2(mod(l9_1711,l9_1707),floor(l9_1711/l9_1707));
l9_1712/=float2(l9_1707);
float2 l9_1713=l9_1712;
float l9_1714=dot(l9_1713,float2(0.38253,0.42662001));
float3 l9_1715=float3(0.457831,0.62343299,0.97625297)*l9_1714;
l9_1715=sin(l9_1715)*float3(479.371,389.53101,513.03497);
l9_1715=fract(l9_1715);
l9_1715=floor(l9_1715*10000.0)*9.9999997e-05;
float3 l9_1716=l9_1715;
float3 l9_1717=l9_1716;
N173_particleSeed=l9_1717;
float l9_1718=fract((N173_particleSeed.y*12.12358)+N173_globalSeed);
float l9_1719=fract((N173_particleSeed.z*3.5358)+N173_globalSeed);
float2 l9_1720=float2(N173_lifeTimeConstant);
if (N173_ENABLE_LIFETIMEMINMAX)
{
l9_1720=N173_lifeTimeMinMax;
}
float l9_1721=fast::max(l9_1720.x,0.0099999998);
float l9_1722=fast::max(l9_1720.y,0.0099999998);
float l9_1723=tempGlobals.gTimeElapsed;
float l9_1724=l9_1723;
if (N173_ENABLE_EXTERNALTIME)
{
l9_1724=N173_externalTime;
}
float l9_1725=l9_1724;
if (N173_ENABLE_INSTANTSPAWN)
{
l9_1725=N173_timeGlobal*l9_1724;
}
else
{
float l9_1726=fract(((l9_1724*N173_timeGlobal)*(1.0/l9_1720.y))+l9_1718);
l9_1725=l9_1726*l9_1720.y;
}
float l9_1727=mix(l9_1725/l9_1721,l9_1725/l9_1722,l9_1719);
float l9_1728=fast::clamp(l9_1727,0.0,1.0);
float l9_1729=0.0;
if (!N173_ENABLE_INSTANTSPAWN)
{
if (N173_spawnDuration>0.0)
{
if ((l9_1724-N173_spawnDuration)>=l9_1725)
{
l9_1729=1.0;
}
}
}
float l9_1730=l9_1727+l9_1729;
N173_dieTrigger=1.0;
if (l9_1730>0.99989998)
{
N173_dieTrigger=0.0;
}
N173_timeValues=float4(l9_1720,l9_1725,l9_1728);
l9_1701=N173_particleSeed;
l9_1702=N173_globalSeed;
l9_1703=N173_dieTrigger;
l9_1704=N173_timeValues;
l9_1690=l9_1701;
l9_1691=l9_1702;
l9_1692=l9_1703;
l9_1693=l9_1704;
float3 l9_1731=float3(0.0);
l9_1731=param_240.SurfacePosition_ObjectSpace;
float3 l9_1732=float3(0.0);
l9_1732=param_240.VertexNormal_ObjectSpace;
float3 l9_1733=float3(0.0);
float3 l9_1734=(*sc_set2.UserUniforms).spawnLocation;
l9_1733=l9_1734;
float3 l9_1735=float3(0.0);
float3 l9_1736=(*sc_set2.UserUniforms).spawnBox;
l9_1735=l9_1736;
float3 l9_1737=float3(0.0);
float3 l9_1738=(*sc_set2.UserUniforms).spawnSphere;
l9_1737=l9_1738;
float3 l9_1739=float3(0.0);
float3 l9_1740=(*sc_set2.UserUniforms).noiseMult;
l9_1739=l9_1740;
float3 l9_1741=float3(0.0);
float3 l9_1742=(*sc_set2.UserUniforms).noiseFrequency;
l9_1741=l9_1742;
float3 l9_1743=float3(0.0);
float3 l9_1744=(*sc_set2.UserUniforms).sNoiseMult;
l9_1743=l9_1744;
float3 l9_1745=float3(0.0);
float3 l9_1746=(*sc_set2.UserUniforms).sNoiseFrequency;
l9_1745=l9_1746;
float3 l9_1747=float3(0.0);
float3 l9_1748=(*sc_set2.UserUniforms).velocityMin;
l9_1747=l9_1748;
float3 l9_1749=float3(0.0);
float3 l9_1750=(*sc_set2.UserUniforms).velocityMax;
l9_1749=l9_1750;
float3 l9_1751=float3(0.0);
float3 l9_1752=(*sc_set2.UserUniforms).velocityDrag;
l9_1751=l9_1752;
float3 l9_1753=float3(0.0);
float3 l9_1754=float3(0.0);
float3 l9_1755=float3(0.0);
float3 l9_1756;
if (MESHTYPE_tmp==0)
{
float2 l9_1757=float2(0.0);
float2 l9_1758=(*sc_set2.UserUniforms).sizeStart;
l9_1757=l9_1758;
l9_1754=float3(l9_1757,0.0);
l9_1756=l9_1754;
}
else
{
float3 l9_1759=float3(0.0);
float3 l9_1760=(*sc_set2.UserUniforms).sizeStart3D;
l9_1759=l9_1760;
l9_1755=l9_1759;
l9_1756=l9_1755;
}
l9_1753=l9_1756;
float3 l9_1761=float3(0.0);
float3 l9_1762=float3(0.0);
float3 l9_1763=float3(0.0);
float3 l9_1764;
if (MESHTYPE_tmp==0)
{
float2 l9_1765=float2(0.0);
float2 l9_1766=(*sc_set2.UserUniforms).sizeEnd;
l9_1765=l9_1766;
l9_1762=float3(l9_1765,0.0);
l9_1764=l9_1762;
}
else
{
float3 l9_1767=float3(0.0);
float3 l9_1768=(*sc_set2.UserUniforms).sizeEnd3D;
l9_1767=l9_1768;
l9_1763=l9_1767;
l9_1764=l9_1763;
}
l9_1761=l9_1764;
float3 l9_1769=float3(0.0);
float3 l9_1770=float3(0.0);
float3 l9_1771=float3(0.0);
float3 l9_1772;
if (MESHTYPE_tmp==0)
{
float2 l9_1773=float2(0.0);
float2 l9_1774=(*sc_set2.UserUniforms).sizeStartMin;
l9_1773=l9_1774;
l9_1770=float3(l9_1773,0.0);
l9_1772=l9_1770;
}
else
{
float3 l9_1775=float3(0.0);
float3 l9_1776=(*sc_set2.UserUniforms).sizeStartMin3D;
l9_1775=l9_1776;
l9_1771=l9_1775;
l9_1772=l9_1771;
}
l9_1769=l9_1772;
float3 l9_1777=float3(0.0);
float3 l9_1778=float3(0.0);
float3 l9_1779=float3(0.0);
float3 l9_1780;
if (MESHTYPE_tmp==0)
{
float2 l9_1781=float2(0.0);
float2 l9_1782=(*sc_set2.UserUniforms).sizeStartMax;
l9_1781=l9_1782;
l9_1778=float3(l9_1781,0.0);
l9_1780=l9_1778;
}
else
{
float3 l9_1783=float3(0.0);
float3 l9_1784=(*sc_set2.UserUniforms).sizeStartMax3D;
l9_1783=l9_1784;
l9_1779=l9_1783;
l9_1780=l9_1779;
}
l9_1777=l9_1780;
float3 l9_1785=float3(0.0);
float3 l9_1786=float3(0.0);
float3 l9_1787=float3(0.0);
float3 l9_1788;
if (MESHTYPE_tmp==0)
{
float2 l9_1789=float2(0.0);
float2 l9_1790=(*sc_set2.UserUniforms).sizeEndMin;
l9_1789=l9_1790;
l9_1786=float3(l9_1789,0.0);
l9_1788=l9_1786;
}
else
{
float3 l9_1791=float3(0.0);
float3 l9_1792=(*sc_set2.UserUniforms).sizeEndMin3D;
l9_1791=l9_1792;
l9_1787=l9_1791;
l9_1788=l9_1787;
}
l9_1785=l9_1788;
float3 l9_1793=float3(0.0);
float3 l9_1794=float3(0.0);
float3 l9_1795=float3(0.0);
float3 l9_1796;
if (MESHTYPE_tmp==0)
{
float2 l9_1797=float2(0.0);
float2 l9_1798=(*sc_set2.UserUniforms).sizeEndMax;
l9_1797=l9_1798;
l9_1794=float3(l9_1797,0.0);
l9_1796=l9_1794;
}
else
{
float3 l9_1799=float3(0.0);
float3 l9_1800=(*sc_set2.UserUniforms).sizeEndMax3D;
l9_1799=l9_1800;
l9_1795=l9_1799;
l9_1796=l9_1795;
}
l9_1793=l9_1796;
float l9_1801=0.0;
float l9_1802=(*sc_set2.UserUniforms).sizeSpeed;
l9_1801=l9_1802;
float l9_1803=0.0;
float l9_1804=(*sc_set2.UserUniforms).gravity;
l9_1803=l9_1804;
float3 l9_1805=float3(0.0);
float3 l9_1806=(*sc_set2.UserUniforms).localForce;
l9_1805=l9_1806;
float l9_1807=0.0;
float l9_1808=(*sc_set2.UserUniforms).sizeVelScale;
l9_1807=l9_1808;
float l9_1809=0.0;
float l9_1810=float((*sc_set2.UserUniforms).ALIGNTOX!=0);
l9_1809=l9_1810;
float l9_1811=0.0;
float l9_1812=float((*sc_set2.UserUniforms).ALIGNTOY!=0);
l9_1811=l9_1812;
float l9_1813=0.0;
float l9_1814=float((*sc_set2.UserUniforms).ALIGNTOZ!=0);
l9_1813=l9_1814;
float2 l9_1815=float2(0.0);
float2 l9_1816=(*sc_set2.UserUniforms).Port_Input1_N138;
float2 l9_1817=float2(0.0);
float2 l9_1818;
if (MESHTYPE_tmp==0)
{
l9_1818=l9_1816;
}
else
{
float2 l9_1819=float2(0.0);
float2 l9_1820=(*sc_set2.UserUniforms).rotationRandomX;
l9_1819=l9_1820;
l9_1817=l9_1819;
l9_1818=l9_1817;
}
l9_1815=l9_1818;
float2 l9_1821=float2(0.0);
float2 l9_1822=(*sc_set2.UserUniforms).Port_Input1_N139;
float2 l9_1823=float2(0.0);
float2 l9_1824;
if (MESHTYPE_tmp==0)
{
l9_1824=l9_1822;
}
else
{
float2 l9_1825=float2(0.0);
float2 l9_1826=(*sc_set2.UserUniforms).rotationRateX;
l9_1825=l9_1826;
l9_1823=l9_1825;
l9_1824=l9_1823;
}
l9_1821=l9_1824;
float2 l9_1827=float2(0.0);
float2 l9_1828=(*sc_set2.UserUniforms).Port_Input1_N140;
float2 l9_1829=float2(0.0);
float2 l9_1830;
if (MESHTYPE_tmp==0)
{
l9_1830=l9_1828;
}
else
{
float2 l9_1831=float2(0.0);
float2 l9_1832=(*sc_set2.UserUniforms).randomRotationY;
l9_1831=l9_1832;
l9_1829=l9_1831;
l9_1830=l9_1829;
}
l9_1827=l9_1830;
float2 l9_1833=float2(0.0);
float2 l9_1834=(*sc_set2.UserUniforms).Port_Input1_N144;
float2 l9_1835=float2(0.0);
float2 l9_1836;
if (MESHTYPE_tmp==0)
{
l9_1836=l9_1834;
}
else
{
float2 l9_1837=float2(0.0);
float2 l9_1838=(*sc_set2.UserUniforms).rotationRateY;
l9_1837=l9_1838;
l9_1835=l9_1837;
l9_1836=l9_1835;
}
l9_1833=l9_1836;
float2 l9_1839=float2(0.0);
float2 l9_1840=float2(1.0);
float2 l9_1841=float2(0.0);
float2 l9_1842;
if (MESHTYPE_tmp==0)
{
float2 l9_1843=float2(0.0);
float2 l9_1844=(*sc_set2.UserUniforms).rotationRandom;
l9_1843=l9_1844;
l9_1840=l9_1843;
l9_1842=l9_1840;
}
else
{
float2 l9_1845=float2(0.0);
float2 l9_1846=(*sc_set2.UserUniforms).randomRotationZ;
l9_1845=l9_1846;
l9_1841=l9_1845;
l9_1842=l9_1841;
}
l9_1839=l9_1842;
float2 l9_1847=float2(0.0);
float2 l9_1848=float2(1.0);
float2 l9_1849=float2(0.0);
float2 l9_1850;
if (MESHTYPE_tmp==0)
{
float2 l9_1851=float2(0.0);
float2 l9_1852=(*sc_set2.UserUniforms).rotationRate;
l9_1851=l9_1852;
l9_1848=l9_1851;
l9_1850=l9_1848;
}
else
{
float2 l9_1853=float2(0.0);
float2 l9_1854=(*sc_set2.UserUniforms).rotationRateZ;
l9_1853=l9_1854;
l9_1849=l9_1853;
l9_1850=l9_1849;
}
l9_1847=l9_1850;
float l9_1855=0.0;
float l9_1856=(*sc_set2.UserUniforms).rotationDrag;
l9_1855=l9_1856;
float l9_1857=0.0;
float l9_1858=(*sc_set2.UserUniforms).Port_Input1_N110;
float l9_1859=0.0;
float l9_1860;
if (MESHTYPE_tmp==0)
{
l9_1860=l9_1858;
}
else
{
float l9_1861=0.0;
float l9_1862=float((*sc_set2.UserUniforms).CENTER_BBOX!=0);
l9_1861=l9_1862;
l9_1859=l9_1861;
l9_1860=l9_1859;
}
l9_1857=l9_1860;
float l9_1863=0.0;
float l9_1864=(*sc_set2.UserUniforms).fadeDistanceVisible;
l9_1863=l9_1864;
float l9_1865=0.0;
float l9_1866=(*sc_set2.UserUniforms).fadeDistanceInvisible;
l9_1865=l9_1866;
float l9_1867=0.0;
float3 l9_1868=l9_1690;
float l9_1869=l9_1691;
float l9_1870=l9_1692;
float4 l9_1871=l9_1693;
float3 l9_1872=l9_1731;
float3 l9_1873=l9_1732;
float3 l9_1874=l9_1733;
float3 l9_1875=l9_1735;
float3 l9_1876=l9_1737;
float3 l9_1877=l9_1739;
float3 l9_1878=l9_1741;
float3 l9_1879=l9_1743;
float3 l9_1880=l9_1745;
float3 l9_1881=l9_1747;
float3 l9_1882=l9_1749;
float3 l9_1883=l9_1751;
float3 l9_1884=l9_1753;
float3 l9_1885=l9_1761;
float3 l9_1886=l9_1769;
float3 l9_1887=l9_1777;
float3 l9_1888=l9_1785;
float3 l9_1889=l9_1793;
float l9_1890=l9_1801;
float l9_1891=l9_1803;
float3 l9_1892=l9_1805;
float l9_1893=l9_1807;
float l9_1894=l9_1809;
float l9_1895=l9_1811;
float l9_1896=l9_1813;
float2 l9_1897=l9_1815;
float2 l9_1898=l9_1821;
float2 l9_1899=l9_1827;
float2 l9_1900=l9_1833;
float2 l9_1901=l9_1839;
float2 l9_1902=l9_1847;
float l9_1903=l9_1855;
float l9_1904=l9_1857;
float l9_1905=l9_1863;
float l9_1906=l9_1865;
ssGlobals l9_1907=param_240;
tempGlobals=l9_1907;
float l9_1908=0.0;
N111_MESHTYPE_QUAD=MESHTYPE_tmp==0;
N111_particleSeedIn=l9_1868;
N111_globalSeedIn=l9_1869;
N111_dieTrigger=l9_1870;
N111_timeValuesIn=l9_1871;
N111_positionObjectSpace=l9_1872;
N111_normalObjectSpace=l9_1873;
N111_ENABLE_INILOCATION=(int(INILOCATION_tmp)!=0);
N111_spawnLocation=l9_1874;
N111_ENABLE_BOXSPAWN=(int(BOXSPAWN_tmp)!=0);
N111_spawnBox=l9_1875;
N111_ENABLE_SPHERESPAWN=(int(SPHERESPAWN_tmp)!=0);
N111_spawnSphere=l9_1876;
N111_ENABLE_NOISE=(int(NOISE_tmp)!=0);
N111_noiseMult=l9_1877;
N111_noiseFrequency=l9_1878;
N111_ENABLE_SNOISE=(int(SNOISE_tmp)!=0);
N111_sNoiseMult=l9_1879;
N111_sNoiseFrequency=l9_1880;
N111_ENABLE_VELRAMP=(int(VELRAMP_tmp)!=0);
N111_velocityMin=l9_1881;
N111_velocityMax=l9_1882;
N111_velocityDrag=l9_1883;
N111_sizeStart=l9_1884;
N111_sizeEnd=l9_1885;
N111_ENABLE_SIZEMINMAX=(int(SIZEMINMAX_tmp)!=0);
N111_sizeStartMin=l9_1886;
N111_sizeStartMax=l9_1887;
N111_sizeEndMin=l9_1888;
N111_sizeEndMax=l9_1889;
N111_sizeSpeed=l9_1890;
N111_ENABLE_SIZERAMP=(int(SIZERAMP_tmp)!=0);
N111_gravity=l9_1891;
N111_ENABLE_FORCE=(int(FORCE_tmp)!=0);
N111_localForce=l9_1892;
N111_ENABLE_ALIGNTOVEL=(int(VELOCITYDIR_tmp)!=0);
N111_sizeVelScale=l9_1893;
N111_ENABLE_IGNOREVEL=(int(IGNOREVEL_tmp)!=0);
N111_ENABLE_IGNORETRANSFORMSCALE=(int(IGNORETRANSFORMSCALE_tmp)!=0);
N111_ENABLE_ALIGNTOX=l9_1894!=0.0;
N111_ENABLE_ALIGNTOY=l9_1895!=0.0;
N111_ENABLE_ALIGNTOZ=l9_1896!=0.0;
N111_rotationRandomX=l9_1897;
N111_rotationRateX=l9_1898;
N111_rotationRandomY=l9_1899;
N111_rotationRateY=l9_1900;
N111_rotationRandomZ=l9_1901;
N111_rotationRateZ=l9_1902;
N111_rotationDrag=l9_1903;
N111_WORLDSPACE=rotationSpace_tmp==1;
N111_WORLDFORCE=rotationSpace_tmp==2;
N111_ENABLE_CENTER_IN_BBOX=l9_1904!=0.0;
N111_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N111_fadeDistanceVisible=l9_1905;
N111_fadeDistanceInvisible=l9_1906;
float3 l9_1909=float3(0.0);
N111_particleSeed=N111_particleSeedIn;
N111_globalSeed=N111_globalSeedIn;
float l9_1910=N111_particleSeed.x;
float l9_1911=N111_particleSeed.y;
float l9_1912=N111_particleSeed.z;
float3 l9_1913=fract((float3(l9_1910,l9_1911,l9_1912)*3048.28)+float3(N111_globalSeed))-float3(0.5);
float3 l9_1914=fract((N111_particleSeed*374.57129)+float3(N111_globalSeed))-float3(0.5);
float3 l9_1915=normalize(l9_1914+float3(N111_EPSILON));
float l9_1916=fract(N111_particleSeed.x+N111_globalSeed);
float l9_1917=l9_1916;
float l9_1918=0.33333334;
float l9_1919;
if (l9_1917<=0.0)
{
l9_1919=0.0;
}
else
{
l9_1919=pow(l9_1917,l9_1918);
}
float l9_1920=l9_1919;
float l9_1921=l9_1920;
l9_1915*=l9_1921;
l9_1915/=float3(2.0);
float l9_1922=fract((N111_particleSeed.x*334.59122)+N111_globalSeed)-0.5;
float l9_1923=fract((N111_particleSeed.y*41.231232)+N111_globalSeed)-0.5;
float l9_1924=fract((N111_particleSeed.z*18.984529)+N111_globalSeed);
float l9_1925=fract((N111_particleSeed.x*654.15588)+N111_globalSeed);
float l9_1926=fract((N111_particleSeed.y*45.722408)+N111_globalSeed);
float3 l9_1927=(float3(l9_1925,l9_1926,l9_1924)-float3(0.5))*2.0;
float3 l9_1928=float3(l9_1925,l9_1926,l9_1924);
float l9_1929=fract((N111_particleSeed.z*15.32451)+N111_globalSeed);
float2 l9_1930=N111_timeValuesIn.xy;
float l9_1931=N111_timeValuesIn.z;
float l9_1932=N111_timeValuesIn.w;
float3 l9_1933=l9_1909;
float3 l9_1934=l9_1909;
float3 l9_1935=l9_1909;
if (N111_ENABLE_INILOCATION)
{
l9_1935=N111_spawnLocation;
}
if (N111_ENABLE_BOXSPAWN)
{
l9_1933=N111_spawnBox*l9_1913;
}
if (N111_ENABLE_SPHERESPAWN)
{
l9_1934=N111_spawnSphere*l9_1915;
}
float3 l9_1936=(l9_1935+l9_1934)+l9_1933;
float3 l9_1937=l9_1909;
if (N111_ENABLE_NOISE)
{
float3 l9_1938=N111_noiseFrequency;
float3 l9_1939=N111_noiseMult;
float3 l9_1940=l9_1927;
float l9_1941=l9_1932;
float l9_1942=sin(l9_1941*l9_1938.x);
float l9_1943=sin(l9_1941*l9_1938.y);
float l9_1944=sin(l9_1941*l9_1938.z);
float3 l9_1945=(float3(l9_1942,l9_1943,l9_1944)*l9_1939)*l9_1940;
float3 l9_1946=l9_1945;
l9_1937+=l9_1946;
}
if (N111_ENABLE_SNOISE)
{
float l9_1947=l9_1924;
float l9_1948=l9_1925;
float l9_1949=l9_1926;
float3 l9_1950=N111_sNoiseFrequency;
float3 l9_1951=N111_sNoiseMult;
float3 l9_1952=l9_1927;
float l9_1953=l9_1931;
float2 l9_1954=float2(l9_1947*l9_1953,l9_1950.x);
float2 l9_1955=floor(l9_1954+float2(dot(l9_1954,float2(0.36602542))));
float2 l9_1956=(l9_1954-l9_1955)+float2(dot(l9_1955,float2(0.21132487)));
float2 l9_1957=float2(0.0);
bool2 l9_1958=bool2(l9_1956.x>l9_1956.y);
l9_1957=float2(l9_1958.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_1958.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_1959=l9_1956.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_1960=l9_1959.xy-l9_1957;
l9_1959=float4(l9_1960.x,l9_1960.y,l9_1959.z,l9_1959.w);
l9_1955=mod(l9_1955,float2(289.0));
float3 l9_1961=float3(l9_1955.y)+float3(0.0,l9_1957.y,1.0);
float3 l9_1962=mod(((l9_1961*34.0)+float3(1.0))*l9_1961,float3(289.0));
float3 l9_1963=(l9_1962+float3(l9_1955.x))+float3(0.0,l9_1957.x,1.0);
float3 l9_1964=mod(((l9_1963*34.0)+float3(1.0))*l9_1963,float3(289.0));
float3 l9_1965=l9_1964;
float3 l9_1966=fast::max(float3(0.5)-float3(dot(l9_1956,l9_1956),dot(l9_1959.xy,l9_1959.xy),dot(l9_1959.zw,l9_1959.zw)),float3(0.0));
l9_1966*=l9_1966;
l9_1966*=l9_1966;
float3 l9_1967=(fract(l9_1965*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_1968=abs(l9_1967)-float3(0.5);
float3 l9_1969=floor(l9_1967+float3(0.5));
float3 l9_1970=l9_1967-l9_1969;
l9_1966*=(float3(1.7928429)-(((l9_1970*l9_1970)+(l9_1968*l9_1968))*0.85373473));
float3 l9_1971=float3(0.0);
l9_1971.x=(l9_1970.x*l9_1956.x)+(l9_1968.x*l9_1956.y);
float2 l9_1972=(l9_1970.yz*l9_1959.xz)+(l9_1968.yz*l9_1959.yw);
l9_1971=float3(l9_1971.x,l9_1972.x,l9_1972.y);
float l9_1973=130.0*dot(l9_1966,l9_1971);
float l9_1974=l9_1973;
float2 l9_1975=float2(l9_1948*l9_1953,l9_1950.y);
float2 l9_1976=floor(l9_1975+float2(dot(l9_1975,float2(0.36602542))));
float2 l9_1977=(l9_1975-l9_1976)+float2(dot(l9_1976,float2(0.21132487)));
float2 l9_1978=float2(0.0);
bool2 l9_1979=bool2(l9_1977.x>l9_1977.y);
l9_1978=float2(l9_1979.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_1979.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_1980=l9_1977.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_1981=l9_1980.xy-l9_1978;
l9_1980=float4(l9_1981.x,l9_1981.y,l9_1980.z,l9_1980.w);
l9_1976=mod(l9_1976,float2(289.0));
float3 l9_1982=float3(l9_1976.y)+float3(0.0,l9_1978.y,1.0);
float3 l9_1983=mod(((l9_1982*34.0)+float3(1.0))*l9_1982,float3(289.0));
float3 l9_1984=(l9_1983+float3(l9_1976.x))+float3(0.0,l9_1978.x,1.0);
float3 l9_1985=mod(((l9_1984*34.0)+float3(1.0))*l9_1984,float3(289.0));
float3 l9_1986=l9_1985;
float3 l9_1987=fast::max(float3(0.5)-float3(dot(l9_1977,l9_1977),dot(l9_1980.xy,l9_1980.xy),dot(l9_1980.zw,l9_1980.zw)),float3(0.0));
l9_1987*=l9_1987;
l9_1987*=l9_1987;
float3 l9_1988=(fract(l9_1986*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_1989=abs(l9_1988)-float3(0.5);
float3 l9_1990=floor(l9_1988+float3(0.5));
float3 l9_1991=l9_1988-l9_1990;
l9_1987*=(float3(1.7928429)-(((l9_1991*l9_1991)+(l9_1989*l9_1989))*0.85373473));
float3 l9_1992=float3(0.0);
l9_1992.x=(l9_1991.x*l9_1977.x)+(l9_1989.x*l9_1977.y);
float2 l9_1993=(l9_1991.yz*l9_1980.xz)+(l9_1989.yz*l9_1980.yw);
l9_1992=float3(l9_1992.x,l9_1993.x,l9_1993.y);
float l9_1994=130.0*dot(l9_1987,l9_1992);
float l9_1995=l9_1994;
float2 l9_1996=float2(l9_1949*l9_1953,l9_1950.z);
float2 l9_1997=floor(l9_1996+float2(dot(l9_1996,float2(0.36602542))));
float2 l9_1998=(l9_1996-l9_1997)+float2(dot(l9_1997,float2(0.21132487)));
float2 l9_1999=float2(0.0);
bool2 l9_2000=bool2(l9_1998.x>l9_1998.y);
l9_1999=float2(l9_2000.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_2000.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_2001=l9_1998.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_2002=l9_2001.xy-l9_1999;
l9_2001=float4(l9_2002.x,l9_2002.y,l9_2001.z,l9_2001.w);
l9_1997=mod(l9_1997,float2(289.0));
float3 l9_2003=float3(l9_1997.y)+float3(0.0,l9_1999.y,1.0);
float3 l9_2004=mod(((l9_2003*34.0)+float3(1.0))*l9_2003,float3(289.0));
float3 l9_2005=(l9_2004+float3(l9_1997.x))+float3(0.0,l9_1999.x,1.0);
float3 l9_2006=mod(((l9_2005*34.0)+float3(1.0))*l9_2005,float3(289.0));
float3 l9_2007=l9_2006;
float3 l9_2008=fast::max(float3(0.5)-float3(dot(l9_1998,l9_1998),dot(l9_2001.xy,l9_2001.xy),dot(l9_2001.zw,l9_2001.zw)),float3(0.0));
l9_2008*=l9_2008;
l9_2008*=l9_2008;
float3 l9_2009=(fract(l9_2007*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_2010=abs(l9_2009)-float3(0.5);
float3 l9_2011=floor(l9_2009+float3(0.5));
float3 l9_2012=l9_2009-l9_2011;
l9_2008*=(float3(1.7928429)-(((l9_2012*l9_2012)+(l9_2010*l9_2010))*0.85373473));
float3 l9_2013=float3(0.0);
l9_2013.x=(l9_2012.x*l9_1998.x)+(l9_2010.x*l9_1998.y);
float2 l9_2014=(l9_2012.yz*l9_2001.xz)+(l9_2010.yz*l9_2001.yw);
l9_2013=float3(l9_2013.x,l9_2014.x,l9_2014.y);
float l9_2015=130.0*dot(l9_2008,l9_2013);
float l9_2016=l9_2015;
float3 l9_2017=(float3(l9_1974,l9_1995,l9_2016)*l9_1951)*l9_1952;
l9_1937+=l9_2017;
}
float3 l9_2018=float3(0.0,((N111_gravity/2.0)*l9_1931)*l9_1931,0.0);
float3 l9_2019=l9_1909;
if (N111_ENABLE_FORCE)
{
l9_2019=((N111_localForce/float3(2.0))*l9_1931)*l9_1931;
}
float3 l9_2020=l9_1909;
float3 l9_2021=N111_velocityMin+(((l9_1927+float3(1.0))/float3(2.0))*(N111_velocityMax-N111_velocityMin));
if (N111_ENABLE_VELRAMP)
{
l9_2021=mix(N111_velocityMin,N111_velocityMax,l9_1928);
}
float3 l9_2022=l9_2021;
float l9_2023=l9_1931;
float3 l9_2024=N111_velocityDrag;
float3 l9_2025=l9_1937;
float l9_2026=l9_1932;
float3 l9_2027=float3(l9_2023,l9_2023,l9_2023);
float3 l9_2028=l9_2024;
float l9_2029;
if (l9_2027.x<=0.0)
{
l9_2029=0.0;
}
else
{
l9_2029=pow(l9_2027.x,l9_2028.x);
}
float l9_2030=l9_2029;
float l9_2031;
if (l9_2027.y<=0.0)
{
l9_2031=0.0;
}
else
{
l9_2031=pow(l9_2027.y,l9_2028.y);
}
float l9_2032=l9_2031;
float l9_2033;
if (l9_2027.z<=0.0)
{
l9_2033=0.0;
}
else
{
l9_2033=pow(l9_2027.z,l9_2028.z);
}
float3 l9_2034=float3(l9_2030,l9_2032,l9_2033);
float3 l9_2035=l9_2034;
float3 l9_2036=(l9_2022+l9_2025)*l9_2035;
if (N111_ENABLE_VELRAMP)
{
float l9_2037=floor(l9_2026*10000.0)/10000.0;
float2 l9_2038=tempGlobals.Surface_UVCoord0;
float2 l9_2039=(l9_2038/float2(10000.0,1.0))+float2(l9_2037,0.0);
float2 l9_2040=l9_2039;
float4 l9_2041=float4(0.0);
int l9_2042=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_2043=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2043=0;
}
else
{
l9_2043=gl_InstanceIndex%2;
}
int l9_2044=l9_2043;
l9_2042=1-l9_2044;
}
else
{
int l9_2045=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2045=0;
}
else
{
l9_2045=gl_InstanceIndex%2;
}
int l9_2046=l9_2045;
l9_2042=l9_2046;
}
int l9_2047=l9_2042;
int l9_2048=velRampTextureLayout_tmp;
int l9_2049=l9_2047;
float2 l9_2050=l9_2040;
bool l9_2051=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_2052=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_2053=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_2054=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_2055=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_2056=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_2057=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_2058=0.0;
bool l9_2059=l9_2056&&(!l9_2054);
float l9_2060=1.0;
float l9_2061=l9_2050.x;
int l9_2062=l9_2053.x;
if (l9_2062==1)
{
l9_2061=fract(l9_2061);
}
else
{
if (l9_2062==2)
{
float l9_2063=fract(l9_2061);
float l9_2064=l9_2061-l9_2063;
float l9_2065=step(0.25,fract(l9_2064*0.5));
l9_2061=mix(l9_2063,1.0-l9_2063,fast::clamp(l9_2065,0.0,1.0));
}
}
l9_2050.x=l9_2061;
float l9_2066=l9_2050.y;
int l9_2067=l9_2053.y;
if (l9_2067==1)
{
l9_2066=fract(l9_2066);
}
else
{
if (l9_2067==2)
{
float l9_2068=fract(l9_2066);
float l9_2069=l9_2066-l9_2068;
float l9_2070=step(0.25,fract(l9_2069*0.5));
l9_2066=mix(l9_2068,1.0-l9_2068,fast::clamp(l9_2070,0.0,1.0));
}
}
l9_2050.y=l9_2066;
if (l9_2054)
{
bool l9_2071=l9_2056;
bool l9_2072;
if (l9_2071)
{
l9_2072=l9_2053.x==3;
}
else
{
l9_2072=l9_2071;
}
float l9_2073=l9_2050.x;
float l9_2074=l9_2055.x;
float l9_2075=l9_2055.z;
bool l9_2076=l9_2072;
float l9_2077=l9_2060;
float l9_2078=fast::clamp(l9_2073,l9_2074,l9_2075);
float l9_2079=step(abs(l9_2073-l9_2078),9.9999997e-06);
l9_2077*=(l9_2079+((1.0-float(l9_2076))*(1.0-l9_2079)));
l9_2073=l9_2078;
l9_2050.x=l9_2073;
l9_2060=l9_2077;
bool l9_2080=l9_2056;
bool l9_2081;
if (l9_2080)
{
l9_2081=l9_2053.y==3;
}
else
{
l9_2081=l9_2080;
}
float l9_2082=l9_2050.y;
float l9_2083=l9_2055.y;
float l9_2084=l9_2055.w;
bool l9_2085=l9_2081;
float l9_2086=l9_2060;
float l9_2087=fast::clamp(l9_2082,l9_2083,l9_2084);
float l9_2088=step(abs(l9_2082-l9_2087),9.9999997e-06);
l9_2086*=(l9_2088+((1.0-float(l9_2085))*(1.0-l9_2088)));
l9_2082=l9_2087;
l9_2050.y=l9_2082;
l9_2060=l9_2086;
}
float2 l9_2089=l9_2050;
bool l9_2090=l9_2051;
float3x3 l9_2091=l9_2052;
if (l9_2090)
{
l9_2089=float2((l9_2091*float3(l9_2089,1.0)).xy);
}
float2 l9_2092=l9_2089;
float2 l9_2093=l9_2092;
float2 l9_2094=l9_2093;
l9_2050=l9_2094;
float l9_2095=l9_2050.x;
int l9_2096=l9_2053.x;
bool l9_2097=l9_2059;
float l9_2098=l9_2060;
if ((l9_2096==0)||(l9_2096==3))
{
float l9_2099=l9_2095;
float l9_2100=0.0;
float l9_2101=1.0;
bool l9_2102=l9_2097;
float l9_2103=l9_2098;
float l9_2104=fast::clamp(l9_2099,l9_2100,l9_2101);
float l9_2105=step(abs(l9_2099-l9_2104),9.9999997e-06);
l9_2103*=(l9_2105+((1.0-float(l9_2102))*(1.0-l9_2105)));
l9_2099=l9_2104;
l9_2095=l9_2099;
l9_2098=l9_2103;
}
l9_2050.x=l9_2095;
l9_2060=l9_2098;
float l9_2106=l9_2050.y;
int l9_2107=l9_2053.y;
bool l9_2108=l9_2059;
float l9_2109=l9_2060;
if ((l9_2107==0)||(l9_2107==3))
{
float l9_2110=l9_2106;
float l9_2111=0.0;
float l9_2112=1.0;
bool l9_2113=l9_2108;
float l9_2114=l9_2109;
float l9_2115=fast::clamp(l9_2110,l9_2111,l9_2112);
float l9_2116=step(abs(l9_2110-l9_2115),9.9999997e-06);
l9_2114*=(l9_2116+((1.0-float(l9_2113))*(1.0-l9_2116)));
l9_2110=l9_2115;
l9_2106=l9_2110;
l9_2109=l9_2114;
}
l9_2050.y=l9_2106;
l9_2060=l9_2109;
float2 l9_2117=l9_2050;
int l9_2118=l9_2048;
int l9_2119=l9_2049;
float l9_2120=l9_2058;
float2 l9_2121=l9_2117;
int l9_2122=l9_2118;
int l9_2123=l9_2119;
float3 l9_2124=float3(0.0);
if (l9_2122==0)
{
l9_2124=float3(l9_2121,0.0);
}
else
{
if (l9_2122==1)
{
l9_2124=float3(l9_2121.x,(l9_2121.y*0.5)+(0.5-(float(l9_2123)*0.5)),0.0);
}
else
{
l9_2124=float3(l9_2121,float(l9_2123));
}
}
float3 l9_2125=l9_2124;
float3 l9_2126=l9_2125;
float2 l9_2127=l9_2126.xy;
float l9_2128=l9_2120;
float4 l9_2129=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_2127,level(l9_2128));
float4 l9_2130=l9_2129;
float4 l9_2131=l9_2130;
if (l9_2056)
{
l9_2131=mix(l9_2057,l9_2131,float4(l9_2060));
}
float4 l9_2132=l9_2131;
l9_2041=l9_2132;
float4 l9_2133=l9_2041;
float3 l9_2134=l9_2133.xyz;
l9_2036=(l9_2022+l9_2025)*l9_2134;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_2036=l9_2022*l9_2035;
}
}
float3 l9_2135=l9_2036;
l9_2020=l9_2135;
float4x4 l9_2136=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_2137=length(l9_2136[0].xyz);
float4x4 l9_2138=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_2139=length(l9_2138[1].xyz);
float4x4 l9_2140=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_2141=length(l9_2140[2].xyz);
float3 l9_2142=float3(l9_2137,l9_2139,l9_2141);
float4x4 l9_2143=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_2144=l9_2143;
float4 l9_2145=l9_2144[0];
float4 l9_2146=l9_2144[1];
float4 l9_2147=l9_2144[2];
float3x3 l9_2148=float3x3(float3(float3(l9_2145.x,l9_2146.x,l9_2147.x)),float3(float3(l9_2145.y,l9_2146.y,l9_2147.y)),float3(float3(l9_2145.z,l9_2146.z,l9_2147.z)));
float3x3 l9_2149=l9_2148;
float3 l9_2150=((l9_2020+l9_2018)+l9_2019)*l9_2149;
if (N111_WORLDFORCE)
{
float4x4 l9_2151=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_2152=l9_2151;
float4 l9_2153=l9_2152[0];
float4 l9_2154=l9_2152[1];
float4 l9_2155=l9_2152[2];
float3x3 l9_2156=float3x3(float3(float3(l9_2153.x,l9_2154.x,l9_2155.x)),float3(float3(l9_2153.y,l9_2154.y,l9_2155.y)),float3(float3(l9_2153.z,l9_2154.z,l9_2155.z)));
float3x3 l9_2157=l9_2156;
l9_2150=((l9_2020*l9_2157)+l9_2018)+l9_2019;
}
if (N111_WORLDSPACE)
{
l9_2150=((l9_2020*l9_2142)+l9_2018)+l9_2019;
}
float4x4 l9_2158=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3 l9_2159=(l9_2158*float4(l9_1936,1.0)).xyz+l9_2150;
float l9_2160=mix(N111_rotationRandomZ.x,N111_rotationRandomZ.y,l9_1929);
float l9_2161=1.0-l9_1932;
float l9_2162=N111_rotationDrag;
float l9_2163;
if (l9_2161<=0.0)
{
l9_2163=0.0;
}
else
{
l9_2163=pow(l9_2161,l9_2162);
}
float l9_2164=l9_2163;
float l9_2165=l9_2164;
float l9_2166=mix(N111_rotationRateZ.x,N111_rotationRateZ.y,l9_1929);
float l9_2167=((l9_2166*l9_2165)*l9_1932)*2.0;
float l9_2168=N111_PI*((l9_2167+l9_2160)-0.5);
float l9_2169=1.0;
if (N111_ENABLE_SCREENFADE)
{
float3 l9_2170=(*sc_set2.UserUniforms).sc_Camera.position;
float3 l9_2171=l9_2170-l9_2159;
float l9_2172=dot(l9_2171,l9_2171);
float l9_2173=(N111_fadeDistanceInvisible+N111_EPSILON)*(N111_fadeDistanceInvisible+N111_EPSILON);
float l9_2174=N111_fadeDistanceVisible*N111_fadeDistanceVisible;
float l9_2175=fast::min(l9_2173,l9_2174);
float l9_2176=fast::max(l9_2173,l9_2174);
N111_nearCameraFade=smoothstep(l9_2175,l9_2176,l9_2172);
float l9_2177;
if (l9_2173>l9_2174)
{
l9_2177=1.0-N111_nearCameraFade;
}
else
{
l9_2177=N111_nearCameraFade;
}
N111_nearCameraFade=l9_2177;
if (N111_nearCameraFade<=N111_EPSILON)
{
l9_2169=0.0;
}
}
if (N111_MESHTYPE_QUAD)
{
int l9_2178=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2178=0;
}
else
{
l9_2178=gl_InstanceIndex%2;
}
int l9_2179=l9_2178;
float4x4 l9_2180=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_2179];
float3 l9_2181=l9_2180[2].xyz;
int l9_2182=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2182=0;
}
else
{
l9_2182=gl_InstanceIndex%2;
}
int l9_2183=l9_2182;
float3 l9_2184=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_2183][1].xyz;
float3 l9_2185=-l9_2184;
float3 l9_2186=normalize(cross(l9_2181,l9_2185));
float l9_2187=1.0;
if (N111_ENABLE_ALIGNTOX)
{
l9_2186=float3(0.0,0.0,1.0);
l9_2185=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_2186=float3(1.0,0.0,0.0);
l9_2185=float3(0.0,0.0,1.0);
}
if (N111_ENABLE_ALIGNTOZ)
{
l9_2186=float3(1.0,0.0,0.0);
l9_2185=float3(0.0,1.0,0.0);
}
float2 l9_2188=float2(cos(l9_2168),sin(l9_2168));
float2 l9_2189=float2(-sin(l9_2168),cos(l9_2168));
float3 l9_2190=float3((l9_2186*l9_2188.x)+(l9_2185*l9_2188.y));
float3 l9_2191=float3((l9_2186*l9_2189.x)+(l9_2185*l9_2189.y));
if (N111_ENABLE_ALIGNTOVEL)
{
float3 l9_2192=normalize(((l9_2150+l9_2018)+l9_2019)+float3(N111_EPSILON));
float3 l9_2193=l9_2150*(l9_1931-0.0099999998);
float3 l9_2194=l9_2150*(l9_1931+0.0099999998);
if (N111_ENABLE_IGNOREVEL)
{
l9_2187=fast::max(N111_sizeVelScale,N111_EPSILON);
}
else
{
l9_2187=length(l9_2194-l9_2193)*N111_sizeVelScale;
if (N111_ENABLE_IGNORETRANSFORMSCALE)
{
float4x4 l9_2195=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_2187=(length(l9_2194-l9_2193)/length(l9_2195[0].xyz))*N111_sizeVelScale;
}
}
l9_2190=l9_2192;
l9_2191=normalize(cross(l9_2190,l9_2181));
}
float4x4 l9_2196=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_2197=length(l9_2196[0].xyz);
float2 l9_2198=tempGlobals.Surface_UVCoord0;
float2 l9_2199=l9_2198;
float l9_2200=N111_dieTrigger;
float l9_2201=l9_2169;
float2 l9_2202=l9_2199;
float l9_2203=l9_1922;
float l9_2204=l9_1923;
float l9_2205=l9_1932;
float l9_2206=N111_sizeSpeed;
float2 l9_2207=N111_sizeStart.xy;
float2 l9_2208=N111_sizeEnd.xy;
float l9_2209=l9_2205;
float l9_2210=l9_2206;
float l9_2211;
if (l9_2209<=0.0)
{
l9_2211=0.0;
}
else
{
l9_2211=pow(l9_2209,l9_2210);
}
float l9_2212=l9_2211;
float l9_2213=l9_2212;
if (N111_ENABLE_SIZEMINMAX)
{
l9_2207=mix(N111_sizeStartMin.xy,N111_sizeStartMax.xy,float2(l9_2203));
l9_2208=mix(N111_sizeEndMin.xy,N111_sizeEndMax.xy,float2(l9_2204));
}
float2 l9_2214=mix(l9_2207,l9_2208,float2(l9_2213));
if (N111_ENABLE_SIZERAMP)
{
float l9_2215=ceil(l9_2205*10000.0)/10000.0;
float2 l9_2216=tempGlobals.Surface_UVCoord0;
float2 l9_2217=(l9_2216/float2(10000.0,1.0))+float2(l9_2215,0.0);
float2 l9_2218=l9_2217;
float4 l9_2219=float4(0.0);
int l9_2220=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_2221=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2221=0;
}
else
{
l9_2221=gl_InstanceIndex%2;
}
int l9_2222=l9_2221;
l9_2220=1-l9_2222;
}
else
{
int l9_2223=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2223=0;
}
else
{
l9_2223=gl_InstanceIndex%2;
}
int l9_2224=l9_2223;
l9_2220=l9_2224;
}
int l9_2225=l9_2220;
int l9_2226=sizeRampTextureLayout_tmp;
int l9_2227=l9_2225;
float2 l9_2228=l9_2218;
bool l9_2229=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_2230=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_2231=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_2232=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_2233=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_2234=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_2235=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_2236=0.0;
bool l9_2237=l9_2234&&(!l9_2232);
float l9_2238=1.0;
float l9_2239=l9_2228.x;
int l9_2240=l9_2231.x;
if (l9_2240==1)
{
l9_2239=fract(l9_2239);
}
else
{
if (l9_2240==2)
{
float l9_2241=fract(l9_2239);
float l9_2242=l9_2239-l9_2241;
float l9_2243=step(0.25,fract(l9_2242*0.5));
l9_2239=mix(l9_2241,1.0-l9_2241,fast::clamp(l9_2243,0.0,1.0));
}
}
l9_2228.x=l9_2239;
float l9_2244=l9_2228.y;
int l9_2245=l9_2231.y;
if (l9_2245==1)
{
l9_2244=fract(l9_2244);
}
else
{
if (l9_2245==2)
{
float l9_2246=fract(l9_2244);
float l9_2247=l9_2244-l9_2246;
float l9_2248=step(0.25,fract(l9_2247*0.5));
l9_2244=mix(l9_2246,1.0-l9_2246,fast::clamp(l9_2248,0.0,1.0));
}
}
l9_2228.y=l9_2244;
if (l9_2232)
{
bool l9_2249=l9_2234;
bool l9_2250;
if (l9_2249)
{
l9_2250=l9_2231.x==3;
}
else
{
l9_2250=l9_2249;
}
float l9_2251=l9_2228.x;
float l9_2252=l9_2233.x;
float l9_2253=l9_2233.z;
bool l9_2254=l9_2250;
float l9_2255=l9_2238;
float l9_2256=fast::clamp(l9_2251,l9_2252,l9_2253);
float l9_2257=step(abs(l9_2251-l9_2256),9.9999997e-06);
l9_2255*=(l9_2257+((1.0-float(l9_2254))*(1.0-l9_2257)));
l9_2251=l9_2256;
l9_2228.x=l9_2251;
l9_2238=l9_2255;
bool l9_2258=l9_2234;
bool l9_2259;
if (l9_2258)
{
l9_2259=l9_2231.y==3;
}
else
{
l9_2259=l9_2258;
}
float l9_2260=l9_2228.y;
float l9_2261=l9_2233.y;
float l9_2262=l9_2233.w;
bool l9_2263=l9_2259;
float l9_2264=l9_2238;
float l9_2265=fast::clamp(l9_2260,l9_2261,l9_2262);
float l9_2266=step(abs(l9_2260-l9_2265),9.9999997e-06);
l9_2264*=(l9_2266+((1.0-float(l9_2263))*(1.0-l9_2266)));
l9_2260=l9_2265;
l9_2228.y=l9_2260;
l9_2238=l9_2264;
}
float2 l9_2267=l9_2228;
bool l9_2268=l9_2229;
float3x3 l9_2269=l9_2230;
if (l9_2268)
{
l9_2267=float2((l9_2269*float3(l9_2267,1.0)).xy);
}
float2 l9_2270=l9_2267;
float2 l9_2271=l9_2270;
float2 l9_2272=l9_2271;
l9_2228=l9_2272;
float l9_2273=l9_2228.x;
int l9_2274=l9_2231.x;
bool l9_2275=l9_2237;
float l9_2276=l9_2238;
if ((l9_2274==0)||(l9_2274==3))
{
float l9_2277=l9_2273;
float l9_2278=0.0;
float l9_2279=1.0;
bool l9_2280=l9_2275;
float l9_2281=l9_2276;
float l9_2282=fast::clamp(l9_2277,l9_2278,l9_2279);
float l9_2283=step(abs(l9_2277-l9_2282),9.9999997e-06);
l9_2281*=(l9_2283+((1.0-float(l9_2280))*(1.0-l9_2283)));
l9_2277=l9_2282;
l9_2273=l9_2277;
l9_2276=l9_2281;
}
l9_2228.x=l9_2273;
l9_2238=l9_2276;
float l9_2284=l9_2228.y;
int l9_2285=l9_2231.y;
bool l9_2286=l9_2237;
float l9_2287=l9_2238;
if ((l9_2285==0)||(l9_2285==3))
{
float l9_2288=l9_2284;
float l9_2289=0.0;
float l9_2290=1.0;
bool l9_2291=l9_2286;
float l9_2292=l9_2287;
float l9_2293=fast::clamp(l9_2288,l9_2289,l9_2290);
float l9_2294=step(abs(l9_2288-l9_2293),9.9999997e-06);
l9_2292*=(l9_2294+((1.0-float(l9_2291))*(1.0-l9_2294)));
l9_2288=l9_2293;
l9_2284=l9_2288;
l9_2287=l9_2292;
}
l9_2228.y=l9_2284;
l9_2238=l9_2287;
float2 l9_2295=l9_2228;
int l9_2296=l9_2226;
int l9_2297=l9_2227;
float l9_2298=l9_2236;
float2 l9_2299=l9_2295;
int l9_2300=l9_2296;
int l9_2301=l9_2297;
float3 l9_2302=float3(0.0);
if (l9_2300==0)
{
l9_2302=float3(l9_2299,0.0);
}
else
{
if (l9_2300==1)
{
l9_2302=float3(l9_2299.x,(l9_2299.y*0.5)+(0.5-(float(l9_2301)*0.5)),0.0);
}
else
{
l9_2302=float3(l9_2299,float(l9_2301));
}
}
float3 l9_2303=l9_2302;
float3 l9_2304=l9_2303;
float2 l9_2305=l9_2304.xy;
float l9_2306=l9_2298;
float4 l9_2307=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_2305,level(l9_2306));
float4 l9_2308=l9_2307;
float4 l9_2309=l9_2308;
if (l9_2234)
{
l9_2309=mix(l9_2235,l9_2309,float4(l9_2238));
}
float4 l9_2310=l9_2309;
l9_2219=l9_2310;
float4 l9_2311=l9_2219;
float2 l9_2312=l9_2311.xy;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_2312=float2(1.0);
}
l9_2214=l9_2312*l9_2207;
}
float2 l9_2313=l9_2214;
float2 l9_2314=(((l9_2202-float2(0.5))*(l9_2200*l9_2201))*l9_2313)*l9_2197;
float3 l9_2315=(l9_2159+(l9_2191*l9_2314.x))+(l9_2190*(l9_2314.y*l9_2187));
N111_position=l9_2315;
N111_normal=l9_2181;
}
else
{
N111_position=N111_positionObjectSpace;
if (N111_ENABLE_CENTER_IN_BBOX)
{
float3 l9_2316=(*sc_set2.UserUniforms).sc_LocalAabbMax;
float3 l9_2317=(*sc_set2.UserUniforms).sc_LocalAabbMin;
float3 l9_2318=(l9_2316+l9_2317)/float3(2.0);
N111_position-=l9_2318;
}
float3 l9_2319=N111_position;
float3 l9_2320=l9_2142;
float l9_2321=l9_1922;
float l9_2322=l9_1923;
float l9_2323=l9_1932;
float l9_2324=N111_sizeSpeed;
float3 l9_2325=N111_sizeStart;
float3 l9_2326=N111_sizeEnd;
float l9_2327=l9_2323;
float l9_2328=l9_2324;
float l9_2329;
if (l9_2327<=0.0)
{
l9_2329=0.0;
}
else
{
l9_2329=pow(l9_2327,l9_2328);
}
float l9_2330=l9_2329;
float l9_2331=l9_2330;
if (N111_ENABLE_SIZEMINMAX)
{
l9_2325=mix(N111_sizeStartMin,N111_sizeStartMax,float3(l9_2321));
l9_2326=mix(N111_sizeEndMin,N111_sizeEndMax,float3(l9_2322));
}
float3 l9_2332=mix(l9_2325,l9_2326,float3(l9_2331));
if (N111_ENABLE_SIZERAMP)
{
float l9_2333=ceil(l9_2323*10000.0)/10000.0;
float2 l9_2334=tempGlobals.Surface_UVCoord0;
float2 l9_2335=(l9_2334/float2(10000.0,1.0))+float2(l9_2333,0.0);
float2 l9_2336=l9_2335;
float4 l9_2337=float4(0.0);
int l9_2338=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_2339=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2339=0;
}
else
{
l9_2339=gl_InstanceIndex%2;
}
int l9_2340=l9_2339;
l9_2338=1-l9_2340;
}
else
{
int l9_2341=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2341=0;
}
else
{
l9_2341=gl_InstanceIndex%2;
}
int l9_2342=l9_2341;
l9_2338=l9_2342;
}
int l9_2343=l9_2338;
int l9_2344=sizeRampTextureLayout_tmp;
int l9_2345=l9_2343;
float2 l9_2346=l9_2336;
bool l9_2347=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_2348=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_2349=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_2350=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_2351=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_2352=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_2353=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_2354=0.0;
bool l9_2355=l9_2352&&(!l9_2350);
float l9_2356=1.0;
float l9_2357=l9_2346.x;
int l9_2358=l9_2349.x;
if (l9_2358==1)
{
l9_2357=fract(l9_2357);
}
else
{
if (l9_2358==2)
{
float l9_2359=fract(l9_2357);
float l9_2360=l9_2357-l9_2359;
float l9_2361=step(0.25,fract(l9_2360*0.5));
l9_2357=mix(l9_2359,1.0-l9_2359,fast::clamp(l9_2361,0.0,1.0));
}
}
l9_2346.x=l9_2357;
float l9_2362=l9_2346.y;
int l9_2363=l9_2349.y;
if (l9_2363==1)
{
l9_2362=fract(l9_2362);
}
else
{
if (l9_2363==2)
{
float l9_2364=fract(l9_2362);
float l9_2365=l9_2362-l9_2364;
float l9_2366=step(0.25,fract(l9_2365*0.5));
l9_2362=mix(l9_2364,1.0-l9_2364,fast::clamp(l9_2366,0.0,1.0));
}
}
l9_2346.y=l9_2362;
if (l9_2350)
{
bool l9_2367=l9_2352;
bool l9_2368;
if (l9_2367)
{
l9_2368=l9_2349.x==3;
}
else
{
l9_2368=l9_2367;
}
float l9_2369=l9_2346.x;
float l9_2370=l9_2351.x;
float l9_2371=l9_2351.z;
bool l9_2372=l9_2368;
float l9_2373=l9_2356;
float l9_2374=fast::clamp(l9_2369,l9_2370,l9_2371);
float l9_2375=step(abs(l9_2369-l9_2374),9.9999997e-06);
l9_2373*=(l9_2375+((1.0-float(l9_2372))*(1.0-l9_2375)));
l9_2369=l9_2374;
l9_2346.x=l9_2369;
l9_2356=l9_2373;
bool l9_2376=l9_2352;
bool l9_2377;
if (l9_2376)
{
l9_2377=l9_2349.y==3;
}
else
{
l9_2377=l9_2376;
}
float l9_2378=l9_2346.y;
float l9_2379=l9_2351.y;
float l9_2380=l9_2351.w;
bool l9_2381=l9_2377;
float l9_2382=l9_2356;
float l9_2383=fast::clamp(l9_2378,l9_2379,l9_2380);
float l9_2384=step(abs(l9_2378-l9_2383),9.9999997e-06);
l9_2382*=(l9_2384+((1.0-float(l9_2381))*(1.0-l9_2384)));
l9_2378=l9_2383;
l9_2346.y=l9_2378;
l9_2356=l9_2382;
}
float2 l9_2385=l9_2346;
bool l9_2386=l9_2347;
float3x3 l9_2387=l9_2348;
if (l9_2386)
{
l9_2385=float2((l9_2387*float3(l9_2385,1.0)).xy);
}
float2 l9_2388=l9_2385;
float2 l9_2389=l9_2388;
float2 l9_2390=l9_2389;
l9_2346=l9_2390;
float l9_2391=l9_2346.x;
int l9_2392=l9_2349.x;
bool l9_2393=l9_2355;
float l9_2394=l9_2356;
if ((l9_2392==0)||(l9_2392==3))
{
float l9_2395=l9_2391;
float l9_2396=0.0;
float l9_2397=1.0;
bool l9_2398=l9_2393;
float l9_2399=l9_2394;
float l9_2400=fast::clamp(l9_2395,l9_2396,l9_2397);
float l9_2401=step(abs(l9_2395-l9_2400),9.9999997e-06);
l9_2399*=(l9_2401+((1.0-float(l9_2398))*(1.0-l9_2401)));
l9_2395=l9_2400;
l9_2391=l9_2395;
l9_2394=l9_2399;
}
l9_2346.x=l9_2391;
l9_2356=l9_2394;
float l9_2402=l9_2346.y;
int l9_2403=l9_2349.y;
bool l9_2404=l9_2355;
float l9_2405=l9_2356;
if ((l9_2403==0)||(l9_2403==3))
{
float l9_2406=l9_2402;
float l9_2407=0.0;
float l9_2408=1.0;
bool l9_2409=l9_2404;
float l9_2410=l9_2405;
float l9_2411=fast::clamp(l9_2406,l9_2407,l9_2408);
float l9_2412=step(abs(l9_2406-l9_2411),9.9999997e-06);
l9_2410*=(l9_2412+((1.0-float(l9_2409))*(1.0-l9_2412)));
l9_2406=l9_2411;
l9_2402=l9_2406;
l9_2405=l9_2410;
}
l9_2346.y=l9_2402;
l9_2356=l9_2405;
float2 l9_2413=l9_2346;
int l9_2414=l9_2344;
int l9_2415=l9_2345;
float l9_2416=l9_2354;
float2 l9_2417=l9_2413;
int l9_2418=l9_2414;
int l9_2419=l9_2415;
float3 l9_2420=float3(0.0);
if (l9_2418==0)
{
l9_2420=float3(l9_2417,0.0);
}
else
{
if (l9_2418==1)
{
l9_2420=float3(l9_2417.x,(l9_2417.y*0.5)+(0.5-(float(l9_2419)*0.5)),0.0);
}
else
{
l9_2420=float3(l9_2417,float(l9_2419));
}
}
float3 l9_2421=l9_2420;
float3 l9_2422=l9_2421;
float2 l9_2423=l9_2422.xy;
float l9_2424=l9_2416;
float4 l9_2425=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_2423,level(l9_2424));
float4 l9_2426=l9_2425;
float4 l9_2427=l9_2426;
if (l9_2352)
{
l9_2427=mix(l9_2353,l9_2427,float4(l9_2356));
}
float4 l9_2428=l9_2427;
l9_2337=l9_2428;
float4 l9_2429=l9_2337;
float3 l9_2430=l9_2429.xyz;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_2430=float3(1.0);
}
l9_2332=l9_2430*l9_2325;
}
float3 l9_2431=l9_2332;
N111_position=(l9_2319*l9_2320)*l9_2431;
if ((N111_dieTrigger<0.5)||(l9_2169<0.5))
{
N111_position.x=2.1474836e+09;
}
float3x3 l9_2432;
if (((N111_ENABLE_ALIGNTOVEL||N111_ENABLE_ALIGNTOX)||N111_ENABLE_ALIGNTOY)||N111_ENABLE_ALIGNTOZ)
{
if (N111_ENABLE_ALIGNTOZ)
{
l9_2432=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
}
else
{
float3 l9_2433=float3(0.0);
if (N111_ENABLE_ALIGNTOX)
{
l9_2433=float3(1.0,0.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_2433=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOVEL)
{
float l9_2434=0.001;
float3 l9_2435=l9_2021;
float l9_2436=l9_1931-l9_2434;
float3 l9_2437=N111_velocityDrag;
float3 l9_2438=l9_1937;
float l9_2439=l9_1932-l9_2434;
float3 l9_2440=float3(l9_2436,l9_2436,l9_2436);
float3 l9_2441=l9_2437;
float l9_2442;
if (l9_2440.x<=0.0)
{
l9_2442=0.0;
}
else
{
l9_2442=pow(l9_2440.x,l9_2441.x);
}
float l9_2443=l9_2442;
float l9_2444;
if (l9_2440.y<=0.0)
{
l9_2444=0.0;
}
else
{
l9_2444=pow(l9_2440.y,l9_2441.y);
}
float l9_2445=l9_2444;
float l9_2446;
if (l9_2440.z<=0.0)
{
l9_2446=0.0;
}
else
{
l9_2446=pow(l9_2440.z,l9_2441.z);
}
float3 l9_2447=float3(l9_2443,l9_2445,l9_2446);
float3 l9_2448=l9_2447;
float3 l9_2449=(l9_2435+l9_2438)*l9_2448;
if (N111_ENABLE_VELRAMP)
{
float l9_2450=floor(l9_2439*10000.0)/10000.0;
float2 l9_2451=tempGlobals.Surface_UVCoord0;
float2 l9_2452=(l9_2451/float2(10000.0,1.0))+float2(l9_2450,0.0);
float2 l9_2453=l9_2452;
float4 l9_2454=float4(0.0);
int l9_2455=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_2456=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2456=0;
}
else
{
l9_2456=gl_InstanceIndex%2;
}
int l9_2457=l9_2456;
l9_2455=1-l9_2457;
}
else
{
int l9_2458=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2458=0;
}
else
{
l9_2458=gl_InstanceIndex%2;
}
int l9_2459=l9_2458;
l9_2455=l9_2459;
}
int l9_2460=l9_2455;
int l9_2461=velRampTextureLayout_tmp;
int l9_2462=l9_2460;
float2 l9_2463=l9_2453;
bool l9_2464=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_2465=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_2466=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_2467=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_2468=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_2469=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_2470=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_2471=0.0;
bool l9_2472=l9_2469&&(!l9_2467);
float l9_2473=1.0;
float l9_2474=l9_2463.x;
int l9_2475=l9_2466.x;
if (l9_2475==1)
{
l9_2474=fract(l9_2474);
}
else
{
if (l9_2475==2)
{
float l9_2476=fract(l9_2474);
float l9_2477=l9_2474-l9_2476;
float l9_2478=step(0.25,fract(l9_2477*0.5));
l9_2474=mix(l9_2476,1.0-l9_2476,fast::clamp(l9_2478,0.0,1.0));
}
}
l9_2463.x=l9_2474;
float l9_2479=l9_2463.y;
int l9_2480=l9_2466.y;
if (l9_2480==1)
{
l9_2479=fract(l9_2479);
}
else
{
if (l9_2480==2)
{
float l9_2481=fract(l9_2479);
float l9_2482=l9_2479-l9_2481;
float l9_2483=step(0.25,fract(l9_2482*0.5));
l9_2479=mix(l9_2481,1.0-l9_2481,fast::clamp(l9_2483,0.0,1.0));
}
}
l9_2463.y=l9_2479;
if (l9_2467)
{
bool l9_2484=l9_2469;
bool l9_2485;
if (l9_2484)
{
l9_2485=l9_2466.x==3;
}
else
{
l9_2485=l9_2484;
}
float l9_2486=l9_2463.x;
float l9_2487=l9_2468.x;
float l9_2488=l9_2468.z;
bool l9_2489=l9_2485;
float l9_2490=l9_2473;
float l9_2491=fast::clamp(l9_2486,l9_2487,l9_2488);
float l9_2492=step(abs(l9_2486-l9_2491),9.9999997e-06);
l9_2490*=(l9_2492+((1.0-float(l9_2489))*(1.0-l9_2492)));
l9_2486=l9_2491;
l9_2463.x=l9_2486;
l9_2473=l9_2490;
bool l9_2493=l9_2469;
bool l9_2494;
if (l9_2493)
{
l9_2494=l9_2466.y==3;
}
else
{
l9_2494=l9_2493;
}
float l9_2495=l9_2463.y;
float l9_2496=l9_2468.y;
float l9_2497=l9_2468.w;
bool l9_2498=l9_2494;
float l9_2499=l9_2473;
float l9_2500=fast::clamp(l9_2495,l9_2496,l9_2497);
float l9_2501=step(abs(l9_2495-l9_2500),9.9999997e-06);
l9_2499*=(l9_2501+((1.0-float(l9_2498))*(1.0-l9_2501)));
l9_2495=l9_2500;
l9_2463.y=l9_2495;
l9_2473=l9_2499;
}
float2 l9_2502=l9_2463;
bool l9_2503=l9_2464;
float3x3 l9_2504=l9_2465;
if (l9_2503)
{
l9_2502=float2((l9_2504*float3(l9_2502,1.0)).xy);
}
float2 l9_2505=l9_2502;
float2 l9_2506=l9_2505;
float2 l9_2507=l9_2506;
l9_2463=l9_2507;
float l9_2508=l9_2463.x;
int l9_2509=l9_2466.x;
bool l9_2510=l9_2472;
float l9_2511=l9_2473;
if ((l9_2509==0)||(l9_2509==3))
{
float l9_2512=l9_2508;
float l9_2513=0.0;
float l9_2514=1.0;
bool l9_2515=l9_2510;
float l9_2516=l9_2511;
float l9_2517=fast::clamp(l9_2512,l9_2513,l9_2514);
float l9_2518=step(abs(l9_2512-l9_2517),9.9999997e-06);
l9_2516*=(l9_2518+((1.0-float(l9_2515))*(1.0-l9_2518)));
l9_2512=l9_2517;
l9_2508=l9_2512;
l9_2511=l9_2516;
}
l9_2463.x=l9_2508;
l9_2473=l9_2511;
float l9_2519=l9_2463.y;
int l9_2520=l9_2466.y;
bool l9_2521=l9_2472;
float l9_2522=l9_2473;
if ((l9_2520==0)||(l9_2520==3))
{
float l9_2523=l9_2519;
float l9_2524=0.0;
float l9_2525=1.0;
bool l9_2526=l9_2521;
float l9_2527=l9_2522;
float l9_2528=fast::clamp(l9_2523,l9_2524,l9_2525);
float l9_2529=step(abs(l9_2523-l9_2528),9.9999997e-06);
l9_2527*=(l9_2529+((1.0-float(l9_2526))*(1.0-l9_2529)));
l9_2523=l9_2528;
l9_2519=l9_2523;
l9_2522=l9_2527;
}
l9_2463.y=l9_2519;
l9_2473=l9_2522;
float2 l9_2530=l9_2463;
int l9_2531=l9_2461;
int l9_2532=l9_2462;
float l9_2533=l9_2471;
float2 l9_2534=l9_2530;
int l9_2535=l9_2531;
int l9_2536=l9_2532;
float3 l9_2537=float3(0.0);
if (l9_2535==0)
{
l9_2537=float3(l9_2534,0.0);
}
else
{
if (l9_2535==1)
{
l9_2537=float3(l9_2534.x,(l9_2534.y*0.5)+(0.5-(float(l9_2536)*0.5)),0.0);
}
else
{
l9_2537=float3(l9_2534,float(l9_2536));
}
}
float3 l9_2538=l9_2537;
float3 l9_2539=l9_2538;
float2 l9_2540=l9_2539.xy;
float l9_2541=l9_2533;
float4 l9_2542=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_2540,level(l9_2541));
float4 l9_2543=l9_2542;
float4 l9_2544=l9_2543;
if (l9_2469)
{
l9_2544=mix(l9_2470,l9_2544,float4(l9_2473));
}
float4 l9_2545=l9_2544;
l9_2454=l9_2545;
float4 l9_2546=l9_2454;
float3 l9_2547=l9_2546.xyz;
l9_2449=(l9_2435+l9_2438)*l9_2547;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_2449=l9_2435*l9_2448;
}
}
float3 l9_2548=l9_2449;
float3 l9_2549=l9_2548;
float l9_2550=((N111_gravity/2.0)*(l9_1931-l9_2434))*(l9_1931-l9_2434);
l9_2018.y-=l9_2550;
if (N111_ENABLE_FORCE)
{
float3 l9_2551=float3(((N111_localForce/float3(2.0))*(l9_1931-l9_2434))*(l9_1931-l9_2434));
l9_2019-=l9_2551;
}
if (N111_WORLDFORCE)
{
float4x4 l9_2552=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_2553=l9_2552;
float4 l9_2554=l9_2553[0];
float4 l9_2555=l9_2553[1];
float4 l9_2556=l9_2553[2];
float3x3 l9_2557=float3x3(float3(float3(l9_2554.x,l9_2555.x,l9_2556.x)),float3(float3(l9_2554.y,l9_2555.y,l9_2556.y)),float3(float3(l9_2554.z,l9_2555.z,l9_2556.z)));
float3x3 l9_2558=l9_2557;
l9_2433=(((l9_2020-l9_2549)*l9_2558)+l9_2018)+l9_2019;
}
else
{
if (N111_WORLDSPACE)
{
l9_2433=((l9_2020-l9_2549)+l9_2018)+l9_2019;
}
else
{
float4x4 l9_2559=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_2560=l9_2559;
float4 l9_2561=l9_2560[0];
float4 l9_2562=l9_2560[1];
float4 l9_2563=l9_2560[2];
float3x3 l9_2564=float3x3(float3(float3(l9_2561.x,l9_2562.x,l9_2563.x)),float3(float3(l9_2561.y,l9_2562.y,l9_2563.y)),float3(float3(l9_2561.z,l9_2562.z,l9_2563.z)));
float3x3 l9_2565=l9_2564;
l9_2433=(((l9_2020-l9_2549)+l9_2019)+l9_2018)*l9_2565;
}
}
l9_2433=normalize(l9_2433+float3(N111_EPSILON));
}
float3 l9_2566=float3(0.0,0.0,1.0);
float3 l9_2567=cross(l9_2433,l9_2566);
float3 l9_2568=normalize(l9_2567);
float l9_2569=length(l9_2567);
float l9_2570=dot(l9_2566,l9_2433);
float l9_2571=1.0-l9_2570;
l9_2432=float3x3(float3(((l9_2571*l9_2568.x)*l9_2568.x)+l9_2570,((l9_2571*l9_2568.x)*l9_2568.y)-(l9_2568.z*l9_2569),((l9_2571*l9_2568.z)*l9_2568.x)+(l9_2568.y*l9_2569)),float3(((l9_2571*l9_2568.x)*l9_2568.y)+(l9_2568.z*l9_2569),((l9_2571*l9_2568.y)*l9_2568.y)+l9_2570,((l9_2571*l9_2568.y)*l9_2568.z)-(l9_2568.x*l9_2569)),float3(((l9_2571*l9_2568.z)*l9_2568.x)-(l9_2568.y*l9_2569),((l9_2571*l9_2568.y)*l9_2568.z)+(l9_2568.x*l9_2569),((l9_2571*l9_2568.z)*l9_2568.z)+l9_2570));
}
float3x3 l9_2572=float3x3(float3(cos(l9_2168),-sin(l9_2168),0.0),float3(sin(l9_2168),cos(l9_2168),0.0),float3(0.0,0.0,1.0));
l9_2432=l9_2432*l9_2572;
if (N111_ENABLE_ALIGNTOVEL&&(!N111_ENABLE_IGNOREVEL))
{
float3 l9_2573=l9_2150*(l9_1931-0.0099999998);
float3 l9_2574=l9_2150*(l9_1931+0.0099999998);
N111_position.z*=(length(l9_2574-l9_2573)*fast::max(N111_sizeVelScale,0.1));
}
}
else
{
float l9_2575=fract((N111_particleSeed.x*92.653008)+N111_globalSeed);
float l9_2576=mix(N111_rotationRandomX.x,N111_rotationRandomX.y,l9_2575);
float l9_2577=mix(N111_rotationRateX.x,N111_rotationRateX.y,l9_2575);
float l9_2578=((l9_2577*l9_2165)*l9_1932)*2.0;
float l9_2579=fract((N111_particleSeed.y*6.7557559)+N111_globalSeed);
float l9_2580=mix(N111_rotationRandomY.x,N111_rotationRandomY.y,l9_2579);
float l9_2581=mix(N111_rotationRateY.x,N111_rotationRateY.y,l9_2579);
float l9_2582=((l9_2581*l9_2165)*l9_1932)*2.0;
float l9_2583=N111_PI*(l9_2578+l9_2576);
float l9_2584=N111_PI*(l9_2582+l9_2580);
float l9_2585=N111_PI*(l9_2167+l9_2160);
float3 l9_2586=float3(l9_2583,l9_2584,l9_2585);
float l9_2587=cos(l9_2586.x);
float l9_2588=sin(l9_2586.x);
float l9_2589=cos(l9_2586.y);
float l9_2590=sin(l9_2586.y);
float l9_2591=cos(l9_2586.z);
float l9_2592=sin(l9_2586.z);
l9_2432=float3x3(float3(l9_2589*l9_2591,(l9_2587*l9_2592)+((l9_2588*l9_2590)*l9_2591),(l9_2588*l9_2592)-((l9_2587*l9_2590)*l9_2591)),float3((-l9_2589)*l9_2592,(l9_2587*l9_2591)-((l9_2588*l9_2590)*l9_2592),(l9_2588*l9_2591)+((l9_2587*l9_2590)*l9_2592)),float3(l9_2590,(-l9_2588)*l9_2589,l9_2587*l9_2589));
}
if ((!N111_WORLDSPACE)&&(!N111_ENABLE_ALIGNTOVEL))
{
float4x4 l9_2593=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_2594=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_2595=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3x3 l9_2596=float3x3(float3(l9_2593[0].xyz/float3(l9_2142.x)),float3(l9_2594[1].xyz/float3(l9_2142.y)),float3(l9_2595[2].xyz/float3(l9_2142.z)));
l9_2432=l9_2596*l9_2432;
}
N111_position=l9_2432*N111_position;
N111_normal=normalize(l9_2432*N111_normalObjectSpace);
N111_position+=l9_2159;
}
N111_timeValues=float4(l9_1930,l9_1931,l9_1932);
l9_1908=N111_nearCameraFade;
l9_1867=l9_1908;
l9_1677=l9_1867;
out.Interpolator0.x=l9_1677;
ssGlobals param_241=Globals;
float4 l9_2597=float4(0.0);
float l9_2598=0.0;
float l9_2599=(*sc_set2.UserUniforms).timeGlobal;
l9_2598=l9_2599;
float l9_2600=0.0;
float l9_2601=(*sc_set2.UserUniforms).externalTimeInput;
l9_2600=l9_2601;
float l9_2602=0.0;
float l9_2603=(*sc_set2.UserUniforms).externalSeed;
l9_2602=l9_2603;
float l9_2604=0.0;
float l9_2605=(*sc_set2.UserUniforms).lifeTimeConstant;
l9_2604=l9_2605;
float2 l9_2606=float2(0.0);
float2 l9_2607=(*sc_set2.UserUniforms).lifeTimeMinMax;
l9_2606=l9_2607;
float l9_2608=0.0;
float l9_2609=(*sc_set2.UserUniforms).spawnDuration;
l9_2608=l9_2609;
float3 l9_2610=float3(0.0);
float l9_2611=0.0;
float l9_2612=0.0;
float4 l9_2613=float4(0.0);
float l9_2614=l9_2598;
float l9_2615=l9_2600;
float l9_2616=l9_2602;
float l9_2617=l9_2604;
float2 l9_2618=l9_2606;
float l9_2619=l9_2608;
ssGlobals l9_2620=param_241;
tempGlobals=l9_2620;
float3 l9_2621=float3(0.0);
float l9_2622=0.0;
float l9_2623=0.0;
float4 l9_2624=float4(0.0);
N173_timeGlobal=l9_2614;
N173_ENABLE_EXTERNALTIME=(int(EXTERNALTIME_tmp)!=0);
N173_externalTime=l9_2615;
N173_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N173_externalSeed=l9_2616;
N173_ENABLE_LIFETIMEMINMAX=(int(LIFETIMEMINMAX_tmp)!=0);
N173_lifeTimeConstant=l9_2617;
N173_lifeTimeMinMax=l9_2618;
N173_ENABLE_INSTANTSPAWN=(int(INSTANTSPAWN_tmp)!=0);
N173_spawnDuration=l9_2619;
float l9_2625=0.0;
if (N173_ENABLE_WORLDPOSSEED)
{
float4x4 l9_2626=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_2625=length(float4(1.0)*l9_2626);
}
N173_globalSeed=N173_externalSeed+l9_2625;
float l9_2627=2000.0;
int l9_2628=0;
int l9_2629=gl_InstanceIndex;
l9_2628=l9_2629;
int l9_2630=l9_2628;
float l9_2631=float(l9_2630);
float2 l9_2632=float2(mod(l9_2631,l9_2627),floor(l9_2631/l9_2627));
l9_2632/=float2(l9_2627);
float2 l9_2633=l9_2632;
float l9_2634=dot(l9_2633,float2(0.38253,0.42662001));
float3 l9_2635=float3(0.457831,0.62343299,0.97625297)*l9_2634;
l9_2635=sin(l9_2635)*float3(479.371,389.53101,513.03497);
l9_2635=fract(l9_2635);
l9_2635=floor(l9_2635*10000.0)*9.9999997e-05;
float3 l9_2636=l9_2635;
float3 l9_2637=l9_2636;
N173_particleSeed=l9_2637;
float l9_2638=fract((N173_particleSeed.y*12.12358)+N173_globalSeed);
float l9_2639=fract((N173_particleSeed.z*3.5358)+N173_globalSeed);
float2 l9_2640=float2(N173_lifeTimeConstant);
if (N173_ENABLE_LIFETIMEMINMAX)
{
l9_2640=N173_lifeTimeMinMax;
}
float l9_2641=fast::max(l9_2640.x,0.0099999998);
float l9_2642=fast::max(l9_2640.y,0.0099999998);
float l9_2643=tempGlobals.gTimeElapsed;
float l9_2644=l9_2643;
if (N173_ENABLE_EXTERNALTIME)
{
l9_2644=N173_externalTime;
}
float l9_2645=l9_2644;
if (N173_ENABLE_INSTANTSPAWN)
{
l9_2645=N173_timeGlobal*l9_2644;
}
else
{
float l9_2646=fract(((l9_2644*N173_timeGlobal)*(1.0/l9_2640.y))+l9_2638);
l9_2645=l9_2646*l9_2640.y;
}
float l9_2647=mix(l9_2645/l9_2641,l9_2645/l9_2642,l9_2639);
float l9_2648=fast::clamp(l9_2647,0.0,1.0);
float l9_2649=0.0;
if (!N173_ENABLE_INSTANTSPAWN)
{
if (N173_spawnDuration>0.0)
{
if ((l9_2644-N173_spawnDuration)>=l9_2645)
{
l9_2649=1.0;
}
}
}
float l9_2650=l9_2647+l9_2649;
N173_dieTrigger=1.0;
if (l9_2650>0.99989998)
{
N173_dieTrigger=0.0;
}
N173_timeValues=float4(l9_2640,l9_2645,l9_2648);
l9_2621=N173_particleSeed;
l9_2622=N173_globalSeed;
l9_2623=N173_dieTrigger;
l9_2624=N173_timeValues;
l9_2610=l9_2621;
l9_2611=l9_2622;
l9_2612=l9_2623;
l9_2613=l9_2624;
float3 l9_2651=float3(0.0);
l9_2651=param_241.SurfacePosition_ObjectSpace;
float3 l9_2652=float3(0.0);
l9_2652=param_241.VertexNormal_ObjectSpace;
float3 l9_2653=float3(0.0);
float3 l9_2654=(*sc_set2.UserUniforms).spawnLocation;
l9_2653=l9_2654;
float3 l9_2655=float3(0.0);
float3 l9_2656=(*sc_set2.UserUniforms).spawnBox;
l9_2655=l9_2656;
float3 l9_2657=float3(0.0);
float3 l9_2658=(*sc_set2.UserUniforms).spawnSphere;
l9_2657=l9_2658;
float3 l9_2659=float3(0.0);
float3 l9_2660=(*sc_set2.UserUniforms).noiseMult;
l9_2659=l9_2660;
float3 l9_2661=float3(0.0);
float3 l9_2662=(*sc_set2.UserUniforms).noiseFrequency;
l9_2661=l9_2662;
float3 l9_2663=float3(0.0);
float3 l9_2664=(*sc_set2.UserUniforms).sNoiseMult;
l9_2663=l9_2664;
float3 l9_2665=float3(0.0);
float3 l9_2666=(*sc_set2.UserUniforms).sNoiseFrequency;
l9_2665=l9_2666;
float3 l9_2667=float3(0.0);
float3 l9_2668=(*sc_set2.UserUniforms).velocityMin;
l9_2667=l9_2668;
float3 l9_2669=float3(0.0);
float3 l9_2670=(*sc_set2.UserUniforms).velocityMax;
l9_2669=l9_2670;
float3 l9_2671=float3(0.0);
float3 l9_2672=(*sc_set2.UserUniforms).velocityDrag;
l9_2671=l9_2672;
float3 l9_2673=float3(0.0);
float3 l9_2674=float3(0.0);
float3 l9_2675=float3(0.0);
float3 l9_2676;
if (MESHTYPE_tmp==0)
{
float2 l9_2677=float2(0.0);
float2 l9_2678=(*sc_set2.UserUniforms).sizeStart;
l9_2677=l9_2678;
l9_2674=float3(l9_2677,0.0);
l9_2676=l9_2674;
}
else
{
float3 l9_2679=float3(0.0);
float3 l9_2680=(*sc_set2.UserUniforms).sizeStart3D;
l9_2679=l9_2680;
l9_2675=l9_2679;
l9_2676=l9_2675;
}
l9_2673=l9_2676;
float3 l9_2681=float3(0.0);
float3 l9_2682=float3(0.0);
float3 l9_2683=float3(0.0);
float3 l9_2684;
if (MESHTYPE_tmp==0)
{
float2 l9_2685=float2(0.0);
float2 l9_2686=(*sc_set2.UserUniforms).sizeEnd;
l9_2685=l9_2686;
l9_2682=float3(l9_2685,0.0);
l9_2684=l9_2682;
}
else
{
float3 l9_2687=float3(0.0);
float3 l9_2688=(*sc_set2.UserUniforms).sizeEnd3D;
l9_2687=l9_2688;
l9_2683=l9_2687;
l9_2684=l9_2683;
}
l9_2681=l9_2684;
float3 l9_2689=float3(0.0);
float3 l9_2690=float3(0.0);
float3 l9_2691=float3(0.0);
float3 l9_2692;
if (MESHTYPE_tmp==0)
{
float2 l9_2693=float2(0.0);
float2 l9_2694=(*sc_set2.UserUniforms).sizeStartMin;
l9_2693=l9_2694;
l9_2690=float3(l9_2693,0.0);
l9_2692=l9_2690;
}
else
{
float3 l9_2695=float3(0.0);
float3 l9_2696=(*sc_set2.UserUniforms).sizeStartMin3D;
l9_2695=l9_2696;
l9_2691=l9_2695;
l9_2692=l9_2691;
}
l9_2689=l9_2692;
float3 l9_2697=float3(0.0);
float3 l9_2698=float3(0.0);
float3 l9_2699=float3(0.0);
float3 l9_2700;
if (MESHTYPE_tmp==0)
{
float2 l9_2701=float2(0.0);
float2 l9_2702=(*sc_set2.UserUniforms).sizeStartMax;
l9_2701=l9_2702;
l9_2698=float3(l9_2701,0.0);
l9_2700=l9_2698;
}
else
{
float3 l9_2703=float3(0.0);
float3 l9_2704=(*sc_set2.UserUniforms).sizeStartMax3D;
l9_2703=l9_2704;
l9_2699=l9_2703;
l9_2700=l9_2699;
}
l9_2697=l9_2700;
float3 l9_2705=float3(0.0);
float3 l9_2706=float3(0.0);
float3 l9_2707=float3(0.0);
float3 l9_2708;
if (MESHTYPE_tmp==0)
{
float2 l9_2709=float2(0.0);
float2 l9_2710=(*sc_set2.UserUniforms).sizeEndMin;
l9_2709=l9_2710;
l9_2706=float3(l9_2709,0.0);
l9_2708=l9_2706;
}
else
{
float3 l9_2711=float3(0.0);
float3 l9_2712=(*sc_set2.UserUniforms).sizeEndMin3D;
l9_2711=l9_2712;
l9_2707=l9_2711;
l9_2708=l9_2707;
}
l9_2705=l9_2708;
float3 l9_2713=float3(0.0);
float3 l9_2714=float3(0.0);
float3 l9_2715=float3(0.0);
float3 l9_2716;
if (MESHTYPE_tmp==0)
{
float2 l9_2717=float2(0.0);
float2 l9_2718=(*sc_set2.UserUniforms).sizeEndMax;
l9_2717=l9_2718;
l9_2714=float3(l9_2717,0.0);
l9_2716=l9_2714;
}
else
{
float3 l9_2719=float3(0.0);
float3 l9_2720=(*sc_set2.UserUniforms).sizeEndMax3D;
l9_2719=l9_2720;
l9_2715=l9_2719;
l9_2716=l9_2715;
}
l9_2713=l9_2716;
float l9_2721=0.0;
float l9_2722=(*sc_set2.UserUniforms).sizeSpeed;
l9_2721=l9_2722;
float l9_2723=0.0;
float l9_2724=(*sc_set2.UserUniforms).gravity;
l9_2723=l9_2724;
float3 l9_2725=float3(0.0);
float3 l9_2726=(*sc_set2.UserUniforms).localForce;
l9_2725=l9_2726;
float l9_2727=0.0;
float l9_2728=(*sc_set2.UserUniforms).sizeVelScale;
l9_2727=l9_2728;
float l9_2729=0.0;
float l9_2730=float((*sc_set2.UserUniforms).ALIGNTOX!=0);
l9_2729=l9_2730;
float l9_2731=0.0;
float l9_2732=float((*sc_set2.UserUniforms).ALIGNTOY!=0);
l9_2731=l9_2732;
float l9_2733=0.0;
float l9_2734=float((*sc_set2.UserUniforms).ALIGNTOZ!=0);
l9_2733=l9_2734;
float2 l9_2735=float2(0.0);
float2 l9_2736=(*sc_set2.UserUniforms).Port_Input1_N138;
float2 l9_2737=float2(0.0);
float2 l9_2738;
if (MESHTYPE_tmp==0)
{
l9_2738=l9_2736;
}
else
{
float2 l9_2739=float2(0.0);
float2 l9_2740=(*sc_set2.UserUniforms).rotationRandomX;
l9_2739=l9_2740;
l9_2737=l9_2739;
l9_2738=l9_2737;
}
l9_2735=l9_2738;
float2 l9_2741=float2(0.0);
float2 l9_2742=(*sc_set2.UserUniforms).Port_Input1_N139;
float2 l9_2743=float2(0.0);
float2 l9_2744;
if (MESHTYPE_tmp==0)
{
l9_2744=l9_2742;
}
else
{
float2 l9_2745=float2(0.0);
float2 l9_2746=(*sc_set2.UserUniforms).rotationRateX;
l9_2745=l9_2746;
l9_2743=l9_2745;
l9_2744=l9_2743;
}
l9_2741=l9_2744;
float2 l9_2747=float2(0.0);
float2 l9_2748=(*sc_set2.UserUniforms).Port_Input1_N140;
float2 l9_2749=float2(0.0);
float2 l9_2750;
if (MESHTYPE_tmp==0)
{
l9_2750=l9_2748;
}
else
{
float2 l9_2751=float2(0.0);
float2 l9_2752=(*sc_set2.UserUniforms).randomRotationY;
l9_2751=l9_2752;
l9_2749=l9_2751;
l9_2750=l9_2749;
}
l9_2747=l9_2750;
float2 l9_2753=float2(0.0);
float2 l9_2754=(*sc_set2.UserUniforms).Port_Input1_N144;
float2 l9_2755=float2(0.0);
float2 l9_2756;
if (MESHTYPE_tmp==0)
{
l9_2756=l9_2754;
}
else
{
float2 l9_2757=float2(0.0);
float2 l9_2758=(*sc_set2.UserUniforms).rotationRateY;
l9_2757=l9_2758;
l9_2755=l9_2757;
l9_2756=l9_2755;
}
l9_2753=l9_2756;
float2 l9_2759=float2(0.0);
float2 l9_2760=float2(1.0);
float2 l9_2761=float2(0.0);
float2 l9_2762;
if (MESHTYPE_tmp==0)
{
float2 l9_2763=float2(0.0);
float2 l9_2764=(*sc_set2.UserUniforms).rotationRandom;
l9_2763=l9_2764;
l9_2760=l9_2763;
l9_2762=l9_2760;
}
else
{
float2 l9_2765=float2(0.0);
float2 l9_2766=(*sc_set2.UserUniforms).randomRotationZ;
l9_2765=l9_2766;
l9_2761=l9_2765;
l9_2762=l9_2761;
}
l9_2759=l9_2762;
float2 l9_2767=float2(0.0);
float2 l9_2768=float2(1.0);
float2 l9_2769=float2(0.0);
float2 l9_2770;
if (MESHTYPE_tmp==0)
{
float2 l9_2771=float2(0.0);
float2 l9_2772=(*sc_set2.UserUniforms).rotationRate;
l9_2771=l9_2772;
l9_2768=l9_2771;
l9_2770=l9_2768;
}
else
{
float2 l9_2773=float2(0.0);
float2 l9_2774=(*sc_set2.UserUniforms).rotationRateZ;
l9_2773=l9_2774;
l9_2769=l9_2773;
l9_2770=l9_2769;
}
l9_2767=l9_2770;
float l9_2775=0.0;
float l9_2776=(*sc_set2.UserUniforms).rotationDrag;
l9_2775=l9_2776;
float l9_2777=0.0;
float l9_2778=(*sc_set2.UserUniforms).Port_Input1_N110;
float l9_2779=0.0;
float l9_2780;
if (MESHTYPE_tmp==0)
{
l9_2780=l9_2778;
}
else
{
float l9_2781=0.0;
float l9_2782=float((*sc_set2.UserUniforms).CENTER_BBOX!=0);
l9_2781=l9_2782;
l9_2779=l9_2781;
l9_2780=l9_2779;
}
l9_2777=l9_2780;
float l9_2783=0.0;
float l9_2784=(*sc_set2.UserUniforms).fadeDistanceVisible;
l9_2783=l9_2784;
float l9_2785=0.0;
float l9_2786=(*sc_set2.UserUniforms).fadeDistanceInvisible;
l9_2785=l9_2786;
float4 l9_2787=float4(0.0);
float3 l9_2788=l9_2610;
float l9_2789=l9_2611;
float l9_2790=l9_2612;
float4 l9_2791=l9_2613;
float3 l9_2792=l9_2651;
float3 l9_2793=l9_2652;
float3 l9_2794=l9_2653;
float3 l9_2795=l9_2655;
float3 l9_2796=l9_2657;
float3 l9_2797=l9_2659;
float3 l9_2798=l9_2661;
float3 l9_2799=l9_2663;
float3 l9_2800=l9_2665;
float3 l9_2801=l9_2667;
float3 l9_2802=l9_2669;
float3 l9_2803=l9_2671;
float3 l9_2804=l9_2673;
float3 l9_2805=l9_2681;
float3 l9_2806=l9_2689;
float3 l9_2807=l9_2697;
float3 l9_2808=l9_2705;
float3 l9_2809=l9_2713;
float l9_2810=l9_2721;
float l9_2811=l9_2723;
float3 l9_2812=l9_2725;
float l9_2813=l9_2727;
float l9_2814=l9_2729;
float l9_2815=l9_2731;
float l9_2816=l9_2733;
float2 l9_2817=l9_2735;
float2 l9_2818=l9_2741;
float2 l9_2819=l9_2747;
float2 l9_2820=l9_2753;
float2 l9_2821=l9_2759;
float2 l9_2822=l9_2767;
float l9_2823=l9_2775;
float l9_2824=l9_2777;
float l9_2825=l9_2783;
float l9_2826=l9_2785;
ssGlobals l9_2827=param_241;
tempGlobals=l9_2827;
float4 l9_2828=float4(0.0);
N111_MESHTYPE_QUAD=MESHTYPE_tmp==0;
N111_particleSeedIn=l9_2788;
N111_globalSeedIn=l9_2789;
N111_dieTrigger=l9_2790;
N111_timeValuesIn=l9_2791;
N111_positionObjectSpace=l9_2792;
N111_normalObjectSpace=l9_2793;
N111_ENABLE_INILOCATION=(int(INILOCATION_tmp)!=0);
N111_spawnLocation=l9_2794;
N111_ENABLE_BOXSPAWN=(int(BOXSPAWN_tmp)!=0);
N111_spawnBox=l9_2795;
N111_ENABLE_SPHERESPAWN=(int(SPHERESPAWN_tmp)!=0);
N111_spawnSphere=l9_2796;
N111_ENABLE_NOISE=(int(NOISE_tmp)!=0);
N111_noiseMult=l9_2797;
N111_noiseFrequency=l9_2798;
N111_ENABLE_SNOISE=(int(SNOISE_tmp)!=0);
N111_sNoiseMult=l9_2799;
N111_sNoiseFrequency=l9_2800;
N111_ENABLE_VELRAMP=(int(VELRAMP_tmp)!=0);
N111_velocityMin=l9_2801;
N111_velocityMax=l9_2802;
N111_velocityDrag=l9_2803;
N111_sizeStart=l9_2804;
N111_sizeEnd=l9_2805;
N111_ENABLE_SIZEMINMAX=(int(SIZEMINMAX_tmp)!=0);
N111_sizeStartMin=l9_2806;
N111_sizeStartMax=l9_2807;
N111_sizeEndMin=l9_2808;
N111_sizeEndMax=l9_2809;
N111_sizeSpeed=l9_2810;
N111_ENABLE_SIZERAMP=(int(SIZERAMP_tmp)!=0);
N111_gravity=l9_2811;
N111_ENABLE_FORCE=(int(FORCE_tmp)!=0);
N111_localForce=l9_2812;
N111_ENABLE_ALIGNTOVEL=(int(VELOCITYDIR_tmp)!=0);
N111_sizeVelScale=l9_2813;
N111_ENABLE_IGNOREVEL=(int(IGNOREVEL_tmp)!=0);
N111_ENABLE_IGNORETRANSFORMSCALE=(int(IGNORETRANSFORMSCALE_tmp)!=0);
N111_ENABLE_ALIGNTOX=l9_2814!=0.0;
N111_ENABLE_ALIGNTOY=l9_2815!=0.0;
N111_ENABLE_ALIGNTOZ=l9_2816!=0.0;
N111_rotationRandomX=l9_2817;
N111_rotationRateX=l9_2818;
N111_rotationRandomY=l9_2819;
N111_rotationRateY=l9_2820;
N111_rotationRandomZ=l9_2821;
N111_rotationRateZ=l9_2822;
N111_rotationDrag=l9_2823;
N111_WORLDSPACE=rotationSpace_tmp==1;
N111_WORLDFORCE=rotationSpace_tmp==2;
N111_ENABLE_CENTER_IN_BBOX=l9_2824!=0.0;
N111_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N111_fadeDistanceVisible=l9_2825;
N111_fadeDistanceInvisible=l9_2826;
float3 l9_2829=float3(0.0);
N111_particleSeed=N111_particleSeedIn;
N111_globalSeed=N111_globalSeedIn;
float l9_2830=N111_particleSeed.x;
float l9_2831=N111_particleSeed.y;
float l9_2832=N111_particleSeed.z;
float3 l9_2833=fract((float3(l9_2830,l9_2831,l9_2832)*3048.28)+float3(N111_globalSeed))-float3(0.5);
float3 l9_2834=fract((N111_particleSeed*374.57129)+float3(N111_globalSeed))-float3(0.5);
float3 l9_2835=normalize(l9_2834+float3(N111_EPSILON));
float l9_2836=fract(N111_particleSeed.x+N111_globalSeed);
float l9_2837=l9_2836;
float l9_2838=0.33333334;
float l9_2839;
if (l9_2837<=0.0)
{
l9_2839=0.0;
}
else
{
l9_2839=pow(l9_2837,l9_2838);
}
float l9_2840=l9_2839;
float l9_2841=l9_2840;
l9_2835*=l9_2841;
l9_2835/=float3(2.0);
float l9_2842=fract((N111_particleSeed.x*334.59122)+N111_globalSeed)-0.5;
float l9_2843=fract((N111_particleSeed.y*41.231232)+N111_globalSeed)-0.5;
float l9_2844=fract((N111_particleSeed.z*18.984529)+N111_globalSeed);
float l9_2845=fract((N111_particleSeed.x*654.15588)+N111_globalSeed);
float l9_2846=fract((N111_particleSeed.y*45.722408)+N111_globalSeed);
float3 l9_2847=(float3(l9_2845,l9_2846,l9_2844)-float3(0.5))*2.0;
float3 l9_2848=float3(l9_2845,l9_2846,l9_2844);
float l9_2849=fract((N111_particleSeed.z*15.32451)+N111_globalSeed);
float2 l9_2850=N111_timeValuesIn.xy;
float l9_2851=N111_timeValuesIn.z;
float l9_2852=N111_timeValuesIn.w;
float3 l9_2853=l9_2829;
float3 l9_2854=l9_2829;
float3 l9_2855=l9_2829;
if (N111_ENABLE_INILOCATION)
{
l9_2855=N111_spawnLocation;
}
if (N111_ENABLE_BOXSPAWN)
{
l9_2853=N111_spawnBox*l9_2833;
}
if (N111_ENABLE_SPHERESPAWN)
{
l9_2854=N111_spawnSphere*l9_2835;
}
float3 l9_2856=(l9_2855+l9_2854)+l9_2853;
float3 l9_2857=l9_2829;
if (N111_ENABLE_NOISE)
{
float3 l9_2858=N111_noiseFrequency;
float3 l9_2859=N111_noiseMult;
float3 l9_2860=l9_2847;
float l9_2861=l9_2852;
float l9_2862=sin(l9_2861*l9_2858.x);
float l9_2863=sin(l9_2861*l9_2858.y);
float l9_2864=sin(l9_2861*l9_2858.z);
float3 l9_2865=(float3(l9_2862,l9_2863,l9_2864)*l9_2859)*l9_2860;
float3 l9_2866=l9_2865;
l9_2857+=l9_2866;
}
if (N111_ENABLE_SNOISE)
{
float l9_2867=l9_2844;
float l9_2868=l9_2845;
float l9_2869=l9_2846;
float3 l9_2870=N111_sNoiseFrequency;
float3 l9_2871=N111_sNoiseMult;
float3 l9_2872=l9_2847;
float l9_2873=l9_2851;
float2 l9_2874=float2(l9_2867*l9_2873,l9_2870.x);
float2 l9_2875=floor(l9_2874+float2(dot(l9_2874,float2(0.36602542))));
float2 l9_2876=(l9_2874-l9_2875)+float2(dot(l9_2875,float2(0.21132487)));
float2 l9_2877=float2(0.0);
bool2 l9_2878=bool2(l9_2876.x>l9_2876.y);
l9_2877=float2(l9_2878.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_2878.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_2879=l9_2876.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_2880=l9_2879.xy-l9_2877;
l9_2879=float4(l9_2880.x,l9_2880.y,l9_2879.z,l9_2879.w);
l9_2875=mod(l9_2875,float2(289.0));
float3 l9_2881=float3(l9_2875.y)+float3(0.0,l9_2877.y,1.0);
float3 l9_2882=mod(((l9_2881*34.0)+float3(1.0))*l9_2881,float3(289.0));
float3 l9_2883=(l9_2882+float3(l9_2875.x))+float3(0.0,l9_2877.x,1.0);
float3 l9_2884=mod(((l9_2883*34.0)+float3(1.0))*l9_2883,float3(289.0));
float3 l9_2885=l9_2884;
float3 l9_2886=fast::max(float3(0.5)-float3(dot(l9_2876,l9_2876),dot(l9_2879.xy,l9_2879.xy),dot(l9_2879.zw,l9_2879.zw)),float3(0.0));
l9_2886*=l9_2886;
l9_2886*=l9_2886;
float3 l9_2887=(fract(l9_2885*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_2888=abs(l9_2887)-float3(0.5);
float3 l9_2889=floor(l9_2887+float3(0.5));
float3 l9_2890=l9_2887-l9_2889;
l9_2886*=(float3(1.7928429)-(((l9_2890*l9_2890)+(l9_2888*l9_2888))*0.85373473));
float3 l9_2891=float3(0.0);
l9_2891.x=(l9_2890.x*l9_2876.x)+(l9_2888.x*l9_2876.y);
float2 l9_2892=(l9_2890.yz*l9_2879.xz)+(l9_2888.yz*l9_2879.yw);
l9_2891=float3(l9_2891.x,l9_2892.x,l9_2892.y);
float l9_2893=130.0*dot(l9_2886,l9_2891);
float l9_2894=l9_2893;
float2 l9_2895=float2(l9_2868*l9_2873,l9_2870.y);
float2 l9_2896=floor(l9_2895+float2(dot(l9_2895,float2(0.36602542))));
float2 l9_2897=(l9_2895-l9_2896)+float2(dot(l9_2896,float2(0.21132487)));
float2 l9_2898=float2(0.0);
bool2 l9_2899=bool2(l9_2897.x>l9_2897.y);
l9_2898=float2(l9_2899.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_2899.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_2900=l9_2897.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_2901=l9_2900.xy-l9_2898;
l9_2900=float4(l9_2901.x,l9_2901.y,l9_2900.z,l9_2900.w);
l9_2896=mod(l9_2896,float2(289.0));
float3 l9_2902=float3(l9_2896.y)+float3(0.0,l9_2898.y,1.0);
float3 l9_2903=mod(((l9_2902*34.0)+float3(1.0))*l9_2902,float3(289.0));
float3 l9_2904=(l9_2903+float3(l9_2896.x))+float3(0.0,l9_2898.x,1.0);
float3 l9_2905=mod(((l9_2904*34.0)+float3(1.0))*l9_2904,float3(289.0));
float3 l9_2906=l9_2905;
float3 l9_2907=fast::max(float3(0.5)-float3(dot(l9_2897,l9_2897),dot(l9_2900.xy,l9_2900.xy),dot(l9_2900.zw,l9_2900.zw)),float3(0.0));
l9_2907*=l9_2907;
l9_2907*=l9_2907;
float3 l9_2908=(fract(l9_2906*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_2909=abs(l9_2908)-float3(0.5);
float3 l9_2910=floor(l9_2908+float3(0.5));
float3 l9_2911=l9_2908-l9_2910;
l9_2907*=(float3(1.7928429)-(((l9_2911*l9_2911)+(l9_2909*l9_2909))*0.85373473));
float3 l9_2912=float3(0.0);
l9_2912.x=(l9_2911.x*l9_2897.x)+(l9_2909.x*l9_2897.y);
float2 l9_2913=(l9_2911.yz*l9_2900.xz)+(l9_2909.yz*l9_2900.yw);
l9_2912=float3(l9_2912.x,l9_2913.x,l9_2913.y);
float l9_2914=130.0*dot(l9_2907,l9_2912);
float l9_2915=l9_2914;
float2 l9_2916=float2(l9_2869*l9_2873,l9_2870.z);
float2 l9_2917=floor(l9_2916+float2(dot(l9_2916,float2(0.36602542))));
float2 l9_2918=(l9_2916-l9_2917)+float2(dot(l9_2917,float2(0.21132487)));
float2 l9_2919=float2(0.0);
bool2 l9_2920=bool2(l9_2918.x>l9_2918.y);
l9_2919=float2(l9_2920.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_2920.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float4 l9_2921=l9_2918.xyxy+float4(0.21132487,0.21132487,-0.57735026,-0.57735026);
float2 l9_2922=l9_2921.xy-l9_2919;
l9_2921=float4(l9_2922.x,l9_2922.y,l9_2921.z,l9_2921.w);
l9_2917=mod(l9_2917,float2(289.0));
float3 l9_2923=float3(l9_2917.y)+float3(0.0,l9_2919.y,1.0);
float3 l9_2924=mod(((l9_2923*34.0)+float3(1.0))*l9_2923,float3(289.0));
float3 l9_2925=(l9_2924+float3(l9_2917.x))+float3(0.0,l9_2919.x,1.0);
float3 l9_2926=mod(((l9_2925*34.0)+float3(1.0))*l9_2925,float3(289.0));
float3 l9_2927=l9_2926;
float3 l9_2928=fast::max(float3(0.5)-float3(dot(l9_2918,l9_2918),dot(l9_2921.xy,l9_2921.xy),dot(l9_2921.zw,l9_2921.zw)),float3(0.0));
l9_2928*=l9_2928;
l9_2928*=l9_2928;
float3 l9_2929=(fract(l9_2927*float3(0.024390243))*2.0)-float3(1.0);
float3 l9_2930=abs(l9_2929)-float3(0.5);
float3 l9_2931=floor(l9_2929+float3(0.5));
float3 l9_2932=l9_2929-l9_2931;
l9_2928*=(float3(1.7928429)-(((l9_2932*l9_2932)+(l9_2930*l9_2930))*0.85373473));
float3 l9_2933=float3(0.0);
l9_2933.x=(l9_2932.x*l9_2918.x)+(l9_2930.x*l9_2918.y);
float2 l9_2934=(l9_2932.yz*l9_2921.xz)+(l9_2930.yz*l9_2921.yw);
l9_2933=float3(l9_2933.x,l9_2934.x,l9_2934.y);
float l9_2935=130.0*dot(l9_2928,l9_2933);
float l9_2936=l9_2935;
float3 l9_2937=(float3(l9_2894,l9_2915,l9_2936)*l9_2871)*l9_2872;
l9_2857+=l9_2937;
}
float3 l9_2938=float3(0.0,((N111_gravity/2.0)*l9_2851)*l9_2851,0.0);
float3 l9_2939=l9_2829;
if (N111_ENABLE_FORCE)
{
l9_2939=((N111_localForce/float3(2.0))*l9_2851)*l9_2851;
}
float3 l9_2940=l9_2829;
float3 l9_2941=N111_velocityMin+(((l9_2847+float3(1.0))/float3(2.0))*(N111_velocityMax-N111_velocityMin));
if (N111_ENABLE_VELRAMP)
{
l9_2941=mix(N111_velocityMin,N111_velocityMax,l9_2848);
}
float3 l9_2942=l9_2941;
float l9_2943=l9_2851;
float3 l9_2944=N111_velocityDrag;
float3 l9_2945=l9_2857;
float l9_2946=l9_2852;
float3 l9_2947=float3(l9_2943,l9_2943,l9_2943);
float3 l9_2948=l9_2944;
float l9_2949;
if (l9_2947.x<=0.0)
{
l9_2949=0.0;
}
else
{
l9_2949=pow(l9_2947.x,l9_2948.x);
}
float l9_2950=l9_2949;
float l9_2951;
if (l9_2947.y<=0.0)
{
l9_2951=0.0;
}
else
{
l9_2951=pow(l9_2947.y,l9_2948.y);
}
float l9_2952=l9_2951;
float l9_2953;
if (l9_2947.z<=0.0)
{
l9_2953=0.0;
}
else
{
l9_2953=pow(l9_2947.z,l9_2948.z);
}
float3 l9_2954=float3(l9_2950,l9_2952,l9_2953);
float3 l9_2955=l9_2954;
float3 l9_2956=(l9_2942+l9_2945)*l9_2955;
if (N111_ENABLE_VELRAMP)
{
float l9_2957=floor(l9_2946*10000.0)/10000.0;
float2 l9_2958=tempGlobals.Surface_UVCoord0;
float2 l9_2959=(l9_2958/float2(10000.0,1.0))+float2(l9_2957,0.0);
float2 l9_2960=l9_2959;
float4 l9_2961=float4(0.0);
int l9_2962=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_2963=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2963=0;
}
else
{
l9_2963=gl_InstanceIndex%2;
}
int l9_2964=l9_2963;
l9_2962=1-l9_2964;
}
else
{
int l9_2965=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2965=0;
}
else
{
l9_2965=gl_InstanceIndex%2;
}
int l9_2966=l9_2965;
l9_2962=l9_2966;
}
int l9_2967=l9_2962;
int l9_2968=velRampTextureLayout_tmp;
int l9_2969=l9_2967;
float2 l9_2970=l9_2960;
bool l9_2971=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_2972=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_2973=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_2974=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_2975=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_2976=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_2977=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_2978=0.0;
bool l9_2979=l9_2976&&(!l9_2974);
float l9_2980=1.0;
float l9_2981=l9_2970.x;
int l9_2982=l9_2973.x;
if (l9_2982==1)
{
l9_2981=fract(l9_2981);
}
else
{
if (l9_2982==2)
{
float l9_2983=fract(l9_2981);
float l9_2984=l9_2981-l9_2983;
float l9_2985=step(0.25,fract(l9_2984*0.5));
l9_2981=mix(l9_2983,1.0-l9_2983,fast::clamp(l9_2985,0.0,1.0));
}
}
l9_2970.x=l9_2981;
float l9_2986=l9_2970.y;
int l9_2987=l9_2973.y;
if (l9_2987==1)
{
l9_2986=fract(l9_2986);
}
else
{
if (l9_2987==2)
{
float l9_2988=fract(l9_2986);
float l9_2989=l9_2986-l9_2988;
float l9_2990=step(0.25,fract(l9_2989*0.5));
l9_2986=mix(l9_2988,1.0-l9_2988,fast::clamp(l9_2990,0.0,1.0));
}
}
l9_2970.y=l9_2986;
if (l9_2974)
{
bool l9_2991=l9_2976;
bool l9_2992;
if (l9_2991)
{
l9_2992=l9_2973.x==3;
}
else
{
l9_2992=l9_2991;
}
float l9_2993=l9_2970.x;
float l9_2994=l9_2975.x;
float l9_2995=l9_2975.z;
bool l9_2996=l9_2992;
float l9_2997=l9_2980;
float l9_2998=fast::clamp(l9_2993,l9_2994,l9_2995);
float l9_2999=step(abs(l9_2993-l9_2998),9.9999997e-06);
l9_2997*=(l9_2999+((1.0-float(l9_2996))*(1.0-l9_2999)));
l9_2993=l9_2998;
l9_2970.x=l9_2993;
l9_2980=l9_2997;
bool l9_3000=l9_2976;
bool l9_3001;
if (l9_3000)
{
l9_3001=l9_2973.y==3;
}
else
{
l9_3001=l9_3000;
}
float l9_3002=l9_2970.y;
float l9_3003=l9_2975.y;
float l9_3004=l9_2975.w;
bool l9_3005=l9_3001;
float l9_3006=l9_2980;
float l9_3007=fast::clamp(l9_3002,l9_3003,l9_3004);
float l9_3008=step(abs(l9_3002-l9_3007),9.9999997e-06);
l9_3006*=(l9_3008+((1.0-float(l9_3005))*(1.0-l9_3008)));
l9_3002=l9_3007;
l9_2970.y=l9_3002;
l9_2980=l9_3006;
}
float2 l9_3009=l9_2970;
bool l9_3010=l9_2971;
float3x3 l9_3011=l9_2972;
if (l9_3010)
{
l9_3009=float2((l9_3011*float3(l9_3009,1.0)).xy);
}
float2 l9_3012=l9_3009;
float2 l9_3013=l9_3012;
float2 l9_3014=l9_3013;
l9_2970=l9_3014;
float l9_3015=l9_2970.x;
int l9_3016=l9_2973.x;
bool l9_3017=l9_2979;
float l9_3018=l9_2980;
if ((l9_3016==0)||(l9_3016==3))
{
float l9_3019=l9_3015;
float l9_3020=0.0;
float l9_3021=1.0;
bool l9_3022=l9_3017;
float l9_3023=l9_3018;
float l9_3024=fast::clamp(l9_3019,l9_3020,l9_3021);
float l9_3025=step(abs(l9_3019-l9_3024),9.9999997e-06);
l9_3023*=(l9_3025+((1.0-float(l9_3022))*(1.0-l9_3025)));
l9_3019=l9_3024;
l9_3015=l9_3019;
l9_3018=l9_3023;
}
l9_2970.x=l9_3015;
l9_2980=l9_3018;
float l9_3026=l9_2970.y;
int l9_3027=l9_2973.y;
bool l9_3028=l9_2979;
float l9_3029=l9_2980;
if ((l9_3027==0)||(l9_3027==3))
{
float l9_3030=l9_3026;
float l9_3031=0.0;
float l9_3032=1.0;
bool l9_3033=l9_3028;
float l9_3034=l9_3029;
float l9_3035=fast::clamp(l9_3030,l9_3031,l9_3032);
float l9_3036=step(abs(l9_3030-l9_3035),9.9999997e-06);
l9_3034*=(l9_3036+((1.0-float(l9_3033))*(1.0-l9_3036)));
l9_3030=l9_3035;
l9_3026=l9_3030;
l9_3029=l9_3034;
}
l9_2970.y=l9_3026;
l9_2980=l9_3029;
float2 l9_3037=l9_2970;
int l9_3038=l9_2968;
int l9_3039=l9_2969;
float l9_3040=l9_2978;
float2 l9_3041=l9_3037;
int l9_3042=l9_3038;
int l9_3043=l9_3039;
float3 l9_3044=float3(0.0);
if (l9_3042==0)
{
l9_3044=float3(l9_3041,0.0);
}
else
{
if (l9_3042==1)
{
l9_3044=float3(l9_3041.x,(l9_3041.y*0.5)+(0.5-(float(l9_3043)*0.5)),0.0);
}
else
{
l9_3044=float3(l9_3041,float(l9_3043));
}
}
float3 l9_3045=l9_3044;
float3 l9_3046=l9_3045;
float2 l9_3047=l9_3046.xy;
float l9_3048=l9_3040;
float4 l9_3049=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_3047,level(l9_3048));
float4 l9_3050=l9_3049;
float4 l9_3051=l9_3050;
if (l9_2976)
{
l9_3051=mix(l9_2977,l9_3051,float4(l9_2980));
}
float4 l9_3052=l9_3051;
l9_2961=l9_3052;
float4 l9_3053=l9_2961;
float3 l9_3054=l9_3053.xyz;
l9_2956=(l9_2942+l9_2945)*l9_3054;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_2956=l9_2942*l9_2955;
}
}
float3 l9_3055=l9_2956;
l9_2940=l9_3055;
float4x4 l9_3056=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_3057=length(l9_3056[0].xyz);
float4x4 l9_3058=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_3059=length(l9_3058[1].xyz);
float4x4 l9_3060=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_3061=length(l9_3060[2].xyz);
float3 l9_3062=float3(l9_3057,l9_3059,l9_3061);
float4x4 l9_3063=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_3064=l9_3063;
float4 l9_3065=l9_3064[0];
float4 l9_3066=l9_3064[1];
float4 l9_3067=l9_3064[2];
float3x3 l9_3068=float3x3(float3(float3(l9_3065.x,l9_3066.x,l9_3067.x)),float3(float3(l9_3065.y,l9_3066.y,l9_3067.y)),float3(float3(l9_3065.z,l9_3066.z,l9_3067.z)));
float3x3 l9_3069=l9_3068;
float3 l9_3070=((l9_2940+l9_2938)+l9_2939)*l9_3069;
if (N111_WORLDFORCE)
{
float4x4 l9_3071=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_3072=l9_3071;
float4 l9_3073=l9_3072[0];
float4 l9_3074=l9_3072[1];
float4 l9_3075=l9_3072[2];
float3x3 l9_3076=float3x3(float3(float3(l9_3073.x,l9_3074.x,l9_3075.x)),float3(float3(l9_3073.y,l9_3074.y,l9_3075.y)),float3(float3(l9_3073.z,l9_3074.z,l9_3075.z)));
float3x3 l9_3077=l9_3076;
l9_3070=((l9_2940*l9_3077)+l9_2938)+l9_2939;
}
if (N111_WORLDSPACE)
{
l9_3070=((l9_2940*l9_3062)+l9_2938)+l9_2939;
}
float4x4 l9_3078=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3 l9_3079=(l9_3078*float4(l9_2856,1.0)).xyz+l9_3070;
float l9_3080=mix(N111_rotationRandomZ.x,N111_rotationRandomZ.y,l9_2849);
float l9_3081=1.0-l9_2852;
float l9_3082=N111_rotationDrag;
float l9_3083;
if (l9_3081<=0.0)
{
l9_3083=0.0;
}
else
{
l9_3083=pow(l9_3081,l9_3082);
}
float l9_3084=l9_3083;
float l9_3085=l9_3084;
float l9_3086=mix(N111_rotationRateZ.x,N111_rotationRateZ.y,l9_2849);
float l9_3087=((l9_3086*l9_3085)*l9_2852)*2.0;
float l9_3088=N111_PI*((l9_3087+l9_3080)-0.5);
float l9_3089=1.0;
if (N111_ENABLE_SCREENFADE)
{
float3 l9_3090=(*sc_set2.UserUniforms).sc_Camera.position;
float3 l9_3091=l9_3090-l9_3079;
float l9_3092=dot(l9_3091,l9_3091);
float l9_3093=(N111_fadeDistanceInvisible+N111_EPSILON)*(N111_fadeDistanceInvisible+N111_EPSILON);
float l9_3094=N111_fadeDistanceVisible*N111_fadeDistanceVisible;
float l9_3095=fast::min(l9_3093,l9_3094);
float l9_3096=fast::max(l9_3093,l9_3094);
N111_nearCameraFade=smoothstep(l9_3095,l9_3096,l9_3092);
float l9_3097;
if (l9_3093>l9_3094)
{
l9_3097=1.0-N111_nearCameraFade;
}
else
{
l9_3097=N111_nearCameraFade;
}
N111_nearCameraFade=l9_3097;
if (N111_nearCameraFade<=N111_EPSILON)
{
l9_3089=0.0;
}
}
if (N111_MESHTYPE_QUAD)
{
int l9_3098=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3098=0;
}
else
{
l9_3098=gl_InstanceIndex%2;
}
int l9_3099=l9_3098;
float4x4 l9_3100=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_3099];
float3 l9_3101=l9_3100[2].xyz;
int l9_3102=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3102=0;
}
else
{
l9_3102=gl_InstanceIndex%2;
}
int l9_3103=l9_3102;
float3 l9_3104=(*sc_set2.UserUniforms).sc_ViewMatrixInverseArray[l9_3103][1].xyz;
float3 l9_3105=-l9_3104;
float3 l9_3106=normalize(cross(l9_3101,l9_3105));
float l9_3107=1.0;
if (N111_ENABLE_ALIGNTOX)
{
l9_3106=float3(0.0,0.0,1.0);
l9_3105=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_3106=float3(1.0,0.0,0.0);
l9_3105=float3(0.0,0.0,1.0);
}
if (N111_ENABLE_ALIGNTOZ)
{
l9_3106=float3(1.0,0.0,0.0);
l9_3105=float3(0.0,1.0,0.0);
}
float2 l9_3108=float2(cos(l9_3088),sin(l9_3088));
float2 l9_3109=float2(-sin(l9_3088),cos(l9_3088));
float3 l9_3110=float3((l9_3106*l9_3108.x)+(l9_3105*l9_3108.y));
float3 l9_3111=float3((l9_3106*l9_3109.x)+(l9_3105*l9_3109.y));
if (N111_ENABLE_ALIGNTOVEL)
{
float3 l9_3112=normalize(((l9_3070+l9_2938)+l9_2939)+float3(N111_EPSILON));
float3 l9_3113=l9_3070*(l9_2851-0.0099999998);
float3 l9_3114=l9_3070*(l9_2851+0.0099999998);
if (N111_ENABLE_IGNOREVEL)
{
l9_3107=fast::max(N111_sizeVelScale,N111_EPSILON);
}
else
{
l9_3107=length(l9_3114-l9_3113)*N111_sizeVelScale;
if (N111_ENABLE_IGNORETRANSFORMSCALE)
{
float4x4 l9_3115=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_3107=(length(l9_3114-l9_3113)/length(l9_3115[0].xyz))*N111_sizeVelScale;
}
}
l9_3110=l9_3112;
l9_3111=normalize(cross(l9_3110,l9_3101));
}
float4x4 l9_3116=(*sc_set2.UserUniforms).sc_ModelMatrix;
float l9_3117=length(l9_3116[0].xyz);
float2 l9_3118=tempGlobals.Surface_UVCoord0;
float2 l9_3119=l9_3118;
float l9_3120=N111_dieTrigger;
float l9_3121=l9_3089;
float2 l9_3122=l9_3119;
float l9_3123=l9_2842;
float l9_3124=l9_2843;
float l9_3125=l9_2852;
float l9_3126=N111_sizeSpeed;
float2 l9_3127=N111_sizeStart.xy;
float2 l9_3128=N111_sizeEnd.xy;
float l9_3129=l9_3125;
float l9_3130=l9_3126;
float l9_3131;
if (l9_3129<=0.0)
{
l9_3131=0.0;
}
else
{
l9_3131=pow(l9_3129,l9_3130);
}
float l9_3132=l9_3131;
float l9_3133=l9_3132;
if (N111_ENABLE_SIZEMINMAX)
{
l9_3127=mix(N111_sizeStartMin.xy,N111_sizeStartMax.xy,float2(l9_3123));
l9_3128=mix(N111_sizeEndMin.xy,N111_sizeEndMax.xy,float2(l9_3124));
}
float2 l9_3134=mix(l9_3127,l9_3128,float2(l9_3133));
if (N111_ENABLE_SIZERAMP)
{
float l9_3135=ceil(l9_3125*10000.0)/10000.0;
float2 l9_3136=tempGlobals.Surface_UVCoord0;
float2 l9_3137=(l9_3136/float2(10000.0,1.0))+float2(l9_3135,0.0);
float2 l9_3138=l9_3137;
float4 l9_3139=float4(0.0);
int l9_3140=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_3141=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3141=0;
}
else
{
l9_3141=gl_InstanceIndex%2;
}
int l9_3142=l9_3141;
l9_3140=1-l9_3142;
}
else
{
int l9_3143=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3143=0;
}
else
{
l9_3143=gl_InstanceIndex%2;
}
int l9_3144=l9_3143;
l9_3140=l9_3144;
}
int l9_3145=l9_3140;
int l9_3146=sizeRampTextureLayout_tmp;
int l9_3147=l9_3145;
float2 l9_3148=l9_3138;
bool l9_3149=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_3150=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_3151=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_3152=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_3153=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_3154=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_3155=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_3156=0.0;
bool l9_3157=l9_3154&&(!l9_3152);
float l9_3158=1.0;
float l9_3159=l9_3148.x;
int l9_3160=l9_3151.x;
if (l9_3160==1)
{
l9_3159=fract(l9_3159);
}
else
{
if (l9_3160==2)
{
float l9_3161=fract(l9_3159);
float l9_3162=l9_3159-l9_3161;
float l9_3163=step(0.25,fract(l9_3162*0.5));
l9_3159=mix(l9_3161,1.0-l9_3161,fast::clamp(l9_3163,0.0,1.0));
}
}
l9_3148.x=l9_3159;
float l9_3164=l9_3148.y;
int l9_3165=l9_3151.y;
if (l9_3165==1)
{
l9_3164=fract(l9_3164);
}
else
{
if (l9_3165==2)
{
float l9_3166=fract(l9_3164);
float l9_3167=l9_3164-l9_3166;
float l9_3168=step(0.25,fract(l9_3167*0.5));
l9_3164=mix(l9_3166,1.0-l9_3166,fast::clamp(l9_3168,0.0,1.0));
}
}
l9_3148.y=l9_3164;
if (l9_3152)
{
bool l9_3169=l9_3154;
bool l9_3170;
if (l9_3169)
{
l9_3170=l9_3151.x==3;
}
else
{
l9_3170=l9_3169;
}
float l9_3171=l9_3148.x;
float l9_3172=l9_3153.x;
float l9_3173=l9_3153.z;
bool l9_3174=l9_3170;
float l9_3175=l9_3158;
float l9_3176=fast::clamp(l9_3171,l9_3172,l9_3173);
float l9_3177=step(abs(l9_3171-l9_3176),9.9999997e-06);
l9_3175*=(l9_3177+((1.0-float(l9_3174))*(1.0-l9_3177)));
l9_3171=l9_3176;
l9_3148.x=l9_3171;
l9_3158=l9_3175;
bool l9_3178=l9_3154;
bool l9_3179;
if (l9_3178)
{
l9_3179=l9_3151.y==3;
}
else
{
l9_3179=l9_3178;
}
float l9_3180=l9_3148.y;
float l9_3181=l9_3153.y;
float l9_3182=l9_3153.w;
bool l9_3183=l9_3179;
float l9_3184=l9_3158;
float l9_3185=fast::clamp(l9_3180,l9_3181,l9_3182);
float l9_3186=step(abs(l9_3180-l9_3185),9.9999997e-06);
l9_3184*=(l9_3186+((1.0-float(l9_3183))*(1.0-l9_3186)));
l9_3180=l9_3185;
l9_3148.y=l9_3180;
l9_3158=l9_3184;
}
float2 l9_3187=l9_3148;
bool l9_3188=l9_3149;
float3x3 l9_3189=l9_3150;
if (l9_3188)
{
l9_3187=float2((l9_3189*float3(l9_3187,1.0)).xy);
}
float2 l9_3190=l9_3187;
float2 l9_3191=l9_3190;
float2 l9_3192=l9_3191;
l9_3148=l9_3192;
float l9_3193=l9_3148.x;
int l9_3194=l9_3151.x;
bool l9_3195=l9_3157;
float l9_3196=l9_3158;
if ((l9_3194==0)||(l9_3194==3))
{
float l9_3197=l9_3193;
float l9_3198=0.0;
float l9_3199=1.0;
bool l9_3200=l9_3195;
float l9_3201=l9_3196;
float l9_3202=fast::clamp(l9_3197,l9_3198,l9_3199);
float l9_3203=step(abs(l9_3197-l9_3202),9.9999997e-06);
l9_3201*=(l9_3203+((1.0-float(l9_3200))*(1.0-l9_3203)));
l9_3197=l9_3202;
l9_3193=l9_3197;
l9_3196=l9_3201;
}
l9_3148.x=l9_3193;
l9_3158=l9_3196;
float l9_3204=l9_3148.y;
int l9_3205=l9_3151.y;
bool l9_3206=l9_3157;
float l9_3207=l9_3158;
if ((l9_3205==0)||(l9_3205==3))
{
float l9_3208=l9_3204;
float l9_3209=0.0;
float l9_3210=1.0;
bool l9_3211=l9_3206;
float l9_3212=l9_3207;
float l9_3213=fast::clamp(l9_3208,l9_3209,l9_3210);
float l9_3214=step(abs(l9_3208-l9_3213),9.9999997e-06);
l9_3212*=(l9_3214+((1.0-float(l9_3211))*(1.0-l9_3214)));
l9_3208=l9_3213;
l9_3204=l9_3208;
l9_3207=l9_3212;
}
l9_3148.y=l9_3204;
l9_3158=l9_3207;
float2 l9_3215=l9_3148;
int l9_3216=l9_3146;
int l9_3217=l9_3147;
float l9_3218=l9_3156;
float2 l9_3219=l9_3215;
int l9_3220=l9_3216;
int l9_3221=l9_3217;
float3 l9_3222=float3(0.0);
if (l9_3220==0)
{
l9_3222=float3(l9_3219,0.0);
}
else
{
if (l9_3220==1)
{
l9_3222=float3(l9_3219.x,(l9_3219.y*0.5)+(0.5-(float(l9_3221)*0.5)),0.0);
}
else
{
l9_3222=float3(l9_3219,float(l9_3221));
}
}
float3 l9_3223=l9_3222;
float3 l9_3224=l9_3223;
float2 l9_3225=l9_3224.xy;
float l9_3226=l9_3218;
float4 l9_3227=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_3225,level(l9_3226));
float4 l9_3228=l9_3227;
float4 l9_3229=l9_3228;
if (l9_3154)
{
l9_3229=mix(l9_3155,l9_3229,float4(l9_3158));
}
float4 l9_3230=l9_3229;
l9_3139=l9_3230;
float4 l9_3231=l9_3139;
float2 l9_3232=l9_3231.xy;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_3232=float2(1.0);
}
l9_3134=l9_3232*l9_3127;
}
float2 l9_3233=l9_3134;
float2 l9_3234=(((l9_3122-float2(0.5))*(l9_3120*l9_3121))*l9_3233)*l9_3117;
float3 l9_3235=(l9_3079+(l9_3111*l9_3234.x))+(l9_3110*(l9_3234.y*l9_3107));
N111_position=l9_3235;
N111_normal=l9_3101;
}
else
{
N111_position=N111_positionObjectSpace;
if (N111_ENABLE_CENTER_IN_BBOX)
{
float3 l9_3236=(*sc_set2.UserUniforms).sc_LocalAabbMax;
float3 l9_3237=(*sc_set2.UserUniforms).sc_LocalAabbMin;
float3 l9_3238=(l9_3236+l9_3237)/float3(2.0);
N111_position-=l9_3238;
}
float3 l9_3239=N111_position;
float3 l9_3240=l9_3062;
float l9_3241=l9_2842;
float l9_3242=l9_2843;
float l9_3243=l9_2852;
float l9_3244=N111_sizeSpeed;
float3 l9_3245=N111_sizeStart;
float3 l9_3246=N111_sizeEnd;
float l9_3247=l9_3243;
float l9_3248=l9_3244;
float l9_3249;
if (l9_3247<=0.0)
{
l9_3249=0.0;
}
else
{
l9_3249=pow(l9_3247,l9_3248);
}
float l9_3250=l9_3249;
float l9_3251=l9_3250;
if (N111_ENABLE_SIZEMINMAX)
{
l9_3245=mix(N111_sizeStartMin,N111_sizeStartMax,float3(l9_3241));
l9_3246=mix(N111_sizeEndMin,N111_sizeEndMax,float3(l9_3242));
}
float3 l9_3252=mix(l9_3245,l9_3246,float3(l9_3251));
if (N111_ENABLE_SIZERAMP)
{
float l9_3253=ceil(l9_3243*10000.0)/10000.0;
float2 l9_3254=tempGlobals.Surface_UVCoord0;
float2 l9_3255=(l9_3254/float2(10000.0,1.0))+float2(l9_3253,0.0);
float2 l9_3256=l9_3255;
float4 l9_3257=float4(0.0);
int l9_3258=0;
if ((int(sizeRampTextureHasSwappedViews_tmp)!=0))
{
int l9_3259=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3259=0;
}
else
{
l9_3259=gl_InstanceIndex%2;
}
int l9_3260=l9_3259;
l9_3258=1-l9_3260;
}
else
{
int l9_3261=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3261=0;
}
else
{
l9_3261=gl_InstanceIndex%2;
}
int l9_3262=l9_3261;
l9_3258=l9_3262;
}
int l9_3263=l9_3258;
int l9_3264=sizeRampTextureLayout_tmp;
int l9_3265=l9_3263;
float2 l9_3266=l9_3256;
bool l9_3267=(int(SC_USE_UV_TRANSFORM_sizeRampTexture_tmp)!=0);
float3x3 l9_3268=(*sc_set2.UserUniforms).sizeRampTextureTransform;
int2 l9_3269=int2(SC_SOFTWARE_WRAP_MODE_U_sizeRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_sizeRampTexture_tmp);
bool l9_3270=(int(SC_USE_UV_MIN_MAX_sizeRampTexture_tmp)!=0);
float4 l9_3271=(*sc_set2.UserUniforms).sizeRampTextureUvMinMax;
bool l9_3272=(int(SC_USE_CLAMP_TO_BORDER_sizeRampTexture_tmp)!=0);
float4 l9_3273=(*sc_set2.UserUniforms).sizeRampTextureBorderColor;
float l9_3274=0.0;
bool l9_3275=l9_3272&&(!l9_3270);
float l9_3276=1.0;
float l9_3277=l9_3266.x;
int l9_3278=l9_3269.x;
if (l9_3278==1)
{
l9_3277=fract(l9_3277);
}
else
{
if (l9_3278==2)
{
float l9_3279=fract(l9_3277);
float l9_3280=l9_3277-l9_3279;
float l9_3281=step(0.25,fract(l9_3280*0.5));
l9_3277=mix(l9_3279,1.0-l9_3279,fast::clamp(l9_3281,0.0,1.0));
}
}
l9_3266.x=l9_3277;
float l9_3282=l9_3266.y;
int l9_3283=l9_3269.y;
if (l9_3283==1)
{
l9_3282=fract(l9_3282);
}
else
{
if (l9_3283==2)
{
float l9_3284=fract(l9_3282);
float l9_3285=l9_3282-l9_3284;
float l9_3286=step(0.25,fract(l9_3285*0.5));
l9_3282=mix(l9_3284,1.0-l9_3284,fast::clamp(l9_3286,0.0,1.0));
}
}
l9_3266.y=l9_3282;
if (l9_3270)
{
bool l9_3287=l9_3272;
bool l9_3288;
if (l9_3287)
{
l9_3288=l9_3269.x==3;
}
else
{
l9_3288=l9_3287;
}
float l9_3289=l9_3266.x;
float l9_3290=l9_3271.x;
float l9_3291=l9_3271.z;
bool l9_3292=l9_3288;
float l9_3293=l9_3276;
float l9_3294=fast::clamp(l9_3289,l9_3290,l9_3291);
float l9_3295=step(abs(l9_3289-l9_3294),9.9999997e-06);
l9_3293*=(l9_3295+((1.0-float(l9_3292))*(1.0-l9_3295)));
l9_3289=l9_3294;
l9_3266.x=l9_3289;
l9_3276=l9_3293;
bool l9_3296=l9_3272;
bool l9_3297;
if (l9_3296)
{
l9_3297=l9_3269.y==3;
}
else
{
l9_3297=l9_3296;
}
float l9_3298=l9_3266.y;
float l9_3299=l9_3271.y;
float l9_3300=l9_3271.w;
bool l9_3301=l9_3297;
float l9_3302=l9_3276;
float l9_3303=fast::clamp(l9_3298,l9_3299,l9_3300);
float l9_3304=step(abs(l9_3298-l9_3303),9.9999997e-06);
l9_3302*=(l9_3304+((1.0-float(l9_3301))*(1.0-l9_3304)));
l9_3298=l9_3303;
l9_3266.y=l9_3298;
l9_3276=l9_3302;
}
float2 l9_3305=l9_3266;
bool l9_3306=l9_3267;
float3x3 l9_3307=l9_3268;
if (l9_3306)
{
l9_3305=float2((l9_3307*float3(l9_3305,1.0)).xy);
}
float2 l9_3308=l9_3305;
float2 l9_3309=l9_3308;
float2 l9_3310=l9_3309;
l9_3266=l9_3310;
float l9_3311=l9_3266.x;
int l9_3312=l9_3269.x;
bool l9_3313=l9_3275;
float l9_3314=l9_3276;
if ((l9_3312==0)||(l9_3312==3))
{
float l9_3315=l9_3311;
float l9_3316=0.0;
float l9_3317=1.0;
bool l9_3318=l9_3313;
float l9_3319=l9_3314;
float l9_3320=fast::clamp(l9_3315,l9_3316,l9_3317);
float l9_3321=step(abs(l9_3315-l9_3320),9.9999997e-06);
l9_3319*=(l9_3321+((1.0-float(l9_3318))*(1.0-l9_3321)));
l9_3315=l9_3320;
l9_3311=l9_3315;
l9_3314=l9_3319;
}
l9_3266.x=l9_3311;
l9_3276=l9_3314;
float l9_3322=l9_3266.y;
int l9_3323=l9_3269.y;
bool l9_3324=l9_3275;
float l9_3325=l9_3276;
if ((l9_3323==0)||(l9_3323==3))
{
float l9_3326=l9_3322;
float l9_3327=0.0;
float l9_3328=1.0;
bool l9_3329=l9_3324;
float l9_3330=l9_3325;
float l9_3331=fast::clamp(l9_3326,l9_3327,l9_3328);
float l9_3332=step(abs(l9_3326-l9_3331),9.9999997e-06);
l9_3330*=(l9_3332+((1.0-float(l9_3329))*(1.0-l9_3332)));
l9_3326=l9_3331;
l9_3322=l9_3326;
l9_3325=l9_3330;
}
l9_3266.y=l9_3322;
l9_3276=l9_3325;
float2 l9_3333=l9_3266;
int l9_3334=l9_3264;
int l9_3335=l9_3265;
float l9_3336=l9_3274;
float2 l9_3337=l9_3333;
int l9_3338=l9_3334;
int l9_3339=l9_3335;
float3 l9_3340=float3(0.0);
if (l9_3338==0)
{
l9_3340=float3(l9_3337,0.0);
}
else
{
if (l9_3338==1)
{
l9_3340=float3(l9_3337.x,(l9_3337.y*0.5)+(0.5-(float(l9_3339)*0.5)),0.0);
}
else
{
l9_3340=float3(l9_3337,float(l9_3339));
}
}
float3 l9_3341=l9_3340;
float3 l9_3342=l9_3341;
float2 l9_3343=l9_3342.xy;
float l9_3344=l9_3336;
float4 l9_3345=sc_set2.sizeRampTexture.sample(sc_set2.sizeRampTextureSmpSC,l9_3343,level(l9_3344));
float4 l9_3346=l9_3345;
float4 l9_3347=l9_3346;
if (l9_3272)
{
l9_3347=mix(l9_3273,l9_3347,float4(l9_3276));
}
float4 l9_3348=l9_3347;
l9_3257=l9_3348;
float4 l9_3349=l9_3257;
float3 l9_3350=l9_3349.xyz;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_3350=float3(1.0);
}
l9_3252=l9_3350*l9_3245;
}
float3 l9_3351=l9_3252;
N111_position=(l9_3239*l9_3240)*l9_3351;
if ((N111_dieTrigger<0.5)||(l9_3089<0.5))
{
N111_position.x=2.1474836e+09;
}
float3x3 l9_3352;
if (((N111_ENABLE_ALIGNTOVEL||N111_ENABLE_ALIGNTOX)||N111_ENABLE_ALIGNTOY)||N111_ENABLE_ALIGNTOZ)
{
if (N111_ENABLE_ALIGNTOZ)
{
l9_3352=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
}
else
{
float3 l9_3353=float3(0.0);
if (N111_ENABLE_ALIGNTOX)
{
l9_3353=float3(1.0,0.0,0.0);
}
if (N111_ENABLE_ALIGNTOY)
{
l9_3353=float3(0.0,1.0,0.0);
}
if (N111_ENABLE_ALIGNTOVEL)
{
float l9_3354=0.001;
float3 l9_3355=l9_2941;
float l9_3356=l9_2851-l9_3354;
float3 l9_3357=N111_velocityDrag;
float3 l9_3358=l9_2857;
float l9_3359=l9_2852-l9_3354;
float3 l9_3360=float3(l9_3356,l9_3356,l9_3356);
float3 l9_3361=l9_3357;
float l9_3362;
if (l9_3360.x<=0.0)
{
l9_3362=0.0;
}
else
{
l9_3362=pow(l9_3360.x,l9_3361.x);
}
float l9_3363=l9_3362;
float l9_3364;
if (l9_3360.y<=0.0)
{
l9_3364=0.0;
}
else
{
l9_3364=pow(l9_3360.y,l9_3361.y);
}
float l9_3365=l9_3364;
float l9_3366;
if (l9_3360.z<=0.0)
{
l9_3366=0.0;
}
else
{
l9_3366=pow(l9_3360.z,l9_3361.z);
}
float3 l9_3367=float3(l9_3363,l9_3365,l9_3366);
float3 l9_3368=l9_3367;
float3 l9_3369=(l9_3355+l9_3358)*l9_3368;
if (N111_ENABLE_VELRAMP)
{
float l9_3370=floor(l9_3359*10000.0)/10000.0;
float2 l9_3371=tempGlobals.Surface_UVCoord0;
float2 l9_3372=(l9_3371/float2(10000.0,1.0))+float2(l9_3370,0.0);
float2 l9_3373=l9_3372;
float4 l9_3374=float4(0.0);
int l9_3375=0;
if ((int(velRampTextureHasSwappedViews_tmp)!=0))
{
int l9_3376=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3376=0;
}
else
{
l9_3376=gl_InstanceIndex%2;
}
int l9_3377=l9_3376;
l9_3375=1-l9_3377;
}
else
{
int l9_3378=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3378=0;
}
else
{
l9_3378=gl_InstanceIndex%2;
}
int l9_3379=l9_3378;
l9_3375=l9_3379;
}
int l9_3380=l9_3375;
int l9_3381=velRampTextureLayout_tmp;
int l9_3382=l9_3380;
float2 l9_3383=l9_3373;
bool l9_3384=(int(SC_USE_UV_TRANSFORM_velRampTexture_tmp)!=0);
float3x3 l9_3385=(*sc_set2.UserUniforms).velRampTextureTransform;
int2 l9_3386=int2(SC_SOFTWARE_WRAP_MODE_U_velRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_velRampTexture_tmp);
bool l9_3387=(int(SC_USE_UV_MIN_MAX_velRampTexture_tmp)!=0);
float4 l9_3388=(*sc_set2.UserUniforms).velRampTextureUvMinMax;
bool l9_3389=(int(SC_USE_CLAMP_TO_BORDER_velRampTexture_tmp)!=0);
float4 l9_3390=(*sc_set2.UserUniforms).velRampTextureBorderColor;
float l9_3391=0.0;
bool l9_3392=l9_3389&&(!l9_3387);
float l9_3393=1.0;
float l9_3394=l9_3383.x;
int l9_3395=l9_3386.x;
if (l9_3395==1)
{
l9_3394=fract(l9_3394);
}
else
{
if (l9_3395==2)
{
float l9_3396=fract(l9_3394);
float l9_3397=l9_3394-l9_3396;
float l9_3398=step(0.25,fract(l9_3397*0.5));
l9_3394=mix(l9_3396,1.0-l9_3396,fast::clamp(l9_3398,0.0,1.0));
}
}
l9_3383.x=l9_3394;
float l9_3399=l9_3383.y;
int l9_3400=l9_3386.y;
if (l9_3400==1)
{
l9_3399=fract(l9_3399);
}
else
{
if (l9_3400==2)
{
float l9_3401=fract(l9_3399);
float l9_3402=l9_3399-l9_3401;
float l9_3403=step(0.25,fract(l9_3402*0.5));
l9_3399=mix(l9_3401,1.0-l9_3401,fast::clamp(l9_3403,0.0,1.0));
}
}
l9_3383.y=l9_3399;
if (l9_3387)
{
bool l9_3404=l9_3389;
bool l9_3405;
if (l9_3404)
{
l9_3405=l9_3386.x==3;
}
else
{
l9_3405=l9_3404;
}
float l9_3406=l9_3383.x;
float l9_3407=l9_3388.x;
float l9_3408=l9_3388.z;
bool l9_3409=l9_3405;
float l9_3410=l9_3393;
float l9_3411=fast::clamp(l9_3406,l9_3407,l9_3408);
float l9_3412=step(abs(l9_3406-l9_3411),9.9999997e-06);
l9_3410*=(l9_3412+((1.0-float(l9_3409))*(1.0-l9_3412)));
l9_3406=l9_3411;
l9_3383.x=l9_3406;
l9_3393=l9_3410;
bool l9_3413=l9_3389;
bool l9_3414;
if (l9_3413)
{
l9_3414=l9_3386.y==3;
}
else
{
l9_3414=l9_3413;
}
float l9_3415=l9_3383.y;
float l9_3416=l9_3388.y;
float l9_3417=l9_3388.w;
bool l9_3418=l9_3414;
float l9_3419=l9_3393;
float l9_3420=fast::clamp(l9_3415,l9_3416,l9_3417);
float l9_3421=step(abs(l9_3415-l9_3420),9.9999997e-06);
l9_3419*=(l9_3421+((1.0-float(l9_3418))*(1.0-l9_3421)));
l9_3415=l9_3420;
l9_3383.y=l9_3415;
l9_3393=l9_3419;
}
float2 l9_3422=l9_3383;
bool l9_3423=l9_3384;
float3x3 l9_3424=l9_3385;
if (l9_3423)
{
l9_3422=float2((l9_3424*float3(l9_3422,1.0)).xy);
}
float2 l9_3425=l9_3422;
float2 l9_3426=l9_3425;
float2 l9_3427=l9_3426;
l9_3383=l9_3427;
float l9_3428=l9_3383.x;
int l9_3429=l9_3386.x;
bool l9_3430=l9_3392;
float l9_3431=l9_3393;
if ((l9_3429==0)||(l9_3429==3))
{
float l9_3432=l9_3428;
float l9_3433=0.0;
float l9_3434=1.0;
bool l9_3435=l9_3430;
float l9_3436=l9_3431;
float l9_3437=fast::clamp(l9_3432,l9_3433,l9_3434);
float l9_3438=step(abs(l9_3432-l9_3437),9.9999997e-06);
l9_3436*=(l9_3438+((1.0-float(l9_3435))*(1.0-l9_3438)));
l9_3432=l9_3437;
l9_3428=l9_3432;
l9_3431=l9_3436;
}
l9_3383.x=l9_3428;
l9_3393=l9_3431;
float l9_3439=l9_3383.y;
int l9_3440=l9_3386.y;
bool l9_3441=l9_3392;
float l9_3442=l9_3393;
if ((l9_3440==0)||(l9_3440==3))
{
float l9_3443=l9_3439;
float l9_3444=0.0;
float l9_3445=1.0;
bool l9_3446=l9_3441;
float l9_3447=l9_3442;
float l9_3448=fast::clamp(l9_3443,l9_3444,l9_3445);
float l9_3449=step(abs(l9_3443-l9_3448),9.9999997e-06);
l9_3447*=(l9_3449+((1.0-float(l9_3446))*(1.0-l9_3449)));
l9_3443=l9_3448;
l9_3439=l9_3443;
l9_3442=l9_3447;
}
l9_3383.y=l9_3439;
l9_3393=l9_3442;
float2 l9_3450=l9_3383;
int l9_3451=l9_3381;
int l9_3452=l9_3382;
float l9_3453=l9_3391;
float2 l9_3454=l9_3450;
int l9_3455=l9_3451;
int l9_3456=l9_3452;
float3 l9_3457=float3(0.0);
if (l9_3455==0)
{
l9_3457=float3(l9_3454,0.0);
}
else
{
if (l9_3455==1)
{
l9_3457=float3(l9_3454.x,(l9_3454.y*0.5)+(0.5-(float(l9_3456)*0.5)),0.0);
}
else
{
l9_3457=float3(l9_3454,float(l9_3456));
}
}
float3 l9_3458=l9_3457;
float3 l9_3459=l9_3458;
float2 l9_3460=l9_3459.xy;
float l9_3461=l9_3453;
float4 l9_3462=sc_set2.velRampTexture.sample(sc_set2.velRampTextureSmpSC,l9_3460,level(l9_3461));
float4 l9_3463=l9_3462;
float4 l9_3464=l9_3463;
if (l9_3389)
{
l9_3464=mix(l9_3390,l9_3464,float4(l9_3393));
}
float4 l9_3465=l9_3464;
l9_3374=l9_3465;
float4 l9_3466=l9_3374;
float3 l9_3467=l9_3466.xyz;
l9_3369=(l9_3355+l9_3358)*l9_3467;
if (!(SC_DEVICE_CLASS_tmp>=2))
{
l9_3369=l9_3355*l9_3368;
}
}
float3 l9_3468=l9_3369;
float3 l9_3469=l9_3468;
float l9_3470=((N111_gravity/2.0)*(l9_2851-l9_3354))*(l9_2851-l9_3354);
l9_2938.y-=l9_3470;
if (N111_ENABLE_FORCE)
{
float3 l9_3471=float3(((N111_localForce/float3(2.0))*(l9_2851-l9_3354))*(l9_2851-l9_3354));
l9_2939-=l9_3471;
}
if (N111_WORLDFORCE)
{
float4x4 l9_3472=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_3473=l9_3472;
float4 l9_3474=l9_3473[0];
float4 l9_3475=l9_3473[1];
float4 l9_3476=l9_3473[2];
float3x3 l9_3477=float3x3(float3(float3(l9_3474.x,l9_3475.x,l9_3476.x)),float3(float3(l9_3474.y,l9_3475.y,l9_3476.y)),float3(float3(l9_3474.z,l9_3475.z,l9_3476.z)));
float3x3 l9_3478=l9_3477;
l9_3353=(((l9_2940-l9_3469)*l9_3478)+l9_2938)+l9_2939;
}
else
{
if (N111_WORLDSPACE)
{
l9_3353=((l9_2940-l9_3469)+l9_2938)+l9_2939;
}
else
{
float4x4 l9_3479=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_3480=l9_3479;
float4 l9_3481=l9_3480[0];
float4 l9_3482=l9_3480[1];
float4 l9_3483=l9_3480[2];
float3x3 l9_3484=float3x3(float3(float3(l9_3481.x,l9_3482.x,l9_3483.x)),float3(float3(l9_3481.y,l9_3482.y,l9_3483.y)),float3(float3(l9_3481.z,l9_3482.z,l9_3483.z)));
float3x3 l9_3485=l9_3484;
l9_3353=(((l9_2940-l9_3469)+l9_2939)+l9_2938)*l9_3485;
}
}
l9_3353=normalize(l9_3353+float3(N111_EPSILON));
}
float3 l9_3486=float3(0.0,0.0,1.0);
float3 l9_3487=cross(l9_3353,l9_3486);
float3 l9_3488=normalize(l9_3487);
float l9_3489=length(l9_3487);
float l9_3490=dot(l9_3486,l9_3353);
float l9_3491=1.0-l9_3490;
l9_3352=float3x3(float3(((l9_3491*l9_3488.x)*l9_3488.x)+l9_3490,((l9_3491*l9_3488.x)*l9_3488.y)-(l9_3488.z*l9_3489),((l9_3491*l9_3488.z)*l9_3488.x)+(l9_3488.y*l9_3489)),float3(((l9_3491*l9_3488.x)*l9_3488.y)+(l9_3488.z*l9_3489),((l9_3491*l9_3488.y)*l9_3488.y)+l9_3490,((l9_3491*l9_3488.y)*l9_3488.z)-(l9_3488.x*l9_3489)),float3(((l9_3491*l9_3488.z)*l9_3488.x)-(l9_3488.y*l9_3489),((l9_3491*l9_3488.y)*l9_3488.z)+(l9_3488.x*l9_3489),((l9_3491*l9_3488.z)*l9_3488.z)+l9_3490));
}
float3x3 l9_3492=float3x3(float3(cos(l9_3088),-sin(l9_3088),0.0),float3(sin(l9_3088),cos(l9_3088),0.0),float3(0.0,0.0,1.0));
l9_3352=l9_3352*l9_3492;
if (N111_ENABLE_ALIGNTOVEL&&(!N111_ENABLE_IGNOREVEL))
{
float3 l9_3493=l9_3070*(l9_2851-0.0099999998);
float3 l9_3494=l9_3070*(l9_2851+0.0099999998);
N111_position.z*=(length(l9_3494-l9_3493)*fast::max(N111_sizeVelScale,0.1));
}
}
else
{
float l9_3495=fract((N111_particleSeed.x*92.653008)+N111_globalSeed);
float l9_3496=mix(N111_rotationRandomX.x,N111_rotationRandomX.y,l9_3495);
float l9_3497=mix(N111_rotationRateX.x,N111_rotationRateX.y,l9_3495);
float l9_3498=((l9_3497*l9_3085)*l9_2852)*2.0;
float l9_3499=fract((N111_particleSeed.y*6.7557559)+N111_globalSeed);
float l9_3500=mix(N111_rotationRandomY.x,N111_rotationRandomY.y,l9_3499);
float l9_3501=mix(N111_rotationRateY.x,N111_rotationRateY.y,l9_3499);
float l9_3502=((l9_3501*l9_3085)*l9_2852)*2.0;
float l9_3503=N111_PI*(l9_3498+l9_3496);
float l9_3504=N111_PI*(l9_3502+l9_3500);
float l9_3505=N111_PI*(l9_3087+l9_3080);
float3 l9_3506=float3(l9_3503,l9_3504,l9_3505);
float l9_3507=cos(l9_3506.x);
float l9_3508=sin(l9_3506.x);
float l9_3509=cos(l9_3506.y);
float l9_3510=sin(l9_3506.y);
float l9_3511=cos(l9_3506.z);
float l9_3512=sin(l9_3506.z);
l9_3352=float3x3(float3(l9_3509*l9_3511,(l9_3507*l9_3512)+((l9_3508*l9_3510)*l9_3511),(l9_3508*l9_3512)-((l9_3507*l9_3510)*l9_3511)),float3((-l9_3509)*l9_3512,(l9_3507*l9_3511)-((l9_3508*l9_3510)*l9_3512),(l9_3508*l9_3511)+((l9_3507*l9_3510)*l9_3512)),float3(l9_3510,(-l9_3508)*l9_3509,l9_3507*l9_3509));
}
if ((!N111_WORLDSPACE)&&(!N111_ENABLE_ALIGNTOVEL))
{
float4x4 l9_3513=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_3514=(*sc_set2.UserUniforms).sc_ModelMatrix;
float4x4 l9_3515=(*sc_set2.UserUniforms).sc_ModelMatrix;
float3x3 l9_3516=float3x3(float3(l9_3513[0].xyz/float3(l9_3062.x)),float3(l9_3514[1].xyz/float3(l9_3062.y)),float3(l9_3515[2].xyz/float3(l9_3062.z)));
l9_3352=l9_3516*l9_3352;
}
N111_position=l9_3352*N111_position;
N111_normal=normalize(l9_3352*N111_normalObjectSpace);
N111_position+=l9_3079;
}
N111_timeValues=float4(l9_2850,l9_2851,l9_2852);
l9_2828=N111_timeValues;
l9_2787=l9_2828;
l9_2597=l9_2787;
out.Interpolator0.y=l9_2597.x;
out.Interpolator0.z=l9_2597.y;
out.Interpolator0.w=l9_2597.z;
out.Interpolator1.x=l9_2597.w;
if (PreviewInfo.Saved)
{
out.PreviewVertexColor=float4(PreviewInfo.Color.xyz,1.0);
out.PreviewVertexSaved=1.0;
}
return out;
}
} // VERTEX SHADER


namespace SNAP_FS {
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
float2 Surface_UVCoord1;
float gInstanceID;
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
float timeGlobal;
float externalTimeInput;
float externalSeed;
float lifeTimeConstant;
float2 lifeTimeMinMax;
float spawnDuration;
float3 spawnLocation;
float3 spawnBox;
float3 spawnSphere;
float3 noiseMult;
float3 noiseFrequency;
float3 sNoiseMult;
float3 sNoiseFrequency;
float3 velocityMin;
float3 velocityMax;
float3 velocityDrag;
float4 velRampTextureSize;
float4 velRampTextureDims;
float4 velRampTextureView;
float3x3 velRampTextureTransform;
float4 velRampTextureUvMinMax;
float4 velRampTextureBorderColor;
float2 sizeStart;
float3 sizeStart3D;
float2 sizeEnd;
float3 sizeEnd3D;
float2 sizeStartMin;
float3 sizeStartMin3D;
float2 sizeStartMax;
float3 sizeStartMax3D;
float2 sizeEndMin;
float3 sizeEndMin3D;
float2 sizeEndMax;
float3 sizeEndMax3D;
float sizeSpeed;
float4 sizeRampTextureSize;
float4 sizeRampTextureDims;
float4 sizeRampTextureView;
float3x3 sizeRampTextureTransform;
float4 sizeRampTextureUvMinMax;
float4 sizeRampTextureBorderColor;
float gravity;
float3 localForce;
float sizeVelScale;
int ALIGNTOX;
int ALIGNTOY;
int ALIGNTOZ;
float2 rotationRandomX;
float2 rotationRateX;
float2 randomRotationY;
float2 rotationRateY;
float2 rotationRandom;
float2 randomRotationZ;
float2 rotationRate;
float2 rotationRateZ;
float rotationDrag;
int CENTER_BBOX;
float fadeDistanceVisible;
float fadeDistanceInvisible;
float3 colorStart;
float3 colorEnd;
float3 colorMinStart;
float3 colorMinEnd;
float3 colorMaxStart;
float3 colorMaxEnd;
float alphaStart;
float alphaEnd;
float alphaMinStart;
float alphaMinEnd;
float alphaMaxStart;
float alphaMaxEnd;
float alphaDissolveMult;
float numValidFrames;
float2 gridSize;
float flipBookSpeedMult;
float flipBookRandomStart;
float4 colorRampTextureSize;
float4 colorRampTextureDims;
float4 colorRampTextureView;
float3x3 colorRampTextureTransform;
float4 colorRampTextureUvMinMax;
float4 colorRampTextureBorderColor;
float4 colorRampMult;
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float metallic;
float roughness;
float Port_Input1_N119;
float2 Port_Input1_N138;
float2 Port_Input1_N139;
float2 Port_Input1_N140;
float2 Port_Input1_N144;
float Port_Input1_N069;
float Port_Input1_N068;
float Port_Input1_N110;
float Port_Input1_N154;
float3 Port_Default_N167;
float3 Port_Emissive_N014;
float3 Port_AO_N014;
float3 Port_SpecularAO_N014;
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
constant sc_Bones_obj* sc_BonesUBO [[id(0)]];
texture2d<float> colorRampTexture [[id(1)]];
texture2d<float> intensityTexture [[id(2)]];
texture2d<float> mainTexture [[id(3)]];
texture2d<float> normalTex [[id(4)]];
texture2d<float> sc_EnvmapDiffuse [[id(5)]];
texture2d<float> sc_EnvmapSpecular [[id(6)]];
texture2d<float> sc_RayTracedAoTexture [[id(15)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(16)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(17)]];
texture2d<float> sc_RayTracedShadowTexture [[id(18)]];
texture2d<float> sc_SSAOTexture [[id(19)]];
texture2d<float> sc_ScreenTexture [[id(20)]];
texture2d<float> sc_ShadowTexture [[id(21)]];
texture2d<float> sizeRampTexture [[id(23)]];
texture2d<float> velRampTexture [[id(24)]];
sampler colorRampTextureSmpSC [[id(25)]];
sampler intensityTextureSmpSC [[id(26)]];
sampler mainTextureSmpSC [[id(27)]];
sampler normalTexSmpSC [[id(28)]];
sampler sc_EnvmapDiffuseSmpSC [[id(29)]];
sampler sc_EnvmapSpecularSmpSC [[id(30)]];
sampler sc_RayTracedAoTextureSmpSC [[id(32)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(33)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(34)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(35)]];
sampler sc_SSAOTextureSmpSC [[id(36)]];
sampler sc_ScreenTextureSmpSC [[id(37)]];
sampler sc_ShadowTextureSmpSC [[id(38)]];
sampler sizeRampTextureSmpSC [[id(40)]];
sampler velRampTextureSmpSC [[id(41)]];
constant userUniformsObj* UserUniforms [[id(42)]];
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
float Interpolator_gInstanceID [[user(locn13)]];
float4 Interpolator0 [[user(locn14)]];
float4 Interpolator1 [[user(locn15)]];
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
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
float3 calculateDirectSpecular(thread const SurfaceProperties& surfaceProperties,thread const float3& L,thread const float3& V)
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
float l9_10=l9_5/(l9_8+l9_9);
float param_6=NdotL;
float param_7=NdotV;
float param_8=r;
float l9_11=param_6;
float l9_12=param_8;
float l9_13=l9_12+1.0;
l9_13=(l9_13*l9_13)*0.125;
float l9_14=(l9_11*(1.0-l9_13))+l9_13;
float l9_15=param_7;
float l9_16=param_8;
float l9_17=l9_16+1.0;
l9_17=(l9_17*l9_17)*0.125;
float l9_18=(l9_15*(1.0-l9_17))+l9_17;
float l9_19=1.0/(l9_14*l9_18);
float param_9=VdotH;
float3 param_10=F0;
float l9_20=param_9;
float3 l9_21=param_10;
float3 l9_22=float3(1.0);
float l9_23=1.0-l9_20;
float l9_24=l9_23*l9_23;
float l9_25=(l9_24*l9_24)*l9_23;
float3 l9_26=l9_21+((l9_22-l9_21)*l9_25);
float3 l9_27=l9_26;
return l9_27*(((l9_10*l9_19)*0.25)*NdotL);
}
else
{
float specPower=exp2(11.0-(10.0*r));
float param_11=VdotH;
float3 param_12=F0;
float l9_28=param_11;
float3 l9_29=param_12;
float3 l9_30=float3(1.0);
float l9_31=1.0-l9_28;
float l9_32=l9_31*l9_31;
float l9_33=(l9_32*l9_32)*l9_31;
float3 l9_34=l9_29+((l9_30-l9_29)*l9_33);
float3 l9_35=l9_34;
return ((l9_35*((specPower*0.125)+0.25))*pow(NdotH,specPower))*NdotL;
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
float3 N2_colorStart=float3(0.0);
float3 N2_colorEnd=float3(0.0);
bool N2_ENABLE_COLORMINMAX=false;
float3 N2_colorMinStart=float3(0.0);
float3 N2_colorMinEnd=float3(0.0);
float3 N2_colorMaxStart=float3(0.0);
float3 N2_colorMaxEnd=float3(0.0);
bool N2_ENABLE_COLORMONOMIN=false;
float N2_alphaStart=0.0;
float N2_alphaEnd=0.0;
bool N2_ENABLE_ALPHAMINMAX=false;
float N2_alphaMinStart=0.0;
float N2_alphaMinEnd=0.0;
float N2_alphaMaxStart=0.0;
float N2_alphaMaxEnd=0.0;
bool N2_ENABLE_ALPHADISSOLVE=false;
float N2_alphaDissolveMult=0.0;
bool N2_ENABLE_PREMULTIPLIEDCOLOR=false;
bool N2_ENABLE_BLACKASALPHA=false;
bool N2_ENABLE_SCREENFADE=false;
float N2_nearCameraFade=0.0;
bool N2_ENABLE_FLIPBOOK=false;
float N2_numValidFrames=0.0;
float2 N2_gridSize=float2(0.0);
float N2_flipBookSpeedMult=0.0;
float N2_flipBookRandomStart=0.0;
bool N2_ENABLE_FLIPBOOKBLEND=false;
bool N2_ENABLE_FLIPBOOKBYLIFE=false;
bool N2_ENABLE_COLORRAMP=false;
float2 N2_texSize=float2(0.0);
float4 N2_colorRampMult=float4(0.0);
bool N2_ENABLE_NORANDOFFSET=false;
bool N2_ENABLE_BASETEXTURE=false;
float4 N2_timeValuesIn=float4(0.0);
bool N2_ENABLE_WORLDPOSSEED=false;
float N2_externalSeed=0.0;
float3 N2_particleSeed=float3(0.0);
float N2_globalSeed=0.0;
float4 N2_result=float4(0.0);
float2 N2_uv=float2(0.0);
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
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-in.varPos);
Globals.PositionWS=in.varPos;
Globals.VertexTangent_WorldSpace=normalize(in.varTangent.xyz);
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace)*in.varTangent.w;
Globals.Surface_UVCoord0=in.varPackedTex.xy;
Globals.Surface_UVCoord1=in.varPackedTex.zw;
Globals.gInstanceID=in.Interpolator_gInstanceID;
float4 Result_N153=float4(0.0);
float4 param=float4(0.0);
float4 param_1=float4(0.0);
ssGlobals param_3=Globals;
ssGlobals tempGlobals;
float4 param_2;
if ((MESHTYPE_tmp==1)&&(int(PBR_tmp)!=0))
{
float3 l9_2=float3(0.0);
float3 l9_3=(*sc_set2.UserUniforms).colorStart;
l9_2=l9_3;
float3 l9_4=float3(0.0);
float3 l9_5=(*sc_set2.UserUniforms).colorEnd;
l9_4=l9_5;
float3 l9_6=float3(0.0);
float3 l9_7=(*sc_set2.UserUniforms).colorMinStart;
l9_6=l9_7;
float3 l9_8=float3(0.0);
float3 l9_9=(*sc_set2.UserUniforms).colorMinEnd;
l9_8=l9_9;
float3 l9_10=float3(0.0);
float3 l9_11=(*sc_set2.UserUniforms).colorMaxStart;
l9_10=l9_11;
float3 l9_12=float3(0.0);
float3 l9_13=(*sc_set2.UserUniforms).colorMaxEnd;
l9_12=l9_13;
float l9_14=0.0;
float l9_15=(*sc_set2.UserUniforms).alphaStart;
l9_14=l9_15;
float l9_16=0.0;
float l9_17=(*sc_set2.UserUniforms).alphaEnd;
l9_16=l9_17;
float l9_18=0.0;
float l9_19=(*sc_set2.UserUniforms).alphaMinStart;
l9_18=l9_19;
float l9_20=0.0;
float l9_21=(*sc_set2.UserUniforms).alphaMinEnd;
l9_20=l9_21;
float l9_22=0.0;
float l9_23=(*sc_set2.UserUniforms).alphaMaxStart;
l9_22=l9_23;
float l9_24=0.0;
float l9_25=(*sc_set2.UserUniforms).alphaMaxEnd;
l9_24=l9_25;
float l9_26=0.0;
float l9_27=(*sc_set2.UserUniforms).alphaDissolveMult;
l9_26=l9_27;
float l9_28=0.0;
l9_28=in.Interpolator0.x;
float l9_29=0.0;
float l9_30=(*sc_set2.UserUniforms).numValidFrames;
l9_29=l9_30;
float2 l9_31=float2(0.0);
float2 l9_32=(*sc_set2.UserUniforms).gridSize;
l9_31=l9_32;
float l9_33=0.0;
float l9_34=(*sc_set2.UserUniforms).flipBookSpeedMult;
l9_33=l9_34;
float l9_35=0.0;
float l9_36=(*sc_set2.UserUniforms).flipBookRandomStart;
l9_35=l9_36;
float2 l9_37=float2(0.0);
float2 l9_38=(*sc_set2.UserUniforms).colorRampTextureSize.xy;
l9_37=l9_38;
float4 l9_39=float4(0.0);
float4 l9_40=(*sc_set2.UserUniforms).colorRampMult;
l9_39=l9_40;
float4 l9_41=float4(0.0);
float4 l9_42;
l9_42.x=in.Interpolator0.y;
l9_42.y=in.Interpolator0.z;
l9_42.z=in.Interpolator0.w;
l9_42.w=in.Interpolator1.x;
l9_41=l9_42;
float l9_43=0.0;
float l9_44=(*sc_set2.UserUniforms).externalSeed;
l9_43=l9_44;
float4 l9_45=float4(0.0);
float3 l9_46=l9_2;
float3 l9_47=l9_4;
float3 l9_48=l9_6;
float3 l9_49=l9_8;
float3 l9_50=l9_10;
float3 l9_51=l9_12;
float l9_52=l9_14;
float l9_53=l9_16;
float l9_54=l9_18;
float l9_55=l9_20;
float l9_56=l9_22;
float l9_57=l9_24;
float l9_58=l9_26;
float l9_59=l9_28;
float l9_60=l9_29;
float2 l9_61=l9_31;
float l9_62=l9_33;
float l9_63=l9_35;
float2 l9_64=l9_37;
float4 l9_65=l9_39;
float4 l9_66=l9_41;
float l9_67=l9_43;
ssGlobals l9_68=param_3;
tempGlobals=l9_68;
float4 l9_69=float4(0.0);
N2_colorStart=l9_46;
N2_colorEnd=l9_47;
N2_ENABLE_COLORMINMAX=(int(COLORMINMAX_tmp)!=0);
N2_colorMinStart=l9_48;
N2_colorMinEnd=l9_49;
N2_colorMaxStart=l9_50;
N2_colorMaxEnd=l9_51;
N2_ENABLE_COLORMONOMIN=(int(COLORMONOMIN_tmp)!=0);
N2_alphaStart=l9_52;
N2_alphaEnd=l9_53;
N2_ENABLE_ALPHAMINMAX=(int(ALPHAMINMAX_tmp)!=0);
N2_alphaMinStart=l9_54;
N2_alphaMinEnd=l9_55;
N2_alphaMaxStart=l9_56;
N2_alphaMaxEnd=l9_57;
N2_ENABLE_ALPHADISSOLVE=(int(ALPHADISSOLVE_tmp)!=0);
N2_alphaDissolveMult=l9_58;
N2_ENABLE_PREMULTIPLIEDCOLOR=(int(PREMULTIPLIEDCOLOR_tmp)!=0);
N2_ENABLE_BLACKASALPHA=(int(BLACKASALPHA_tmp)!=0);
N2_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N2_nearCameraFade=l9_59;
N2_ENABLE_FLIPBOOK=(int(FLIPBOOK_tmp)!=0);
N2_numValidFrames=l9_60;
N2_gridSize=l9_61;
N2_flipBookSpeedMult=l9_62;
N2_flipBookRandomStart=l9_63;
N2_ENABLE_FLIPBOOKBLEND=(int(FLIPBOOKBLEND_tmp)!=0);
N2_ENABLE_FLIPBOOKBYLIFE=(int(FLIPBOOKBYLIFE_tmp)!=0);
N2_ENABLE_COLORRAMP=(int(COLORRAMP_tmp)!=0);
N2_texSize=l9_64;
N2_colorRampMult=l9_65;
N2_ENABLE_NORANDOFFSET=(int(NORANDOFFSET_tmp)!=0);
N2_ENABLE_BASETEXTURE=(int(BASETEXTURE_tmp)!=0);
N2_timeValuesIn=l9_66;
N2_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N2_externalSeed=l9_67;
float l9_70=0.0;
if (N2_ENABLE_WORLDPOSSEED)
{
float4x4 l9_71=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_70=length(float4(1.0)*l9_71);
}
N2_globalSeed=N2_externalSeed+l9_70;
float l9_72=2000.0;
int l9_73=0;
l9_73=int(tempGlobals.gInstanceID);
int l9_74=l9_73;
float l9_75=float(l9_74);
float2 l9_76=float2(mod(l9_75,l9_72),floor(l9_75/l9_72));
l9_76/=float2(l9_72);
float2 l9_77=l9_76;
float l9_78=dot(l9_77,float2(0.38253,0.42662001));
float3 l9_79=float3(0.457831,0.62343299,0.97625297)*l9_78;
l9_79=sin(l9_79)*float3(479.371,389.53101,513.03497);
l9_79=fract(l9_79);
l9_79=floor(l9_79*10000.0)*9.9999997e-05;
float3 l9_80=l9_79;
float3 l9_81=l9_80;
N2_particleSeed=l9_81;
float l9_82=N2_particleSeed.x;
float l9_83=N2_particleSeed.y;
float l9_84=N2_particleSeed.z;
float3 l9_85=fract((float3(l9_82,l9_83,l9_84)*27.21883)+float3(N2_globalSeed));
if (N2_ENABLE_COLORMONOMIN)
{
l9_85=fract((float3(l9_82,l9_82,l9_82)*27.21883)+float3(N2_globalSeed));
}
float l9_86=fract((N2_particleSeed.x*3121.3333)+N2_globalSeed);
float l9_87=fract((N2_particleSeed.y*13.2234)+N2_globalSeed);
float l9_88=fract((N2_particleSeed.z*3.5358)+N2_globalSeed);
float l9_89=N2_timeValuesIn.w;
float4 l9_90=float4(0.0);
float3 l9_91=float3(0.0);
float3 l9_92=float3(0.0);
float l9_93=0.0;
float l9_94=0.0;
if (N2_ENABLE_COLORMINMAX)
{
l9_91=mix(N2_colorMinStart,N2_colorMaxStart,l9_85);
l9_92=mix(N2_colorMinEnd,N2_colorMaxEnd,l9_85);
}
else
{
l9_91=N2_colorStart;
l9_92=N2_colorEnd;
}
if (N2_ENABLE_ALPHAMINMAX)
{
l9_93=mix(N2_alphaMinStart,N2_alphaMaxStart,l9_86);
l9_94=mix(N2_alphaMinEnd,N2_alphaMaxEnd,l9_86);
}
else
{
l9_93=N2_alphaStart;
l9_94=N2_alphaEnd;
}
l9_91=mix(l9_91,l9_92,float3(l9_89));
l9_93=mix(l9_93,l9_94,l9_89);
l9_90=float4(l9_91,l9_93);
float4 l9_95=float4(0.0);
float2 l9_96=tempGlobals.Surface_UVCoord0;
float2 l9_97=l9_96;
float2 l9_98=tempGlobals.Surface_UVCoord1;
float2 l9_99=l9_98;
float l9_100=fast::max(N2_timeValuesIn.x,0.0099999998);
float l9_101=fast::max(N2_timeValuesIn.y,0.0099999998);
float l9_102=N2_timeValuesIn.z;
if (N2_ENABLE_FLIPBOOKBYLIFE)
{
float l9_103=mix(l9_100,l9_101,l9_88);
l9_102=N2_timeValuesIn.z/l9_103;
}
float l9_104=mix(0.0,N2_flipBookRandomStart,l9_87);
float2 l9_105=l9_97/N2_gridSize;
float l9_106=(l9_102*N2_flipBookSpeedMult)+l9_104;
l9_106=mod(l9_106,N2_numValidFrames);
float l9_107=floor(l9_106)*(1.0/N2_gridSize.x);
float l9_108=mod(floor((-l9_106)/N2_gridSize.x),N2_gridSize.y)*(1.0/N2_gridSize.y);
float l9_109=l9_106+1.0;
l9_109=mod(l9_109,N2_numValidFrames);
float l9_110=floor(l9_109)*(1.0/N2_gridSize.x);
float l9_111=floor((-l9_109)*(1.0/N2_gridSize.x))*(1.0/N2_gridSize.y);
float l9_112=fract(l9_106);
l9_97=l9_105+float2(l9_107,l9_108);
l9_99=l9_105+float2(l9_110,l9_111);
if (N2_ENABLE_FLIPBOOKBLEND)
{
float2 l9_113=l9_97;
float4 l9_114=float4(0.0);
int l9_115=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_116=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_116=0;
}
else
{
l9_116=in.varStereoViewID;
}
int l9_117=l9_116;
l9_115=1-l9_117;
}
else
{
int l9_118=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_118=0;
}
else
{
l9_118=in.varStereoViewID;
}
int l9_119=l9_118;
l9_115=l9_119;
}
int l9_120=l9_115;
int l9_121=mainTextureLayout_tmp;
int l9_122=l9_120;
float2 l9_123=l9_113;
bool l9_124=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_125=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_126=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_127=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_128=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_129=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_130=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_131=0.0;
bool l9_132=l9_129&&(!l9_127);
float l9_133=1.0;
float l9_134=l9_123.x;
int l9_135=l9_126.x;
if (l9_135==1)
{
l9_134=fract(l9_134);
}
else
{
if (l9_135==2)
{
float l9_136=fract(l9_134);
float l9_137=l9_134-l9_136;
float l9_138=step(0.25,fract(l9_137*0.5));
l9_134=mix(l9_136,1.0-l9_136,fast::clamp(l9_138,0.0,1.0));
}
}
l9_123.x=l9_134;
float l9_139=l9_123.y;
int l9_140=l9_126.y;
if (l9_140==1)
{
l9_139=fract(l9_139);
}
else
{
if (l9_140==2)
{
float l9_141=fract(l9_139);
float l9_142=l9_139-l9_141;
float l9_143=step(0.25,fract(l9_142*0.5));
l9_139=mix(l9_141,1.0-l9_141,fast::clamp(l9_143,0.0,1.0));
}
}
l9_123.y=l9_139;
if (l9_127)
{
bool l9_144=l9_129;
bool l9_145;
if (l9_144)
{
l9_145=l9_126.x==3;
}
else
{
l9_145=l9_144;
}
float l9_146=l9_123.x;
float l9_147=l9_128.x;
float l9_148=l9_128.z;
bool l9_149=l9_145;
float l9_150=l9_133;
float l9_151=fast::clamp(l9_146,l9_147,l9_148);
float l9_152=step(abs(l9_146-l9_151),9.9999997e-06);
l9_150*=(l9_152+((1.0-float(l9_149))*(1.0-l9_152)));
l9_146=l9_151;
l9_123.x=l9_146;
l9_133=l9_150;
bool l9_153=l9_129;
bool l9_154;
if (l9_153)
{
l9_154=l9_126.y==3;
}
else
{
l9_154=l9_153;
}
float l9_155=l9_123.y;
float l9_156=l9_128.y;
float l9_157=l9_128.w;
bool l9_158=l9_154;
float l9_159=l9_133;
float l9_160=fast::clamp(l9_155,l9_156,l9_157);
float l9_161=step(abs(l9_155-l9_160),9.9999997e-06);
l9_159*=(l9_161+((1.0-float(l9_158))*(1.0-l9_161)));
l9_155=l9_160;
l9_123.y=l9_155;
l9_133=l9_159;
}
float2 l9_162=l9_123;
bool l9_163=l9_124;
float3x3 l9_164=l9_125;
if (l9_163)
{
l9_162=float2((l9_164*float3(l9_162,1.0)).xy);
}
float2 l9_165=l9_162;
float2 l9_166=l9_165;
float2 l9_167=l9_166;
l9_123=l9_167;
float l9_168=l9_123.x;
int l9_169=l9_126.x;
bool l9_170=l9_132;
float l9_171=l9_133;
if ((l9_169==0)||(l9_169==3))
{
float l9_172=l9_168;
float l9_173=0.0;
float l9_174=1.0;
bool l9_175=l9_170;
float l9_176=l9_171;
float l9_177=fast::clamp(l9_172,l9_173,l9_174);
float l9_178=step(abs(l9_172-l9_177),9.9999997e-06);
l9_176*=(l9_178+((1.0-float(l9_175))*(1.0-l9_178)));
l9_172=l9_177;
l9_168=l9_172;
l9_171=l9_176;
}
l9_123.x=l9_168;
l9_133=l9_171;
float l9_179=l9_123.y;
int l9_180=l9_126.y;
bool l9_181=l9_132;
float l9_182=l9_133;
if ((l9_180==0)||(l9_180==3))
{
float l9_183=l9_179;
float l9_184=0.0;
float l9_185=1.0;
bool l9_186=l9_181;
float l9_187=l9_182;
float l9_188=fast::clamp(l9_183,l9_184,l9_185);
float l9_189=step(abs(l9_183-l9_188),9.9999997e-06);
l9_187*=(l9_189+((1.0-float(l9_186))*(1.0-l9_189)));
l9_183=l9_188;
l9_179=l9_183;
l9_182=l9_187;
}
l9_123.y=l9_179;
l9_133=l9_182;
float2 l9_190=l9_123;
int l9_191=l9_121;
int l9_192=l9_122;
float l9_193=l9_131;
float2 l9_194=l9_190;
int l9_195=l9_191;
int l9_196=l9_192;
float3 l9_197=float3(0.0);
if (l9_195==0)
{
l9_197=float3(l9_194,0.0);
}
else
{
if (l9_195==1)
{
l9_197=float3(l9_194.x,(l9_194.y*0.5)+(0.5-(float(l9_196)*0.5)),0.0);
}
else
{
l9_197=float3(l9_194,float(l9_196));
}
}
float3 l9_198=l9_197;
float3 l9_199=l9_198;
float2 l9_200=l9_199.xy;
float l9_201=l9_193;
float4 l9_202=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_200,bias(l9_201));
float4 l9_203=l9_202;
float4 l9_204=l9_203;
if (l9_129)
{
l9_204=mix(l9_130,l9_204,float4(l9_133));
}
float4 l9_205=l9_204;
l9_114=l9_205;
float4 l9_206=l9_114;
float4 l9_207=l9_206;
float2 l9_208=l9_99;
float4 l9_209=float4(0.0);
int l9_210=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_211=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_211=0;
}
else
{
l9_211=in.varStereoViewID;
}
int l9_212=l9_211;
l9_210=1-l9_212;
}
else
{
int l9_213=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_213=0;
}
else
{
l9_213=in.varStereoViewID;
}
int l9_214=l9_213;
l9_210=l9_214;
}
int l9_215=l9_210;
int l9_216=mainTextureLayout_tmp;
int l9_217=l9_215;
float2 l9_218=l9_208;
bool l9_219=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_220=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_221=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_222=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_223=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_224=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_225=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_226=0.0;
bool l9_227=l9_224&&(!l9_222);
float l9_228=1.0;
float l9_229=l9_218.x;
int l9_230=l9_221.x;
if (l9_230==1)
{
l9_229=fract(l9_229);
}
else
{
if (l9_230==2)
{
float l9_231=fract(l9_229);
float l9_232=l9_229-l9_231;
float l9_233=step(0.25,fract(l9_232*0.5));
l9_229=mix(l9_231,1.0-l9_231,fast::clamp(l9_233,0.0,1.0));
}
}
l9_218.x=l9_229;
float l9_234=l9_218.y;
int l9_235=l9_221.y;
if (l9_235==1)
{
l9_234=fract(l9_234);
}
else
{
if (l9_235==2)
{
float l9_236=fract(l9_234);
float l9_237=l9_234-l9_236;
float l9_238=step(0.25,fract(l9_237*0.5));
l9_234=mix(l9_236,1.0-l9_236,fast::clamp(l9_238,0.0,1.0));
}
}
l9_218.y=l9_234;
if (l9_222)
{
bool l9_239=l9_224;
bool l9_240;
if (l9_239)
{
l9_240=l9_221.x==3;
}
else
{
l9_240=l9_239;
}
float l9_241=l9_218.x;
float l9_242=l9_223.x;
float l9_243=l9_223.z;
bool l9_244=l9_240;
float l9_245=l9_228;
float l9_246=fast::clamp(l9_241,l9_242,l9_243);
float l9_247=step(abs(l9_241-l9_246),9.9999997e-06);
l9_245*=(l9_247+((1.0-float(l9_244))*(1.0-l9_247)));
l9_241=l9_246;
l9_218.x=l9_241;
l9_228=l9_245;
bool l9_248=l9_224;
bool l9_249;
if (l9_248)
{
l9_249=l9_221.y==3;
}
else
{
l9_249=l9_248;
}
float l9_250=l9_218.y;
float l9_251=l9_223.y;
float l9_252=l9_223.w;
bool l9_253=l9_249;
float l9_254=l9_228;
float l9_255=fast::clamp(l9_250,l9_251,l9_252);
float l9_256=step(abs(l9_250-l9_255),9.9999997e-06);
l9_254*=(l9_256+((1.0-float(l9_253))*(1.0-l9_256)));
l9_250=l9_255;
l9_218.y=l9_250;
l9_228=l9_254;
}
float2 l9_257=l9_218;
bool l9_258=l9_219;
float3x3 l9_259=l9_220;
if (l9_258)
{
l9_257=float2((l9_259*float3(l9_257,1.0)).xy);
}
float2 l9_260=l9_257;
float2 l9_261=l9_260;
float2 l9_262=l9_261;
l9_218=l9_262;
float l9_263=l9_218.x;
int l9_264=l9_221.x;
bool l9_265=l9_227;
float l9_266=l9_228;
if ((l9_264==0)||(l9_264==3))
{
float l9_267=l9_263;
float l9_268=0.0;
float l9_269=1.0;
bool l9_270=l9_265;
float l9_271=l9_266;
float l9_272=fast::clamp(l9_267,l9_268,l9_269);
float l9_273=step(abs(l9_267-l9_272),9.9999997e-06);
l9_271*=(l9_273+((1.0-float(l9_270))*(1.0-l9_273)));
l9_267=l9_272;
l9_263=l9_267;
l9_266=l9_271;
}
l9_218.x=l9_263;
l9_228=l9_266;
float l9_274=l9_218.y;
int l9_275=l9_221.y;
bool l9_276=l9_227;
float l9_277=l9_228;
if ((l9_275==0)||(l9_275==3))
{
float l9_278=l9_274;
float l9_279=0.0;
float l9_280=1.0;
bool l9_281=l9_276;
float l9_282=l9_277;
float l9_283=fast::clamp(l9_278,l9_279,l9_280);
float l9_284=step(abs(l9_278-l9_283),9.9999997e-06);
l9_282*=(l9_284+((1.0-float(l9_281))*(1.0-l9_284)));
l9_278=l9_283;
l9_274=l9_278;
l9_277=l9_282;
}
l9_218.y=l9_274;
l9_228=l9_277;
float2 l9_285=l9_218;
int l9_286=l9_216;
int l9_287=l9_217;
float l9_288=l9_226;
float2 l9_289=l9_285;
int l9_290=l9_286;
int l9_291=l9_287;
float3 l9_292=float3(0.0);
if (l9_290==0)
{
l9_292=float3(l9_289,0.0);
}
else
{
if (l9_290==1)
{
l9_292=float3(l9_289.x,(l9_289.y*0.5)+(0.5-(float(l9_291)*0.5)),0.0);
}
else
{
l9_292=float3(l9_289,float(l9_291));
}
}
float3 l9_293=l9_292;
float3 l9_294=l9_293;
float2 l9_295=l9_294.xy;
float l9_296=l9_288;
float4 l9_297=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_295,bias(l9_296));
float4 l9_298=l9_297;
float4 l9_299=l9_298;
if (l9_224)
{
l9_299=mix(l9_225,l9_299,float4(l9_228));
}
float4 l9_300=l9_299;
l9_209=l9_300;
float4 l9_301=l9_209;
l9_95=mix(l9_207,l9_301,float4(l9_112));
}
else
{
float2 l9_302=l9_97;
float4 l9_303=float4(0.0);
int l9_304=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
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
int l9_310=mainTextureLayout_tmp;
int l9_311=l9_309;
float2 l9_312=l9_302;
bool l9_313=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_314=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_315=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_316=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_317=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_318=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_319=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_320=0.0;
bool l9_321=l9_318&&(!l9_316);
float l9_322=1.0;
float l9_323=l9_312.x;
int l9_324=l9_315.x;
if (l9_324==1)
{
l9_323=fract(l9_323);
}
else
{
if (l9_324==2)
{
float l9_325=fract(l9_323);
float l9_326=l9_323-l9_325;
float l9_327=step(0.25,fract(l9_326*0.5));
l9_323=mix(l9_325,1.0-l9_325,fast::clamp(l9_327,0.0,1.0));
}
}
l9_312.x=l9_323;
float l9_328=l9_312.y;
int l9_329=l9_315.y;
if (l9_329==1)
{
l9_328=fract(l9_328);
}
else
{
if (l9_329==2)
{
float l9_330=fract(l9_328);
float l9_331=l9_328-l9_330;
float l9_332=step(0.25,fract(l9_331*0.5));
l9_328=mix(l9_330,1.0-l9_330,fast::clamp(l9_332,0.0,1.0));
}
}
l9_312.y=l9_328;
if (l9_316)
{
bool l9_333=l9_318;
bool l9_334;
if (l9_333)
{
l9_334=l9_315.x==3;
}
else
{
l9_334=l9_333;
}
float l9_335=l9_312.x;
float l9_336=l9_317.x;
float l9_337=l9_317.z;
bool l9_338=l9_334;
float l9_339=l9_322;
float l9_340=fast::clamp(l9_335,l9_336,l9_337);
float l9_341=step(abs(l9_335-l9_340),9.9999997e-06);
l9_339*=(l9_341+((1.0-float(l9_338))*(1.0-l9_341)));
l9_335=l9_340;
l9_312.x=l9_335;
l9_322=l9_339;
bool l9_342=l9_318;
bool l9_343;
if (l9_342)
{
l9_343=l9_315.y==3;
}
else
{
l9_343=l9_342;
}
float l9_344=l9_312.y;
float l9_345=l9_317.y;
float l9_346=l9_317.w;
bool l9_347=l9_343;
float l9_348=l9_322;
float l9_349=fast::clamp(l9_344,l9_345,l9_346);
float l9_350=step(abs(l9_344-l9_349),9.9999997e-06);
l9_348*=(l9_350+((1.0-float(l9_347))*(1.0-l9_350)));
l9_344=l9_349;
l9_312.y=l9_344;
l9_322=l9_348;
}
float2 l9_351=l9_312;
bool l9_352=l9_313;
float3x3 l9_353=l9_314;
if (l9_352)
{
l9_351=float2((l9_353*float3(l9_351,1.0)).xy);
}
float2 l9_354=l9_351;
float2 l9_355=l9_354;
float2 l9_356=l9_355;
l9_312=l9_356;
float l9_357=l9_312.x;
int l9_358=l9_315.x;
bool l9_359=l9_321;
float l9_360=l9_322;
if ((l9_358==0)||(l9_358==3))
{
float l9_361=l9_357;
float l9_362=0.0;
float l9_363=1.0;
bool l9_364=l9_359;
float l9_365=l9_360;
float l9_366=fast::clamp(l9_361,l9_362,l9_363);
float l9_367=step(abs(l9_361-l9_366),9.9999997e-06);
l9_365*=(l9_367+((1.0-float(l9_364))*(1.0-l9_367)));
l9_361=l9_366;
l9_357=l9_361;
l9_360=l9_365;
}
l9_312.x=l9_357;
l9_322=l9_360;
float l9_368=l9_312.y;
int l9_369=l9_315.y;
bool l9_370=l9_321;
float l9_371=l9_322;
if ((l9_369==0)||(l9_369==3))
{
float l9_372=l9_368;
float l9_373=0.0;
float l9_374=1.0;
bool l9_375=l9_370;
float l9_376=l9_371;
float l9_377=fast::clamp(l9_372,l9_373,l9_374);
float l9_378=step(abs(l9_372-l9_377),9.9999997e-06);
l9_376*=(l9_378+((1.0-float(l9_375))*(1.0-l9_378)));
l9_372=l9_377;
l9_368=l9_372;
l9_371=l9_376;
}
l9_312.y=l9_368;
l9_322=l9_371;
float2 l9_379=l9_312;
int l9_380=l9_310;
int l9_381=l9_311;
float l9_382=l9_320;
float2 l9_383=l9_379;
int l9_384=l9_380;
int l9_385=l9_381;
float3 l9_386=float3(0.0);
if (l9_384==0)
{
l9_386=float3(l9_383,0.0);
}
else
{
if (l9_384==1)
{
l9_386=float3(l9_383.x,(l9_383.y*0.5)+(0.5-(float(l9_385)*0.5)),0.0);
}
else
{
l9_386=float3(l9_383,float(l9_385));
}
}
float3 l9_387=l9_386;
float3 l9_388=l9_387;
float2 l9_389=l9_388.xy;
float l9_390=l9_382;
float4 l9_391=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_389,bias(l9_390));
float4 l9_392=l9_391;
float4 l9_393=l9_392;
if (l9_318)
{
l9_393=mix(l9_319,l9_393,float4(l9_322));
}
float4 l9_394=l9_393;
l9_303=l9_394;
float4 l9_395=l9_303;
l9_95=l9_395;
}
float4 l9_396=float4(0.0);
float l9_397=ceil(l9_89*N2_texSize.x)/N2_texSize.x;
float l9_398=l9_397;
if (N2_ENABLE_NORANDOFFSET)
{
float2 l9_399=tempGlobals.Surface_UVCoord0;
l9_398+=(l9_399.x/N2_texSize.x);
}
float2 l9_400=float2(l9_398,0.5);
float4 l9_401=float4(0.0);
int l9_402=0;
if ((int(colorRampTextureHasSwappedViews_tmp)!=0))
{
int l9_403=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_403=0;
}
else
{
l9_403=in.varStereoViewID;
}
int l9_404=l9_403;
l9_402=1-l9_404;
}
else
{
int l9_405=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_405=0;
}
else
{
l9_405=in.varStereoViewID;
}
int l9_406=l9_405;
l9_402=l9_406;
}
int l9_407=l9_402;
int l9_408=colorRampTextureLayout_tmp;
int l9_409=l9_407;
float2 l9_410=l9_400;
bool l9_411=(int(SC_USE_UV_TRANSFORM_colorRampTexture_tmp)!=0);
float3x3 l9_412=(*sc_set2.UserUniforms).colorRampTextureTransform;
int2 l9_413=int2(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_colorRampTexture_tmp);
bool l9_414=(int(SC_USE_UV_MIN_MAX_colorRampTexture_tmp)!=0);
float4 l9_415=(*sc_set2.UserUniforms).colorRampTextureUvMinMax;
bool l9_416=(int(SC_USE_CLAMP_TO_BORDER_colorRampTexture_tmp)!=0);
float4 l9_417=(*sc_set2.UserUniforms).colorRampTextureBorderColor;
float l9_418=0.0;
bool l9_419=l9_416&&(!l9_414);
float l9_420=1.0;
float l9_421=l9_410.x;
int l9_422=l9_413.x;
if (l9_422==1)
{
l9_421=fract(l9_421);
}
else
{
if (l9_422==2)
{
float l9_423=fract(l9_421);
float l9_424=l9_421-l9_423;
float l9_425=step(0.25,fract(l9_424*0.5));
l9_421=mix(l9_423,1.0-l9_423,fast::clamp(l9_425,0.0,1.0));
}
}
l9_410.x=l9_421;
float l9_426=l9_410.y;
int l9_427=l9_413.y;
if (l9_427==1)
{
l9_426=fract(l9_426);
}
else
{
if (l9_427==2)
{
float l9_428=fract(l9_426);
float l9_429=l9_426-l9_428;
float l9_430=step(0.25,fract(l9_429*0.5));
l9_426=mix(l9_428,1.0-l9_428,fast::clamp(l9_430,0.0,1.0));
}
}
l9_410.y=l9_426;
if (l9_414)
{
bool l9_431=l9_416;
bool l9_432;
if (l9_431)
{
l9_432=l9_413.x==3;
}
else
{
l9_432=l9_431;
}
float l9_433=l9_410.x;
float l9_434=l9_415.x;
float l9_435=l9_415.z;
bool l9_436=l9_432;
float l9_437=l9_420;
float l9_438=fast::clamp(l9_433,l9_434,l9_435);
float l9_439=step(abs(l9_433-l9_438),9.9999997e-06);
l9_437*=(l9_439+((1.0-float(l9_436))*(1.0-l9_439)));
l9_433=l9_438;
l9_410.x=l9_433;
l9_420=l9_437;
bool l9_440=l9_416;
bool l9_441;
if (l9_440)
{
l9_441=l9_413.y==3;
}
else
{
l9_441=l9_440;
}
float l9_442=l9_410.y;
float l9_443=l9_415.y;
float l9_444=l9_415.w;
bool l9_445=l9_441;
float l9_446=l9_420;
float l9_447=fast::clamp(l9_442,l9_443,l9_444);
float l9_448=step(abs(l9_442-l9_447),9.9999997e-06);
l9_446*=(l9_448+((1.0-float(l9_445))*(1.0-l9_448)));
l9_442=l9_447;
l9_410.y=l9_442;
l9_420=l9_446;
}
float2 l9_449=l9_410;
bool l9_450=l9_411;
float3x3 l9_451=l9_412;
if (l9_450)
{
l9_449=float2((l9_451*float3(l9_449,1.0)).xy);
}
float2 l9_452=l9_449;
float2 l9_453=l9_452;
float2 l9_454=l9_453;
l9_410=l9_454;
float l9_455=l9_410.x;
int l9_456=l9_413.x;
bool l9_457=l9_419;
float l9_458=l9_420;
if ((l9_456==0)||(l9_456==3))
{
float l9_459=l9_455;
float l9_460=0.0;
float l9_461=1.0;
bool l9_462=l9_457;
float l9_463=l9_458;
float l9_464=fast::clamp(l9_459,l9_460,l9_461);
float l9_465=step(abs(l9_459-l9_464),9.9999997e-06);
l9_463*=(l9_465+((1.0-float(l9_462))*(1.0-l9_465)));
l9_459=l9_464;
l9_455=l9_459;
l9_458=l9_463;
}
l9_410.x=l9_455;
l9_420=l9_458;
float l9_466=l9_410.y;
int l9_467=l9_413.y;
bool l9_468=l9_419;
float l9_469=l9_420;
if ((l9_467==0)||(l9_467==3))
{
float l9_470=l9_466;
float l9_471=0.0;
float l9_472=1.0;
bool l9_473=l9_468;
float l9_474=l9_469;
float l9_475=fast::clamp(l9_470,l9_471,l9_472);
float l9_476=step(abs(l9_470-l9_475),9.9999997e-06);
l9_474*=(l9_476+((1.0-float(l9_473))*(1.0-l9_476)));
l9_470=l9_475;
l9_466=l9_470;
l9_469=l9_474;
}
l9_410.y=l9_466;
l9_420=l9_469;
float2 l9_477=l9_410;
int l9_478=l9_408;
int l9_479=l9_409;
float l9_480=l9_418;
float2 l9_481=l9_477;
int l9_482=l9_478;
int l9_483=l9_479;
float3 l9_484=float3(0.0);
if (l9_482==0)
{
l9_484=float3(l9_481,0.0);
}
else
{
if (l9_482==1)
{
l9_484=float3(l9_481.x,(l9_481.y*0.5)+(0.5-(float(l9_483)*0.5)),0.0);
}
else
{
l9_484=float3(l9_481,float(l9_483));
}
}
float3 l9_485=l9_484;
float3 l9_486=l9_485;
float2 l9_487=l9_486.xy;
float l9_488=l9_480;
float4 l9_489=sc_set2.colorRampTexture.sample(sc_set2.colorRampTextureSmpSC,l9_487,bias(l9_488));
float4 l9_490=l9_489;
float4 l9_491=l9_490;
if (l9_416)
{
l9_491=mix(l9_417,l9_491,float4(l9_420));
}
float4 l9_492=l9_491;
l9_401=l9_492;
float4 l9_493=l9_401;
l9_396=l9_493*N2_colorRampMult;
float4 l9_494=float4(1.0);
float4 l9_495=float4(1.0);
if (N2_ENABLE_BASETEXTURE)
{
float2 l9_496=tempGlobals.Surface_UVCoord0;
float2 l9_497=l9_496;
float4 l9_498=float4(0.0);
int l9_499=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_500=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_500=0;
}
else
{
l9_500=in.varStereoViewID;
}
int l9_501=l9_500;
l9_499=1-l9_501;
}
else
{
int l9_502=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_502=0;
}
else
{
l9_502=in.varStereoViewID;
}
int l9_503=l9_502;
l9_499=l9_503;
}
int l9_504=l9_499;
int l9_505=mainTextureLayout_tmp;
int l9_506=l9_504;
float2 l9_507=l9_497;
bool l9_508=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_509=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_510=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_511=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_512=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_513=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_514=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_515=0.0;
bool l9_516=l9_513&&(!l9_511);
float l9_517=1.0;
float l9_518=l9_507.x;
int l9_519=l9_510.x;
if (l9_519==1)
{
l9_518=fract(l9_518);
}
else
{
if (l9_519==2)
{
float l9_520=fract(l9_518);
float l9_521=l9_518-l9_520;
float l9_522=step(0.25,fract(l9_521*0.5));
l9_518=mix(l9_520,1.0-l9_520,fast::clamp(l9_522,0.0,1.0));
}
}
l9_507.x=l9_518;
float l9_523=l9_507.y;
int l9_524=l9_510.y;
if (l9_524==1)
{
l9_523=fract(l9_523);
}
else
{
if (l9_524==2)
{
float l9_525=fract(l9_523);
float l9_526=l9_523-l9_525;
float l9_527=step(0.25,fract(l9_526*0.5));
l9_523=mix(l9_525,1.0-l9_525,fast::clamp(l9_527,0.0,1.0));
}
}
l9_507.y=l9_523;
if (l9_511)
{
bool l9_528=l9_513;
bool l9_529;
if (l9_528)
{
l9_529=l9_510.x==3;
}
else
{
l9_529=l9_528;
}
float l9_530=l9_507.x;
float l9_531=l9_512.x;
float l9_532=l9_512.z;
bool l9_533=l9_529;
float l9_534=l9_517;
float l9_535=fast::clamp(l9_530,l9_531,l9_532);
float l9_536=step(abs(l9_530-l9_535),9.9999997e-06);
l9_534*=(l9_536+((1.0-float(l9_533))*(1.0-l9_536)));
l9_530=l9_535;
l9_507.x=l9_530;
l9_517=l9_534;
bool l9_537=l9_513;
bool l9_538;
if (l9_537)
{
l9_538=l9_510.y==3;
}
else
{
l9_538=l9_537;
}
float l9_539=l9_507.y;
float l9_540=l9_512.y;
float l9_541=l9_512.w;
bool l9_542=l9_538;
float l9_543=l9_517;
float l9_544=fast::clamp(l9_539,l9_540,l9_541);
float l9_545=step(abs(l9_539-l9_544),9.9999997e-06);
l9_543*=(l9_545+((1.0-float(l9_542))*(1.0-l9_545)));
l9_539=l9_544;
l9_507.y=l9_539;
l9_517=l9_543;
}
float2 l9_546=l9_507;
bool l9_547=l9_508;
float3x3 l9_548=l9_509;
if (l9_547)
{
l9_546=float2((l9_548*float3(l9_546,1.0)).xy);
}
float2 l9_549=l9_546;
float2 l9_550=l9_549;
float2 l9_551=l9_550;
l9_507=l9_551;
float l9_552=l9_507.x;
int l9_553=l9_510.x;
bool l9_554=l9_516;
float l9_555=l9_517;
if ((l9_553==0)||(l9_553==3))
{
float l9_556=l9_552;
float l9_557=0.0;
float l9_558=1.0;
bool l9_559=l9_554;
float l9_560=l9_555;
float l9_561=fast::clamp(l9_556,l9_557,l9_558);
float l9_562=step(abs(l9_556-l9_561),9.9999997e-06);
l9_560*=(l9_562+((1.0-float(l9_559))*(1.0-l9_562)));
l9_556=l9_561;
l9_552=l9_556;
l9_555=l9_560;
}
l9_507.x=l9_552;
l9_517=l9_555;
float l9_563=l9_507.y;
int l9_564=l9_510.y;
bool l9_565=l9_516;
float l9_566=l9_517;
if ((l9_564==0)||(l9_564==3))
{
float l9_567=l9_563;
float l9_568=0.0;
float l9_569=1.0;
bool l9_570=l9_565;
float l9_571=l9_566;
float l9_572=fast::clamp(l9_567,l9_568,l9_569);
float l9_573=step(abs(l9_567-l9_572),9.9999997e-06);
l9_571*=(l9_573+((1.0-float(l9_570))*(1.0-l9_573)));
l9_567=l9_572;
l9_563=l9_567;
l9_566=l9_571;
}
l9_507.y=l9_563;
l9_517=l9_566;
float2 l9_574=l9_507;
int l9_575=l9_505;
int l9_576=l9_506;
float l9_577=l9_515;
float2 l9_578=l9_574;
int l9_579=l9_575;
int l9_580=l9_576;
float3 l9_581=float3(0.0);
if (l9_579==0)
{
l9_581=float3(l9_578,0.0);
}
else
{
if (l9_579==1)
{
l9_581=float3(l9_578.x,(l9_578.y*0.5)+(0.5-(float(l9_580)*0.5)),0.0);
}
else
{
l9_581=float3(l9_578,float(l9_580));
}
}
float3 l9_582=l9_581;
float3 l9_583=l9_582;
float2 l9_584=l9_583.xy;
float l9_585=l9_577;
float4 l9_586=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_584,bias(l9_585));
float4 l9_587=l9_586;
float4 l9_588=l9_587;
if (l9_513)
{
l9_588=mix(l9_514,l9_588,float4(l9_517));
}
float4 l9_589=l9_588;
l9_498=l9_589;
float4 l9_590=l9_498;
l9_494=l9_590;
float2 l9_591=tempGlobals.Surface_UVCoord0;
N2_uv=l9_591;
if (N2_ENABLE_FLIPBOOK)
{
l9_494=l9_95;
N2_uv=l9_97;
}
}
if (N2_ENABLE_COLORRAMP)
{
if (!(!(SC_DEVICE_CLASS_tmp>=2)))
{
l9_495=l9_396;
}
}
N2_result=(l9_494*l9_90)*l9_495;
if (N2_ENABLE_SCREENFADE)
{
N2_result.w*=N2_nearCameraFade;
}
if (N2_ENABLE_ALPHADISSOLVE)
{
float l9_592=l9_89*N2_alphaDissolveMult;
N2_result.w=fast::clamp(N2_result.w-l9_592,0.0,1.0);
}
if (N2_ENABLE_BLACKASALPHA)
{
float l9_593=length(N2_result.xyz);
N2_result.w=l9_593;
}
if (N2_ENABLE_PREMULTIPLIEDCOLOR)
{
float3 l9_594=N2_result.xyz*N2_result.w;
N2_result=float4(l9_594.x,l9_594.y,l9_594.z,N2_result.w);
}
l9_69=N2_result;
l9_45=l9_69;
float l9_595=0.0;
l9_595=l9_45.w;
float3 l9_596=float3(0.0);
float3 l9_597=float3(0.0);
float3 l9_598=(*sc_set2.UserUniforms).Port_Default_N167;
ssGlobals l9_599=param_3;
float3 l9_600;
if ((int(NORMALTEX_tmp)!=0))
{
float3 l9_601=float3(0.0);
float3 l9_602=(*sc_set2.UserUniforms).colorStart;
l9_601=l9_602;
float3 l9_603=float3(0.0);
float3 l9_604=(*sc_set2.UserUniforms).colorEnd;
l9_603=l9_604;
float3 l9_605=float3(0.0);
float3 l9_606=(*sc_set2.UserUniforms).colorMinStart;
l9_605=l9_606;
float3 l9_607=float3(0.0);
float3 l9_608=(*sc_set2.UserUniforms).colorMinEnd;
l9_607=l9_608;
float3 l9_609=float3(0.0);
float3 l9_610=(*sc_set2.UserUniforms).colorMaxStart;
l9_609=l9_610;
float3 l9_611=float3(0.0);
float3 l9_612=(*sc_set2.UserUniforms).colorMaxEnd;
l9_611=l9_612;
float l9_613=0.0;
float l9_614=(*sc_set2.UserUniforms).alphaStart;
l9_613=l9_614;
float l9_615=0.0;
float l9_616=(*sc_set2.UserUniforms).alphaEnd;
l9_615=l9_616;
float l9_617=0.0;
float l9_618=(*sc_set2.UserUniforms).alphaMinStart;
l9_617=l9_618;
float l9_619=0.0;
float l9_620=(*sc_set2.UserUniforms).alphaMinEnd;
l9_619=l9_620;
float l9_621=0.0;
float l9_622=(*sc_set2.UserUniforms).alphaMaxStart;
l9_621=l9_622;
float l9_623=0.0;
float l9_624=(*sc_set2.UserUniforms).alphaMaxEnd;
l9_623=l9_624;
float l9_625=0.0;
float l9_626=(*sc_set2.UserUniforms).alphaDissolveMult;
l9_625=l9_626;
float l9_627=0.0;
l9_627=in.Interpolator0.x;
float l9_628=0.0;
float l9_629=(*sc_set2.UserUniforms).numValidFrames;
l9_628=l9_629;
float2 l9_630=float2(0.0);
float2 l9_631=(*sc_set2.UserUniforms).gridSize;
l9_630=l9_631;
float l9_632=0.0;
float l9_633=(*sc_set2.UserUniforms).flipBookSpeedMult;
l9_632=l9_633;
float l9_634=0.0;
float l9_635=(*sc_set2.UserUniforms).flipBookRandomStart;
l9_634=l9_635;
float2 l9_636=float2(0.0);
float2 l9_637=(*sc_set2.UserUniforms).colorRampTextureSize.xy;
l9_636=l9_637;
float4 l9_638=float4(0.0);
float4 l9_639=(*sc_set2.UserUniforms).colorRampMult;
l9_638=l9_639;
float4 l9_640=float4(0.0);
float4 l9_641;
l9_641.x=in.Interpolator0.y;
l9_641.y=in.Interpolator0.z;
l9_641.z=in.Interpolator0.w;
l9_641.w=in.Interpolator1.x;
l9_640=l9_641;
float l9_642=0.0;
float l9_643=(*sc_set2.UserUniforms).externalSeed;
l9_642=l9_643;
float2 l9_644=float2(0.0);
float3 l9_645=l9_601;
float3 l9_646=l9_603;
float3 l9_647=l9_605;
float3 l9_648=l9_607;
float3 l9_649=l9_609;
float3 l9_650=l9_611;
float l9_651=l9_613;
float l9_652=l9_615;
float l9_653=l9_617;
float l9_654=l9_619;
float l9_655=l9_621;
float l9_656=l9_623;
float l9_657=l9_625;
float l9_658=l9_627;
float l9_659=l9_628;
float2 l9_660=l9_630;
float l9_661=l9_632;
float l9_662=l9_634;
float2 l9_663=l9_636;
float4 l9_664=l9_638;
float4 l9_665=l9_640;
float l9_666=l9_642;
ssGlobals l9_667=l9_599;
tempGlobals=l9_667;
float2 l9_668=float2(0.0);
N2_colorStart=l9_645;
N2_colorEnd=l9_646;
N2_ENABLE_COLORMINMAX=(int(COLORMINMAX_tmp)!=0);
N2_colorMinStart=l9_647;
N2_colorMinEnd=l9_648;
N2_colorMaxStart=l9_649;
N2_colorMaxEnd=l9_650;
N2_ENABLE_COLORMONOMIN=(int(COLORMONOMIN_tmp)!=0);
N2_alphaStart=l9_651;
N2_alphaEnd=l9_652;
N2_ENABLE_ALPHAMINMAX=(int(ALPHAMINMAX_tmp)!=0);
N2_alphaMinStart=l9_653;
N2_alphaMinEnd=l9_654;
N2_alphaMaxStart=l9_655;
N2_alphaMaxEnd=l9_656;
N2_ENABLE_ALPHADISSOLVE=(int(ALPHADISSOLVE_tmp)!=0);
N2_alphaDissolveMult=l9_657;
N2_ENABLE_PREMULTIPLIEDCOLOR=(int(PREMULTIPLIEDCOLOR_tmp)!=0);
N2_ENABLE_BLACKASALPHA=(int(BLACKASALPHA_tmp)!=0);
N2_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N2_nearCameraFade=l9_658;
N2_ENABLE_FLIPBOOK=(int(FLIPBOOK_tmp)!=0);
N2_numValidFrames=l9_659;
N2_gridSize=l9_660;
N2_flipBookSpeedMult=l9_661;
N2_flipBookRandomStart=l9_662;
N2_ENABLE_FLIPBOOKBLEND=(int(FLIPBOOKBLEND_tmp)!=0);
N2_ENABLE_FLIPBOOKBYLIFE=(int(FLIPBOOKBYLIFE_tmp)!=0);
N2_ENABLE_COLORRAMP=(int(COLORRAMP_tmp)!=0);
N2_texSize=l9_663;
N2_colorRampMult=l9_664;
N2_ENABLE_NORANDOFFSET=(int(NORANDOFFSET_tmp)!=0);
N2_ENABLE_BASETEXTURE=(int(BASETEXTURE_tmp)!=0);
N2_timeValuesIn=l9_665;
N2_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N2_externalSeed=l9_666;
float l9_669=0.0;
if (N2_ENABLE_WORLDPOSSEED)
{
float4x4 l9_670=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_669=length(float4(1.0)*l9_670);
}
N2_globalSeed=N2_externalSeed+l9_669;
float l9_671=2000.0;
int l9_672=0;
l9_672=int(tempGlobals.gInstanceID);
int l9_673=l9_672;
float l9_674=float(l9_673);
float2 l9_675=float2(mod(l9_674,l9_671),floor(l9_674/l9_671));
l9_675/=float2(l9_671);
float2 l9_676=l9_675;
float l9_677=dot(l9_676,float2(0.38253,0.42662001));
float3 l9_678=float3(0.457831,0.62343299,0.97625297)*l9_677;
l9_678=sin(l9_678)*float3(479.371,389.53101,513.03497);
l9_678=fract(l9_678);
l9_678=floor(l9_678*10000.0)*9.9999997e-05;
float3 l9_679=l9_678;
float3 l9_680=l9_679;
N2_particleSeed=l9_680;
float l9_681=N2_particleSeed.x;
float l9_682=N2_particleSeed.y;
float l9_683=N2_particleSeed.z;
float3 l9_684=fract((float3(l9_681,l9_682,l9_683)*27.21883)+float3(N2_globalSeed));
if (N2_ENABLE_COLORMONOMIN)
{
l9_684=fract((float3(l9_681,l9_681,l9_681)*27.21883)+float3(N2_globalSeed));
}
float l9_685=fract((N2_particleSeed.x*3121.3333)+N2_globalSeed);
float l9_686=fract((N2_particleSeed.y*13.2234)+N2_globalSeed);
float l9_687=fract((N2_particleSeed.z*3.5358)+N2_globalSeed);
float l9_688=N2_timeValuesIn.w;
float4 l9_689=float4(0.0);
float3 l9_690=float3(0.0);
float3 l9_691=float3(0.0);
float l9_692=0.0;
float l9_693=0.0;
if (N2_ENABLE_COLORMINMAX)
{
l9_690=mix(N2_colorMinStart,N2_colorMaxStart,l9_684);
l9_691=mix(N2_colorMinEnd,N2_colorMaxEnd,l9_684);
}
else
{
l9_690=N2_colorStart;
l9_691=N2_colorEnd;
}
if (N2_ENABLE_ALPHAMINMAX)
{
l9_692=mix(N2_alphaMinStart,N2_alphaMaxStart,l9_685);
l9_693=mix(N2_alphaMinEnd,N2_alphaMaxEnd,l9_685);
}
else
{
l9_692=N2_alphaStart;
l9_693=N2_alphaEnd;
}
l9_690=mix(l9_690,l9_691,float3(l9_688));
l9_692=mix(l9_692,l9_693,l9_688);
l9_689=float4(l9_690,l9_692);
float4 l9_694=float4(0.0);
float2 l9_695=tempGlobals.Surface_UVCoord0;
float2 l9_696=l9_695;
float2 l9_697=tempGlobals.Surface_UVCoord1;
float2 l9_698=l9_697;
float l9_699=fast::max(N2_timeValuesIn.x,0.0099999998);
float l9_700=fast::max(N2_timeValuesIn.y,0.0099999998);
float l9_701=N2_timeValuesIn.z;
if (N2_ENABLE_FLIPBOOKBYLIFE)
{
float l9_702=mix(l9_699,l9_700,l9_687);
l9_701=N2_timeValuesIn.z/l9_702;
}
float l9_703=mix(0.0,N2_flipBookRandomStart,l9_686);
float2 l9_704=l9_696/N2_gridSize;
float l9_705=(l9_701*N2_flipBookSpeedMult)+l9_703;
l9_705=mod(l9_705,N2_numValidFrames);
float l9_706=floor(l9_705)*(1.0/N2_gridSize.x);
float l9_707=mod(floor((-l9_705)/N2_gridSize.x),N2_gridSize.y)*(1.0/N2_gridSize.y);
float l9_708=l9_705+1.0;
l9_708=mod(l9_708,N2_numValidFrames);
float l9_709=floor(l9_708)*(1.0/N2_gridSize.x);
float l9_710=floor((-l9_708)*(1.0/N2_gridSize.x))*(1.0/N2_gridSize.y);
float l9_711=fract(l9_705);
l9_696=l9_704+float2(l9_706,l9_707);
l9_698=l9_704+float2(l9_709,l9_710);
if (N2_ENABLE_FLIPBOOKBLEND)
{
float2 l9_712=l9_696;
float4 l9_713=float4(0.0);
int l9_714=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_715=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_715=0;
}
else
{
l9_715=in.varStereoViewID;
}
int l9_716=l9_715;
l9_714=1-l9_716;
}
else
{
int l9_717=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_717=0;
}
else
{
l9_717=in.varStereoViewID;
}
int l9_718=l9_717;
l9_714=l9_718;
}
int l9_719=l9_714;
int l9_720=mainTextureLayout_tmp;
int l9_721=l9_719;
float2 l9_722=l9_712;
bool l9_723=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_724=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_725=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_726=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_727=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_728=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_729=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_730=0.0;
bool l9_731=l9_728&&(!l9_726);
float l9_732=1.0;
float l9_733=l9_722.x;
int l9_734=l9_725.x;
if (l9_734==1)
{
l9_733=fract(l9_733);
}
else
{
if (l9_734==2)
{
float l9_735=fract(l9_733);
float l9_736=l9_733-l9_735;
float l9_737=step(0.25,fract(l9_736*0.5));
l9_733=mix(l9_735,1.0-l9_735,fast::clamp(l9_737,0.0,1.0));
}
}
l9_722.x=l9_733;
float l9_738=l9_722.y;
int l9_739=l9_725.y;
if (l9_739==1)
{
l9_738=fract(l9_738);
}
else
{
if (l9_739==2)
{
float l9_740=fract(l9_738);
float l9_741=l9_738-l9_740;
float l9_742=step(0.25,fract(l9_741*0.5));
l9_738=mix(l9_740,1.0-l9_740,fast::clamp(l9_742,0.0,1.0));
}
}
l9_722.y=l9_738;
if (l9_726)
{
bool l9_743=l9_728;
bool l9_744;
if (l9_743)
{
l9_744=l9_725.x==3;
}
else
{
l9_744=l9_743;
}
float l9_745=l9_722.x;
float l9_746=l9_727.x;
float l9_747=l9_727.z;
bool l9_748=l9_744;
float l9_749=l9_732;
float l9_750=fast::clamp(l9_745,l9_746,l9_747);
float l9_751=step(abs(l9_745-l9_750),9.9999997e-06);
l9_749*=(l9_751+((1.0-float(l9_748))*(1.0-l9_751)));
l9_745=l9_750;
l9_722.x=l9_745;
l9_732=l9_749;
bool l9_752=l9_728;
bool l9_753;
if (l9_752)
{
l9_753=l9_725.y==3;
}
else
{
l9_753=l9_752;
}
float l9_754=l9_722.y;
float l9_755=l9_727.y;
float l9_756=l9_727.w;
bool l9_757=l9_753;
float l9_758=l9_732;
float l9_759=fast::clamp(l9_754,l9_755,l9_756);
float l9_760=step(abs(l9_754-l9_759),9.9999997e-06);
l9_758*=(l9_760+((1.0-float(l9_757))*(1.0-l9_760)));
l9_754=l9_759;
l9_722.y=l9_754;
l9_732=l9_758;
}
float2 l9_761=l9_722;
bool l9_762=l9_723;
float3x3 l9_763=l9_724;
if (l9_762)
{
l9_761=float2((l9_763*float3(l9_761,1.0)).xy);
}
float2 l9_764=l9_761;
float2 l9_765=l9_764;
float2 l9_766=l9_765;
l9_722=l9_766;
float l9_767=l9_722.x;
int l9_768=l9_725.x;
bool l9_769=l9_731;
float l9_770=l9_732;
if ((l9_768==0)||(l9_768==3))
{
float l9_771=l9_767;
float l9_772=0.0;
float l9_773=1.0;
bool l9_774=l9_769;
float l9_775=l9_770;
float l9_776=fast::clamp(l9_771,l9_772,l9_773);
float l9_777=step(abs(l9_771-l9_776),9.9999997e-06);
l9_775*=(l9_777+((1.0-float(l9_774))*(1.0-l9_777)));
l9_771=l9_776;
l9_767=l9_771;
l9_770=l9_775;
}
l9_722.x=l9_767;
l9_732=l9_770;
float l9_778=l9_722.y;
int l9_779=l9_725.y;
bool l9_780=l9_731;
float l9_781=l9_732;
if ((l9_779==0)||(l9_779==3))
{
float l9_782=l9_778;
float l9_783=0.0;
float l9_784=1.0;
bool l9_785=l9_780;
float l9_786=l9_781;
float l9_787=fast::clamp(l9_782,l9_783,l9_784);
float l9_788=step(abs(l9_782-l9_787),9.9999997e-06);
l9_786*=(l9_788+((1.0-float(l9_785))*(1.0-l9_788)));
l9_782=l9_787;
l9_778=l9_782;
l9_781=l9_786;
}
l9_722.y=l9_778;
l9_732=l9_781;
float2 l9_789=l9_722;
int l9_790=l9_720;
int l9_791=l9_721;
float l9_792=l9_730;
float2 l9_793=l9_789;
int l9_794=l9_790;
int l9_795=l9_791;
float3 l9_796=float3(0.0);
if (l9_794==0)
{
l9_796=float3(l9_793,0.0);
}
else
{
if (l9_794==1)
{
l9_796=float3(l9_793.x,(l9_793.y*0.5)+(0.5-(float(l9_795)*0.5)),0.0);
}
else
{
l9_796=float3(l9_793,float(l9_795));
}
}
float3 l9_797=l9_796;
float3 l9_798=l9_797;
float2 l9_799=l9_798.xy;
float l9_800=l9_792;
float4 l9_801=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_799,bias(l9_800));
float4 l9_802=l9_801;
float4 l9_803=l9_802;
if (l9_728)
{
l9_803=mix(l9_729,l9_803,float4(l9_732));
}
float4 l9_804=l9_803;
l9_713=l9_804;
float4 l9_805=l9_713;
float4 l9_806=l9_805;
float2 l9_807=l9_698;
float4 l9_808=float4(0.0);
int l9_809=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_810=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_810=0;
}
else
{
l9_810=in.varStereoViewID;
}
int l9_811=l9_810;
l9_809=1-l9_811;
}
else
{
int l9_812=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_812=0;
}
else
{
l9_812=in.varStereoViewID;
}
int l9_813=l9_812;
l9_809=l9_813;
}
int l9_814=l9_809;
int l9_815=mainTextureLayout_tmp;
int l9_816=l9_814;
float2 l9_817=l9_807;
bool l9_818=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_819=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_820=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_821=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_822=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_823=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_824=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_825=0.0;
bool l9_826=l9_823&&(!l9_821);
float l9_827=1.0;
float l9_828=l9_817.x;
int l9_829=l9_820.x;
if (l9_829==1)
{
l9_828=fract(l9_828);
}
else
{
if (l9_829==2)
{
float l9_830=fract(l9_828);
float l9_831=l9_828-l9_830;
float l9_832=step(0.25,fract(l9_831*0.5));
l9_828=mix(l9_830,1.0-l9_830,fast::clamp(l9_832,0.0,1.0));
}
}
l9_817.x=l9_828;
float l9_833=l9_817.y;
int l9_834=l9_820.y;
if (l9_834==1)
{
l9_833=fract(l9_833);
}
else
{
if (l9_834==2)
{
float l9_835=fract(l9_833);
float l9_836=l9_833-l9_835;
float l9_837=step(0.25,fract(l9_836*0.5));
l9_833=mix(l9_835,1.0-l9_835,fast::clamp(l9_837,0.0,1.0));
}
}
l9_817.y=l9_833;
if (l9_821)
{
bool l9_838=l9_823;
bool l9_839;
if (l9_838)
{
l9_839=l9_820.x==3;
}
else
{
l9_839=l9_838;
}
float l9_840=l9_817.x;
float l9_841=l9_822.x;
float l9_842=l9_822.z;
bool l9_843=l9_839;
float l9_844=l9_827;
float l9_845=fast::clamp(l9_840,l9_841,l9_842);
float l9_846=step(abs(l9_840-l9_845),9.9999997e-06);
l9_844*=(l9_846+((1.0-float(l9_843))*(1.0-l9_846)));
l9_840=l9_845;
l9_817.x=l9_840;
l9_827=l9_844;
bool l9_847=l9_823;
bool l9_848;
if (l9_847)
{
l9_848=l9_820.y==3;
}
else
{
l9_848=l9_847;
}
float l9_849=l9_817.y;
float l9_850=l9_822.y;
float l9_851=l9_822.w;
bool l9_852=l9_848;
float l9_853=l9_827;
float l9_854=fast::clamp(l9_849,l9_850,l9_851);
float l9_855=step(abs(l9_849-l9_854),9.9999997e-06);
l9_853*=(l9_855+((1.0-float(l9_852))*(1.0-l9_855)));
l9_849=l9_854;
l9_817.y=l9_849;
l9_827=l9_853;
}
float2 l9_856=l9_817;
bool l9_857=l9_818;
float3x3 l9_858=l9_819;
if (l9_857)
{
l9_856=float2((l9_858*float3(l9_856,1.0)).xy);
}
float2 l9_859=l9_856;
float2 l9_860=l9_859;
float2 l9_861=l9_860;
l9_817=l9_861;
float l9_862=l9_817.x;
int l9_863=l9_820.x;
bool l9_864=l9_826;
float l9_865=l9_827;
if ((l9_863==0)||(l9_863==3))
{
float l9_866=l9_862;
float l9_867=0.0;
float l9_868=1.0;
bool l9_869=l9_864;
float l9_870=l9_865;
float l9_871=fast::clamp(l9_866,l9_867,l9_868);
float l9_872=step(abs(l9_866-l9_871),9.9999997e-06);
l9_870*=(l9_872+((1.0-float(l9_869))*(1.0-l9_872)));
l9_866=l9_871;
l9_862=l9_866;
l9_865=l9_870;
}
l9_817.x=l9_862;
l9_827=l9_865;
float l9_873=l9_817.y;
int l9_874=l9_820.y;
bool l9_875=l9_826;
float l9_876=l9_827;
if ((l9_874==0)||(l9_874==3))
{
float l9_877=l9_873;
float l9_878=0.0;
float l9_879=1.0;
bool l9_880=l9_875;
float l9_881=l9_876;
float l9_882=fast::clamp(l9_877,l9_878,l9_879);
float l9_883=step(abs(l9_877-l9_882),9.9999997e-06);
l9_881*=(l9_883+((1.0-float(l9_880))*(1.0-l9_883)));
l9_877=l9_882;
l9_873=l9_877;
l9_876=l9_881;
}
l9_817.y=l9_873;
l9_827=l9_876;
float2 l9_884=l9_817;
int l9_885=l9_815;
int l9_886=l9_816;
float l9_887=l9_825;
float2 l9_888=l9_884;
int l9_889=l9_885;
int l9_890=l9_886;
float3 l9_891=float3(0.0);
if (l9_889==0)
{
l9_891=float3(l9_888,0.0);
}
else
{
if (l9_889==1)
{
l9_891=float3(l9_888.x,(l9_888.y*0.5)+(0.5-(float(l9_890)*0.5)),0.0);
}
else
{
l9_891=float3(l9_888,float(l9_890));
}
}
float3 l9_892=l9_891;
float3 l9_893=l9_892;
float2 l9_894=l9_893.xy;
float l9_895=l9_887;
float4 l9_896=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_894,bias(l9_895));
float4 l9_897=l9_896;
float4 l9_898=l9_897;
if (l9_823)
{
l9_898=mix(l9_824,l9_898,float4(l9_827));
}
float4 l9_899=l9_898;
l9_808=l9_899;
float4 l9_900=l9_808;
l9_694=mix(l9_806,l9_900,float4(l9_711));
}
else
{
float2 l9_901=l9_696;
float4 l9_902=float4(0.0);
int l9_903=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_904=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_904=0;
}
else
{
l9_904=in.varStereoViewID;
}
int l9_905=l9_904;
l9_903=1-l9_905;
}
else
{
int l9_906=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_906=0;
}
else
{
l9_906=in.varStereoViewID;
}
int l9_907=l9_906;
l9_903=l9_907;
}
int l9_908=l9_903;
int l9_909=mainTextureLayout_tmp;
int l9_910=l9_908;
float2 l9_911=l9_901;
bool l9_912=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_913=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_914=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_915=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_916=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_917=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_918=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_919=0.0;
bool l9_920=l9_917&&(!l9_915);
float l9_921=1.0;
float l9_922=l9_911.x;
int l9_923=l9_914.x;
if (l9_923==1)
{
l9_922=fract(l9_922);
}
else
{
if (l9_923==2)
{
float l9_924=fract(l9_922);
float l9_925=l9_922-l9_924;
float l9_926=step(0.25,fract(l9_925*0.5));
l9_922=mix(l9_924,1.0-l9_924,fast::clamp(l9_926,0.0,1.0));
}
}
l9_911.x=l9_922;
float l9_927=l9_911.y;
int l9_928=l9_914.y;
if (l9_928==1)
{
l9_927=fract(l9_927);
}
else
{
if (l9_928==2)
{
float l9_929=fract(l9_927);
float l9_930=l9_927-l9_929;
float l9_931=step(0.25,fract(l9_930*0.5));
l9_927=mix(l9_929,1.0-l9_929,fast::clamp(l9_931,0.0,1.0));
}
}
l9_911.y=l9_927;
if (l9_915)
{
bool l9_932=l9_917;
bool l9_933;
if (l9_932)
{
l9_933=l9_914.x==3;
}
else
{
l9_933=l9_932;
}
float l9_934=l9_911.x;
float l9_935=l9_916.x;
float l9_936=l9_916.z;
bool l9_937=l9_933;
float l9_938=l9_921;
float l9_939=fast::clamp(l9_934,l9_935,l9_936);
float l9_940=step(abs(l9_934-l9_939),9.9999997e-06);
l9_938*=(l9_940+((1.0-float(l9_937))*(1.0-l9_940)));
l9_934=l9_939;
l9_911.x=l9_934;
l9_921=l9_938;
bool l9_941=l9_917;
bool l9_942;
if (l9_941)
{
l9_942=l9_914.y==3;
}
else
{
l9_942=l9_941;
}
float l9_943=l9_911.y;
float l9_944=l9_916.y;
float l9_945=l9_916.w;
bool l9_946=l9_942;
float l9_947=l9_921;
float l9_948=fast::clamp(l9_943,l9_944,l9_945);
float l9_949=step(abs(l9_943-l9_948),9.9999997e-06);
l9_947*=(l9_949+((1.0-float(l9_946))*(1.0-l9_949)));
l9_943=l9_948;
l9_911.y=l9_943;
l9_921=l9_947;
}
float2 l9_950=l9_911;
bool l9_951=l9_912;
float3x3 l9_952=l9_913;
if (l9_951)
{
l9_950=float2((l9_952*float3(l9_950,1.0)).xy);
}
float2 l9_953=l9_950;
float2 l9_954=l9_953;
float2 l9_955=l9_954;
l9_911=l9_955;
float l9_956=l9_911.x;
int l9_957=l9_914.x;
bool l9_958=l9_920;
float l9_959=l9_921;
if ((l9_957==0)||(l9_957==3))
{
float l9_960=l9_956;
float l9_961=0.0;
float l9_962=1.0;
bool l9_963=l9_958;
float l9_964=l9_959;
float l9_965=fast::clamp(l9_960,l9_961,l9_962);
float l9_966=step(abs(l9_960-l9_965),9.9999997e-06);
l9_964*=(l9_966+((1.0-float(l9_963))*(1.0-l9_966)));
l9_960=l9_965;
l9_956=l9_960;
l9_959=l9_964;
}
l9_911.x=l9_956;
l9_921=l9_959;
float l9_967=l9_911.y;
int l9_968=l9_914.y;
bool l9_969=l9_920;
float l9_970=l9_921;
if ((l9_968==0)||(l9_968==3))
{
float l9_971=l9_967;
float l9_972=0.0;
float l9_973=1.0;
bool l9_974=l9_969;
float l9_975=l9_970;
float l9_976=fast::clamp(l9_971,l9_972,l9_973);
float l9_977=step(abs(l9_971-l9_976),9.9999997e-06);
l9_975*=(l9_977+((1.0-float(l9_974))*(1.0-l9_977)));
l9_971=l9_976;
l9_967=l9_971;
l9_970=l9_975;
}
l9_911.y=l9_967;
l9_921=l9_970;
float2 l9_978=l9_911;
int l9_979=l9_909;
int l9_980=l9_910;
float l9_981=l9_919;
float2 l9_982=l9_978;
int l9_983=l9_979;
int l9_984=l9_980;
float3 l9_985=float3(0.0);
if (l9_983==0)
{
l9_985=float3(l9_982,0.0);
}
else
{
if (l9_983==1)
{
l9_985=float3(l9_982.x,(l9_982.y*0.5)+(0.5-(float(l9_984)*0.5)),0.0);
}
else
{
l9_985=float3(l9_982,float(l9_984));
}
}
float3 l9_986=l9_985;
float3 l9_987=l9_986;
float2 l9_988=l9_987.xy;
float l9_989=l9_981;
float4 l9_990=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_988,bias(l9_989));
float4 l9_991=l9_990;
float4 l9_992=l9_991;
if (l9_917)
{
l9_992=mix(l9_918,l9_992,float4(l9_921));
}
float4 l9_993=l9_992;
l9_902=l9_993;
float4 l9_994=l9_902;
l9_694=l9_994;
}
float4 l9_995=float4(0.0);
float l9_996=ceil(l9_688*N2_texSize.x)/N2_texSize.x;
float l9_997=l9_996;
if (N2_ENABLE_NORANDOFFSET)
{
float2 l9_998=tempGlobals.Surface_UVCoord0;
l9_997+=(l9_998.x/N2_texSize.x);
}
float2 l9_999=float2(l9_997,0.5);
float4 l9_1000=float4(0.0);
int l9_1001=0;
if ((int(colorRampTextureHasSwappedViews_tmp)!=0))
{
int l9_1002=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1002=0;
}
else
{
l9_1002=in.varStereoViewID;
}
int l9_1003=l9_1002;
l9_1001=1-l9_1003;
}
else
{
int l9_1004=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1004=0;
}
else
{
l9_1004=in.varStereoViewID;
}
int l9_1005=l9_1004;
l9_1001=l9_1005;
}
int l9_1006=l9_1001;
int l9_1007=colorRampTextureLayout_tmp;
int l9_1008=l9_1006;
float2 l9_1009=l9_999;
bool l9_1010=(int(SC_USE_UV_TRANSFORM_colorRampTexture_tmp)!=0);
float3x3 l9_1011=(*sc_set2.UserUniforms).colorRampTextureTransform;
int2 l9_1012=int2(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_colorRampTexture_tmp);
bool l9_1013=(int(SC_USE_UV_MIN_MAX_colorRampTexture_tmp)!=0);
float4 l9_1014=(*sc_set2.UserUniforms).colorRampTextureUvMinMax;
bool l9_1015=(int(SC_USE_CLAMP_TO_BORDER_colorRampTexture_tmp)!=0);
float4 l9_1016=(*sc_set2.UserUniforms).colorRampTextureBorderColor;
float l9_1017=0.0;
bool l9_1018=l9_1015&&(!l9_1013);
float l9_1019=1.0;
float l9_1020=l9_1009.x;
int l9_1021=l9_1012.x;
if (l9_1021==1)
{
l9_1020=fract(l9_1020);
}
else
{
if (l9_1021==2)
{
float l9_1022=fract(l9_1020);
float l9_1023=l9_1020-l9_1022;
float l9_1024=step(0.25,fract(l9_1023*0.5));
l9_1020=mix(l9_1022,1.0-l9_1022,fast::clamp(l9_1024,0.0,1.0));
}
}
l9_1009.x=l9_1020;
float l9_1025=l9_1009.y;
int l9_1026=l9_1012.y;
if (l9_1026==1)
{
l9_1025=fract(l9_1025);
}
else
{
if (l9_1026==2)
{
float l9_1027=fract(l9_1025);
float l9_1028=l9_1025-l9_1027;
float l9_1029=step(0.25,fract(l9_1028*0.5));
l9_1025=mix(l9_1027,1.0-l9_1027,fast::clamp(l9_1029,0.0,1.0));
}
}
l9_1009.y=l9_1025;
if (l9_1013)
{
bool l9_1030=l9_1015;
bool l9_1031;
if (l9_1030)
{
l9_1031=l9_1012.x==3;
}
else
{
l9_1031=l9_1030;
}
float l9_1032=l9_1009.x;
float l9_1033=l9_1014.x;
float l9_1034=l9_1014.z;
bool l9_1035=l9_1031;
float l9_1036=l9_1019;
float l9_1037=fast::clamp(l9_1032,l9_1033,l9_1034);
float l9_1038=step(abs(l9_1032-l9_1037),9.9999997e-06);
l9_1036*=(l9_1038+((1.0-float(l9_1035))*(1.0-l9_1038)));
l9_1032=l9_1037;
l9_1009.x=l9_1032;
l9_1019=l9_1036;
bool l9_1039=l9_1015;
bool l9_1040;
if (l9_1039)
{
l9_1040=l9_1012.y==3;
}
else
{
l9_1040=l9_1039;
}
float l9_1041=l9_1009.y;
float l9_1042=l9_1014.y;
float l9_1043=l9_1014.w;
bool l9_1044=l9_1040;
float l9_1045=l9_1019;
float l9_1046=fast::clamp(l9_1041,l9_1042,l9_1043);
float l9_1047=step(abs(l9_1041-l9_1046),9.9999997e-06);
l9_1045*=(l9_1047+((1.0-float(l9_1044))*(1.0-l9_1047)));
l9_1041=l9_1046;
l9_1009.y=l9_1041;
l9_1019=l9_1045;
}
float2 l9_1048=l9_1009;
bool l9_1049=l9_1010;
float3x3 l9_1050=l9_1011;
if (l9_1049)
{
l9_1048=float2((l9_1050*float3(l9_1048,1.0)).xy);
}
float2 l9_1051=l9_1048;
float2 l9_1052=l9_1051;
float2 l9_1053=l9_1052;
l9_1009=l9_1053;
float l9_1054=l9_1009.x;
int l9_1055=l9_1012.x;
bool l9_1056=l9_1018;
float l9_1057=l9_1019;
if ((l9_1055==0)||(l9_1055==3))
{
float l9_1058=l9_1054;
float l9_1059=0.0;
float l9_1060=1.0;
bool l9_1061=l9_1056;
float l9_1062=l9_1057;
float l9_1063=fast::clamp(l9_1058,l9_1059,l9_1060);
float l9_1064=step(abs(l9_1058-l9_1063),9.9999997e-06);
l9_1062*=(l9_1064+((1.0-float(l9_1061))*(1.0-l9_1064)));
l9_1058=l9_1063;
l9_1054=l9_1058;
l9_1057=l9_1062;
}
l9_1009.x=l9_1054;
l9_1019=l9_1057;
float l9_1065=l9_1009.y;
int l9_1066=l9_1012.y;
bool l9_1067=l9_1018;
float l9_1068=l9_1019;
if ((l9_1066==0)||(l9_1066==3))
{
float l9_1069=l9_1065;
float l9_1070=0.0;
float l9_1071=1.0;
bool l9_1072=l9_1067;
float l9_1073=l9_1068;
float l9_1074=fast::clamp(l9_1069,l9_1070,l9_1071);
float l9_1075=step(abs(l9_1069-l9_1074),9.9999997e-06);
l9_1073*=(l9_1075+((1.0-float(l9_1072))*(1.0-l9_1075)));
l9_1069=l9_1074;
l9_1065=l9_1069;
l9_1068=l9_1073;
}
l9_1009.y=l9_1065;
l9_1019=l9_1068;
float2 l9_1076=l9_1009;
int l9_1077=l9_1007;
int l9_1078=l9_1008;
float l9_1079=l9_1017;
float2 l9_1080=l9_1076;
int l9_1081=l9_1077;
int l9_1082=l9_1078;
float3 l9_1083=float3(0.0);
if (l9_1081==0)
{
l9_1083=float3(l9_1080,0.0);
}
else
{
if (l9_1081==1)
{
l9_1083=float3(l9_1080.x,(l9_1080.y*0.5)+(0.5-(float(l9_1082)*0.5)),0.0);
}
else
{
l9_1083=float3(l9_1080,float(l9_1082));
}
}
float3 l9_1084=l9_1083;
float3 l9_1085=l9_1084;
float2 l9_1086=l9_1085.xy;
float l9_1087=l9_1079;
float4 l9_1088=sc_set2.colorRampTexture.sample(sc_set2.colorRampTextureSmpSC,l9_1086,bias(l9_1087));
float4 l9_1089=l9_1088;
float4 l9_1090=l9_1089;
if (l9_1015)
{
l9_1090=mix(l9_1016,l9_1090,float4(l9_1019));
}
float4 l9_1091=l9_1090;
l9_1000=l9_1091;
float4 l9_1092=l9_1000;
l9_995=l9_1092*N2_colorRampMult;
float4 l9_1093=float4(1.0);
float4 l9_1094=float4(1.0);
if (N2_ENABLE_BASETEXTURE)
{
float2 l9_1095=tempGlobals.Surface_UVCoord0;
float2 l9_1096=l9_1095;
float4 l9_1097=float4(0.0);
int l9_1098=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_1099=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1099=0;
}
else
{
l9_1099=in.varStereoViewID;
}
int l9_1100=l9_1099;
l9_1098=1-l9_1100;
}
else
{
int l9_1101=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1101=0;
}
else
{
l9_1101=in.varStereoViewID;
}
int l9_1102=l9_1101;
l9_1098=l9_1102;
}
int l9_1103=l9_1098;
int l9_1104=mainTextureLayout_tmp;
int l9_1105=l9_1103;
float2 l9_1106=l9_1096;
bool l9_1107=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_1108=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_1109=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_1110=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_1111=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_1112=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_1113=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_1114=0.0;
bool l9_1115=l9_1112&&(!l9_1110);
float l9_1116=1.0;
float l9_1117=l9_1106.x;
int l9_1118=l9_1109.x;
if (l9_1118==1)
{
l9_1117=fract(l9_1117);
}
else
{
if (l9_1118==2)
{
float l9_1119=fract(l9_1117);
float l9_1120=l9_1117-l9_1119;
float l9_1121=step(0.25,fract(l9_1120*0.5));
l9_1117=mix(l9_1119,1.0-l9_1119,fast::clamp(l9_1121,0.0,1.0));
}
}
l9_1106.x=l9_1117;
float l9_1122=l9_1106.y;
int l9_1123=l9_1109.y;
if (l9_1123==1)
{
l9_1122=fract(l9_1122);
}
else
{
if (l9_1123==2)
{
float l9_1124=fract(l9_1122);
float l9_1125=l9_1122-l9_1124;
float l9_1126=step(0.25,fract(l9_1125*0.5));
l9_1122=mix(l9_1124,1.0-l9_1124,fast::clamp(l9_1126,0.0,1.0));
}
}
l9_1106.y=l9_1122;
if (l9_1110)
{
bool l9_1127=l9_1112;
bool l9_1128;
if (l9_1127)
{
l9_1128=l9_1109.x==3;
}
else
{
l9_1128=l9_1127;
}
float l9_1129=l9_1106.x;
float l9_1130=l9_1111.x;
float l9_1131=l9_1111.z;
bool l9_1132=l9_1128;
float l9_1133=l9_1116;
float l9_1134=fast::clamp(l9_1129,l9_1130,l9_1131);
float l9_1135=step(abs(l9_1129-l9_1134),9.9999997e-06);
l9_1133*=(l9_1135+((1.0-float(l9_1132))*(1.0-l9_1135)));
l9_1129=l9_1134;
l9_1106.x=l9_1129;
l9_1116=l9_1133;
bool l9_1136=l9_1112;
bool l9_1137;
if (l9_1136)
{
l9_1137=l9_1109.y==3;
}
else
{
l9_1137=l9_1136;
}
float l9_1138=l9_1106.y;
float l9_1139=l9_1111.y;
float l9_1140=l9_1111.w;
bool l9_1141=l9_1137;
float l9_1142=l9_1116;
float l9_1143=fast::clamp(l9_1138,l9_1139,l9_1140);
float l9_1144=step(abs(l9_1138-l9_1143),9.9999997e-06);
l9_1142*=(l9_1144+((1.0-float(l9_1141))*(1.0-l9_1144)));
l9_1138=l9_1143;
l9_1106.y=l9_1138;
l9_1116=l9_1142;
}
float2 l9_1145=l9_1106;
bool l9_1146=l9_1107;
float3x3 l9_1147=l9_1108;
if (l9_1146)
{
l9_1145=float2((l9_1147*float3(l9_1145,1.0)).xy);
}
float2 l9_1148=l9_1145;
float2 l9_1149=l9_1148;
float2 l9_1150=l9_1149;
l9_1106=l9_1150;
float l9_1151=l9_1106.x;
int l9_1152=l9_1109.x;
bool l9_1153=l9_1115;
float l9_1154=l9_1116;
if ((l9_1152==0)||(l9_1152==3))
{
float l9_1155=l9_1151;
float l9_1156=0.0;
float l9_1157=1.0;
bool l9_1158=l9_1153;
float l9_1159=l9_1154;
float l9_1160=fast::clamp(l9_1155,l9_1156,l9_1157);
float l9_1161=step(abs(l9_1155-l9_1160),9.9999997e-06);
l9_1159*=(l9_1161+((1.0-float(l9_1158))*(1.0-l9_1161)));
l9_1155=l9_1160;
l9_1151=l9_1155;
l9_1154=l9_1159;
}
l9_1106.x=l9_1151;
l9_1116=l9_1154;
float l9_1162=l9_1106.y;
int l9_1163=l9_1109.y;
bool l9_1164=l9_1115;
float l9_1165=l9_1116;
if ((l9_1163==0)||(l9_1163==3))
{
float l9_1166=l9_1162;
float l9_1167=0.0;
float l9_1168=1.0;
bool l9_1169=l9_1164;
float l9_1170=l9_1165;
float l9_1171=fast::clamp(l9_1166,l9_1167,l9_1168);
float l9_1172=step(abs(l9_1166-l9_1171),9.9999997e-06);
l9_1170*=(l9_1172+((1.0-float(l9_1169))*(1.0-l9_1172)));
l9_1166=l9_1171;
l9_1162=l9_1166;
l9_1165=l9_1170;
}
l9_1106.y=l9_1162;
l9_1116=l9_1165;
float2 l9_1173=l9_1106;
int l9_1174=l9_1104;
int l9_1175=l9_1105;
float l9_1176=l9_1114;
float2 l9_1177=l9_1173;
int l9_1178=l9_1174;
int l9_1179=l9_1175;
float3 l9_1180=float3(0.0);
if (l9_1178==0)
{
l9_1180=float3(l9_1177,0.0);
}
else
{
if (l9_1178==1)
{
l9_1180=float3(l9_1177.x,(l9_1177.y*0.5)+(0.5-(float(l9_1179)*0.5)),0.0);
}
else
{
l9_1180=float3(l9_1177,float(l9_1179));
}
}
float3 l9_1181=l9_1180;
float3 l9_1182=l9_1181;
float2 l9_1183=l9_1182.xy;
float l9_1184=l9_1176;
float4 l9_1185=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_1183,bias(l9_1184));
float4 l9_1186=l9_1185;
float4 l9_1187=l9_1186;
if (l9_1112)
{
l9_1187=mix(l9_1113,l9_1187,float4(l9_1116));
}
float4 l9_1188=l9_1187;
l9_1097=l9_1188;
float4 l9_1189=l9_1097;
l9_1093=l9_1189;
float2 l9_1190=tempGlobals.Surface_UVCoord0;
N2_uv=l9_1190;
if (N2_ENABLE_FLIPBOOK)
{
l9_1093=l9_694;
N2_uv=l9_696;
}
}
if (N2_ENABLE_COLORRAMP)
{
if (!(!(SC_DEVICE_CLASS_tmp>=2)))
{
l9_1094=l9_995;
}
}
N2_result=(l9_1093*l9_689)*l9_1094;
if (N2_ENABLE_SCREENFADE)
{
N2_result.w*=N2_nearCameraFade;
}
if (N2_ENABLE_ALPHADISSOLVE)
{
float l9_1191=l9_688*N2_alphaDissolveMult;
N2_result.w=fast::clamp(N2_result.w-l9_1191,0.0,1.0);
}
if (N2_ENABLE_BLACKASALPHA)
{
float l9_1192=length(N2_result.xyz);
N2_result.w=l9_1192;
}
if (N2_ENABLE_PREMULTIPLIEDCOLOR)
{
float3 l9_1193=N2_result.xyz*N2_result.w;
N2_result=float4(l9_1193.x,l9_1193.y,l9_1193.z,N2_result.w);
}
l9_668=N2_uv;
l9_644=l9_668;
float4 l9_1194=float4(0.0);
float2 l9_1195=l9_644;
int l9_1196=0;
if ((int(normalTexHasSwappedViews_tmp)!=0))
{
int l9_1197=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1197=0;
}
else
{
l9_1197=in.varStereoViewID;
}
int l9_1198=l9_1197;
l9_1196=1-l9_1198;
}
else
{
int l9_1199=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1199=0;
}
else
{
l9_1199=in.varStereoViewID;
}
int l9_1200=l9_1199;
l9_1196=l9_1200;
}
int l9_1201=l9_1196;
int l9_1202=normalTexLayout_tmp;
int l9_1203=l9_1201;
float2 l9_1204=l9_1195;
bool l9_1205=(int(SC_USE_UV_TRANSFORM_normalTex_tmp)!=0);
float3x3 l9_1206=(*sc_set2.UserUniforms).normalTexTransform;
int2 l9_1207=int2(SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp);
bool l9_1208=(int(SC_USE_UV_MIN_MAX_normalTex_tmp)!=0);
float4 l9_1209=(*sc_set2.UserUniforms).normalTexUvMinMax;
bool l9_1210=(int(SC_USE_CLAMP_TO_BORDER_normalTex_tmp)!=0);
float4 l9_1211=(*sc_set2.UserUniforms).normalTexBorderColor;
float l9_1212=0.0;
bool l9_1213=l9_1210&&(!l9_1208);
float l9_1214=1.0;
float l9_1215=l9_1204.x;
int l9_1216=l9_1207.x;
if (l9_1216==1)
{
l9_1215=fract(l9_1215);
}
else
{
if (l9_1216==2)
{
float l9_1217=fract(l9_1215);
float l9_1218=l9_1215-l9_1217;
float l9_1219=step(0.25,fract(l9_1218*0.5));
l9_1215=mix(l9_1217,1.0-l9_1217,fast::clamp(l9_1219,0.0,1.0));
}
}
l9_1204.x=l9_1215;
float l9_1220=l9_1204.y;
int l9_1221=l9_1207.y;
if (l9_1221==1)
{
l9_1220=fract(l9_1220);
}
else
{
if (l9_1221==2)
{
float l9_1222=fract(l9_1220);
float l9_1223=l9_1220-l9_1222;
float l9_1224=step(0.25,fract(l9_1223*0.5));
l9_1220=mix(l9_1222,1.0-l9_1222,fast::clamp(l9_1224,0.0,1.0));
}
}
l9_1204.y=l9_1220;
if (l9_1208)
{
bool l9_1225=l9_1210;
bool l9_1226;
if (l9_1225)
{
l9_1226=l9_1207.x==3;
}
else
{
l9_1226=l9_1225;
}
float l9_1227=l9_1204.x;
float l9_1228=l9_1209.x;
float l9_1229=l9_1209.z;
bool l9_1230=l9_1226;
float l9_1231=l9_1214;
float l9_1232=fast::clamp(l9_1227,l9_1228,l9_1229);
float l9_1233=step(abs(l9_1227-l9_1232),9.9999997e-06);
l9_1231*=(l9_1233+((1.0-float(l9_1230))*(1.0-l9_1233)));
l9_1227=l9_1232;
l9_1204.x=l9_1227;
l9_1214=l9_1231;
bool l9_1234=l9_1210;
bool l9_1235;
if (l9_1234)
{
l9_1235=l9_1207.y==3;
}
else
{
l9_1235=l9_1234;
}
float l9_1236=l9_1204.y;
float l9_1237=l9_1209.y;
float l9_1238=l9_1209.w;
bool l9_1239=l9_1235;
float l9_1240=l9_1214;
float l9_1241=fast::clamp(l9_1236,l9_1237,l9_1238);
float l9_1242=step(abs(l9_1236-l9_1241),9.9999997e-06);
l9_1240*=(l9_1242+((1.0-float(l9_1239))*(1.0-l9_1242)));
l9_1236=l9_1241;
l9_1204.y=l9_1236;
l9_1214=l9_1240;
}
float2 l9_1243=l9_1204;
bool l9_1244=l9_1205;
float3x3 l9_1245=l9_1206;
if (l9_1244)
{
l9_1243=float2((l9_1245*float3(l9_1243,1.0)).xy);
}
float2 l9_1246=l9_1243;
float2 l9_1247=l9_1246;
float2 l9_1248=l9_1247;
l9_1204=l9_1248;
float l9_1249=l9_1204.x;
int l9_1250=l9_1207.x;
bool l9_1251=l9_1213;
float l9_1252=l9_1214;
if ((l9_1250==0)||(l9_1250==3))
{
float l9_1253=l9_1249;
float l9_1254=0.0;
float l9_1255=1.0;
bool l9_1256=l9_1251;
float l9_1257=l9_1252;
float l9_1258=fast::clamp(l9_1253,l9_1254,l9_1255);
float l9_1259=step(abs(l9_1253-l9_1258),9.9999997e-06);
l9_1257*=(l9_1259+((1.0-float(l9_1256))*(1.0-l9_1259)));
l9_1253=l9_1258;
l9_1249=l9_1253;
l9_1252=l9_1257;
}
l9_1204.x=l9_1249;
l9_1214=l9_1252;
float l9_1260=l9_1204.y;
int l9_1261=l9_1207.y;
bool l9_1262=l9_1213;
float l9_1263=l9_1214;
if ((l9_1261==0)||(l9_1261==3))
{
float l9_1264=l9_1260;
float l9_1265=0.0;
float l9_1266=1.0;
bool l9_1267=l9_1262;
float l9_1268=l9_1263;
float l9_1269=fast::clamp(l9_1264,l9_1265,l9_1266);
float l9_1270=step(abs(l9_1264-l9_1269),9.9999997e-06);
l9_1268*=(l9_1270+((1.0-float(l9_1267))*(1.0-l9_1270)));
l9_1264=l9_1269;
l9_1260=l9_1264;
l9_1263=l9_1268;
}
l9_1204.y=l9_1260;
l9_1214=l9_1263;
float2 l9_1271=l9_1204;
int l9_1272=l9_1202;
int l9_1273=l9_1203;
float l9_1274=l9_1212;
float2 l9_1275=l9_1271;
int l9_1276=l9_1272;
int l9_1277=l9_1273;
float3 l9_1278=float3(0.0);
if (l9_1276==0)
{
l9_1278=float3(l9_1275,0.0);
}
else
{
if (l9_1276==1)
{
l9_1278=float3(l9_1275.x,(l9_1275.y*0.5)+(0.5-(float(l9_1277)*0.5)),0.0);
}
else
{
l9_1278=float3(l9_1275,float(l9_1277));
}
}
float3 l9_1279=l9_1278;
float3 l9_1280=l9_1279;
float2 l9_1281=l9_1280.xy;
float l9_1282=l9_1274;
float4 l9_1283=sc_set2.normalTex.sample(sc_set2.normalTexSmpSC,l9_1281,bias(l9_1282));
float4 l9_1284=l9_1283;
float4 l9_1285=l9_1284;
if (l9_1210)
{
l9_1285=mix(l9_1211,l9_1285,float4(l9_1214));
}
float4 l9_1286=l9_1285;
float4 l9_1287=l9_1286;
float3 l9_1288=(l9_1287.xyz*1.9921875)-float3(1.0);
l9_1287=float4(l9_1288.x,l9_1288.y,l9_1288.z,l9_1287.w);
l9_1194=l9_1287;
l9_597=l9_1194.xyz;
l9_600=l9_597;
}
else
{
l9_600=l9_598;
}
l9_596=l9_600;
float l9_1289=0.0;
float l9_1290=(*sc_set2.UserUniforms).metallic;
l9_1289=l9_1290;
float l9_1291=0.0;
float l9_1292=(*sc_set2.UserUniforms).roughness;
l9_1291=l9_1292;
float4 l9_1293=float4(0.0);
float3 l9_1294=l9_45.xyz;
float l9_1295=l9_595;
float3 l9_1296=l9_596;
float3 l9_1297=(*sc_set2.UserUniforms).Port_Emissive_N014;
float l9_1298=l9_1289;
float l9_1299=l9_1291;
float3 l9_1300=(*sc_set2.UserUniforms).Port_AO_N014;
float3 l9_1301=(*sc_set2.UserUniforms).Port_SpecularAO_N014;
ssGlobals l9_1302=param_3;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1302.BumpedNormal=float3x3(float3(l9_1302.VertexTangent_WorldSpace),float3(l9_1302.VertexBinormal_WorldSpace),float3(l9_1302.VertexNormal_WorldSpace))*l9_1296;
}
l9_1295=fast::clamp(l9_1295,0.0,1.0);
float l9_1303=l9_1295;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_1303<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_1304=gl_FragCoord;
float2 l9_1305=floor(mod(l9_1304.xy,float2(4.0)));
float l9_1306=(mod(dot(l9_1305,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_1303<l9_1306)
{
discard_fragment();
}
}
l9_1294=fast::max(l9_1294,float3(0.0));
float4 l9_1307;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1307=float4(l9_1294,l9_1295);
}
else
{
l9_1298=fast::clamp(l9_1298,0.0,1.0);
l9_1299=fast::clamp(l9_1299,0.0,1.0);
float3 l9_1308=l9_1294;
float l9_1309=l9_1295;
float3 l9_1310=l9_1302.BumpedNormal;
float3 l9_1311=l9_1302.PositionWS;
float3 l9_1312=l9_1302.ViewDirWS;
float3 l9_1313=l9_1297;
float l9_1314=l9_1298;
float l9_1315=l9_1299;
float3 l9_1316=l9_1300;
float3 l9_1317=l9_1301;
SurfaceProperties l9_1318;
l9_1318.albedo=float3(0.0);
l9_1318.opacity=1.0;
l9_1318.normal=float3(0.0);
l9_1318.positionWS=float3(0.0);
l9_1318.viewDirWS=float3(0.0);
l9_1318.metallic=0.0;
l9_1318.roughness=0.0;
l9_1318.emissive=float3(0.0);
l9_1318.ao=float3(1.0);
l9_1318.specularAo=float3(1.0);
l9_1318.bakedShadows=float3(1.0);
SurfaceProperties l9_1319=l9_1318;
SurfaceProperties l9_1320=l9_1319;
l9_1320.opacity=l9_1309;
float3 l9_1321=l9_1308;
float3 l9_1322;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1322=float3(pow(l9_1321.x,2.2),pow(l9_1321.y,2.2),pow(l9_1321.z,2.2));
}
else
{
l9_1322=l9_1321*l9_1321;
}
float3 l9_1323=l9_1322;
l9_1320.albedo=l9_1323;
l9_1320.normal=normalize(l9_1310);
l9_1320.positionWS=l9_1311;
l9_1320.viewDirWS=l9_1312;
float3 l9_1324=l9_1313;
float3 l9_1325;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1325=float3(pow(l9_1324.x,2.2),pow(l9_1324.y,2.2),pow(l9_1324.z,2.2));
}
else
{
l9_1325=l9_1324*l9_1324;
}
float3 l9_1326=l9_1325;
l9_1320.emissive=l9_1326;
l9_1320.metallic=l9_1314;
l9_1320.roughness=l9_1315;
l9_1320.ao=l9_1316;
l9_1320.specularAo=l9_1317;
if ((int(sc_SSAOEnabled_tmp)!=0))
{
float3 l9_1327=l9_1320.positionWS;
l9_1320.ao=evaluateSSAO(l9_1327,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC);
}
SurfaceProperties l9_1328=l9_1320;
SurfaceProperties l9_1329=l9_1328;
float3 l9_1330=mix(float3(0.039999999),l9_1329.albedo*l9_1329.metallic,float3(l9_1329.metallic));
float3 l9_1331=mix(l9_1329.albedo*(1.0-l9_1329.metallic),float3(0.0),float3(l9_1329.metallic));
l9_1328.albedo=l9_1331;
l9_1328.specColor=l9_1330;
SurfaceProperties l9_1332=l9_1328;
l9_1320=l9_1332;
SurfaceProperties l9_1333=l9_1320;
LightingComponents l9_1334;
l9_1334.directDiffuse=float3(0.0);
l9_1334.directSpecular=float3(0.0);
l9_1334.indirectDiffuse=float3(1.0);
l9_1334.indirectSpecular=float3(0.0);
l9_1334.emitted=float3(0.0);
l9_1334.transmitted=float3(0.0);
LightingComponents l9_1335=l9_1334;
LightingComponents l9_1336=l9_1335;
float3 l9_1337=l9_1333.viewDirWS;
int l9_1338=0;
float4 l9_1339=float4(l9_1333.bakedShadows,1.0);
if (sc_DirectionalLightsCount_tmp>0)
{
sc_DirectionalLight_t l9_1340;
LightProperties l9_1341;
int l9_1342=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_1342<sc_DirectionalLightsCount_tmp)
{
l9_1340.direction=(*sc_set2.UserUniforms).sc_DirectionalLights[l9_1342].direction;
l9_1340.color=(*sc_set2.UserUniforms).sc_DirectionalLights[l9_1342].color;
l9_1341.direction=l9_1340.direction;
l9_1341.color=l9_1340.color.xyz;
l9_1341.attenuation=l9_1340.color.w;
l9_1341.attenuation*=l9_1339[(l9_1338<3) ? l9_1338 : 3];
l9_1338++;
LightingComponents l9_1343=l9_1336;
LightProperties l9_1344=l9_1341;
SurfaceProperties l9_1345=l9_1333;
float3 l9_1346=l9_1337;
SurfaceProperties l9_1347=l9_1345;
float3 l9_1348=l9_1344.direction;
float l9_1349=dot(l9_1347.normal,l9_1348);
float l9_1350=fast::clamp(l9_1349,0.0,1.0);
float3 l9_1351=float3(l9_1350);
l9_1343.directDiffuse+=((l9_1351*l9_1344.color)*l9_1344.attenuation);
SurfaceProperties l9_1352=l9_1345;
float3 l9_1353=l9_1344.direction;
float3 l9_1354=l9_1346;
l9_1343.directSpecular+=((calculateDirectSpecular(l9_1352,l9_1353,l9_1354)*l9_1344.color)*l9_1344.attenuation);
LightingComponents l9_1355=l9_1343;
l9_1336=l9_1355;
l9_1342++;
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
sc_PointLight_t_1 l9_1356;
LightProperties l9_1357;
int l9_1358=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_1358<sc_PointLightsCount_tmp)
{
l9_1356.falloffEnabled=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].falloffEnabled!=0;
l9_1356.falloffEndDistance=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].falloffEndDistance;
l9_1356.negRcpFalloffEndDistance4=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].negRcpFalloffEndDistance4;
l9_1356.angleScale=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].angleScale;
l9_1356.angleOffset=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].angleOffset;
l9_1356.direction=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].direction;
l9_1356.position=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].position;
l9_1356.color=(*sc_set2.UserUniforms).sc_PointLights[l9_1358].color;
float3 l9_1359=l9_1356.position-l9_1333.positionWS;
l9_1357.direction=normalize(l9_1359);
l9_1357.color=l9_1356.color.xyz;
l9_1357.attenuation=l9_1356.color.w;
l9_1357.attenuation*=l9_1339[(l9_1338<3) ? l9_1338 : 3];
float3 l9_1360=l9_1357.direction;
float3 l9_1361=l9_1356.direction;
float l9_1362=l9_1356.angleScale;
float l9_1363=l9_1356.angleOffset;
float l9_1364=dot(l9_1360,l9_1361);
float l9_1365=fast::clamp((l9_1364*l9_1362)+l9_1363,0.0,1.0);
float l9_1366=l9_1365*l9_1365;
l9_1357.attenuation*=l9_1366;
if (l9_1356.falloffEnabled)
{
float l9_1367=length(l9_1359);
float l9_1368=l9_1356.falloffEndDistance;
l9_1357.attenuation*=computeDistanceAttenuation(l9_1367,l9_1368);
}
l9_1338++;
LightingComponents l9_1369=l9_1336;
LightProperties l9_1370=l9_1357;
SurfaceProperties l9_1371=l9_1333;
float3 l9_1372=l9_1337;
SurfaceProperties l9_1373=l9_1371;
float3 l9_1374=l9_1370.direction;
float l9_1375=dot(l9_1373.normal,l9_1374);
float l9_1376=fast::clamp(l9_1375,0.0,1.0);
float3 l9_1377=float3(l9_1376);
l9_1369.directDiffuse+=((l9_1377*l9_1370.color)*l9_1370.attenuation);
SurfaceProperties l9_1378=l9_1371;
float3 l9_1379=l9_1370.direction;
float3 l9_1380=l9_1372;
l9_1369.directSpecular+=((calculateDirectSpecular(l9_1378,l9_1379,l9_1380)*l9_1370.color)*l9_1370.attenuation);
LightingComponents l9_1381=l9_1369;
l9_1336=l9_1381;
l9_1358++;
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
float3 l9_1382=float3(0.0);
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float2 l9_1383=abs(in.varShadowTex-float2(0.5));
float l9_1384=fast::max(l9_1383.x,l9_1383.y);
float l9_1385=step(l9_1384,0.5);
float4 l9_1386=sc_set2.sc_ShadowTexture.sample(sc_set2.sc_ShadowTextureSmpSC,in.varShadowTex)*l9_1385;
float3 l9_1387=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_1386.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float l9_1388=l9_1386.w*(*sc_set2.UserUniforms).sc_ShadowDensity;
l9_1382=mix(float3(1.0),l9_1387,float3(l9_1388));
}
else
{
l9_1382=float3(1.0);
}
float3 l9_1389=l9_1382;
float3 l9_1390=l9_1389;
l9_1336.directDiffuse*=l9_1390;
l9_1336.directSpecular*=l9_1390;
}
bool l9_1391=(*sc_set2.UserUniforms).receivesRayTracedShadows!=0;
if (l9_1391)
{
float4 l9_1392=gl_FragCoord;
float2 l9_1393=(l9_1392.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_1394=l9_1393;
float2 l9_1395=l9_1394;
int l9_1396=0;
if ((int(sc_RayTracedShadowTextureHasSwappedViews_tmp)!=0))
{
int l9_1397=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1397=0;
}
else
{
l9_1397=in.varStereoViewID;
}
int l9_1398=l9_1397;
l9_1396=1-l9_1398;
}
else
{
int l9_1399=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1399=0;
}
else
{
l9_1399=in.varStereoViewID;
}
int l9_1400=l9_1399;
l9_1396=l9_1400;
}
int l9_1401=l9_1396;
float2 l9_1402=l9_1395;
int l9_1403=l9_1401;
float2 l9_1404=l9_1402;
int l9_1405=l9_1403;
float l9_1406=0.0;
float4 l9_1407=float4(0.0);
float2 l9_1408=l9_1404;
int l9_1409=sc_RayTracedShadowTextureLayout_tmp;
int l9_1410=l9_1405;
float l9_1411=l9_1406;
float2 l9_1412=l9_1408;
int l9_1413=l9_1409;
int l9_1414=l9_1410;
float3 l9_1415=float3(0.0);
if (l9_1413==0)
{
l9_1415=float3(l9_1412,0.0);
}
else
{
if (l9_1413==1)
{
l9_1415=float3(l9_1412.x,(l9_1412.y*0.5)+(0.5-(float(l9_1414)*0.5)),0.0);
}
else
{
l9_1415=float3(l9_1412,float(l9_1414));
}
}
float3 l9_1416=l9_1415;
float3 l9_1417=l9_1416;
float2 l9_1418=l9_1417.xy;
float l9_1419=l9_1411;
float4 l9_1420=sc_set2.sc_RayTracedShadowTexture.sample(sc_set2.sc_RayTracedShadowTextureSmpSC,l9_1418,bias(l9_1419));
float4 l9_1421=l9_1420;
l9_1407=l9_1421;
float4 l9_1422=l9_1407;
float4 l9_1423=l9_1422;
float4 l9_1424=l9_1423;
float l9_1425=l9_1424.x;
float3 l9_1426=float3(l9_1425);
float3 l9_1427=l9_1426;
l9_1336.directDiffuse*=(float3(1.0)-l9_1427);
l9_1336.directSpecular*=(float3(1.0)-l9_1427);
}
SurfaceProperties l9_1428=l9_1333;
float3 l9_1429=l9_1428.normal;
float3 l9_1430=float3(0.0);
if ((sc_EnvLightMode_tmp==sc_AmbientLightMode_EnvironmentMap_tmp)||(sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp))
{
float3 l9_1431=l9_1429;
float3 l9_1432=l9_1431;
float l9_1433=(*sc_set2.UserUniforms).sc_EnvmapRotation.y;
float2 l9_1434=float2(0.0);
float l9_1435=l9_1432.x;
float l9_1436=-l9_1432.z;
float l9_1437=(l9_1435<0.0) ? (-1.0) : 1.0;
float l9_1438=l9_1437*acos(fast::clamp(l9_1436/length(float2(l9_1435,l9_1436)),-1.0,1.0));
l9_1434.x=l9_1438-1.5707964;
l9_1434.y=acos(l9_1432.y);
l9_1434/=float2(6.2831855,3.1415927);
l9_1434.y=1.0-l9_1434.y;
l9_1434.x+=(l9_1433/360.0);
l9_1434.x=fract((l9_1434.x+floor(l9_1434.x))+1.0);
float2 l9_1439=l9_1434;
float2 l9_1440=l9_1439;
float4 l9_1441=float4(0.0);
if (sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float2 l9_1442=l9_1440;
float2 l9_1443=(*sc_set2.UserUniforms).sc_EnvmapSpecularSize.xy;
float l9_1444=5.0;
l9_1440=calcSeamlessPanoramicUvsForSampling(l9_1442,l9_1443,l9_1444);
}
float2 l9_1445=l9_1440;
float l9_1446=13.0;
int l9_1447=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1448=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1448=0;
}
else
{
l9_1448=in.varStereoViewID;
}
int l9_1449=l9_1448;
l9_1447=1-l9_1449;
}
else
{
int l9_1450=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1450=0;
}
else
{
l9_1450=in.varStereoViewID;
}
int l9_1451=l9_1450;
l9_1447=l9_1451;
}
int l9_1452=l9_1447;
float2 l9_1453=l9_1445;
int l9_1454=l9_1452;
float l9_1455=l9_1446;
float4 l9_1456=float4(0.0);
float2 l9_1457=l9_1453;
int l9_1458=sc_EnvmapSpecularLayout_tmp;
int l9_1459=l9_1454;
float l9_1460=l9_1455;
float2 l9_1461=l9_1457;
int l9_1462=l9_1458;
int l9_1463=l9_1459;
float3 l9_1464=float3(0.0);
if (l9_1462==0)
{
l9_1464=float3(l9_1461,0.0);
}
else
{
if (l9_1462==1)
{
l9_1464=float3(l9_1461.x,(l9_1461.y*0.5)+(0.5-(float(l9_1463)*0.5)),0.0);
}
else
{
l9_1464=float3(l9_1461,float(l9_1463));
}
}
float3 l9_1465=l9_1464;
float3 l9_1466=l9_1465;
float2 l9_1467=l9_1466.xy;
float l9_1468=l9_1460;
float4 l9_1469=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1467,bias(l9_1468));
float4 l9_1470=l9_1469;
l9_1456=l9_1470;
float4 l9_1471=l9_1456;
float4 l9_1472=l9_1471;
l9_1441=l9_1472;
}
else
{
if ((sc_MaxTextureImageUnits_tmp>8)&&(int(sc_HasDiffuseEnvmap_tmp)!=0))
{
float2 l9_1473=l9_1440;
float2 l9_1474=(*sc_set2.UserUniforms).sc_EnvmapDiffuseSize.xy;
float l9_1475=0.0;
l9_1440=calcSeamlessPanoramicUvsForSampling(l9_1473,l9_1474,l9_1475);
float2 l9_1476=l9_1440;
float l9_1477=-13.0;
int l9_1478=0;
if ((int(sc_EnvmapDiffuseHasSwappedViews_tmp)!=0))
{
int l9_1479=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1479=0;
}
else
{
l9_1479=in.varStereoViewID;
}
int l9_1480=l9_1479;
l9_1478=1-l9_1480;
}
else
{
int l9_1481=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1481=0;
}
else
{
l9_1481=in.varStereoViewID;
}
int l9_1482=l9_1481;
l9_1478=l9_1482;
}
int l9_1483=l9_1478;
float2 l9_1484=l9_1476;
int l9_1485=l9_1483;
float l9_1486=l9_1477;
float4 l9_1487=float4(0.0);
float2 l9_1488=l9_1484;
int l9_1489=sc_EnvmapDiffuseLayout_tmp;
int l9_1490=l9_1485;
float l9_1491=l9_1486;
float2 l9_1492=l9_1488;
int l9_1493=l9_1489;
int l9_1494=l9_1490;
float3 l9_1495=float3(0.0);
if (l9_1493==0)
{
l9_1495=float3(l9_1492,0.0);
}
else
{
if (l9_1493==1)
{
l9_1495=float3(l9_1492.x,(l9_1492.y*0.5)+(0.5-(float(l9_1494)*0.5)),0.0);
}
else
{
l9_1495=float3(l9_1492,float(l9_1494));
}
}
float3 l9_1496=l9_1495;
float3 l9_1497=l9_1496;
float2 l9_1498=l9_1497.xy;
float l9_1499=l9_1491;
float4 l9_1500=sc_set2.sc_EnvmapDiffuse.sample(sc_set2.sc_EnvmapDiffuseSmpSC,l9_1498,bias(l9_1499));
float4 l9_1501=l9_1500;
l9_1487=l9_1501;
float4 l9_1502=l9_1487;
float4 l9_1503=l9_1502;
l9_1441=l9_1503;
}
else
{
float2 l9_1504=l9_1440;
float l9_1505=13.0;
int l9_1506=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1507=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1507=0;
}
else
{
l9_1507=in.varStereoViewID;
}
int l9_1508=l9_1507;
l9_1506=1-l9_1508;
}
else
{
int l9_1509=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1509=0;
}
else
{
l9_1509=in.varStereoViewID;
}
int l9_1510=l9_1509;
l9_1506=l9_1510;
}
int l9_1511=l9_1506;
float2 l9_1512=l9_1504;
int l9_1513=l9_1511;
float l9_1514=l9_1505;
float4 l9_1515=float4(0.0);
float2 l9_1516=l9_1512;
int l9_1517=sc_EnvmapSpecularLayout_tmp;
int l9_1518=l9_1513;
float l9_1519=l9_1514;
float2 l9_1520=l9_1516;
int l9_1521=l9_1517;
int l9_1522=l9_1518;
float3 l9_1523=float3(0.0);
if (l9_1521==0)
{
l9_1523=float3(l9_1520,0.0);
}
else
{
if (l9_1521==1)
{
l9_1523=float3(l9_1520.x,(l9_1520.y*0.5)+(0.5-(float(l9_1522)*0.5)),0.0);
}
else
{
l9_1523=float3(l9_1520,float(l9_1522));
}
}
float3 l9_1524=l9_1523;
float3 l9_1525=l9_1524;
float2 l9_1526=l9_1525.xy;
float l9_1527=l9_1519;
float4 l9_1528=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1526,bias(l9_1527));
float4 l9_1529=l9_1528;
l9_1515=l9_1529;
float4 l9_1530=l9_1515;
float4 l9_1531=l9_1530;
l9_1441=l9_1531;
}
}
float4 l9_1532=l9_1441;
float3 l9_1533=l9_1532.xyz*(1.0/l9_1532.w);
float3 l9_1534=l9_1533*(*sc_set2.UserUniforms).sc_EnvmapExposure;
l9_1430=l9_1534;
}
else
{
if (sc_EnvLightMode_tmp==sc_AmbientLightMode_SphericalHarmonics_tmp)
{
float3 l9_1535=(*sc_set2.UserUniforms).sc_Sh[0];
float3 l9_1536=(*sc_set2.UserUniforms).sc_Sh[1];
float3 l9_1537=(*sc_set2.UserUniforms).sc_Sh[2];
float3 l9_1538=(*sc_set2.UserUniforms).sc_Sh[3];
float3 l9_1539=(*sc_set2.UserUniforms).sc_Sh[4];
float3 l9_1540=(*sc_set2.UserUniforms).sc_Sh[5];
float3 l9_1541=(*sc_set2.UserUniforms).sc_Sh[6];
float3 l9_1542=(*sc_set2.UserUniforms).sc_Sh[7];
float3 l9_1543=(*sc_set2.UserUniforms).sc_Sh[8];
float3 l9_1544=-l9_1429;
float l9_1545=0.0;
l9_1545=l9_1544.x;
float l9_1546=l9_1544.y;
float l9_1547=l9_1544.z;
float l9_1548=l9_1545*l9_1545;
float l9_1549=l9_1546*l9_1546;
float l9_1550=l9_1547*l9_1547;
float l9_1551=l9_1545*l9_1546;
float l9_1552=l9_1546*l9_1547;
float l9_1553=l9_1545*l9_1547;
float3 l9_1554=((((((l9_1543*0.42904299)*(l9_1548-l9_1549))+((l9_1541*0.74312502)*l9_1550))+(l9_1535*0.88622701))-(l9_1541*0.24770799))+((((l9_1539*l9_1551)+(l9_1542*l9_1553))+(l9_1540*l9_1552))*0.85808599))+((((l9_1538*l9_1545)+(l9_1536*l9_1546))+(l9_1537*l9_1547))*1.0233279);
l9_1430=l9_1554*(*sc_set2.UserUniforms).sc_ShIntensity;
}
}
bool l9_1555=(*sc_set2.UserUniforms).receivesRayTracedDiffuseIndirect!=0;
if (l9_1555)
{
float4 l9_1556=sampleRayTracedIndirectDiffuse(in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,gl_FragCoord);
l9_1430=mix(l9_1430,l9_1556.xyz,float3(l9_1556.w));
}
if (sc_AmbientLightsCount_tmp>0)
{
if (sc_AmbientLightMode0_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_1430+=((*sc_set2.UserUniforms).sc_AmbientLights[0].color*(*sc_set2.UserUniforms).sc_AmbientLights[0].intensity);
}
else
{
l9_1430.x+=(1e-06*(*sc_set2.UserUniforms).sc_AmbientLights[0].color.x);
}
}
if (sc_AmbientLightsCount_tmp>1)
{
if (sc_AmbientLightMode1_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_1430+=((*sc_set2.UserUniforms).sc_AmbientLights[1].color*(*sc_set2.UserUniforms).sc_AmbientLights[1].intensity);
}
else
{
l9_1430.x+=(1e-06*(*sc_set2.UserUniforms).sc_AmbientLights[1].color.x);
}
}
if (sc_AmbientLightsCount_tmp>2)
{
if (sc_AmbientLightMode2_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_1430+=((*sc_set2.UserUniforms).sc_AmbientLights[2].color*(*sc_set2.UserUniforms).sc_AmbientLights[2].intensity);
}
else
{
l9_1430.x+=(1e-06*(*sc_set2.UserUniforms).sc_AmbientLights[2].color.x);
}
}
if ((int(sc_LightEstimation_tmp)!=0))
{
float3 l9_1557=l9_1429;
float3 l9_1558=(*sc_set2.UserUniforms).sc_LightEstimationData.ambientLight;
sc_SphericalGaussianLight_t l9_1559;
float l9_1560;
int l9_1561=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_1561<sc_LightEstimationSGCount_tmp)
{
l9_1559.color=(*sc_set2.UserUniforms).sc_LightEstimationData.sg[l9_1561].color;
l9_1559.sharpness=(*sc_set2.UserUniforms).sc_LightEstimationData.sg[l9_1561].sharpness;
l9_1559.axis=(*sc_set2.UserUniforms).sc_LightEstimationData.sg[l9_1561].axis;
float3 l9_1562=l9_1557;
float l9_1563=dot(l9_1559.axis,l9_1562);
float l9_1564=l9_1559.sharpness;
float l9_1565=0.36000001;
float l9_1566=1.0/(4.0*l9_1565);
float l9_1567=exp(-l9_1564);
float l9_1568=l9_1567*l9_1567;
float l9_1569=1.0/l9_1564;
float l9_1570=(1.0+(2.0*l9_1568))-l9_1569;
float l9_1571=((l9_1567-l9_1568)*l9_1569)-l9_1568;
float l9_1572=sqrt(1.0-l9_1570);
float l9_1573=l9_1565*l9_1563;
float l9_1574=l9_1566*l9_1572;
float l9_1575=l9_1573+l9_1574;
float l9_1576=l9_1563;
float l9_1577=fast::clamp(l9_1576,0.0,1.0);
float l9_1578=l9_1577;
if (step(abs(l9_1573),l9_1574)>0.5)
{
l9_1560=(l9_1575*l9_1575)/l9_1572;
}
else
{
l9_1560=l9_1578;
}
l9_1578=l9_1560;
float l9_1579=(l9_1570*l9_1578)+l9_1571;
sc_SphericalGaussianLight_t l9_1580=l9_1559;
float3 l9_1581=(l9_1580.color/float3(l9_1580.sharpness))*6.2831855;
float3 l9_1582=(l9_1581*l9_1579)/float3(3.1415927);
l9_1558+=l9_1582;
l9_1561++;
continue;
}
else
{
break;
}
}
float3 l9_1583=l9_1558;
l9_1430+=l9_1583;
}
float3 l9_1584=l9_1430;
float3 l9_1585=l9_1584;
l9_1336.indirectDiffuse=l9_1585;
SurfaceProperties l9_1586=l9_1333;
float3 l9_1587=l9_1337;
float3 l9_1588=float3(0.0);
if ((sc_EnvLightMode_tmp==sc_AmbientLightMode_EnvironmentMap_tmp)||(sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp))
{
SurfaceProperties l9_1589=l9_1586;
float3 l9_1590=l9_1587;
float3 l9_1591=l9_1589.normal;
float3 l9_1592=reflect(-l9_1590,l9_1591);
float3 l9_1593=l9_1591;
float3 l9_1594=l9_1592;
float l9_1595=l9_1589.roughness;
l9_1592=getSpecularDominantDir(l9_1593,l9_1594,l9_1595);
float l9_1596=l9_1589.roughness;
float l9_1597=pow(l9_1596,0.66666669);
float l9_1598=fast::clamp(l9_1597,0.0,1.0);
float l9_1599=l9_1598*5.0;
float l9_1600=l9_1599;
float l9_1601=l9_1600;
float3 l9_1602=l9_1592;
float l9_1603=l9_1601;
float3 l9_1604=l9_1602;
float l9_1605=l9_1603;
float4 l9_1606=float4(0.0);
float3 l9_1607=l9_1604;
float l9_1608=(*sc_set2.UserUniforms).sc_EnvmapRotation.y;
float2 l9_1609=float2(0.0);
float l9_1610=l9_1607.x;
float l9_1611=-l9_1607.z;
float l9_1612=(l9_1610<0.0) ? (-1.0) : 1.0;
float l9_1613=l9_1612*acos(fast::clamp(l9_1611/length(float2(l9_1610,l9_1611)),-1.0,1.0));
l9_1609.x=l9_1613-1.5707964;
l9_1609.y=acos(l9_1607.y);
l9_1609/=float2(6.2831855,3.1415927);
l9_1609.y=1.0-l9_1609.y;
l9_1609.x+=(l9_1608/360.0);
l9_1609.x=fract((l9_1609.x+floor(l9_1609.x))+1.0);
float2 l9_1614=l9_1609;
float2 l9_1615=l9_1614;
if (SC_DEVICE_CLASS_tmp>=2)
{
float l9_1616=floor(l9_1605);
float l9_1617=ceil(l9_1605);
float l9_1618=l9_1605-l9_1616;
float2 l9_1619=l9_1615;
float2 l9_1620=(*sc_set2.UserUniforms).sc_EnvmapSpecularSize.xy;
float l9_1621=l9_1616;
float2 l9_1622=calcSeamlessPanoramicUvsForSampling(l9_1619,l9_1620,l9_1621);
float2 l9_1623=l9_1622;
float l9_1624=l9_1616;
float2 l9_1625=l9_1623;
float l9_1626=l9_1624;
int l9_1627=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1628=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1628=0;
}
else
{
l9_1628=in.varStereoViewID;
}
int l9_1629=l9_1628;
l9_1627=1-l9_1629;
}
else
{
int l9_1630=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1630=0;
}
else
{
l9_1630=in.varStereoViewID;
}
int l9_1631=l9_1630;
l9_1627=l9_1631;
}
int l9_1632=l9_1627;
float2 l9_1633=l9_1625;
int l9_1634=l9_1632;
float l9_1635=l9_1626;
float4 l9_1636=float4(0.0);
float2 l9_1637=l9_1633;
int l9_1638=sc_EnvmapSpecularLayout_tmp;
int l9_1639=l9_1634;
float l9_1640=l9_1635;
float2 l9_1641=l9_1637;
int l9_1642=l9_1638;
int l9_1643=l9_1639;
float3 l9_1644=float3(0.0);
if (l9_1642==0)
{
l9_1644=float3(l9_1641,0.0);
}
else
{
if (l9_1642==1)
{
l9_1644=float3(l9_1641.x,(l9_1641.y*0.5)+(0.5-(float(l9_1643)*0.5)),0.0);
}
else
{
l9_1644=float3(l9_1641,float(l9_1643));
}
}
float3 l9_1645=l9_1644;
float3 l9_1646=l9_1645;
float2 l9_1647=l9_1646.xy;
float l9_1648=l9_1640;
float4 l9_1649=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1647,level(l9_1648));
float4 l9_1650=l9_1649;
l9_1636=l9_1650;
float4 l9_1651=l9_1636;
float4 l9_1652=l9_1651;
float4 l9_1653=l9_1652;
float4 l9_1654=l9_1653;
float2 l9_1655=l9_1615;
float2 l9_1656=(*sc_set2.UserUniforms).sc_EnvmapSpecularSize.xy;
float l9_1657=l9_1617;
float2 l9_1658=calcSeamlessPanoramicUvsForSampling(l9_1655,l9_1656,l9_1657);
float2 l9_1659=l9_1658;
float l9_1660=l9_1617;
float2 l9_1661=l9_1659;
float l9_1662=l9_1660;
int l9_1663=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1664=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1664=0;
}
else
{
l9_1664=in.varStereoViewID;
}
int l9_1665=l9_1664;
l9_1663=1-l9_1665;
}
else
{
int l9_1666=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1666=0;
}
else
{
l9_1666=in.varStereoViewID;
}
int l9_1667=l9_1666;
l9_1663=l9_1667;
}
int l9_1668=l9_1663;
float2 l9_1669=l9_1661;
int l9_1670=l9_1668;
float l9_1671=l9_1662;
float4 l9_1672=float4(0.0);
float2 l9_1673=l9_1669;
int l9_1674=sc_EnvmapSpecularLayout_tmp;
int l9_1675=l9_1670;
float l9_1676=l9_1671;
float2 l9_1677=l9_1673;
int l9_1678=l9_1674;
int l9_1679=l9_1675;
float3 l9_1680=float3(0.0);
if (l9_1678==0)
{
l9_1680=float3(l9_1677,0.0);
}
else
{
if (l9_1678==1)
{
l9_1680=float3(l9_1677.x,(l9_1677.y*0.5)+(0.5-(float(l9_1679)*0.5)),0.0);
}
else
{
l9_1680=float3(l9_1677,float(l9_1679));
}
}
float3 l9_1681=l9_1680;
float3 l9_1682=l9_1681;
float2 l9_1683=l9_1682.xy;
float l9_1684=l9_1676;
float4 l9_1685=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1683,level(l9_1684));
float4 l9_1686=l9_1685;
l9_1672=l9_1686;
float4 l9_1687=l9_1672;
float4 l9_1688=l9_1687;
float4 l9_1689=l9_1688;
float4 l9_1690=l9_1689;
l9_1606=mix(l9_1654,l9_1690,float4(l9_1618));
}
else
{
float2 l9_1691=l9_1615;
float l9_1692=l9_1605;
float2 l9_1693=l9_1691;
float l9_1694=l9_1692;
int l9_1695=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_1696=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1696=0;
}
else
{
l9_1696=in.varStereoViewID;
}
int l9_1697=l9_1696;
l9_1695=1-l9_1697;
}
else
{
int l9_1698=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1698=0;
}
else
{
l9_1698=in.varStereoViewID;
}
int l9_1699=l9_1698;
l9_1695=l9_1699;
}
int l9_1700=l9_1695;
float2 l9_1701=l9_1693;
int l9_1702=l9_1700;
float l9_1703=l9_1694;
float4 l9_1704=float4(0.0);
float2 l9_1705=l9_1701;
int l9_1706=sc_EnvmapSpecularLayout_tmp;
int l9_1707=l9_1702;
float l9_1708=l9_1703;
float2 l9_1709=l9_1705;
int l9_1710=l9_1706;
int l9_1711=l9_1707;
float3 l9_1712=float3(0.0);
if (l9_1710==0)
{
l9_1712=float3(l9_1709,0.0);
}
else
{
if (l9_1710==1)
{
l9_1712=float3(l9_1709.x,(l9_1709.y*0.5)+(0.5-(float(l9_1711)*0.5)),0.0);
}
else
{
l9_1712=float3(l9_1709,float(l9_1711));
}
}
float3 l9_1713=l9_1712;
float3 l9_1714=l9_1713;
float2 l9_1715=l9_1714.xy;
float l9_1716=l9_1708;
float4 l9_1717=sc_set2.sc_EnvmapSpecular.sample(sc_set2.sc_EnvmapSpecularSmpSC,l9_1715,level(l9_1716));
float4 l9_1718=l9_1717;
l9_1704=l9_1718;
float4 l9_1719=l9_1704;
float4 l9_1720=l9_1719;
float4 l9_1721=l9_1720;
l9_1606=l9_1721;
}
float4 l9_1722=l9_1606;
float3 l9_1723=l9_1722.xyz*(1.0/l9_1722.w);
float3 l9_1724=l9_1723;
float3 l9_1725=l9_1724*(*sc_set2.UserUniforms).sc_EnvmapExposure;
l9_1725+=float3(1e-06);
float3 l9_1726=l9_1725;
float3 l9_1727=l9_1726;
bool l9_1728=(*sc_set2.UserUniforms).receivesRayTracedReflections!=0;
if (l9_1728)
{
float4 l9_1729=sampleRayTracedReflections(in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,gl_FragCoord);
l9_1727=mix(l9_1727,l9_1729.xyz,float3(l9_1729.w));
}
SurfaceProperties l9_1730=l9_1589;
float l9_1731=abs(dot(l9_1591,l9_1590));
float3 l9_1732=l9_1727*envBRDFApprox(l9_1730,l9_1731);
l9_1588+=l9_1732;
}
if ((int(sc_LightEstimation_tmp)!=0))
{
SurfaceProperties l9_1733=l9_1586;
float3 l9_1734=l9_1587;
float l9_1735=fast::clamp(l9_1733.roughness*l9_1733.roughness,0.0099999998,1.0);
float3 l9_1736=(*sc_set2.UserUniforms).sc_LightEstimationData.ambientLight*l9_1733.specColor;
sc_SphericalGaussianLight_t l9_1737;
sc_SphericalGaussianLight_t l9_1738;
sc_SphericalGaussianLight_t l9_1739;
int l9_1740=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_1740<sc_LightEstimationSGCount_tmp)
{
l9_1737.color=(*sc_set2.UserUniforms).sc_LightEstimationData.sg[l9_1740].color;
l9_1737.sharpness=(*sc_set2.UserUniforms).sc_LightEstimationData.sg[l9_1740].sharpness;
l9_1737.axis=(*sc_set2.UserUniforms).sc_LightEstimationData.sg[l9_1740].axis;
float3 l9_1741=l9_1733.normal;
float l9_1742=l9_1735;
float3 l9_1743=l9_1734;
float3 l9_1744=l9_1733.specColor;
float3 l9_1745=l9_1741;
float l9_1746=l9_1742;
l9_1738.axis=l9_1745;
float l9_1747=l9_1746*l9_1746;
l9_1738.sharpness=2.0/l9_1747;
l9_1738.color=float3(1.0/(3.1415927*l9_1747));
sc_SphericalGaussianLight_t l9_1748=l9_1738;
sc_SphericalGaussianLight_t l9_1749=l9_1748;
sc_SphericalGaussianLight_t l9_1750=l9_1749;
float3 l9_1751=l9_1743;
l9_1739.axis=reflect(-l9_1751,l9_1750.axis);
l9_1739.color=l9_1750.color;
l9_1739.sharpness=l9_1750.sharpness;
l9_1739.sharpness/=(4.0*fast::max(dot(l9_1750.axis,l9_1751),9.9999997e-05));
sc_SphericalGaussianLight_t l9_1752=l9_1739;
sc_SphericalGaussianLight_t l9_1753=l9_1752;
sc_SphericalGaussianLight_t l9_1754=l9_1753;
sc_SphericalGaussianLight_t l9_1755=l9_1737;
float l9_1756=length((l9_1754.axis*l9_1754.sharpness)+(l9_1755.axis*l9_1755.sharpness));
float3 l9_1757=(l9_1754.color*exp((l9_1756-l9_1754.sharpness)-l9_1755.sharpness))*l9_1755.color;
float l9_1758=1.0-exp((-2.0)*l9_1756);
float3 l9_1759=((l9_1757*6.2831855)*l9_1758)/float3(l9_1756);
float3 l9_1760=l9_1759;
float3 l9_1761=l9_1753.axis;
float l9_1762=l9_1742*l9_1742;
float l9_1763=dot(l9_1741,l9_1761);
float l9_1764=fast::clamp(l9_1763,0.0,1.0);
float l9_1765=l9_1764;
float l9_1766=dot(l9_1741,l9_1743);
float l9_1767=fast::clamp(l9_1766,0.0,1.0);
float l9_1768=l9_1767;
float3 l9_1769=normalize(l9_1753.axis+l9_1743);
float l9_1770=l9_1762;
float l9_1771=l9_1765;
float l9_1772=1.0/(l9_1771+sqrt(l9_1770+(((1.0-l9_1770)*l9_1771)*l9_1771)));
float l9_1773=l9_1762;
float l9_1774=l9_1768;
float l9_1775=1.0/(l9_1774+sqrt(l9_1773+(((1.0-l9_1773)*l9_1774)*l9_1774)));
l9_1760*=(l9_1772*l9_1775);
float l9_1776=dot(l9_1761,l9_1769);
float l9_1777=fast::clamp(l9_1776,0.0,1.0);
float l9_1778=pow(1.0-l9_1777,5.0);
l9_1760*=(l9_1744+((float3(1.0)-l9_1744)*l9_1778));
l9_1760*=l9_1765;
float3 l9_1779=l9_1760;
l9_1736+=l9_1779;
l9_1740++;
continue;
}
else
{
break;
}
}
float3 l9_1780=l9_1736;
l9_1588+=l9_1780;
}
float3 l9_1781=l9_1588;
l9_1336.indirectSpecular=l9_1781;
LightingComponents l9_1782=l9_1336;
LightingComponents l9_1783=l9_1782;
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_1783.directDiffuse=float3(0.0);
l9_1783.indirectDiffuse=float3(0.0);
float4 l9_1784=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_1785=out.FragColor0;
float4 l9_1786=l9_1785;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_1786.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_1787=l9_1786;
l9_1784=l9_1787;
}
else
{
float4 l9_1788=gl_FragCoord;
float2 l9_1789=(l9_1788.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_1790=l9_1789;
float2 l9_1791=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_1792=1;
int l9_1793=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1793=0;
}
else
{
l9_1793=in.varStereoViewID;
}
int l9_1794=l9_1793;
int l9_1795=l9_1794;
float3 l9_1796=float3(l9_1790,0.0);
int l9_1797=l9_1792;
int l9_1798=l9_1795;
if (l9_1797==1)
{
l9_1796.y=((2.0*l9_1796.y)+float(l9_1798))-1.0;
}
float2 l9_1799=l9_1796.xy;
l9_1791=l9_1799;
}
else
{
l9_1791=l9_1790;
}
float2 l9_1800=l9_1791;
float2 l9_1801=l9_1800;
float2 l9_1802=l9_1801;
int l9_1803=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_1804=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1804=0;
}
else
{
l9_1804=in.varStereoViewID;
}
int l9_1805=l9_1804;
l9_1803=1-l9_1805;
}
else
{
int l9_1806=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1806=0;
}
else
{
l9_1806=in.varStereoViewID;
}
int l9_1807=l9_1806;
l9_1803=l9_1807;
}
int l9_1808=l9_1803;
float2 l9_1809=l9_1802;
int l9_1810=l9_1808;
float2 l9_1811=l9_1809;
int l9_1812=l9_1810;
float l9_1813=0.0;
float4 l9_1814=float4(0.0);
float2 l9_1815=l9_1811;
int l9_1816=sc_ScreenTextureLayout_tmp;
int l9_1817=l9_1812;
float l9_1818=l9_1813;
float2 l9_1819=l9_1815;
int l9_1820=l9_1816;
int l9_1821=l9_1817;
float3 l9_1822=float3(0.0);
if (l9_1820==0)
{
l9_1822=float3(l9_1819,0.0);
}
else
{
if (l9_1820==1)
{
l9_1822=float3(l9_1819.x,(l9_1819.y*0.5)+(0.5-(float(l9_1821)*0.5)),0.0);
}
else
{
l9_1822=float3(l9_1819,float(l9_1821));
}
}
float3 l9_1823=l9_1822;
float3 l9_1824=l9_1823;
float2 l9_1825=l9_1824.xy;
float l9_1826=l9_1818;
float4 l9_1827=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_1825,bias(l9_1826));
float4 l9_1828=l9_1827;
l9_1814=l9_1828;
float4 l9_1829=l9_1814;
float4 l9_1830=l9_1829;
float4 l9_1831=l9_1830;
l9_1784=l9_1831;
}
float4 l9_1832=l9_1784;
float4 l9_1833=l9_1832;
float3 l9_1834=l9_1833.xyz;
float3 l9_1835;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_1835=float3(pow(l9_1834.x,2.2),pow(l9_1834.y,2.2),pow(l9_1834.z,2.2));
}
else
{
l9_1835=l9_1834*l9_1834;
}
float3 l9_1836=l9_1835;
float3 l9_1837=l9_1836;
l9_1783.transmitted=l9_1837*mix(float3(1.0),l9_1320.albedo,float3(l9_1320.opacity));
l9_1320.opacity=1.0;
}
bool l9_1838=false;
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_1838=true;
}
SurfaceProperties l9_1839=l9_1320;
LightingComponents l9_1840=l9_1783;
bool l9_1841=l9_1838;
float3 l9_1842=float3(0.0);
bool l9_1843=(*sc_set2.UserUniforms).receivesRayTracedAo!=0;
if (l9_1843)
{
l9_1842=l9_1839.albedo*(l9_1840.directDiffuse+(l9_1840.indirectDiffuse*float3(1.0-sampleRayTracedAo(in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord))));
}
else
{
l9_1842=l9_1839.albedo*(l9_1840.directDiffuse+(l9_1840.indirectDiffuse*l9_1839.ao));
}
float3 l9_1844=l9_1840.directSpecular+(l9_1840.indirectSpecular*l9_1839.specularAo);
float3 l9_1845=l9_1839.emissive;
float3 l9_1846=l9_1840.transmitted;
if (l9_1841)
{
float l9_1847=l9_1839.opacity;
l9_1842*=srgbToLinear(l9_1847);
}
float3 l9_1848=((l9_1842+l9_1844)+l9_1845)+l9_1846;
float3 l9_1849=l9_1848;
float4 l9_1850=float4(l9_1849,l9_1320.opacity);
if (!(int(sc_BlendMode_Multiply_tmp)!=0))
{
float3 l9_1851=l9_1850.xyz;
float l9_1852=1.8;
float l9_1853=1.4;
float l9_1854=0.5;
float l9_1855=1.5;
float3 l9_1856=(l9_1851*((l9_1851*l9_1852)+float3(l9_1853)))/((l9_1851*((l9_1851*l9_1852)+float3(l9_1854)))+float3(l9_1855));
l9_1850=float4(l9_1856.x,l9_1856.y,l9_1856.z,l9_1850.w);
}
float3 l9_1857=l9_1850.xyz;
float l9_1858=l9_1857.x;
float l9_1859=l9_1857.y;
float l9_1860=l9_1857.z;
float3 l9_1861=float3(linearToSrgb(l9_1858),linearToSrgb(l9_1859),linearToSrgb(l9_1860));
l9_1850=float4(l9_1861.x,l9_1861.y,l9_1861.z,l9_1850.w);
float4 l9_1862=l9_1850;
l9_1307=l9_1862;
}
l9_1307=fast::max(l9_1307,float4(0.0));
l9_1293=l9_1307;
param=l9_1293;
param_2=param;
}
else
{
float3 l9_1863=float3(0.0);
float3 l9_1864=(*sc_set2.UserUniforms).colorStart;
l9_1863=l9_1864;
float3 l9_1865=float3(0.0);
float3 l9_1866=(*sc_set2.UserUniforms).colorEnd;
l9_1865=l9_1866;
float3 l9_1867=float3(0.0);
float3 l9_1868=(*sc_set2.UserUniforms).colorMinStart;
l9_1867=l9_1868;
float3 l9_1869=float3(0.0);
float3 l9_1870=(*sc_set2.UserUniforms).colorMinEnd;
l9_1869=l9_1870;
float3 l9_1871=float3(0.0);
float3 l9_1872=(*sc_set2.UserUniforms).colorMaxStart;
l9_1871=l9_1872;
float3 l9_1873=float3(0.0);
float3 l9_1874=(*sc_set2.UserUniforms).colorMaxEnd;
l9_1873=l9_1874;
float l9_1875=0.0;
float l9_1876=(*sc_set2.UserUniforms).alphaStart;
l9_1875=l9_1876;
float l9_1877=0.0;
float l9_1878=(*sc_set2.UserUniforms).alphaEnd;
l9_1877=l9_1878;
float l9_1879=0.0;
float l9_1880=(*sc_set2.UserUniforms).alphaMinStart;
l9_1879=l9_1880;
float l9_1881=0.0;
float l9_1882=(*sc_set2.UserUniforms).alphaMinEnd;
l9_1881=l9_1882;
float l9_1883=0.0;
float l9_1884=(*sc_set2.UserUniforms).alphaMaxStart;
l9_1883=l9_1884;
float l9_1885=0.0;
float l9_1886=(*sc_set2.UserUniforms).alphaMaxEnd;
l9_1885=l9_1886;
float l9_1887=0.0;
float l9_1888=(*sc_set2.UserUniforms).alphaDissolveMult;
l9_1887=l9_1888;
float l9_1889=0.0;
l9_1889=in.Interpolator0.x;
float l9_1890=0.0;
float l9_1891=(*sc_set2.UserUniforms).numValidFrames;
l9_1890=l9_1891;
float2 l9_1892=float2(0.0);
float2 l9_1893=(*sc_set2.UserUniforms).gridSize;
l9_1892=l9_1893;
float l9_1894=0.0;
float l9_1895=(*sc_set2.UserUniforms).flipBookSpeedMult;
l9_1894=l9_1895;
float l9_1896=0.0;
float l9_1897=(*sc_set2.UserUniforms).flipBookRandomStart;
l9_1896=l9_1897;
float2 l9_1898=float2(0.0);
float2 l9_1899=(*sc_set2.UserUniforms).colorRampTextureSize.xy;
l9_1898=l9_1899;
float4 l9_1900=float4(0.0);
float4 l9_1901=(*sc_set2.UserUniforms).colorRampMult;
l9_1900=l9_1901;
float4 l9_1902=float4(0.0);
float4 l9_1903;
l9_1903.x=in.Interpolator0.y;
l9_1903.y=in.Interpolator0.z;
l9_1903.z=in.Interpolator0.w;
l9_1903.w=in.Interpolator1.x;
l9_1902=l9_1903;
float l9_1904=0.0;
float l9_1905=(*sc_set2.UserUniforms).externalSeed;
l9_1904=l9_1905;
float4 l9_1906=float4(0.0);
float3 l9_1907=l9_1863;
float3 l9_1908=l9_1865;
float3 l9_1909=l9_1867;
float3 l9_1910=l9_1869;
float3 l9_1911=l9_1871;
float3 l9_1912=l9_1873;
float l9_1913=l9_1875;
float l9_1914=l9_1877;
float l9_1915=l9_1879;
float l9_1916=l9_1881;
float l9_1917=l9_1883;
float l9_1918=l9_1885;
float l9_1919=l9_1887;
float l9_1920=l9_1889;
float l9_1921=l9_1890;
float2 l9_1922=l9_1892;
float l9_1923=l9_1894;
float l9_1924=l9_1896;
float2 l9_1925=l9_1898;
float4 l9_1926=l9_1900;
float4 l9_1927=l9_1902;
float l9_1928=l9_1904;
ssGlobals l9_1929=param_3;
tempGlobals=l9_1929;
float4 l9_1930=float4(0.0);
N2_colorStart=l9_1907;
N2_colorEnd=l9_1908;
N2_ENABLE_COLORMINMAX=(int(COLORMINMAX_tmp)!=0);
N2_colorMinStart=l9_1909;
N2_colorMinEnd=l9_1910;
N2_colorMaxStart=l9_1911;
N2_colorMaxEnd=l9_1912;
N2_ENABLE_COLORMONOMIN=(int(COLORMONOMIN_tmp)!=0);
N2_alphaStart=l9_1913;
N2_alphaEnd=l9_1914;
N2_ENABLE_ALPHAMINMAX=(int(ALPHAMINMAX_tmp)!=0);
N2_alphaMinStart=l9_1915;
N2_alphaMinEnd=l9_1916;
N2_alphaMaxStart=l9_1917;
N2_alphaMaxEnd=l9_1918;
N2_ENABLE_ALPHADISSOLVE=(int(ALPHADISSOLVE_tmp)!=0);
N2_alphaDissolveMult=l9_1919;
N2_ENABLE_PREMULTIPLIEDCOLOR=(int(PREMULTIPLIEDCOLOR_tmp)!=0);
N2_ENABLE_BLACKASALPHA=(int(BLACKASALPHA_tmp)!=0);
N2_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N2_nearCameraFade=l9_1920;
N2_ENABLE_FLIPBOOK=(int(FLIPBOOK_tmp)!=0);
N2_numValidFrames=l9_1921;
N2_gridSize=l9_1922;
N2_flipBookSpeedMult=l9_1923;
N2_flipBookRandomStart=l9_1924;
N2_ENABLE_FLIPBOOKBLEND=(int(FLIPBOOKBLEND_tmp)!=0);
N2_ENABLE_FLIPBOOKBYLIFE=(int(FLIPBOOKBYLIFE_tmp)!=0);
N2_ENABLE_COLORRAMP=(int(COLORRAMP_tmp)!=0);
N2_texSize=l9_1925;
N2_colorRampMult=l9_1926;
N2_ENABLE_NORANDOFFSET=(int(NORANDOFFSET_tmp)!=0);
N2_ENABLE_BASETEXTURE=(int(BASETEXTURE_tmp)!=0);
N2_timeValuesIn=l9_1927;
N2_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N2_externalSeed=l9_1928;
float l9_1931=0.0;
if (N2_ENABLE_WORLDPOSSEED)
{
float4x4 l9_1932=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_1931=length(float4(1.0)*l9_1932);
}
N2_globalSeed=N2_externalSeed+l9_1931;
float l9_1933=2000.0;
int l9_1934=0;
l9_1934=int(tempGlobals.gInstanceID);
int l9_1935=l9_1934;
float l9_1936=float(l9_1935);
float2 l9_1937=float2(mod(l9_1936,l9_1933),floor(l9_1936/l9_1933));
l9_1937/=float2(l9_1933);
float2 l9_1938=l9_1937;
float l9_1939=dot(l9_1938,float2(0.38253,0.42662001));
float3 l9_1940=float3(0.457831,0.62343299,0.97625297)*l9_1939;
l9_1940=sin(l9_1940)*float3(479.371,389.53101,513.03497);
l9_1940=fract(l9_1940);
l9_1940=floor(l9_1940*10000.0)*9.9999997e-05;
float3 l9_1941=l9_1940;
float3 l9_1942=l9_1941;
N2_particleSeed=l9_1942;
float l9_1943=N2_particleSeed.x;
float l9_1944=N2_particleSeed.y;
float l9_1945=N2_particleSeed.z;
float3 l9_1946=fract((float3(l9_1943,l9_1944,l9_1945)*27.21883)+float3(N2_globalSeed));
if (N2_ENABLE_COLORMONOMIN)
{
l9_1946=fract((float3(l9_1943,l9_1943,l9_1943)*27.21883)+float3(N2_globalSeed));
}
float l9_1947=fract((N2_particleSeed.x*3121.3333)+N2_globalSeed);
float l9_1948=fract((N2_particleSeed.y*13.2234)+N2_globalSeed);
float l9_1949=fract((N2_particleSeed.z*3.5358)+N2_globalSeed);
float l9_1950=N2_timeValuesIn.w;
float4 l9_1951=float4(0.0);
float3 l9_1952=float3(0.0);
float3 l9_1953=float3(0.0);
float l9_1954=0.0;
float l9_1955=0.0;
if (N2_ENABLE_COLORMINMAX)
{
l9_1952=mix(N2_colorMinStart,N2_colorMaxStart,l9_1946);
l9_1953=mix(N2_colorMinEnd,N2_colorMaxEnd,l9_1946);
}
else
{
l9_1952=N2_colorStart;
l9_1953=N2_colorEnd;
}
if (N2_ENABLE_ALPHAMINMAX)
{
l9_1954=mix(N2_alphaMinStart,N2_alphaMaxStart,l9_1947);
l9_1955=mix(N2_alphaMinEnd,N2_alphaMaxEnd,l9_1947);
}
else
{
l9_1954=N2_alphaStart;
l9_1955=N2_alphaEnd;
}
l9_1952=mix(l9_1952,l9_1953,float3(l9_1950));
l9_1954=mix(l9_1954,l9_1955,l9_1950);
l9_1951=float4(l9_1952,l9_1954);
float4 l9_1956=float4(0.0);
float2 l9_1957=tempGlobals.Surface_UVCoord0;
float2 l9_1958=l9_1957;
float2 l9_1959=tempGlobals.Surface_UVCoord1;
float2 l9_1960=l9_1959;
float l9_1961=fast::max(N2_timeValuesIn.x,0.0099999998);
float l9_1962=fast::max(N2_timeValuesIn.y,0.0099999998);
float l9_1963=N2_timeValuesIn.z;
if (N2_ENABLE_FLIPBOOKBYLIFE)
{
float l9_1964=mix(l9_1961,l9_1962,l9_1949);
l9_1963=N2_timeValuesIn.z/l9_1964;
}
float l9_1965=mix(0.0,N2_flipBookRandomStart,l9_1948);
float2 l9_1966=l9_1958/N2_gridSize;
float l9_1967=(l9_1963*N2_flipBookSpeedMult)+l9_1965;
l9_1967=mod(l9_1967,N2_numValidFrames);
float l9_1968=floor(l9_1967)*(1.0/N2_gridSize.x);
float l9_1969=mod(floor((-l9_1967)/N2_gridSize.x),N2_gridSize.y)*(1.0/N2_gridSize.y);
float l9_1970=l9_1967+1.0;
l9_1970=mod(l9_1970,N2_numValidFrames);
float l9_1971=floor(l9_1970)*(1.0/N2_gridSize.x);
float l9_1972=floor((-l9_1970)*(1.0/N2_gridSize.x))*(1.0/N2_gridSize.y);
float l9_1973=fract(l9_1967);
l9_1958=l9_1966+float2(l9_1968,l9_1969);
l9_1960=l9_1966+float2(l9_1971,l9_1972);
if (N2_ENABLE_FLIPBOOKBLEND)
{
float2 l9_1974=l9_1958;
float4 l9_1975=float4(0.0);
int l9_1976=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_1977=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1977=0;
}
else
{
l9_1977=in.varStereoViewID;
}
int l9_1978=l9_1977;
l9_1976=1-l9_1978;
}
else
{
int l9_1979=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1979=0;
}
else
{
l9_1979=in.varStereoViewID;
}
int l9_1980=l9_1979;
l9_1976=l9_1980;
}
int l9_1981=l9_1976;
int l9_1982=mainTextureLayout_tmp;
int l9_1983=l9_1981;
float2 l9_1984=l9_1974;
bool l9_1985=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_1986=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_1987=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_1988=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_1989=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_1990=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_1991=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_1992=0.0;
bool l9_1993=l9_1990&&(!l9_1988);
float l9_1994=1.0;
float l9_1995=l9_1984.x;
int l9_1996=l9_1987.x;
if (l9_1996==1)
{
l9_1995=fract(l9_1995);
}
else
{
if (l9_1996==2)
{
float l9_1997=fract(l9_1995);
float l9_1998=l9_1995-l9_1997;
float l9_1999=step(0.25,fract(l9_1998*0.5));
l9_1995=mix(l9_1997,1.0-l9_1997,fast::clamp(l9_1999,0.0,1.0));
}
}
l9_1984.x=l9_1995;
float l9_2000=l9_1984.y;
int l9_2001=l9_1987.y;
if (l9_2001==1)
{
l9_2000=fract(l9_2000);
}
else
{
if (l9_2001==2)
{
float l9_2002=fract(l9_2000);
float l9_2003=l9_2000-l9_2002;
float l9_2004=step(0.25,fract(l9_2003*0.5));
l9_2000=mix(l9_2002,1.0-l9_2002,fast::clamp(l9_2004,0.0,1.0));
}
}
l9_1984.y=l9_2000;
if (l9_1988)
{
bool l9_2005=l9_1990;
bool l9_2006;
if (l9_2005)
{
l9_2006=l9_1987.x==3;
}
else
{
l9_2006=l9_2005;
}
float l9_2007=l9_1984.x;
float l9_2008=l9_1989.x;
float l9_2009=l9_1989.z;
bool l9_2010=l9_2006;
float l9_2011=l9_1994;
float l9_2012=fast::clamp(l9_2007,l9_2008,l9_2009);
float l9_2013=step(abs(l9_2007-l9_2012),9.9999997e-06);
l9_2011*=(l9_2013+((1.0-float(l9_2010))*(1.0-l9_2013)));
l9_2007=l9_2012;
l9_1984.x=l9_2007;
l9_1994=l9_2011;
bool l9_2014=l9_1990;
bool l9_2015;
if (l9_2014)
{
l9_2015=l9_1987.y==3;
}
else
{
l9_2015=l9_2014;
}
float l9_2016=l9_1984.y;
float l9_2017=l9_1989.y;
float l9_2018=l9_1989.w;
bool l9_2019=l9_2015;
float l9_2020=l9_1994;
float l9_2021=fast::clamp(l9_2016,l9_2017,l9_2018);
float l9_2022=step(abs(l9_2016-l9_2021),9.9999997e-06);
l9_2020*=(l9_2022+((1.0-float(l9_2019))*(1.0-l9_2022)));
l9_2016=l9_2021;
l9_1984.y=l9_2016;
l9_1994=l9_2020;
}
float2 l9_2023=l9_1984;
bool l9_2024=l9_1985;
float3x3 l9_2025=l9_1986;
if (l9_2024)
{
l9_2023=float2((l9_2025*float3(l9_2023,1.0)).xy);
}
float2 l9_2026=l9_2023;
float2 l9_2027=l9_2026;
float2 l9_2028=l9_2027;
l9_1984=l9_2028;
float l9_2029=l9_1984.x;
int l9_2030=l9_1987.x;
bool l9_2031=l9_1993;
float l9_2032=l9_1994;
if ((l9_2030==0)||(l9_2030==3))
{
float l9_2033=l9_2029;
float l9_2034=0.0;
float l9_2035=1.0;
bool l9_2036=l9_2031;
float l9_2037=l9_2032;
float l9_2038=fast::clamp(l9_2033,l9_2034,l9_2035);
float l9_2039=step(abs(l9_2033-l9_2038),9.9999997e-06);
l9_2037*=(l9_2039+((1.0-float(l9_2036))*(1.0-l9_2039)));
l9_2033=l9_2038;
l9_2029=l9_2033;
l9_2032=l9_2037;
}
l9_1984.x=l9_2029;
l9_1994=l9_2032;
float l9_2040=l9_1984.y;
int l9_2041=l9_1987.y;
bool l9_2042=l9_1993;
float l9_2043=l9_1994;
if ((l9_2041==0)||(l9_2041==3))
{
float l9_2044=l9_2040;
float l9_2045=0.0;
float l9_2046=1.0;
bool l9_2047=l9_2042;
float l9_2048=l9_2043;
float l9_2049=fast::clamp(l9_2044,l9_2045,l9_2046);
float l9_2050=step(abs(l9_2044-l9_2049),9.9999997e-06);
l9_2048*=(l9_2050+((1.0-float(l9_2047))*(1.0-l9_2050)));
l9_2044=l9_2049;
l9_2040=l9_2044;
l9_2043=l9_2048;
}
l9_1984.y=l9_2040;
l9_1994=l9_2043;
float2 l9_2051=l9_1984;
int l9_2052=l9_1982;
int l9_2053=l9_1983;
float l9_2054=l9_1992;
float2 l9_2055=l9_2051;
int l9_2056=l9_2052;
int l9_2057=l9_2053;
float3 l9_2058=float3(0.0);
if (l9_2056==0)
{
l9_2058=float3(l9_2055,0.0);
}
else
{
if (l9_2056==1)
{
l9_2058=float3(l9_2055.x,(l9_2055.y*0.5)+(0.5-(float(l9_2057)*0.5)),0.0);
}
else
{
l9_2058=float3(l9_2055,float(l9_2057));
}
}
float3 l9_2059=l9_2058;
float3 l9_2060=l9_2059;
float2 l9_2061=l9_2060.xy;
float l9_2062=l9_2054;
float4 l9_2063=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_2061,bias(l9_2062));
float4 l9_2064=l9_2063;
float4 l9_2065=l9_2064;
if (l9_1990)
{
l9_2065=mix(l9_1991,l9_2065,float4(l9_1994));
}
float4 l9_2066=l9_2065;
l9_1975=l9_2066;
float4 l9_2067=l9_1975;
float4 l9_2068=l9_2067;
float2 l9_2069=l9_1960;
float4 l9_2070=float4(0.0);
int l9_2071=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_2072=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2072=0;
}
else
{
l9_2072=in.varStereoViewID;
}
int l9_2073=l9_2072;
l9_2071=1-l9_2073;
}
else
{
int l9_2074=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2074=0;
}
else
{
l9_2074=in.varStereoViewID;
}
int l9_2075=l9_2074;
l9_2071=l9_2075;
}
int l9_2076=l9_2071;
int l9_2077=mainTextureLayout_tmp;
int l9_2078=l9_2076;
float2 l9_2079=l9_2069;
bool l9_2080=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_2081=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_2082=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_2083=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_2084=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_2085=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_2086=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_2087=0.0;
bool l9_2088=l9_2085&&(!l9_2083);
float l9_2089=1.0;
float l9_2090=l9_2079.x;
int l9_2091=l9_2082.x;
if (l9_2091==1)
{
l9_2090=fract(l9_2090);
}
else
{
if (l9_2091==2)
{
float l9_2092=fract(l9_2090);
float l9_2093=l9_2090-l9_2092;
float l9_2094=step(0.25,fract(l9_2093*0.5));
l9_2090=mix(l9_2092,1.0-l9_2092,fast::clamp(l9_2094,0.0,1.0));
}
}
l9_2079.x=l9_2090;
float l9_2095=l9_2079.y;
int l9_2096=l9_2082.y;
if (l9_2096==1)
{
l9_2095=fract(l9_2095);
}
else
{
if (l9_2096==2)
{
float l9_2097=fract(l9_2095);
float l9_2098=l9_2095-l9_2097;
float l9_2099=step(0.25,fract(l9_2098*0.5));
l9_2095=mix(l9_2097,1.0-l9_2097,fast::clamp(l9_2099,0.0,1.0));
}
}
l9_2079.y=l9_2095;
if (l9_2083)
{
bool l9_2100=l9_2085;
bool l9_2101;
if (l9_2100)
{
l9_2101=l9_2082.x==3;
}
else
{
l9_2101=l9_2100;
}
float l9_2102=l9_2079.x;
float l9_2103=l9_2084.x;
float l9_2104=l9_2084.z;
bool l9_2105=l9_2101;
float l9_2106=l9_2089;
float l9_2107=fast::clamp(l9_2102,l9_2103,l9_2104);
float l9_2108=step(abs(l9_2102-l9_2107),9.9999997e-06);
l9_2106*=(l9_2108+((1.0-float(l9_2105))*(1.0-l9_2108)));
l9_2102=l9_2107;
l9_2079.x=l9_2102;
l9_2089=l9_2106;
bool l9_2109=l9_2085;
bool l9_2110;
if (l9_2109)
{
l9_2110=l9_2082.y==3;
}
else
{
l9_2110=l9_2109;
}
float l9_2111=l9_2079.y;
float l9_2112=l9_2084.y;
float l9_2113=l9_2084.w;
bool l9_2114=l9_2110;
float l9_2115=l9_2089;
float l9_2116=fast::clamp(l9_2111,l9_2112,l9_2113);
float l9_2117=step(abs(l9_2111-l9_2116),9.9999997e-06);
l9_2115*=(l9_2117+((1.0-float(l9_2114))*(1.0-l9_2117)));
l9_2111=l9_2116;
l9_2079.y=l9_2111;
l9_2089=l9_2115;
}
float2 l9_2118=l9_2079;
bool l9_2119=l9_2080;
float3x3 l9_2120=l9_2081;
if (l9_2119)
{
l9_2118=float2((l9_2120*float3(l9_2118,1.0)).xy);
}
float2 l9_2121=l9_2118;
float2 l9_2122=l9_2121;
float2 l9_2123=l9_2122;
l9_2079=l9_2123;
float l9_2124=l9_2079.x;
int l9_2125=l9_2082.x;
bool l9_2126=l9_2088;
float l9_2127=l9_2089;
if ((l9_2125==0)||(l9_2125==3))
{
float l9_2128=l9_2124;
float l9_2129=0.0;
float l9_2130=1.0;
bool l9_2131=l9_2126;
float l9_2132=l9_2127;
float l9_2133=fast::clamp(l9_2128,l9_2129,l9_2130);
float l9_2134=step(abs(l9_2128-l9_2133),9.9999997e-06);
l9_2132*=(l9_2134+((1.0-float(l9_2131))*(1.0-l9_2134)));
l9_2128=l9_2133;
l9_2124=l9_2128;
l9_2127=l9_2132;
}
l9_2079.x=l9_2124;
l9_2089=l9_2127;
float l9_2135=l9_2079.y;
int l9_2136=l9_2082.y;
bool l9_2137=l9_2088;
float l9_2138=l9_2089;
if ((l9_2136==0)||(l9_2136==3))
{
float l9_2139=l9_2135;
float l9_2140=0.0;
float l9_2141=1.0;
bool l9_2142=l9_2137;
float l9_2143=l9_2138;
float l9_2144=fast::clamp(l9_2139,l9_2140,l9_2141);
float l9_2145=step(abs(l9_2139-l9_2144),9.9999997e-06);
l9_2143*=(l9_2145+((1.0-float(l9_2142))*(1.0-l9_2145)));
l9_2139=l9_2144;
l9_2135=l9_2139;
l9_2138=l9_2143;
}
l9_2079.y=l9_2135;
l9_2089=l9_2138;
float2 l9_2146=l9_2079;
int l9_2147=l9_2077;
int l9_2148=l9_2078;
float l9_2149=l9_2087;
float2 l9_2150=l9_2146;
int l9_2151=l9_2147;
int l9_2152=l9_2148;
float3 l9_2153=float3(0.0);
if (l9_2151==0)
{
l9_2153=float3(l9_2150,0.0);
}
else
{
if (l9_2151==1)
{
l9_2153=float3(l9_2150.x,(l9_2150.y*0.5)+(0.5-(float(l9_2152)*0.5)),0.0);
}
else
{
l9_2153=float3(l9_2150,float(l9_2152));
}
}
float3 l9_2154=l9_2153;
float3 l9_2155=l9_2154;
float2 l9_2156=l9_2155.xy;
float l9_2157=l9_2149;
float4 l9_2158=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_2156,bias(l9_2157));
float4 l9_2159=l9_2158;
float4 l9_2160=l9_2159;
if (l9_2085)
{
l9_2160=mix(l9_2086,l9_2160,float4(l9_2089));
}
float4 l9_2161=l9_2160;
l9_2070=l9_2161;
float4 l9_2162=l9_2070;
l9_1956=mix(l9_2068,l9_2162,float4(l9_1973));
}
else
{
float2 l9_2163=l9_1958;
float4 l9_2164=float4(0.0);
int l9_2165=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_2166=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2166=0;
}
else
{
l9_2166=in.varStereoViewID;
}
int l9_2167=l9_2166;
l9_2165=1-l9_2167;
}
else
{
int l9_2168=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2168=0;
}
else
{
l9_2168=in.varStereoViewID;
}
int l9_2169=l9_2168;
l9_2165=l9_2169;
}
int l9_2170=l9_2165;
int l9_2171=mainTextureLayout_tmp;
int l9_2172=l9_2170;
float2 l9_2173=l9_2163;
bool l9_2174=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_2175=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_2176=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_2177=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_2178=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_2179=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_2180=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_2181=0.0;
bool l9_2182=l9_2179&&(!l9_2177);
float l9_2183=1.0;
float l9_2184=l9_2173.x;
int l9_2185=l9_2176.x;
if (l9_2185==1)
{
l9_2184=fract(l9_2184);
}
else
{
if (l9_2185==2)
{
float l9_2186=fract(l9_2184);
float l9_2187=l9_2184-l9_2186;
float l9_2188=step(0.25,fract(l9_2187*0.5));
l9_2184=mix(l9_2186,1.0-l9_2186,fast::clamp(l9_2188,0.0,1.0));
}
}
l9_2173.x=l9_2184;
float l9_2189=l9_2173.y;
int l9_2190=l9_2176.y;
if (l9_2190==1)
{
l9_2189=fract(l9_2189);
}
else
{
if (l9_2190==2)
{
float l9_2191=fract(l9_2189);
float l9_2192=l9_2189-l9_2191;
float l9_2193=step(0.25,fract(l9_2192*0.5));
l9_2189=mix(l9_2191,1.0-l9_2191,fast::clamp(l9_2193,0.0,1.0));
}
}
l9_2173.y=l9_2189;
if (l9_2177)
{
bool l9_2194=l9_2179;
bool l9_2195;
if (l9_2194)
{
l9_2195=l9_2176.x==3;
}
else
{
l9_2195=l9_2194;
}
float l9_2196=l9_2173.x;
float l9_2197=l9_2178.x;
float l9_2198=l9_2178.z;
bool l9_2199=l9_2195;
float l9_2200=l9_2183;
float l9_2201=fast::clamp(l9_2196,l9_2197,l9_2198);
float l9_2202=step(abs(l9_2196-l9_2201),9.9999997e-06);
l9_2200*=(l9_2202+((1.0-float(l9_2199))*(1.0-l9_2202)));
l9_2196=l9_2201;
l9_2173.x=l9_2196;
l9_2183=l9_2200;
bool l9_2203=l9_2179;
bool l9_2204;
if (l9_2203)
{
l9_2204=l9_2176.y==3;
}
else
{
l9_2204=l9_2203;
}
float l9_2205=l9_2173.y;
float l9_2206=l9_2178.y;
float l9_2207=l9_2178.w;
bool l9_2208=l9_2204;
float l9_2209=l9_2183;
float l9_2210=fast::clamp(l9_2205,l9_2206,l9_2207);
float l9_2211=step(abs(l9_2205-l9_2210),9.9999997e-06);
l9_2209*=(l9_2211+((1.0-float(l9_2208))*(1.0-l9_2211)));
l9_2205=l9_2210;
l9_2173.y=l9_2205;
l9_2183=l9_2209;
}
float2 l9_2212=l9_2173;
bool l9_2213=l9_2174;
float3x3 l9_2214=l9_2175;
if (l9_2213)
{
l9_2212=float2((l9_2214*float3(l9_2212,1.0)).xy);
}
float2 l9_2215=l9_2212;
float2 l9_2216=l9_2215;
float2 l9_2217=l9_2216;
l9_2173=l9_2217;
float l9_2218=l9_2173.x;
int l9_2219=l9_2176.x;
bool l9_2220=l9_2182;
float l9_2221=l9_2183;
if ((l9_2219==0)||(l9_2219==3))
{
float l9_2222=l9_2218;
float l9_2223=0.0;
float l9_2224=1.0;
bool l9_2225=l9_2220;
float l9_2226=l9_2221;
float l9_2227=fast::clamp(l9_2222,l9_2223,l9_2224);
float l9_2228=step(abs(l9_2222-l9_2227),9.9999997e-06);
l9_2226*=(l9_2228+((1.0-float(l9_2225))*(1.0-l9_2228)));
l9_2222=l9_2227;
l9_2218=l9_2222;
l9_2221=l9_2226;
}
l9_2173.x=l9_2218;
l9_2183=l9_2221;
float l9_2229=l9_2173.y;
int l9_2230=l9_2176.y;
bool l9_2231=l9_2182;
float l9_2232=l9_2183;
if ((l9_2230==0)||(l9_2230==3))
{
float l9_2233=l9_2229;
float l9_2234=0.0;
float l9_2235=1.0;
bool l9_2236=l9_2231;
float l9_2237=l9_2232;
float l9_2238=fast::clamp(l9_2233,l9_2234,l9_2235);
float l9_2239=step(abs(l9_2233-l9_2238),9.9999997e-06);
l9_2237*=(l9_2239+((1.0-float(l9_2236))*(1.0-l9_2239)));
l9_2233=l9_2238;
l9_2229=l9_2233;
l9_2232=l9_2237;
}
l9_2173.y=l9_2229;
l9_2183=l9_2232;
float2 l9_2240=l9_2173;
int l9_2241=l9_2171;
int l9_2242=l9_2172;
float l9_2243=l9_2181;
float2 l9_2244=l9_2240;
int l9_2245=l9_2241;
int l9_2246=l9_2242;
float3 l9_2247=float3(0.0);
if (l9_2245==0)
{
l9_2247=float3(l9_2244,0.0);
}
else
{
if (l9_2245==1)
{
l9_2247=float3(l9_2244.x,(l9_2244.y*0.5)+(0.5-(float(l9_2246)*0.5)),0.0);
}
else
{
l9_2247=float3(l9_2244,float(l9_2246));
}
}
float3 l9_2248=l9_2247;
float3 l9_2249=l9_2248;
float2 l9_2250=l9_2249.xy;
float l9_2251=l9_2243;
float4 l9_2252=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_2250,bias(l9_2251));
float4 l9_2253=l9_2252;
float4 l9_2254=l9_2253;
if (l9_2179)
{
l9_2254=mix(l9_2180,l9_2254,float4(l9_2183));
}
float4 l9_2255=l9_2254;
l9_2164=l9_2255;
float4 l9_2256=l9_2164;
l9_1956=l9_2256;
}
float4 l9_2257=float4(0.0);
float l9_2258=ceil(l9_1950*N2_texSize.x)/N2_texSize.x;
float l9_2259=l9_2258;
if (N2_ENABLE_NORANDOFFSET)
{
float2 l9_2260=tempGlobals.Surface_UVCoord0;
l9_2259+=(l9_2260.x/N2_texSize.x);
}
float2 l9_2261=float2(l9_2259,0.5);
float4 l9_2262=float4(0.0);
int l9_2263=0;
if ((int(colorRampTextureHasSwappedViews_tmp)!=0))
{
int l9_2264=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2264=0;
}
else
{
l9_2264=in.varStereoViewID;
}
int l9_2265=l9_2264;
l9_2263=1-l9_2265;
}
else
{
int l9_2266=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2266=0;
}
else
{
l9_2266=in.varStereoViewID;
}
int l9_2267=l9_2266;
l9_2263=l9_2267;
}
int l9_2268=l9_2263;
int l9_2269=colorRampTextureLayout_tmp;
int l9_2270=l9_2268;
float2 l9_2271=l9_2261;
bool l9_2272=(int(SC_USE_UV_TRANSFORM_colorRampTexture_tmp)!=0);
float3x3 l9_2273=(*sc_set2.UserUniforms).colorRampTextureTransform;
int2 l9_2274=int2(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_colorRampTexture_tmp);
bool l9_2275=(int(SC_USE_UV_MIN_MAX_colorRampTexture_tmp)!=0);
float4 l9_2276=(*sc_set2.UserUniforms).colorRampTextureUvMinMax;
bool l9_2277=(int(SC_USE_CLAMP_TO_BORDER_colorRampTexture_tmp)!=0);
float4 l9_2278=(*sc_set2.UserUniforms).colorRampTextureBorderColor;
float l9_2279=0.0;
bool l9_2280=l9_2277&&(!l9_2275);
float l9_2281=1.0;
float l9_2282=l9_2271.x;
int l9_2283=l9_2274.x;
if (l9_2283==1)
{
l9_2282=fract(l9_2282);
}
else
{
if (l9_2283==2)
{
float l9_2284=fract(l9_2282);
float l9_2285=l9_2282-l9_2284;
float l9_2286=step(0.25,fract(l9_2285*0.5));
l9_2282=mix(l9_2284,1.0-l9_2284,fast::clamp(l9_2286,0.0,1.0));
}
}
l9_2271.x=l9_2282;
float l9_2287=l9_2271.y;
int l9_2288=l9_2274.y;
if (l9_2288==1)
{
l9_2287=fract(l9_2287);
}
else
{
if (l9_2288==2)
{
float l9_2289=fract(l9_2287);
float l9_2290=l9_2287-l9_2289;
float l9_2291=step(0.25,fract(l9_2290*0.5));
l9_2287=mix(l9_2289,1.0-l9_2289,fast::clamp(l9_2291,0.0,1.0));
}
}
l9_2271.y=l9_2287;
if (l9_2275)
{
bool l9_2292=l9_2277;
bool l9_2293;
if (l9_2292)
{
l9_2293=l9_2274.x==3;
}
else
{
l9_2293=l9_2292;
}
float l9_2294=l9_2271.x;
float l9_2295=l9_2276.x;
float l9_2296=l9_2276.z;
bool l9_2297=l9_2293;
float l9_2298=l9_2281;
float l9_2299=fast::clamp(l9_2294,l9_2295,l9_2296);
float l9_2300=step(abs(l9_2294-l9_2299),9.9999997e-06);
l9_2298*=(l9_2300+((1.0-float(l9_2297))*(1.0-l9_2300)));
l9_2294=l9_2299;
l9_2271.x=l9_2294;
l9_2281=l9_2298;
bool l9_2301=l9_2277;
bool l9_2302;
if (l9_2301)
{
l9_2302=l9_2274.y==3;
}
else
{
l9_2302=l9_2301;
}
float l9_2303=l9_2271.y;
float l9_2304=l9_2276.y;
float l9_2305=l9_2276.w;
bool l9_2306=l9_2302;
float l9_2307=l9_2281;
float l9_2308=fast::clamp(l9_2303,l9_2304,l9_2305);
float l9_2309=step(abs(l9_2303-l9_2308),9.9999997e-06);
l9_2307*=(l9_2309+((1.0-float(l9_2306))*(1.0-l9_2309)));
l9_2303=l9_2308;
l9_2271.y=l9_2303;
l9_2281=l9_2307;
}
float2 l9_2310=l9_2271;
bool l9_2311=l9_2272;
float3x3 l9_2312=l9_2273;
if (l9_2311)
{
l9_2310=float2((l9_2312*float3(l9_2310,1.0)).xy);
}
float2 l9_2313=l9_2310;
float2 l9_2314=l9_2313;
float2 l9_2315=l9_2314;
l9_2271=l9_2315;
float l9_2316=l9_2271.x;
int l9_2317=l9_2274.x;
bool l9_2318=l9_2280;
float l9_2319=l9_2281;
if ((l9_2317==0)||(l9_2317==3))
{
float l9_2320=l9_2316;
float l9_2321=0.0;
float l9_2322=1.0;
bool l9_2323=l9_2318;
float l9_2324=l9_2319;
float l9_2325=fast::clamp(l9_2320,l9_2321,l9_2322);
float l9_2326=step(abs(l9_2320-l9_2325),9.9999997e-06);
l9_2324*=(l9_2326+((1.0-float(l9_2323))*(1.0-l9_2326)));
l9_2320=l9_2325;
l9_2316=l9_2320;
l9_2319=l9_2324;
}
l9_2271.x=l9_2316;
l9_2281=l9_2319;
float l9_2327=l9_2271.y;
int l9_2328=l9_2274.y;
bool l9_2329=l9_2280;
float l9_2330=l9_2281;
if ((l9_2328==0)||(l9_2328==3))
{
float l9_2331=l9_2327;
float l9_2332=0.0;
float l9_2333=1.0;
bool l9_2334=l9_2329;
float l9_2335=l9_2330;
float l9_2336=fast::clamp(l9_2331,l9_2332,l9_2333);
float l9_2337=step(abs(l9_2331-l9_2336),9.9999997e-06);
l9_2335*=(l9_2337+((1.0-float(l9_2334))*(1.0-l9_2337)));
l9_2331=l9_2336;
l9_2327=l9_2331;
l9_2330=l9_2335;
}
l9_2271.y=l9_2327;
l9_2281=l9_2330;
float2 l9_2338=l9_2271;
int l9_2339=l9_2269;
int l9_2340=l9_2270;
float l9_2341=l9_2279;
float2 l9_2342=l9_2338;
int l9_2343=l9_2339;
int l9_2344=l9_2340;
float3 l9_2345=float3(0.0);
if (l9_2343==0)
{
l9_2345=float3(l9_2342,0.0);
}
else
{
if (l9_2343==1)
{
l9_2345=float3(l9_2342.x,(l9_2342.y*0.5)+(0.5-(float(l9_2344)*0.5)),0.0);
}
else
{
l9_2345=float3(l9_2342,float(l9_2344));
}
}
float3 l9_2346=l9_2345;
float3 l9_2347=l9_2346;
float2 l9_2348=l9_2347.xy;
float l9_2349=l9_2341;
float4 l9_2350=sc_set2.colorRampTexture.sample(sc_set2.colorRampTextureSmpSC,l9_2348,bias(l9_2349));
float4 l9_2351=l9_2350;
float4 l9_2352=l9_2351;
if (l9_2277)
{
l9_2352=mix(l9_2278,l9_2352,float4(l9_2281));
}
float4 l9_2353=l9_2352;
l9_2262=l9_2353;
float4 l9_2354=l9_2262;
l9_2257=l9_2354*N2_colorRampMult;
float4 l9_2355=float4(1.0);
float4 l9_2356=float4(1.0);
if (N2_ENABLE_BASETEXTURE)
{
float2 l9_2357=tempGlobals.Surface_UVCoord0;
float2 l9_2358=l9_2357;
float4 l9_2359=float4(0.0);
int l9_2360=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_2361=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2361=0;
}
else
{
l9_2361=in.varStereoViewID;
}
int l9_2362=l9_2361;
l9_2360=1-l9_2362;
}
else
{
int l9_2363=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2363=0;
}
else
{
l9_2363=in.varStereoViewID;
}
int l9_2364=l9_2363;
l9_2360=l9_2364;
}
int l9_2365=l9_2360;
int l9_2366=mainTextureLayout_tmp;
int l9_2367=l9_2365;
float2 l9_2368=l9_2358;
bool l9_2369=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_2370=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_2371=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_2372=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_2373=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_2374=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_2375=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_2376=0.0;
bool l9_2377=l9_2374&&(!l9_2372);
float l9_2378=1.0;
float l9_2379=l9_2368.x;
int l9_2380=l9_2371.x;
if (l9_2380==1)
{
l9_2379=fract(l9_2379);
}
else
{
if (l9_2380==2)
{
float l9_2381=fract(l9_2379);
float l9_2382=l9_2379-l9_2381;
float l9_2383=step(0.25,fract(l9_2382*0.5));
l9_2379=mix(l9_2381,1.0-l9_2381,fast::clamp(l9_2383,0.0,1.0));
}
}
l9_2368.x=l9_2379;
float l9_2384=l9_2368.y;
int l9_2385=l9_2371.y;
if (l9_2385==1)
{
l9_2384=fract(l9_2384);
}
else
{
if (l9_2385==2)
{
float l9_2386=fract(l9_2384);
float l9_2387=l9_2384-l9_2386;
float l9_2388=step(0.25,fract(l9_2387*0.5));
l9_2384=mix(l9_2386,1.0-l9_2386,fast::clamp(l9_2388,0.0,1.0));
}
}
l9_2368.y=l9_2384;
if (l9_2372)
{
bool l9_2389=l9_2374;
bool l9_2390;
if (l9_2389)
{
l9_2390=l9_2371.x==3;
}
else
{
l9_2390=l9_2389;
}
float l9_2391=l9_2368.x;
float l9_2392=l9_2373.x;
float l9_2393=l9_2373.z;
bool l9_2394=l9_2390;
float l9_2395=l9_2378;
float l9_2396=fast::clamp(l9_2391,l9_2392,l9_2393);
float l9_2397=step(abs(l9_2391-l9_2396),9.9999997e-06);
l9_2395*=(l9_2397+((1.0-float(l9_2394))*(1.0-l9_2397)));
l9_2391=l9_2396;
l9_2368.x=l9_2391;
l9_2378=l9_2395;
bool l9_2398=l9_2374;
bool l9_2399;
if (l9_2398)
{
l9_2399=l9_2371.y==3;
}
else
{
l9_2399=l9_2398;
}
float l9_2400=l9_2368.y;
float l9_2401=l9_2373.y;
float l9_2402=l9_2373.w;
bool l9_2403=l9_2399;
float l9_2404=l9_2378;
float l9_2405=fast::clamp(l9_2400,l9_2401,l9_2402);
float l9_2406=step(abs(l9_2400-l9_2405),9.9999997e-06);
l9_2404*=(l9_2406+((1.0-float(l9_2403))*(1.0-l9_2406)));
l9_2400=l9_2405;
l9_2368.y=l9_2400;
l9_2378=l9_2404;
}
float2 l9_2407=l9_2368;
bool l9_2408=l9_2369;
float3x3 l9_2409=l9_2370;
if (l9_2408)
{
l9_2407=float2((l9_2409*float3(l9_2407,1.0)).xy);
}
float2 l9_2410=l9_2407;
float2 l9_2411=l9_2410;
float2 l9_2412=l9_2411;
l9_2368=l9_2412;
float l9_2413=l9_2368.x;
int l9_2414=l9_2371.x;
bool l9_2415=l9_2377;
float l9_2416=l9_2378;
if ((l9_2414==0)||(l9_2414==3))
{
float l9_2417=l9_2413;
float l9_2418=0.0;
float l9_2419=1.0;
bool l9_2420=l9_2415;
float l9_2421=l9_2416;
float l9_2422=fast::clamp(l9_2417,l9_2418,l9_2419);
float l9_2423=step(abs(l9_2417-l9_2422),9.9999997e-06);
l9_2421*=(l9_2423+((1.0-float(l9_2420))*(1.0-l9_2423)));
l9_2417=l9_2422;
l9_2413=l9_2417;
l9_2416=l9_2421;
}
l9_2368.x=l9_2413;
l9_2378=l9_2416;
float l9_2424=l9_2368.y;
int l9_2425=l9_2371.y;
bool l9_2426=l9_2377;
float l9_2427=l9_2378;
if ((l9_2425==0)||(l9_2425==3))
{
float l9_2428=l9_2424;
float l9_2429=0.0;
float l9_2430=1.0;
bool l9_2431=l9_2426;
float l9_2432=l9_2427;
float l9_2433=fast::clamp(l9_2428,l9_2429,l9_2430);
float l9_2434=step(abs(l9_2428-l9_2433),9.9999997e-06);
l9_2432*=(l9_2434+((1.0-float(l9_2431))*(1.0-l9_2434)));
l9_2428=l9_2433;
l9_2424=l9_2428;
l9_2427=l9_2432;
}
l9_2368.y=l9_2424;
l9_2378=l9_2427;
float2 l9_2435=l9_2368;
int l9_2436=l9_2366;
int l9_2437=l9_2367;
float l9_2438=l9_2376;
float2 l9_2439=l9_2435;
int l9_2440=l9_2436;
int l9_2441=l9_2437;
float3 l9_2442=float3(0.0);
if (l9_2440==0)
{
l9_2442=float3(l9_2439,0.0);
}
else
{
if (l9_2440==1)
{
l9_2442=float3(l9_2439.x,(l9_2439.y*0.5)+(0.5-(float(l9_2441)*0.5)),0.0);
}
else
{
l9_2442=float3(l9_2439,float(l9_2441));
}
}
float3 l9_2443=l9_2442;
float3 l9_2444=l9_2443;
float2 l9_2445=l9_2444.xy;
float l9_2446=l9_2438;
float4 l9_2447=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_2445,bias(l9_2446));
float4 l9_2448=l9_2447;
float4 l9_2449=l9_2448;
if (l9_2374)
{
l9_2449=mix(l9_2375,l9_2449,float4(l9_2378));
}
float4 l9_2450=l9_2449;
l9_2359=l9_2450;
float4 l9_2451=l9_2359;
l9_2355=l9_2451;
float2 l9_2452=tempGlobals.Surface_UVCoord0;
N2_uv=l9_2452;
if (N2_ENABLE_FLIPBOOK)
{
l9_2355=l9_1956;
N2_uv=l9_1958;
}
}
if (N2_ENABLE_COLORRAMP)
{
if (!(!(SC_DEVICE_CLASS_tmp>=2)))
{
l9_2356=l9_2257;
}
}
N2_result=(l9_2355*l9_1951)*l9_2356;
if (N2_ENABLE_SCREENFADE)
{
N2_result.w*=N2_nearCameraFade;
}
if (N2_ENABLE_ALPHADISSOLVE)
{
float l9_2453=l9_1950*N2_alphaDissolveMult;
N2_result.w=fast::clamp(N2_result.w-l9_2453,0.0,1.0);
}
if (N2_ENABLE_BLACKASALPHA)
{
float l9_2454=length(N2_result.xyz);
N2_result.w=l9_2454;
}
if (N2_ENABLE_PREMULTIPLIEDCOLOR)
{
float3 l9_2455=N2_result.xyz*N2_result.w;
N2_result=float4(l9_2455.x,l9_2455.y,l9_2455.z,N2_result.w);
}
l9_1930=N2_result;
l9_1906=l9_1930;
param_1=l9_1906;
param_2=param_1;
}
Result_N153=param_2;
FinalColor=Result_N153;
float4 param_4=FinalColor;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_2456=param_4;
float4 l9_2457=l9_2456;
float l9_2458=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_2458=l9_2457.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_2458=fast::clamp(l9_2457.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_2458=fast::clamp(dot(l9_2457.xyz,float3(l9_2457.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_2458=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_2458=(1.0-dot(l9_2457.xyz,float3(0.33333001)))*l9_2457.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_2458=(1.0-fast::clamp(dot(l9_2457.xyz,float3(1.0)),0.0,1.0))*l9_2457.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_2458=fast::clamp(dot(l9_2457.xyz,float3(1.0)),0.0,1.0)*l9_2457.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_2458=fast::clamp(dot(l9_2457.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_2458=fast::clamp(dot(l9_2457.xyz,float3(1.0)),0.0,1.0)*l9_2457.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_2458=dot(l9_2457.xyz,float3(0.33333001))*l9_2457.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_2458=1.0-fast::clamp(dot(l9_2457.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_2458=fast::clamp(dot(l9_2457.xyz,float3(1.0)),0.0,1.0);
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
float l9_2459=l9_2458;
float l9_2460=l9_2459;
float l9_2461=(*sc_set2.UserUniforms).sc_ShadowDensity*l9_2460;
float3 l9_2462=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_2456.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float4 l9_2463=float4(l9_2462.x,l9_2462.y,l9_2462.z,l9_2461);
param_4=l9_2463;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_4=float4(param_4.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_2464=param_4;
float4 l9_2465=float4(0.0);
float4 l9_2466=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_2467=out.FragColor0;
float4 l9_2468=l9_2467;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_2468.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_2469=l9_2468;
l9_2466=l9_2469;
}
else
{
float4 l9_2470=gl_FragCoord;
float2 l9_2471=(l9_2470.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_2472=l9_2471;
float2 l9_2473=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_2474=1;
int l9_2475=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2475=0;
}
else
{
l9_2475=in.varStereoViewID;
}
int l9_2476=l9_2475;
int l9_2477=l9_2476;
float3 l9_2478=float3(l9_2472,0.0);
int l9_2479=l9_2474;
int l9_2480=l9_2477;
if (l9_2479==1)
{
l9_2478.y=((2.0*l9_2478.y)+float(l9_2480))-1.0;
}
float2 l9_2481=l9_2478.xy;
l9_2473=l9_2481;
}
else
{
l9_2473=l9_2472;
}
float2 l9_2482=l9_2473;
float2 l9_2483=l9_2482;
float2 l9_2484=l9_2483;
int l9_2485=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_2486=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2486=0;
}
else
{
l9_2486=in.varStereoViewID;
}
int l9_2487=l9_2486;
l9_2485=1-l9_2487;
}
else
{
int l9_2488=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_2488=0;
}
else
{
l9_2488=in.varStereoViewID;
}
int l9_2489=l9_2488;
l9_2485=l9_2489;
}
int l9_2490=l9_2485;
float2 l9_2491=l9_2484;
int l9_2492=l9_2490;
float2 l9_2493=l9_2491;
int l9_2494=l9_2492;
float l9_2495=0.0;
float4 l9_2496=float4(0.0);
float2 l9_2497=l9_2493;
int l9_2498=sc_ScreenTextureLayout_tmp;
int l9_2499=l9_2494;
float l9_2500=l9_2495;
float2 l9_2501=l9_2497;
int l9_2502=l9_2498;
int l9_2503=l9_2499;
float3 l9_2504=float3(0.0);
if (l9_2502==0)
{
l9_2504=float3(l9_2501,0.0);
}
else
{
if (l9_2502==1)
{
l9_2504=float3(l9_2501.x,(l9_2501.y*0.5)+(0.5-(float(l9_2503)*0.5)),0.0);
}
else
{
l9_2504=float3(l9_2501,float(l9_2503));
}
}
float3 l9_2505=l9_2504;
float3 l9_2506=l9_2505;
float2 l9_2507=l9_2506.xy;
float l9_2508=l9_2500;
float4 l9_2509=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_2507,bias(l9_2508));
float4 l9_2510=l9_2509;
l9_2496=l9_2510;
float4 l9_2511=l9_2496;
float4 l9_2512=l9_2511;
float4 l9_2513=l9_2512;
l9_2466=l9_2513;
}
float4 l9_2514=l9_2466;
float4 l9_2515=l9_2514;
float3 l9_2516=l9_2515.xyz;
float3 l9_2517=l9_2516;
float3 l9_2518=l9_2464.xyz;
float3 l9_2519=definedBlend(l9_2517,l9_2518,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.intensityTexture,sc_set2.intensityTextureSmpSC);
l9_2465=float4(l9_2519.x,l9_2519.y,l9_2519.z,l9_2465.w);
float3 l9_2520=mix(l9_2516,l9_2465.xyz,float3(l9_2464.w));
l9_2465=float4(l9_2520.x,l9_2520.y,l9_2520.z,l9_2465.w);
l9_2465.w=1.0;
float4 l9_2521=l9_2465;
param_4=l9_2521;
}
else
{
float4 l9_2522=param_4;
float4 l9_2523=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_2523=float4(mix(float3(1.0),l9_2522.xyz,float3(l9_2522.w)),l9_2522.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_2524=l9_2522.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_2524=fast::clamp(l9_2524,0.0,1.0);
}
l9_2523=float4(l9_2522.xyz*l9_2524,l9_2524);
}
else
{
l9_2523=l9_2522;
}
}
float4 l9_2525=l9_2523;
param_4=l9_2525;
}
}
}
float4 l9_2526=param_4;
FinalColor=l9_2526;
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
float4 l9_2527=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_2527=float4((*sc_set2.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_2527=float4(0.0);
}
float4 l9_2528=l9_2527;
float4 Cost=l9_2528;
if (Cost.w>0.0)
{
FinalColor=Cost;
}
FinalColor=fast::max(FinalColor,float4(0.0));
float3 param_5=in.varPos;
float4 param_6=FinalColor;
FinalColor=outputMotionVectorsIfNeeded(param_5,param_6,in.varStereoViewID,(*sc_set2.UserUniforms));
float4 param_7=FinalColor;
float4 l9_2529=param_7;
out.FragColor0=l9_2529;
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
float2 Surface_UVCoord1;
float gInstanceID;
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
float timeGlobal;
float externalTimeInput;
float externalSeed;
float lifeTimeConstant;
float2 lifeTimeMinMax;
float spawnDuration;
float3 spawnLocation;
float3 spawnBox;
float3 spawnSphere;
float3 noiseMult;
float3 noiseFrequency;
float3 sNoiseMult;
float3 sNoiseFrequency;
float3 velocityMin;
float3 velocityMax;
float3 velocityDrag;
float4 velRampTextureSize;
float4 velRampTextureDims;
float4 velRampTextureView;
float3x3 velRampTextureTransform;
float4 velRampTextureUvMinMax;
float4 velRampTextureBorderColor;
float2 sizeStart;
float3 sizeStart3D;
float2 sizeEnd;
float3 sizeEnd3D;
float2 sizeStartMin;
float3 sizeStartMin3D;
float2 sizeStartMax;
float3 sizeStartMax3D;
float2 sizeEndMin;
float3 sizeEndMin3D;
float2 sizeEndMax;
float3 sizeEndMax3D;
float sizeSpeed;
float4 sizeRampTextureSize;
float4 sizeRampTextureDims;
float4 sizeRampTextureView;
float3x3 sizeRampTextureTransform;
float4 sizeRampTextureUvMinMax;
float4 sizeRampTextureBorderColor;
float gravity;
float3 localForce;
float sizeVelScale;
int ALIGNTOX;
int ALIGNTOY;
int ALIGNTOZ;
float2 rotationRandomX;
float2 rotationRateX;
float2 randomRotationY;
float2 rotationRateY;
float2 rotationRandom;
float2 randomRotationZ;
float2 rotationRate;
float2 rotationRateZ;
float rotationDrag;
int CENTER_BBOX;
float fadeDistanceVisible;
float fadeDistanceInvisible;
float3 colorStart;
float3 colorEnd;
float3 colorMinStart;
float3 colorMinEnd;
float3 colorMaxStart;
float3 colorMaxEnd;
float alphaStart;
float alphaEnd;
float alphaMinStart;
float alphaMinEnd;
float alphaMaxStart;
float alphaMaxEnd;
float alphaDissolveMult;
float numValidFrames;
float2 gridSize;
float flipBookSpeedMult;
float flipBookRandomStart;
float4 colorRampTextureSize;
float4 colorRampTextureDims;
float4 colorRampTextureView;
float3x3 colorRampTextureTransform;
float4 colorRampTextureUvMinMax;
float4 colorRampTextureBorderColor;
float4 colorRampMult;
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
float4 normalTexSize;
float4 normalTexDims;
float4 normalTexView;
float3x3 normalTexTransform;
float4 normalTexUvMinMax;
float4 normalTexBorderColor;
float metallic;
float roughness;
float Port_Input1_N119;
float2 Port_Input1_N138;
float2 Port_Input1_N139;
float2 Port_Input1_N140;
float2 Port_Input1_N144;
float Port_Input1_N069;
float Port_Input1_N068;
float Port_Input1_N110;
float Port_Input1_N154;
float3 Port_Default_N167;
float3 Port_Emissive_N014;
float3 Port_AO_N014;
float3 Port_SpecularAO_N014;
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
constant sc_Bones_obj* sc_BonesUBO [[id(0)]];
texture2d<float> colorRampTexture [[id(1)]];
texture2d<float> intensityTexture [[id(2)]];
texture2d<float> mainTexture [[id(3)]];
texture2d<float> normalTex [[id(4)]];
texture2d<float> sc_EnvmapDiffuse [[id(5)]];
texture2d<float> sc_EnvmapSpecular [[id(6)]];
texture2d<float> sc_RayTracedAoTexture [[id(15)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(16)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(17)]];
texture2d<float> sc_RayTracedShadowTexture [[id(18)]];
texture2d<float> sc_SSAOTexture [[id(19)]];
texture2d<float> sc_ScreenTexture [[id(20)]];
texture2d<float> sc_ShadowTexture [[id(21)]];
texture2d<float> sizeRampTexture [[id(23)]];
texture2d<float> velRampTexture [[id(24)]];
sampler colorRampTextureSmpSC [[id(25)]];
sampler intensityTextureSmpSC [[id(26)]];
sampler mainTextureSmpSC [[id(27)]];
sampler normalTexSmpSC [[id(28)]];
sampler sc_EnvmapDiffuseSmpSC [[id(29)]];
sampler sc_EnvmapSpecularSmpSC [[id(30)]];
sampler sc_RayTracedAoTextureSmpSC [[id(32)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(33)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(34)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(35)]];
sampler sc_SSAOTextureSmpSC [[id(36)]];
sampler sc_ScreenTextureSmpSC [[id(37)]];
sampler sc_ShadowTextureSmpSC [[id(38)]];
sampler sizeRampTextureSmpSC [[id(40)]];
sampler velRampTextureSmpSC [[id(41)]];
constant userUniformsObj* UserUniforms [[id(42)]];
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
float Interpolator_gInstanceID [[user(locn13)]];
float4 Interpolator0 [[user(locn14)]];
float4 Interpolator1 [[user(locn15)]];
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
float3 N2_colorStart=float3(0.0);
float3 N2_colorEnd=float3(0.0);
bool N2_ENABLE_COLORMINMAX=false;
float3 N2_colorMinStart=float3(0.0);
float3 N2_colorMinEnd=float3(0.0);
float3 N2_colorMaxStart=float3(0.0);
float3 N2_colorMaxEnd=float3(0.0);
bool N2_ENABLE_COLORMONOMIN=false;
float N2_alphaStart=0.0;
float N2_alphaEnd=0.0;
bool N2_ENABLE_ALPHAMINMAX=false;
float N2_alphaMinStart=0.0;
float N2_alphaMinEnd=0.0;
float N2_alphaMaxStart=0.0;
float N2_alphaMaxEnd=0.0;
bool N2_ENABLE_ALPHADISSOLVE=false;
float N2_alphaDissolveMult=0.0;
bool N2_ENABLE_PREMULTIPLIEDCOLOR=false;
bool N2_ENABLE_BLACKASALPHA=false;
bool N2_ENABLE_SCREENFADE=false;
float N2_nearCameraFade=0.0;
bool N2_ENABLE_FLIPBOOK=false;
float N2_numValidFrames=0.0;
float2 N2_gridSize=float2(0.0);
float N2_flipBookSpeedMult=0.0;
float N2_flipBookRandomStart=0.0;
bool N2_ENABLE_FLIPBOOKBLEND=false;
bool N2_ENABLE_FLIPBOOKBYLIFE=false;
bool N2_ENABLE_COLORRAMP=false;
float2 N2_texSize=float2(0.0);
float4 N2_colorRampMult=float4(0.0);
bool N2_ENABLE_NORANDOFFSET=false;
bool N2_ENABLE_BASETEXTURE=false;
float4 N2_timeValuesIn=float4(0.0);
bool N2_ENABLE_WORLDPOSSEED=false;
float N2_externalSeed=0.0;
float3 N2_particleSeed=float3(0.0);
float N2_globalSeed=0.0;
float4 N2_result=float4(0.0);
float2 N2_uv=float2(0.0);
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
Globals.Surface_UVCoord1=in.varPackedTex.zw;
Globals.gInstanceID=in.Interpolator_gInstanceID;
ssGlobals param=Globals;
ssGlobals tempGlobals;
if ((MESHTYPE_tmp==1)&&(int(PBR_tmp)!=0))
{
float3 l9_2=float3(0.0);
float3 l9_3=(*sc_set2.UserUniforms).colorStart;
l9_2=l9_3;
float3 l9_4=float3(0.0);
float3 l9_5=(*sc_set2.UserUniforms).colorEnd;
l9_4=l9_5;
float3 l9_6=float3(0.0);
float3 l9_7=(*sc_set2.UserUniforms).colorMinStart;
l9_6=l9_7;
float3 l9_8=float3(0.0);
float3 l9_9=(*sc_set2.UserUniforms).colorMinEnd;
l9_8=l9_9;
float3 l9_10=float3(0.0);
float3 l9_11=(*sc_set2.UserUniforms).colorMaxStart;
l9_10=l9_11;
float3 l9_12=float3(0.0);
float3 l9_13=(*sc_set2.UserUniforms).colorMaxEnd;
l9_12=l9_13;
float l9_14=0.0;
float l9_15=(*sc_set2.UserUniforms).alphaStart;
l9_14=l9_15;
float l9_16=0.0;
float l9_17=(*sc_set2.UserUniforms).alphaEnd;
l9_16=l9_17;
float l9_18=0.0;
float l9_19=(*sc_set2.UserUniforms).alphaMinStart;
l9_18=l9_19;
float l9_20=0.0;
float l9_21=(*sc_set2.UserUniforms).alphaMinEnd;
l9_20=l9_21;
float l9_22=0.0;
float l9_23=(*sc_set2.UserUniforms).alphaMaxStart;
l9_22=l9_23;
float l9_24=0.0;
float l9_25=(*sc_set2.UserUniforms).alphaMaxEnd;
l9_24=l9_25;
float l9_26=0.0;
float l9_27=(*sc_set2.UserUniforms).alphaDissolveMult;
l9_26=l9_27;
float l9_28=0.0;
l9_28=in.Interpolator0.x;
float l9_29=0.0;
float l9_30=(*sc_set2.UserUniforms).numValidFrames;
l9_29=l9_30;
float2 l9_31=float2(0.0);
float2 l9_32=(*sc_set2.UserUniforms).gridSize;
l9_31=l9_32;
float l9_33=0.0;
float l9_34=(*sc_set2.UserUniforms).flipBookSpeedMult;
l9_33=l9_34;
float l9_35=0.0;
float l9_36=(*sc_set2.UserUniforms).flipBookRandomStart;
l9_35=l9_36;
float2 l9_37=float2(0.0);
float2 l9_38=(*sc_set2.UserUniforms).colorRampTextureSize.xy;
l9_37=l9_38;
float4 l9_39=float4(0.0);
float4 l9_40=(*sc_set2.UserUniforms).colorRampMult;
l9_39=l9_40;
float4 l9_41=float4(0.0);
float4 l9_42;
l9_42.x=in.Interpolator0.y;
l9_42.y=in.Interpolator0.z;
l9_42.z=in.Interpolator0.w;
l9_42.w=in.Interpolator1.x;
l9_41=l9_42;
float l9_43=0.0;
float l9_44=(*sc_set2.UserUniforms).externalSeed;
l9_43=l9_44;
float4 l9_45=float4(0.0);
float3 l9_46=l9_2;
float3 l9_47=l9_4;
float3 l9_48=l9_6;
float3 l9_49=l9_8;
float3 l9_50=l9_10;
float3 l9_51=l9_12;
float l9_52=l9_14;
float l9_53=l9_16;
float l9_54=l9_18;
float l9_55=l9_20;
float l9_56=l9_22;
float l9_57=l9_24;
float l9_58=l9_26;
float l9_59=l9_28;
float l9_60=l9_29;
float2 l9_61=l9_31;
float l9_62=l9_33;
float l9_63=l9_35;
float2 l9_64=l9_37;
float4 l9_65=l9_39;
float4 l9_66=l9_41;
float l9_67=l9_43;
ssGlobals l9_68=param;
tempGlobals=l9_68;
float4 l9_69=float4(0.0);
N2_colorStart=l9_46;
N2_colorEnd=l9_47;
N2_ENABLE_COLORMINMAX=(int(COLORMINMAX_tmp)!=0);
N2_colorMinStart=l9_48;
N2_colorMinEnd=l9_49;
N2_colorMaxStart=l9_50;
N2_colorMaxEnd=l9_51;
N2_ENABLE_COLORMONOMIN=(int(COLORMONOMIN_tmp)!=0);
N2_alphaStart=l9_52;
N2_alphaEnd=l9_53;
N2_ENABLE_ALPHAMINMAX=(int(ALPHAMINMAX_tmp)!=0);
N2_alphaMinStart=l9_54;
N2_alphaMinEnd=l9_55;
N2_alphaMaxStart=l9_56;
N2_alphaMaxEnd=l9_57;
N2_ENABLE_ALPHADISSOLVE=(int(ALPHADISSOLVE_tmp)!=0);
N2_alphaDissolveMult=l9_58;
N2_ENABLE_PREMULTIPLIEDCOLOR=(int(PREMULTIPLIEDCOLOR_tmp)!=0);
N2_ENABLE_BLACKASALPHA=(int(BLACKASALPHA_tmp)!=0);
N2_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N2_nearCameraFade=l9_59;
N2_ENABLE_FLIPBOOK=(int(FLIPBOOK_tmp)!=0);
N2_numValidFrames=l9_60;
N2_gridSize=l9_61;
N2_flipBookSpeedMult=l9_62;
N2_flipBookRandomStart=l9_63;
N2_ENABLE_FLIPBOOKBLEND=(int(FLIPBOOKBLEND_tmp)!=0);
N2_ENABLE_FLIPBOOKBYLIFE=(int(FLIPBOOKBYLIFE_tmp)!=0);
N2_ENABLE_COLORRAMP=(int(COLORRAMP_tmp)!=0);
N2_texSize=l9_64;
N2_colorRampMult=l9_65;
N2_ENABLE_NORANDOFFSET=(int(NORANDOFFSET_tmp)!=0);
N2_ENABLE_BASETEXTURE=(int(BASETEXTURE_tmp)!=0);
N2_timeValuesIn=l9_66;
N2_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N2_externalSeed=l9_67;
float l9_70=0.0;
if (N2_ENABLE_WORLDPOSSEED)
{
float4x4 l9_71=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_70=length(float4(1.0)*l9_71);
}
N2_globalSeed=N2_externalSeed+l9_70;
float l9_72=2000.0;
int l9_73=0;
l9_73=int(tempGlobals.gInstanceID);
int l9_74=l9_73;
float l9_75=float(l9_74);
float2 l9_76=float2(mod(l9_75,l9_72),floor(l9_75/l9_72));
l9_76/=float2(l9_72);
float2 l9_77=l9_76;
float l9_78=dot(l9_77,float2(0.38253,0.42662001));
float3 l9_79=float3(0.457831,0.62343299,0.97625297)*l9_78;
l9_79=sin(l9_79)*float3(479.371,389.53101,513.03497);
l9_79=fract(l9_79);
l9_79=floor(l9_79*10000.0)*9.9999997e-05;
float3 l9_80=l9_79;
float3 l9_81=l9_80;
N2_particleSeed=l9_81;
float l9_82=N2_particleSeed.x;
float l9_83=N2_particleSeed.y;
float l9_84=N2_particleSeed.z;
float3 l9_85=fract((float3(l9_82,l9_83,l9_84)*27.21883)+float3(N2_globalSeed));
if (N2_ENABLE_COLORMONOMIN)
{
l9_85=fract((float3(l9_82,l9_82,l9_82)*27.21883)+float3(N2_globalSeed));
}
float l9_86=fract((N2_particleSeed.x*3121.3333)+N2_globalSeed);
float l9_87=fract((N2_particleSeed.y*13.2234)+N2_globalSeed);
float l9_88=fract((N2_particleSeed.z*3.5358)+N2_globalSeed);
float l9_89=N2_timeValuesIn.w;
float4 l9_90=float4(0.0);
float3 l9_91=float3(0.0);
float3 l9_92=float3(0.0);
float l9_93=0.0;
float l9_94=0.0;
if (N2_ENABLE_COLORMINMAX)
{
l9_91=mix(N2_colorMinStart,N2_colorMaxStart,l9_85);
l9_92=mix(N2_colorMinEnd,N2_colorMaxEnd,l9_85);
}
else
{
l9_91=N2_colorStart;
l9_92=N2_colorEnd;
}
if (N2_ENABLE_ALPHAMINMAX)
{
l9_93=mix(N2_alphaMinStart,N2_alphaMaxStart,l9_86);
l9_94=mix(N2_alphaMinEnd,N2_alphaMaxEnd,l9_86);
}
else
{
l9_93=N2_alphaStart;
l9_94=N2_alphaEnd;
}
l9_91=mix(l9_91,l9_92,float3(l9_89));
l9_93=mix(l9_93,l9_94,l9_89);
l9_90=float4(l9_91,l9_93);
float4 l9_95=float4(0.0);
float2 l9_96=tempGlobals.Surface_UVCoord0;
float2 l9_97=l9_96;
float2 l9_98=tempGlobals.Surface_UVCoord1;
float2 l9_99=l9_98;
float l9_100=fast::max(N2_timeValuesIn.x,0.0099999998);
float l9_101=fast::max(N2_timeValuesIn.y,0.0099999998);
float l9_102=N2_timeValuesIn.z;
if (N2_ENABLE_FLIPBOOKBYLIFE)
{
float l9_103=mix(l9_100,l9_101,l9_88);
l9_102=N2_timeValuesIn.z/l9_103;
}
float l9_104=mix(0.0,N2_flipBookRandomStart,l9_87);
float2 l9_105=l9_97/N2_gridSize;
float l9_106=(l9_102*N2_flipBookSpeedMult)+l9_104;
l9_106=mod(l9_106,N2_numValidFrames);
float l9_107=floor(l9_106)*(1.0/N2_gridSize.x);
float l9_108=mod(floor((-l9_106)/N2_gridSize.x),N2_gridSize.y)*(1.0/N2_gridSize.y);
float l9_109=l9_106+1.0;
l9_109=mod(l9_109,N2_numValidFrames);
float l9_110=floor(l9_109)*(1.0/N2_gridSize.x);
float l9_111=floor((-l9_109)*(1.0/N2_gridSize.x))*(1.0/N2_gridSize.y);
float l9_112=fract(l9_106);
l9_97=l9_105+float2(l9_107,l9_108);
l9_99=l9_105+float2(l9_110,l9_111);
if (N2_ENABLE_FLIPBOOKBLEND)
{
float2 l9_113=l9_97;
float4 l9_114=float4(0.0);
int l9_115=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_116=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_116=0;
}
else
{
l9_116=in.varStereoViewID;
}
int l9_117=l9_116;
l9_115=1-l9_117;
}
else
{
int l9_118=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_118=0;
}
else
{
l9_118=in.varStereoViewID;
}
int l9_119=l9_118;
l9_115=l9_119;
}
int l9_120=l9_115;
int l9_121=mainTextureLayout_tmp;
int l9_122=l9_120;
float2 l9_123=l9_113;
bool l9_124=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_125=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_126=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_127=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_128=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_129=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_130=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_131=0.0;
bool l9_132=l9_129&&(!l9_127);
float l9_133=1.0;
float l9_134=l9_123.x;
int l9_135=l9_126.x;
if (l9_135==1)
{
l9_134=fract(l9_134);
}
else
{
if (l9_135==2)
{
float l9_136=fract(l9_134);
float l9_137=l9_134-l9_136;
float l9_138=step(0.25,fract(l9_137*0.5));
l9_134=mix(l9_136,1.0-l9_136,fast::clamp(l9_138,0.0,1.0));
}
}
l9_123.x=l9_134;
float l9_139=l9_123.y;
int l9_140=l9_126.y;
if (l9_140==1)
{
l9_139=fract(l9_139);
}
else
{
if (l9_140==2)
{
float l9_141=fract(l9_139);
float l9_142=l9_139-l9_141;
float l9_143=step(0.25,fract(l9_142*0.5));
l9_139=mix(l9_141,1.0-l9_141,fast::clamp(l9_143,0.0,1.0));
}
}
l9_123.y=l9_139;
if (l9_127)
{
bool l9_144=l9_129;
bool l9_145;
if (l9_144)
{
l9_145=l9_126.x==3;
}
else
{
l9_145=l9_144;
}
float l9_146=l9_123.x;
float l9_147=l9_128.x;
float l9_148=l9_128.z;
bool l9_149=l9_145;
float l9_150=l9_133;
float l9_151=fast::clamp(l9_146,l9_147,l9_148);
float l9_152=step(abs(l9_146-l9_151),9.9999997e-06);
l9_150*=(l9_152+((1.0-float(l9_149))*(1.0-l9_152)));
l9_146=l9_151;
l9_123.x=l9_146;
l9_133=l9_150;
bool l9_153=l9_129;
bool l9_154;
if (l9_153)
{
l9_154=l9_126.y==3;
}
else
{
l9_154=l9_153;
}
float l9_155=l9_123.y;
float l9_156=l9_128.y;
float l9_157=l9_128.w;
bool l9_158=l9_154;
float l9_159=l9_133;
float l9_160=fast::clamp(l9_155,l9_156,l9_157);
float l9_161=step(abs(l9_155-l9_160),9.9999997e-06);
l9_159*=(l9_161+((1.0-float(l9_158))*(1.0-l9_161)));
l9_155=l9_160;
l9_123.y=l9_155;
l9_133=l9_159;
}
float2 l9_162=l9_123;
bool l9_163=l9_124;
float3x3 l9_164=l9_125;
if (l9_163)
{
l9_162=float2((l9_164*float3(l9_162,1.0)).xy);
}
float2 l9_165=l9_162;
float2 l9_166=l9_165;
float2 l9_167=l9_166;
l9_123=l9_167;
float l9_168=l9_123.x;
int l9_169=l9_126.x;
bool l9_170=l9_132;
float l9_171=l9_133;
if ((l9_169==0)||(l9_169==3))
{
float l9_172=l9_168;
float l9_173=0.0;
float l9_174=1.0;
bool l9_175=l9_170;
float l9_176=l9_171;
float l9_177=fast::clamp(l9_172,l9_173,l9_174);
float l9_178=step(abs(l9_172-l9_177),9.9999997e-06);
l9_176*=(l9_178+((1.0-float(l9_175))*(1.0-l9_178)));
l9_172=l9_177;
l9_168=l9_172;
l9_171=l9_176;
}
l9_123.x=l9_168;
l9_133=l9_171;
float l9_179=l9_123.y;
int l9_180=l9_126.y;
bool l9_181=l9_132;
float l9_182=l9_133;
if ((l9_180==0)||(l9_180==3))
{
float l9_183=l9_179;
float l9_184=0.0;
float l9_185=1.0;
bool l9_186=l9_181;
float l9_187=l9_182;
float l9_188=fast::clamp(l9_183,l9_184,l9_185);
float l9_189=step(abs(l9_183-l9_188),9.9999997e-06);
l9_187*=(l9_189+((1.0-float(l9_186))*(1.0-l9_189)));
l9_183=l9_188;
l9_179=l9_183;
l9_182=l9_187;
}
l9_123.y=l9_179;
l9_133=l9_182;
float2 l9_190=l9_123;
int l9_191=l9_121;
int l9_192=l9_122;
float l9_193=l9_131;
float2 l9_194=l9_190;
int l9_195=l9_191;
int l9_196=l9_192;
float3 l9_197=float3(0.0);
if (l9_195==0)
{
l9_197=float3(l9_194,0.0);
}
else
{
if (l9_195==1)
{
l9_197=float3(l9_194.x,(l9_194.y*0.5)+(0.5-(float(l9_196)*0.5)),0.0);
}
else
{
l9_197=float3(l9_194,float(l9_196));
}
}
float3 l9_198=l9_197;
float3 l9_199=l9_198;
float2 l9_200=l9_199.xy;
float l9_201=l9_193;
float4 l9_202=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_200,bias(l9_201));
float4 l9_203=l9_202;
float4 l9_204=l9_203;
if (l9_129)
{
l9_204=mix(l9_130,l9_204,float4(l9_133));
}
float4 l9_205=l9_204;
l9_114=l9_205;
float4 l9_206=l9_114;
float4 l9_207=l9_206;
float2 l9_208=l9_99;
float4 l9_209=float4(0.0);
int l9_210=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_211=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_211=0;
}
else
{
l9_211=in.varStereoViewID;
}
int l9_212=l9_211;
l9_210=1-l9_212;
}
else
{
int l9_213=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_213=0;
}
else
{
l9_213=in.varStereoViewID;
}
int l9_214=l9_213;
l9_210=l9_214;
}
int l9_215=l9_210;
int l9_216=mainTextureLayout_tmp;
int l9_217=l9_215;
float2 l9_218=l9_208;
bool l9_219=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_220=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_221=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_222=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_223=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_224=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_225=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_226=0.0;
bool l9_227=l9_224&&(!l9_222);
float l9_228=1.0;
float l9_229=l9_218.x;
int l9_230=l9_221.x;
if (l9_230==1)
{
l9_229=fract(l9_229);
}
else
{
if (l9_230==2)
{
float l9_231=fract(l9_229);
float l9_232=l9_229-l9_231;
float l9_233=step(0.25,fract(l9_232*0.5));
l9_229=mix(l9_231,1.0-l9_231,fast::clamp(l9_233,0.0,1.0));
}
}
l9_218.x=l9_229;
float l9_234=l9_218.y;
int l9_235=l9_221.y;
if (l9_235==1)
{
l9_234=fract(l9_234);
}
else
{
if (l9_235==2)
{
float l9_236=fract(l9_234);
float l9_237=l9_234-l9_236;
float l9_238=step(0.25,fract(l9_237*0.5));
l9_234=mix(l9_236,1.0-l9_236,fast::clamp(l9_238,0.0,1.0));
}
}
l9_218.y=l9_234;
if (l9_222)
{
bool l9_239=l9_224;
bool l9_240;
if (l9_239)
{
l9_240=l9_221.x==3;
}
else
{
l9_240=l9_239;
}
float l9_241=l9_218.x;
float l9_242=l9_223.x;
float l9_243=l9_223.z;
bool l9_244=l9_240;
float l9_245=l9_228;
float l9_246=fast::clamp(l9_241,l9_242,l9_243);
float l9_247=step(abs(l9_241-l9_246),9.9999997e-06);
l9_245*=(l9_247+((1.0-float(l9_244))*(1.0-l9_247)));
l9_241=l9_246;
l9_218.x=l9_241;
l9_228=l9_245;
bool l9_248=l9_224;
bool l9_249;
if (l9_248)
{
l9_249=l9_221.y==3;
}
else
{
l9_249=l9_248;
}
float l9_250=l9_218.y;
float l9_251=l9_223.y;
float l9_252=l9_223.w;
bool l9_253=l9_249;
float l9_254=l9_228;
float l9_255=fast::clamp(l9_250,l9_251,l9_252);
float l9_256=step(abs(l9_250-l9_255),9.9999997e-06);
l9_254*=(l9_256+((1.0-float(l9_253))*(1.0-l9_256)));
l9_250=l9_255;
l9_218.y=l9_250;
l9_228=l9_254;
}
float2 l9_257=l9_218;
bool l9_258=l9_219;
float3x3 l9_259=l9_220;
if (l9_258)
{
l9_257=float2((l9_259*float3(l9_257,1.0)).xy);
}
float2 l9_260=l9_257;
float2 l9_261=l9_260;
float2 l9_262=l9_261;
l9_218=l9_262;
float l9_263=l9_218.x;
int l9_264=l9_221.x;
bool l9_265=l9_227;
float l9_266=l9_228;
if ((l9_264==0)||(l9_264==3))
{
float l9_267=l9_263;
float l9_268=0.0;
float l9_269=1.0;
bool l9_270=l9_265;
float l9_271=l9_266;
float l9_272=fast::clamp(l9_267,l9_268,l9_269);
float l9_273=step(abs(l9_267-l9_272),9.9999997e-06);
l9_271*=(l9_273+((1.0-float(l9_270))*(1.0-l9_273)));
l9_267=l9_272;
l9_263=l9_267;
l9_266=l9_271;
}
l9_218.x=l9_263;
l9_228=l9_266;
float l9_274=l9_218.y;
int l9_275=l9_221.y;
bool l9_276=l9_227;
float l9_277=l9_228;
if ((l9_275==0)||(l9_275==3))
{
float l9_278=l9_274;
float l9_279=0.0;
float l9_280=1.0;
bool l9_281=l9_276;
float l9_282=l9_277;
float l9_283=fast::clamp(l9_278,l9_279,l9_280);
float l9_284=step(abs(l9_278-l9_283),9.9999997e-06);
l9_282*=(l9_284+((1.0-float(l9_281))*(1.0-l9_284)));
l9_278=l9_283;
l9_274=l9_278;
l9_277=l9_282;
}
l9_218.y=l9_274;
l9_228=l9_277;
float2 l9_285=l9_218;
int l9_286=l9_216;
int l9_287=l9_217;
float l9_288=l9_226;
float2 l9_289=l9_285;
int l9_290=l9_286;
int l9_291=l9_287;
float3 l9_292=float3(0.0);
if (l9_290==0)
{
l9_292=float3(l9_289,0.0);
}
else
{
if (l9_290==1)
{
l9_292=float3(l9_289.x,(l9_289.y*0.5)+(0.5-(float(l9_291)*0.5)),0.0);
}
else
{
l9_292=float3(l9_289,float(l9_291));
}
}
float3 l9_293=l9_292;
float3 l9_294=l9_293;
float2 l9_295=l9_294.xy;
float l9_296=l9_288;
float4 l9_297=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_295,bias(l9_296));
float4 l9_298=l9_297;
float4 l9_299=l9_298;
if (l9_224)
{
l9_299=mix(l9_225,l9_299,float4(l9_228));
}
float4 l9_300=l9_299;
l9_209=l9_300;
float4 l9_301=l9_209;
l9_95=mix(l9_207,l9_301,float4(l9_112));
}
else
{
float2 l9_302=l9_97;
float4 l9_303=float4(0.0);
int l9_304=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
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
int l9_310=mainTextureLayout_tmp;
int l9_311=l9_309;
float2 l9_312=l9_302;
bool l9_313=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_314=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_315=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_316=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_317=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_318=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_319=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_320=0.0;
bool l9_321=l9_318&&(!l9_316);
float l9_322=1.0;
float l9_323=l9_312.x;
int l9_324=l9_315.x;
if (l9_324==1)
{
l9_323=fract(l9_323);
}
else
{
if (l9_324==2)
{
float l9_325=fract(l9_323);
float l9_326=l9_323-l9_325;
float l9_327=step(0.25,fract(l9_326*0.5));
l9_323=mix(l9_325,1.0-l9_325,fast::clamp(l9_327,0.0,1.0));
}
}
l9_312.x=l9_323;
float l9_328=l9_312.y;
int l9_329=l9_315.y;
if (l9_329==1)
{
l9_328=fract(l9_328);
}
else
{
if (l9_329==2)
{
float l9_330=fract(l9_328);
float l9_331=l9_328-l9_330;
float l9_332=step(0.25,fract(l9_331*0.5));
l9_328=mix(l9_330,1.0-l9_330,fast::clamp(l9_332,0.0,1.0));
}
}
l9_312.y=l9_328;
if (l9_316)
{
bool l9_333=l9_318;
bool l9_334;
if (l9_333)
{
l9_334=l9_315.x==3;
}
else
{
l9_334=l9_333;
}
float l9_335=l9_312.x;
float l9_336=l9_317.x;
float l9_337=l9_317.z;
bool l9_338=l9_334;
float l9_339=l9_322;
float l9_340=fast::clamp(l9_335,l9_336,l9_337);
float l9_341=step(abs(l9_335-l9_340),9.9999997e-06);
l9_339*=(l9_341+((1.0-float(l9_338))*(1.0-l9_341)));
l9_335=l9_340;
l9_312.x=l9_335;
l9_322=l9_339;
bool l9_342=l9_318;
bool l9_343;
if (l9_342)
{
l9_343=l9_315.y==3;
}
else
{
l9_343=l9_342;
}
float l9_344=l9_312.y;
float l9_345=l9_317.y;
float l9_346=l9_317.w;
bool l9_347=l9_343;
float l9_348=l9_322;
float l9_349=fast::clamp(l9_344,l9_345,l9_346);
float l9_350=step(abs(l9_344-l9_349),9.9999997e-06);
l9_348*=(l9_350+((1.0-float(l9_347))*(1.0-l9_350)));
l9_344=l9_349;
l9_312.y=l9_344;
l9_322=l9_348;
}
float2 l9_351=l9_312;
bool l9_352=l9_313;
float3x3 l9_353=l9_314;
if (l9_352)
{
l9_351=float2((l9_353*float3(l9_351,1.0)).xy);
}
float2 l9_354=l9_351;
float2 l9_355=l9_354;
float2 l9_356=l9_355;
l9_312=l9_356;
float l9_357=l9_312.x;
int l9_358=l9_315.x;
bool l9_359=l9_321;
float l9_360=l9_322;
if ((l9_358==0)||(l9_358==3))
{
float l9_361=l9_357;
float l9_362=0.0;
float l9_363=1.0;
bool l9_364=l9_359;
float l9_365=l9_360;
float l9_366=fast::clamp(l9_361,l9_362,l9_363);
float l9_367=step(abs(l9_361-l9_366),9.9999997e-06);
l9_365*=(l9_367+((1.0-float(l9_364))*(1.0-l9_367)));
l9_361=l9_366;
l9_357=l9_361;
l9_360=l9_365;
}
l9_312.x=l9_357;
l9_322=l9_360;
float l9_368=l9_312.y;
int l9_369=l9_315.y;
bool l9_370=l9_321;
float l9_371=l9_322;
if ((l9_369==0)||(l9_369==3))
{
float l9_372=l9_368;
float l9_373=0.0;
float l9_374=1.0;
bool l9_375=l9_370;
float l9_376=l9_371;
float l9_377=fast::clamp(l9_372,l9_373,l9_374);
float l9_378=step(abs(l9_372-l9_377),9.9999997e-06);
l9_376*=(l9_378+((1.0-float(l9_375))*(1.0-l9_378)));
l9_372=l9_377;
l9_368=l9_372;
l9_371=l9_376;
}
l9_312.y=l9_368;
l9_322=l9_371;
float2 l9_379=l9_312;
int l9_380=l9_310;
int l9_381=l9_311;
float l9_382=l9_320;
float2 l9_383=l9_379;
int l9_384=l9_380;
int l9_385=l9_381;
float3 l9_386=float3(0.0);
if (l9_384==0)
{
l9_386=float3(l9_383,0.0);
}
else
{
if (l9_384==1)
{
l9_386=float3(l9_383.x,(l9_383.y*0.5)+(0.5-(float(l9_385)*0.5)),0.0);
}
else
{
l9_386=float3(l9_383,float(l9_385));
}
}
float3 l9_387=l9_386;
float3 l9_388=l9_387;
float2 l9_389=l9_388.xy;
float l9_390=l9_382;
float4 l9_391=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_389,bias(l9_390));
float4 l9_392=l9_391;
float4 l9_393=l9_392;
if (l9_318)
{
l9_393=mix(l9_319,l9_393,float4(l9_322));
}
float4 l9_394=l9_393;
l9_303=l9_394;
float4 l9_395=l9_303;
l9_95=l9_395;
}
float4 l9_396=float4(0.0);
float l9_397=ceil(l9_89*N2_texSize.x)/N2_texSize.x;
float l9_398=l9_397;
if (N2_ENABLE_NORANDOFFSET)
{
float2 l9_399=tempGlobals.Surface_UVCoord0;
l9_398+=(l9_399.x/N2_texSize.x);
}
float2 l9_400=float2(l9_398,0.5);
float4 l9_401=float4(0.0);
int l9_402=0;
if ((int(colorRampTextureHasSwappedViews_tmp)!=0))
{
int l9_403=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_403=0;
}
else
{
l9_403=in.varStereoViewID;
}
int l9_404=l9_403;
l9_402=1-l9_404;
}
else
{
int l9_405=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_405=0;
}
else
{
l9_405=in.varStereoViewID;
}
int l9_406=l9_405;
l9_402=l9_406;
}
int l9_407=l9_402;
int l9_408=colorRampTextureLayout_tmp;
int l9_409=l9_407;
float2 l9_410=l9_400;
bool l9_411=(int(SC_USE_UV_TRANSFORM_colorRampTexture_tmp)!=0);
float3x3 l9_412=(*sc_set2.UserUniforms).colorRampTextureTransform;
int2 l9_413=int2(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_colorRampTexture_tmp);
bool l9_414=(int(SC_USE_UV_MIN_MAX_colorRampTexture_tmp)!=0);
float4 l9_415=(*sc_set2.UserUniforms).colorRampTextureUvMinMax;
bool l9_416=(int(SC_USE_CLAMP_TO_BORDER_colorRampTexture_tmp)!=0);
float4 l9_417=(*sc_set2.UserUniforms).colorRampTextureBorderColor;
float l9_418=0.0;
bool l9_419=l9_416&&(!l9_414);
float l9_420=1.0;
float l9_421=l9_410.x;
int l9_422=l9_413.x;
if (l9_422==1)
{
l9_421=fract(l9_421);
}
else
{
if (l9_422==2)
{
float l9_423=fract(l9_421);
float l9_424=l9_421-l9_423;
float l9_425=step(0.25,fract(l9_424*0.5));
l9_421=mix(l9_423,1.0-l9_423,fast::clamp(l9_425,0.0,1.0));
}
}
l9_410.x=l9_421;
float l9_426=l9_410.y;
int l9_427=l9_413.y;
if (l9_427==1)
{
l9_426=fract(l9_426);
}
else
{
if (l9_427==2)
{
float l9_428=fract(l9_426);
float l9_429=l9_426-l9_428;
float l9_430=step(0.25,fract(l9_429*0.5));
l9_426=mix(l9_428,1.0-l9_428,fast::clamp(l9_430,0.0,1.0));
}
}
l9_410.y=l9_426;
if (l9_414)
{
bool l9_431=l9_416;
bool l9_432;
if (l9_431)
{
l9_432=l9_413.x==3;
}
else
{
l9_432=l9_431;
}
float l9_433=l9_410.x;
float l9_434=l9_415.x;
float l9_435=l9_415.z;
bool l9_436=l9_432;
float l9_437=l9_420;
float l9_438=fast::clamp(l9_433,l9_434,l9_435);
float l9_439=step(abs(l9_433-l9_438),9.9999997e-06);
l9_437*=(l9_439+((1.0-float(l9_436))*(1.0-l9_439)));
l9_433=l9_438;
l9_410.x=l9_433;
l9_420=l9_437;
bool l9_440=l9_416;
bool l9_441;
if (l9_440)
{
l9_441=l9_413.y==3;
}
else
{
l9_441=l9_440;
}
float l9_442=l9_410.y;
float l9_443=l9_415.y;
float l9_444=l9_415.w;
bool l9_445=l9_441;
float l9_446=l9_420;
float l9_447=fast::clamp(l9_442,l9_443,l9_444);
float l9_448=step(abs(l9_442-l9_447),9.9999997e-06);
l9_446*=(l9_448+((1.0-float(l9_445))*(1.0-l9_448)));
l9_442=l9_447;
l9_410.y=l9_442;
l9_420=l9_446;
}
float2 l9_449=l9_410;
bool l9_450=l9_411;
float3x3 l9_451=l9_412;
if (l9_450)
{
l9_449=float2((l9_451*float3(l9_449,1.0)).xy);
}
float2 l9_452=l9_449;
float2 l9_453=l9_452;
float2 l9_454=l9_453;
l9_410=l9_454;
float l9_455=l9_410.x;
int l9_456=l9_413.x;
bool l9_457=l9_419;
float l9_458=l9_420;
if ((l9_456==0)||(l9_456==3))
{
float l9_459=l9_455;
float l9_460=0.0;
float l9_461=1.0;
bool l9_462=l9_457;
float l9_463=l9_458;
float l9_464=fast::clamp(l9_459,l9_460,l9_461);
float l9_465=step(abs(l9_459-l9_464),9.9999997e-06);
l9_463*=(l9_465+((1.0-float(l9_462))*(1.0-l9_465)));
l9_459=l9_464;
l9_455=l9_459;
l9_458=l9_463;
}
l9_410.x=l9_455;
l9_420=l9_458;
float l9_466=l9_410.y;
int l9_467=l9_413.y;
bool l9_468=l9_419;
float l9_469=l9_420;
if ((l9_467==0)||(l9_467==3))
{
float l9_470=l9_466;
float l9_471=0.0;
float l9_472=1.0;
bool l9_473=l9_468;
float l9_474=l9_469;
float l9_475=fast::clamp(l9_470,l9_471,l9_472);
float l9_476=step(abs(l9_470-l9_475),9.9999997e-06);
l9_474*=(l9_476+((1.0-float(l9_473))*(1.0-l9_476)));
l9_470=l9_475;
l9_466=l9_470;
l9_469=l9_474;
}
l9_410.y=l9_466;
l9_420=l9_469;
float2 l9_477=l9_410;
int l9_478=l9_408;
int l9_479=l9_409;
float l9_480=l9_418;
float2 l9_481=l9_477;
int l9_482=l9_478;
int l9_483=l9_479;
float3 l9_484=float3(0.0);
if (l9_482==0)
{
l9_484=float3(l9_481,0.0);
}
else
{
if (l9_482==1)
{
l9_484=float3(l9_481.x,(l9_481.y*0.5)+(0.5-(float(l9_483)*0.5)),0.0);
}
else
{
l9_484=float3(l9_481,float(l9_483));
}
}
float3 l9_485=l9_484;
float3 l9_486=l9_485;
float2 l9_487=l9_486.xy;
float l9_488=l9_480;
float4 l9_489=sc_set2.colorRampTexture.sample(sc_set2.colorRampTextureSmpSC,l9_487,bias(l9_488));
float4 l9_490=l9_489;
float4 l9_491=l9_490;
if (l9_416)
{
l9_491=mix(l9_417,l9_491,float4(l9_420));
}
float4 l9_492=l9_491;
l9_401=l9_492;
float4 l9_493=l9_401;
l9_396=l9_493*N2_colorRampMult;
float4 l9_494=float4(1.0);
float4 l9_495=float4(1.0);
if (N2_ENABLE_BASETEXTURE)
{
float2 l9_496=tempGlobals.Surface_UVCoord0;
float2 l9_497=l9_496;
float4 l9_498=float4(0.0);
int l9_499=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_500=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_500=0;
}
else
{
l9_500=in.varStereoViewID;
}
int l9_501=l9_500;
l9_499=1-l9_501;
}
else
{
int l9_502=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_502=0;
}
else
{
l9_502=in.varStereoViewID;
}
int l9_503=l9_502;
l9_499=l9_503;
}
int l9_504=l9_499;
int l9_505=mainTextureLayout_tmp;
int l9_506=l9_504;
float2 l9_507=l9_497;
bool l9_508=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_509=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_510=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_511=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_512=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_513=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_514=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_515=0.0;
bool l9_516=l9_513&&(!l9_511);
float l9_517=1.0;
float l9_518=l9_507.x;
int l9_519=l9_510.x;
if (l9_519==1)
{
l9_518=fract(l9_518);
}
else
{
if (l9_519==2)
{
float l9_520=fract(l9_518);
float l9_521=l9_518-l9_520;
float l9_522=step(0.25,fract(l9_521*0.5));
l9_518=mix(l9_520,1.0-l9_520,fast::clamp(l9_522,0.0,1.0));
}
}
l9_507.x=l9_518;
float l9_523=l9_507.y;
int l9_524=l9_510.y;
if (l9_524==1)
{
l9_523=fract(l9_523);
}
else
{
if (l9_524==2)
{
float l9_525=fract(l9_523);
float l9_526=l9_523-l9_525;
float l9_527=step(0.25,fract(l9_526*0.5));
l9_523=mix(l9_525,1.0-l9_525,fast::clamp(l9_527,0.0,1.0));
}
}
l9_507.y=l9_523;
if (l9_511)
{
bool l9_528=l9_513;
bool l9_529;
if (l9_528)
{
l9_529=l9_510.x==3;
}
else
{
l9_529=l9_528;
}
float l9_530=l9_507.x;
float l9_531=l9_512.x;
float l9_532=l9_512.z;
bool l9_533=l9_529;
float l9_534=l9_517;
float l9_535=fast::clamp(l9_530,l9_531,l9_532);
float l9_536=step(abs(l9_530-l9_535),9.9999997e-06);
l9_534*=(l9_536+((1.0-float(l9_533))*(1.0-l9_536)));
l9_530=l9_535;
l9_507.x=l9_530;
l9_517=l9_534;
bool l9_537=l9_513;
bool l9_538;
if (l9_537)
{
l9_538=l9_510.y==3;
}
else
{
l9_538=l9_537;
}
float l9_539=l9_507.y;
float l9_540=l9_512.y;
float l9_541=l9_512.w;
bool l9_542=l9_538;
float l9_543=l9_517;
float l9_544=fast::clamp(l9_539,l9_540,l9_541);
float l9_545=step(abs(l9_539-l9_544),9.9999997e-06);
l9_543*=(l9_545+((1.0-float(l9_542))*(1.0-l9_545)));
l9_539=l9_544;
l9_507.y=l9_539;
l9_517=l9_543;
}
float2 l9_546=l9_507;
bool l9_547=l9_508;
float3x3 l9_548=l9_509;
if (l9_547)
{
l9_546=float2((l9_548*float3(l9_546,1.0)).xy);
}
float2 l9_549=l9_546;
float2 l9_550=l9_549;
float2 l9_551=l9_550;
l9_507=l9_551;
float l9_552=l9_507.x;
int l9_553=l9_510.x;
bool l9_554=l9_516;
float l9_555=l9_517;
if ((l9_553==0)||(l9_553==3))
{
float l9_556=l9_552;
float l9_557=0.0;
float l9_558=1.0;
bool l9_559=l9_554;
float l9_560=l9_555;
float l9_561=fast::clamp(l9_556,l9_557,l9_558);
float l9_562=step(abs(l9_556-l9_561),9.9999997e-06);
l9_560*=(l9_562+((1.0-float(l9_559))*(1.0-l9_562)));
l9_556=l9_561;
l9_552=l9_556;
l9_555=l9_560;
}
l9_507.x=l9_552;
l9_517=l9_555;
float l9_563=l9_507.y;
int l9_564=l9_510.y;
bool l9_565=l9_516;
float l9_566=l9_517;
if ((l9_564==0)||(l9_564==3))
{
float l9_567=l9_563;
float l9_568=0.0;
float l9_569=1.0;
bool l9_570=l9_565;
float l9_571=l9_566;
float l9_572=fast::clamp(l9_567,l9_568,l9_569);
float l9_573=step(abs(l9_567-l9_572),9.9999997e-06);
l9_571*=(l9_573+((1.0-float(l9_570))*(1.0-l9_573)));
l9_567=l9_572;
l9_563=l9_567;
l9_566=l9_571;
}
l9_507.y=l9_563;
l9_517=l9_566;
float2 l9_574=l9_507;
int l9_575=l9_505;
int l9_576=l9_506;
float l9_577=l9_515;
float2 l9_578=l9_574;
int l9_579=l9_575;
int l9_580=l9_576;
float3 l9_581=float3(0.0);
if (l9_579==0)
{
l9_581=float3(l9_578,0.0);
}
else
{
if (l9_579==1)
{
l9_581=float3(l9_578.x,(l9_578.y*0.5)+(0.5-(float(l9_580)*0.5)),0.0);
}
else
{
l9_581=float3(l9_578,float(l9_580));
}
}
float3 l9_582=l9_581;
float3 l9_583=l9_582;
float2 l9_584=l9_583.xy;
float l9_585=l9_577;
float4 l9_586=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_584,bias(l9_585));
float4 l9_587=l9_586;
float4 l9_588=l9_587;
if (l9_513)
{
l9_588=mix(l9_514,l9_588,float4(l9_517));
}
float4 l9_589=l9_588;
l9_498=l9_589;
float4 l9_590=l9_498;
l9_494=l9_590;
float2 l9_591=tempGlobals.Surface_UVCoord0;
N2_uv=l9_591;
if (N2_ENABLE_FLIPBOOK)
{
l9_494=l9_95;
N2_uv=l9_97;
}
}
if (N2_ENABLE_COLORRAMP)
{
if (!(!(SC_DEVICE_CLASS_tmp>=2)))
{
l9_495=l9_396;
}
}
N2_result=(l9_494*l9_90)*l9_495;
if (N2_ENABLE_SCREENFADE)
{
N2_result.w*=N2_nearCameraFade;
}
if (N2_ENABLE_ALPHADISSOLVE)
{
float l9_592=l9_89*N2_alphaDissolveMult;
N2_result.w=fast::clamp(N2_result.w-l9_592,0.0,1.0);
}
if (N2_ENABLE_BLACKASALPHA)
{
float l9_593=length(N2_result.xyz);
N2_result.w=l9_593;
}
if (N2_ENABLE_PREMULTIPLIEDCOLOR)
{
float3 l9_594=N2_result.xyz*N2_result.w;
N2_result=float4(l9_594.x,l9_594.y,l9_594.z,N2_result.w);
}
l9_69=N2_result;
l9_45=l9_69;
float l9_595=0.0;
l9_595=l9_45.w;
float3 l9_596=float3(0.0);
float3 l9_597=float3(0.0);
float3 l9_598=(*sc_set2.UserUniforms).Port_Default_N167;
ssGlobals l9_599=param;
float3 l9_600;
if ((int(NORMALTEX_tmp)!=0))
{
float3 l9_601=float3(0.0);
float3 l9_602=(*sc_set2.UserUniforms).colorStart;
l9_601=l9_602;
float3 l9_603=float3(0.0);
float3 l9_604=(*sc_set2.UserUniforms).colorEnd;
l9_603=l9_604;
float3 l9_605=float3(0.0);
float3 l9_606=(*sc_set2.UserUniforms).colorMinStart;
l9_605=l9_606;
float3 l9_607=float3(0.0);
float3 l9_608=(*sc_set2.UserUniforms).colorMinEnd;
l9_607=l9_608;
float3 l9_609=float3(0.0);
float3 l9_610=(*sc_set2.UserUniforms).colorMaxStart;
l9_609=l9_610;
float3 l9_611=float3(0.0);
float3 l9_612=(*sc_set2.UserUniforms).colorMaxEnd;
l9_611=l9_612;
float l9_613=0.0;
float l9_614=(*sc_set2.UserUniforms).alphaStart;
l9_613=l9_614;
float l9_615=0.0;
float l9_616=(*sc_set2.UserUniforms).alphaEnd;
l9_615=l9_616;
float l9_617=0.0;
float l9_618=(*sc_set2.UserUniforms).alphaMinStart;
l9_617=l9_618;
float l9_619=0.0;
float l9_620=(*sc_set2.UserUniforms).alphaMinEnd;
l9_619=l9_620;
float l9_621=0.0;
float l9_622=(*sc_set2.UserUniforms).alphaMaxStart;
l9_621=l9_622;
float l9_623=0.0;
float l9_624=(*sc_set2.UserUniforms).alphaMaxEnd;
l9_623=l9_624;
float l9_625=0.0;
float l9_626=(*sc_set2.UserUniforms).alphaDissolveMult;
l9_625=l9_626;
float l9_627=0.0;
l9_627=in.Interpolator0.x;
float l9_628=0.0;
float l9_629=(*sc_set2.UserUniforms).numValidFrames;
l9_628=l9_629;
float2 l9_630=float2(0.0);
float2 l9_631=(*sc_set2.UserUniforms).gridSize;
l9_630=l9_631;
float l9_632=0.0;
float l9_633=(*sc_set2.UserUniforms).flipBookSpeedMult;
l9_632=l9_633;
float l9_634=0.0;
float l9_635=(*sc_set2.UserUniforms).flipBookRandomStart;
l9_634=l9_635;
float2 l9_636=float2(0.0);
float2 l9_637=(*sc_set2.UserUniforms).colorRampTextureSize.xy;
l9_636=l9_637;
float4 l9_638=float4(0.0);
float4 l9_639=(*sc_set2.UserUniforms).colorRampMult;
l9_638=l9_639;
float4 l9_640=float4(0.0);
float4 l9_641;
l9_641.x=in.Interpolator0.y;
l9_641.y=in.Interpolator0.z;
l9_641.z=in.Interpolator0.w;
l9_641.w=in.Interpolator1.x;
l9_640=l9_641;
float l9_642=0.0;
float l9_643=(*sc_set2.UserUniforms).externalSeed;
l9_642=l9_643;
float2 l9_644=float2(0.0);
float3 l9_645=l9_601;
float3 l9_646=l9_603;
float3 l9_647=l9_605;
float3 l9_648=l9_607;
float3 l9_649=l9_609;
float3 l9_650=l9_611;
float l9_651=l9_613;
float l9_652=l9_615;
float l9_653=l9_617;
float l9_654=l9_619;
float l9_655=l9_621;
float l9_656=l9_623;
float l9_657=l9_625;
float l9_658=l9_627;
float l9_659=l9_628;
float2 l9_660=l9_630;
float l9_661=l9_632;
float l9_662=l9_634;
float2 l9_663=l9_636;
float4 l9_664=l9_638;
float4 l9_665=l9_640;
float l9_666=l9_642;
ssGlobals l9_667=l9_599;
tempGlobals=l9_667;
float2 l9_668=float2(0.0);
N2_colorStart=l9_645;
N2_colorEnd=l9_646;
N2_ENABLE_COLORMINMAX=(int(COLORMINMAX_tmp)!=0);
N2_colorMinStart=l9_647;
N2_colorMinEnd=l9_648;
N2_colorMaxStart=l9_649;
N2_colorMaxEnd=l9_650;
N2_ENABLE_COLORMONOMIN=(int(COLORMONOMIN_tmp)!=0);
N2_alphaStart=l9_651;
N2_alphaEnd=l9_652;
N2_ENABLE_ALPHAMINMAX=(int(ALPHAMINMAX_tmp)!=0);
N2_alphaMinStart=l9_653;
N2_alphaMinEnd=l9_654;
N2_alphaMaxStart=l9_655;
N2_alphaMaxEnd=l9_656;
N2_ENABLE_ALPHADISSOLVE=(int(ALPHADISSOLVE_tmp)!=0);
N2_alphaDissolveMult=l9_657;
N2_ENABLE_PREMULTIPLIEDCOLOR=(int(PREMULTIPLIEDCOLOR_tmp)!=0);
N2_ENABLE_BLACKASALPHA=(int(BLACKASALPHA_tmp)!=0);
N2_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N2_nearCameraFade=l9_658;
N2_ENABLE_FLIPBOOK=(int(FLIPBOOK_tmp)!=0);
N2_numValidFrames=l9_659;
N2_gridSize=l9_660;
N2_flipBookSpeedMult=l9_661;
N2_flipBookRandomStart=l9_662;
N2_ENABLE_FLIPBOOKBLEND=(int(FLIPBOOKBLEND_tmp)!=0);
N2_ENABLE_FLIPBOOKBYLIFE=(int(FLIPBOOKBYLIFE_tmp)!=0);
N2_ENABLE_COLORRAMP=(int(COLORRAMP_tmp)!=0);
N2_texSize=l9_663;
N2_colorRampMult=l9_664;
N2_ENABLE_NORANDOFFSET=(int(NORANDOFFSET_tmp)!=0);
N2_ENABLE_BASETEXTURE=(int(BASETEXTURE_tmp)!=0);
N2_timeValuesIn=l9_665;
N2_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N2_externalSeed=l9_666;
float l9_669=0.0;
if (N2_ENABLE_WORLDPOSSEED)
{
float4x4 l9_670=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_669=length(float4(1.0)*l9_670);
}
N2_globalSeed=N2_externalSeed+l9_669;
float l9_671=2000.0;
int l9_672=0;
l9_672=int(tempGlobals.gInstanceID);
int l9_673=l9_672;
float l9_674=float(l9_673);
float2 l9_675=float2(mod(l9_674,l9_671),floor(l9_674/l9_671));
l9_675/=float2(l9_671);
float2 l9_676=l9_675;
float l9_677=dot(l9_676,float2(0.38253,0.42662001));
float3 l9_678=float3(0.457831,0.62343299,0.97625297)*l9_677;
l9_678=sin(l9_678)*float3(479.371,389.53101,513.03497);
l9_678=fract(l9_678);
l9_678=floor(l9_678*10000.0)*9.9999997e-05;
float3 l9_679=l9_678;
float3 l9_680=l9_679;
N2_particleSeed=l9_680;
float l9_681=N2_particleSeed.x;
float l9_682=N2_particleSeed.y;
float l9_683=N2_particleSeed.z;
float3 l9_684=fract((float3(l9_681,l9_682,l9_683)*27.21883)+float3(N2_globalSeed));
if (N2_ENABLE_COLORMONOMIN)
{
l9_684=fract((float3(l9_681,l9_681,l9_681)*27.21883)+float3(N2_globalSeed));
}
float l9_685=fract((N2_particleSeed.x*3121.3333)+N2_globalSeed);
float l9_686=fract((N2_particleSeed.y*13.2234)+N2_globalSeed);
float l9_687=fract((N2_particleSeed.z*3.5358)+N2_globalSeed);
float l9_688=N2_timeValuesIn.w;
float4 l9_689=float4(0.0);
float3 l9_690=float3(0.0);
float3 l9_691=float3(0.0);
float l9_692=0.0;
float l9_693=0.0;
if (N2_ENABLE_COLORMINMAX)
{
l9_690=mix(N2_colorMinStart,N2_colorMaxStart,l9_684);
l9_691=mix(N2_colorMinEnd,N2_colorMaxEnd,l9_684);
}
else
{
l9_690=N2_colorStart;
l9_691=N2_colorEnd;
}
if (N2_ENABLE_ALPHAMINMAX)
{
l9_692=mix(N2_alphaMinStart,N2_alphaMaxStart,l9_685);
l9_693=mix(N2_alphaMinEnd,N2_alphaMaxEnd,l9_685);
}
else
{
l9_692=N2_alphaStart;
l9_693=N2_alphaEnd;
}
l9_690=mix(l9_690,l9_691,float3(l9_688));
l9_692=mix(l9_692,l9_693,l9_688);
l9_689=float4(l9_690,l9_692);
float4 l9_694=float4(0.0);
float2 l9_695=tempGlobals.Surface_UVCoord0;
float2 l9_696=l9_695;
float2 l9_697=tempGlobals.Surface_UVCoord1;
float2 l9_698=l9_697;
float l9_699=fast::max(N2_timeValuesIn.x,0.0099999998);
float l9_700=fast::max(N2_timeValuesIn.y,0.0099999998);
float l9_701=N2_timeValuesIn.z;
if (N2_ENABLE_FLIPBOOKBYLIFE)
{
float l9_702=mix(l9_699,l9_700,l9_687);
l9_701=N2_timeValuesIn.z/l9_702;
}
float l9_703=mix(0.0,N2_flipBookRandomStart,l9_686);
float2 l9_704=l9_696/N2_gridSize;
float l9_705=(l9_701*N2_flipBookSpeedMult)+l9_703;
l9_705=mod(l9_705,N2_numValidFrames);
float l9_706=floor(l9_705)*(1.0/N2_gridSize.x);
float l9_707=mod(floor((-l9_705)/N2_gridSize.x),N2_gridSize.y)*(1.0/N2_gridSize.y);
float l9_708=l9_705+1.0;
l9_708=mod(l9_708,N2_numValidFrames);
float l9_709=floor(l9_708)*(1.0/N2_gridSize.x);
float l9_710=floor((-l9_708)*(1.0/N2_gridSize.x))*(1.0/N2_gridSize.y);
float l9_711=fract(l9_705);
l9_696=l9_704+float2(l9_706,l9_707);
l9_698=l9_704+float2(l9_709,l9_710);
if (N2_ENABLE_FLIPBOOKBLEND)
{
float2 l9_712=l9_696;
float4 l9_713=float4(0.0);
int l9_714=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_715=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_715=0;
}
else
{
l9_715=in.varStereoViewID;
}
int l9_716=l9_715;
l9_714=1-l9_716;
}
else
{
int l9_717=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_717=0;
}
else
{
l9_717=in.varStereoViewID;
}
int l9_718=l9_717;
l9_714=l9_718;
}
int l9_719=l9_714;
int l9_720=mainTextureLayout_tmp;
int l9_721=l9_719;
float2 l9_722=l9_712;
bool l9_723=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_724=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_725=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_726=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_727=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_728=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_729=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_730=0.0;
bool l9_731=l9_728&&(!l9_726);
float l9_732=1.0;
float l9_733=l9_722.x;
int l9_734=l9_725.x;
if (l9_734==1)
{
l9_733=fract(l9_733);
}
else
{
if (l9_734==2)
{
float l9_735=fract(l9_733);
float l9_736=l9_733-l9_735;
float l9_737=step(0.25,fract(l9_736*0.5));
l9_733=mix(l9_735,1.0-l9_735,fast::clamp(l9_737,0.0,1.0));
}
}
l9_722.x=l9_733;
float l9_738=l9_722.y;
int l9_739=l9_725.y;
if (l9_739==1)
{
l9_738=fract(l9_738);
}
else
{
if (l9_739==2)
{
float l9_740=fract(l9_738);
float l9_741=l9_738-l9_740;
float l9_742=step(0.25,fract(l9_741*0.5));
l9_738=mix(l9_740,1.0-l9_740,fast::clamp(l9_742,0.0,1.0));
}
}
l9_722.y=l9_738;
if (l9_726)
{
bool l9_743=l9_728;
bool l9_744;
if (l9_743)
{
l9_744=l9_725.x==3;
}
else
{
l9_744=l9_743;
}
float l9_745=l9_722.x;
float l9_746=l9_727.x;
float l9_747=l9_727.z;
bool l9_748=l9_744;
float l9_749=l9_732;
float l9_750=fast::clamp(l9_745,l9_746,l9_747);
float l9_751=step(abs(l9_745-l9_750),9.9999997e-06);
l9_749*=(l9_751+((1.0-float(l9_748))*(1.0-l9_751)));
l9_745=l9_750;
l9_722.x=l9_745;
l9_732=l9_749;
bool l9_752=l9_728;
bool l9_753;
if (l9_752)
{
l9_753=l9_725.y==3;
}
else
{
l9_753=l9_752;
}
float l9_754=l9_722.y;
float l9_755=l9_727.y;
float l9_756=l9_727.w;
bool l9_757=l9_753;
float l9_758=l9_732;
float l9_759=fast::clamp(l9_754,l9_755,l9_756);
float l9_760=step(abs(l9_754-l9_759),9.9999997e-06);
l9_758*=(l9_760+((1.0-float(l9_757))*(1.0-l9_760)));
l9_754=l9_759;
l9_722.y=l9_754;
l9_732=l9_758;
}
float2 l9_761=l9_722;
bool l9_762=l9_723;
float3x3 l9_763=l9_724;
if (l9_762)
{
l9_761=float2((l9_763*float3(l9_761,1.0)).xy);
}
float2 l9_764=l9_761;
float2 l9_765=l9_764;
float2 l9_766=l9_765;
l9_722=l9_766;
float l9_767=l9_722.x;
int l9_768=l9_725.x;
bool l9_769=l9_731;
float l9_770=l9_732;
if ((l9_768==0)||(l9_768==3))
{
float l9_771=l9_767;
float l9_772=0.0;
float l9_773=1.0;
bool l9_774=l9_769;
float l9_775=l9_770;
float l9_776=fast::clamp(l9_771,l9_772,l9_773);
float l9_777=step(abs(l9_771-l9_776),9.9999997e-06);
l9_775*=(l9_777+((1.0-float(l9_774))*(1.0-l9_777)));
l9_771=l9_776;
l9_767=l9_771;
l9_770=l9_775;
}
l9_722.x=l9_767;
l9_732=l9_770;
float l9_778=l9_722.y;
int l9_779=l9_725.y;
bool l9_780=l9_731;
float l9_781=l9_732;
if ((l9_779==0)||(l9_779==3))
{
float l9_782=l9_778;
float l9_783=0.0;
float l9_784=1.0;
bool l9_785=l9_780;
float l9_786=l9_781;
float l9_787=fast::clamp(l9_782,l9_783,l9_784);
float l9_788=step(abs(l9_782-l9_787),9.9999997e-06);
l9_786*=(l9_788+((1.0-float(l9_785))*(1.0-l9_788)));
l9_782=l9_787;
l9_778=l9_782;
l9_781=l9_786;
}
l9_722.y=l9_778;
l9_732=l9_781;
float2 l9_789=l9_722;
int l9_790=l9_720;
int l9_791=l9_721;
float l9_792=l9_730;
float2 l9_793=l9_789;
int l9_794=l9_790;
int l9_795=l9_791;
float3 l9_796=float3(0.0);
if (l9_794==0)
{
l9_796=float3(l9_793,0.0);
}
else
{
if (l9_794==1)
{
l9_796=float3(l9_793.x,(l9_793.y*0.5)+(0.5-(float(l9_795)*0.5)),0.0);
}
else
{
l9_796=float3(l9_793,float(l9_795));
}
}
float3 l9_797=l9_796;
float3 l9_798=l9_797;
float2 l9_799=l9_798.xy;
float l9_800=l9_792;
float4 l9_801=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_799,bias(l9_800));
float4 l9_802=l9_801;
float4 l9_803=l9_802;
if (l9_728)
{
l9_803=mix(l9_729,l9_803,float4(l9_732));
}
float4 l9_804=l9_803;
l9_713=l9_804;
float4 l9_805=l9_713;
float4 l9_806=l9_805;
float2 l9_807=l9_698;
float4 l9_808=float4(0.0);
int l9_809=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_810=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_810=0;
}
else
{
l9_810=in.varStereoViewID;
}
int l9_811=l9_810;
l9_809=1-l9_811;
}
else
{
int l9_812=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_812=0;
}
else
{
l9_812=in.varStereoViewID;
}
int l9_813=l9_812;
l9_809=l9_813;
}
int l9_814=l9_809;
int l9_815=mainTextureLayout_tmp;
int l9_816=l9_814;
float2 l9_817=l9_807;
bool l9_818=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_819=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_820=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_821=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_822=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_823=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_824=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_825=0.0;
bool l9_826=l9_823&&(!l9_821);
float l9_827=1.0;
float l9_828=l9_817.x;
int l9_829=l9_820.x;
if (l9_829==1)
{
l9_828=fract(l9_828);
}
else
{
if (l9_829==2)
{
float l9_830=fract(l9_828);
float l9_831=l9_828-l9_830;
float l9_832=step(0.25,fract(l9_831*0.5));
l9_828=mix(l9_830,1.0-l9_830,fast::clamp(l9_832,0.0,1.0));
}
}
l9_817.x=l9_828;
float l9_833=l9_817.y;
int l9_834=l9_820.y;
if (l9_834==1)
{
l9_833=fract(l9_833);
}
else
{
if (l9_834==2)
{
float l9_835=fract(l9_833);
float l9_836=l9_833-l9_835;
float l9_837=step(0.25,fract(l9_836*0.5));
l9_833=mix(l9_835,1.0-l9_835,fast::clamp(l9_837,0.0,1.0));
}
}
l9_817.y=l9_833;
if (l9_821)
{
bool l9_838=l9_823;
bool l9_839;
if (l9_838)
{
l9_839=l9_820.x==3;
}
else
{
l9_839=l9_838;
}
float l9_840=l9_817.x;
float l9_841=l9_822.x;
float l9_842=l9_822.z;
bool l9_843=l9_839;
float l9_844=l9_827;
float l9_845=fast::clamp(l9_840,l9_841,l9_842);
float l9_846=step(abs(l9_840-l9_845),9.9999997e-06);
l9_844*=(l9_846+((1.0-float(l9_843))*(1.0-l9_846)));
l9_840=l9_845;
l9_817.x=l9_840;
l9_827=l9_844;
bool l9_847=l9_823;
bool l9_848;
if (l9_847)
{
l9_848=l9_820.y==3;
}
else
{
l9_848=l9_847;
}
float l9_849=l9_817.y;
float l9_850=l9_822.y;
float l9_851=l9_822.w;
bool l9_852=l9_848;
float l9_853=l9_827;
float l9_854=fast::clamp(l9_849,l9_850,l9_851);
float l9_855=step(abs(l9_849-l9_854),9.9999997e-06);
l9_853*=(l9_855+((1.0-float(l9_852))*(1.0-l9_855)));
l9_849=l9_854;
l9_817.y=l9_849;
l9_827=l9_853;
}
float2 l9_856=l9_817;
bool l9_857=l9_818;
float3x3 l9_858=l9_819;
if (l9_857)
{
l9_856=float2((l9_858*float3(l9_856,1.0)).xy);
}
float2 l9_859=l9_856;
float2 l9_860=l9_859;
float2 l9_861=l9_860;
l9_817=l9_861;
float l9_862=l9_817.x;
int l9_863=l9_820.x;
bool l9_864=l9_826;
float l9_865=l9_827;
if ((l9_863==0)||(l9_863==3))
{
float l9_866=l9_862;
float l9_867=0.0;
float l9_868=1.0;
bool l9_869=l9_864;
float l9_870=l9_865;
float l9_871=fast::clamp(l9_866,l9_867,l9_868);
float l9_872=step(abs(l9_866-l9_871),9.9999997e-06);
l9_870*=(l9_872+((1.0-float(l9_869))*(1.0-l9_872)));
l9_866=l9_871;
l9_862=l9_866;
l9_865=l9_870;
}
l9_817.x=l9_862;
l9_827=l9_865;
float l9_873=l9_817.y;
int l9_874=l9_820.y;
bool l9_875=l9_826;
float l9_876=l9_827;
if ((l9_874==0)||(l9_874==3))
{
float l9_877=l9_873;
float l9_878=0.0;
float l9_879=1.0;
bool l9_880=l9_875;
float l9_881=l9_876;
float l9_882=fast::clamp(l9_877,l9_878,l9_879);
float l9_883=step(abs(l9_877-l9_882),9.9999997e-06);
l9_881*=(l9_883+((1.0-float(l9_880))*(1.0-l9_883)));
l9_877=l9_882;
l9_873=l9_877;
l9_876=l9_881;
}
l9_817.y=l9_873;
l9_827=l9_876;
float2 l9_884=l9_817;
int l9_885=l9_815;
int l9_886=l9_816;
float l9_887=l9_825;
float2 l9_888=l9_884;
int l9_889=l9_885;
int l9_890=l9_886;
float3 l9_891=float3(0.0);
if (l9_889==0)
{
l9_891=float3(l9_888,0.0);
}
else
{
if (l9_889==1)
{
l9_891=float3(l9_888.x,(l9_888.y*0.5)+(0.5-(float(l9_890)*0.5)),0.0);
}
else
{
l9_891=float3(l9_888,float(l9_890));
}
}
float3 l9_892=l9_891;
float3 l9_893=l9_892;
float2 l9_894=l9_893.xy;
float l9_895=l9_887;
float4 l9_896=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_894,bias(l9_895));
float4 l9_897=l9_896;
float4 l9_898=l9_897;
if (l9_823)
{
l9_898=mix(l9_824,l9_898,float4(l9_827));
}
float4 l9_899=l9_898;
l9_808=l9_899;
float4 l9_900=l9_808;
l9_694=mix(l9_806,l9_900,float4(l9_711));
}
else
{
float2 l9_901=l9_696;
float4 l9_902=float4(0.0);
int l9_903=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_904=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_904=0;
}
else
{
l9_904=in.varStereoViewID;
}
int l9_905=l9_904;
l9_903=1-l9_905;
}
else
{
int l9_906=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_906=0;
}
else
{
l9_906=in.varStereoViewID;
}
int l9_907=l9_906;
l9_903=l9_907;
}
int l9_908=l9_903;
int l9_909=mainTextureLayout_tmp;
int l9_910=l9_908;
float2 l9_911=l9_901;
bool l9_912=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_913=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_914=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_915=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_916=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_917=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_918=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_919=0.0;
bool l9_920=l9_917&&(!l9_915);
float l9_921=1.0;
float l9_922=l9_911.x;
int l9_923=l9_914.x;
if (l9_923==1)
{
l9_922=fract(l9_922);
}
else
{
if (l9_923==2)
{
float l9_924=fract(l9_922);
float l9_925=l9_922-l9_924;
float l9_926=step(0.25,fract(l9_925*0.5));
l9_922=mix(l9_924,1.0-l9_924,fast::clamp(l9_926,0.0,1.0));
}
}
l9_911.x=l9_922;
float l9_927=l9_911.y;
int l9_928=l9_914.y;
if (l9_928==1)
{
l9_927=fract(l9_927);
}
else
{
if (l9_928==2)
{
float l9_929=fract(l9_927);
float l9_930=l9_927-l9_929;
float l9_931=step(0.25,fract(l9_930*0.5));
l9_927=mix(l9_929,1.0-l9_929,fast::clamp(l9_931,0.0,1.0));
}
}
l9_911.y=l9_927;
if (l9_915)
{
bool l9_932=l9_917;
bool l9_933;
if (l9_932)
{
l9_933=l9_914.x==3;
}
else
{
l9_933=l9_932;
}
float l9_934=l9_911.x;
float l9_935=l9_916.x;
float l9_936=l9_916.z;
bool l9_937=l9_933;
float l9_938=l9_921;
float l9_939=fast::clamp(l9_934,l9_935,l9_936);
float l9_940=step(abs(l9_934-l9_939),9.9999997e-06);
l9_938*=(l9_940+((1.0-float(l9_937))*(1.0-l9_940)));
l9_934=l9_939;
l9_911.x=l9_934;
l9_921=l9_938;
bool l9_941=l9_917;
bool l9_942;
if (l9_941)
{
l9_942=l9_914.y==3;
}
else
{
l9_942=l9_941;
}
float l9_943=l9_911.y;
float l9_944=l9_916.y;
float l9_945=l9_916.w;
bool l9_946=l9_942;
float l9_947=l9_921;
float l9_948=fast::clamp(l9_943,l9_944,l9_945);
float l9_949=step(abs(l9_943-l9_948),9.9999997e-06);
l9_947*=(l9_949+((1.0-float(l9_946))*(1.0-l9_949)));
l9_943=l9_948;
l9_911.y=l9_943;
l9_921=l9_947;
}
float2 l9_950=l9_911;
bool l9_951=l9_912;
float3x3 l9_952=l9_913;
if (l9_951)
{
l9_950=float2((l9_952*float3(l9_950,1.0)).xy);
}
float2 l9_953=l9_950;
float2 l9_954=l9_953;
float2 l9_955=l9_954;
l9_911=l9_955;
float l9_956=l9_911.x;
int l9_957=l9_914.x;
bool l9_958=l9_920;
float l9_959=l9_921;
if ((l9_957==0)||(l9_957==3))
{
float l9_960=l9_956;
float l9_961=0.0;
float l9_962=1.0;
bool l9_963=l9_958;
float l9_964=l9_959;
float l9_965=fast::clamp(l9_960,l9_961,l9_962);
float l9_966=step(abs(l9_960-l9_965),9.9999997e-06);
l9_964*=(l9_966+((1.0-float(l9_963))*(1.0-l9_966)));
l9_960=l9_965;
l9_956=l9_960;
l9_959=l9_964;
}
l9_911.x=l9_956;
l9_921=l9_959;
float l9_967=l9_911.y;
int l9_968=l9_914.y;
bool l9_969=l9_920;
float l9_970=l9_921;
if ((l9_968==0)||(l9_968==3))
{
float l9_971=l9_967;
float l9_972=0.0;
float l9_973=1.0;
bool l9_974=l9_969;
float l9_975=l9_970;
float l9_976=fast::clamp(l9_971,l9_972,l9_973);
float l9_977=step(abs(l9_971-l9_976),9.9999997e-06);
l9_975*=(l9_977+((1.0-float(l9_974))*(1.0-l9_977)));
l9_971=l9_976;
l9_967=l9_971;
l9_970=l9_975;
}
l9_911.y=l9_967;
l9_921=l9_970;
float2 l9_978=l9_911;
int l9_979=l9_909;
int l9_980=l9_910;
float l9_981=l9_919;
float2 l9_982=l9_978;
int l9_983=l9_979;
int l9_984=l9_980;
float3 l9_985=float3(0.0);
if (l9_983==0)
{
l9_985=float3(l9_982,0.0);
}
else
{
if (l9_983==1)
{
l9_985=float3(l9_982.x,(l9_982.y*0.5)+(0.5-(float(l9_984)*0.5)),0.0);
}
else
{
l9_985=float3(l9_982,float(l9_984));
}
}
float3 l9_986=l9_985;
float3 l9_987=l9_986;
float2 l9_988=l9_987.xy;
float l9_989=l9_981;
float4 l9_990=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_988,bias(l9_989));
float4 l9_991=l9_990;
float4 l9_992=l9_991;
if (l9_917)
{
l9_992=mix(l9_918,l9_992,float4(l9_921));
}
float4 l9_993=l9_992;
l9_902=l9_993;
float4 l9_994=l9_902;
l9_694=l9_994;
}
float4 l9_995=float4(0.0);
float l9_996=ceil(l9_688*N2_texSize.x)/N2_texSize.x;
float l9_997=l9_996;
if (N2_ENABLE_NORANDOFFSET)
{
float2 l9_998=tempGlobals.Surface_UVCoord0;
l9_997+=(l9_998.x/N2_texSize.x);
}
float2 l9_999=float2(l9_997,0.5);
float4 l9_1000=float4(0.0);
int l9_1001=0;
if ((int(colorRampTextureHasSwappedViews_tmp)!=0))
{
int l9_1002=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1002=0;
}
else
{
l9_1002=in.varStereoViewID;
}
int l9_1003=l9_1002;
l9_1001=1-l9_1003;
}
else
{
int l9_1004=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1004=0;
}
else
{
l9_1004=in.varStereoViewID;
}
int l9_1005=l9_1004;
l9_1001=l9_1005;
}
int l9_1006=l9_1001;
int l9_1007=colorRampTextureLayout_tmp;
int l9_1008=l9_1006;
float2 l9_1009=l9_999;
bool l9_1010=(int(SC_USE_UV_TRANSFORM_colorRampTexture_tmp)!=0);
float3x3 l9_1011=(*sc_set2.UserUniforms).colorRampTextureTransform;
int2 l9_1012=int2(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_colorRampTexture_tmp);
bool l9_1013=(int(SC_USE_UV_MIN_MAX_colorRampTexture_tmp)!=0);
float4 l9_1014=(*sc_set2.UserUniforms).colorRampTextureUvMinMax;
bool l9_1015=(int(SC_USE_CLAMP_TO_BORDER_colorRampTexture_tmp)!=0);
float4 l9_1016=(*sc_set2.UserUniforms).colorRampTextureBorderColor;
float l9_1017=0.0;
bool l9_1018=l9_1015&&(!l9_1013);
float l9_1019=1.0;
float l9_1020=l9_1009.x;
int l9_1021=l9_1012.x;
if (l9_1021==1)
{
l9_1020=fract(l9_1020);
}
else
{
if (l9_1021==2)
{
float l9_1022=fract(l9_1020);
float l9_1023=l9_1020-l9_1022;
float l9_1024=step(0.25,fract(l9_1023*0.5));
l9_1020=mix(l9_1022,1.0-l9_1022,fast::clamp(l9_1024,0.0,1.0));
}
}
l9_1009.x=l9_1020;
float l9_1025=l9_1009.y;
int l9_1026=l9_1012.y;
if (l9_1026==1)
{
l9_1025=fract(l9_1025);
}
else
{
if (l9_1026==2)
{
float l9_1027=fract(l9_1025);
float l9_1028=l9_1025-l9_1027;
float l9_1029=step(0.25,fract(l9_1028*0.5));
l9_1025=mix(l9_1027,1.0-l9_1027,fast::clamp(l9_1029,0.0,1.0));
}
}
l9_1009.y=l9_1025;
if (l9_1013)
{
bool l9_1030=l9_1015;
bool l9_1031;
if (l9_1030)
{
l9_1031=l9_1012.x==3;
}
else
{
l9_1031=l9_1030;
}
float l9_1032=l9_1009.x;
float l9_1033=l9_1014.x;
float l9_1034=l9_1014.z;
bool l9_1035=l9_1031;
float l9_1036=l9_1019;
float l9_1037=fast::clamp(l9_1032,l9_1033,l9_1034);
float l9_1038=step(abs(l9_1032-l9_1037),9.9999997e-06);
l9_1036*=(l9_1038+((1.0-float(l9_1035))*(1.0-l9_1038)));
l9_1032=l9_1037;
l9_1009.x=l9_1032;
l9_1019=l9_1036;
bool l9_1039=l9_1015;
bool l9_1040;
if (l9_1039)
{
l9_1040=l9_1012.y==3;
}
else
{
l9_1040=l9_1039;
}
float l9_1041=l9_1009.y;
float l9_1042=l9_1014.y;
float l9_1043=l9_1014.w;
bool l9_1044=l9_1040;
float l9_1045=l9_1019;
float l9_1046=fast::clamp(l9_1041,l9_1042,l9_1043);
float l9_1047=step(abs(l9_1041-l9_1046),9.9999997e-06);
l9_1045*=(l9_1047+((1.0-float(l9_1044))*(1.0-l9_1047)));
l9_1041=l9_1046;
l9_1009.y=l9_1041;
l9_1019=l9_1045;
}
float2 l9_1048=l9_1009;
bool l9_1049=l9_1010;
float3x3 l9_1050=l9_1011;
if (l9_1049)
{
l9_1048=float2((l9_1050*float3(l9_1048,1.0)).xy);
}
float2 l9_1051=l9_1048;
float2 l9_1052=l9_1051;
float2 l9_1053=l9_1052;
l9_1009=l9_1053;
float l9_1054=l9_1009.x;
int l9_1055=l9_1012.x;
bool l9_1056=l9_1018;
float l9_1057=l9_1019;
if ((l9_1055==0)||(l9_1055==3))
{
float l9_1058=l9_1054;
float l9_1059=0.0;
float l9_1060=1.0;
bool l9_1061=l9_1056;
float l9_1062=l9_1057;
float l9_1063=fast::clamp(l9_1058,l9_1059,l9_1060);
float l9_1064=step(abs(l9_1058-l9_1063),9.9999997e-06);
l9_1062*=(l9_1064+((1.0-float(l9_1061))*(1.0-l9_1064)));
l9_1058=l9_1063;
l9_1054=l9_1058;
l9_1057=l9_1062;
}
l9_1009.x=l9_1054;
l9_1019=l9_1057;
float l9_1065=l9_1009.y;
int l9_1066=l9_1012.y;
bool l9_1067=l9_1018;
float l9_1068=l9_1019;
if ((l9_1066==0)||(l9_1066==3))
{
float l9_1069=l9_1065;
float l9_1070=0.0;
float l9_1071=1.0;
bool l9_1072=l9_1067;
float l9_1073=l9_1068;
float l9_1074=fast::clamp(l9_1069,l9_1070,l9_1071);
float l9_1075=step(abs(l9_1069-l9_1074),9.9999997e-06);
l9_1073*=(l9_1075+((1.0-float(l9_1072))*(1.0-l9_1075)));
l9_1069=l9_1074;
l9_1065=l9_1069;
l9_1068=l9_1073;
}
l9_1009.y=l9_1065;
l9_1019=l9_1068;
float2 l9_1076=l9_1009;
int l9_1077=l9_1007;
int l9_1078=l9_1008;
float l9_1079=l9_1017;
float2 l9_1080=l9_1076;
int l9_1081=l9_1077;
int l9_1082=l9_1078;
float3 l9_1083=float3(0.0);
if (l9_1081==0)
{
l9_1083=float3(l9_1080,0.0);
}
else
{
if (l9_1081==1)
{
l9_1083=float3(l9_1080.x,(l9_1080.y*0.5)+(0.5-(float(l9_1082)*0.5)),0.0);
}
else
{
l9_1083=float3(l9_1080,float(l9_1082));
}
}
float3 l9_1084=l9_1083;
float3 l9_1085=l9_1084;
float2 l9_1086=l9_1085.xy;
float l9_1087=l9_1079;
float4 l9_1088=sc_set2.colorRampTexture.sample(sc_set2.colorRampTextureSmpSC,l9_1086,bias(l9_1087));
float4 l9_1089=l9_1088;
float4 l9_1090=l9_1089;
if (l9_1015)
{
l9_1090=mix(l9_1016,l9_1090,float4(l9_1019));
}
float4 l9_1091=l9_1090;
l9_1000=l9_1091;
float4 l9_1092=l9_1000;
l9_995=l9_1092*N2_colorRampMult;
float4 l9_1093=float4(1.0);
float4 l9_1094=float4(1.0);
if (N2_ENABLE_BASETEXTURE)
{
float2 l9_1095=tempGlobals.Surface_UVCoord0;
float2 l9_1096=l9_1095;
float4 l9_1097=float4(0.0);
int l9_1098=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_1099=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1099=0;
}
else
{
l9_1099=in.varStereoViewID;
}
int l9_1100=l9_1099;
l9_1098=1-l9_1100;
}
else
{
int l9_1101=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1101=0;
}
else
{
l9_1101=in.varStereoViewID;
}
int l9_1102=l9_1101;
l9_1098=l9_1102;
}
int l9_1103=l9_1098;
int l9_1104=mainTextureLayout_tmp;
int l9_1105=l9_1103;
float2 l9_1106=l9_1096;
bool l9_1107=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_1108=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_1109=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_1110=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_1111=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_1112=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_1113=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_1114=0.0;
bool l9_1115=l9_1112&&(!l9_1110);
float l9_1116=1.0;
float l9_1117=l9_1106.x;
int l9_1118=l9_1109.x;
if (l9_1118==1)
{
l9_1117=fract(l9_1117);
}
else
{
if (l9_1118==2)
{
float l9_1119=fract(l9_1117);
float l9_1120=l9_1117-l9_1119;
float l9_1121=step(0.25,fract(l9_1120*0.5));
l9_1117=mix(l9_1119,1.0-l9_1119,fast::clamp(l9_1121,0.0,1.0));
}
}
l9_1106.x=l9_1117;
float l9_1122=l9_1106.y;
int l9_1123=l9_1109.y;
if (l9_1123==1)
{
l9_1122=fract(l9_1122);
}
else
{
if (l9_1123==2)
{
float l9_1124=fract(l9_1122);
float l9_1125=l9_1122-l9_1124;
float l9_1126=step(0.25,fract(l9_1125*0.5));
l9_1122=mix(l9_1124,1.0-l9_1124,fast::clamp(l9_1126,0.0,1.0));
}
}
l9_1106.y=l9_1122;
if (l9_1110)
{
bool l9_1127=l9_1112;
bool l9_1128;
if (l9_1127)
{
l9_1128=l9_1109.x==3;
}
else
{
l9_1128=l9_1127;
}
float l9_1129=l9_1106.x;
float l9_1130=l9_1111.x;
float l9_1131=l9_1111.z;
bool l9_1132=l9_1128;
float l9_1133=l9_1116;
float l9_1134=fast::clamp(l9_1129,l9_1130,l9_1131);
float l9_1135=step(abs(l9_1129-l9_1134),9.9999997e-06);
l9_1133*=(l9_1135+((1.0-float(l9_1132))*(1.0-l9_1135)));
l9_1129=l9_1134;
l9_1106.x=l9_1129;
l9_1116=l9_1133;
bool l9_1136=l9_1112;
bool l9_1137;
if (l9_1136)
{
l9_1137=l9_1109.y==3;
}
else
{
l9_1137=l9_1136;
}
float l9_1138=l9_1106.y;
float l9_1139=l9_1111.y;
float l9_1140=l9_1111.w;
bool l9_1141=l9_1137;
float l9_1142=l9_1116;
float l9_1143=fast::clamp(l9_1138,l9_1139,l9_1140);
float l9_1144=step(abs(l9_1138-l9_1143),9.9999997e-06);
l9_1142*=(l9_1144+((1.0-float(l9_1141))*(1.0-l9_1144)));
l9_1138=l9_1143;
l9_1106.y=l9_1138;
l9_1116=l9_1142;
}
float2 l9_1145=l9_1106;
bool l9_1146=l9_1107;
float3x3 l9_1147=l9_1108;
if (l9_1146)
{
l9_1145=float2((l9_1147*float3(l9_1145,1.0)).xy);
}
float2 l9_1148=l9_1145;
float2 l9_1149=l9_1148;
float2 l9_1150=l9_1149;
l9_1106=l9_1150;
float l9_1151=l9_1106.x;
int l9_1152=l9_1109.x;
bool l9_1153=l9_1115;
float l9_1154=l9_1116;
if ((l9_1152==0)||(l9_1152==3))
{
float l9_1155=l9_1151;
float l9_1156=0.0;
float l9_1157=1.0;
bool l9_1158=l9_1153;
float l9_1159=l9_1154;
float l9_1160=fast::clamp(l9_1155,l9_1156,l9_1157);
float l9_1161=step(abs(l9_1155-l9_1160),9.9999997e-06);
l9_1159*=(l9_1161+((1.0-float(l9_1158))*(1.0-l9_1161)));
l9_1155=l9_1160;
l9_1151=l9_1155;
l9_1154=l9_1159;
}
l9_1106.x=l9_1151;
l9_1116=l9_1154;
float l9_1162=l9_1106.y;
int l9_1163=l9_1109.y;
bool l9_1164=l9_1115;
float l9_1165=l9_1116;
if ((l9_1163==0)||(l9_1163==3))
{
float l9_1166=l9_1162;
float l9_1167=0.0;
float l9_1168=1.0;
bool l9_1169=l9_1164;
float l9_1170=l9_1165;
float l9_1171=fast::clamp(l9_1166,l9_1167,l9_1168);
float l9_1172=step(abs(l9_1166-l9_1171),9.9999997e-06);
l9_1170*=(l9_1172+((1.0-float(l9_1169))*(1.0-l9_1172)));
l9_1166=l9_1171;
l9_1162=l9_1166;
l9_1165=l9_1170;
}
l9_1106.y=l9_1162;
l9_1116=l9_1165;
float2 l9_1173=l9_1106;
int l9_1174=l9_1104;
int l9_1175=l9_1105;
float l9_1176=l9_1114;
float2 l9_1177=l9_1173;
int l9_1178=l9_1174;
int l9_1179=l9_1175;
float3 l9_1180=float3(0.0);
if (l9_1178==0)
{
l9_1180=float3(l9_1177,0.0);
}
else
{
if (l9_1178==1)
{
l9_1180=float3(l9_1177.x,(l9_1177.y*0.5)+(0.5-(float(l9_1179)*0.5)),0.0);
}
else
{
l9_1180=float3(l9_1177,float(l9_1179));
}
}
float3 l9_1181=l9_1180;
float3 l9_1182=l9_1181;
float2 l9_1183=l9_1182.xy;
float l9_1184=l9_1176;
float4 l9_1185=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_1183,bias(l9_1184));
float4 l9_1186=l9_1185;
float4 l9_1187=l9_1186;
if (l9_1112)
{
l9_1187=mix(l9_1113,l9_1187,float4(l9_1116));
}
float4 l9_1188=l9_1187;
l9_1097=l9_1188;
float4 l9_1189=l9_1097;
l9_1093=l9_1189;
float2 l9_1190=tempGlobals.Surface_UVCoord0;
N2_uv=l9_1190;
if (N2_ENABLE_FLIPBOOK)
{
l9_1093=l9_694;
N2_uv=l9_696;
}
}
if (N2_ENABLE_COLORRAMP)
{
if (!(!(SC_DEVICE_CLASS_tmp>=2)))
{
l9_1094=l9_995;
}
}
N2_result=(l9_1093*l9_689)*l9_1094;
if (N2_ENABLE_SCREENFADE)
{
N2_result.w*=N2_nearCameraFade;
}
if (N2_ENABLE_ALPHADISSOLVE)
{
float l9_1191=l9_688*N2_alphaDissolveMult;
N2_result.w=fast::clamp(N2_result.w-l9_1191,0.0,1.0);
}
if (N2_ENABLE_BLACKASALPHA)
{
float l9_1192=length(N2_result.xyz);
N2_result.w=l9_1192;
}
if (N2_ENABLE_PREMULTIPLIEDCOLOR)
{
float3 l9_1193=N2_result.xyz*N2_result.w;
N2_result=float4(l9_1193.x,l9_1193.y,l9_1193.z,N2_result.w);
}
l9_668=N2_uv;
l9_644=l9_668;
float4 l9_1194=float4(0.0);
float2 l9_1195=l9_644;
int l9_1196=0;
if ((int(normalTexHasSwappedViews_tmp)!=0))
{
int l9_1197=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1197=0;
}
else
{
l9_1197=in.varStereoViewID;
}
int l9_1198=l9_1197;
l9_1196=1-l9_1198;
}
else
{
int l9_1199=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1199=0;
}
else
{
l9_1199=in.varStereoViewID;
}
int l9_1200=l9_1199;
l9_1196=l9_1200;
}
int l9_1201=l9_1196;
int l9_1202=normalTexLayout_tmp;
int l9_1203=l9_1201;
float2 l9_1204=l9_1195;
bool l9_1205=(int(SC_USE_UV_TRANSFORM_normalTex_tmp)!=0);
float3x3 l9_1206=(*sc_set2.UserUniforms).normalTexTransform;
int2 l9_1207=int2(SC_SOFTWARE_WRAP_MODE_U_normalTex_tmp,SC_SOFTWARE_WRAP_MODE_V_normalTex_tmp);
bool l9_1208=(int(SC_USE_UV_MIN_MAX_normalTex_tmp)!=0);
float4 l9_1209=(*sc_set2.UserUniforms).normalTexUvMinMax;
bool l9_1210=(int(SC_USE_CLAMP_TO_BORDER_normalTex_tmp)!=0);
float4 l9_1211=(*sc_set2.UserUniforms).normalTexBorderColor;
float l9_1212=0.0;
bool l9_1213=l9_1210&&(!l9_1208);
float l9_1214=1.0;
float l9_1215=l9_1204.x;
int l9_1216=l9_1207.x;
if (l9_1216==1)
{
l9_1215=fract(l9_1215);
}
else
{
if (l9_1216==2)
{
float l9_1217=fract(l9_1215);
float l9_1218=l9_1215-l9_1217;
float l9_1219=step(0.25,fract(l9_1218*0.5));
l9_1215=mix(l9_1217,1.0-l9_1217,fast::clamp(l9_1219,0.0,1.0));
}
}
l9_1204.x=l9_1215;
float l9_1220=l9_1204.y;
int l9_1221=l9_1207.y;
if (l9_1221==1)
{
l9_1220=fract(l9_1220);
}
else
{
if (l9_1221==2)
{
float l9_1222=fract(l9_1220);
float l9_1223=l9_1220-l9_1222;
float l9_1224=step(0.25,fract(l9_1223*0.5));
l9_1220=mix(l9_1222,1.0-l9_1222,fast::clamp(l9_1224,0.0,1.0));
}
}
l9_1204.y=l9_1220;
if (l9_1208)
{
bool l9_1225=l9_1210;
bool l9_1226;
if (l9_1225)
{
l9_1226=l9_1207.x==3;
}
else
{
l9_1226=l9_1225;
}
float l9_1227=l9_1204.x;
float l9_1228=l9_1209.x;
float l9_1229=l9_1209.z;
bool l9_1230=l9_1226;
float l9_1231=l9_1214;
float l9_1232=fast::clamp(l9_1227,l9_1228,l9_1229);
float l9_1233=step(abs(l9_1227-l9_1232),9.9999997e-06);
l9_1231*=(l9_1233+((1.0-float(l9_1230))*(1.0-l9_1233)));
l9_1227=l9_1232;
l9_1204.x=l9_1227;
l9_1214=l9_1231;
bool l9_1234=l9_1210;
bool l9_1235;
if (l9_1234)
{
l9_1235=l9_1207.y==3;
}
else
{
l9_1235=l9_1234;
}
float l9_1236=l9_1204.y;
float l9_1237=l9_1209.y;
float l9_1238=l9_1209.w;
bool l9_1239=l9_1235;
float l9_1240=l9_1214;
float l9_1241=fast::clamp(l9_1236,l9_1237,l9_1238);
float l9_1242=step(abs(l9_1236-l9_1241),9.9999997e-06);
l9_1240*=(l9_1242+((1.0-float(l9_1239))*(1.0-l9_1242)));
l9_1236=l9_1241;
l9_1204.y=l9_1236;
l9_1214=l9_1240;
}
float2 l9_1243=l9_1204;
bool l9_1244=l9_1205;
float3x3 l9_1245=l9_1206;
if (l9_1244)
{
l9_1243=float2((l9_1245*float3(l9_1243,1.0)).xy);
}
float2 l9_1246=l9_1243;
float2 l9_1247=l9_1246;
float2 l9_1248=l9_1247;
l9_1204=l9_1248;
float l9_1249=l9_1204.x;
int l9_1250=l9_1207.x;
bool l9_1251=l9_1213;
float l9_1252=l9_1214;
if ((l9_1250==0)||(l9_1250==3))
{
float l9_1253=l9_1249;
float l9_1254=0.0;
float l9_1255=1.0;
bool l9_1256=l9_1251;
float l9_1257=l9_1252;
float l9_1258=fast::clamp(l9_1253,l9_1254,l9_1255);
float l9_1259=step(abs(l9_1253-l9_1258),9.9999997e-06);
l9_1257*=(l9_1259+((1.0-float(l9_1256))*(1.0-l9_1259)));
l9_1253=l9_1258;
l9_1249=l9_1253;
l9_1252=l9_1257;
}
l9_1204.x=l9_1249;
l9_1214=l9_1252;
float l9_1260=l9_1204.y;
int l9_1261=l9_1207.y;
bool l9_1262=l9_1213;
float l9_1263=l9_1214;
if ((l9_1261==0)||(l9_1261==3))
{
float l9_1264=l9_1260;
float l9_1265=0.0;
float l9_1266=1.0;
bool l9_1267=l9_1262;
float l9_1268=l9_1263;
float l9_1269=fast::clamp(l9_1264,l9_1265,l9_1266);
float l9_1270=step(abs(l9_1264-l9_1269),9.9999997e-06);
l9_1268*=(l9_1270+((1.0-float(l9_1267))*(1.0-l9_1270)));
l9_1264=l9_1269;
l9_1260=l9_1264;
l9_1263=l9_1268;
}
l9_1204.y=l9_1260;
l9_1214=l9_1263;
float2 l9_1271=l9_1204;
int l9_1272=l9_1202;
int l9_1273=l9_1203;
float l9_1274=l9_1212;
float2 l9_1275=l9_1271;
int l9_1276=l9_1272;
int l9_1277=l9_1273;
float3 l9_1278=float3(0.0);
if (l9_1276==0)
{
l9_1278=float3(l9_1275,0.0);
}
else
{
if (l9_1276==1)
{
l9_1278=float3(l9_1275.x,(l9_1275.y*0.5)+(0.5-(float(l9_1277)*0.5)),0.0);
}
else
{
l9_1278=float3(l9_1275,float(l9_1277));
}
}
float3 l9_1279=l9_1278;
float3 l9_1280=l9_1279;
float2 l9_1281=l9_1280.xy;
float l9_1282=l9_1274;
float4 l9_1283=sc_set2.normalTex.sample(sc_set2.normalTexSmpSC,l9_1281,bias(l9_1282));
float4 l9_1284=l9_1283;
float4 l9_1285=l9_1284;
if (l9_1210)
{
l9_1285=mix(l9_1211,l9_1285,float4(l9_1214));
}
float4 l9_1286=l9_1285;
float4 l9_1287=l9_1286;
float3 l9_1288=(l9_1287.xyz*1.9921875)-float3(1.0);
l9_1287=float4(l9_1288.x,l9_1288.y,l9_1288.z,l9_1287.w);
l9_1194=l9_1287;
l9_597=l9_1194.xyz;
l9_600=l9_597;
}
else
{
l9_600=l9_598;
}
l9_596=l9_600;
float l9_1289=0.0;
float l9_1290=(*sc_set2.UserUniforms).roughness;
l9_1289=l9_1290;
float l9_1291=l9_595;
float3 l9_1292=l9_596;
float l9_1293=l9_1289;
ssGlobals l9_1294=param;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1294.BumpedNormal=float3x3(float3(l9_1294.VertexTangent_WorldSpace),float3(l9_1294.VertexBinormal_WorldSpace),float3(l9_1294.VertexNormal_WorldSpace))*l9_1292;
}
l9_1291=fast::clamp(l9_1291,0.0,1.0);
float l9_1295=l9_1291;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_1295<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_1296=gl_FragCoord;
float2 l9_1297=floor(mod(l9_1296.xy,float2(4.0)));
float l9_1298=(mod(dot(l9_1297,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_1295<l9_1298)
{
discard_fragment();
}
}
float3 l9_1299=l9_1294.PositionWS;
float3 l9_1300=l9_1294.BumpedNormal;
float l9_1301=l9_1293;
float3 l9_1302=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_1299);
if (dot(l9_1302,l9_1300)>=(-0.050000001))
{
uint3 l9_1303=uint3(round((l9_1299-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_1303.x,l9_1303.y,l9_1303.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_1304=l9_1300;
float l9_1305=dot(abs(l9_1304),float3(1.0));
l9_1304/=float3(l9_1305);
float l9_1306=fast::clamp(-l9_1304.z,0.0,1.0);
float2 l9_1307=l9_1304.xy;
float l9_1308;
if (l9_1304.x>=0.0)
{
l9_1308=l9_1306;
}
else
{
l9_1308=-l9_1306;
}
l9_1307.x+=l9_1308;
float l9_1309;
if (l9_1304.y>=0.0)
{
l9_1309=l9_1306;
}
else
{
l9_1309=-l9_1306;
}
l9_1307.y+=l9_1309;
float2 l9_1310=l9_1307;
float2 l9_1311=l9_1310;
uint2 l9_1312=uint2(as_type<uint>(half2(float2(l9_1311.x,0.0))),as_type<uint>(half2(float2(l9_1311.y,0.0))));
out.normal_and_more=uint4(l9_1312.x,l9_1312.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_1313;
if (l9_1301<0.0)
{
l9_1313=1023u;
}
else
{
l9_1313=uint(fast::clamp(l9_1301,0.0,1.0)*1000.0);
}
uint l9_1314=l9_1313;
l9_1314 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_1314;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
}
else
{
float3 l9_1315=float3(0.0);
float3 l9_1316=(*sc_set2.UserUniforms).colorStart;
l9_1315=l9_1316;
float3 l9_1317=float3(0.0);
float3 l9_1318=(*sc_set2.UserUniforms).colorEnd;
l9_1317=l9_1318;
float3 l9_1319=float3(0.0);
float3 l9_1320=(*sc_set2.UserUniforms).colorMinStart;
l9_1319=l9_1320;
float3 l9_1321=float3(0.0);
float3 l9_1322=(*sc_set2.UserUniforms).colorMinEnd;
l9_1321=l9_1322;
float3 l9_1323=float3(0.0);
float3 l9_1324=(*sc_set2.UserUniforms).colorMaxStart;
l9_1323=l9_1324;
float3 l9_1325=float3(0.0);
float3 l9_1326=(*sc_set2.UserUniforms).colorMaxEnd;
l9_1325=l9_1326;
float l9_1327=0.0;
float l9_1328=(*sc_set2.UserUniforms).alphaStart;
l9_1327=l9_1328;
float l9_1329=0.0;
float l9_1330=(*sc_set2.UserUniforms).alphaEnd;
l9_1329=l9_1330;
float l9_1331=0.0;
float l9_1332=(*sc_set2.UserUniforms).alphaMinStart;
l9_1331=l9_1332;
float l9_1333=0.0;
float l9_1334=(*sc_set2.UserUniforms).alphaMinEnd;
l9_1333=l9_1334;
float l9_1335=0.0;
float l9_1336=(*sc_set2.UserUniforms).alphaMaxStart;
l9_1335=l9_1336;
float l9_1337=0.0;
float l9_1338=(*sc_set2.UserUniforms).alphaMaxEnd;
l9_1337=l9_1338;
float l9_1339=0.0;
float l9_1340=(*sc_set2.UserUniforms).alphaDissolveMult;
l9_1339=l9_1340;
float l9_1341=0.0;
l9_1341=in.Interpolator0.x;
float l9_1342=0.0;
float l9_1343=(*sc_set2.UserUniforms).numValidFrames;
l9_1342=l9_1343;
float2 l9_1344=float2(0.0);
float2 l9_1345=(*sc_set2.UserUniforms).gridSize;
l9_1344=l9_1345;
float l9_1346=0.0;
float l9_1347=(*sc_set2.UserUniforms).flipBookSpeedMult;
l9_1346=l9_1347;
float l9_1348=0.0;
float l9_1349=(*sc_set2.UserUniforms).flipBookRandomStart;
l9_1348=l9_1349;
float2 l9_1350=float2(0.0);
float2 l9_1351=(*sc_set2.UserUniforms).colorRampTextureSize.xy;
l9_1350=l9_1351;
float4 l9_1352=float4(0.0);
float4 l9_1353=(*sc_set2.UserUniforms).colorRampMult;
l9_1352=l9_1353;
float4 l9_1354=float4(0.0);
float4 l9_1355;
l9_1355.x=in.Interpolator0.y;
l9_1355.y=in.Interpolator0.z;
l9_1355.z=in.Interpolator0.w;
l9_1355.w=in.Interpolator1.x;
l9_1354=l9_1355;
float l9_1356=0.0;
float l9_1357=(*sc_set2.UserUniforms).externalSeed;
l9_1356=l9_1357;
float3 l9_1358=l9_1315;
float3 l9_1359=l9_1317;
float3 l9_1360=l9_1319;
float3 l9_1361=l9_1321;
float3 l9_1362=l9_1323;
float3 l9_1363=l9_1325;
float l9_1364=l9_1327;
float l9_1365=l9_1329;
float l9_1366=l9_1331;
float l9_1367=l9_1333;
float l9_1368=l9_1335;
float l9_1369=l9_1337;
float l9_1370=l9_1339;
float l9_1371=l9_1341;
float l9_1372=l9_1342;
float2 l9_1373=l9_1344;
float l9_1374=l9_1346;
float l9_1375=l9_1348;
float2 l9_1376=l9_1350;
float4 l9_1377=l9_1352;
float4 l9_1378=l9_1354;
float l9_1379=l9_1356;
ssGlobals l9_1380=param;
tempGlobals=l9_1380;
N2_colorStart=l9_1358;
N2_colorEnd=l9_1359;
N2_ENABLE_COLORMINMAX=(int(COLORMINMAX_tmp)!=0);
N2_colorMinStart=l9_1360;
N2_colorMinEnd=l9_1361;
N2_colorMaxStart=l9_1362;
N2_colorMaxEnd=l9_1363;
N2_ENABLE_COLORMONOMIN=(int(COLORMONOMIN_tmp)!=0);
N2_alphaStart=l9_1364;
N2_alphaEnd=l9_1365;
N2_ENABLE_ALPHAMINMAX=(int(ALPHAMINMAX_tmp)!=0);
N2_alphaMinStart=l9_1366;
N2_alphaMinEnd=l9_1367;
N2_alphaMaxStart=l9_1368;
N2_alphaMaxEnd=l9_1369;
N2_ENABLE_ALPHADISSOLVE=(int(ALPHADISSOLVE_tmp)!=0);
N2_alphaDissolveMult=l9_1370;
N2_ENABLE_PREMULTIPLIEDCOLOR=(int(PREMULTIPLIEDCOLOR_tmp)!=0);
N2_ENABLE_BLACKASALPHA=(int(BLACKASALPHA_tmp)!=0);
N2_ENABLE_SCREENFADE=(int(SCREENFADE_tmp)!=0);
N2_nearCameraFade=l9_1371;
N2_ENABLE_FLIPBOOK=(int(FLIPBOOK_tmp)!=0);
N2_numValidFrames=l9_1372;
N2_gridSize=l9_1373;
N2_flipBookSpeedMult=l9_1374;
N2_flipBookRandomStart=l9_1375;
N2_ENABLE_FLIPBOOKBLEND=(int(FLIPBOOKBLEND_tmp)!=0);
N2_ENABLE_FLIPBOOKBYLIFE=(int(FLIPBOOKBYLIFE_tmp)!=0);
N2_ENABLE_COLORRAMP=(int(COLORRAMP_tmp)!=0);
N2_texSize=l9_1376;
N2_colorRampMult=l9_1377;
N2_ENABLE_NORANDOFFSET=(int(NORANDOFFSET_tmp)!=0);
N2_ENABLE_BASETEXTURE=(int(BASETEXTURE_tmp)!=0);
N2_timeValuesIn=l9_1378;
N2_ENABLE_WORLDPOSSEED=(int(WORLDPOSSEED_tmp)!=0);
N2_externalSeed=l9_1379;
float l9_1381=0.0;
if (N2_ENABLE_WORLDPOSSEED)
{
float4x4 l9_1382=(*sc_set2.UserUniforms).sc_ModelMatrix;
l9_1381=length(float4(1.0)*l9_1382);
}
N2_globalSeed=N2_externalSeed+l9_1381;
float l9_1383=2000.0;
int l9_1384=0;
l9_1384=int(tempGlobals.gInstanceID);
int l9_1385=l9_1384;
float l9_1386=float(l9_1385);
float2 l9_1387=float2(mod(l9_1386,l9_1383),floor(l9_1386/l9_1383));
l9_1387/=float2(l9_1383);
float2 l9_1388=l9_1387;
float l9_1389=dot(l9_1388,float2(0.38253,0.42662001));
float3 l9_1390=float3(0.457831,0.62343299,0.97625297)*l9_1389;
l9_1390=sin(l9_1390)*float3(479.371,389.53101,513.03497);
l9_1390=fract(l9_1390);
l9_1390=floor(l9_1390*10000.0)*9.9999997e-05;
float3 l9_1391=l9_1390;
float3 l9_1392=l9_1391;
N2_particleSeed=l9_1392;
float l9_1393=N2_particleSeed.x;
float l9_1394=N2_particleSeed.y;
float l9_1395=N2_particleSeed.z;
float3 l9_1396=fract((float3(l9_1393,l9_1394,l9_1395)*27.21883)+float3(N2_globalSeed));
if (N2_ENABLE_COLORMONOMIN)
{
l9_1396=fract((float3(l9_1393,l9_1393,l9_1393)*27.21883)+float3(N2_globalSeed));
}
float l9_1397=fract((N2_particleSeed.x*3121.3333)+N2_globalSeed);
float l9_1398=fract((N2_particleSeed.y*13.2234)+N2_globalSeed);
float l9_1399=fract((N2_particleSeed.z*3.5358)+N2_globalSeed);
float l9_1400=N2_timeValuesIn.w;
float4 l9_1401=float4(0.0);
float3 l9_1402=float3(0.0);
float3 l9_1403=float3(0.0);
float l9_1404=0.0;
float l9_1405=0.0;
if (N2_ENABLE_COLORMINMAX)
{
l9_1402=mix(N2_colorMinStart,N2_colorMaxStart,l9_1396);
l9_1403=mix(N2_colorMinEnd,N2_colorMaxEnd,l9_1396);
}
else
{
l9_1402=N2_colorStart;
l9_1403=N2_colorEnd;
}
if (N2_ENABLE_ALPHAMINMAX)
{
l9_1404=mix(N2_alphaMinStart,N2_alphaMaxStart,l9_1397);
l9_1405=mix(N2_alphaMinEnd,N2_alphaMaxEnd,l9_1397);
}
else
{
l9_1404=N2_alphaStart;
l9_1405=N2_alphaEnd;
}
l9_1402=mix(l9_1402,l9_1403,float3(l9_1400));
l9_1404=mix(l9_1404,l9_1405,l9_1400);
l9_1401=float4(l9_1402,l9_1404);
float4 l9_1406=float4(0.0);
float2 l9_1407=tempGlobals.Surface_UVCoord0;
float2 l9_1408=l9_1407;
float2 l9_1409=tempGlobals.Surface_UVCoord1;
float2 l9_1410=l9_1409;
float l9_1411=fast::max(N2_timeValuesIn.x,0.0099999998);
float l9_1412=fast::max(N2_timeValuesIn.y,0.0099999998);
float l9_1413=N2_timeValuesIn.z;
if (N2_ENABLE_FLIPBOOKBYLIFE)
{
float l9_1414=mix(l9_1411,l9_1412,l9_1399);
l9_1413=N2_timeValuesIn.z/l9_1414;
}
float l9_1415=mix(0.0,N2_flipBookRandomStart,l9_1398);
float2 l9_1416=l9_1408/N2_gridSize;
float l9_1417=(l9_1413*N2_flipBookSpeedMult)+l9_1415;
l9_1417=mod(l9_1417,N2_numValidFrames);
float l9_1418=floor(l9_1417)*(1.0/N2_gridSize.x);
float l9_1419=mod(floor((-l9_1417)/N2_gridSize.x),N2_gridSize.y)*(1.0/N2_gridSize.y);
float l9_1420=l9_1417+1.0;
l9_1420=mod(l9_1420,N2_numValidFrames);
float l9_1421=floor(l9_1420)*(1.0/N2_gridSize.x);
float l9_1422=floor((-l9_1420)*(1.0/N2_gridSize.x))*(1.0/N2_gridSize.y);
float l9_1423=fract(l9_1417);
l9_1408=l9_1416+float2(l9_1418,l9_1419);
l9_1410=l9_1416+float2(l9_1421,l9_1422);
if (N2_ENABLE_FLIPBOOKBLEND)
{
float2 l9_1424=l9_1408;
float4 l9_1425=float4(0.0);
int l9_1426=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_1427=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1427=0;
}
else
{
l9_1427=in.varStereoViewID;
}
int l9_1428=l9_1427;
l9_1426=1-l9_1428;
}
else
{
int l9_1429=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1429=0;
}
else
{
l9_1429=in.varStereoViewID;
}
int l9_1430=l9_1429;
l9_1426=l9_1430;
}
int l9_1431=l9_1426;
int l9_1432=mainTextureLayout_tmp;
int l9_1433=l9_1431;
float2 l9_1434=l9_1424;
bool l9_1435=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_1436=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_1437=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_1438=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_1439=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_1440=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_1441=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_1442=0.0;
bool l9_1443=l9_1440&&(!l9_1438);
float l9_1444=1.0;
float l9_1445=l9_1434.x;
int l9_1446=l9_1437.x;
if (l9_1446==1)
{
l9_1445=fract(l9_1445);
}
else
{
if (l9_1446==2)
{
float l9_1447=fract(l9_1445);
float l9_1448=l9_1445-l9_1447;
float l9_1449=step(0.25,fract(l9_1448*0.5));
l9_1445=mix(l9_1447,1.0-l9_1447,fast::clamp(l9_1449,0.0,1.0));
}
}
l9_1434.x=l9_1445;
float l9_1450=l9_1434.y;
int l9_1451=l9_1437.y;
if (l9_1451==1)
{
l9_1450=fract(l9_1450);
}
else
{
if (l9_1451==2)
{
float l9_1452=fract(l9_1450);
float l9_1453=l9_1450-l9_1452;
float l9_1454=step(0.25,fract(l9_1453*0.5));
l9_1450=mix(l9_1452,1.0-l9_1452,fast::clamp(l9_1454,0.0,1.0));
}
}
l9_1434.y=l9_1450;
if (l9_1438)
{
bool l9_1455=l9_1440;
bool l9_1456;
if (l9_1455)
{
l9_1456=l9_1437.x==3;
}
else
{
l9_1456=l9_1455;
}
float l9_1457=l9_1434.x;
float l9_1458=l9_1439.x;
float l9_1459=l9_1439.z;
bool l9_1460=l9_1456;
float l9_1461=l9_1444;
float l9_1462=fast::clamp(l9_1457,l9_1458,l9_1459);
float l9_1463=step(abs(l9_1457-l9_1462),9.9999997e-06);
l9_1461*=(l9_1463+((1.0-float(l9_1460))*(1.0-l9_1463)));
l9_1457=l9_1462;
l9_1434.x=l9_1457;
l9_1444=l9_1461;
bool l9_1464=l9_1440;
bool l9_1465;
if (l9_1464)
{
l9_1465=l9_1437.y==3;
}
else
{
l9_1465=l9_1464;
}
float l9_1466=l9_1434.y;
float l9_1467=l9_1439.y;
float l9_1468=l9_1439.w;
bool l9_1469=l9_1465;
float l9_1470=l9_1444;
float l9_1471=fast::clamp(l9_1466,l9_1467,l9_1468);
float l9_1472=step(abs(l9_1466-l9_1471),9.9999997e-06);
l9_1470*=(l9_1472+((1.0-float(l9_1469))*(1.0-l9_1472)));
l9_1466=l9_1471;
l9_1434.y=l9_1466;
l9_1444=l9_1470;
}
float2 l9_1473=l9_1434;
bool l9_1474=l9_1435;
float3x3 l9_1475=l9_1436;
if (l9_1474)
{
l9_1473=float2((l9_1475*float3(l9_1473,1.0)).xy);
}
float2 l9_1476=l9_1473;
float2 l9_1477=l9_1476;
float2 l9_1478=l9_1477;
l9_1434=l9_1478;
float l9_1479=l9_1434.x;
int l9_1480=l9_1437.x;
bool l9_1481=l9_1443;
float l9_1482=l9_1444;
if ((l9_1480==0)||(l9_1480==3))
{
float l9_1483=l9_1479;
float l9_1484=0.0;
float l9_1485=1.0;
bool l9_1486=l9_1481;
float l9_1487=l9_1482;
float l9_1488=fast::clamp(l9_1483,l9_1484,l9_1485);
float l9_1489=step(abs(l9_1483-l9_1488),9.9999997e-06);
l9_1487*=(l9_1489+((1.0-float(l9_1486))*(1.0-l9_1489)));
l9_1483=l9_1488;
l9_1479=l9_1483;
l9_1482=l9_1487;
}
l9_1434.x=l9_1479;
l9_1444=l9_1482;
float l9_1490=l9_1434.y;
int l9_1491=l9_1437.y;
bool l9_1492=l9_1443;
float l9_1493=l9_1444;
if ((l9_1491==0)||(l9_1491==3))
{
float l9_1494=l9_1490;
float l9_1495=0.0;
float l9_1496=1.0;
bool l9_1497=l9_1492;
float l9_1498=l9_1493;
float l9_1499=fast::clamp(l9_1494,l9_1495,l9_1496);
float l9_1500=step(abs(l9_1494-l9_1499),9.9999997e-06);
l9_1498*=(l9_1500+((1.0-float(l9_1497))*(1.0-l9_1500)));
l9_1494=l9_1499;
l9_1490=l9_1494;
l9_1493=l9_1498;
}
l9_1434.y=l9_1490;
l9_1444=l9_1493;
float2 l9_1501=l9_1434;
int l9_1502=l9_1432;
int l9_1503=l9_1433;
float l9_1504=l9_1442;
float2 l9_1505=l9_1501;
int l9_1506=l9_1502;
int l9_1507=l9_1503;
float3 l9_1508=float3(0.0);
if (l9_1506==0)
{
l9_1508=float3(l9_1505,0.0);
}
else
{
if (l9_1506==1)
{
l9_1508=float3(l9_1505.x,(l9_1505.y*0.5)+(0.5-(float(l9_1507)*0.5)),0.0);
}
else
{
l9_1508=float3(l9_1505,float(l9_1507));
}
}
float3 l9_1509=l9_1508;
float3 l9_1510=l9_1509;
float2 l9_1511=l9_1510.xy;
float l9_1512=l9_1504;
float4 l9_1513=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_1511,bias(l9_1512));
float4 l9_1514=l9_1513;
float4 l9_1515=l9_1514;
if (l9_1440)
{
l9_1515=mix(l9_1441,l9_1515,float4(l9_1444));
}
float4 l9_1516=l9_1515;
l9_1425=l9_1516;
float4 l9_1517=l9_1425;
float4 l9_1518=l9_1517;
float2 l9_1519=l9_1410;
float4 l9_1520=float4(0.0);
int l9_1521=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
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
l9_1521=1-l9_1523;
}
else
{
int l9_1524=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1524=0;
}
else
{
l9_1524=in.varStereoViewID;
}
int l9_1525=l9_1524;
l9_1521=l9_1525;
}
int l9_1526=l9_1521;
int l9_1527=mainTextureLayout_tmp;
int l9_1528=l9_1526;
float2 l9_1529=l9_1519;
bool l9_1530=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_1531=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_1532=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_1533=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_1534=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_1535=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_1536=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_1537=0.0;
bool l9_1538=l9_1535&&(!l9_1533);
float l9_1539=1.0;
float l9_1540=l9_1529.x;
int l9_1541=l9_1532.x;
if (l9_1541==1)
{
l9_1540=fract(l9_1540);
}
else
{
if (l9_1541==2)
{
float l9_1542=fract(l9_1540);
float l9_1543=l9_1540-l9_1542;
float l9_1544=step(0.25,fract(l9_1543*0.5));
l9_1540=mix(l9_1542,1.0-l9_1542,fast::clamp(l9_1544,0.0,1.0));
}
}
l9_1529.x=l9_1540;
float l9_1545=l9_1529.y;
int l9_1546=l9_1532.y;
if (l9_1546==1)
{
l9_1545=fract(l9_1545);
}
else
{
if (l9_1546==2)
{
float l9_1547=fract(l9_1545);
float l9_1548=l9_1545-l9_1547;
float l9_1549=step(0.25,fract(l9_1548*0.5));
l9_1545=mix(l9_1547,1.0-l9_1547,fast::clamp(l9_1549,0.0,1.0));
}
}
l9_1529.y=l9_1545;
if (l9_1533)
{
bool l9_1550=l9_1535;
bool l9_1551;
if (l9_1550)
{
l9_1551=l9_1532.x==3;
}
else
{
l9_1551=l9_1550;
}
float l9_1552=l9_1529.x;
float l9_1553=l9_1534.x;
float l9_1554=l9_1534.z;
bool l9_1555=l9_1551;
float l9_1556=l9_1539;
float l9_1557=fast::clamp(l9_1552,l9_1553,l9_1554);
float l9_1558=step(abs(l9_1552-l9_1557),9.9999997e-06);
l9_1556*=(l9_1558+((1.0-float(l9_1555))*(1.0-l9_1558)));
l9_1552=l9_1557;
l9_1529.x=l9_1552;
l9_1539=l9_1556;
bool l9_1559=l9_1535;
bool l9_1560;
if (l9_1559)
{
l9_1560=l9_1532.y==3;
}
else
{
l9_1560=l9_1559;
}
float l9_1561=l9_1529.y;
float l9_1562=l9_1534.y;
float l9_1563=l9_1534.w;
bool l9_1564=l9_1560;
float l9_1565=l9_1539;
float l9_1566=fast::clamp(l9_1561,l9_1562,l9_1563);
float l9_1567=step(abs(l9_1561-l9_1566),9.9999997e-06);
l9_1565*=(l9_1567+((1.0-float(l9_1564))*(1.0-l9_1567)));
l9_1561=l9_1566;
l9_1529.y=l9_1561;
l9_1539=l9_1565;
}
float2 l9_1568=l9_1529;
bool l9_1569=l9_1530;
float3x3 l9_1570=l9_1531;
if (l9_1569)
{
l9_1568=float2((l9_1570*float3(l9_1568,1.0)).xy);
}
float2 l9_1571=l9_1568;
float2 l9_1572=l9_1571;
float2 l9_1573=l9_1572;
l9_1529=l9_1573;
float l9_1574=l9_1529.x;
int l9_1575=l9_1532.x;
bool l9_1576=l9_1538;
float l9_1577=l9_1539;
if ((l9_1575==0)||(l9_1575==3))
{
float l9_1578=l9_1574;
float l9_1579=0.0;
float l9_1580=1.0;
bool l9_1581=l9_1576;
float l9_1582=l9_1577;
float l9_1583=fast::clamp(l9_1578,l9_1579,l9_1580);
float l9_1584=step(abs(l9_1578-l9_1583),9.9999997e-06);
l9_1582*=(l9_1584+((1.0-float(l9_1581))*(1.0-l9_1584)));
l9_1578=l9_1583;
l9_1574=l9_1578;
l9_1577=l9_1582;
}
l9_1529.x=l9_1574;
l9_1539=l9_1577;
float l9_1585=l9_1529.y;
int l9_1586=l9_1532.y;
bool l9_1587=l9_1538;
float l9_1588=l9_1539;
if ((l9_1586==0)||(l9_1586==3))
{
float l9_1589=l9_1585;
float l9_1590=0.0;
float l9_1591=1.0;
bool l9_1592=l9_1587;
float l9_1593=l9_1588;
float l9_1594=fast::clamp(l9_1589,l9_1590,l9_1591);
float l9_1595=step(abs(l9_1589-l9_1594),9.9999997e-06);
l9_1593*=(l9_1595+((1.0-float(l9_1592))*(1.0-l9_1595)));
l9_1589=l9_1594;
l9_1585=l9_1589;
l9_1588=l9_1593;
}
l9_1529.y=l9_1585;
l9_1539=l9_1588;
float2 l9_1596=l9_1529;
int l9_1597=l9_1527;
int l9_1598=l9_1528;
float l9_1599=l9_1537;
float2 l9_1600=l9_1596;
int l9_1601=l9_1597;
int l9_1602=l9_1598;
float3 l9_1603=float3(0.0);
if (l9_1601==0)
{
l9_1603=float3(l9_1600,0.0);
}
else
{
if (l9_1601==1)
{
l9_1603=float3(l9_1600.x,(l9_1600.y*0.5)+(0.5-(float(l9_1602)*0.5)),0.0);
}
else
{
l9_1603=float3(l9_1600,float(l9_1602));
}
}
float3 l9_1604=l9_1603;
float3 l9_1605=l9_1604;
float2 l9_1606=l9_1605.xy;
float l9_1607=l9_1599;
float4 l9_1608=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_1606,bias(l9_1607));
float4 l9_1609=l9_1608;
float4 l9_1610=l9_1609;
if (l9_1535)
{
l9_1610=mix(l9_1536,l9_1610,float4(l9_1539));
}
float4 l9_1611=l9_1610;
l9_1520=l9_1611;
float4 l9_1612=l9_1520;
l9_1406=mix(l9_1518,l9_1612,float4(l9_1423));
}
else
{
float2 l9_1613=l9_1408;
float4 l9_1614=float4(0.0);
int l9_1615=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_1616=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1616=0;
}
else
{
l9_1616=in.varStereoViewID;
}
int l9_1617=l9_1616;
l9_1615=1-l9_1617;
}
else
{
int l9_1618=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1618=0;
}
else
{
l9_1618=in.varStereoViewID;
}
int l9_1619=l9_1618;
l9_1615=l9_1619;
}
int l9_1620=l9_1615;
int l9_1621=mainTextureLayout_tmp;
int l9_1622=l9_1620;
float2 l9_1623=l9_1613;
bool l9_1624=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_1625=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_1626=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_1627=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_1628=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_1629=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_1630=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_1631=0.0;
bool l9_1632=l9_1629&&(!l9_1627);
float l9_1633=1.0;
float l9_1634=l9_1623.x;
int l9_1635=l9_1626.x;
if (l9_1635==1)
{
l9_1634=fract(l9_1634);
}
else
{
if (l9_1635==2)
{
float l9_1636=fract(l9_1634);
float l9_1637=l9_1634-l9_1636;
float l9_1638=step(0.25,fract(l9_1637*0.5));
l9_1634=mix(l9_1636,1.0-l9_1636,fast::clamp(l9_1638,0.0,1.0));
}
}
l9_1623.x=l9_1634;
float l9_1639=l9_1623.y;
int l9_1640=l9_1626.y;
if (l9_1640==1)
{
l9_1639=fract(l9_1639);
}
else
{
if (l9_1640==2)
{
float l9_1641=fract(l9_1639);
float l9_1642=l9_1639-l9_1641;
float l9_1643=step(0.25,fract(l9_1642*0.5));
l9_1639=mix(l9_1641,1.0-l9_1641,fast::clamp(l9_1643,0.0,1.0));
}
}
l9_1623.y=l9_1639;
if (l9_1627)
{
bool l9_1644=l9_1629;
bool l9_1645;
if (l9_1644)
{
l9_1645=l9_1626.x==3;
}
else
{
l9_1645=l9_1644;
}
float l9_1646=l9_1623.x;
float l9_1647=l9_1628.x;
float l9_1648=l9_1628.z;
bool l9_1649=l9_1645;
float l9_1650=l9_1633;
float l9_1651=fast::clamp(l9_1646,l9_1647,l9_1648);
float l9_1652=step(abs(l9_1646-l9_1651),9.9999997e-06);
l9_1650*=(l9_1652+((1.0-float(l9_1649))*(1.0-l9_1652)));
l9_1646=l9_1651;
l9_1623.x=l9_1646;
l9_1633=l9_1650;
bool l9_1653=l9_1629;
bool l9_1654;
if (l9_1653)
{
l9_1654=l9_1626.y==3;
}
else
{
l9_1654=l9_1653;
}
float l9_1655=l9_1623.y;
float l9_1656=l9_1628.y;
float l9_1657=l9_1628.w;
bool l9_1658=l9_1654;
float l9_1659=l9_1633;
float l9_1660=fast::clamp(l9_1655,l9_1656,l9_1657);
float l9_1661=step(abs(l9_1655-l9_1660),9.9999997e-06);
l9_1659*=(l9_1661+((1.0-float(l9_1658))*(1.0-l9_1661)));
l9_1655=l9_1660;
l9_1623.y=l9_1655;
l9_1633=l9_1659;
}
float2 l9_1662=l9_1623;
bool l9_1663=l9_1624;
float3x3 l9_1664=l9_1625;
if (l9_1663)
{
l9_1662=float2((l9_1664*float3(l9_1662,1.0)).xy);
}
float2 l9_1665=l9_1662;
float2 l9_1666=l9_1665;
float2 l9_1667=l9_1666;
l9_1623=l9_1667;
float l9_1668=l9_1623.x;
int l9_1669=l9_1626.x;
bool l9_1670=l9_1632;
float l9_1671=l9_1633;
if ((l9_1669==0)||(l9_1669==3))
{
float l9_1672=l9_1668;
float l9_1673=0.0;
float l9_1674=1.0;
bool l9_1675=l9_1670;
float l9_1676=l9_1671;
float l9_1677=fast::clamp(l9_1672,l9_1673,l9_1674);
float l9_1678=step(abs(l9_1672-l9_1677),9.9999997e-06);
l9_1676*=(l9_1678+((1.0-float(l9_1675))*(1.0-l9_1678)));
l9_1672=l9_1677;
l9_1668=l9_1672;
l9_1671=l9_1676;
}
l9_1623.x=l9_1668;
l9_1633=l9_1671;
float l9_1679=l9_1623.y;
int l9_1680=l9_1626.y;
bool l9_1681=l9_1632;
float l9_1682=l9_1633;
if ((l9_1680==0)||(l9_1680==3))
{
float l9_1683=l9_1679;
float l9_1684=0.0;
float l9_1685=1.0;
bool l9_1686=l9_1681;
float l9_1687=l9_1682;
float l9_1688=fast::clamp(l9_1683,l9_1684,l9_1685);
float l9_1689=step(abs(l9_1683-l9_1688),9.9999997e-06);
l9_1687*=(l9_1689+((1.0-float(l9_1686))*(1.0-l9_1689)));
l9_1683=l9_1688;
l9_1679=l9_1683;
l9_1682=l9_1687;
}
l9_1623.y=l9_1679;
l9_1633=l9_1682;
float2 l9_1690=l9_1623;
int l9_1691=l9_1621;
int l9_1692=l9_1622;
float l9_1693=l9_1631;
float2 l9_1694=l9_1690;
int l9_1695=l9_1691;
int l9_1696=l9_1692;
float3 l9_1697=float3(0.0);
if (l9_1695==0)
{
l9_1697=float3(l9_1694,0.0);
}
else
{
if (l9_1695==1)
{
l9_1697=float3(l9_1694.x,(l9_1694.y*0.5)+(0.5-(float(l9_1696)*0.5)),0.0);
}
else
{
l9_1697=float3(l9_1694,float(l9_1696));
}
}
float3 l9_1698=l9_1697;
float3 l9_1699=l9_1698;
float2 l9_1700=l9_1699.xy;
float l9_1701=l9_1693;
float4 l9_1702=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_1700,bias(l9_1701));
float4 l9_1703=l9_1702;
float4 l9_1704=l9_1703;
if (l9_1629)
{
l9_1704=mix(l9_1630,l9_1704,float4(l9_1633));
}
float4 l9_1705=l9_1704;
l9_1614=l9_1705;
float4 l9_1706=l9_1614;
l9_1406=l9_1706;
}
float4 l9_1707=float4(0.0);
float l9_1708=ceil(l9_1400*N2_texSize.x)/N2_texSize.x;
float l9_1709=l9_1708;
if (N2_ENABLE_NORANDOFFSET)
{
float2 l9_1710=tempGlobals.Surface_UVCoord0;
l9_1709+=(l9_1710.x/N2_texSize.x);
}
float2 l9_1711=float2(l9_1709,0.5);
float4 l9_1712=float4(0.0);
int l9_1713=0;
if ((int(colorRampTextureHasSwappedViews_tmp)!=0))
{
int l9_1714=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1714=0;
}
else
{
l9_1714=in.varStereoViewID;
}
int l9_1715=l9_1714;
l9_1713=1-l9_1715;
}
else
{
int l9_1716=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1716=0;
}
else
{
l9_1716=in.varStereoViewID;
}
int l9_1717=l9_1716;
l9_1713=l9_1717;
}
int l9_1718=l9_1713;
int l9_1719=colorRampTextureLayout_tmp;
int l9_1720=l9_1718;
float2 l9_1721=l9_1711;
bool l9_1722=(int(SC_USE_UV_TRANSFORM_colorRampTexture_tmp)!=0);
float3x3 l9_1723=(*sc_set2.UserUniforms).colorRampTextureTransform;
int2 l9_1724=int2(SC_SOFTWARE_WRAP_MODE_U_colorRampTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_colorRampTexture_tmp);
bool l9_1725=(int(SC_USE_UV_MIN_MAX_colorRampTexture_tmp)!=0);
float4 l9_1726=(*sc_set2.UserUniforms).colorRampTextureUvMinMax;
bool l9_1727=(int(SC_USE_CLAMP_TO_BORDER_colorRampTexture_tmp)!=0);
float4 l9_1728=(*sc_set2.UserUniforms).colorRampTextureBorderColor;
float l9_1729=0.0;
bool l9_1730=l9_1727&&(!l9_1725);
float l9_1731=1.0;
float l9_1732=l9_1721.x;
int l9_1733=l9_1724.x;
if (l9_1733==1)
{
l9_1732=fract(l9_1732);
}
else
{
if (l9_1733==2)
{
float l9_1734=fract(l9_1732);
float l9_1735=l9_1732-l9_1734;
float l9_1736=step(0.25,fract(l9_1735*0.5));
l9_1732=mix(l9_1734,1.0-l9_1734,fast::clamp(l9_1736,0.0,1.0));
}
}
l9_1721.x=l9_1732;
float l9_1737=l9_1721.y;
int l9_1738=l9_1724.y;
if (l9_1738==1)
{
l9_1737=fract(l9_1737);
}
else
{
if (l9_1738==2)
{
float l9_1739=fract(l9_1737);
float l9_1740=l9_1737-l9_1739;
float l9_1741=step(0.25,fract(l9_1740*0.5));
l9_1737=mix(l9_1739,1.0-l9_1739,fast::clamp(l9_1741,0.0,1.0));
}
}
l9_1721.y=l9_1737;
if (l9_1725)
{
bool l9_1742=l9_1727;
bool l9_1743;
if (l9_1742)
{
l9_1743=l9_1724.x==3;
}
else
{
l9_1743=l9_1742;
}
float l9_1744=l9_1721.x;
float l9_1745=l9_1726.x;
float l9_1746=l9_1726.z;
bool l9_1747=l9_1743;
float l9_1748=l9_1731;
float l9_1749=fast::clamp(l9_1744,l9_1745,l9_1746);
float l9_1750=step(abs(l9_1744-l9_1749),9.9999997e-06);
l9_1748*=(l9_1750+((1.0-float(l9_1747))*(1.0-l9_1750)));
l9_1744=l9_1749;
l9_1721.x=l9_1744;
l9_1731=l9_1748;
bool l9_1751=l9_1727;
bool l9_1752;
if (l9_1751)
{
l9_1752=l9_1724.y==3;
}
else
{
l9_1752=l9_1751;
}
float l9_1753=l9_1721.y;
float l9_1754=l9_1726.y;
float l9_1755=l9_1726.w;
bool l9_1756=l9_1752;
float l9_1757=l9_1731;
float l9_1758=fast::clamp(l9_1753,l9_1754,l9_1755);
float l9_1759=step(abs(l9_1753-l9_1758),9.9999997e-06);
l9_1757*=(l9_1759+((1.0-float(l9_1756))*(1.0-l9_1759)));
l9_1753=l9_1758;
l9_1721.y=l9_1753;
l9_1731=l9_1757;
}
float2 l9_1760=l9_1721;
bool l9_1761=l9_1722;
float3x3 l9_1762=l9_1723;
if (l9_1761)
{
l9_1760=float2((l9_1762*float3(l9_1760,1.0)).xy);
}
float2 l9_1763=l9_1760;
float2 l9_1764=l9_1763;
float2 l9_1765=l9_1764;
l9_1721=l9_1765;
float l9_1766=l9_1721.x;
int l9_1767=l9_1724.x;
bool l9_1768=l9_1730;
float l9_1769=l9_1731;
if ((l9_1767==0)||(l9_1767==3))
{
float l9_1770=l9_1766;
float l9_1771=0.0;
float l9_1772=1.0;
bool l9_1773=l9_1768;
float l9_1774=l9_1769;
float l9_1775=fast::clamp(l9_1770,l9_1771,l9_1772);
float l9_1776=step(abs(l9_1770-l9_1775),9.9999997e-06);
l9_1774*=(l9_1776+((1.0-float(l9_1773))*(1.0-l9_1776)));
l9_1770=l9_1775;
l9_1766=l9_1770;
l9_1769=l9_1774;
}
l9_1721.x=l9_1766;
l9_1731=l9_1769;
float l9_1777=l9_1721.y;
int l9_1778=l9_1724.y;
bool l9_1779=l9_1730;
float l9_1780=l9_1731;
if ((l9_1778==0)||(l9_1778==3))
{
float l9_1781=l9_1777;
float l9_1782=0.0;
float l9_1783=1.0;
bool l9_1784=l9_1779;
float l9_1785=l9_1780;
float l9_1786=fast::clamp(l9_1781,l9_1782,l9_1783);
float l9_1787=step(abs(l9_1781-l9_1786),9.9999997e-06);
l9_1785*=(l9_1787+((1.0-float(l9_1784))*(1.0-l9_1787)));
l9_1781=l9_1786;
l9_1777=l9_1781;
l9_1780=l9_1785;
}
l9_1721.y=l9_1777;
l9_1731=l9_1780;
float2 l9_1788=l9_1721;
int l9_1789=l9_1719;
int l9_1790=l9_1720;
float l9_1791=l9_1729;
float2 l9_1792=l9_1788;
int l9_1793=l9_1789;
int l9_1794=l9_1790;
float3 l9_1795=float3(0.0);
if (l9_1793==0)
{
l9_1795=float3(l9_1792,0.0);
}
else
{
if (l9_1793==1)
{
l9_1795=float3(l9_1792.x,(l9_1792.y*0.5)+(0.5-(float(l9_1794)*0.5)),0.0);
}
else
{
l9_1795=float3(l9_1792,float(l9_1794));
}
}
float3 l9_1796=l9_1795;
float3 l9_1797=l9_1796;
float2 l9_1798=l9_1797.xy;
float l9_1799=l9_1791;
float4 l9_1800=sc_set2.colorRampTexture.sample(sc_set2.colorRampTextureSmpSC,l9_1798,bias(l9_1799));
float4 l9_1801=l9_1800;
float4 l9_1802=l9_1801;
if (l9_1727)
{
l9_1802=mix(l9_1728,l9_1802,float4(l9_1731));
}
float4 l9_1803=l9_1802;
l9_1712=l9_1803;
float4 l9_1804=l9_1712;
l9_1707=l9_1804*N2_colorRampMult;
float4 l9_1805=float4(1.0);
float4 l9_1806=float4(1.0);
if (N2_ENABLE_BASETEXTURE)
{
float2 l9_1807=tempGlobals.Surface_UVCoord0;
float2 l9_1808=l9_1807;
float4 l9_1809=float4(0.0);
int l9_1810=0;
if ((int(mainTextureHasSwappedViews_tmp)!=0))
{
int l9_1811=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1811=0;
}
else
{
l9_1811=in.varStereoViewID;
}
int l9_1812=l9_1811;
l9_1810=1-l9_1812;
}
else
{
int l9_1813=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1813=0;
}
else
{
l9_1813=in.varStereoViewID;
}
int l9_1814=l9_1813;
l9_1810=l9_1814;
}
int l9_1815=l9_1810;
int l9_1816=mainTextureLayout_tmp;
int l9_1817=l9_1815;
float2 l9_1818=l9_1808;
bool l9_1819=(int(SC_USE_UV_TRANSFORM_mainTexture_tmp)!=0);
float3x3 l9_1820=(*sc_set2.UserUniforms).mainTextureTransform;
int2 l9_1821=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_mainTexture_tmp);
bool l9_1822=(int(SC_USE_UV_MIN_MAX_mainTexture_tmp)!=0);
float4 l9_1823=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool l9_1824=(int(SC_USE_CLAMP_TO_BORDER_mainTexture_tmp)!=0);
float4 l9_1825=(*sc_set2.UserUniforms).mainTextureBorderColor;
float l9_1826=0.0;
bool l9_1827=l9_1824&&(!l9_1822);
float l9_1828=1.0;
float l9_1829=l9_1818.x;
int l9_1830=l9_1821.x;
if (l9_1830==1)
{
l9_1829=fract(l9_1829);
}
else
{
if (l9_1830==2)
{
float l9_1831=fract(l9_1829);
float l9_1832=l9_1829-l9_1831;
float l9_1833=step(0.25,fract(l9_1832*0.5));
l9_1829=mix(l9_1831,1.0-l9_1831,fast::clamp(l9_1833,0.0,1.0));
}
}
l9_1818.x=l9_1829;
float l9_1834=l9_1818.y;
int l9_1835=l9_1821.y;
if (l9_1835==1)
{
l9_1834=fract(l9_1834);
}
else
{
if (l9_1835==2)
{
float l9_1836=fract(l9_1834);
float l9_1837=l9_1834-l9_1836;
float l9_1838=step(0.25,fract(l9_1837*0.5));
l9_1834=mix(l9_1836,1.0-l9_1836,fast::clamp(l9_1838,0.0,1.0));
}
}
l9_1818.y=l9_1834;
if (l9_1822)
{
bool l9_1839=l9_1824;
bool l9_1840;
if (l9_1839)
{
l9_1840=l9_1821.x==3;
}
else
{
l9_1840=l9_1839;
}
float l9_1841=l9_1818.x;
float l9_1842=l9_1823.x;
float l9_1843=l9_1823.z;
bool l9_1844=l9_1840;
float l9_1845=l9_1828;
float l9_1846=fast::clamp(l9_1841,l9_1842,l9_1843);
float l9_1847=step(abs(l9_1841-l9_1846),9.9999997e-06);
l9_1845*=(l9_1847+((1.0-float(l9_1844))*(1.0-l9_1847)));
l9_1841=l9_1846;
l9_1818.x=l9_1841;
l9_1828=l9_1845;
bool l9_1848=l9_1824;
bool l9_1849;
if (l9_1848)
{
l9_1849=l9_1821.y==3;
}
else
{
l9_1849=l9_1848;
}
float l9_1850=l9_1818.y;
float l9_1851=l9_1823.y;
float l9_1852=l9_1823.w;
bool l9_1853=l9_1849;
float l9_1854=l9_1828;
float l9_1855=fast::clamp(l9_1850,l9_1851,l9_1852);
float l9_1856=step(abs(l9_1850-l9_1855),9.9999997e-06);
l9_1854*=(l9_1856+((1.0-float(l9_1853))*(1.0-l9_1856)));
l9_1850=l9_1855;
l9_1818.y=l9_1850;
l9_1828=l9_1854;
}
float2 l9_1857=l9_1818;
bool l9_1858=l9_1819;
float3x3 l9_1859=l9_1820;
if (l9_1858)
{
l9_1857=float2((l9_1859*float3(l9_1857,1.0)).xy);
}
float2 l9_1860=l9_1857;
float2 l9_1861=l9_1860;
float2 l9_1862=l9_1861;
l9_1818=l9_1862;
float l9_1863=l9_1818.x;
int l9_1864=l9_1821.x;
bool l9_1865=l9_1827;
float l9_1866=l9_1828;
if ((l9_1864==0)||(l9_1864==3))
{
float l9_1867=l9_1863;
float l9_1868=0.0;
float l9_1869=1.0;
bool l9_1870=l9_1865;
float l9_1871=l9_1866;
float l9_1872=fast::clamp(l9_1867,l9_1868,l9_1869);
float l9_1873=step(abs(l9_1867-l9_1872),9.9999997e-06);
l9_1871*=(l9_1873+((1.0-float(l9_1870))*(1.0-l9_1873)));
l9_1867=l9_1872;
l9_1863=l9_1867;
l9_1866=l9_1871;
}
l9_1818.x=l9_1863;
l9_1828=l9_1866;
float l9_1874=l9_1818.y;
int l9_1875=l9_1821.y;
bool l9_1876=l9_1827;
float l9_1877=l9_1828;
if ((l9_1875==0)||(l9_1875==3))
{
float l9_1878=l9_1874;
float l9_1879=0.0;
float l9_1880=1.0;
bool l9_1881=l9_1876;
float l9_1882=l9_1877;
float l9_1883=fast::clamp(l9_1878,l9_1879,l9_1880);
float l9_1884=step(abs(l9_1878-l9_1883),9.9999997e-06);
l9_1882*=(l9_1884+((1.0-float(l9_1881))*(1.0-l9_1884)));
l9_1878=l9_1883;
l9_1874=l9_1878;
l9_1877=l9_1882;
}
l9_1818.y=l9_1874;
l9_1828=l9_1877;
float2 l9_1885=l9_1818;
int l9_1886=l9_1816;
int l9_1887=l9_1817;
float l9_1888=l9_1826;
float2 l9_1889=l9_1885;
int l9_1890=l9_1886;
int l9_1891=l9_1887;
float3 l9_1892=float3(0.0);
if (l9_1890==0)
{
l9_1892=float3(l9_1889,0.0);
}
else
{
if (l9_1890==1)
{
l9_1892=float3(l9_1889.x,(l9_1889.y*0.5)+(0.5-(float(l9_1891)*0.5)),0.0);
}
else
{
l9_1892=float3(l9_1889,float(l9_1891));
}
}
float3 l9_1893=l9_1892;
float3 l9_1894=l9_1893;
float2 l9_1895=l9_1894.xy;
float l9_1896=l9_1888;
float4 l9_1897=sc_set2.mainTexture.sample(sc_set2.mainTextureSmpSC,l9_1895,bias(l9_1896));
float4 l9_1898=l9_1897;
float4 l9_1899=l9_1898;
if (l9_1824)
{
l9_1899=mix(l9_1825,l9_1899,float4(l9_1828));
}
float4 l9_1900=l9_1899;
l9_1809=l9_1900;
float4 l9_1901=l9_1809;
l9_1805=l9_1901;
float2 l9_1902=tempGlobals.Surface_UVCoord0;
N2_uv=l9_1902;
if (N2_ENABLE_FLIPBOOK)
{
l9_1805=l9_1406;
N2_uv=l9_1408;
}
}
if (N2_ENABLE_COLORRAMP)
{
if (!(!(SC_DEVICE_CLASS_tmp>=2)))
{
l9_1806=l9_1707;
}
}
N2_result=(l9_1805*l9_1401)*l9_1806;
if (N2_ENABLE_SCREENFADE)
{
N2_result.w*=N2_nearCameraFade;
}
if (N2_ENABLE_ALPHADISSOLVE)
{
float l9_1903=l9_1400*N2_alphaDissolveMult;
N2_result.w=fast::clamp(N2_result.w-l9_1903,0.0,1.0);
}
if (N2_ENABLE_BLACKASALPHA)
{
float l9_1904=length(N2_result.xyz);
N2_result.w=l9_1904;
}
if (N2_ENABLE_PREMULTIPLIEDCOLOR)
{
float3 l9_1905=N2_result.xyz*N2_result.w;
N2_result=float4(l9_1905.x,l9_1905.y,l9_1905.z,N2_result.w);
}
}
return out;
}
} // RECEIVER MODE SHADER
