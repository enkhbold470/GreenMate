"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Billboard = void 0;
var __selfType = requireType("./Billboard");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const BillboardController_1 = require("./BillboardController");
/*
 * Billboard allows an object to rotate to face the camera.
 */
let Billboard = class Billboard extends BaseScriptComponent {
    onAwake() {
        const billboardConfig = {
            script: this,
            target: this.getSceneObject(),
            xAxisEnabled: this._xAxisEnabled,
            yAxisEnabled: this._yAxisEnabled,
            zAxisEnabled: this._zAxisEnabled,
            axisBufferDegrees: this._axisBufferDegrees,
            axisEasing: this._axisEasing,
            duration: this.duration,
        };
        this.controller = new BillboardController_1.default(billboardConfig);
    }
    /**
     * Immediately resets the SceneObject to the rotation accroding to inputs regardless of easing.
     */
    snapToOffsetRotation() {
        this.controller.resetRotation();
    }
    /**
     * @returns if the SceneObject billboards about the x-axis.
     */
    get xAxisEnabled() {
        return this._xAxisEnabled;
    }
    /**
     * @param enabled - defines if the SceneObject billboards about the x-axis.
     */
    set xAxisEnabled(enabled) {
        if (enabled === this._xAxisEnabled) {
            return;
        }
        this._xAxisEnabled = enabled;
        this.controller.enableAxisRotation(BillboardController_1.RotationAxis.X, enabled);
    }
    /**
     * @returns if the SceneObject billboards about the y-axis.
     */
    get yAxisEnabled() {
        return this._yAxisEnabled;
    }
    /**
     * @param enabled - defines if the SceneObject billboards about the y-axis.
     */
    set yAxisEnabled(enabled) {
        if (enabled === this._yAxisEnabled) {
            return;
        }
        this._yAxisEnabled = enabled;
        this.controller.enableAxisRotation(BillboardController_1.RotationAxis.Y, enabled);
    }
    /**
     * @returns if the SceneObject billboards about the z-axis.
     */
    get zAxisEnabled() {
        return this._zAxisEnabled;
    }
    /**
     * @param enabled - defines if the SceneObject billboards about the z-axis.
     */
    set zAxisEnabled(enabled) {
        if (enabled === this._zAxisEnabled) {
            return;
        }
        this._zAxisEnabled = enabled;
        this.controller.enableAxisRotation(BillboardController_1.RotationAxis.Z, enabled);
    }
    /**
     * @param easing - the vector defining the easing for each axis. For instant follow, use easing = (1,1,1).
     */
    set axisEasing(easing) {
        if (easing.equal(this._axisEasing)) {
            return;
        }
        this._axisEasing = easing;
        this.controller.axisEasing = easing;
    }
    /**
     * @returns the vector defining the easing for each axis.
     */
    get axisEasing() {
        return this._axisEasing;
    }
    /**
     * @param bufferDegrees - the vector defining the buffer for each axis.
     */
    set axisBufferDegrees(bufferDegrees) {
        if (bufferDegrees.equal(this._axisBufferDegrees)) {
            return;
        }
        this._axisBufferDegrees = bufferDegrees;
        this.controller.axisBufferDegrees = bufferDegrees;
    }
    /**
     * @returns the vector defining the buffer for each axis.
     */
    get axisBufferDegrees() {
        return this._axisBufferDegrees;
    }
};
exports.Billboard = Billboard;
exports.Billboard = Billboard = __decorate([
    component
], Billboard);
//# sourceMappingURL=Billboard.js.map