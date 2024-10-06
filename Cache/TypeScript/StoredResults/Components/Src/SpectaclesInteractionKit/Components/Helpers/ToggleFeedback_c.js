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
// @input Asset.Material toggledOffMaterial
checkUndefined("toggledOffMaterial", []);
// @input Asset.Material toggledOffSelectMaterial
checkUndefined("toggledOffSelectMaterial", []);
// @input Asset.Material toggledOnMaterial
checkUndefined("toggledOnMaterial", []);
// @input Asset.Material toggledOnSelectMaterial
checkUndefined("toggledOnSelectMaterial", []);
// @input Asset.Material disabledMaterial
checkUndefined("disabledMaterial", []);
// @input Component.RenderMeshVisual[] meshVisuals
checkUndefined("meshVisuals", []);
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
var Module = require("../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Helpers/ToggleFeedback");
Object.setPrototypeOf(script, Module.ToggleFeedback.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
