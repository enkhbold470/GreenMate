"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RotationAxis = void 0;
const WorldCameraFinderProvider_1 = require("../../../Providers/CameraProvider/WorldCameraFinderProvider");
const BillboardRotationCalculator_1 = require("./BillboardRotationCalculator");
var RotationAxis;
(function (RotationAxis) {
    RotationAxis[RotationAxis["X"] = 0] = "X";
    RotationAxis[RotationAxis["Y"] = 1] = "Y";
    RotationAxis[RotationAxis["Z"] = 2] = "Z";
})(RotationAxis || (exports.RotationAxis = RotationAxis = {}));
const rotationAxes = [RotationAxis.X, RotationAxis.Y, RotationAxis.Z];
const VEC3_UP = vec3.up();
const TAG = 'BillboardController';
class BillboardController {
    constructor(config) {
        var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m;
        this.worldCameraProvider = WorldCameraFinderProvider_1.default.getInstance();
        // The target will rotate according to the camera's position for X/Y-axes rotation, camera's rotation for Z-axis rotation.
        this.cameraTransform = this.worldCameraProvider.getTransform();
        // We wait until the first update to set the rotation due to an inaccuracy of transforms on first frame.
        this.firstUpdate = true;
        this.target = config.target;
        this.targetTransform = this.target.getTransform();
        // Set up the rotation calculators to rotate along the axes with specific behavior.
        this.xAxisCalculator = new BillboardRotationCalculator_1.default({
            axis: RotationAxis.X,
            axisEnabled: config.xAxisEnabled,
            axisBufferRadians: MathUtils.DegToRad * ((_b = (_a = config.axisBufferDegrees) === null || _a === void 0 ? void 0 : _a.x) !== null && _b !== void 0 ? _b : 0),
            axisEasing: (_d = (_c = config.axisEasing) === null || _c === void 0 ? void 0 : _c.x) !== null && _d !== void 0 ? _d : 1,
            duration: config.duration,
        });
        this.yAxisCalculator = new BillboardRotationCalculator_1.default({
            axis: RotationAxis.Y,
            axisEnabled: config.yAxisEnabled,
            axisBufferRadians: MathUtils.DegToRad * ((_f = (_e = config.axisBufferDegrees) === null || _e === void 0 ? void 0 : _e.y) !== null && _f !== void 0 ? _f : 0),
            axisEasing: (_h = (_g = config.axisEasing) === null || _g === void 0 ? void 0 : _g.y) !== null && _h !== void 0 ? _h : 1,
            duration: config.duration,
        });
        this.zAxisCalculator = new BillboardRotationCalculator_1.default({
            axis: RotationAxis.Z,
            axisEnabled: config.zAxisEnabled,
            axisBufferRadians: MathUtils.DegToRad * ((_k = (_j = config.axisBufferDegrees) === null || _j === void 0 ? void 0 : _j.z) !== null && _k !== void 0 ? _k : 0),
            axisEasing: (_m = (_l = config.axisEasing) === null || _l === void 0 ? void 0 : _l.z) !== null && _m !== void 0 ? _m : 1,
            duration: config.duration,
        });
        this.updateEvent = config.script.createEvent('UpdateEvent');
        this.updateEvent.bind(this.onUpdate.bind(this));
    }
    enableAxisRotation(axis, enabled) {
        let axisCalculator;
        switch (axis) {
            case RotationAxis.X:
                axisCalculator = this.xAxisCalculator;
                break;
            case RotationAxis.Y:
                axisCalculator = this.yAxisCalculator;
                break;
            case RotationAxis.Z:
                axisCalculator = this.zAxisCalculator;
                break;
        }
        axisCalculator.axisEnabled = enabled;
    }
    get axisEasing() {
        return new vec3(this.xAxisCalculator.axisEasing, this.yAxisCalculator.axisEasing, this.zAxisCalculator.axisEasing);
    }
    set axisEasing(easing) {
        this.xAxisCalculator.axisEasing = easing.x;
        this.yAxisCalculator.axisEasing = easing.y;
        this.zAxisCalculator.axisEasing = easing.z;
    }
    get axisBufferDegrees() {
        return new vec3(MathUtils.RadToDeg * this.xAxisCalculator.axisBufferRadians, MathUtils.RadToDeg * this.yAxisCalculator.axisBufferRadians, MathUtils.RadToDeg * this.zAxisCalculator.axisBufferRadians);
    }
    set axisBufferDegrees(bufferDegrees) {
        this.xAxisCalculator.axisBufferRadians =
            MathUtils.DegToRad * bufferDegrees.x;
        this.yAxisCalculator.axisBufferRadians =
            MathUtils.DegToRad * bufferDegrees.y;
        this.zAxisCalculator.axisBufferRadians =
            MathUtils.DegToRad * bufferDegrees.z;
    }
    // The following functions aid with getting unit vectors relative to the target's current rotation.
    getForwardVector() {
        return this.targetTransform.forward;
    }
    getUpVector() {
        return this.targetTransform.up;
    }
    getRightVector() {
        return this.targetTransform.right;
    }
    // Returns a unit vector aligned with the line from the target's center to the camera for X/Y-axes rotation.
    getTargetToCameraVector() {
        return this.cameraTransform
            .getWorldPosition()
            .sub(this.targetTransform.getWorldPosition())
            .normalize();
    }
    // Returns the up vector of a camera for Z-axis rotation.
    getCameraUpVector() {
        return this.cameraTransform.up;
    }
    // Rotates the target about each enabled axis separately.
    onUpdate() {
        if (this.firstUpdate) {
            this.firstUpdate = false;
            this.resetRotation();
            return;
        }
        let targetToCamera;
        for (const axis of rotationAxes) {
            let rotationQuaternion;
            if (axis === RotationAxis.X || axis === RotationAxis.Y) {
                if (!targetToCamera) {
                    targetToCamera = this.getTargetToCameraVector();
                }
            }
            switch (axis) {
                case RotationAxis.X:
                    rotationQuaternion = this.xAxisCalculator.getRotation(this.getRightVector(), this.getForwardVector(), targetToCamera, this.getUpVector());
                    break;
                case RotationAxis.Y:
                    rotationQuaternion = this.yAxisCalculator.getRotation(VEC3_UP, this.getForwardVector(), targetToCamera, this.getRightVector().uniformScale(-1));
                    break;
                case RotationAxis.Z:
                    rotationQuaternion = this.zAxisCalculator.getRotation(this.getForwardVector(), this.getUpVector(), this.getCameraUpVector(), this.getRightVector());
                    break;
                default:
                    throw new Error(`Invalid axis: ${axis}`);
            }
            this.targetTransform.setWorldRotation(rotationQuaternion.multiply(this.targetTransform.getWorldRotation()));
        }
    }
    resetRotation() {
        for (const axis of rotationAxes) {
            let rotationQuaternion;
            let targetToCamera;
            if (axis === RotationAxis.X || axis === RotationAxis.Y) {
                if (!targetToCamera) {
                    targetToCamera = this.getTargetToCameraVector();
                }
            }
            switch (axis) {
                case RotationAxis.X:
                    rotationQuaternion = this.xAxisCalculator.resetRotation(this.getRightVector(), this.getForwardVector(), targetToCamera, this.getUpVector());
                    break;
                case RotationAxis.Y:
                    rotationQuaternion = this.yAxisCalculator.resetRotation(VEC3_UP, this.getForwardVector(), targetToCamera, this.getRightVector().uniformScale(-1));
                    break;
                case RotationAxis.Z:
                    rotationQuaternion = this.zAxisCalculator.resetRotation(this.getForwardVector(), this.getUpVector(), this.getCameraUpVector(), this.getRightVector());
                    break;
                default:
                    throw new Error(`Invalid axis: ${axis}`);
            }
            this.targetTransform.setWorldRotation(rotationQuaternion.multiply(this.targetTransform.getWorldRotation()));
        }
    }
}
exports.default = BillboardController;
//# sourceMappingURL=BillboardController.js.map