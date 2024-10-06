"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
const Singleton_1 = require("../../Decorators/Singleton");
const algorithms_1 = require("../../Utils/algorithms");
const BaseWorldCameraProvider_1 = require("./BaseWorldCameraProvider");
let WorldCameraFinderProvider = class WorldCameraFinderProvider extends BaseWorldCameraProvider_1.default {
    constructor() {
        super();
        const cameraComponent = this.lookForCameraComponent();
        if (cameraComponent === null) {
            throw new Error('Could not find any suitable camera in the scene, make sure it is setup correctly');
        }
        if (this.lookForDeviceTrackingComponent(cameraComponent.getSceneObject()) ===
            null) {
            throw new Error('Your main camera is currently missing a \'Device Tracking Component\'. Set your `Device Tracking Component` with Tracking Mode: World for spatial movement in your Lens.');
        }
        this.cameraComponent = cameraComponent;
        this.cameraTransform = this.cameraComponent.getTransform();
    }
    lookForCameraComponent() {
        // Define predicate for bfs
        const predicate = (object) => {
            const cameraComponent = object.getComponent('Component.Camera');
            // It is possible the liveTarget is not set, in this case we use the captureTarget
            const targetRenderTarget = global.scene.liveTarget !== null
                ? global.scene.liveTarget
                : global.scene.captureTarget;
            if (object.enabled &&
                cameraComponent !== null &&
                cameraComponent.type === Camera.Type.Perspective &&
                cameraComponent.renderTarget.isSame(targetRenderTarget) &&
                cameraComponent.enabled) {
                return cameraComponent;
            }
            else {
                return null;
            }
        };
        // Get root objects from the scene
        const rootObjects = [];
        for (let i = 0; i < global.scene.getRootObjectsCount(); i++) {
            rootObjects.push(global.scene.getRootObject(i));
        }
        // return bfs<Camera | null>(rootObjects, predicate)
        return (0, algorithms_1.bfs)(rootObjects, predicate);
    }
    lookForDeviceTrackingComponent(sceneObject) {
        const deviceTrackingComponent = sceneObject.getComponent('Component.DeviceTracking');
        return deviceTrackingComponent;
    }
};
WorldCameraFinderProvider = __decorate([
    Singleton_1.Singleton
], WorldCameraFinderProvider);
exports.default = WorldCameraFinderProvider;
//# sourceMappingURL=WorldCameraFinderProvider.js.map