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
// @input float _minValue = 0 {"hint":"The minimum numeric value of the slider"}
checkUndefined("_minValue", []);
// @input float _maxValue = 1 {"hint":"The maximum numeric value of the slider"}
checkUndefined("_maxValue", []);
// @input float startValue = 0.5 {"hint":"The initial numeric value of the slider"}
checkUndefined("startValue", []);
// @input bool stepBehavior = false {"hint":"Enable this to change the slider's value in steps rather than continuously"}
checkUndefined("stepBehavior", []);
// @input float _stepSize = 0 {"hint":"The size of the steps that the slider's value will be changed in.", "showIf":"stepBehavior", "showIfValue":true}
checkUndefined("_stepSize", [["stepBehavior",true]]);
// @input float toggleDuration = 0.2 {"hint":"The duration of the toggle animation in seconds.", "showIf":"isToggleable", "showIfValue":true}
checkUndefined("toggleDuration", [["isToggleable",true]]);
// @ui {"widget":"separator"}
// @input SceneObject sliderMin {"hint":"The position of the slider knob when the minimum value is reached."}
checkUndefined("sliderMin", []);
// @input SceneObject sliderMax {"hint":"The position of the slider knob when the maximum value is reached."}
checkUndefined("sliderMax", []);
// @input SceneObject _sliderKnob {"hint":"The SceneObject representing the knob of the slider which will be moved along the path between the positions provided by sliderMin and sliderMax when the value is updated. Please ensure the SceneObject has an Interactable component attached."}
checkUndefined("_sliderKnob", []);
// @ui {"widget":"separator"}
// @input bool editEventCallbacks = false {"hint":"Enable this to add functions from another script to this component's callback events"}
checkUndefined("editEventCallbacks", []);
// @ui {"widget":"group_start", "label":"On Hover Enter Callbacks", "showIf":"editEventCallbacks"}
// @input Component.ScriptComponent customFunctionForOnHoverEnter {"hint":"The script containing functions to be called on hover enter"}
// @input string[] onHoverEnterFunctionNames {"hint":"The names for the functions on the provided script, to be called on hover enter"}
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"On Hover Exit Callbacks", "showIf":"editEventCallbacks"}
// @input Component.ScriptComponent customFunctionForOnHoverExit {"hint":"The script containing functions to be called on hover exit"}
// @input string[] onHoverExitFunctionNames {"hint":"The names for the functions on the provided script, to be called on hover exit"}
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"On Slide Start Callbacks", "showIf":"editEventCallbacks"}
// @input Component.ScriptComponent customFunctionForOnSlideStart {"hint":"The script containing functions to be called on slide start"}
// @input string[] onSlideStartFunctionNames {"hint":"The names for the functions on the provided script, to be called on slide start"}
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"On Slide End Callbacks", "showIf":"editEventCallbacks"}
// @input Component.ScriptComponent customFunctionForOnSlideEnd {"hint":"The script containing functions to be called on slide end"}
// @input string[] onSlideEndFunctionNames {"hint":"The names for the functions on the provided script, to be called on slide end"}
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"On Value Update Callbacks", "showIf":"editEventCallbacks"}
// @input Component.ScriptComponent customFunctionForOnValueUpdate {"hint":"The script containing functions to be called on value update"}
// @input string[] onValueUpdateFunctionNames {"hint":"The names for the functions on the provided script, to be called on value update"}
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"On Min Value Reached Callbacks", "showIf":"editEventCallbacks"}
// @input Component.ScriptComponent customFunctionForOnMinValueReached {"hint":"The script containing functions to be called on min value reached"}
// @input string[] onMinValueReachedFunctionNames {"hint":"The names for the functions on the provided script, to be called when minimum value is reached"}
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"On Max Value Reached Callbacks", "showIf":"editEventCallbacks"}
// @input Component.ScriptComponent customFunctionForOnMaxValueReached {"hint":"The script containing functions to be called on max value reached"}
// @input string[] onMaxValueReachedFunctionNames {"hint":"The names for the functions on the provided script, to be called when maximum value is reached"}
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
var Module = require("../../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/UI/Slider/Slider");
Object.setPrototypeOf(script, Module.Slider.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
