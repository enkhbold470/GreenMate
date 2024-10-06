//@input Asset.Texture deviceCameraTexture
//@input Component.ScreenTransform toolbarScreenT
//@input Component.ScreenTransform toolbarLeftSection
//@input Component.ScreenTransform toolbarRightSection
//@input Component.ScreenTransform toolbarMidSection
//@input Component.ScreenTransform bottomMidSection
//@input Component.ScreenTransform previewZone

const provider = script.deviceCameraTexture.control;
const toolbarAnchors = script.toolbarScreenT.anchors;
const previewZoneAnchors = script.previewZone.anchors;
const previewOffset = 0.042;
let pixelSize = 45;
let screenWidth = 800;

let toolbarLeftSectionRight;
let toolbarRightSectionLeft;
let toolbarTopSectionRight;
let bottomMidSectionRight;

const updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(update);

init();

function init() {
    if (script.toolbarLeftSection) {
        toolbarLeftSectionRight = script.toolbarLeftSection.anchors.right + 1;
    }

    if (script.toolbarRightSection) {
        toolbarRightSectionLeft = 1 - script.toolbarRightSection.anchors.left;
    }

    if (script.toolbarMidSection) {
        toolbarTopSectionRight = script.toolbarMidSection.anchors.right;
    }

    if (script.bottomMidSection) {
        bottomMidSectionRight = script.bottomMidSection.anchors.right;
    }
}

function update() {

    let screenScale = global.deviceInfoSystem.screenScale;
    if (!screenScale) {
        screenScale = 2;
    }

    pixelSize = 24 * screenScale;
    screenWidth = 427 * screenScale;

    toolbarAnchors.bottom = 1 - pixelSize * 2 / provider.getHeight();

    previewZoneAnchors.top = Math.max(toolbarAnchors.bottom - (1 - toolbarAnchors.bottom) * previewOffset, -1);
    previewZoneAnchors.bottom = -1;

    if (script.toolbarLeftSection) {
        script.toolbarLeftSection.anchors.left = -1;
        script.toolbarLeftSection.anchors.right = -1 + toolbarLeftSectionRight * screenWidth / provider.getWidth();
    }

    if (script.toolbarRightSection) {
        script.toolbarRightSection.anchors.right = 1;
        script.toolbarRightSection.anchors.left = 1 - toolbarRightSectionLeft * screenWidth / provider.getWidth();
    }

    if (script.toolbarMidSection) {
        script.toolbarMidSection.anchors.left = 0 - toolbarTopSectionRight * screenWidth / provider.getWidth();
        script.toolbarMidSection.anchors.right = 0 + toolbarTopSectionRight * screenWidth / provider.getWidth();
    }

    if (script.bottomMidSection) {
        script.bottomMidSection.anchors.bottom = -1;
        script.bottomMidSection.anchors.top = -1 + pixelSize * 2 / provider.getHeight();
        script.bottomMidSection.anchors.left = 0 - bottomMidSectionRight * screenWidth / provider.getWidth();
        script.bottomMidSection.anchors.right = 0 + bottomMidSectionRight * screenWidth / provider.getWidth();
    }
}
