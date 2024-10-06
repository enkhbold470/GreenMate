//@input Asset.Texture deviceCameraTexture
//@input SceneObject distObj
//@input SceneObject pivotObj
//@input Component.Camera camera
//@input Component.ScriptComponent placementScript
//@input SceneObject slider
//@input Component.ScriptComponent sliderScript

const camera = script.camera;
const distObjT = script.distObj.getTransform();
const pivotObjT = script.pivotObj.getTransform();
const objPos = new vec3(0, 0, 0);

const initFov = camera.fov;
const initSliderVal = 0.5;
let sliderValue = 0.5;
let isShown = false;
let defFov = 60 * Math.PI / 180;
const maxFov = Math.PI;

let prevWidth = 0;
let prevHeight = 0;
let isPaused = false;

init();

function init() {
    script.sliderScript.api.addOnValueChangedCallbacks(onSliderValueChanged);
}

const updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(update);

function update() {

    if (isPaused) {
        return;
    }

    const height = script.deviceCameraTexture.getHeight();
    const width = script.deviceCameraTexture.getWidth();

    if (height == prevHeight && width == prevWidth) {
        return;
    }

    prevHeight = height;
    prevWidth = width;

    if (width < height) {
        updateCameraFov(height, width);
    } else {
        updateCameraFov(height, height);
    }
}

function updateCameraFov(height, width) {
    const diag = Math.sqrt((height * height) + (width * width));
    const distance = diag / (2 * Math.tan(initFov / 2));

    defFov = 2 * Math.atan((diag) / (2 * distance * width / height));

    setCameraFov();
}

function setCameraFov() {
    let curFov;
    if (sliderValue < initSliderVal) {
        curFov = sliderValue / initSliderVal * defFov;
    } else {
        curFov = defFov + (sliderValue - initSliderVal) / (1 - initSliderVal) * (maxFov - defFov);
    }

    script.camera.fov = curFov;
}

function showSlider() {
    isShown = true;
    script.sliderScript.enabled = true;
    script.slider.enabled = true;
    sliderValue = initSliderVal;
    script.sliderScript.api.setSliderValue(0);
}

function onSliderValueChanged(val) {
    if (!isShown) {
        return;
    }
    val = clamp(val, 0.0001, 0.9999);
    sliderValue = val;

    setCameraFov();
}

function hideSlider() {
    isShown = false;
    script.sliderScript.enabled = false;
    script.slider.enabled = false;
}

function clamp(val, min, max) {
    return Math.min(Math.max(val, min), max);
}

script.pause = function() {
    isPaused = true;
    script.camera.fov = initFov;
};

script.resume = function(forceUpdate) {
    isPaused = false;
    if (forceUpdate) {
        prevHeight = -1;
        prevWidth = -1;
        sliderValue = initSliderVal;
    }
    update();
};

script.showSlider = showSlider;
script.hideSlider = hideSlider;
