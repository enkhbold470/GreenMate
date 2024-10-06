//@input Asset.RenderMesh[] meshes
//@input Asset.Texture[] iconTextures
//@input Component.Image[] geometryBackgrounds
//@input SceneObject[] geometryCheckObjects
//@input Component.ScriptComponent lightController
//@input Component.ScriptComponent fovController
//@input SceneObject rightSection

let renderMeshVisual;
let curObjIdx;
let previewObject;
const ghostScale = 0.02;

function show(newObject) {
    previewObject = newObject;
    renderMeshVisual = newObject.getComponent('Component.RenderMeshVisual');
    script.lightController.show();
    script.rightSection.enabled = true;
    curObjIdx = 0;
    script.fovController.resume(true);
    setMesh();
    update();
}

function hide() {
    script.lightController.hide();
    script.rightSection.enabled = false;
}

function setMesh() {
    renderMeshVisual.mesh = script.meshes[curObjIdx];
}

function onMappingButtonTapped() {
    curObjIdx = (curObjIdx + 1) % script.iconTextures.length;
    update();
}

function onGeometryIconTapped(idx) {
    curObjIdx = idx;
    update();
}

function setGeometryIconHoverStatus(idx, status) {
    const color = script.geometryBackgrounds[idx].mainPass.baseColor;
    color.w = status;
    script.geometryBackgrounds[idx].mainPass.baseColor = color;
}

function update() {
    resetCheckObjects();
    script.geometryCheckObjects[curObjIdx].enabled = true;
    if (curObjIdx == 1) {
        previewObject.getTransform().setWorldScale(vec3.one().uniformScale(10 * ghostScale));
    } else {
        previewObject.getTransform().setWorldScale(vec3.one().uniformScale(10));
    }

    setMesh();
}

function resetCheckObjects() {
    script.geometryCheckObjects.forEach(function(obj) {
        obj.enabled = false;
    });
}

function addDropDownImage(newImage) {
    script.geometryBackgrounds.push(newImage);
}

function addCheckObject(newObject) {
    script.geometryCheckObjects.push(newObject);
}

script.onMappingButtonTapped = onMappingButtonTapped;
script.onGeometryIconTapped = onGeometryIconTapped;
script.setGeometryIconHoverStatus = setGeometryIconHoverStatus;
script.addDropDownImage = addDropDownImage;
script.addCheckObject = addCheckObject;
script.show = show;
script.hide = hide;
