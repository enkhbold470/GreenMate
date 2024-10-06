//@input SceneObject parent
//@input Component.ScriptComponent fovController

function show(newSceneObject) {
    newSceneObject.setParent(script.parent);
    script.fovController.showSlider();
}

function setVfxManager(newObject) {
    newObject.setParent(script.parent);
}

function hide() {
    script.fovController.hideSlider();
}

script.setVfxManager = setVfxManager;
script.show = show;
script.hide = hide;
