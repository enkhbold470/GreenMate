"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.InteractorLineVisual = void 0;
var __selfType = requireType("./InteractorLineVisual");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const InteractionManager_1 = require("../../../Core/InteractionManager/InteractionManager");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const WorldCameraFinderProvider_1 = require("../../../Providers/CameraProvider/WorldCameraFinderProvider");
const animate_1 = require("../../../Utils/animate");
const color_1 = require("../../../Utils/color");
const InteractorLineRenderer_1 = require("./InteractorLineRenderer");
const FADE_DURATION_SECS = 0.21;
const TAG = 'InteractorLineVisual';
/**
 * InteractorLineVisual uses a modified line renderer to display the ray interactor visual
 * Uses interactor locus and direction
 */
let InteractorLineVisual = class InteractorLineVisual extends BaseScriptComponent {
    /**
     * Sets whether the visual can be shown, so developers can show/hide the ray in certain parts of their lens.
     */
    set isEnabled(isEnabled) {
        this._enabled = isEnabled;
    }
    /**
     * Gets whether the visual is active (can be shown if hand is in frame and we're in far field targeting mode).
     */
    get isEnabled() {
        return this._enabled;
    }
    /**
     * Sets how the visuals for the line drawer should be shown.
     */
    set visualStyle(style) {
        this.line.visualStyle = style;
    }
    /**
     * Gets the current visual style.
     */
    get visualStyle() {
        return this.line.visualStyle;
    }
    /**
     * Sets the color of the visual from the start.
     */
    set beginColor(color) {
        this.line.startColor = (0, color_1.withAlpha)(color, 1);
    }
    /**
     * Gets the color of the visual from the start.
     */
    get beginColor() {
        return (0, color_1.withoutAlpha)(this.line.startColor);
    }
    /**
     * Sets the color of the visual from the end.
     */
    set endColor(color) {
        this.line.endColor = (0, color_1.withAlpha)(color, 1);
    }
    /**
     * Gets the color of the visual from the end.
     */
    get endColor() {
        return (0, color_1.withoutAlpha)(this.line.endColor);
    }
    onAwake() {
        this.transform = this.sceneObject.getTransform();
        this.defaultScale = this.transform.getWorldScale();
        this.line = new InteractorLineRenderer_1.default({
            material: this.lineMaterial,
            points: [vec3.zero(), vec3.up().uniformScale(this.maxLength)],
            startColor: (0, color_1.withAlpha)(this._beginColor, 1),
            endColor: (0, color_1.withAlpha)(this._endColor, 1),
            startWidth: this.lineWidth,
            endWidth: this.lineWidth,
        });
        this.line.getSceneObject().setParent(this.sceneObject);
        if (this.lineStyle !== undefined) {
            this.line.visualStyle = this.lineStyle;
        }
        if (this.lineLength && this.lineLength > 0) {
            this.defaultScale = new vec3(1, this.lineLength / this.maxLength, 1);
        }
        this.showVisual(false);
        this.defineScriptEvents();
    }
    defineScriptEvents() {
        this.createEvent('OnEnableEvent').bind(() => {
            this.isEnabled = true;
        });
        this.createEvent('OnDisableEvent').bind(() => {
            this.isEnabled = false;
        });
        this.createEvent('UpdateEvent').bind(() => {
            this.update();
        });
        this.createEvent('OnDestroyEvent').bind(() => {
            this.onDestroy();
        });
    }
    showVisual(isShown) {
        if (this.isShown === isShown) {
            return;
        }
        this.isShown = isShown;
        this.animationCancelSet();
        (0, animate_1.default)({
            cancelSet: this.animationCancelSet,
            duration: FADE_DURATION_SECS,
            easing: 'ease-out-cubic',
            update: (t) => {
                this.line.opacity = isShown ? t : 1 - t;
            },
        });
    }
    rotationFromOrthogonal(right, up, fwd) {
        const vec3to4 = (v3) => new vec4(v3.x, v3.y, v3.z, 0);
        const rotationMatrix = new mat4();
        rotationMatrix.column0 = vec3to4(right);
        rotationMatrix.column1 = vec3to4(up);
        rotationMatrix.column2 = vec3to4(fwd);
        return quat.fromEulerVec(rotationMatrix.extractEulerAngles());
    }
    /**
     * Calculates the world scale of the line visual, if distance is valid (greater than the minimum distance to show the visual).
     * If an item is targeted directly and the distance is valid, returns a vec3 representing the ray scaled to the distance to the target.
     * If an item is targeted indirectly, returns the default scale so as not to throw the user off.
     * Otherwise, returns default scale if no item is targeted, or null if the distance is not valid.
     */
    getScale() {
        var _a, _b, _c;
        const distance = (_b = (_a = this.interactor) === null || _a === void 0 ? void 0 : _a.distanceToTarget) !== null && _b !== void 0 ? _b : null;
        if (distance === null) {
            return this.defaultScale;
        }
        return ((_c = this.interactor) === null || _c === void 0 ? void 0 : _c.activeTargetingMode) === Interactor_1.TargetingMode.Direct ||
            this.shouldStick
            ? new vec3(1, distance / this.maxLength, 1)
            : this.defaultScale;
    }
    /**
     * Updates the line visual each frame
     */
    update() {
        if (this.interactor === null ||
            !this.isEnabled ||
            !this.interactor.enabled ||
            this.interactor.activeTargetingMode !== Interactor_1.TargetingMode.Indirect ||
            !this.interactor.isTargeting()) {
            this.showVisual(false);
            return;
        }
        this.updateActiveCursor();
    }
    /**
     * Moves and rotates cursor based on locus and direction updates
     * Scales cursor length to nearest interactable if it is being hit
     */
    updateActiveCursor() {
        if (!this.interactor) {
            return;
        }
        // Hide ray if the scale is below the minimum distance, or if locus/direction aren't provided.
        const distanceScale = this.getScale();
        const locus = this.interactor.startPoint;
        let direction = this.interactor.direction;
        if (distanceScale === null || locus === null || direction === null) {
            this.showVisual(false);
            return;
        }
        this.transform.setWorldPosition(locus);
        this.transform.setWorldScale(distanceScale);
        if (this.shouldStick &&
            (Interactor_1.InteractorTriggerType.Select & this.interactor.currentTrigger) !== 0) {
            const target = this.interactor.currentInteractable;
            if (target) {
                const targetPos = target.sceneObject
                    .getTransform()
                    .getWorldPosition();
                direction = targetPos.sub(locus).normalize();
            }
        }
        // Create rotation from orthogonal vectors & set world rotation
        const locusToCamera = this.camera.getWorldPosition().sub(locus)
            .normalize();
        const newRight = direction.cross(locusToCamera).normalize();
        const newForward = newRight.cross(direction);
        this.transform.setWorldRotation(this.rotationFromOrthogonal(newRight, direction, newForward));
        this.showVisual(true);
    }
    /**
     * Destroys cursor & line renderer when the custom component is destroyed.
     */
    onDestroy() {
        var _a;
        (_a = this.line) === null || _a === void 0 ? void 0 : _a.destroy();
        this.sceneObject.destroy();
    }
    get interactor() {
        var _a;
        return (_a = this._interactor) !== null && _a !== void 0 ? _a : null;
    }
    __initialize() {
        super.__initialize();
        this.camera = WorldCameraFinderProvider_1.default.getInstance();
        this.interactionManager = InteractionManager_1.InteractionManager.getInstance();
        this._enabled = true;
        this.isShown = false;
        this.animationCancelSet = new animate_1.CancelSet();
        this.defaultScale = new vec3(1, 1, 1);
        this.maxLength = 500;
    }
};
exports.InteractorLineVisual = InteractorLineVisual;
exports.InteractorLineVisual = InteractorLineVisual = __decorate([
    component
], InteractorLineVisual);
//# sourceMappingURL=InteractorLineVisual.js.map