// @input Component.Camera camera
// @input Asset.Texture texture
//@input Component.ScreenTransform previewZone

const previewZoneAnchors = script.previewZone.anchors;
const camera = script.camera;
let lastSize = camera.size;
const toolbarSize = 25;

init();

function init() {
    script.camera.renderTarget.control.resolutionScale = 2;
}

script.createEvent('UpdateEvent').bind(function() {
    if (script.texture.getHeight() > 0 && script.texture.getHeight() !== lastSize) {
        let screenScale = global.deviceInfoSystem.screenScale;

        if (!screenScale) {
            screenScale = 2;
        }
        camera.size = script.texture.getHeight() * (2 / screenScale);
        lastSize = camera.size;

        previewZoneAnchors.bottom = -1;
        previewZoneAnchors.top = Math.max(2 * (script.texture.getHeight() - toolbarSize * screenScale) / script.texture.getHeight() - 1, -1);
    }
});
