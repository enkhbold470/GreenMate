//@input Component.ScriptComponent lightController
//@input Component.ScriptComponent dropDownMenu
//@input SceneObject firstObj

const texts = ['Echopark', 'Marvista', 'Pasadena', 'Pier', 'Speakeasy'];
const parent = script.firstObj.getParent();
const offset = new vec2(0, -0.395);
let isCreated = false;

const interactionComp = script.getSceneObject().getComponent('Component.InteractionComponent');

function init() {
    script.dropDownMenu.setEnabled(true);
    if (parent.getChildrenCount() <= 1) {
        setUpMenu();
    }
    script.dropDownMenu.setEnabled(false);
}

interactionComp.onHoverStart.add(function() {
    script.dropDownMenu.setEnabled(true);
    if (parent.getChildrenCount() <= 1) {
        setUpMenu();
    }
});

interactionComp.onHoverEnd.add(function() {
    script.dropDownMenu.setEnabled(false);
});

//interactionComp.onTap.add(function() {
//    script.lightController.onMainEnvironmentIconTapped();
//});

function setUpMenu() {
    isCreated = true;
    const firstObjScreenT = script.firstObj.getComponent('Component.ScreenTransform');
    const parent = script.firstObj.getParent();
    const firstObjCenter = firstObjScreenT.anchors.getCenter();

    for (let i = 1; i < texts.length; i++) {
        const newObj = parent.copyWholeHierarchyAndAssets(script.firstObj);

        const screenT = newObj.getComponent('Component.ScreenTransform');
        screenT.anchors.setCenter(firstObjCenter.add(offset.uniformScale(i)));

        const curScript = newObj.getComponent('Component.ScriptComponent');
        curScript.setId(i);

        const text = newObj.getChild(1).getComponent('Component.Text');
        text.text = texts[i];

        const curImage = newObj.getComponent('Component.Image');
        const checkObject = newObj.getChild(0);

        script.lightController.addDropDownImage(curImage);
        script.lightController.addCheckObject(checkObject);
    }

    script.lightController.resetEnvironmentIcons();
}

init();
