//@input Component.ScriptComponent materialPreviewController
//@input Component.ScriptComponent dropDownMenu
//@input SceneObject firstObj
//@input Asset.Texture[] icons

const texts = ['Sphere', 'Ghost', 'Cube'];
const parent = script.firstObj.getParent();
const offset = new vec2(0, -0.6464);
let isCreated = false;

const interactionComp = script.getSceneObject().getComponent('Component.InteractionComponent');

interactionComp.onHoverStart.add(function() {
    script.dropDownMenu.setEnabled(true);
    if (parent.getChildrenCount() <= 1) {
        setUpMenu();
    }
});

interactionComp.onHoverEnd.add(function() {
    script.dropDownMenu.setEnabled(false);
});

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

        const iconImage = newObj.getChild(2).getComponent('Component.Image');
        iconImage.mainPass.baseTex = script.icons[i];

        const curImage = newObj.getComponent('Component.Image');
        const checkObject = newObj.getChild(0);
        checkObject.enabled = false;

        script.materialPreviewController.addDropDownImage(curImage);
        script.materialPreviewController.addCheckObject(checkObject);
    }

    script.materialPreviewController.onGeometryIconTapped(0);
}
