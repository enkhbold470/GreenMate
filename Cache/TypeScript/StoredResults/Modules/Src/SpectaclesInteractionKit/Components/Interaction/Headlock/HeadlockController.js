"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RotationAxis = void 0;
const WorldCameraFinderProvider_1 = require("../../../Providers/CameraProvider/WorldCameraFinderProvider");
const HeadlockRotationCalculator_1 = require("./HeadlockRotationCalculator");
const HeadlockTranslationCalculator_1 = require("./HeadlockTranslationCalculator");
var RotationAxis;
(function (RotationAxis) {
    RotationAxis[RotationAxis["Pitch"] = 0] = "Pitch";
    RotationAxis[RotationAxis["Yaw"] = 1] = "Yaw";
})(RotationAxis || (exports.RotationAxis = RotationAxis = {}));
const rotationAxes = [RotationAxis.Pitch, RotationAxis.Yaw];
const TAG = 'HeadlockController';
const DEFAULT_DURATION = 0.033;
class DefaultHeadlockController {
    constructor(config) {
        var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m, _o, _p, _q, _r;
        this.config = config;
        this.worldCameraProvider = WorldCameraFinderProvider_1.default.getInstance();
        // The target will move along a sphere according to the camera's rotation, maintaining the same pitch / yaw offset wherever the user looks.
        this.cameraTransform = this.worldCameraProvider.getTransform();
        this.target = config.target;
        this.targetTransform = this.target.getTransform();
        this.headlockComponent = config.headlockComponent;
        this.headlocked = true;
        this._distance = config.distance;
        // Set up the translation calculator to center the sphere on the user's head with configurable behavior.
        this.translationCalculator = new HeadlockTranslationCalculator_1.default({
            center: this.cameraTransform.getWorldPosition(),
            duration: (_a = config.duration) !== null && _a !== void 0 ? _a : DEFAULT_DURATION,
            xzEnabled: (_b = config.xzEnabled) !== null && _b !== void 0 ? _b : true,
            xzEasing: (_c = config.xzEasing) !== null && _c !== void 0 ? _c : 1,
            yEnabled: (_d = config.yEnabled) !== null && _d !== void 0 ? _d : true,
            yEasing: (_e = config.yEasing) !== null && _e !== void 0 ? _e : 1,
            translationBuffer: (_f = config.translationBuffer) !== null && _f !== void 0 ? _f : 0,
        });
        // Set up the rotation calculators to rotate the target along the sphere about the axes with configurable behavior.
        this.pitchCalculator = new HeadlockRotationCalculator_1.default({
            distance: this.distance,
            axis: RotationAxis.Pitch,
            duration: (_g = config.duration) !== null && _g !== void 0 ? _g : DEFAULT_DURATION,
            axisEnabled: (_h = config.lockedPitch) !== null && _h !== void 0 ? _h : true,
            axisEasing: (_j = config.pitchEasing) !== null && _j !== void 0 ? _j : 1,
            axisOffsetRadians: MathUtils.DegToRad * ((_k = config.pitchOffsetDegrees) !== null && _k !== void 0 ? _k : 0),
            axisBufferRadians: MathUtils.DegToRad * ((_l = config.pitchBufferDegrees) !== null && _l !== void 0 ? _l : 0),
        });
        this.yawCalculator = new HeadlockRotationCalculator_1.default({
            distance: this.distance,
            axis: RotationAxis.Yaw,
            duration: (_m = config.duration) !== null && _m !== void 0 ? _m : DEFAULT_DURATION,
            axisEnabled: (_o = config.lockedYaw) !== null && _o !== void 0 ? _o : true,
            axisEasing: (_p = config.yawEasing) !== null && _p !== void 0 ? _p : 1,
            axisOffsetRadians: MathUtils.DegToRad * ((_q = config.yawOffsetDegrees) !== null && _q !== void 0 ? _q : 0),
            axisBufferRadians: MathUtils.DegToRad * ((_r = config.yawBufferDegrees) !== null && _r !== void 0 ? _r : 0),
        });
        this.updateEvent = config.script.createEvent('UpdateEvent');
        this.enableEvent = config.script.createEvent('OnEnableEvent');
        this.updateEvent.bind(this.onUpdate.bind(this));
        // Whenever the script component or target object is re-enabled, reset the target to correct position.
        this.enableEvent.bind(this.resetPosition.bind(this));
        this.target.onEnabled.add(this.resetPosition.bind(this));
        this.resetPosition();
    }
    get distance() {
        return this._distance;
    }
    set distance(distance) {
        this._distance = distance;
        this.pitchCalculator.distance = distance;
        this.yawCalculator.distance = distance;
    }
    get xzEnabled() {
        return this.translationCalculator.xzEnable;
    }
    set xzEnabled(enabled) {
        this.translationCalculator.xzEnable = enabled;
    }
    get yEnabled() {
        return this.translationCalculator.yEnable;
    }
    set yEnabled(enabled) {
        this.translationCalculator.yEnable = enabled;
    }
    get xzEasing() {
        return this.translationCalculator.xzEasing;
    }
    set xzEasing(easing) {
        this.translationCalculator.xzEasing = easing;
    }
    get yEasing() {
        return this.translationCalculator.yEasing;
    }
    set yEasing(easing) {
        this.translationCalculator.yEasing = easing;
    }
    get translationBuffer() {
        return this.translationCalculator.translationBuffer;
    }
    set translationBuffer(distance) {
        this.translationCalculator.translationBuffer = distance;
    }
    get unlockPitch() {
        return !this.pitchCalculator.axisEnabled;
    }
    set unlockPitch(unlocked) {
        this.pitchCalculator.axisEnabled = !unlocked;
    }
    get pitchOffsetDegrees() {
        return MathUtils.RadToDeg * this.pitchCalculator.axisOffsetRadians;
    }
    set pitchOffsetDegrees(offsetDegrees) {
        this.pitchCalculator.axisOffsetRadians = MathUtils.DegToRad * offsetDegrees;
    }
    get pitchEasing() {
        return this.pitchCalculator.axisEasing;
    }
    set pitchEasing(easing) {
        this.pitchCalculator.axisEasing = easing;
    }
    get pitchBufferDegrees() {
        return MathUtils.RadToDeg * this.pitchCalculator.axisBufferRadians;
    }
    set pitchBufferDegrees(bufferDegrees) {
        this.pitchCalculator.axisBufferRadians = MathUtils.DegToRad * bufferDegrees;
    }
    get unlockYaw() {
        return !this.yawCalculator.axisEnabled;
    }
    set unlockYaw(unlocked) {
        this.yawCalculator.axisEnabled = !unlocked;
    }
    get yawOffsetDegrees() {
        return MathUtils.RadToDeg * this.yawCalculator.axisOffsetRadians;
    }
    set yawOffsetDegrees(offsetDegrees) {
        this.yawCalculator.axisOffsetRadians = MathUtils.DegToRad * offsetDegrees;
    }
    get yawEasing() {
        return this.yawCalculator.axisEasing;
    }
    set yawEasing(easing) {
        this.yawCalculator.axisEasing = easing;
    }
    get yawBufferDegrees() {
        return MathUtils.RadToDeg * this.yawCalculator.axisBufferRadians;
    }
    set yawBufferDegrees(bufferDegrees) {
        this.yawCalculator.axisBufferRadians = MathUtils.DegToRad * bufferDegrees;
    }
    // Returns a NON-NORMALIZED unit vector aligned with the line to the target from the sphere's center for rotation along the sphere.
    getCenterToTargetVector() {
        return this.targetTransform
            .getWorldPosition()
            .sub(this.translationCalculator.getCenter());
    }
    // Gets the direction in which the user is facing.
    getFaceForwardVector() {
        return this.cameraTransform.back.normalize();
    }
    // Rotates the target about each enabled axis separately.
    onUpdate() {
        // If headlocking is currently disabled, do not update the target.
        if (!this.headlocked) {
            return;
        }
        // Move the sphere around the user's head and updates the target to maintain the same angle.
        const translationOffset = this.translationCalculator.updateCenter(this.cameraTransform.getWorldPosition());
        this.targetTransform.setWorldPosition(translationOffset.add(this.targetTransform.getWorldPosition()));
        // Rotate the target along the sphere to reach the desired offsets.
        for (const axis of rotationAxes) {
            let rotationOffset;
            switch (axis) {
                // Head tilt is to be ignored for headlocking purposes, thus some vectors must be flattened on the XZ-plane if not already.
                case RotationAxis.Pitch:
                    rotationOffset = this.pitchCalculator.getOffset(
                    // The pitch axis is the user's X-axis if yaw is enabled, otherwise use the world's X-axis.
                    this.headlockComponent.lockedYaw
                        ? this.cameraTransform.left.projectOnPlane(vec3.up()).normalize() // the axis vectors depend on if the other axis is enabled e.g. yaw disabled means we always use a constant right vector for pitch
                        : vec3.left(), this.getCenterToTargetVector(), vec3.up(), this.getFaceForwardVector(), this.cameraTransform.up);
                    break;
                case RotationAxis.Yaw:
                    rotationOffset = this.yawCalculator.getOffset(
                    // The yaw axis is the user's Y-axis projected onto a plane to prevent head-tilt from affecting positions if pitch is enabled, otherwise use the world's Y-axis.
                    this.headlockComponent.lockedPitch
                        ? this.cameraTransform.up.projectOnPlane(new vec3(this.cameraTransform.left.x, 0, this.cameraTransform.left.z))
                        : vec3.up(), this.getCenterToTargetVector(), this.cameraTransform.right.projectOnPlane(vec3.up()), this.getFaceForwardVector());
                    break;
                default:
                    throw new Error(`Invalid axis: ${axis}`);
            }
            this.targetTransform.setWorldPosition(rotationOffset.add(this.targetTransform.getWorldPosition()));
        }
    }
    setHeadlocked(headlocked) {
        this.headlocked = headlocked;
    }
    isHeadlocked() {
        return this.headlocked;
    }
    // Place the target at correct position according to offsets.
    resetPosition() {
        var _a, _b;
        let offset = this.getFaceForwardVector().uniformScale(this.distance);
        const pitchQuaternion = quat.angleAxis(MathUtils.DegToRad * ((_a = this.headlockComponent.pitchOffsetDegrees) !== null && _a !== void 0 ? _a : 0), vec3.left());
        offset = pitchQuaternion.multiplyVec3(offset);
        const yawQuaternion = quat.angleAxis(MathUtils.DegToRad * ((_b = this.headlockComponent.yawOffsetDegrees) !== null && _b !== void 0 ? _b : 0), vec3.up());
        offset = yawQuaternion.multiplyVec3(offset);
        this.targetTransform.setWorldPosition(this.cameraTransform.getWorldPosition().add(offset));
    }
}
exports.default = DefaultHeadlockController;
//# sourceMappingURL=HeadlockController.js.map