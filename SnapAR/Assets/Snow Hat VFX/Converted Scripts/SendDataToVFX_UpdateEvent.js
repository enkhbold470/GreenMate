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
script.createEvent("UpdateEvent").bind(function() { require("SendDataToVFX_wrapped")(script)})