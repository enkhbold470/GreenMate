#version 100 sc_convert_to 300 es
#if defined VERTEX_SHADER




#include <std2.glsl>
#include <std2_vs.glsl>
#include <std2_fs.glsl>
#include <std2_texture.glsl>


//SG_REFLECTION_BEGIN
//attribute vec4 color:15:
//SG_REFLECTION_END



varying vec4 varColor;
attribute vec4 color;

mat3 _4181;
vec2 _4194;
vec3 _4205;

void ngsVertexShaderEnd(sc_Vertex_t v,vec3 WorldPosition,vec3 WorldNormal,vec3 WorldTangent,vec4 ScreenPosition)
{
varPos=WorldPosition;
varNormal=normalize(WorldNormal);
vec3 _3565=normalize(WorldTangent);
varTangent=vec4(_3565.x,_3565.y,_3565.z,varTangent.w);
varTangent.w=tangent.w;
#if (UseViewSpaceDepthVariant&&((sc_OITDepthGatherPass||sc_OITCompositingPass)||sc_OITDepthBoundsPass))
{
vec4 param=v.position;
varViewSpaceDepth=-sc_ObjectToView(param).z;
}
#endif
vec4 _4217;
#if (sc_RenderingSpace==3)
{
_4217=ScreenPosition;
}
#else
{
vec4 _4218;
#if (sc_RenderingSpace==4)
{
_4218=(sc_ModelViewMatrixArray[sc_GetStereoViewIndex()]*v.position)*vec4(1.0/sc_Camera.aspect,1.0,1.0,1.0);
}
#else
{
vec4 _4219;
#if (sc_RenderingSpace==2)
{
_4219=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPos,1.0);
}
#else
{
vec4 _4220;
#if (sc_RenderingSpace==1)
{
_4220=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPos,1.0);
}
#else
{
_4220=vec4(0.0);
}
#endif
_4219=_4220;
}
#endif
_4218=_4219;
}
#endif
_4217=_4218;
}
#endif
varPackedTex=vec4(v.texture0,v.texture1);
#if (sc_ProjectiveShadowsReceiver)
{
vec4 param_1=v.position;
varShadowTex=getProjectedTexCoords(param_1);
}
#endif
vec4 _4221;
#if (sc_DepthBufferMode==1)
{
vec4 _4158=_4217;
_4158.z=((log2(max(sc_Camera.clipPlanes.x,1.0+_4217.w))*(2.0/log2(sc_Camera.clipPlanes.y+1.0)))-1.0)*_4217.w;
_4221=_4158;
}
#else
{
_4221=_4217;
}
#endif
gl_Position=_4221;
}

void main()
{
sc_Vertex_t _4018=sc_LoadVertexAttributes();
sc_BlendVertex(_4018);
sc_Vertex_t _4019=_4018;
sc_SkinVertex(_4019);
sc_Vertex_t _4027=_4019;
#if (sc_RenderingSpace==3)
{
varPos=vec3(0.0);
varNormal=_4027.normal;
varTangent=vec4(_4027.tangent.x,_4027.tangent.y,_4027.tangent.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==4)
{
varPos=vec3(0.0);
varNormal=_4027.normal;
varTangent=vec4(_4027.tangent.x,_4027.tangent.y,_4027.tangent.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==2)
{
varPos=_4027.position.xyz;
varNormal=_4027.normal;
varTangent=vec4(_4027.tangent.x,_4027.tangent.y,_4027.tangent.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==1)
{
varPos=(sc_ModelMatrix*_4027.position).xyz;
varNormal=sc_NormalMatrix*_4027.normal;
vec3 _4044=sc_NormalMatrix*_4027.tangent;
varTangent=vec4(_4044.x,_4044.y,_4044.z,varTangent.w);
}
#endif
}
#endif
}
#endif
}
#endif
varColor=color;
sc_Vertex_t param=_4027;
vec3 param_1=varPos;
vec3 param_2=varNormal;
vec3 param_3=varTangent.xyz;
vec4 param_4=_4027.position;
ngsVertexShaderEnd(param,param_1,param_2,param_3,param_4);
}

#elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER




#include <std2.glsl>
#include <std2_vs.glsl>
#include <std2_fs.glsl>
#include <std2_texture.glsl>


//SG_REFLECTION_BEGIN
//texture texture2DArray baseTexArrSC:fs27-28
//texture texture2D baseTex:fs26-28
//sampler sampler baseTexSmpSC:fs28
//SG_REFLECTION_END

struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
vec2 Surface_UVCoord0;
};

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
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
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
const ivec2 _5854=ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
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
const ivec2 _5880=ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);

uniform float correctedIntensity;
uniform mediump sampler2D intensityTexture;
uniform mediump sampler2D sc_OITFilteredDepthBoundsTexture;
uniform highp sampler2D sc_OITFrontDepthTexture;
uniform mediump sampler2D sc_OITDepthHigh0;
uniform mediump sampler2D sc_OITDepthLow0;
uniform mediump sampler2D sc_OITAlpha0;
uniform mediump sampler2D sc_OITDepthHigh1;
uniform mediump sampler2D sc_OITDepthLow1;
uniform mediump sampler2D sc_OITAlpha1;
uniform float alphaTestThreshold;
uniform vec4 baseTexDims;
uniform int channel;
uniform mat3 baseTexTransform;
uniform vec4 baseTexUvMinMax;
uniform vec4 baseTexBorderColor;
uniform int overrideTimeEnabled;
uniform float overrideTimeElapsed;
uniform float overrideTimeDelta;
uniform mediump sampler2D baseTex;
uniform mediump sampler2DArray baseTexArrSC;

varying vec4 varColor;

float _9273;
vec3 _9301;
vec4 _9367;
vec4 _9388;
vec4 _9556;
float _9573;

int baseTexGetStereoViewIndex()
{
#if (baseTexHasSwappedViews)
{
return 1-sc_GetStereoViewIndex();
}
#else
{
return sc_GetStereoViewIndex();
}
#endif
}

void Node10_If_else(inout float Bool1,inout vec4 Value1,inout vec4 Default,out vec4 Result,ssGlobals Globals)
{
Bool1=float(float(channel)==0.0);
if (Bool1!=0.0)
{
vec4 _9558;
#if (baseTexLayout==2)
{
vec2 _8841=baseTexDims.xy;
int _8842=baseTexLayout;
int _8843=baseTexGetStereoViewIndex();
vec2 _8844=Globals.Surface_UVCoord0;
bool _8845=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8846=baseTexTransform;
ivec2 _8847=_5854;
bool _8848=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8849=baseTexUvMinMax;
bool _8850=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8851=baseTexBorderColor;
float _8852=0.0;
_9558=sc_SampleTextureBiasOrLevel_1(_8841,_8842,_8843,_8844,_8845,_8846,_8847,_8848,_8849,_8850,_8851,_8852,baseTexArrSC);
}
#else
{
vec2 _8853=baseTexDims.xy;
int _8854=baseTexLayout;
int _8855=baseTexGetStereoViewIndex();
vec2 _8856=Globals.Surface_UVCoord0;
bool _8857=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8858=baseTexTransform;
ivec2 _8859=_5880;
bool _8860=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8861=baseTexUvMinMax;
bool _8862=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8863=baseTexBorderColor;
float _8864=0.0;
_9558=sc_SampleTextureBiasOrLevel(_8853,_8854,_8855,_8856,_8857,_8858,_8859,_8860,_8861,_8862,_8863,_8864,baseTex);
}
#endif
vec4 _9226=vec4(0.0);
_9226.x=_9558.x;
vec4 _9228=_9226;
_9228.y=_9558.y;
vec4 _9230=_9228;
_9230.z=_9558.z;
vec4 _9232=_9230;
_9232.w=_9558.w;
Value1=_9232*vec4(_9558.w);
Result=Value1;
}
else
{
vec4 _9557;
#if (baseTexLayout==2)
{
vec2 _8778=baseTexDims.xy;
int _8779=baseTexLayout;
int _8780=baseTexGetStereoViewIndex();
vec2 _8781=Globals.Surface_UVCoord0;
bool _8782=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8783=baseTexTransform;
ivec2 _8784=_5854;
bool _8785=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8786=baseTexUvMinMax;
bool _8787=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8788=baseTexBorderColor;
float _8789=0.0;
_9557=sc_SampleTextureBiasOrLevel_1(_8778,_8779,_8780,_8781,_8782,_8783,_8784,_8785,_8786,_8787,_8788,_8789,baseTexArrSC);
}
#else
{
vec2 _8790=baseTexDims.xy;
int _8791=baseTexLayout;
int _8792=baseTexGetStereoViewIndex();
vec2 _8793=Globals.Surface_UVCoord0;
bool _8794=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8795=baseTexTransform;
ivec2 _8796=_5880;
bool _8797=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8798=baseTexUvMinMax;
bool _8799=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8800=baseTexBorderColor;
float _8801=0.0;
_9557=sc_SampleTextureBiasOrLevel(_8790,_8791,_8792,_8793,_8794,_8795,_8796,_8797,_8798,_8799,_8800,_8801,baseTex);
}
#endif
vec4 _9214=vec4(0.0);
_9214.x=_9557.x;
vec4 _9216=_9214;
_9216.y=_9557.y;
vec4 _9218=_9216;
_9218.z=_9557.z;
vec4 _9220=_9218;
_9220.w=_9557.w;
Default=_9220*vec4(_9557.w);
Result=Default;
}
}

void Node11_If_else(inout float Bool1,inout vec4 Value1,inout vec4 Default,out vec4 Result,ssGlobals Globals)
{
Bool1=float(float(channel)==1.0);
if (Bool1!=0.0)
{
vec4 _9559;
#if (baseTexLayout==2)
{
vec2 _8712=baseTexDims.xy;
int _8713=baseTexLayout;
int _8714=baseTexGetStereoViewIndex();
vec2 _8715=Globals.Surface_UVCoord0;
bool _8716=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8717=baseTexTransform;
ivec2 _8718=_5854;
bool _8719=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8720=baseTexUvMinMax;
bool _8721=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8722=baseTexBorderColor;
float _8723=0.0;
_9559=sc_SampleTextureBiasOrLevel_1(_8712,_8713,_8714,_8715,_8716,_8717,_8718,_8719,_8720,_8721,_8722,_8723,baseTexArrSC);
}
#else
{
vec2 _8724=baseTexDims.xy;
int _8725=baseTexLayout;
int _8726=baseTexGetStereoViewIndex();
vec2 _8727=Globals.Surface_UVCoord0;
bool _8728=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8729=baseTexTransform;
ivec2 _8730=_5880;
bool _8731=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8732=baseTexUvMinMax;
bool _8733=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8734=baseTexBorderColor;
float _8735=0.0;
_9559=sc_SampleTextureBiasOrLevel(_8724,_8725,_8726,_8727,_8728,_8729,_8730,_8731,_8732,_8733,_8734,_8735,baseTex);
}
#endif
vec4 _9235=vec4(0.0);
_9235.x=_9559.x;
vec4 _9237=_9235;
_9237.y=_9559.x;
vec4 _9239=_9237;
_9239.z=_9559.x;
vec4 _9241=_9239;
_9241.w=1.0;
Value1=_9241;
Result=Value1;
}
else
{
float param=0.0;
vec4 param_1=vec4(0.0);
vec4 param_2=vec4(0.0);
ssGlobals param_4=Globals;
vec4 param_3;
Node10_If_else(param,param_1,param_2,param_3,param_4);
Default=param_3;
Result=Default;
}
}

void Node12_If_else(inout float Bool1,inout vec4 Value1,inout vec4 Default,out vec4 Result,ssGlobals Globals)
{
Bool1=float(float(channel)==2.0);
if (Bool1!=0.0)
{
vec4 _9560;
#if (baseTexLayout==2)
{
vec2 _8484=baseTexDims.xy;
int _8485=baseTexLayout;
int _8486=baseTexGetStereoViewIndex();
vec2 _8487=Globals.Surface_UVCoord0;
bool _8488=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8489=baseTexTransform;
ivec2 _8490=_5854;
bool _8491=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8492=baseTexUvMinMax;
bool _8493=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8494=baseTexBorderColor;
float _8495=0.0;
_9560=sc_SampleTextureBiasOrLevel_1(_8484,_8485,_8486,_8487,_8488,_8489,_8490,_8491,_8492,_8493,_8494,_8495,baseTexArrSC);
}
#else
{
vec2 _8496=baseTexDims.xy;
int _8497=baseTexLayout;
int _8498=baseTexGetStereoViewIndex();
vec2 _8499=Globals.Surface_UVCoord0;
bool _8500=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _8501=baseTexTransform;
ivec2 _8502=_5880;
bool _8503=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _8504=baseTexUvMinMax;
bool _8505=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _8506=baseTexBorderColor;
float _8507=0.0;
_9560=sc_SampleTextureBiasOrLevel(_8496,_8497,_8498,_8499,_8500,_8501,_8502,_8503,_8504,_8505,_8506,_8507,baseTex);
}
#endif
vec4 _9244=vec4(0.0);
_9244.x=_9560.y;
vec4 _9246=_9244;
_9246.y=_9560.y;
vec4 _9248=_9246;
_9248.z=_9560.y;
vec4 _9250=_9248;
_9250.w=1.0;
Value1=_9250;
Result=Value1;
}
else
{
float param=0.0;
vec4 param_1=vec4(0.0);
vec4 param_2=vec4(0.0);
ssGlobals param_4=Globals;
vec4 param_3;
Node11_If_else(param,param_1,param_2,param_3,param_4);
Default=param_3;
Result=Default;
}
}

void Node13_If_else(inout float Bool1,inout vec4 Value1,inout vec4 Default,out vec4 Result,ssGlobals Globals)
{
Bool1=float(float(channel)==3.0);
if (Bool1!=0.0)
{
vec4 _9561;
#if (baseTexLayout==2)
{
vec2 _7200=baseTexDims.xy;
int _7201=baseTexLayout;
int _7202=baseTexGetStereoViewIndex();
vec2 _7203=Globals.Surface_UVCoord0;
bool _7204=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _7205=baseTexTransform;
ivec2 _7206=_5854;
bool _7207=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _7208=baseTexUvMinMax;
bool _7209=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _7210=baseTexBorderColor;
float _7211=0.0;
_9561=sc_SampleTextureBiasOrLevel_1(_7200,_7201,_7202,_7203,_7204,_7205,_7206,_7207,_7208,_7209,_7210,_7211,baseTexArrSC);
}
#else
{
vec2 _7212=baseTexDims.xy;
int _7213=baseTexLayout;
int _7214=baseTexGetStereoViewIndex();
vec2 _7215=Globals.Surface_UVCoord0;
bool _7216=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _7217=baseTexTransform;
ivec2 _7218=_5880;
bool _7219=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _7220=baseTexUvMinMax;
bool _7221=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _7222=baseTexBorderColor;
float _7223=0.0;
_9561=sc_SampleTextureBiasOrLevel(_7212,_7213,_7214,_7215,_7216,_7217,_7218,_7219,_7220,_7221,_7222,_7223,baseTex);
}
#endif
vec4 _9253=vec4(0.0);
_9253.x=_9561.z;
vec4 _9255=_9253;
_9255.y=_9561.z;
vec4 _9257=_9255;
_9257.z=_9561.z;
vec4 _9259=_9257;
_9259.w=1.0;
Value1=_9259;
Result=Value1;
}
else
{
float param=0.0;
vec4 param_1=vec4(0.0);
vec4 param_2=vec4(0.0);
ssGlobals param_4=Globals;
vec4 param_3;
Node12_If_else(param,param_1,param_2,param_3,param_4);
Default=param_3;
Result=Default;
}
}

void Node15_If_else(inout float Bool1,inout vec4 Value1,inout vec4 Default,out vec4 Result,ssGlobals Globals)
{
Bool1=float(float(channel)==4.0);
if (Bool1!=0.0)
{
vec4 _9562;
#if (baseTexLayout==2)
{
vec2 _6562=baseTexDims.xy;
int _6563=baseTexLayout;
int _6564=baseTexGetStereoViewIndex();
vec2 _6565=Globals.Surface_UVCoord0;
bool _6566=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _6567=baseTexTransform;
ivec2 _6568=_5854;
bool _6569=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _6570=baseTexUvMinMax;
bool _6571=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _6572=baseTexBorderColor;
float _6573=0.0;
_9562=sc_SampleTextureBiasOrLevel_1(_6562,_6563,_6564,_6565,_6566,_6567,_6568,_6569,_6570,_6571,_6572,_6573,baseTexArrSC);
}
#else
{
vec2 _6574=baseTexDims.xy;
int _6575=baseTexLayout;
int _6576=baseTexGetStereoViewIndex();
vec2 _6577=Globals.Surface_UVCoord0;
bool _6578=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
mat3 _6579=baseTexTransform;
ivec2 _6580=_5880;
bool _6581=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
vec4 _6582=baseTexUvMinMax;
bool _6583=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
vec4 _6584=baseTexBorderColor;
float _6585=0.0;
_9562=sc_SampleTextureBiasOrLevel(_6574,_6575,_6576,_6577,_6578,_6579,_6580,_6581,_6582,_6583,_6584,_6585,baseTex);
}
#endif
vec4 _9262=vec4(0.0);
_9262.x=_9562.w;
vec4 _9264=_9262;
_9264.y=_9562.w;
vec4 _9266=_9264;
_9266.z=_9562.w;
vec4 _9268=_9266;
_9268.w=1.0;
Value1=_9268;
Result=Value1;
}
else
{
float param=0.0;
vec4 param_1=vec4(0.0);
vec4 param_2=vec4(0.0);
ssGlobals param_4=Globals;
vec4 param_3;
Node13_If_else(param,param_1,param_2,param_3,param_4);
Default=param_3;
Result=Default;
}
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

vec3 transformColor(float yValue,vec3 original,vec3 target,float weight,float intMap)
{
#if (BLEND_MODE_INTENSE)
{
vec3 _3334=original;
vec4 _9302;
if (_3334.y<_3334.z)
{
_9302=vec4(_3334.zy,-1.0,0.666667);
}
else
{
_9302=vec4(_3334.yz,0.0,-0.333333);
}
vec4 _9303;
if (_3334.x<_9302.x)
{
_9303=vec4(_9302.xy,_9573,_3334.x);
}
else
{
_9303=vec4(_3334.x,_9302.y,_9573,_9302.x);
}
float _8559=_9303.x-((_9303.x-min(_9303.w,_9303.y))*0.5);
float _8687=6.0*target.x;
return mix(original,((clamp(vec3(abs(_8687-3.0)-1.0,2.0-abs(_8687-2.0),2.0-abs(_8687-4.0)),vec3(0.0),vec3(1.0))-vec3(0.5))*((1.0-abs((2.0*_8559)-1.0))*target.y))+vec3(_8559),vec3(weight));
}
#else
{
float param=yValue;
float param_1=intMap;
float param_2=target.x;
vec3 _8960=_9301;
_8960.x=transformSingleColor(param,param_1,param_2);
float param_3=yValue;
float param_4=intMap;
float param_5=target.y;
vec3 _8962=_8960;
_8962.y=transformSingleColor(param_3,param_4,param_5);
float param_6=yValue;
float param_7=intMap;
float param_8=target.z;
vec3 _8964=_8962;
_8964.z=transformSingleColor(param_6,param_7,param_8);
return mix(original,clamp(_8964,vec3(0.0),vec3(1.0)),vec3(weight));
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
float _9363;
if (a.x<0.5)
{
_9363=(2.0*a.x)*b.x;
}
else
{
_9363=1.0-((2.0*(1.0-a.x))*(1.0-b.x));
}
float _9364;
if (a.y<0.5)
{
_9364=(2.0*a.y)*b.y;
}
else
{
_9364=1.0-((2.0*(1.0-a.y))*(1.0-b.y));
}
float _9365;
if (a.z<0.5)
{
_9365=(2.0*a.z)*b.z;
}
else
{
_9365=1.0-((2.0*(1.0-a.z))*(1.0-b.z));
}
return vec3(_9363,_9364,_9365);
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
float _9360;
if (b.x<0.5)
{
_9360=(2.0*b.x)*a.x;
}
else
{
_9360=1.0-((2.0*(1.0-b.x))*(1.0-a.x));
}
float _9361;
if (b.y<0.5)
{
_9361=(2.0*b.y)*a.y;
}
else
{
_9361=1.0-((2.0*(1.0-b.y))*(1.0-a.y));
}
float _9362;
if (b.z<0.5)
{
_9362=(2.0*b.z)*a.z;
}
else
{
_9362=1.0-((2.0*(1.0-b.z))*(1.0-a.z));
}
return vec3(_9360,_9361,_9362);
}
#else
{
#if (BLEND_MODE_COLOR_DODGE)
{
float _9357;
if (b.x==1.0)
{
_9357=b.x;
}
else
{
_9357=min(a.x/(1.0-b.x),1.0);
}
float _9358;
if (b.y==1.0)
{
_9358=b.y;
}
else
{
_9358=min(a.y/(1.0-b.y),1.0);
}
float _9359;
if (b.z==1.0)
{
_9359=b.z;
}
else
{
_9359=min(a.z/(1.0-b.z),1.0);
}
return vec3(_9357,_9358,_9359);
}
#else
{
#if (BLEND_MODE_COLOR_BURN)
{
float _9354;
if (b.x==0.0)
{
_9354=b.x;
}
else
{
_9354=max(1.0-((1.0-a.x)/b.x),0.0);
}
float _9355;
if (b.y==0.0)
{
_9355=b.y;
}
else
{
_9355=max(1.0-((1.0-a.y)/b.y),0.0);
}
float _9356;
if (b.z==0.0)
{
_9356=b.z;
}
else
{
_9356=max(1.0-((1.0-a.z)/b.z),0.0);
}
return vec3(_9354,_9355,_9356);
}
#else
{
#if (BLEND_MODE_LINEAR_LIGHT)
{
float _9351;
if (b.x<0.5)
{
_9351=max((a.x+(2.0*b.x))-1.0,0.0);
}
else
{
_9351=min(a.x+(2.0*(b.x-0.5)),1.0);
}
float _9352;
if (b.y<0.5)
{
_9352=max((a.y+(2.0*b.y))-1.0,0.0);
}
else
{
_9352=min(a.y+(2.0*(b.y-0.5)),1.0);
}
float _9353;
if (b.z<0.5)
{
_9353=max((a.z+(2.0*b.z))-1.0,0.0);
}
else
{
_9353=min(a.z+(2.0*(b.z-0.5)),1.0);
}
return vec3(_9351,_9352,_9353);
}
#else
{
#if (BLEND_MODE_VIVID_LIGHT)
{
float _9344;
if (b.x<0.5)
{
float _9343;
if ((2.0*b.x)==0.0)
{
_9343=2.0*b.x;
}
else
{
_9343=max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
_9344=_9343;
}
else
{
float _9342;
if ((2.0*(b.x-0.5))==1.0)
{
_9342=2.0*(b.x-0.5);
}
else
{
_9342=min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
_9344=_9342;
}
float _9347;
if (b.y<0.5)
{
float _9346;
if ((2.0*b.y)==0.0)
{
_9346=2.0*b.y;
}
else
{
_9346=max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
_9347=_9346;
}
else
{
float _9345;
if ((2.0*(b.y-0.5))==1.0)
{
_9345=2.0*(b.y-0.5);
}
else
{
_9345=min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
_9347=_9345;
}
float _9350;
if (b.z<0.5)
{
float _9349;
if ((2.0*b.z)==0.0)
{
_9349=2.0*b.z;
}
else
{
_9349=max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
_9350=_9349;
}
else
{
float _9348;
if ((2.0*(b.z-0.5))==1.0)
{
_9348=2.0*(b.z-0.5);
}
else
{
_9348=min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
_9350=_9348;
}
return vec3(_9344,_9347,_9350);
}
#else
{
#if (BLEND_MODE_PIN_LIGHT)
{
float _9339;
if (b.x<0.5)
{
_9339=min(a.x,2.0*b.x);
}
else
{
_9339=max(a.x,2.0*(b.x-0.5));
}
float _9340;
if (b.y<0.5)
{
_9340=min(a.y,2.0*b.y);
}
else
{
_9340=max(a.y,2.0*(b.y-0.5));
}
float _9341;
if (b.z<0.5)
{
_9341=min(a.z,2.0*b.z);
}
else
{
_9341=max(a.z,2.0*(b.z-0.5));
}
return vec3(_9339,_9340,_9341);
}
#else
{
#if (BLEND_MODE_HARD_MIX)
{
float _9332;
if (b.x<0.5)
{
float _9331;
if ((2.0*b.x)==0.0)
{
_9331=2.0*b.x;
}
else
{
_9331=max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
_9332=_9331;
}
else
{
float _9330;
if ((2.0*(b.x-0.5))==1.0)
{
_9330=2.0*(b.x-0.5);
}
else
{
_9330=min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
_9332=_9330;
}
bool _4288=_9332<0.5;
float _9335;
if (b.y<0.5)
{
float _9334;
if ((2.0*b.y)==0.0)
{
_9334=2.0*b.y;
}
else
{
_9334=max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
_9335=_9334;
}
else
{
float _9333;
if ((2.0*(b.y-0.5))==1.0)
{
_9333=2.0*(b.y-0.5);
}
else
{
_9333=min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
_9335=_9333;
}
bool _4342=_9335<0.5;
float _9338;
if (b.z<0.5)
{
float _9337;
if ((2.0*b.z)==0.0)
{
_9337=2.0*b.z;
}
else
{
_9337=max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
_9338=_9337;
}
else
{
float _9336;
if ((2.0*(b.z-0.5))==1.0)
{
_9336=2.0*(b.z-0.5);
}
else
{
_9336=min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
_9338=_9336;
}
return vec3(_4288 ? 0.0 : 1.0,_4342 ? 0.0 : 1.0,(_9338<0.5) ? 0.0 : 1.0);
}
#else
{
#if (BLEND_MODE_HARD_REFLECT)
{
float _9327;
if (b.x==1.0)
{
_9327=b.x;
}
else
{
_9327=min((a.x*a.x)/(1.0-b.x),1.0);
}
float _9328;
if (b.y==1.0)
{
_9328=b.y;
}
else
{
_9328=min((a.y*a.y)/(1.0-b.y),1.0);
}
float _9329;
if (b.z==1.0)
{
_9329=b.z;
}
else
{
_9329=min((a.z*a.z)/(1.0-b.z),1.0);
}
return vec3(_9327,_9328,_9329);
}
#else
{
#if (BLEND_MODE_HARD_GLOW)
{
float _9324;
if (a.x==1.0)
{
_9324=a.x;
}
else
{
_9324=min((b.x*b.x)/(1.0-a.x),1.0);
}
float _9325;
if (a.y==1.0)
{
_9325=a.y;
}
else
{
_9325=min((b.y*b.y)/(1.0-a.y),1.0);
}
float _9326;
if (a.z==1.0)
{
_9326=a.z;
}
else
{
_9326=min((b.z*b.z)/(1.0-a.z),1.0);
}
return vec3(_9324,_9325,_9326);
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
vec3 _4550=a;
vec3 _4552=b;
vec4 _9320;
if (_4550.y<_4550.z)
{
_9320=vec4(_4550.zy,-1.0,0.666667);
}
else
{
_9320=vec4(_4550.yz,0.0,-0.333333);
}
vec4 _9321;
if (_4550.x<_9320.x)
{
_9321=vec4(_9320.xy,_9573,_4550.x);
}
else
{
_9321=vec4(_4550.x,_9320.y,_9573,_9320.x);
}
float _8298=_9321.x-min(_9321.w,_9321.y);
float _8223=_9321.x-(_8298*0.5);
float _8229=abs((2.0*_8223)-1.0);
vec4 _9322;
if (_4552.y<_4552.z)
{
_9322=vec4(_4552.zy,-1.0,0.666667);
}
else
{
_9322=vec4(_4552.yz,0.0,-0.333333);
}
vec4 _9323;
if (_4552.x<_9322.x)
{
_9323=vec4(_9322.xyw,_4552.x);
}
else
{
_9323=vec4(_4552.x,_9322.yzx);
}
float _8459=6.0*abs(((_9323.w-_9323.y)/((6.0*(_9323.x-min(_9323.w,_9323.y)))+1e-07))+_9323.z);
return ((clamp(vec3(abs(_8459-3.0)-1.0,2.0-abs(_8459-2.0),2.0-abs(_8459-4.0)),vec3(0.0),vec3(1.0))-vec3(0.5))*((1.0-_8229)*(_8298/(1.0-_8229))))+vec3(_8223);
}
#else
{
#if (BLEND_MODE_SATURATION)
{
vec3 _4560=a;
vec3 _4562=b;
vec4 _9316;
if (_4560.y<_4560.z)
{
_9316=vec4(_4560.zy,-1.0,0.666667);
}
else
{
_9316=vec4(_4560.yz,0.0,-0.333333);
}
vec4 _9317;
if (_4560.x<_9316.x)
{
_9317=vec4(_9316.xyw,_4560.x);
}
else
{
_9317=vec4(_4560.x,_9316.yzx);
}
float _8011=_9317.x-min(_9317.w,_9317.y);
float _7936=_9317.x-(_8011*0.5);
vec4 _9318;
if (_4562.y<_4562.z)
{
_9318=vec4(_4562.zy,-1.0,0.666667);
}
else
{
_9318=vec4(_4562.yz,0.0,-0.333333);
}
vec4 _9319;
if (_4562.x<_9318.x)
{
_9319=vec4(_9318.xy,_9573,_4562.x);
}
else
{
_9319=vec4(_4562.x,_9318.y,_9573,_9318.x);
}
float _8119=_9319.x-min(_9319.w,_9319.y);
float _8172=6.0*abs(((_9317.w-_9317.y)/((6.0*_8011)+1e-07))+_9317.z);
return ((clamp(vec3(abs(_8172-3.0)-1.0,2.0-abs(_8172-2.0),2.0-abs(_8172-4.0)),vec3(0.0),vec3(1.0))-vec3(0.5))*((1.0-abs((2.0*_7936)-1.0))*(_8119/(1.0-abs((2.0*(_9319.x-(_8119*0.5)))-1.0)))))+vec3(_7936);
}
#else
{
#if (BLEND_MODE_COLOR)
{
vec3 _4570=a;
vec3 _4572=b;
vec4 _9312;
if (_4572.y<_4572.z)
{
_9312=vec4(_4572.zy,-1.0,0.666667);
}
else
{
_9312=vec4(_4572.yz,0.0,-0.333333);
}
vec4 _9313;
if (_4572.x<_9312.x)
{
_9313=vec4(_9312.xyw,_4572.x);
}
else
{
_9313=vec4(_4572.x,_9312.yzx);
}
float _7724=_9313.x-min(_9313.w,_9313.y);
vec4 _9314;
if (_4570.y<_4570.z)
{
_9314=vec4(_4570.zy,-1.0,0.666667);
}
else
{
_9314=vec4(_4570.yz,0.0,-0.333333);
}
vec4 _9315;
if (_4570.x<_9314.x)
{
_9315=vec4(_9314.xy,_9573,_4570.x);
}
else
{
_9315=vec4(_4570.x,_9314.y,_9573,_9314.x);
}
float _7757=_9315.x-((_9315.x-min(_9315.w,_9315.y))*0.5);
float _7885=6.0*abs(((_9313.w-_9313.y)/((6.0*_7724)+1e-07))+_9313.z);
return ((clamp(vec3(abs(_7885-3.0)-1.0,2.0-abs(_7885-2.0),2.0-abs(_7885-4.0)),vec3(0.0),vec3(1.0))-vec3(0.5))*((1.0-abs((2.0*_7757)-1.0))*(_7724/(1.0-abs((2.0*(_9313.x-(_7724*0.5)))-1.0)))))+vec3(_7757);
}
#else
{
#if (BLEND_MODE_LUMINOSITY)
{
vec3 _4580=a;
vec3 _4582=b;
vec4 _9308;
if (_4580.y<_4580.z)
{
_9308=vec4(_4580.zy,-1.0,0.666667);
}
else
{
_9308=vec4(_4580.yz,0.0,-0.333333);
}
vec4 _9309;
if (_4580.x<_9308.x)
{
_9309=vec4(_9308.xyw,_4580.x);
}
else
{
_9309=vec4(_4580.x,_9308.yzx);
}
float _7437=_9309.x-min(_9309.w,_9309.y);
vec4 _9310;
if (_4582.y<_4582.z)
{
_9310=vec4(_4582.zy,-1.0,0.666667);
}
else
{
_9310=vec4(_4582.yz,0.0,-0.333333);
}
vec4 _9311;
if (_4582.x<_9310.x)
{
_9311=vec4(_9310.xy,_9573,_4582.x);
}
else
{
_9311=vec4(_4582.x,_9310.y,_9573,_9310.x);
}
float _7470=_9311.x-((_9311.x-min(_9311.w,_9311.y))*0.5);
float _7598=6.0*abs(((_9309.w-_9309.y)/((6.0*_7437)+1e-07))+_9309.z);
return ((clamp(vec3(abs(_7598-3.0)-1.0,2.0-abs(_7598-2.0),2.0-abs(_7598-4.0)),vec3(0.0),vec3(1.0))-vec3(0.5))*((1.0-abs((2.0*_7470)-1.0))*(_7437/(1.0-abs((2.0*(_9309.x-(_7437*0.5)))-1.0)))))+vec3(_7470);
}
#else
{
vec3 _4587=a;
vec3 _4589=b;
float _7316=((0.299*_4587.x)+(0.587*_4587.y))+(0.114*_4587.z);
mediump vec4 _7286=texture2D(intensityTexture,vec2(pow(_7316,1.0/correctedIntensity),0.5));
float _7331=(((_7286.x*256.0)+_7286.y)+(_7286.z*0.00390625))*0.0622559;
float _9306;
#if (BLEND_MODE_FORGRAY)
{
_9306=max(_7331,1.0);
}
#else
{
_9306=_7331;
}
#endif
float _9307;
#if (BLEND_MODE_NOTBRIGHT)
{
_9307=min(_9306,1.0);
}
#else
{
_9307=_9306;
}
#endif
float _7270=_7316;
vec3 _7271=_4587;
vec3 _7272=_4589;
float _7273=1.0;
float _7274=_9307;
return transformColor(_7270,_7271,_7272,_7273,_7274);
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

vec4 ngsPixelShader(inout vec4 result)
{
#if (sc_ProjectiveShadowsCaster)
{
vec4 param=result;
return evaluateShadowCasterColor(param);
}
#else
{
#if (sc_RenderAlphaToColor)
{
return vec4(result.w);
}
#endif
}
#endif
#if (sc_BlendMode_Custom)
{
vec3 _6631=getFramebufferColor().xyz;
vec3 _6626=_6631;
vec3 _6627=result.xyz;
vec3 _6644=mix(_6631,definedBlend(_6626,_6627).xyz,vec3(result.w));
vec4 _9208=vec4(_6644.x,_6644.y,_6644.z,_9556.w);
_9208.w=1.0;
result=_9208;
}
#else
{
#if (sc_BlendMode_MultiplyOriginal)
{
vec3 _5659=mix(vec3(1.0),result.xyz,vec3(result.w));
result=vec4(_5659.x,_5659.y,_5659.z,result.w);
}
#else
{
#if (sc_BlendMode_Screen)
{
vec3 _5669=result.xyz*result.w;
result=vec4(_5669.x,_5669.y,_5669.z,result.w);
}
#endif
}
#endif
}
#endif
return result;
}

float getFrontLayerZTestEpsilon()
{
#if (sc_SkinBonesCount>0)
{
return 5e-07;
}
#else
{
return 5e-08;
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

void oitCompositing(vec4 materialColor)
{
#if (sc_OITCompositingPass)
{
vec2 _4921=getScreenUV();
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture2D(sc_OITFrontDepthTexture,_4921).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
int depths[8];
int alphas[8];
for (int _9370=0; _9370<8; depths[_9370]=0,alphas[_9370]=0,_9370++)
{
}
int _9373;
#if (sc_OITMaxLayers8)
{
_9373=2;
}
#else
{
_9373=1;
}
#endif
vec4 _9384;
vec4 _9391;
vec4 _9448;
_9448=_9388;
_9391=_9388;
_9384=_9388;
vec4 _9382;
vec4 _9389;
vec4 _9446;
for (int _9371=0; _9371<_9373; _9448=_9446,_9391=_9389,_9384=_9382,_9371++)
{
vec4 _9383;
vec4 _9390;
vec4 _9447;
if (_9371==0)
{
_9447=texture2D(sc_OITAlpha0,_4921);
_9390=texture2D(sc_OITDepthLow0,_4921);
_9383=texture2D(sc_OITDepthHigh0,_4921);
}
else
{
_9447=_9448;
_9390=_9391;
_9383=_9384;
}
if (_9371==1)
{
_9446=texture2D(sc_OITAlpha1,_4921);
_9389=texture2D(sc_OITDepthLow1,_4921);
_9382=texture2D(sc_OITDepthHigh1,_4921);
}
else
{
_9446=_9447;
_9389=_9390;
_9382=_9383;
}
if (any(notEqual(_9382,vec4(0.0)))||any(notEqual(_9389,vec4(0.0))))
{
int param[8];
param[0]=depths[0];
param[1]=depths[1];
param[2]=depths[2];
param[3]=depths[3];
param[4]=depths[4];
param[5]=depths[5];
param[6]=depths[6];
param[7]=depths[7];
#if (sc_OITCompositingPass)
{
int _9396=((_9371+1)*4)-1;
float _9492=floor((_9382.w*255.0)+0.5);
for (; _9396>=(_9371*4); param[_9396]=(param[_9396]*4)+int(floor(mod(_9492,4.0))),_9492=floor(_9492*0.25),_9396--)
{
}
}
#endif
depths[0]=param[0];
depths[1]=param[1];
depths[2]=param[2];
depths[3]=param[3];
depths[4]=param[4];
depths[5]=param[5];
depths[6]=param[6];
depths[7]=param[7];
int param_1[8];
param_1[0]=param[0];
param_1[1]=param[1];
param_1[2]=param[2];
param_1[3]=param[3];
param_1[4]=param[4];
param_1[5]=param[5];
param_1[6]=param[6];
param_1[7]=param[7];
#if (sc_OITCompositingPass)
{
int _9401=((_9371+1)*4)-1;
float _9491=floor((_9382.z*255.0)+0.5);
for (; _9401>=(_9371*4); param_1[_9401]=(param_1[_9401]*4)+int(floor(mod(_9491,4.0))),_9491=floor(_9491*0.25),_9401--)
{
}
}
#endif
depths[0]=param_1[0];
depths[1]=param_1[1];
depths[2]=param_1[2];
depths[3]=param_1[3];
depths[4]=param_1[4];
depths[5]=param_1[5];
depths[6]=param_1[6];
depths[7]=param_1[7];
int param_2[8];
param_2[0]=param_1[0];
param_2[1]=param_1[1];
param_2[2]=param_1[2];
param_2[3]=param_1[3];
param_2[4]=param_1[4];
param_2[5]=param_1[5];
param_2[6]=param_1[6];
param_2[7]=param_1[7];
#if (sc_OITCompositingPass)
{
int _9406=((_9371+1)*4)-1;
float _9490=floor((_9382.y*255.0)+0.5);
for (; _9406>=(_9371*4); param_2[_9406]=(param_2[_9406]*4)+int(floor(mod(_9490,4.0))),_9490=floor(_9490*0.25),_9406--)
{
}
}
#endif
depths[0]=param_2[0];
depths[1]=param_2[1];
depths[2]=param_2[2];
depths[3]=param_2[3];
depths[4]=param_2[4];
depths[5]=param_2[5];
depths[6]=param_2[6];
depths[7]=param_2[7];
int param_3[8];
param_3[0]=param_2[0];
param_3[1]=param_2[1];
param_3[2]=param_2[2];
param_3[3]=param_2[3];
param_3[4]=param_2[4];
param_3[5]=param_2[5];
param_3[6]=param_2[6];
param_3[7]=param_2[7];
#if (sc_OITCompositingPass)
{
int _9411=((_9371+1)*4)-1;
float _9489=floor((_9382.x*255.0)+0.5);
for (; _9411>=(_9371*4); param_3[_9411]=(param_3[_9411]*4)+int(floor(mod(_9489,4.0))),_9489=floor(_9489*0.25),_9411--)
{
}
}
#endif
depths[0]=param_3[0];
depths[1]=param_3[1];
depths[2]=param_3[2];
depths[3]=param_3[3];
depths[4]=param_3[4];
depths[5]=param_3[5];
depths[6]=param_3[6];
depths[7]=param_3[7];
int param_4[8];
param_4[0]=param_3[0];
param_4[1]=param_3[1];
param_4[2]=param_3[2];
param_4[3]=param_3[3];
param_4[4]=param_3[4];
param_4[5]=param_3[5];
param_4[6]=param_3[6];
param_4[7]=param_3[7];
#if (sc_OITCompositingPass)
{
int _9422=((_9371+1)*4)-1;
float _9488=floor((_9389.w*255.0)+0.5);
for (; _9422>=(_9371*4); param_4[_9422]=(param_4[_9422]*4)+int(floor(mod(_9488,4.0))),_9488=floor(_9488*0.25),_9422--)
{
}
}
#endif
depths[0]=param_4[0];
depths[1]=param_4[1];
depths[2]=param_4[2];
depths[3]=param_4[3];
depths[4]=param_4[4];
depths[5]=param_4[5];
depths[6]=param_4[6];
depths[7]=param_4[7];
int param_5[8];
param_5[0]=param_4[0];
param_5[1]=param_4[1];
param_5[2]=param_4[2];
param_5[3]=param_4[3];
param_5[4]=param_4[4];
param_5[5]=param_4[5];
param_5[6]=param_4[6];
param_5[7]=param_4[7];
#if (sc_OITCompositingPass)
{
int _9427=((_9371+1)*4)-1;
float _9487=floor((_9389.z*255.0)+0.5);
for (; _9427>=(_9371*4); param_5[_9427]=(param_5[_9427]*4)+int(floor(mod(_9487,4.0))),_9487=floor(_9487*0.25),_9427--)
{
}
}
#endif
depths[0]=param_5[0];
depths[1]=param_5[1];
depths[2]=param_5[2];
depths[3]=param_5[3];
depths[4]=param_5[4];
depths[5]=param_5[5];
depths[6]=param_5[6];
depths[7]=param_5[7];
int param_6[8];
param_6[0]=param_5[0];
param_6[1]=param_5[1];
param_6[2]=param_5[2];
param_6[3]=param_5[3];
param_6[4]=param_5[4];
param_6[5]=param_5[5];
param_6[6]=param_5[6];
param_6[7]=param_5[7];
#if (sc_OITCompositingPass)
{
int _9432=((_9371+1)*4)-1;
float _9486=floor((_9389.y*255.0)+0.5);
for (; _9432>=(_9371*4); param_6[_9432]=(param_6[_9432]*4)+int(floor(mod(_9486,4.0))),_9486=floor(_9486*0.25),_9432--)
{
}
}
#endif
depths[0]=param_6[0];
depths[1]=param_6[1];
depths[2]=param_6[2];
depths[3]=param_6[3];
depths[4]=param_6[4];
depths[5]=param_6[5];
depths[6]=param_6[6];
depths[7]=param_6[7];
int param_7[8];
param_7[0]=param_6[0];
param_7[1]=param_6[1];
param_7[2]=param_6[2];
param_7[3]=param_6[3];
param_7[4]=param_6[4];
param_7[5]=param_6[5];
param_7[6]=param_6[6];
param_7[7]=param_6[7];
#if (sc_OITCompositingPass)
{
int _9437=((_9371+1)*4)-1;
float _9485=floor((_9389.x*255.0)+0.5);
for (; _9437>=(_9371*4); param_7[_9437]=(param_7[_9437]*4)+int(floor(mod(_9485,4.0))),_9485=floor(_9485*0.25),_9437--)
{
}
}
#endif
depths[0]=param_7[0];
depths[1]=param_7[1];
depths[2]=param_7[2];
depths[3]=param_7[3];
depths[4]=param_7[4];
depths[5]=param_7[5];
depths[6]=param_7[6];
depths[7]=param_7[7];
int param_8[8];
param_8[0]=alphas[0];
param_8[1]=alphas[1];
param_8[2]=alphas[2];
param_8[3]=alphas[3];
param_8[4]=alphas[4];
param_8[5]=alphas[5];
param_8[6]=alphas[6];
param_8[7]=alphas[7];
#if (sc_OITCompositingPass)
{
int _9462=((_9371+1)*4)-1;
float _9484=floor((_9446.w*255.0)+0.5);
for (; _9462>=(_9371*4); param_8[_9462]=(param_8[_9462]*4)+int(floor(mod(_9484,4.0))),_9484=floor(_9484*0.25),_9462--)
{
}
}
#endif
alphas[0]=param_8[0];
alphas[1]=param_8[1];
alphas[2]=param_8[2];
alphas[3]=param_8[3];
alphas[4]=param_8[4];
alphas[5]=param_8[5];
alphas[6]=param_8[6];
alphas[7]=param_8[7];
int param_9[8];
param_9[0]=param_8[0];
param_9[1]=param_8[1];
param_9[2]=param_8[2];
param_9[3]=param_8[3];
param_9[4]=param_8[4];
param_9[5]=param_8[5];
param_9[6]=param_8[6];
param_9[7]=param_8[7];
#if (sc_OITCompositingPass)
{
int _9467=((_9371+1)*4)-1;
float _9483=floor((_9446.z*255.0)+0.5);
for (; _9467>=(_9371*4); param_9[_9467]=(param_9[_9467]*4)+int(floor(mod(_9483,4.0))),_9483=floor(_9483*0.25),_9467--)
{
}
}
#endif
alphas[0]=param_9[0];
alphas[1]=param_9[1];
alphas[2]=param_9[2];
alphas[3]=param_9[3];
alphas[4]=param_9[4];
alphas[5]=param_9[5];
alphas[6]=param_9[6];
alphas[7]=param_9[7];
int param_10[8];
param_10[0]=param_9[0];
param_10[1]=param_9[1];
param_10[2]=param_9[2];
param_10[3]=param_9[3];
param_10[4]=param_9[4];
param_10[5]=param_9[5];
param_10[6]=param_9[6];
param_10[7]=param_9[7];
#if (sc_OITCompositingPass)
{
int _9472=((_9371+1)*4)-1;
float _9482=floor((_9446.y*255.0)+0.5);
for (; _9472>=(_9371*4); param_10[_9472]=(param_10[_9472]*4)+int(floor(mod(_9482,4.0))),_9482=floor(_9482*0.25),_9472--)
{
}
}
#endif
alphas[0]=param_10[0];
alphas[1]=param_10[1];
alphas[2]=param_10[2];
alphas[3]=param_10[3];
alphas[4]=param_10[4];
alphas[5]=param_10[5];
alphas[6]=param_10[6];
alphas[7]=param_10[7];
int param_11[8];
param_11[0]=param_10[0];
param_11[1]=param_10[1];
param_11[2]=param_10[2];
param_11[3]=param_10[3];
param_11[4]=param_10[4];
param_11[5]=param_10[5];
param_11[6]=param_10[6];
param_11[7]=param_10[7];
#if (sc_OITCompositingPass)
{
int _9477=((_9371+1)*4)-1;
float _9481=floor((_9446.x*255.0)+0.5);
for (; _9477>=(_9371*4); param_11[_9477]=(param_11[_9477]*4)+int(floor(mod(_9481,4.0))),_9481=floor(_9481*0.25),_9477--)
{
}
}
#endif
alphas[0]=param_11[0];
alphas[1]=param_11[1];
alphas[2]=param_11[2];
alphas[3]=param_11[3];
alphas[4]=param_11[4];
alphas[5]=param_11[5];
alphas[6]=param_11[6];
alphas[7]=param_11[7];
}
continue;
}
mediump vec4 _7101=texture2D(sc_OITFilteredDepthBoundsTexture,_4921);
int _9377;
#if (sc_SkinBonesCount>0)
{
float _7111=(1.0-_7101.x)*1000.0;
_9377=int(clamp(((_7111+getDepthOrderingEpsilon())-_7111)/((_7101.y*1000.0)-_7111),0.0,1.0)*65535.0);
}
#else
{
_9377=0;
}
#endif
float _7148=(1.0-_7101.x)*1000.0;
vec4 _9375;
_9375=materialColor*materialColor.w;
vec4 _9520;
for (int _9374=0; _9374<8; _9375=_9520,_9374++)
{
int _5158=depths[_9374];
int _5161=int(clamp((viewSpaceDepth()-_7148)/((_7101.y*1000.0)-_7148),0.0,1.0)*65535.0)-_9377;
bool _5162=_5158<_5161;
bool _5169;
if (_5162)
{
_5169=depths[_9374]>0;
}
else
{
_5169=_5162;
}
if (_5169)
{
vec3 _5180=_9375.xyz*(1.0-(float(alphas[_9374])*0.00392157));
_9520=vec4(_5180.x,_5180.y,_5180.z,_9375.w);
}
else
{
_9520=_9375;
}
continue;
}
vec4 param_12=_9375;
sc_writeFragData0(param_12);
#if (sc_OITMaxLayersVisualizeLayerCount)
{
discard;
}
#endif
}
#endif
}

float packValue(inout int value)
{
#if (sc_OITDepthGatherPass)
{
int _4735=value;
value/=4;
return floor(floor(mod(float(_4735),4.0))*64.0)*0.00392157;
}
#else
{
return 0.0;
}
#endif
}

void oitDepthGather(vec4 materialColor)
{
#if (sc_OITDepthGatherPass)
{
vec2 _4791=getScreenUV();
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture2D(sc_OITFrontDepthTexture,_4791).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
mediump vec4 _7171=texture2D(sc_OITFilteredDepthBoundsTexture,_4791);
float _7181=(1.0-_7171.x)*1000.0;
int param=int(clamp((viewSpaceDepth()-_7181)/((_7171.y*1000.0)-_7181),0.0,1.0)*65535.0);
float _4829=packValue(param);
vec4 _9164=_9367;
_9164.x=_4829;
int param_1=param;
float _4834=packValue(param_1);
vec4 _9166=_9164;
_9166.y=_4834;
int param_2=param_1;
float _4839=packValue(param_2);
vec4 _9168=_9166;
_9168.z=_4839;
int param_3=param_2;
float _4844=packValue(param_3);
vec4 _9170=_9168;
_9170.w=_4844;
int param_4=param_3;
float _4850=packValue(param_4);
vec4 _9172=_9367;
_9172.x=_4850;
int param_5=param_4;
float _4855=packValue(param_5);
vec4 _9174=_9172;
_9174.y=_4855;
int param_6=param_5;
float _4860=packValue(param_6);
vec4 _9176=_9174;
_9176.z=_4860;
int param_7=param_6;
float _4865=packValue(param_7);
vec4 _9178=_9176;
_9178.w=_4865;
int param_8=int(materialColor.w*255.0);
float _4871=packValue(param_8);
vec4 _9180=_9367;
_9180.x=_4871;
int param_9=param_8;
float _4876=packValue(param_9);
vec4 _9182=_9180;
_9182.y=_4876;
int param_10=param_9;
float _4881=packValue(param_10);
vec4 _9184=_9182;
_9184.z=_4881;
int param_11=param_10;
float _4886=packValue(param_11);
vec4 _9186=_9184;
_9186.w=_4886;
vec4 param_12=_9178;
sc_writeFragData0(param_12);
vec4 param_13=_9170;
sc_writeFragData1(param_13);
vec4 param_14=_9186;
sc_writeFragData2(param_14);
#if (sc_OITMaxLayersVisualizeLayerCount)
{
vec4 param_15=vec4(0.00392157,0.0,0.0,0.0);
sc_writeFragData2(param_15);
}
#endif
}
#endif
}

void main()
{
bool _6251=overrideTimeEnabled==1;
float _9269;
if (_6251)
{
_9269=overrideTimeElapsed;
}
else
{
_9269=sc_Time.x;
}
float _9270;
if (_6251)
{
_9270=overrideTimeDelta;
}
else
{
_9270=sc_Time.y;
}
float param=0.0;
vec4 param_1=vec4(0.0);
vec4 param_2=vec4(0.0);
ssGlobals param_4=ssGlobals(_9269,_9270,_9273,varPackedTex.xy);
vec4 param_3;
Node15_If_else(param,param_1,param_2,param_3,param_4);
vec4 _6287=param_3;
#if (sc_BlendMode_AlphaTest)
{
if (_6287.w<alphaTestThreshold)
{
discard;
}
}
#endif
#if (ENABLE_STIPPLE_PATTERN_TEST)
{
if (_6287.w<((mod(dot(floor(mod(gl_FragCoord.xy,vec2(4.0))),vec2(4.0,1.0))*9.0,16.0)+1.0)*0.0588235))
{
discard;
}
}
#endif
vec4 param_5=_6287;
vec4 _6295=ngsPixelShader(param_5);
vec4 _6298=max(_6295,vec4(0.0));
vec4 param_6=_6298;
sc_writeFragData0(param_6);
vec4 _6485=clamp(_6298,vec4(0.0),vec4(1.0));
#if (sc_OITDepthBoundsPass)
{
#if (sc_OITDepthBoundsPass)
{
float _6545=clamp(viewSpaceDepth()*0.001,0.0,1.0);
vec4 _6540=vec4(max(0.0,1.00392-_6545),min(1.0,_6545+0.00392157),0.0,0.0);
sc_writeFragData0(_6540);
}
#endif
}
#else
{
#if (sc_OITDepthPrepass)
{
vec4 _6535=vec4(1.0);
sc_writeFragData0(_6535);
}
#else
{
#if (sc_OITDepthGatherPass)
{
vec4 _6477=_6485;
oitDepthGather(_6477);
}
#else
{
#if (sc_OITCompositingPass)
{
vec4 _6478=_6485;
oitCompositing(_6478);
}
#else
{
#if (sc_OITFrontLayerPass)
{
#if (sc_OITFrontLayerPass)
{
if (abs(gl_FragCoord.z-texture2D(sc_OITFrontDepthTexture,getScreenUV()).x)>getFrontLayerZTestEpsilon())
{
discard;
}
vec4 _6513=_6485;
sc_writeFragData0(_6513);
}
#endif
}
#else
{
vec4 _6480=_6485;
sc_writeFragData0(_6480);
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
