"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MouseInteractor = void 0;
var __selfType = requireType("./MouseInteractor");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const BaseInteractor_1 = require("../Interactor/BaseInteractor");
const Interactor_1 = require("../Interactor/Interactor");
const MouseTargetProvider_1 = require("../Interactor/MouseTargetProvider");
const TouchRayProvider_1 = require("../Interactor/TouchRayProvider");
const TARGETING_VOLUME_MULTIPLIER = 1;
/**
 * {@link Interactor} implementation used for touch bases interactions
 * to interact with {@link Interactable} components with the mouse cursor
 * in preview window of Lens Studio
 *
 * There are no events for mouse hover in Lens Studio so this class uses some technics to
 * achieve both hover and trigger events.
 */
let MouseInteractor = class MouseInteractor extends BaseInteractor_1.default {
    onAwake() {
        this.defineSceneEvents();
        this.defineTouchEvents();
        this.inputType = Interactor_1.InteractorInputType.Mouse;
        this.touchRayProvider = new TouchRayProvider_1.TouchRayProvider(this, this.maxRaycastDistance);
        this.mouseTargetProvider = new MouseTargetProvider_1.default(this, {
            rayProvider: this.touchRayProvider,
            maxRayDistance: this.maxRaycastDistance,
            targetingVolumeMultiplier: TARGETING_VOLUME_MULTIPLIER,
            shouldPreventTargetUpdate: () => {
                return this.currentInteractable !== null && this.isDown;
            },
            spherecastRadii: this.spherecastRadii,
            spherecastDistanceThresholds: this.spherecastDistanceThresholds,
        });
    }
    /**
     * @inheritdoc
     */
    get startPoint() {
        return this.mouseTargetProvider.startPoint;
    }
    /**
     * @inheritdoc
     */
    get endPoint() {
        return this.mouseTargetProvider.endPoint;
    }
    /**
     * @inheritdoc
     */
    get direction() {
        return this.mouseTargetProvider.direction;
    }
    /**
     * @inheritdoc
     */
    get distanceToTarget() {
        var _a, _b;
        return ((_b = (_a = this.mouseTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.hit.distance) !== null && _b !== void 0 ? _b : null);
    }
    /**
     * @inheritdoc
     */
    get targetHitPosition() {
        var _a, _b;
        return ((_b = (_a = this.mouseTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.hit.position) !== null && _b !== void 0 ? _b : null);
    }
    get targetHitInfo() {
        var _a;
        return (_a = this.mouseTargetProvider.currentInteractableHitInfo) !== null && _a !== void 0 ? _a : null;
    }
    /**
     * @inheritdoc
     */
    get activeTargetingMode() {
        return this.mouseTargetingMode;
    }
    /**
     * @inheritdoc
     */
    get maxRaycastDistance() {
        return this._maxRaycastDistance;
    }
    /**
     * @inheritdoc
     */
    get orientation() {
        return quat.quatIdentity();
    }
    /** @inheritdoc */
    get interactionStrength() {
        return this.currentTrigger === Interactor_1.InteractorTriggerType.Select ? 1 : 0.5;
    }
    /**
     * Set if the Interactor is should draw a debug gizmo of collider/raycasts in the scene.
     */
    set drawDebug(debug) {
        this._drawDebug = debug;
        this.mouseTargetProvider.drawDebug = debug;
    }
    /**
     * @returns if the Interactor is currently drawing a debug gizmo of collider/raycasts in the scene.
     */
    get drawDebug() {
        return this._drawDebug;
    }
    /**
     * @inheritdoc
     */
    isActive() {
        return this.enabled;
    }
    /**
     * @inheritdoc
     */
    isTargeting() {
        return this.touchRayProvider.isAvailable();
    }
    /** @inheritdoc */
    updateState() {
        var _a, _b;
        super.updateState();
        if (!this.isActive()) {
            return;
        }
        this.mouseTargetProvider.update();
        this.currentInteractable =
            (_b = (_a = this.mouseTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.interactable) !== null && _b !== void 0 ? _b : null;
        this.currentTrigger = this.isDown
            ? Interactor_1.InteractorTriggerType.Select
            : Interactor_1.InteractorTriggerType.None;
        this.updateDragVector();
    }
    clearCurrentHitInfo() {
        this.mouseTargetProvider.clearCurrentInteractableHitInfo();
    }
    defineSceneEvents() {
        this.createEvent('OnEnableEvent').bind(() => {
            this.enabled = true;
        });
        this.createEvent('OnDisableEvent').bind(() => {
            this.enabled = false;
        });
    }
    defineTouchEvents() {
        this.createEvent('TouchStartEvent').bind((...args) => this.onTouchStartEvent(...args));
        this.createEvent('TouchEndEvent').bind((...args) => this.onTouchEndEvent(...args));
    }
    onTouchStartEvent(ev) {
        this.isDown = true;
    }
    onTouchEndEvent(ev) {
        this.isDown = false;
    }
    __initialize() {
        super.__initialize();
        this.isDown = false;
        if (!global.deviceInfoSystem.isEditor()) {
            this.interactionManager.deregisterInteractor(this);
            this.enabled = false;
            return;
        }
    }
};
exports.MouseInteractor = MouseInteractor;
exports.MouseInteractor = MouseInteractor = __decorate([
    component
], MouseInteractor);
//# sourceMappingURL=MouseInteractor.js.map