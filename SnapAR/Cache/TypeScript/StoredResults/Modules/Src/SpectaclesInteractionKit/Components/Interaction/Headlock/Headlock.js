"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Headlock = void 0;
var __selfType = requireType("./Headlock");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const HeadlockController_1 = require("./HeadlockController");
/*
 * Headlock allows an object to move to follow the camera.
 */
let Headlock = class Headlock extends BaseScriptComponent {
    onAwake() {
        const headlockConfig = {
            script: this,
            target: this.getSceneObject(),
            distance: this.distance,
            xzEnabled: this.xzEnabled,
            xzEasing: this.xzEasing,
            yEnabled: this.yEnabled,
            yEasing: this.yEasing,
            translationBuffer: this.translationBuffer,
            lockedPitch: this.lockedPitch,
            pitchEasing: this.pitchEasing,
            pitchOffsetDegrees: this.pitchOffsetDegrees,
            pitchBufferDegrees: this.pitchBufferDegrees,
            lockedYaw: this.lockedYaw,
            yawEasing: this.yawEasing,
            yawOffsetDegrees: this.yawOffsetDegrees,
            yawBufferDegrees: this.yawBufferDegrees,
            headlockComponent: this,
        };
        this.controller = new HeadlockController_1.default(headlockConfig);
    }
    /**
     * Get how far the SceneObject will be from the user.
     */
    get distance() {
        return this._distance;
    }
    /**
     * Set how far the SceneObject will be from the user.
     */
    set distance(distance) {
        if (distance === this._distance) {
            return;
        }
        this._distance = distance;
        this.controller.distance = distance;
    }
    /**
     * Get if the camera will follow when the user moves their head along XZ-plane. For most cases, this should stay enabled.
     */
    get xzEnabled() {
        return this._xzEnabled;
    }
    /**
     * Sets if the camera will follow when the user moves their head along XZ-plane. For most cases, this should stay enabled.
     */
    set xzEnabled(enabled) {
        if (enabled === this._xzEnabled) {
            return;
        }
        this._xzEnabled = enabled;
        this.controller.xzEnabled = enabled;
    }
    /**
     * Get how fast the camera will follow along the XZ-plane, 0.1 for delayed follow, 1 for instant follow.
     */
    get xzEasing() {
        return this._xzEasing;
    }
    /**
     * Set how fast the camera will follow along the XZ-plane, 0.1 for delayed follow, 1 for instant follow.
     */
    set xzEasing(easing) {
        if (easing === this._distance) {
            return;
        }
        this._xzEasing = easing;
        this.controller.xzEasing = easing;
    }
    /**
     * Get if the camera will follow when the user moves their head along Y-axis. For most cases, this should stay enabled.
     */
    get yEnabled() {
        return this._yEnabled;
    }
    /**
     * Set if the camera will follow when the user moves their head along Y-axis. For most cases, this should stay enabled.
     */
    set yEnabled(enabled) {
        if (enabled === this._yEnabled) {
            return;
        }
        this._yEnabled = enabled;
        this.controller.yEnabled = enabled;
    }
    /**
     * Get how fast the camera will follow along the Y-axis, 0.1 for delayed follow, 1 for instant follow.
     */
    get yEasing() {
        return this._yEasing;
    }
    /**
     * Set how fast the camera will follow along the Y-axis, 0.1 for delayed follow, 1 for instant follow.
     */
    set yEasing(easing) {
        if (easing === this._yEasing) {
            return;
        }
        this._yEasing = easing;
        this.controller.yEasing = easing;
    }
    /**
     * Get the magnitude of change (in centimeters) needed to activate a translation for the target to follow the user's head translation.
     */
    get translationBuffer() {
        return this._translationBuffer;
    }
    /**
     * Set the magnitude of change (in centimeters) needed to activate a translation for the target to follow the user's head translation. To keep the SceneObject from 'wobbling' when the user has an unstable head, a small buffer is recommended rather than 0.
     */
    set translationBuffer(buffer) {
        if (buffer === this._translationBuffer) {
            return;
        }
        this._translationBuffer = buffer;
        this.controller.translationBuffer = buffer;
    }
    /**
     * Get if the camera will follow when the user moves their head along the pitch-axis (looking up/down)
     */
    get lockedPitch() {
        return this._lockedPitch;
    }
    /**
     * Set if the camera will follow when the user moves their head along the pitch-axis (looking up/down)
     */
    set lockedPitch(locked) {
        if (locked === this._lockedPitch) {
            return;
        }
        this._lockedPitch = locked;
        this.controller.unlockPitch = !locked;
    }
    /**
     * Get how many degrees of offset from the center point should the target sit. Positive values place the element below the center.
     */
    get pitchOffsetDegrees() {
        return this._pitchOffsetDegrees;
    }
    /**
     * Set how many degrees of offset from the center point should the target sit. Positive values place the element below the center.
     */
    set pitchOffsetDegrees(degrees) {
        if (degrees === this._pitchOffsetDegrees) {
            return;
        }
        this._pitchOffsetDegrees = degrees;
        this.controller.pitchOffsetDegrees = degrees;
    }
    /**
     * Get how fast the camera will follow along the pitch-axis, 0.1 for delayed follow, 1 for instant follow.
     */
    get pitchEasing() {
        return this._pitchEasing;
    }
    /**
     * Set how fast the camera will follow along the pitch-axis, 0.1 for delayed follow, 1 for instant follow.
     */
    set pitchEasing(easing) {
        if (easing === this._pitchEasing) {
            return;
        }
        this._pitchEasing = easing;
        this.controller.pitchEasing = easing;
    }
    /**
     * Get how many degrees of leeway along each direction (up/down) before change starts to occur.
     */
    get pitchBufferDegrees() {
        return this._pitchBufferDegrees;
    }
    /**
     * Set how many degrees of leeway along each direction (up/down) before change starts to occur.
     */
    set pitchBufferDegrees(degrees) {
        if (degrees === this._pitchBufferDegrees) {
            return;
        }
        this._pitchBufferDegrees = degrees;
        this.controller.pitchBufferDegrees = degrees;
    }
    /**
     * Get if the camera will follow when the user moves their head along the yaw-axis (looking left/right)
     */
    get lockedYaw() {
        return this._lockedYaw;
    }
    /**
     * Set if the camera will follow when the user moves their head along the yaw-axis (looking left/right)
     */
    set lockedYaw(locked) {
        if (locked === this._lockedYaw) {
            return;
        }
        this._lockedYaw = locked;
        this.controller.unlockYaw = !locked;
    }
    /**
     * Get how many degrees of offset from the center point should the target sit. Positive values place the element to the left.
     */
    get yawOffsetDegrees() {
        return this._yawOffsetDegrees;
    }
    /**
     * Set how many degrees of offset from the center point should the target sit. Positive values place the element to the left.
     */
    set yawOffsetDegrees(degrees) {
        if (degrees === this._yawOffsetDegrees) {
            return;
        }
        this._yawOffsetDegrees = degrees;
        this.controller.yawOffsetDegrees = degrees;
    }
    /**
     * Get how fast the camera will follow along the yaw-axis, 0.1 for delayed follow, 1 for instant follow.
     */
    get yawEasing() {
        return this._yawEasing;
    }
    /**
     * Set how fast the camera will follow along the yaw-axis, 0.1 for delayed follow, 1 for instant follow.
     */
    set yawEasing(easing) {
        if (easing === this._yawEasing) {
            return;
        }
        this._yawEasing = easing;
        this.controller.yawEasing = easing;
    }
    /**
     * Get how many degrees of leeway along each direction (left/right) before change starts to occur.
     */
    get yawBufferDegrees() {
        return this._yawBufferDegrees;
    }
    /**
     * Set how many degrees of leeway along each direction (left/right) before change starts to occur.
     */
    set yawBufferDegrees(degrees) {
        if (degrees === this._yawBufferDegrees) {
            return;
        }
        this._yawBufferDegrees = degrees;
        this.controller.yawBufferDegrees = degrees;
    }
    __initialize() {
        super.__initialize();
        this.
        /**
         * Snaps the object to its exact desired position, regardless of easing, unlocks, buffers, etc. Should be used after modifying values that affect the desired position (such as offset, distance) to snap the object into place without having a strange path.
         */
        snapToOffsetPosition = () => {
            this.controller.resetPosition();
        };
    }
};
exports.Headlock = Headlock;
exports.Headlock = Headlock = __decorate([
    component
], Headlock);
//# sourceMappingURL=Headlock.js.map