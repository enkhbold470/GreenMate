if (script.onAwake) {
	script.onAwake();
	return;
};
function checkUndefined(property, showIfData){
   for (var i = 0; i < showIfData.length; i++){
       if (showIfData[i][0] && script[showIfData[i][0]] != showIfData[i][1]){
           return;
       }
   }
   if (script[property] == undefined){
      throw new Error('Input ' + property + ' was not provided for the object ' + script.getSceneObject().name);
   }
}
// @ui {"widget":"group_start", "label":"Interactable Manipulation"}
// @input SceneObject manipulateRootSceneObject {"hint":"Root SceneObject of the set of SceneObjects to manipulate. If left blank, this script's SceneObject will be treated as the root. The root's transform will be modified by this script."}
// @input float minimumScaleFactor = 0.25 {"hint":"The smallest this object can scale down to, relative to its original scale. A value of 0.5 means it cannot scale smaller than 50% of its current size", "widget":"slider", "min":0, "max":1, "step":0.05}
checkUndefined("minimumScaleFactor", []);
// @input float maximumScaleFactor = 20 {"hint":"The largest this object can scale up to, relative to its original scale. A value of 2 means it cannot scale larger than twice its current size", "widget":"slider", "min":1, "max":20, "step":0.5}
checkUndefined("maximumScaleFactor", []);
// @input bool enableTranslation = true
checkUndefined("enableTranslation", []);
// @input bool enableRotation = true
checkUndefined("enableRotation", []);
// @input bool enableScale = true
checkUndefined("enableScale", []);
// @input bool enableStretchZ = true {"hint":"Toggles forward stretch for manipulating objects from afar."}
checkUndefined("enableStretchZ", []);
// @input bool showStretchZProperties = false {"showIf":"enableStretchZ", "showIfValue":true}
checkUndefined("showStretchZProperties", [["enableStretchZ",true]]);
// @input float zStretchFactorMin = 1.0 {"hint":"Z multiplier on the near end of the stretch scale", "showIf":"showStretchZProperties", "showIfValue":true}
checkUndefined("zStretchFactorMin", [["showStretchZProperties",true]]);
// @input float zStretchFactorMax = 12.0 {"hint":"Z multiplier on the far end of the stretch scale", "showIf":"showStretchZProperties", "showIfValue":true}
checkUndefined("zStretchFactorMax", [["showStretchZProperties",true]]);
// @input bool useFilter = true {"hint":"Apply filtering to smooth manipulation"}
checkUndefined("useFilter", []);
// @input bool showFilterProperties = false {"showIf":"useFilter", "showIfValue":true}
checkUndefined("showFilterProperties", [["useFilter",true]]);
// @input float minCutoff = 2 {"showIf":"showFilterProperties", "showIfValue":true}
checkUndefined("minCutoff", [["showFilterProperties",true]]);
// @input float beta = 0.015 {"showIf":"showFilterProperties", "showIfValue":true}
checkUndefined("beta", [["showFilterProperties",true]]);
// @input float dcutoff = 1 {"showIf":"showFilterProperties", "showIfValue":true}
checkUndefined("dcutoff", [["showFilterProperties",true]]);
// @input bool showTranslationProperties = false
checkUndefined("showTranslationProperties", []);
// @input bool _enableXTranslation = true {"hint":"Enable translation along the world's X-axis.", "showIf":"showTranslationProperties", "showIfValue":true}
checkUndefined("_enableXTranslation", [["showTranslationProperties",true]]);
// @input bool _enableYTranslation = true {"hint":"Enable translation along the world's Y-axis.", "showIf":"showTranslationProperties", "showIfValue":true}
checkUndefined("_enableYTranslation", [["showTranslationProperties",true]]);
// @input bool _enableZTranslation = true {"hint":"Enable translation along the world's Z-axis.", "showIf":"showTranslationProperties", "showIfValue":true}
checkUndefined("_enableZTranslation", [["showTranslationProperties",true]]);
// @input bool showRotationProperties = false
checkUndefined("showRotationProperties", []);
// @input string _rotationAxis = 'All' {"hint":"Enable rotation about all axes or a single world axis (x,y,z) when using to two hands.", "widget":"combobox", "values":[{"label":"All", "value":"All"}, {"label":"X", "value":"X"}, {"label":"Y", "value":"Y"}, {"label":"Z", "value":"Z"}], "showIf":"showRotationProperties", "showIfValue":true}
checkUndefined("_rotationAxis", [["showRotationProperties",true]]);
// @ui {"widget":"group_end"}
var scriptPrototype = Object.getPrototypeOf(script);
if (!global.BaseScriptComponent){
   function BaseScriptComponent(){}
   global.BaseScriptComponent = BaseScriptComponent;
   global.BaseScriptComponent.prototype = scriptPrototype;
   global.BaseScriptComponent.prototype.__initialize = function(){};
   global.BaseScriptComponent.getTypeName = function(){
       throw new Error("Cannot get type name from the class, not decorated with @component");
   }
}
var Module = require("../../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Interaction/InteractableManipulation/InteractableManipulation");
Object.setPrototypeOf(script, Module.InteractableManipulation.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
