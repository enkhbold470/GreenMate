//@input SceneObject textureLeftSection
//@input SceneObject textureMiddleSection
//@input SceneObject channelIconObj
//@input SceneObject mappingIconObj
//@input Component.ScriptComponent fovController
//@input SceneObject[] channelBackgroundObjects
//@input SceneObject[] mappingBackgroundObjects
//@input SceneObject[] mappingObjs
//@input Asset.Material[] texturePreviewMats

let channelIdx = 0;
let mappingObjIdx = 0;
const channelBackgroundPass = [];
const mappingBackgroundPass = [];
let texturePreviewPass;

function init() {

    script.channelBackgroundObjects.forEach(function(obj) {
        const pass = obj.getComponent('Component.Image').mainPass;
        channelBackgroundPass.push(pass);
    });

    script.mappingBackgroundObjects.forEach(function(obj) {
        const pass = obj.getComponent('Component.Image').mainPass;
        mappingBackgroundPass.push(pass);
    });

    texturePreviewPass = [];
    script.texturePreviewMats.forEach(function(material) {
        texturePreviewPass.push(material.mainPass);
    });
}

function show(newTexture) {
    reset();
    script.textureLeftSection.enabled = true;
    script.textureMiddleSection.enabled = true;
    texturePreviewPass[0].baseTex = newTexture;
    setChannelIdx(0);
    setMappingIndex(0);
}

function setChannelIdx(idx) {
    setChannelBackgroundColor(channelIdx, 0);
    channelIdx = idx;
    setChannelBackgroundColor(channelIdx, 1);
    texturePreviewPass[mappingObjIdx].channel = channelIdx;
}

function setMappingIndex(idx) {
    setMappingBackgroundColor(mappingObjIdx, 0);
    script.mappingObjs[mappingObjIdx].enabled = false;
    mappingObjIdx = idx;
    setMappingBackgroundColor(mappingObjIdx, 1);
    script.mappingObjs[mappingObjIdx].enabled = true;
    texturePreviewPass[mappingObjIdx].baseTex = texturePreviewPass[0].baseTex;
    texturePreviewPass[mappingObjIdx].channel = channelIdx;

    if (mappingObjIdx == 0 || mappingObjIdx == 2) {
        script.fovController.pause();
    } else {
        script.fovController.resume(true);
    }
}

function onChannelButtonTapped(idx) {
    setChannelIdx(idx);
}

function onMappingButtonTapped(idx) {
    setMappingIndex(idx);
}

function reset() {
    setChannelIdx(0);
    setMappingIndex(0);
    hideMappingObjs();
}

function setChannelBackgroundColor(idx, alpha) {
    const color = channelBackgroundPass[idx].baseColor;
    color.w = alpha;
    channelBackgroundPass[idx].baseColor = color;
}

function setMappingBackgroundColor(idx, alpha) {
    const color = mappingBackgroundPass[idx].baseColor;
    color.w = alpha;
    mappingBackgroundPass[idx].baseColor = color;
}

function hideMappingObjs() {
    script.mappingObjs.forEach(function(obj) {
        obj.enabled = false;
    });
}

function hide() {
    hideMappingObjs();
    script.textureLeftSection.enabled = false;
    script.textureMiddleSection.enabled = false;
    script.fovController.resume();
}

init();

script.onChannelButtonTapped = onChannelButtonTapped;
script.onMappingButtonTapped = onMappingButtonTapped;
script.show = show;
script.hide = hide;
