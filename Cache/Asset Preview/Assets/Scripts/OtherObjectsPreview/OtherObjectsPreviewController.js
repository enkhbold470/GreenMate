//@input SceneObject lightning
//@input Component.ScriptComponent fovController

function show() {
    script.lightning.enabled = true;
    script.fovController.showSlider();
}

function hide() {
    script.lightning.enabled = false;
    script.fovController.hideSlider();
}

script.show = show;
script.hide = hide;
