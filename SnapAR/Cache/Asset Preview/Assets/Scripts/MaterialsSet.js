//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":""}

//@input SceneObject[] iconBackgroundObjects

//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":""}

//@input Asset.Material greyMaterial
//@input bool[] greyBackgroundStatus

//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":""}

/*
@typedef IconMaterialsData
@property {Component.Image} iconImage
@property {Component.Texture} texture
*/

//@input Asset.Material iconMaterial
//@input Asset.Texture[] iconTextures

//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":""}

//@input Asset.Material texturePreviewMaterial
//@input Component.RenderMeshVisual[] textureRenderMeshes

//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":""}

//@input SceneObject hintObject

//@ui {"widget":"group_end"}

global.hintObject = script.hintObject;

const greyBackgroundImages = [];
const iconImages = [];

init();

function init() {

    createIconObjs();
    setIconBackgroundMaterials();
    setIconMaterials();
    setTexturePreviewMaterials();
}

function createIconObjs() {
    script.iconBackgroundObjects.forEach(function(obj) {
        let newImage = obj.createComponent('Component.Image');
        newImage.stretchMode = StretchMode.Fill;
        greyBackgroundImages.push(newImage);

        const child = global.scene.createSceneObject('icon');
        child.setParent(obj);
        child.layer = obj.layer;

        const screenT = child.createComponent('Component.ScreenTransform');
        const anchors = screenT.anchors;
        anchors.left = -0.75;
        anchors.right = 0.75;
        anchors.bottom = -0.75;
        anchors.top = 0.75;

        newImage = child.createComponent('Component.Image');
        newImage.stretchMode = StretchMode.Fit;
        iconImages.push(newImage);
    });
}

function setIconBackgroundMaterials() {
    greyBackgroundImages.forEach(function(img, i) {
        const newMaterial = script.greyMaterial.clone();
        const color = newMaterial.mainPass.baseColor;
        color.w = (script.greyBackgroundStatus[i]) ? 1 : 0;
        newMaterial.mainPass.baseColor = color;

        img.mainMaterial = newMaterial;
    });
}

function setIconMaterials() {
    iconImages.forEach(function(image, i) {
        const newMaterial = script.iconMaterial.clone();
        newMaterial.mainPass.baseTex = script.iconTextures[i];

        image.mainMaterial = newMaterial;
    });
}

function setTexturePreviewMaterials() {
    const curColorMask = new vec4b(1, 1, 1, 1);

    return;

    let newMaterial = script.texturePreviewMaterial.clone();
    newMaterialPass = newMaterial.mainPass;
    print(' --->>   ' + newMaterialPass.colorMask + '    ' + newMaterialPass.cullMode + '     ' + newMaterialPass.channel);
    newMaterialPass.colorMask = curColorMask;
    newMaterialPass.cullMode = CullMode.Front;
    newMaterialPass.channel = 1;
    script.textureRenderMeshes[1].mainMaterial = newMaterial;

    newMaterial = script.texturePreviewMaterial.clone();
    newMaterialPass = newMaterial.mainPass;
    newMaterialPass.colorMask = curColorMask;
    newMaterialPass.cullMode = CullMode.Back;
    newMaterialPass.channel = 1;
    script.textureRenderMeshes[0].mainMaterial = newMaterial;
}
