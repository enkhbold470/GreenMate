"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CursorViewModel = exports.CursorInteractor = exports.CursorState = void 0;
const InteractableManipulation_1 = require("../../../Components/Interaction/InteractableManipulation/InteractableManipulation");
const InteractionManager_1 = require("../../../Core/InteractionManager/InteractionManager");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const WorldCameraFinderProvider_1 = require("../../../Providers/CameraProvider/WorldCameraFinderProvider");
const SIK_1 = require("../../../SIK");
const animate_1 = require("../../../Utils/animate");
const Event_1 = require("../../../Utils/Event");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const OneEuroFilter_1 = require("../../../Utils/OneEuroFilter");
const StateMachine_1 = require("../../../Utils/StateMachine");
const ScrollView_1 = require("../../UI/ScrollView/ScrollView");
var CursorState;
(function (CursorState) {
    CursorState["Inactive"] = "Inactive";
    CursorState["Idle"] = "Idle";
    CursorState["Hovering"] = "Hovering";
    CursorState["Manipulating"] = "Manipulating";
    CursorState["Scrolling"] = "Scrolling";
})(CursorState || (exports.CursorState = CursorState = {}));
var CursorInteractor;
(function (CursorInteractor) {
    CursorInteractor[CursorInteractor["Primary"] = 0] = "Primary";
    CursorInteractor[CursorInteractor["Secondary"] = 1] = "Secondary";
})(CursorInteractor || (exports.CursorInteractor = CursorInteractor = {}));
const DISTANCE_SCALE_FACTOR = 10;
const DEFAULT_INITIAL_DISTANCE = 160;
const MIN_DISTANCE = 15;
const DEFAULT_MANIPULATE_STRENGTH = 1;
const DEFAULT_HOVER_ANIMATE_DURATION_SECONDS = 0.2;
const DEFAULT_IDLE_ANIMATE_DURATION_SECONDS = 0.7;
const DEFAULT_NEAR_FIELD_SCALE = 0.4;
const DEFAULT_MID_FIELD_SCALE = 0.8;
const DEFAULT_FAR_FIELD_SCALE = 1.2;
const DEFAULT_NEAR_FIELD_THRESHOLD_CM = 70;
const DEFAULT_MID_FIELD_THRESHOLD_CM = 130;
const DEFAULT_FAR_FIELD_THRESHOLD_CM = 200;
const DEFAULT_CURSOR_FILTER = {
    frequency: 60,
    dcutoff: 0.16,
    minCutoff: 0.5,
    beta: 0.2,
};
const TAG = 'CursorViewModel';
/**
 * ViewModel for the InteractorCursor that uses a StateMachine to keep track of cursor updates & state changes.
 */
class CursorViewModel {
    constructor(enableCursorSnapping, enableFilter, _interactor) {
        this.enableCursorSnapping = enableCursorSnapping;
        this.enableFilter = enableFilter;
        this._interactor = _interactor;
        this.interactionConfigurationProvider = SIK_1.SIK.InteractionConfiguration;
        this.camera = WorldCameraFinderProvider_1.default.getInstance();
        // Native Logging
        this.log = new NativeLogger_1.default(TAG);
        this.stateMachine = new StateMachine_1.default('CursorViewModel');
        this.handProvider = SIK_1.SIK.HandInputData;
        this.interactionManager = InteractionManager_1.InteractionManager.getInstance();
        this.onStateChangeEvent = new Event_1.default();
        this.onStateChange = this.onStateChangeEvent.publicApi();
        this.onCursorUpdateEvent = new Event_1.default();
        this.onCursorUpdate = this.onCursorUpdateEvent.publicApi();
        this._cursorPosition = null;
        this.currentInteractableUnsubscribeCallback = null;
        this.currentInteractable = null;
        this.currentManipulation = null;
        this.isScrolling = false;
        this.cursorDistance = DEFAULT_INITIAL_DISTANCE;
        this.distanceCancelSet = new animate_1.CancelSet();
        this.isAnimating = false;
        this.scrollView = null;
        // Allows the developer to set position manually, setting to null whenever the developer wants to resume default behavior.
        this.positionOverride = null;
        /**
       * Currently using a one-euro filter optimized for reducing slow speed jitter.
       */
        this.filter = new OneEuroFilter_1.OneEuroFilterVec3(DEFAULT_CURSOR_FILTER);
        // If passing an Interactor within the constructor, ensure the Interactor callbacks are setup correctly.
        if (_interactor !== undefined) {
            this.setInteractor(_interactor);
        }
        this.setupStateMachine();
    }
    setInteractor(interactor) {
        if (this.currentInteractableUnsubscribeCallback !== null) {
            this.currentInteractableUnsubscribeCallback();
            this.currentInteractableUnsubscribeCallback = null;
        }
        this._interactor = interactor;
        this.currentInteractableUnsubscribeCallback =
            this.interactor.onCurrentInteractableChanged.add((interactable) => {
                this.currentInteractable = interactable;
                this.currentManipulation =
                    interactable !== null
                        ? interactable.sceneObject.getComponent(InteractableManipulation_1.InteractableManipulation.getTypeName())
                        : null;
                this.isScrolling =
                    interactable !== null
                        ? this.checkScrollable(interactable.sceneObject)
                        : false;
            });
    }
    get interactor() {
        var _a;
        return (_a = this._interactor) !== null && _a !== void 0 ? _a : null;
    }
    get cursorPosition() {
        return this._cursorPosition;
    }
    setupStateMachine() {
        this.stateMachine.addState({
            name: CursorState.Inactive,
            onEnter: () => {
                this.onStateChangeEvent.invoke(CursorState.Inactive);
                // If we enter the inactive state due to direct targeting, set the cursor distance to be closer to hand for post-direct interaction.
                const isDirect = this.interactor !== null &&
                    this.interactor.activeTargetingMode === Interactor_1.TargetingMode.Direct;
                this.cursorDistance = isDirect ? MIN_DISTANCE : DEFAULT_INITIAL_DISTANCE;
            },
            transitions: [
                {
                    nextStateName: CursorState.Idle,
                    checkOnUpdate: () => {
                        var _a, _b;
                        return ((_b = (this.checkVisibleTargetingState() &&
                            ((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentInteractable) === null)) !== null && _b !== void 0 ? _b : false);
                    },
                },
                {
                    nextStateName: CursorState.Hovering,
                    // If the interactor targets an object on the first frame of being active, jump immediately to the object to avoid jumpy cursor.
                    checkOnUpdate: () => {
                        var _a;
                        return (this.checkVisibleTargetingState() &&
                            ((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentInteractable) !== null);
                    },
                },
            ],
        });
        this.stateMachine.addState({
            name: CursorState.Idle,
            onEnter: () => {
                this.onStateChangeEvent.invoke(CursorState.Idle);
                // When entering idle state with no Interactable target, lerp to the default distance
                const distance = Math.max(this.cursorDistance, MIN_DISTANCE);
                this.animateCursorDistance(distance, 'ease-in-out-cubic', DEFAULT_IDLE_ANIMATE_DURATION_SECONDS);
            },
            onUpdate: () => {
                var _a;
                const position = this.getFarFieldCursorPosition();
                this.updateIndirectCursorPosition((_a = this.interactor.interactionStrength) !== null && _a !== void 0 ? _a : null, position);
            },
            transitions: [
                {
                    nextStateName: CursorState.Inactive,
                    checkOnUpdate: () => {
                        return !this.interactor || !this.checkVisibleTargetingState();
                    },
                },
                {
                    nextStateName: CursorState.Hovering,
                    checkOnUpdate: () => {
                        var _a;
                        return ((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentInteractable) !== null;
                    },
                    // Lerp to the targeted Interactable when transitioning to hover state
                    onExecution: () => {
                        var _a, _b, _c, _d;
                        const origin = (_b = (_a = this.interactor) === null || _a === void 0 ? void 0 : _a.startPoint) !== null && _b !== void 0 ? _b : null;
                        const hitPosition = (_d = (_c = this.interactor) === null || _c === void 0 ? void 0 : _c.targetHitPosition) !== null && _d !== void 0 ? _d : null;
                        if (origin === null || hitPosition === null) {
                            return;
                        }
                        const distance = origin.distance(hitPosition);
                        this.animateCursorDistance(distance, 'linear', DEFAULT_HOVER_ANIMATE_DURATION_SECONDS);
                    },
                },
            ],
        });
        this.stateMachine.addState({
            name: CursorState.Hovering,
            onEnter: () => {
                this.onStateChangeEvent.invoke(CursorState.Hovering);
            },
            onUpdate: () => {
                var _a, _b, _c, _d, _e, _f, _g;
                // Cancel the animation if a trigger happens mid-animation
                if (this.isAnimating &&
                    ((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentTrigger) !== Interactor_1.InteractorTriggerType.None) {
                    this.cancelAnimation();
                }
                if (!this.isAnimating) {
                    this.cursorDistance =
                        (_e = (_c = (_b = this.interactor) === null || _b === void 0 ? void 0 : _b.targetHitInfo) === null || _c === void 0 ? void 0 : _c.hit.position.distance((_d = this.interactor) === null || _d === void 0 ? void 0 : _d.startPoint)) !== null && _e !== void 0 ? _e : this.cursorDistance;
                }
                const position = this.shouldSnap()
                    ? this.getSnappedCursorPosition()
                    : this.getFarFieldCursorPosition();
                this.updateIndirectCursorPosition((_g = (_f = this.interactor) === null || _f === void 0 ? void 0 : _f.interactionStrength) !== null && _g !== void 0 ? _g : null, position);
            },
            transitions: [
                {
                    nextStateName: CursorState.Inactive,
                    checkOnUpdate: () => {
                        return !this.interactor || !this.checkVisibleTargetingState();
                    },
                },
                {
                    nextStateName: CursorState.Idle,
                    checkOnUpdate: () => {
                        var _a;
                        return !((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentInteractable);
                    },
                },
                {
                    nextStateName: CursorState.Manipulating,
                    checkOnUpdate: () => {
                        var _a;
                        return (((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentTrigger) !== Interactor_1.InteractorTriggerType.None &&
                            this.currentManipulation !== null);
                    },
                },
                {
                    nextStateName: CursorState.Scrolling,
                    checkOnUpdate: () => {
                        var _a, _b;
                        return (((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentTrigger) !== Interactor_1.InteractorTriggerType.None &&
                            this.isScrolling &&
                            ((_b = this.interactor) === null || _b === void 0 ? void 0 : _b.currentDragVector) !== null);
                    },
                },
            ],
            onExit: () => {
                this.cancelAnimation();
            },
        });
        this.stateMachine.addState({
            name: CursorState.Manipulating,
            onEnter: () => this.onStateChangeEvent.invoke(CursorState.Manipulating),
            onUpdate: () => {
                /**
         * We were showing the cursor snapped to center as a visual feedback if line is disabled,
         * But we disabled this by default in LAF-3485.
         */
                this.updateIndirectCursorPosition(DEFAULT_MANIPULATE_STRENGTH, this.getSnappedCursorPosition());
            },
            transitions: [
                {
                    nextStateName: CursorState.Inactive,
                    checkOnUpdate: () => {
                        return !this.interactor || !this.checkVisibleTargetingState();
                    },
                },
                {
                    nextStateName: CursorState.Idle,
                    checkOnUpdate: () => {
                        var _a;
                        return !((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentInteractable);
                    },
                },
                {
                    nextStateName: CursorState.Hovering,
                    checkOnUpdate: () => {
                        var _a;
                        return (((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentTrigger) === Interactor_1.InteractorTriggerType.None);
                    },
                },
            ],
        });
        this.stateMachine.addState({
            name: CursorState.Scrolling,
            onEnter: () => this.onStateChangeEvent.invoke(CursorState.Scrolling),
            onUpdate: () => {
                var _a, _b;
                const planecastPosition = this.getPlanecastCursorPosition();
                this.updateIndirectCursorPosition((_b = (_a = this.interactor) === null || _a === void 0 ? void 0 : _a.interactionStrength) !== null && _b !== void 0 ? _b : null, planecastPosition);
            },
            transitions: [
                {
                    nextStateName: CursorState.Inactive,
                    checkOnUpdate: () => {
                        return !this.interactor || !this.checkVisibleTargetingState();
                    },
                },
                {
                    nextStateName: CursorState.Idle,
                    checkOnUpdate: () => {
                        var _a, _b;
                        return (!((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentInteractable) ||
                            // If the planecasted point is not within the ScrollView's bounds, immediately switch to Idle to avoid a flicker.
                            (!this.checkPlanecastWithinScrollView() &&
                                ((_b = this.interactor) === null || _b === void 0 ? void 0 : _b.currentTrigger) === Interactor_1.InteractorTriggerType.None));
                    },
                },
                {
                    nextStateName: CursorState.Hovering,
                    checkOnUpdate: () => {
                        var _a;
                        return (((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentTrigger) === Interactor_1.InteractorTriggerType.None);
                    },
                },
            ],
        });
        this.stateMachine.enterState(CursorState.Inactive);
    }
    getPlanecastCursorPosition() {
        if (this.interactor === null) {
            this.log.d('Cursor failed to get planecast position due to null interactor, and will return null.');
            return null;
        }
        const position = this.interactor.planecastPoint;
        return this.shouldFilter()
            ? this.filter.filter(position, getTime())
            : position;
    }
    checkPlanecastWithinScrollView() {
        var _a, _b, _c, _d;
        const cursorPos = this.getPlanecastCursorPosition();
        if (cursorPos === null) {
            return false;
        }
        return ((_d = (_c = (_b = (_a = this.scrollView) === null || _a === void 0 ? void 0 : _a.getSceneObject()) === null || _b === void 0 ? void 0 : _b.getComponent('Component.ScreenTransform')) === null || _c === void 0 ? void 0 : _c.containsWorldPoint(cursorPos)) !== null && _d !== void 0 ? _d : false);
    }
    /**
   * Calculates the position of the cursor based on the center of the targeting ray.
   * @returns the position of the cursor, or null if not applicable
   */
    getFarFieldCursorPosition() {
        var _a, _b, _c, _d;
        const origin = (_b = (_a = this.interactor) === null || _a === void 0 ? void 0 : _a.startPoint) !== null && _b !== void 0 ? _b : null;
        const direction = (_d = (_c = this.interactor) === null || _c === void 0 ? void 0 : _c.direction) !== null && _d !== void 0 ? _d : null;
        if (this.interactor === null || origin === null || direction === null) {
            this.log.d('Cursor failed to get far field position due to null interactor, origin, or direction, and will return null.');
            return null;
        }
        const position = origin.add(direction.uniformScale(this.cursorDistance));
        return this.shouldFilter()
            ? this.filter.filter(position, getTime())
            : position;
    }
    /**
   * Returns the snapped cursor position, where it's stuck to the center of target when currently selecting, or the hit position otherwise.
   * @returns the position of the snapped cursor, with the regular far field cursor position or null as a fallback if the target hit position cannot be found.
   */
    getSnappedCursorPosition() {
        var _a, _b, _c, _d, _e, _f, _g, _h;
        let position;
        if (!this.interactor) {
            return null;
        }
        const isTriggering = (this.interactor.currentTrigger & Interactor_1.InteractorTriggerType.Select) !== 0;
        const wasTriggering = (this.interactor.previousTrigger & Interactor_1.InteractorTriggerType.Select) !== 0;
        if (isTriggering) {
            // While triggering, ensuring that the initial local position is maintained.
            position =
                (_f = (_b = (_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentInteractable) === null || _b === void 0 ? void 0 : _b.sceneObject.getTransform().getWorldTransform().multiplyPoint((_e = (_d = (_c = this.interactor) === null || _c === void 0 ? void 0 : _c.targetHitInfo) === null || _d === void 0 ? void 0 : _d.localHitPosition) !== null && _e !== void 0 ? _e : vec3.zero())) !== null && _f !== void 0 ? _f : null;
        }
        else if (wasTriggering && !isTriggering) {
            // On the frame that the Interactor stops triggering, maintain the same cursor position as previous frame to account for targeting changes.
            position = this.cursorPosition;
        }
        else {
            // We calculate the direction from the interactor to the hit point, then use the stored cursor distance to respect animated distance.
            const origin = this.interactor.startPoint;
            if (!origin) {
                return null;
            }
            const direction = (_h = (_g = this.interactor.targetHitInfo) === null || _g === void 0 ? void 0 : _g.hit.position) === null || _h === void 0 ? void 0 : _h.sub(origin).normalize();
            if (!direction) {
                return null;
            }
            position = origin.add(direction.uniformScale(this.cursorDistance));
        }
        if (position) {
            return this.shouldFilter()
                ? this.filter.filter(position, getTime())
                : position;
        }
        else {
            return this.getFarFieldCursorPosition();
        }
    }
    /**
   * @returns if the cursor should be snapped to the hit position.
   * During manipulation, since the interactor is assumed to be triggered, we snap the cursor to maintain local offset.
   */
    shouldSnap() {
        var _a;
        return (this.enableCursorSnapping &&
            ((_a = (this.interactor &&
                (this.interactor.inputType & Interactor_1.InteractorInputType.BothHands) !== 0)) !== null && _a !== void 0 ? _a : false));
    }
    shouldFilter() {
        var _a;
        return (this.enableFilter &&
            ((_a = (this.interactor &&
                (this.interactor.inputType & Interactor_1.InteractorInputType.BothHands) !== 0)) !== null && _a !== void 0 ? _a : false));
    }
    // Animates the cursor to move to a certain distance using easing functions
    animateCursorDistance(distance, easing, duration) {
        // Ensure only one thing is modifying the cursor distance at a time
        this.distanceCancelSet.cancel();
        this.isAnimating = true;
        const initialDistance = this.cursorDistance;
        (0, animate_1.default)({
            cancelSet: this.distanceCancelSet,
            duration: duration,
            update: (t) => {
                this.cursorDistance = MathUtils.lerp(initialDistance, distance, t);
            },
            ended: () => {
                this.isAnimating = false;
            },
            easing: easing,
        });
    }
    /**
   * Cancel the existing animation and set the isAnimating boolean to false,
   * allowing other functions (getFarFieldCursorPosition and getSnapCursorPosition)
   * to modify cursorDistance to jump the cursor to the Interactable object
   */
    cancelAnimation() {
        this.distanceCancelSet.cancel();
        this.isAnimating = false;
    }
    // Check if interacted item is within a ScrollView
    checkScrollable(sceneObject) {
        if (sceneObject === null) {
            return false;
        }
        const interactable = this.interactionManager.getInteractableBySceneObject(sceneObject);
        if (interactable !== null && interactable.isScrollable) {
            this.scrollView = sceneObject.getComponent(ScrollView_1.ScrollView.getTypeName());
            if (this.scrollView !== null) {
                return this.scrollView.contentLength > this.scrollView.scrollAreaSize.y;
            }
        }
        return this.checkScrollable(sceneObject.getParent());
    }
    /**
   * When in indirect interaction mode while targeting an Interactable,
   * positions to interaction hit point if snapping.
   * If there is no origin, then hide the cursor instead.
   */
    updateIndirectCursorPosition(interactionStrength, position) {
        var _a, _b, _c, _d, _e;
        if (position !== null) {
            if (!this.isAnimating) {
                this.cursorDistance =
                    (_c = (_b = (_a = this.interactor) === null || _a === void 0 ? void 0 : _a.startPoint) === null || _b === void 0 ? void 0 : _b.distance(position)) !== null && _c !== void 0 ? _c : this.cursorDistance;
            }
            this._cursorPosition = (_d = this.positionOverride) !== null && _d !== void 0 ? _d : position;
            this.onCursorUpdateEvent.invoke({
                cursorEnabled: true,
                cursorData: {
                    position: this.cursorPosition,
                    interactionStrength: interactionStrength !== null && interactionStrength !== void 0 ? interactionStrength : null,
                    isTriggering: ((_e = this.interactor) === null || _e === void 0 ? void 0 : _e.currentTrigger) !== Interactor_1.InteractorTriggerType.None,
                    scale: this.calculateCursorScale(),
                },
                lineEnabled: false,
            });
        }
    }
    // Check if the interactor is not in a state that should hide the cursor (poke or direct), as well as if the interactor is active/targeting.
    checkVisibleTargetingState() {
        var _a;
        if ((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.enabled) {
            return (((this.interactor.activeTargetingMode &
                (Interactor_1.TargetingMode.Poke | Interactor_1.TargetingMode.Direct | Interactor_1.TargetingMode.None)) ===
                0 ||
                this.interactor.inputType === Interactor_1.InteractorInputType.Mouse) &&
                this.interactor.isActive() &&
                this.interactor.isTargeting());
        }
        return false;
    }
    calculateCursorScale() {
        if (this.cursorDistance > DEFAULT_FAR_FIELD_THRESHOLD_CM) {
            return DEFAULT_FAR_FIELD_SCALE;
        }
        else if (this.cursorDistance > DEFAULT_MID_FIELD_THRESHOLD_CM &&
            this.cursorDistance <= DEFAULT_FAR_FIELD_THRESHOLD_CM) {
            const scaleDifference = DEFAULT_FAR_FIELD_SCALE - DEFAULT_MID_FIELD_SCALE;
            const t = MathUtils.remap(this.cursorDistance, DEFAULT_MID_FIELD_THRESHOLD_CM, DEFAULT_FAR_FIELD_THRESHOLD_CM, 0, 1);
            return DEFAULT_MID_FIELD_SCALE + scaleDifference * t;
        }
        else if (this.cursorDistance > DEFAULT_NEAR_FIELD_THRESHOLD_CM &&
            this.cursorDistance <= DEFAULT_MID_FIELD_THRESHOLD_CM) {
            const scaleDifference = DEFAULT_MID_FIELD_SCALE - DEFAULT_NEAR_FIELD_SCALE;
            const t = MathUtils.remap(this.cursorDistance, DEFAULT_NEAR_FIELD_THRESHOLD_CM, DEFAULT_MID_FIELD_THRESHOLD_CM, 0, 1);
            return DEFAULT_NEAR_FIELD_SCALE + scaleDifference * t;
        }
        else {
            return DEFAULT_NEAR_FIELD_SCALE;
        }
    }
}
exports.CursorViewModel = CursorViewModel;
//# sourceMappingURL=CursorViewModel.js.map