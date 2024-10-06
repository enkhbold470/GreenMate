"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MobileInteractor = void 0;
var __selfType = requireType("./MobileInteractor");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const InteractableManipulation_1 = require("../../Components/Interaction/InteractableManipulation/InteractableManipulation");
const SIK_1 = require("../../SIK");
const NativeLogger_1 = require("../../Utils/NativeLogger");
const BaseInteractor_1 = require("../Interactor/BaseInteractor");
const DragProvider_1 = require("../Interactor/DragProvider");
const IndirectTargetProvider_1 = require("../Interactor/IndirectTargetProvider");
const Interactor_1 = require("../Interactor/Interactor");
const MobileRayProvider_1 = require("../Interactor/MobileRayProvider");
const TAG = 'MobileInteractor';
// These thresholds are not for deciding when to invoke onDragStart, but rather to tell the MobileInteractor when to switch what type of drag to track.
const INITIAL_TOUCHPAD_SWITCH_THRESHOLD = 0.05; // Screen position units mapped from the phone's touch surface
const OVERRIDE_TOUCHPAD_SWITCH_THRESHOLD = 0.1; // Screen position units mapped from the phone's touch surface
const INITIAL_SIX_DOF_SWITCH_THRESHOLD = 3; // World units in c
const OVERRIDE_SIX_DOF_SWITCH_THRESHOLD = 20; // World units in c
const MANIPULATE_SIX_DOF_SWITCH_THRESHOLD = 2; // World units in c
/**
 * Interactor for the Mobile Controller
 */
let MobileInteractor = class MobileInteractor extends BaseInteractor_1.default {
    onAwake() {
        this.inputType = Interactor_1.InteractorInputType.Mobile;
        SIK_1.SIK.MobileInputData.filterPositionAndRotation =
            this.initializePositionAndRotationFilter;
        this.defineSceneEvents();
        this.defineTouchEvents();
        this.rayProvider = new MobileRayProvider_1.MobileRayProvider();
        this.indirectTargetProvider = new IndirectTargetProvider_1.default(this, {
            maxRayDistance: this.maxRaycastDistance,
            rayProvider: this.rayProvider,
            targetingVolumeMultiplier: this.indirectTargetingVolumeMultiplier,
            shouldPreventTargetUpdate: () => {
                return this.preventTargetUpdate();
            },
            spherecastRadii: this.spherecastRadii,
            spherecastDistanceThresholds: this.spherecastDistanceThresholds,
        });
    }
    get touchpadScrollSpeed() {
        return this._touchpadScrollSpeed;
    }
    /** @inheritdoc */
    get startPoint() {
        return this.indirectTargetProvider.startPoint;
    }
    /** @inheritdoc */
    get endPoint() {
        return this.indirectTargetProvider.endPoint;
    }
    /** @inheritdoc */
    get direction() {
        return this.indirectTargetProvider.direction;
    }
    /** @inheritdoc */
    get orientation() {
        return this.mobileInputData.rotation;
    }
    /** @inheritdoc */
    get distanceToTarget() {
        var _a, _b;
        return ((_b = (_a = this.indirectTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.hit.distance) !== null && _b !== void 0 ? _b : null);
    }
    /** @inheritdoc */
    get targetHitPosition() {
        var _a, _b;
        return ((_b = (_a = this.indirectTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.hit.position) !== null && _b !== void 0 ? _b : null);
    }
    /** @inheritdoc */
    get targetHitInfo() {
        var _a;
        return (_a = this.indirectTargetProvider.currentInteractableHitInfo) !== null && _a !== void 0 ? _a : null;
    }
    /** @inheritdoc */
    get activeTargetingMode() {
        return this.indirectTargetProvider.targetingMode;
    }
    /** @inheritdoc */
    get maxRaycastDistance() {
        return this._maxRaycastDistance;
    }
    /** @inheritdoc */
    get interactionStrength() {
        return this.touchpadStartPosition !== null ? 1 : 0;
    }
    /**
     * Set if the Interactor is should draw a debug gizmo of collider/raycasts in the scene.
     */
    set drawDebug(debug) {
        this._drawDebug = debug;
        this.indirectTargetProvider.drawDebug = debug;
    }
    /**
     * @returns if the Interactor is currently drawing a debug gizmo of collider/raycasts in the scene.
     */
    get drawDebug() {
        return this._drawDebug;
    }
    /**
     * @returns the current drag vector of the phone's SixDof position in world space.
     */
    get sixDofDragVector() {
        return this.sixDofDragProvider.currentDragVector;
    }
    /**
     * @returns the current drag vector of the phone's touchpad in normalized screen space (with bottom-left corner representing [0,0]).
     */
    get touchpadDragVector() {
        return this.touchpadDragProvider.currentDragVector;
    }
    /** @inheritdoc */
    updateState() {
        var _a, _b;
        super.updateState();
        if (!this.mobileInputData.isAvailable()) {
            return;
        }
        this.indirectTargetProvider.update();
        this.currentInteractable =
            (_b = (_a = this.indirectTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.interactable) !== null && _b !== void 0 ? _b : null;
        this.currentTrigger =
            this.touchpadStartPosition !== null
                ? Interactor_1.InteractorTriggerType.Select
                : Interactor_1.InteractorTriggerType.None;
        if ((this.currentTrigger & Interactor_1.InteractorTriggerType.Select) !== 0) {
            if (this.sixDofStartPosition === null) {
                this.sixDofStartPosition = this.sixDofSwitchPosition;
            }
            this.sixDofCurrentPosition = this.sixDofSwitchPosition;
        }
        else {
            this.sixDofCurrentPosition = this.sixDofStartPosition = null;
        }
        this.updateDragType();
        this.updateDragVector();
    }
    /** @inheritdoc */
    isTargeting() {
        return this.mobileInputData.isAvailable();
    }
    /** @inheritdoc */
    isActive() {
        return this.mobileInputData.isAvailable();
    }
    clearCurrentHitInfo() {
        this.indirectTargetProvider.clearCurrentInteractableHitInfo();
    }
    defineSceneEvents() {
        this.createEvent('OnDestroyEvent').bind(() => {
            this.release();
        });
    }
    defineTouchEvents() {
        this.createEvent('TouchStartEvent').bind((...args) => this.onTouchStartEvent(...args));
        this.createEvent('TouchMoveEvent').bind((...args) => this.onTouchMoveEvent(...args));
        this.createEvent('TouchEndEvent').bind((...args) => this.onTouchEndEvent());
    }
    onTouchStartEvent(ev) {
        this.touchpadCurrentPosition = this.touchpadStartPosition =
            ev.getTouchPosition();
        if (this.currentInteractable !== null) {
            this.isManipulating =
                this.currentInteractable.sceneObject.getComponent(InteractableManipulation_1.InteractableManipulation.getTypeName()) !== null;
        }
        if (!global.deviceInfoSystem.isEditor) {
            this.log.v('Mobile Interactor On Touch Start Event');
        }
    }
    onTouchMoveEvent(ev) {
        this.touchpadCurrentPosition = ev.getTouchPosition();
    }
    onTouchEndEvent() {
        this.touchpadStartPosition = this.touchpadCurrentPosition = null;
        this.dragType = null;
        this.dragProvider.clear();
        this.isManipulating = false;
        if (!global.deviceInfoSystem.isEditor) {
            this.log.v('Mobile Interactor On Touch End Event');
        }
    }
    preventTargetUpdate() {
        // If there's no current touch there's no trigger happening
        if (!this.touchpadStartPosition) {
            return false;
        }
        return true;
    }
    updateDragType() {
        var _a, _b;
        if (this.currentTrigger === Interactor_1.InteractorTriggerType.None) {
            return;
        }
        if (this.dragType !== Interactor_1.DragType.Touchpad &&
            this.touchpadStartPosition !== null &&
            this.touchpadCurrentPosition !== null &&
            ((_a = this.touchpadCurrentPosition) === null || _a === void 0 ? void 0 : _a.sub(this.touchpadStartPosition).length) >
                this.touchpadSwitchThreshold) {
            this.dragType = Interactor_1.DragType.Touchpad;
            return;
        }
        if (this.dragType !== Interactor_1.DragType.SixDof &&
            this.sixDofStartPosition !== null &&
            this.sixDofCurrentPosition !== null &&
            ((_b = this.sixDofCurrentPosition) === null || _b === void 0 ? void 0 : _b.sub(this.sixDofStartPosition).length) >
                this.sixDofSwitchThreshold) {
            this.dragType = Interactor_1.DragType.SixDof;
            return;
        }
    }
    clearDragProviders() {
        this.touchpadDragProvider.clear();
        this.sixDofDragProvider.clear();
        this.planecastDragProvider.clear();
    }
    updateDragVector() {
        var _a, _b, _c, _d, _e, _f;
        if ((this.currentTrigger & Interactor_1.InteractorTriggerType.Select) !== 0) {
            const touchpadDragVector = this.touchpadDragProvider.getDragVector(this.getTouchpadDragPoint(), (_b = (_a = this.currentInteractable) === null || _a === void 0 ? void 0 : _a.enableInstantDrag) !== null && _b !== void 0 ? _b : null);
            const sixDofDragVector = this.sixDofDragProvider.getDragVector(this.getSixDofDragPoint(), (_d = (_c = this.currentInteractable) === null || _c === void 0 ? void 0 : _c.enableInstantDrag) !== null && _d !== void 0 ? _d : null);
            this.currentDragVector = this.dragProvider.currentDragVector;
            this.planecastDragProvider.getDragVector(this.planecastPoint, (_f = (_e = this.currentInteractable) === null || _e === void 0 ? void 0 : _e.enableInstantDrag) !== null && _f !== void 0 ? _f : null);
        }
        else {
            this.currentDragVector = null;
            this.clearDragProviders();
        }
    }
    getDragPoint() {
        if (this.dragType === Interactor_1.DragType.SixDof) {
            return this.getSixDofDragPoint();
        }
        else if (this.dragType === Interactor_1.DragType.Touchpad) {
            return this.getTouchpadDragPoint();
        }
    }
    getSixDofDragPoint() {
        return this.endPoint;
    }
    getTouchpadDragPoint() {
        if (this.touchpadCurrentPosition !== null) {
            return new vec3(
            // Remap the touchpad space such that the bottom-left corner is [0,0] rather than the top-left corner.
            this.touchpadCurrentPosition.x, 1 - this.touchpadCurrentPosition.y, 0).uniformScale(this.touchpadScrollSpeed);
        }
        return null;
    }
    /**
     * At the beginning of interaction, the switch threshold should be lower to immediately start tracking the user's desired type of drag.
     * However if the user is already dragging via Touchpad, switching to drag via 6DoF should be more difficult to avoid accidental drag interruptions.
     * In the case of manipulation, we use a threshold for the startPosition of the ray instead as a design choice.
     */
    get sixDofSwitchThreshold() {
        if (this.isManipulating) {
            return MANIPULATE_SIX_DOF_SWITCH_THRESHOLD;
        }
        if (this.dragType === Interactor_1.DragType.Touchpad) {
            return OVERRIDE_SIX_DOF_SWITCH_THRESHOLD;
        }
        return INITIAL_SIX_DOF_SWITCH_THRESHOLD;
    }
    /**
     * At the beginning of interaction, the switch threshold should be lower to immediately start tracking the user's desired type of drag.
     * However if the user is already dragging via 6Dof, switching to drag via Touchpad should be more difficult to avoid accidental drag interruptions.
     */
    get touchpadSwitchThreshold() {
        if (this.dragType === Interactor_1.DragType.SixDof) {
            return OVERRIDE_TOUCHPAD_SWITCH_THRESHOLD;
        }
        return INITIAL_TOUCHPAD_SWITCH_THRESHOLD;
    }
    /**
     * If we are manipulating, we use the location of the phone as the start point.
     * Otherwise, we use the endpoint of the raycast.
     */
    get sixDofSwitchPosition() {
        return this.isManipulating ? this.startPoint : this.endPoint;
    }
    get dragType() {
        return this._dragType;
    }
    set dragType(type) {
        if (type === this.dragType) {
            return;
        }
        this._dragType = type;
        switch (type) {
            case Interactor_1.DragType.SixDof:
                this.dragProvider = this.sixDofDragProvider;
                // Reset the start position of Touchpad to accurately track when the user wants to switch to using Touchpad drag.
                this.touchpadStartPosition = this.touchpadCurrentPosition;
                break;
            case Interactor_1.DragType.Touchpad:
                this.dragProvider = this.touchpadDragProvider;
                // Reset the start position of 6DoF to accurately track when the user wants to switch to using 6DoF drag.
                this.sixDofStartPosition = this.sixDofCurrentPosition;
        }
    }
    __initialize() {
        super.__initialize();
        this._dragType = null;
        this.isManipulating = false;
        this.log = new NativeLogger_1.default(TAG);
        this.mobileInputData = SIK_1.SIK.MobileInputData;
        this.touchpadStartPosition = null;
        this.touchpadCurrentPosition = null;
        this.sixDofStartPosition = null;
        this.sixDofCurrentPosition = null;
        this.sixDofDragProvider = new DragProvider_1.DragProvider(this.indirectDragThreshold);
        this.touchpadDragProvider = new DragProvider_1.DragProvider(this.touchpadDragThreshold);
    }
};
exports.MobileInteractor = MobileInteractor;
exports.MobileInteractor = MobileInteractor = __decorate([
    component
], MobileInteractor);
//# sourceMappingURL=MobileInteractor.js.map