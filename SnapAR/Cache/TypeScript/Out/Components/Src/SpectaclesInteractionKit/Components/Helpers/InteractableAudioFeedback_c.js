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
// @input Asset.AudioTrackAsset hoverAudioTrack {"hint":"This sound will play when the Interactable is hovered"}
// @input Asset.AudioTrackAsset triggerStartAudioTrack {"hint":"This sound will play when starting the trigger the Interactable"}
// @input Asset.AudioTrackAsset triggerEndAudioTrack {"hint":"This sound will play when ending the trigger of the Interactable"}
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
var Module = require("../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/Helpers/InteractableAudioFeedback");
Object.setPrototypeOf(script, Module.InteractableAudioFeedback.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
