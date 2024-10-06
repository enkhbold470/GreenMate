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
// @input Component.RenderMeshVisual meshVisual {"hint":"The mesh visual to modify into an extendable capsule."}
checkUndefined("meshVisual", []);
// @input float capsuleLength = 10.0 {"hint":"The length of the cylindric section of the capsule (not including the end caps)."}
checkUndefined("capsuleLength", []);
// @input float radius = 1.0 {"hint":"The radius of the end caps and the radius of the cylindric section."}
checkUndefined("radius", []);
// @input int radianStepCount = 16 {"hint":"The number of points per circle in the mesh. Increase for a higher poly-count mesh."}
checkUndefined("radianStepCount", []);
// @input int cylinderStepCount = 16 {"hint":"The number of circles in the cylinder of the mesh. Increase for a higher poly-count mesh."}
checkUndefined("cylinderStepCount", []);
// @input int endXStepCount = 32 {"hint":"The number of circles in the end cap of the capsule of the mesh. Increase for a higher poly-count mesh."}
checkUndefined("endXStepCount", []);
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
var Module = require("../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Helpers/CapsuleMeshCustomizer");
Object.setPrototypeOf(script, Module.CapsuleMeshCustomizer.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
