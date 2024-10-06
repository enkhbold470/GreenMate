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
// @input bool showDebug = false {"hint":"The components under DebugElements will be hidden on start if showDebug is unchecked."}
checkUndefined("showDebug", []);
// @input SceneObject[] debugElements
checkUndefined("debugElements", []);
// @ui {"widget":"group_start", "label":"Slider Knob"}
// @input Component.RenderMeshVisual sliderKnobMesh {"label":"Mesh"}
checkUndefined("sliderKnobMesh", []);
// @input Asset.Material sliderKnobIdleMaterial {"label":"Idle Material"}
checkUndefined("sliderKnobIdleMaterial", []);
// @input Asset.Material sliderKnobSelectedMaterial {"label":"Selected Material"}
checkUndefined("sliderKnobSelectedMaterial", []);
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"Slider Track"}
// @input Component.RenderMeshVisual sliderTrackMesh
checkUndefined("sliderTrackMesh", []);
// @input Asset.Material sliderTrackMaterial
checkUndefined("sliderTrackMaterial", []);
// @ui {"widget":"group_end"}
// @input Asset.AudioTrackAsset sliderProgressAudio
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
var Module = require("../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Helpers/SliderFeedback");
Object.setPrototypeOf(script, Module.SliderFeedback.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
