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
// @ui {"widget":"group_start", "label":"Frame Defaults"}
// @input CursorController worldCursor
// @ui {"widget":"group_end"}
// @ui {"widget":"label", "label":""}
// @ui {"widget":"group_start", "label":"Frame Settings"}
// @input bool autoShowHide = true
checkUndefined("autoShowHide", []);
// @input vec2 innerSize = "{32,32}"
checkUndefined("innerSize", []);
// @input float border = 7
checkUndefined("border", []);
// @input vec2 constantPadding = "{0,0}" {"hint":"In world units (cm), stays constant through scaling"}
checkUndefined("constantPadding", []);
// @input bool allowScaling = true
checkUndefined("allowScaling", []);
// @input bool autoScaleContent = true
checkUndefined("autoScaleContent", []);
// @input bool isContentInteractable = false
checkUndefined("isContentInteractable", []);
// @input bool allowTranslation = true
checkUndefined("allowTranslation", []);
// @ui {"widget":"group_end"}
// @ui {"widget":"label", "label":""}
// @ui {"widget":"group_start", "label":"Min/Max Size"}
// @input vec2 minimumSize = "{10,10}" {"hint":"In world units (cm)"}
checkUndefined("minimumSize", []);
// @input vec2 maximumSize = "{150,150}" {"hint":"In world units (cm)"}
checkUndefined("maximumSize", []);
// @ui {"widget":"group_end"}
// @ui {"widget":"label", "label":""}
// @ui {"widget":"group_start", "label":"Billboarding"}
// @input bool useBillboarding
checkUndefined("useBillboarding", []);
// @input bool xOnTranslate = false {"showIf":"useBillboarding"}
checkUndefined("xOnTranslate", [["useBillboarding",true]]);
// @input bool xAlways = false {"showIf":"xOnTranslate"}
checkUndefined("xAlways", [["xOnTranslate",true]]);
// @input bool yOnTranslate = false {"showIf":"useBillboarding"}
checkUndefined("yOnTranslate", [["useBillboarding",true]]);
// @input bool yAlways = false {"showIf":"yOnTranslate"}
checkUndefined("yAlways", [["yOnTranslate",true]]);
// @ui {"widget":"group_end"}
// @ui {"widget":"label", "label":""}
// @ui {"widget":"group_start", "label":"Snapping"}
// @input bool useSnapping = false {"hint":"Use Snapping Behaviors"}
checkUndefined("useSnapping", []);
// @input bool itemSnapping = false {"hint":"Container to Container Snapping", "showIf":"useSnapping"}
checkUndefined("itemSnapping", [["useSnapping",true]]);
// @input bool worldSnapping = false {"hint":"Container to World Snapping", "showIf":"useSnapping"}
checkUndefined("worldSnapping", [["useSnapping",true]]);
// @ui {"widget":"group_end"}
// @ui {"widget":"label", "label":""}
// @ui {"widget":"group_start", "label":"Follow Behavior"}
// @input bool showFollowButton
checkUndefined("showFollowButton", []);
// @input bool useFOVFollow = false {"label":"Front Follow Behavior", "showIf":"showFollowButton"}
checkUndefined("useFOVFollow", [["showFollowButton",true]]);
// @input bool isFollowing = false {"showIf":"useFOVFollow"}
checkUndefined("isFollowing", [["useFOVFollow",true]]);
// @ui {"widget":"group_end"}
// @ui {"widget":"label", "label":""}
// @ui {"widget":"group_start", "label":"Close Button"}
// @input bool showCloseButton = true
checkUndefined("showCloseButton", []);
// @ui {"widget":"group_end"}
// @ui {"widget":"separator"}
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
var Module = require("../../../../../../Modules/Src/Src/SpectaclesInteractionKit/Components/UI/ContainerFrame/ContainerFrame");
Object.setPrototypeOf(script, Module.ContainerFrame.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
