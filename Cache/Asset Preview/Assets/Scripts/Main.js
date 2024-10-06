//@input Component.ScriptComponent texturePreviewController
//@input Component.ScriptComponent materialPreviewController
//@input Component.ScriptComponent meshPreviewController
//@input Component.ScriptComponent vfxPreviewController
//@input Component.ScriptComponent otherObjectsPreviewController
//@input Component.ScriptComponent gridController
//@input Component.ScriptComponent placementScript

const updateEvent = script.createEvent('LateUpdateEvent');
updateEvent.bind(update);

function update() {

    if (global.scene.getRootObjectsCount() <= 1) {
        return;
    }

    let newObject = null;
    for (let i = global.scene.getRootObjectsCount() - 1; i >= 0; --i) {
        const root = global.scene.getRootObject(i);
        if (root.name === '[ROOT]') {
            continue;
        }

        newObject = root;
    }
    
    script.gridController.show();

    newObject.enabled = true;
    var hasChild = (newObject.getChildrenCount() != 0);

    if (!hasChild && (newObject.name == "Texture" || newObject.name == "Video Texture")){
        var image = newObject.getComponent("Component.Image");
        if (image) {
            var mainPass = image.mainPass;
            if (mainPass){
                hide();
                var texture = mainPass.baseTex;
                script.texturePreviewController.show(texture)
                newObject.destroy();
            }

            return;
        }
    }

    if (!hasChild && newObject.name == 'Material') {
        var renderMeshVisual = newObject.getComponent("Component.RenderMeshVisual");
        if (renderMeshVisual){
            hide();
            script.placementScript.reparentNew();
            script.materialPreviewController.show(newObject);
            return;
        }
    }

    if (!hasChild && newObject.name == 'Mesh') {
        var renderMeshVisual = newObject.getComponent("Component.RenderMeshVisual");
        if (renderMeshVisual){        
            hide();
            script.placementScript.reparentNew();
            script.meshPreviewController.show(newObject);
            return;
        }
    }

    if (newObject.name == 'VFX Graph') {
        hide();
        script.vfxPreviewController.show(newObject);
        return;
    }

    if (newObject.name == '_ngsVfxManager') {
        script.vfxPreviewController.setVfxManager(newObject);
        return;
    }

    hide();
    script.placementScript.reparentNew();
    script.otherObjectsPreviewController.show();
}

function hide() {
    script.texturePreviewController.hide();
    script.materialPreviewController.hide();
    script.meshPreviewController.hide();
    script.vfxPreviewController.hide();
    script.otherObjectsPreviewController.hide();
}
