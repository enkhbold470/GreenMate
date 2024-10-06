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
// @input bool _debugDrawEnabled = false
checkUndefined("_debugDrawEnabled", []);
// @input bool enableHorizontalScroll = false
checkUndefined("enableHorizontalScroll", []);
// @input bool enableVerticalScroll = true
checkUndefined("enableVerticalScroll", []);
// @input bool _enableScrollInertia = true
checkUndefined("_enableScrollInertia", []);
// @input bool enableScrollLimit = true
checkUndefined("enableScrollLimit", []);
// @input float _scrollLimit = 0.3 {"widget":"slider", "min":0, "max":1, "step":0.01}
checkUndefined("_scrollLimit", []);
// @input vec2 scrollAreaBounds = "{1, 1}"
checkUndefined("scrollAreaBounds", []);
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
var Module = require("../../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/UI/ScrollView/ScrollView");
Object.setPrototypeOf(script, Module.ScrollView.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
