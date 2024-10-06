"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.HandInteractor = void 0;
var __selfType = requireType("./HandInteractor");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const SIK_1 = require("../../SIK");
const BaseInteractor_1 = require("../Interactor/BaseInteractor");
const DirectTargetProvider_1 = require("../Interactor/DirectTargetProvider");
const DragProvider_1 = require("../Interactor/DragProvider");
const HandRayProvider_1 = require("../Interactor/HandRayProvider");
const IndirectTargetProvider_1 = require("../Interactor/IndirectTargetProvider");
const Interactor_1 = require("../Interactor/Interactor");
const PokeTargetProvider_1 = require("../Interactor/PokeTargetProvider");
const TAG = 'HandInteractor';
const HANDUI_INTERACTION_DISTANCE_THRESHOLD_CM = 15;
/**
 * Provides the pointer & updates locus and direction on every frame if the pointer is active.
 * Eventually this will turn into a class encompassing both indirect and direct pointers.
 * Locus and direction are calculated with RaycastAnchorVariableShoulder or RaycastAnchorShoulder, depending on the information provided in the config.
 * Default is RaycastAnchorVariableShoulder, RaycastAnchorShoulder is older (from PXP)
 */
let HandInteractor = class HandInteractor extends BaseInteractor_1.default {
    onAwake() {
        this.transform = this.sceneObject.getTransform();
        this.inputType =
            this.handType === 'left'
                ? Interactor_1.InteractorInputType.LeftHand
                : Interactor_1.InteractorInputType.RightHand;
        this.hand = this.handProvider.getHand(this.handType);
        this.handRayProvider = new HandRayProvider_1.HandRayProvider({
            handType: this.handType,
            raycastAlgorithm: this.raycastAlgorithm,
        });
        this.indirectTargetProvider = new IndirectTargetProvider_1.default(this, {
            maxRayDistance: this.maxRaycastDistance,
            rayProvider: this.handRayProvider,
            targetingVolumeMultiplier: this.indirectTargetingVolumeMultiplier,
            shouldPreventTargetUpdate: () => {
                return this.preventTargetUpdate();
            },
            spherecastRadii: this.spherecastRadii,
            spherecastDistanceThresholds: this.spherecastDistanceThresholds,
        });
        this.indirectDragProvider = new DragProvider_1.DragProvider(this.indirectDragThreshold);
        if (this.directColliderEnterRadius >= this.directColliderExitRadius) {
            throw Error('The direct collider enter radius should be less than the exit radius for bistable threshold behavior.');
        }
        this.directTargetProvider = new DirectTargetProvider_1.DirectTargetProvider(this, {
            handType: this.handType,
            shouldPreventTargetUpdate: () => {
                return this.preventTargetUpdate();
            },
            debugEnabled: this.drawDebug,
            colliderEnterRadius: this.directColliderEnterRadius,
            colliderExitRadius: this.directColliderExitRadius,
        });
        this.directDragProvider = new DragProvider_1.DragProvider(this.directDragThreshold);
        this.pokeTargetProvider = new PokeTargetProvider_1.PokeTargetProvider({
            handType: this.handType,
            drawDebug: this.drawDebug,
        });
        this.activeTargetProvider = this.indirectTargetProvider;
        this.dragProvider = this.indirectDragProvider;
        this.defineSceneEvents();
    }
    /** @inheritdoc */
    get startPoint() {
        return this.activeTargetProvider.startPoint;
    }
    /** @inheritdoc */
    get endPoint() {
        return this.activeTargetProvider.endPoint;
    }
    /** @inheritdoc */
    get direction() {
        return this.activeTargetingMode === Interactor_1.TargetingMode.Poke
            ? this.pokeTargetProvider.direction
            : this.indirectTargetProvider.direction;
    }
    /** @inheritdoc */
    get orientation() {
        return this.hand.getPinchDirection();
    }
    /** @inheritdoc */
    get distanceToTarget() {
        var _a, _b;
        return ((_b = (_a = this.activeTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.hit.distance) !== null && _b !== void 0 ? _b : null);
    }
    /** @inheritdoc */
    get targetHitPosition() {
        var _a, _b;
        return ((_b = (_a = this.activeTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.hit.position) !== null && _b !== void 0 ? _b : null);
    }
    /** @inheritdoc */
    get targetHitInfo() {
        var _a;
        return (_a = this.activeTargetProvider.currentInteractableHitInfo) !== null && _a !== void 0 ? _a : null;
    }
    /** @inheritdoc */
    get activeTargetingMode() {
        return this.activeTargetProvider.targetingMode;
    }
    /** @inheritdoc */
    get maxRaycastDistance() {
        return this._maxRaycastDistance;
    }
    /** @inheritdoc */
    get interactionStrength() {
        return this.activeTargetingMode === Interactor_1.TargetingMode.Poke
            ? this.pokeTargetProvider.getInteractionStrength()
            : this.hand.getPinchStrength();
    }
    /**
     * Set if the Interactor is should draw a debug gizmo of collider/raycasts in the scene.
     */
    set drawDebug(debug) {
        this._drawDebug = debug;
        this.indirectTargetProvider.drawDebug = debug;
        this.directTargetProvider.drawDebug = debug;
        this.pokeTargetProvider.drawDebug = debug;
    }
    /**
     * @returns if the Interactor is currently drawing a debug gizmo of collider/raycasts in the scene.
     */
    get drawDebug() {
        return this._drawDebug;
    }
    /** @inheritdoc */
    updateState() {
        super.updateState();
        this.updateTarget();
        this.updateDragVector();
    }
    clearDragProviders() {
        this.directDragProvider.clear();
        this.indirectDragProvider.clear();
        this.planecastDragProvider.clear();
    }
    get planecastPoint() {
        if (this.activeTargetProvider === this.indirectTargetProvider) {
            return this.raycastPlaneIntersection(this.currentInteractable);
        }
        else {
            return this.colliderPlaneIntersection(this.currentInteractable);
        }
    }
    /** @inheritdoc */
    isTargeting() {
        var _a;
        return (_a = this.hand.isInTargetingPose()) !== null && _a !== void 0 ? _a : false;
    }
    /**
     * Returns true if the hand interactor and the hand it is associated with are both enabled.
     */
    isActive() {
        return this.enabled && this.hand.enabled;
    }
    /**
     * Returns true if the hand this interactor is associated with is both enabled and tracked.
     */
    isTracking() {
        return this.hand.enabled && this.hand.isTracked();
    }
    clearCurrentHitInfo() {
        this.indirectTargetProvider.clearCurrentInteractableHitInfo();
        this.directTargetProvider.clearCurrentInteractableHitInfo();
        this.pokeTargetProvider.clearCurrentInteractableHitInfo();
    }
    /** @inheritdoc */
    setInputEnabled(enabled) {
        super.setInputEnabled(enabled);
        this.handProvider.getHand(this.handType).setEnabled(enabled);
    }
    defineSceneEvents() {
        this.createEvent('OnDestroyEvent').bind(() => {
            this.onDestroy();
        });
    }
    updateTarget() {
        var _a, _b;
        if (!this.isActive()) {
            this.indirectTargetProvider.reset();
            return;
        }
        this.pokeTargetProvider.update();
        // Workaround to get onTriggerExit event on poke end, since poke doesn't use hover
        // Otherwise, the interaction manager will by default do an onTriggerCanceled event.
        if (!this.isPoking() &&
            this.previousTrigger === Interactor_1.InteractorTriggerType.Poke) {
            this.currentTrigger = Interactor_1.InteractorTriggerType.None;
            this.currentInteractable = this.previousInteractable;
            return;
        }
        if (this.isPoking()) {
            this.activeTargetProvider = this.pokeTargetProvider;
            this.dragProvider = this.directDragProvider;
        }
        else {
            this.directTargetProvider.update();
            this.indirectTargetProvider.update();
            if ((this.previousTrigger & Interactor_1.InteractorTriggerType.Select) === 0) {
                if (this.pokeTargetProvider.hasTarget()) {
                    this.activeTargetProvider = this.pokeTargetProvider;
                    this.dragProvider = this.directDragProvider;
                }
                else if (this.directTargetProvider.hasTarget()) {
                    this.activeTargetProvider = this.directTargetProvider;
                    this.dragProvider = this.directDragProvider;
                }
                else {
                    this.activeTargetProvider = this.indirectTargetProvider;
                    this.dragProvider = this.indirectDragProvider;
                }
            }
        }
        if (this.isPoking()) {
            this.currentTrigger = Interactor_1.InteractorTriggerType.Poke;
        }
        else if (this.hand.isPinching() &&
            (this.previousTrigger & Interactor_1.InteractorTriggerType.Poke) === 0) {
            this.currentTrigger = Interactor_1.InteractorTriggerType.Pinch;
        }
        else {
            this.currentTrigger = Interactor_1.InteractorTriggerType.None;
        }
        this.currentInteractable =
            (_b = (_a = this.activeTargetProvider.currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.interactable) !== null && _b !== void 0 ? _b : null;
    }
    isPoking() {
        return (this.activeTargetProvider === this.pokeTargetProvider &&
            this.pokeTargetProvider.isTriggering());
    }
    /**
     * @returns if we should prevent any updates to the currently targeted item.
     * In the case of pinching (indirect or direct) or poking, we prevent updates to the targeting system.
     * Otherwise, allow updates to the targeted item.
     */
    preventTargetUpdate() {
        return this.hand.isPinching() || this.isPoking();
    }
    isPokingNonDominantHand() {
        return (this.forcePokeOnNonDominantPalmProximity && this.isNearNonDominantHand());
    }
    isNearNonDominantHand() {
        var _a;
        const nonDominantHand = this.handProvider.getNonDominantHand();
        const dominantHand = this.handProvider.getDominantHand();
        /** If either the dominant or non-dominant hand is not tracked,
       * or if both hands are in an active targeting pose,
       * then the user is not intending to interact with the nondominant hand UI.
       */
        if (!nonDominantHand.isTracked() ||
            !dominantHand.isTracked() ||
            (dominantHand.isInTargetingPose() && nonDominantHand.isInTargetingPose())) {
            return false;
        }
        // Detect if dominant index is within interaction proximity to non-dominant palm
        const palmCenter = nonDominantHand.getPalmCenter();
        const dominantIndexTip = (_a = dominantHand.indexTip) === null || _a === void 0 ? void 0 : _a.position;
        return (palmCenter !== null &&
            dominantIndexTip !== undefined &&
            palmCenter.distanceSquared(dominantIndexTip) <
                HANDUI_INTERACTION_DISTANCE_THRESHOLD_CM *
                    HANDUI_INTERACTION_DISTANCE_THRESHOLD_CM);
    }
    onDestroy() {
        this.release();
        this.directTargetProvider.destroy();
        this.indirectTargetProvider.destroy();
        this.pokeTargetProvider.destroy();
    }
    __initialize() {
        super.__initialize();
        this.handProvider = SIK_1.SIK.HandInputData;
    }
};
exports.HandInteractor = HandInteractor;
exports.HandInteractor = HandInteractor = __decorate([
    component
], HandInteractor);
//# sourceMappingURL=HandInteractor.js.map