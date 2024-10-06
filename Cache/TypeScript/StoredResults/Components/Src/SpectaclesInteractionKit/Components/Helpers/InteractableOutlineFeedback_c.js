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
// @input Asset.Material targetOutlineMaterial {"hint":"This is the material that will provide the mesh outline"}
checkUndefined("targetOutlineMaterial", []);
// @input vec4 hoveringColor = "{1, 1, 0.04, 1}" {"hint":"This is the colour of the outline when hovered", "widget":"color"}
checkUndefined("hoveringColor", []);
// @input vec4 activatingColor = "{1, 1, 1, 1}" {"hint":"This is the colour of the outline when pinched", "widget":"color"}
checkUndefined("activatingColor", []);
// @input float outlineWeight = 0.25 {"hint":"This is the thickness of the outline"}
checkUndefined("outlineWeight", []);
// @input Component.RenderMeshVisual[] meshVisuals {"hint":"These are the meshes that will be outlined on pinch/hover"}
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
var Module = require("../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Helpers/InteractableOutlineFeedback");
Object.setPrototypeOf(script, Module.InteractableOutlineFeedback.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
