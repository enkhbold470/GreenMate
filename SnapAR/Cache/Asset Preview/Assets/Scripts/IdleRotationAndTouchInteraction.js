// @input SceneObject box
// @input SceneObject parent
//@input Component.InteractionComponent interactionComponent

//@input vec3 rotationEuler

script.setFlatMode = isFlatFlag => isFlat = isFlatFlag;

let isFlat = true;

const MIN_SCALE = 0.7;
const MAX_SCALE = 3;

let touchPos = vec2.zero();
let secondTouchPos = vec2.zero();
let touchDelta = new vec2(script.rotationEuler.x, script.rotationEuler.y);
let distance = 0;
let distanceDelta = script.box.getTransform().getWorldScale().x;
let lastTouchPos = vec2.zero();
let accum = quat.quatIdentity();
let touches = [];
let scale = script.box.getTransform().getWorldScale().x;
const scaleCoef = 3;
const frictionCoef = 0.5;

script.interactionComponent.onTouchStart.add(function(eventData) {
    lastTouchPos = eventData.position;
    touches.push(eventData.touchId);

    if (touches.length === 1) {
        touchPos = eventData.position;
    }

    if (touches.length === 2) {
        secondTouchPos = eventData.position;
        distance = touchPos.distance(secondTouchPos);
    }
});

script.interactionComponent.onTouchMove.add(function(eventData) {
    if (eventData.touchId === touches[0]) {
        touchPos = eventData.position;
        touchDelta = lastTouchPos.sub(touchPos);
        lastTouchPos = touchPos;
        if (touches.length === 2) {
            updateDistance(touchPos.distance(secondTouchPos));
        }
    }

    if (touches.length === 2 && eventData.touchId === touches[1]) {
        secondTouchPos = eventData.position;
        updateDistance(touchPos.distance(secondTouchPos));
    }

});

script.interactionComponent.onTouchEnd.add(function(eventData) {
    touches = [];
    touchDelta = new vec2(script.rotationEuler.x, script.rotationEuler.y);
    distance = 0;
});

script.createEvent('UpdateEvent').bind(function(eventData) {
    if (touches.length > 1) {
        touchDelta = vec2.zero();
    }

    if (!isFlat) {
        rotationBehaviour();
    }

    // TODO: can mimic in preview? does not work atm, as it requires 2 fingers
    // zoomBehaviour();
});

function updateDistance(newDistance) {
    distanceDelta += (newDistance - distance) * scaleCoef;
    distanceDelta = clamp(MIN_SCALE, MAX_SCALE, distanceDelta);
    distance = newDistance;
}

function clamp(l, r, x) {
    return Math.max(l, Math.min(x, r));
}

function lerp(a, b, x) {
    return a * (1 - x) + b * x;
}

function zoomBehaviour() {
    scale = lerp(scale, distanceDelta, 0.5);
    script.box.getTransform().setWorldScale(new vec3(scale, scale, scale));
}

// TODO: make dependent on dt instead of framerate?
function rotationBehaviour() {
    const testQuat = quat.fromEulerAngles(-frictionCoef * touchDelta.y, -frictionCoef * touchDelta.x, 0);
    accum = accum.multiply(testQuat);
    accum = quat.slerp(accum, quat.quatIdentity(), 0.1);
    const objectRot = script.parent.getTransform().getWorldRotation();
    const newRot = objectRot.multiply(accum);
    script.parent.getTransform().setWorldRotation(newRot);
    const boxRot = script.box.getTransform().getWorldRotation();
    script.parent.getTransform().setWorldRotation(quat.quatIdentity());
    script.box.getTransform().setWorldRotation(boxRot);
}

script.reset = function() {
    accum = quat.quatIdentity();
    touchDelta = vec2.zero();
    script.parent.getTransform().setWorldRotation(quat.quatIdentity());
    script.box.getTransform().setWorldRotation(quat.quatIdentity());
};
