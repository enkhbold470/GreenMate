// SendDataToVFX.js
// Version: 0.0.2
// Event: Select on the script
// Description: The script helps you to easily send data to the VFX graph

//@ui {"widget":"label", "label":""}
//@ui {"widget":"label", "label":"Use the scripts event to select the trigger type"}
//@ui {"widget":"label", "label":""}
// @ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":"Action"}
// @input string action = "targetPosition" {"label": "Type", "widget":"combobox", "values":[{"label":"Send Target Position", "value":"targetPosition"}, {"label":"Send Target Scale", "value":"targetScale"}, {"label":"Send Target Rotation", "value":"targetRotation"}, {"label":"Send Target Direction Vector", "value":"targetDirection"}, {"label":"Send Target Inverted World Transform", "value":"targetInvTrans"}, {"label":"Send Target Mesh Dimension", "value":"meshDimension"}, {"label":"Send Screen Transform Scale", "value":"screenTransScale"}, {"label":"Convert Target ScreenPos to WorldPos", "value":"screenToWorld"}, {"label":"Convert Target WorldPos to ScreenPos", "value":"worldToScreen"}, {"label":"Convert Local Point to World Pos", "value":"localToWorld"}]}
// @input SceneObject targetPosition {"showIf": "action", "showIfValue": "targetPosition", "label": "Target"}
// @input SceneObject targetRotation {"showIf": "action", "showIfValue": "targetRotation", "label": "Target"}
// @input SceneObject targetScale {"showIf": "action", "showIfValue": "targetScale", "label": "Target"}
// @input int directionValue = 0 {"showIf": "action", "showIfValue": "targetDirection", "values": [{"value": 0, "label": "Up"}, {"value": 1, "label": "Down"}, {"value": 2, "label": "Right"}, {"value": 3, "label": "Left"}, {"value": 4, "label": "Forward"}, {"value": 5, "label": "Back"}], "widget": "combobox", "label": "Direction"}
// @input SceneObject targetDirection {"showIf": "action", "showIfValue": "targetDirection", "label": "Target"}
// @input SceneObject targetInvTrans {"showIf": "action", "showIfValue": "targetInvTrans", "label": "Target"}
// @input string dimensionValue = "aabbMin" {"showIf": "action", "showIfValue": "meshDimension", "values": [{"value": "aabbMin", "label": "Min Value (aabbMin)"}, {"value": "aabbMax", "label": "Max Value (aabbMax)"}], "widget": "combobox", "label": "Event Type"}
// @input Component.RenderMeshVisual targetDimension {"showIf": "action", "showIfValue": "meshDimension", "label": "Target"}
// @input Component.ScreenTransform screenToWorldScreenTrans {"showIf": "action", "showIfValue": "screenToWorld", "label": "Target"}
// @input Component.Camera screenToWorldCamera {"showIf": "action", "showIfValue": "screenToWorld", "label": "Camera"}
// @input float desiredModelHeight = 250 {"showIf": "action", "showIfValue": "screenToWorld", "label": "Height"}
// @input SceneObject worldToScreenObject {"showIf": "action", "showIfValue": "worldToScreen", "label": "Target"}
// @input Component.Camera worldToScreenCamera {"showIf": "action", "showIfValue": "worldToScreen", "label": "Camera"}
// @input Component.ScreenTransform localToWorldObj {"showIf": "action", "showIfValue": "localToWorld", "label": "Target"}
// @input Component.ScreenTransform screenTransObj {"showIf": "action", "showIfValue": "screenTransScale", "label": "Target"}
// @input bool debug {"label": "Debug Output Value"}
//@ui {"widget":"group_end"}

// @ui {"widget":"separator"}

//@ui {"widget":"group_start", "label":"VFX"}
// @input Component.VFXComponent vfx {"label": "Component"}
// @input string vfxScriptName {"label": "Property"}
//@ui {"widget":"group_end"}

var propertySets = [
    ["x", "y", "z", "w"],
    ["column0", "column1", "column2", "column3"]
];

var supTypes = ["number", "boolean"];

function debugPrint(message, shouldPrint) {
    if (shouldPrint) {
        print(message);
    }
}

function getValidProperty(inp) {
    if (!script.vfx) {
        debugPrint("Warning, VFX Component is not set", true);
        return null;
    }
    if (!script.vfx.asset) {
        debugPrint("Warning, VFX Component does not contain VFX asset", true);
        return null;
    }
    if (script.vfxScriptName == "") {
        debugPrint("Warning, VFX property name is not set", true);
        return null;
    }
    if (script.vfx.asset.properties[script.vfxScriptName] == undefined) {
        debugPrint("Warning, VFX " + script.vfx.asset.name + " doesn't have an " + script.vfxScriptName + " property", true);
        return null;
    }
    if (!typeIsMatching(inp, script.vfx.asset.properties[script.vfxScriptName])) {
        debugPrint("Warning, VFX " + script.vfx.asset.name + " " + script.vfxScriptName + " property does not match vfx value type", true);
        return null;
    }
    return function (v) {
        script.vfx.asset.properties[script.vfxScriptName] = v;
    };
}


function typeIsMatching(val, prop) {
    var i;
    for (i = 0; i < supTypes.length; i++) {
        if (typeof val == supTypes[i] && typeof prop == supTypes[i]) {
            return true;
        }
    }

    var haveSameProperty = false;
    for (i = 0; i < propertySets.length; i++) {
        for (var j = 0; j < propertySets[i].length; j++) {
            if ((val[propertySets[i][j]] == undefined) == (prop[propertySets[i][j]] == undefined)) {
                if (val[propertySets[i][j]] != undefined) {
                    haveSameProperty = true;
                }
            } else {
                return false;
            }
        }
    }
    return haveSameProperty;
}

function setVfx(value) {
    debugPrint(value, script.debug);
    var property = getValidProperty(value);
    if (property) {
        property(value);
    }
}

function triggerAction() {
    switch (script.action) {
        case "targetPosition":
            triggerTargetPosition();
            break;
        case "targetScale":
            triggerTargetScale();
            break;
        case "targetRotation":
            triggerTargetRotation();
            break;
        case "targetDirection":
            triggerTargetDirection();
            break;
        case "targetInvTrans":
            triggerTargetInvTrans();
            break;
        case "meshDimension":
            triggerMeshDimension();
            break;
        case "screenToWorld":
            triggerScreenToWorld();
            break;
        case "worldToScreen":
            triggerWorldToScreen();
            break;
        case "localToWorld":
            triggerLocalToWorld();
            break;
        case "screenTransScale":
            triggerScreenTransScale();
            break;
    }
}

function triggerTargetPosition() {
    if (!script.targetPosition) {
        return;
    }
    var pos = script.targetPosition.getTransform().getWorldPosition();
    setVfx(pos);
}

function triggerTargetRotation() {
    if (!script.targetRotation) {
        return;
    }
    var rot = script.targetRotation.getTransform().getWorldRotation();
    setVfx(new vec4(rot.w, rot.x, rot.y, rot.z));
}

function triggerTargetDirection() {
    if (!script.targetDirection) {
        return;
    }
    var dir;
    switch (script.directionValue) {
        case 0:
            dir = script.targetDirection.getTransform().up;
            break;
        case 1:
            dir = script.targetDirection.getTransform().down;
            break;
        case 2:
            dir = script.targetDirection.getTransform().right;
            break;
        case 3:
            dir = script.targetDirection.getTransform().left;
            break;
        case 4:
            dir = script.targetDirection.getTransform().forward;
            break;
        case 5:
            dir = script.targetDirection.getTransform().back;
            break;

    }
    setVfx(dir);
}

function triggerTargetInvTrans() {
    if(!script.targetInvTrans) {
        return;
    }
    var invTrans = script.targetInvTrans.getTransform().getInvertedWorldTransform();
    setVfx(invTrans);
}

function triggerTargetScale() {
    if (!script.targetScale) {
        return;
    }
    var scale = script.targetScale.getTransform().getWorldScale();
    setVfx(scale);
}

function triggerMeshDimension() {
    if (!script.targetDimension && !script.targetDimension.mesh) {
        return;
    }
    if (script.dimensionValue == "aabbMax") {
        var max = script.targetDimension.mesh.aabbMax;
        max = max.mult(script.targetDimension.getTransform().getLocalScale());
        setVfx(max);
    } else if (script.dimensionValue == "aabbMin") {
        var min = script.targetDimension.mesh.aabbMin;
        min = min.mult(script.targetDimension.getTransform().getLocalScale());
        setVfx(min);
    }
}

function triggerScreenToWorld() {
    if (!script.screenToWorldScreenTrans || !script.screenToWorldCamera) {
        return;
    }
    var screenToWorldPos = getScreenPosToWorldPos(script.screenToWorldScreenTrans, script.screenToWorldCamera, script.desiredModelHeight);
    setVfx(screenToWorldPos);
}

function triggerWorldToScreen() {
    if (!script.worldToScreenCamera || !script.worldToScreenObject) {
        return;
    }
    var worldToScreenPos = script.worldToScreenCamera.worldSpaceToScreenSpace(script.worldToScreenObject.getTransform().getWorldPosition());
    setVfx(worldToScreenPos);
}

function triggerLocalToWorld() {
    if (!script.localToWorldObj) {
        return;
    }
    var localToWorldConv = script.localToWorldObj.localPointToWorldPoint(new vec2(0, 0));
    setVfx(localToWorldConv);
}

function triggerScreenTransScale() {
    if (!script.screenTransObj) {
        return;
    }
    var screenImg = script.screenTransObj;
    var a = screenImg.localPointToWorldPoint(new vec2(0, 0));
    var b = screenImg.localPointToWorldPoint(new vec2(1, 1));
    var imgScale = new vec2(Math.abs(b.x - a.x), Math.abs(b.y - a.y));

    setVfx(imgScale);
}

function getScreenPosToWorldPos(s, c, h) {
    var anchors = s.anchors;
    var center = anchors.getCenter();
    var anchorHeight = anchors.getSize().y / 2;
    var modelSize = h;
    var screenPos = s.localPointToScreenPoint(center);
    var fov = c.fov;
    var depth = (modelSize / anchorHeight) * .5 / Math.tan(fov * 0.5);
    var worldPos = c.screenSpaceToWorldSpace(screenPos, depth);

    return worldPos;
}

triggerAction();