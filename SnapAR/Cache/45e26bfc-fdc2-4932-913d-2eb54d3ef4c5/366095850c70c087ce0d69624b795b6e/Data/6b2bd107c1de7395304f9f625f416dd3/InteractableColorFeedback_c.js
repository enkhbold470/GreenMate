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
// @input vec4 defaultColor = "{0.28, 0.28, 0.28, 1}" {"widget":"color"}
checkUndefined("defaultColor", []);
// @input vec4 hoverColor = "{0.28, 0.28, 0.28, 1}" {"widget":"color"}
checkUndefined("hoverColor", []);
// @input vec4 pinchedColor = "{0.46, 0.46, 0.46, 1}" {"widget":"color"}
checkUndefined("pinchedColor", []);
// @input vec4 disabledColor = "{1, 1, 1, 0}" {"widget":"color"}
checkUndefined("disabledColor", []);
// @input Component.RenderMeshVisual[] meshVisuals {"hint":"The meshes which will have their baseColor changed on pinch/hover events"}
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
var Module = require("../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Helpers/InteractableColorFeedback");
Object.setPrototypeOf(script, Module.InteractableColorFeedback.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
