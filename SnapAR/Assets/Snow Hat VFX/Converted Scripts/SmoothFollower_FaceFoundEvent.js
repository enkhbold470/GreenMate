// @input SceneObject follower
// @input SceneObject target
//@ui {"widget":"separator"}
// @input bool followPosition = true
//@ui {"widget":"group_start", "label":"Position Smoothing Properties", "showIf" : "followPosition"}
// @input float maxPosSpeed = 50 {"label":"Max Speed"}
// @input float posDamping = 5 {"label":"Damping"}
//@input int posMode = 0 {"widget":"combobox", "values":[{"label":"World Space", "value":0}, {"label":"Local Space", "value":1}], "label":"Mode"}
//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
// @input bool followRotation = true
//@ui {"widget":"group_start", "label":"Rotation Smoothing Properties", "showIf" : "followRotation"}
// @input float maxRotSpeed = 50 {"label":"Max Speed"}
// @input float rotDamping = 5 {"label":"Damping"}
//@input int rotMode = 0 {"widget":"combobox", "values":[{"label":"World Space", "value":0}, {"label":"Local Space", "value":1}], "label":"Mode"}
//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
// @input bool followScale = true
//@ui {"widget":"group_start", "label":"Scale Smoothing Properties", "showIf" : "followScale"}
// @input float maxScaleSpeed = 50 {"label":"Max Speed"}
// @input float scaleDamping = 5 {"label":"Damping"}
//@input int scaleMode = 0 {"widget":"combobox", "values":[{"label":"World Space", "value":0}, {"label":"Local Space", "value":1}], "label":"Mode"}
//@ui {"widget":"group_end"}
script.createEvent("FaceFoundEvent").bind(function() { require("SmoothFollower_wrapped")(script)})