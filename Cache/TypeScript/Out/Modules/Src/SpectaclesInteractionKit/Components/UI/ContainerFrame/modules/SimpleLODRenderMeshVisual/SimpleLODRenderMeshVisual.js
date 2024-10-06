"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.SimpleLODRenderMeshVisual = void 0;
var __selfType = requireType("./SimpleLODRenderMeshVisual");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const WorldCameraFinderProvider_1 = require("../../../../../Providers/CameraProvider/WorldCameraFinderProvider");
const NativeLogger_1 = require("../../../../../Utils/NativeLogger");
const log = new NativeLogger_1.default('SimpleLODRMV');
const DEFAULT_SPACER = 50;
/**
 * BACKGROUND
 * A first pass at a naive simple Level Of Detail (LOD) RenderMeshVisual
 * Naive because it only tests distance from the center of the object to the camera ( which will fail with super large objects )
 * ---- possible improvement may may distance in relative z plane to the object
 * Simple because there is no fading between different meshes, instead it just pops to the defined mesh at the defined depth
 * ---- possible improvement is a crossfade
 * That being said, it works pretty dang good
 * ~~~~~~~~~~
 *
 * USAGE
 * Drop this component onto a scene object
 * Drop meshes into the meshes array
 * and select threshaolds at the given index ( or else falls back to default )
 * and add the material that is shared across the rmvs
 * and let it do its thing : )
 */
let SimpleLODRenderMeshVisual = class SimpleLODRenderMeshVisual extends BaseScriptComponent {
    onAwake() {
        this.object = this.getSceneObject();
        this.transform = this.object.getTransform();
        const clonedMaterial = this.material.clone();
        for (let i = 0; i < this.meshes.length; i++) {
            const distanceMesh = this.meshes[i];
            const thisRMV = this.object.createComponent('RenderMeshVisual');
            thisRMV.mesh = distanceMesh;
            thisRMV.mainMaterial = clonedMaterial;
            thisRMV.enabled = false;
            this.rmvs.push(thisRMV);
            this.addDistance(this.thresholds[i] ? this.thresholds[i] : DEFAULT_SPACER);
        }
        this.rmvs[this.currentIndex].enabled = true;
        this.createEvent('UpdateEvent').bind(this.update);
    }
    __initialize() {
        super.__initialize();
        this.rmvs = [];
        this.distances = [];
        this.worldCamera = WorldCameraFinderProvider_1.default.getInstance();
        this.cameraTransform = this.worldCamera.getTransform();
        this.currentIndex = 0;
        this.setRenderOrder = (order) => {
            for (let i = 0; i < this.rmvs.length; i++) {
                const thisRmv = this.rmvs[i];
                thisRmv.setRenderOrder(order);
            }
        };
        this.addDistance = (distance) => {
            let lastDistance = 0;
            if (this.distances.length) {
                lastDistance = this.distances[this.distances.length - 1];
            }
            this.distances.push(distance + lastDistance);
        };
        this.update = () => {
            //
            // check and compare distances from camera
            //
            const currentDistanceSquared = this.cameraTransform
                .getWorldPosition()
                .distanceSquared(this.transform.getWorldPosition());
            let from = 0;
            let thisIndex = 0;
            let to;
            while (thisIndex < this.distances.length) {
                to = this.distances[thisIndex] * this.distances[thisIndex];
                if (currentDistanceSquared >= from && currentDistanceSquared < to) {
                    break;
                }
                else {
                    from = to;
                    thisIndex += 1;
                }
            }
            //
            // if at a new threshold, swap the active rmv
            //
            if (thisIndex < this.rmvs.length && this.currentIndex !== thisIndex) {
                this.currentIndex = thisIndex;
                for (const rmv of this.rmvs) {
                    rmv.enabled = false;
                }
                this.rmvs[this.currentIndex].enabled = true;
            }
        };
    }
};
exports.SimpleLODRenderMeshVisual = SimpleLODRenderMeshVisual;
exports.SimpleLODRenderMeshVisual = SimpleLODRenderMeshVisual = __decorate([
    component
], SimpleLODRenderMeshVisual);
//# sourceMappingURL=SimpleLODRenderMeshVisual.js.map