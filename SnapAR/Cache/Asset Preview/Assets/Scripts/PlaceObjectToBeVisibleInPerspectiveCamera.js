// @input SceneObject parent
// @input SceneObject pivot { "hint": "Object to be used as pivot point (a center of the meshes)" }
// @input Component.Camera camera { "hint": "Please note that the camera should have initial transform (no rotation, no translation)" }
// @input float paddingThreshold { "widget": "slider", "min": 0.3, "max": 0.9, "step": 0.01 }

// @input Component.ScriptComponent interaction

const objectTransform = script.parent.getTransform();
const pivotTransform = script.pivot.getTransform();

const EPS = 1e-3;

let isNewObject = true;
const initFov = 60 * Math.PI / 180;

function reparent() {
    const objects = [];
    // backwards to avoid index invalidation
    for (let i = global.scene.getRootObjectsCount() - 1; i >= 0; --i) {
        const root = global.scene.getRootObject(i);
        if (root.name === '[ROOT]') {
            continue;
        }

        root.setParent(script.parent);
        objects.push(root);
    }

    return objects;
}

function executeRecursivelyOnAllChildren(parent, callback) {
    callback(parent);
    parent.children.forEach(child => executeRecursivelyOnAllChildren(child, callback));
}

function aabbMinSingle(mesh) {
    // -INF;INF for text components, needs to be faked
    // TODO: find better solution!
    if (mesh.getTypeName() === 'Component.Text' || mesh.getTypeName() === 'Component.Text3D') {
        const textScale = 2.5; // calculated empirically
        const center = mesh.getSceneObject().getTransform()
            .getWorldPosition();
        return center.add(new vec3(1, 1, 0).uniformScale(-textScale));
    }

    // for some reason twice as small for images
    // currently based off the fact that we instantiate images in "Fit" mode
    // TODO: in prefabs with arbitrary images stretch mode can be different, account for it as well!
    if (mesh.getTypeName() === 'Component.Image') {
        return mesh.worldAabbMin().uniformScale(0.25);
    }

    // okay for other meshes
    return mesh.worldAabbMin();
}

function aabbMaxSingle(mesh) {
    // same concerns as for aabbMin

    if (mesh.getTypeName() === 'Component.Text' || mesh.getTypeName() === 'Component.Text3D') {
        const textScale = 2.5;
        const center = mesh.getSceneObject().getTransform()
            .getWorldPosition();
        return center.add(new vec3(1, 1, 0).uniformScale(textScale));
    }

    if (mesh.getTypeName() === 'Component.Image') {
        return mesh.worldAabbMax().uniformScale(0.25);
    }

    return mesh.worldAabbMax();
}

function placeToBeVisible(rootObjects) {
    const allMeshes = [];

    rootObjects.forEach(function(object) {
        executeRecursivelyOnAllChildren(object, (child) => {
            child.getComponents('Component.BaseMeshVisual').forEach((mesh) => {
                allMeshes.push(mesh);
            });
        });
    });

    if (allMeshes.length === 0) {
        return;
    }

    let aabbMin = vec3.one().uniformScale(Number.POSITIVE_INFINITY);
    let aabbMax = vec3.one().uniformScale(Number.NEGATIVE_INFINITY);

    for (let i = 0; i < allMeshes.length; i++) {
        const mesh = allMeshes[i];
        aabbMin = vec3.min(aabbMin, aabbMinSingle(mesh));
        aabbMax = vec3.max(aabbMax, aabbMaxSingle(mesh));
    }

    const meshCenter = vec3.lerp(aabbMin, aabbMax, 0.5);
    const height = aabbMax.y - aabbMin.y;
    const width = aabbMax.x - aabbMin.x;

    const depth = aabbMax.z - aabbMin.z;
    script.interaction.setFlatMode(depth < EPS);

    const cameraConeLeftTop = script.camera.screenSpaceToWorldSpace(vec2.zero(), 100);
    const cameraConeRightBot = script.camera.screenSpaceToWorldSpace(vec2.one(), 100);

    const aabbMaxX = aabbMax.x - aabbMin.x;
    const aabbMaxY = aabbMax.y - aabbMin.y;
    const aabbMaxZ = aabbMax.z - aabbMin.z;

    const neededScale = 0.87 * 2 * Math.max(Math.max(aabbMaxX, aabbMaxY), aabbMaxZ);

    const pos = objectTransform.getWorldPosition();
    const pivotPos = vec3.zero();

    pivotPos.z = Math.min(-2 * script.camera.near, -neededScale);
    pos.z -= meshCenter.z - pivotPos.z;
    pos.x -= meshCenter.x;
    pos.y -= meshCenter.y;

    pivotTransform.setWorldPosition(pivotPos);
    objectTransform.setWorldPosition(pos);
}

function reparentNew() {
    const newObjects = reparent();
    if (newObjects.length === 0) {
        return;
    }

    isNewObject = true;

    const prevFov = script.camera.fov;
    script.camera.fov = initFov;
    script.interaction.reset();
    placeToBeVisible(newObjects);
    script.camera.fov = prevFov;
}

script.getObjectStatus = function() {
    if (isNewObject) {
        isNewObject = false;
        return true;
    }

    return false;
};

script.reparentNew = reparentNew;
