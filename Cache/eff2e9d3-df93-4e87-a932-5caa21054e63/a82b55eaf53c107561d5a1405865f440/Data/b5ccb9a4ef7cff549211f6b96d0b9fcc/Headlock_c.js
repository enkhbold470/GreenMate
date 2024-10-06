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
// @ui {"widget":"group_start", "label":"Headlock"}
// @input float _distance = 50 {"hint":"How far away the target will be from the camera"}
checkUndefined("_distance", []);
// @ui {"widget":"group_start", "label":"Head Translation"}
// @input bool _xzEnabled = true {"hint":"If the camera will follow when the user moves their head along XZ-plane"}
checkUndefined("_xzEnabled", []);
// @input float _xzEasing = 1 {"hint":"How fast the camera will follow along the XZ-plane, 0.1 for delayed follow, 1 for instant follow."}
checkUndefined("_xzEasing", []);
// @input bool _yEnabled = true {"hint":"If the camera will follow when the user moves their head along Y-axis"}
checkUndefined("_yEnabled", []);
// @input float _yEasing = 1 {"hint":"How fast the camera will follow along the Y-axis, 0.1 for delayed follow, 1 for instant follow."}
checkUndefined("_yEasing", []);
// @input float _translationBuffer = 0 {"hint":"The magnitude of change needed to activate a translation for the target to follow the camera."}
checkUndefined("_translationBuffer", []);
// @ui {"widget":"group_end"}
// @ui {"widget":"group_start", "label":"Head Rotation"}
// @input bool _lockedPitch = true {"hint":"If the camera will NOT follow when the user moves their head along the pitch-axis (looking up/down)"}
checkUndefined("_lockedPitch", []);
// @input float _pitchEasing = 1 {"hint":"How fast the camera will follow along the pitch-axis, 0.1 for delayed follow, 1 for instant follow."}
checkUndefined("_pitchEasing", []);
// @input float _pitchOffsetDegrees = 0 {"hint":"How many degrees of offset from the center point should the target sit"}
checkUndefined("_pitchOffsetDegrees", []);
// @input float _pitchBufferDegrees = 0 {"hint":"How many degrees of leeway along each direction (up/down) before change starts to occur"}
checkUndefined("_pitchBufferDegrees", []);
// @input bool _lockedYaw = true {"hint":"If the camera will follow when the user moves their head along the yaw-axis (looking left/right)"}
checkUndefined("_lockedYaw", []);
// @input float _yawEasing = 1 {"hint":"How fast the camera will follow along the yaw-axis, 0.1 for delayed follow, 1 for instant follow."}
checkUndefined("_yawEasing", []);
// @input float _yawOffsetDegrees = 0 {"hint":"How many degrees of offset from the center point should the target sit"}
checkUndefined("_yawOffsetDegrees", []);
// @input float _yawBufferDegrees = 0 {"hint":"How many degrees of leeway along each direction (left/right) before change starts to occur"}
checkUndefined("_yawBufferDegrees", []);
// @ui {"widget":"group_end"}
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
var Module = require("../../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Interaction/Headlock/Headlock");
Object.setPrototypeOf(script, Module.Headlock.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
