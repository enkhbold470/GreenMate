// -----JS CODE-----
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

var followerTrans;
var targetTrans;
var dampRotVec4;
var isInit = false;
var positionVelocity = vec3.zero();
var rotationVelocity = vec4.zero();
var scaleVelocity = vec3.zero();
var dampPos;
var dampScale;
var deltaTime = getDeltaTime();

function initialize() {
    isInit = validateInputs();
    if (!isInit) {
        return;
    }
    followerTrans = script.follower.getTransform();
    targetTrans = script.target.getTransform();

    dampRotVec4 = new vec4(script.rotDamping, script.rotDamping, script.rotDamping, script.rotDamping);
    dampPos = script.posDamping;
    dampScale = script.scaleDamping;
}


function onUpdate() {
    if (!isInit) {
        return;
    }
    deltaTime = getDeltaTime();
    smoothPosition();
    smoothRotation();
    smoothScale();
}

function smoothPosition() {
    if (!script.followPosition) {
        return;
    }

    positionVelocity = positionVelocity.clampLength(script.maxPosSpeed);

    var followerPosition = (script.posMode == 0) ? followerTrans.getWorldPosition() : followerTrans.getLocalPosition();
    var targetPosition = (script.posMode == 0) ? targetTrans.getWorldPosition() : targetTrans.getLocalPosition();
    var dir = followerPosition.sub(targetPosition);
    var dampedVelocity = positionVelocity.sub(dir).uniformScale(dampPos * dampPos * deltaTime);
    var dampedDelta = 1 + (dampPos * deltaTime);
    var dampedDeltaVec = new vec3(dampedDelta, dampedDelta, dampedDelta);
    positionVelocity = dampedVelocity.div(dampedDeltaVec.mult(dampedDeltaVec));
    var finalPos = followerPosition.add(positionVelocity.uniformScale(deltaTime));

    if (script.posMode == 0) {
        followerTrans.setWorldPosition(finalPos);
    } else {
        followerTrans.setLocalPosition(finalPos);
    }
}


function smoothRotation() {
    if (!script.followRotation) {
        return;
    }

    rotationVelocity = rotationVelocity.clampLength(script.maxRotSpeed);

    var followerVector = (script.rotMode == 0) ? quat2Vec4(followerTrans.getWorldRotation()) : quat2Vec4(followerTrans.getLocalRotation());
    var targetVector = (script.rotMode == 0) ? quat2Vec4(targetTrans.getWorldRotation()) : quat2Vec4(targetTrans.getLocalRotation());
    if (deltaTime <= 0) {
        return;
    }
    var deltaTimeVec4 = new vec4(deltaTime, deltaTime, deltaTime, deltaTime);

    var dot = followerVector.dot(targetVector);

    if (dot < 0) {
        targetVector = targetVector.uniformScale(-1);
    }

    var dampedDelta = dampRotVec4.mult(dampRotVec4).mult(deltaTimeVec4);
    var dampedVelocity = rotationVelocity.sub(followerVector.sub(targetVector)).mult(dampedDelta);
    var dampedDelta = vec4.one().add(dampRotVec4.mult(deltaTimeVec4));
    var multDampedDelta = dampedDelta.mult(dampedDelta);
    rotationVelocity = dampedVelocity.div(multDampedDelta);
    var finalRot = followerVector.add(rotationVelocity.mult(deltaTimeVec4)).normalize();

    if (script.rotMode == 0) {
        followerTrans.setWorldRotation(new quat(finalRot.w, finalRot.x, finalRot.y, finalRot.z));
    } else {
        followerTrans.setLocalRotation(new quat(finalRot.w, finalRot.x, finalRot.y, finalRot.z));
    }
}

function smoothScale() {
    if (!script.followScale) {
        return;
    }

    scaleVelocity = scaleVelocity.clampLength(script.maxScaleSpeed);

    var followScale = (script.scaleMode == 0) ? followerTrans.getWorldScale() : followerTrans.getLocalScale();
    var targetScale = (script.scaleMode == 0) ? targetTrans.getWorldScale() : targetTrans.getLocalScale();

    var dir = followScale.sub(targetScale);
    var dampedVelocity = scaleVelocity.sub(dir).uniformScale(dampScale * dampScale * deltaTime);
    var dampedDelta = 1 + (dampScale * deltaTime);
    var dampedDeltaVec = new vec3(dampedDelta, dampedDelta, dampedDelta);
    scaleVelocity = dampedVelocity.div(dampedDeltaVec.mult(dampedDeltaVec));
    var finalScale = followScale.add(scaleVelocity.uniformScale(deltaTime));

    if (script.scaleMode == 0) {
        followerTrans.setWorldScale(finalScale);
    } else {
        followerTrans.setLocalScale(finalScale);
    }
}

function quat2Vec4(q) {
    return new vec4(q.x, q.y, q.z, q.w)
}

function validateInputs() {
    if (!script.follower) {
        print("ERROR: Please set a scene object that you want to follow the target.");
        return false;
    }
    if (!script.target) {
        print("ERROR: Please set a scene object as a target.");
        return false;
    }

    return true;
}

initialize();

var updateEvent = script.createEvent("UpdateEvent");
updateEvent.bind(onUpdate);