"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ContainerFrame = void 0;
var __selfType = requireType("./ContainerFrame");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Billboard_1 = require("../../../Components/Interaction/Billboard/Billboard");
const Interactable_1 = require("../../../Components/Interaction/Interactable/Interactable");
const InteractableManipulation_1 = require("../../../Components/Interaction/InteractableManipulation/InteractableManipulation");
const animate_1 = require("../../../Utils/animate");
const Event_1 = require("../../../Utils/Event");
const mathUtils_1 = require("../../../Utils/mathUtils");
const CursorHandler_1 = require("./modules/CursorHandler");
const FrameInputHandler_1 = require("./modules/FrameInputHandler");
const HoverBehavior_1 = require("./modules/HoverBehavior");
const LabeledPinchButton_1 = require("./modules/LabeledPinchButton");
const SmoothFollow_1 = require("./modules/SmoothFollow");
const SnappableBehavior_1 = require("./modules/SnappableBehavior");
const CursorController_1 = require("../../../Components/Interaction/InteractorCursor/CursorController");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const WorldCameraFinderProvider_1 = require("../../../Providers/CameraProvider/WorldCameraFinderProvider");
const SIK_1 = require("../../../SIK");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const SceneObjectUtils_1 = require("../../../Utils/SceneObjectUtils");
const log = new NativeLogger_1.default('ContainerFrame');
const OPACITY_TWEEN_DURATION = 0.2;
const SQUEEZE_TWEEN_DURATION = 0.4;
const DEFAULT_BACKING_ALPHA = 1;
const CAPTURE_BACKING_ALPHA = 0.1;
/*
 * use forced depth for now
 * only 2d content
 */
const scaleZ = 1;
/*
 * ratio for scaling between world space and margin space
 * testing different values here, leaving for reference during continued visdev
 * const scaleFactor = 90
 * const scaleFactor = 70
 */
const scaleFactor = 50;
// frame depth factor
const zScaleAdjuster = 15;
const CURSOR_HIGHLIGHT_ANIMATION_DURATION = 0.15;
/**
 * History of this magic number:
 * I added the frame mesh to the scene with a basic material
 * And overlayed it on a Unit Plane
 * I switched the camera to orthographic
 * And scaled up the Frame Mesh until it's edges just touched the edges of the unit plane
 * That was at scale 8.24
 * So without any stretching, the mesh is 1 / 8.24
 * 1 / 8.24 = 0.1213592233
 * And since we set the base scale of the mesh to a constant and then stretch with vertex shader
 * I multiply that base scale by this number above, to get the size of the frame that isn't stretched
 * And subtract that from the amount we need to stretch
 * ヽ(｀Д´)⊃━☆ﾟ. * ･ ｡ﾟ,
 */
const magicScalar = 0.1213592233;
/**
 * the base scale of the frame
 */
const scaleFactorVector = new vec3(scaleFactor + magicScalar, scaleFactor + magicScalar, scaleZ * zScaleAdjuster);
// the current system UI button is not unit sized
// it's closer to 2.35 in X and Y
const buttonMagicNumber = 0.4474272931;
// constant size of button
const defaultButtonSize = 3 * buttonMagicNumber;
const BUTTON_CORNER_OFFSET = 1 / scaleFactor;
/**
 *
 * Base class for the ContainerFrame
 * A 2D Container Component that can act as a "window" around your content
 *
 */
let ContainerFrame = class ContainerFrame extends BaseScriptComponent {
    set isVisible(isVisible) {
        this._isVisible = isVisible;
    }
    get isVisible() {
        return this._isVisible;
    }
    onAwake() {
        // frame
        this.frame = this.framePrefab.instantiate(null);
        this.frameTransform = this.frame.getTransform();
        this.targetScaleCache = new vec2(this.innerSize.x, this.innerSize.y);
        this.originalScale = new vec2(this.innerSize.x, this.innerSize.y);
        // parent
        this.parent = this.getSceneObject();
        this.parentTransform = this.parent.getTransform();
        // target
        this.target = global.scene.createSceneObject('ContainerInner');
        this.targetTransform = this.target.getTransform();
        this.parent.children.forEach((child) => {
            child.setParent(this.target);
        });
        this.target.setParent(this.parent);
        // collider
        this.collider = this.frame.getComponent('Physics.ColliderComponent');
        this.colliderShape = this.collider.shape;
        this.colliderTransform = this.collider.getSceneObject().getTransform();
        // buttons
        this.closeButton = new LabeledPinchButton_1.LabeledPinchButton({
            prefab: this.labeledButtonPrefab,
            parent: this.frame,
            labels: [this.closeIcon],
        });
        this.closeButton.onTrigger.add(() => {
            this.inputState.isPinching = false;
        });
        this.followButton = new LabeledPinchButton_1.LabeledPinchButton({
            prefab: this.labeledButtonPrefab,
            parent: this.frame,
            labels: [this.followIcon, this.unfollowIcon],
            toggle: true,
            triggerColor: new vec4(0.8, 0.8, 0.8, 1),
        });
        this.followButton.setIconScale(new vec2(1.85, 1.85));
        this.followButton.onTrigger.add(() => {
            this.inputState.isPinching = false;
            this.setIsFollowing(!this.isFollowing);
        });
        /*
       *
       * if worldCursor isn't hooked up
       * find it in the hierarchy
       * temporary fix for dynamic creation of frame
       *
       */
        if (!this.worldCursor) {
            const sikRootSceneObject = SIK_1.SIK.InteractionManager.getInteractorsByType(Interactor_1.InteractorInputType.RightHand)[0]
                .sceneObject.getParent()
                .getParent();
            const interactorCursorsSceneObject = (0, SceneObjectUtils_1.findSceneObjectByName)(sikRootSceneObject, 'InteractorCursors');
            this.worldCursor = interactorCursorsSceneObject.getComponent(CursorController_1.CursorController.getTypeName());
        }
        // cursor
        this.cursorHandler = new CursorHandler_1.CursorHandler({
            target: this.target,
            frame: this,
            margin: this.border,
        });
        // SIK Components
        this.interactable = this.frame.createComponent(Interactable_1.Interactable.getTypeName());
        /*
       * indirect targeting only with one interactor
       * prevents direct manipulation controls which are undesired for frame
       */
        this.interactable.targetingMode = 2;
        this.interactable.allowMultipleInteractors = false;
        this.manipulate = this.frame.createComponent(InteractableManipulation_1.InteractableManipulation.getTypeName());
        this.billboardComponent = this.useBillboarding
            ? this.parent.createComponent(Billboard_1.Billboard.getTypeName())
            : null;
        if (this.billboardComponent !== null) {
            this.billboardComponent.xAxisEnabled = false || this.xAlways;
            this.billboardComponent.yAxisEnabled = false || this.yAlways;
        }
        // material
        this.renderMeshVisual = this.frame.getComponent('Component.RenderMeshVisual');
        this.material = this.renderMeshVisual.mainMaterial.clone();
        this.renderMeshVisual.mainMaterial = this.material;
        this.material.mainPass.frustumCullMode = FrustumCullMode.UserDefinedAABB;
        // input handler
        this.inputHandlerOptions = {
            frame: this,
            manipulate: this.manipulate,
            target: this.target,
            parentTransform: this.parentTransform,
            cursorHandler: this.cursorHandler,
            isInteractable: this.isContentInteractable,
            scaleSpeed: undefined,
            allowScaling: this.allowScaling,
            minimumSize: this.minimumSize,
            maximumSize: this.maximumSize,
        };
        this.inputHandler = new FrameInputHandler_1.FrameInputHandler(this.inputHandlerOptions);
        // Use the FrameInputHandler as the authoritative source on when translation starts
        this.inputHandler.onTranslationStart.add(() => {
            var _a;
            this.onTranslationStartEvent.invoke();
            (_a = this.smoothFollow) === null || _a === void 0 ? void 0 : _a.startDragging();
        });
        this.inputHandler.onTranslationEnd.add(() => {
            var _a;
            this.onTranslationEndEvent.invoke();
            (_a = this.smoothFollow) === null || _a === void 0 ? void 0 : _a.finishDragging();
        });
        // button logic
        this.enableCloseButton(this.showCloseButton);
        this.enableFollowButton(this.showFollowButton);
        // following logic
        this.setIsFollowing(this.isFollowing);
        this.manipulate.setManipulateRoot(this.parentTransform);
        this.manipulate.setCanScale(false);
        this.parentTransform.setWorldPosition(this.targetTransform.getWorldPosition());
        this.parentTransform.setWorldRotation(this.targetTransform.getWorldRotation());
        this.frame.setParentPreserveWorldTransform(this.parent);
        this.frameTransform.setLocalPosition(vec3.zero());
        this.frameTransform.setLocalRotation(quat.quatIdentity());
        this.frameTransform.setWorldScale(scaleFactorVector);
        this.targetTransform.setLocalPosition(new vec3(0, 0, 0.5));
        this.targetTransform.setLocalRotation(quat.quatIdentity());
        this.opacity = this.material.mainPass.opacity;
        this.scaleFrame();
        // We need a collider or one is created. We don't actually use it for anything
        this.parentCollider = this.parent.createComponent('Physics.ColliderComponent');
        const shape = Shape.createBoxShape();
        shape.size = new vec3(0.01, 0.01, 0.01);
        this.parentCollider.shape = shape;
        this.parentInteractable = this.parent.createComponent(Interactable_1.Interactable.getTypeName());
        this.parentHoverBehavior = new HoverBehavior_1.HoverBehavior(this.parentInteractable, this);
        this.unSubscribeList.push(this.parentHoverBehavior.onHoverStart.add((e) => {
            this.cursorHandler.setCursor(SIK_1.SIK.CursorController.getCursorByInteractor(e.interactor));
            if (this.autoShowHide)
                this.showVisual();
            if (this.material.mainPass.isHovered === 0) {
                this.showCursorHighlight();
            }
            this.inputState.isHovered = true;
            this.inputState.rawHovered = true;
        }));
        this.unSubscribeList.push(this.parentHoverBehavior.onHoverUpdate.add((e) => {
            const targetObject = e === null || e === void 0 ? void 0 : e.target.sceneObject;
            this.updateCursorHighlightPosition(e);
            let targetParent = targetObject;
            let hoveringInteractable = false;
            this.inputState.needCursor = false;
            while (targetParent !== this.parent && targetParent !== null) {
                if (targetObject === this.target ||
                    targetObject === this.frame ||
                    targetParent === this.target) {
                    this.inputState.needCursor = true;
                }
                if (targetObject === this.target || targetParent === this.target) {
                    hoveringInteractable = true;
                    break;
                }
                targetParent = isNull(targetParent) ? null : targetParent.getParent();
            }
            // hovering over interactable container content ONLY
            if (hoveringInteractable) {
                if (!this.hoveringContentInteractableLast) {
                    this.hideCursorHighlight();
                }
            }
            else {
                if (this.hoveringContentInteractableLast) {
                    this.showCursorHighlight();
                }
            }
            this.hoveringContentInteractableLast = hoveringInteractable;
            // hover over interactable area ( non border container ) OR interactable container content
            if (hoveringInteractable ||
                this.inputHandler.state.hoveringInteractable) {
                this.inputState.innerInteractableActive = true;
            }
            else {
                this.inputState.innerInteractableActive = false;
            }
        }));
        this.unSubscribeList.push(this.parentHoverBehavior.onHoverEnd.add(() => {
            if (this.autoShowHide)
                this.hideVisual();
            if (this.material.mainPass.isHovered > 0) {
                this.hideCursorHighlight();
            }
            this.inputState.isHovered = false;
            this.inputState.rawHovered = false;
            this.inputState.innerInteractableActive = false;
        }));
        this.unSubscribeList.push(this.interactable.onHoverUpdate.add((event) => {
            if (event.interactor.targetHitInfo) {
                this.updateCursorHighlightPosition(event);
                if (event.target === this.interactable) {
                    this.inputHandler.lastHovered = true;
                }
                if (event.interactor.isActive()) {
                    this.inputState.drag.x = 0;
                    this.inputState.drag.y = 0;
                    if (event.interactor.currentDragVector !== null &&
                        this.inputHandler.state.scaling) {
                        this.inputState.drag = this.parentTransform
                            .getInvertedWorldTransform()
                            .multiplyDirection(event.interactor.currentDragVector);
                    }
                }
            }
        }));
        this.unSubscribeList.push(this.interactable.onTriggerStart((e) => {
            const targetObject = e === null || e === void 0 ? void 0 : e.target.sceneObject;
            let targetParent = targetObject;
            while (targetParent !== this.parent && targetParent !== null) {
                if (targetObject === this.target ||
                    targetObject === this.frame ||
                    targetParent === this.target) {
                    this.inputState.isPinching = true;
                    this.currentInteractor = e.interactor;
                }
                if (targetObject === this.target || targetParent === this.target) {
                    break;
                }
                targetParent = targetParent === null || targetParent === void 0 ? void 0 : targetParent.getParent();
            }
        }));
        this.unSubscribeList.push(this.interactable.onTriggerEnd(() => {
            this.inputState.isPinching = false;
            this.currentInteractor = null;
        }));
        this.unSubscribeList.push(this.interactable.onTriggerCanceled(() => {
            this.inputState.isPinching = false;
            this.currentInteractor = null;
        }));
        if (this.useSnapping) {
            this.createSnappableBehavior();
        }
        if (this.useFOVFollow) {
            this.setUseFollow(true);
        }
        this.allInteractables.push(this.interactable);
        this.allInteractables.push(this.parentInteractable);
        this.allInteractables.push(this.closeButton.getInteractable());
        this.allInteractables.push(this.followButton.getInteractable());
        // start hidden
        if (this.autoShowHide) {
            this.hideVisual();
        }
        else {
            this._opacity = 0;
            this.showVisual();
        }
        // handle scaling affordances
        this.setAllowScaling(this.allowScaling);
        const onDestroy = this.createEvent('OnDestroyEvent');
        onDestroy.bind(this.destroy);
        // hide cursorHighlight on start
        this.material.mainPass.isHovered = 0;
        this.backingAlpha = this.material.mainPass.backingAlpha;
        this.update();
    }
    /**
     * @returns vec2 of the total size of the container, including constant padding
     */
    get totalInnerSize() {
        return new vec2(this.innerSize.x + this.constantPadding.x, this.innerSize.y + this.constantPadding.y);
    }
    /*
     *
     * worldTransform api
     *
     */
    /**
     * @returns current world position of frame
     */
    get worldPosition() {
        return this.parentTransform.getWorldPosition();
    }
    /**
     * @param position sets current world position of frame
     */
    set worldPosition(position) {
        this.parentTransform.setWorldPosition(position);
    }
    /**
     * Gets current world position of frame
     * @returns {vec3}
     */
    getWorldPosition() {
        return this.parentTransform.getWorldPosition();
    }
    /**
     * @param position sets current world position of frame
     */
    setWorldPosition(position) {
        this.parentTransform.setWorldPosition(position);
    }
    /**
     * @returns current local position of frame
     */
    get localPosition() {
        return this.parentTransform.getLocalPosition();
    }
    /**
     * @param position sets current local position of frame
     */
    set localPosition(position) {
        this.parentTransform.setLocalPosition(position);
    }
    /**
     * @returns current local position of frame
     */
    getLocalPosition() {
        return this.parentTransform.getLocalPosition();
    }
    /**
     * @param position sets current local position of frame
     */
    setLocalPosition(position) {
        this.parentTransform.setLocalPosition(position);
    }
    /**
     * @returns current world rotation of frame
     */
    get worldRotation() {
        return this.parentTransform.getWorldRotation();
    }
    /**
     * @param rotation sets current local position of frame
     */
    set worldRotation(rotation) {
        this.parentTransform.setWorldRotation(rotation);
    }
    /**
     * @returns current world rotation of frame
     */
    getWorldRotation() {
        return this.parentTransform.getWorldRotation();
    }
    /**
     * @param rotation sets current local position of frame
     */
    setWorldRotation(rotation) {
        this.parentTransform.setWorldRotation(rotation);
    }
    /**
     * @returns current local rotation of frame
     */
    get localRotation() {
        return this.parentTransform.getLocalRotation();
    }
    /**
     * @param rotation set current local rotation of frame
     */
    set localRotation(rotation) {
        this.parentTransform.setLocalRotation(rotation);
    }
    /**
     * @returns current local rotation of frame
     */
    getLocalRotation() {
        return this.parentTransform.getLocalRotation();
    }
    /**
     * @param rotation set current local rotation of frame
     */
    setLocalRotation(rotation) {
        this.parentTransform.setLocalRotation(rotation);
    }
    /**
     * @returns current world scale of frame
     */
    get worldScale() {
        return this.parentTransform.getWorldScale();
    }
    /**
     * @param scale set current world scale of frame
     */
    set worldScale(scale) {
        this.parentTransform.setWorldScale(scale);
    }
    /**
     * @returns current world scale of frame
     */
    get localScale() {
        return this.parentTransform.getLocalScale();
    }
    /**
     * @param scale set current local scale of frame
     */
    set localScale(scale) {
        this.parentTransform.setLocalScale(scale);
    }
    /**
     * @returns current renderOrder for the renderMeshVisual of the frame itself
     */
    get renderOrder() {
        return this.renderMeshVisual.getRenderOrder();
    }
    /**
     * @param renderOrder sets renderOrder for the renderMeshVisual of the frame itself
     */
    set renderOrder(renderOrder) {
        this.renderMeshVisual.setRenderOrder(renderOrder);
        this.closeButton.setRenderOrder(renderOrder);
        this.followButton.setRenderOrder(renderOrder);
    }
    /**
     * @returns ContainerFrame frame sceneObject
     */
    get object() {
        return this.frame;
    }
    /**
     * @param opacity sets opacity for all frame elements
     * note this parameter is effected by calls to `showVisual` and `hideVisual`
     */
    set opacity(opacity) {
        if (opacity > 0) {
            this.isVisible = true;
        }
        else {
            this.isVisible = false;
        }
        if (!this.destroyed) {
            this._opacity = opacity;
            this.material.mainPass.opacity = opacity;
            this.closeButton.setAlpha(opacity);
            this.followButton.setAlpha(opacity);
        }
    }
    /**
     * @returns current opacity of frame elements
     */
    get opacity() {
        return this._opacity;
    }
    /**
     * @param alpha sets alpha of the glass border of the frame
     */
    set borderAlpha(alpha) {
        if (!this.destroyed) {
            this.material.mainPass.borderAlpha = alpha;
        }
    }
    /**
     * @returns alpha of the glass border of the frame
     */
    get borderAlpha() {
        return this.material.mainPass.borderAlpha;
    }
    /**
     * @param alpha sets alpha of the dark backing effect of the frame
     */
    set backingAlpha(alpha) {
        if (!this.destroyed) {
            this.backingAlphaCache = alpha;
            this.material.mainPass.backingAlpha = alpha;
        }
    }
    /**
     * @returns alpha of the dark backing effect of the frame
     */
    get backingAlpha() {
        return this.material.mainPass.backingAlpha;
    }
    __initialize() {
        super.__initialize();
        this.framePrefab = requireAsset('./Prefabs/FramePrefab.prefab');
        this.labeledButtonPrefab = requireAsset('./Prefabs/container-button.prefab');
        this.closeIcon = requireAsset('./Textures/close-icon-1.png');
        this.followIcon = requireAsset('./Textures/follow-white.png');
        this.unfollowIcon = requireAsset('./Textures/follow-black.png');
        this.squeezeAmount = this.border * 0.15;
        this.buttonSize = defaultButtonSize;
        this.buttonScaleVector = vec3
            .one()
            .uniformScale(defaultButtonSize)
            .div(scaleFactorVector);
        this.animationManager = new animate_1.AnimationManager();
        this.onScalingUpdate = new Event_1.default();
        this.
        /**
         * event handler for frame scaling started
         */
        onScalingStart = new Event_1.default();
        this.
        /**
         * event handler for frame scaling ended
         */
        onScalingEnd = new Event_1.default();
        this.
        /**
         * public api for adding functions to the onScalingUpdate event handler
         */
        onScalingUpdateEvent = this.onScalingUpdate.publicApi();
        this.
        /**
         * public api for adding functions to the onScalingStart event handler
         */
        onScalingStartEvent = this.onScalingStart.publicApi();
        this.
        /**
         * public api for adding functions to the onScalingEnd event handler
         */
        onScalingEndEvent = this.onScalingEnd.publicApi();
        this.onTranslationStartEvent = new Event_1.default();
        this.
        /**
         * public api for adding functions to the onTranslationStartEvent event handler
         */
        onTranslationStart = this.onTranslationStartEvent.publicApi();
        this.onTranslationEndEvent = new Event_1.default();
        this.
        /**
         * public api for adding functions to the onTranslationEndEvent event handler
         */
        onTranslationEnd = this.onTranslationEndEvent.publicApi();
        this.onHoverEnterInnerInteractableEvent = new Event_1.default();
        this.onHoverEnterInnerInteractable = this.onHoverEnterInnerInteractableEvent.publicApi();
        this.onHoverExitInnerInteractableEvent = new Event_1.default();
        this.onHoverExitInnerInteractable = this.onHoverExitInnerInteractableEvent.publicApi();
        this.inputState = {
            isHovered: false,
            rawHovered: false,
            isPinching: false,
            position: vec3.zero(),
            isFront: true,
            isBack: false,
            drag: vec3.zero(),
            innerInteractableActive: false,
            needCursor: false,
        };
        this._opacity = 1;
        this.opacityCancel = new animate_1.CancelSet();
        this._isVisible = true;
        this.scalingLastFrame = false;
        this.translatingLastFrame = false;
        this.onMovingShrinkFactor = 0;
        this.squeezeCancel = new animate_1.CancelSet();
        this.translateMode = 0;
        this.translateModeCancel = new animate_1.CancelSet();
        this.allInteractables = [];
        this.billboardComponent = null;
        this.interactableCached = null;
        this.manipulateCached = null;
        this.snapBehavior = null;
        this.currentInteractor = null;
        this.
        /**
         * public api for adding functions to the onSnappingComplete event handler
         */
        onSnappingComplete = null;
        this.
        /**
         * reference to world camera
         */
        worldCamera = WorldCameraFinderProvider_1.default.getInstance().getComponent();
        this.
        /**
         * reference to frame's default front follow behavior
         */
        smoothFollow = null;
        this.currentBorder = this.border;
        this.destroyed = false;
        this.hoveringInnerInteractableLast = false;
        this.interactableHoverOpacity = 0.34;
        this.backingAlphaCache = DEFAULT_BACKING_ALPHA;
        this.hoveringContentInteractable = false;
        this.hoveringContentInteractableLast = false;
        this.cursorHighlightCancel = new animate_1.CancelSet();
        this.forcePreserveScale = false;
        this.lastConstantPadding = this.constantPadding.uniformScale(1);
        this.frustumBuffer = 0;
        this.unSubscribeList = [];
        this.updateCursorHighlightPosition = (e) => {
            var _a;
            if (e.interactor.targetHitInfo) {
                const hitPosition = (_a = e.interactor.targetHitInfo) === null || _a === void 0 ? void 0 : _a.hit.position;
                const normalizer = vec3.one().div(this.colliderShape.size);
                this.inputState.position = this.colliderTransform
                    .getInvertedWorldTransform()
                    .multiplyPoint(hitPosition)
                    .mult(normalizer);
            }
        };
        this.showCursorHighlight = () => {
            if (this.cursorHighlightCancel)
                this.cursorHighlightCancel.cancel();
            const startingHighlight = this.material.mainPass.isHovered;
            (0, animate_1.default)({
                duration: CURSOR_HIGHLIGHT_ANIMATION_DURATION * (1 - startingHighlight),
                cancelSet: this.cursorHighlightCancel,
                update: (t) => {
                    this.material.mainPass.isHovered = t;
                },
            });
        };
        this.hideCursorHighlight = () => {
            if (this.cursorHighlightCancel)
                this.cursorHighlightCancel.cancel();
            const startingHighlight = this.material.mainPass.isHovered;
            (0, animate_1.default)({
                duration: CURSOR_HIGHLIGHT_ANIMATION_DURATION * startingHighlight,
                cancelSet: this.cursorHighlightCancel,
                update: (t) => {
                    this.material.mainPass.isHovered =
                        startingHighlight - t * startingHighlight;
                },
            });
        };
        this.
        /**
         * set diameter of buttons in centimeters
         * @param size
         */
        setButtonScale = (size) => {
            this.buttonSize = size * buttonMagicNumber;
            this.buttonScaleVector = vec3
                .one()
                .uniformScale(this.buttonSize)
                .div(scaleFactorVector);
            this.scaleAndPositionButtons();
        };
        this.update = () => {
            var _a, _b, _c, _d, _e;
            /// if in capture getDeltaTime returns 0
            if (getDeltaTime() === 0) {
                // lighten background if in capture
                if (this.backingAlpha !== CAPTURE_BACKING_ALPHA) {
                    // set directly to not update backingAlphaCache
                    this.material.mainPass.backingAlpha = CAPTURE_BACKING_ALPHA;
                }
            }
            else {
                //not in capture
                if (this.backingAlpha !== this.backingAlphaCache) {
                    // reset to stored value
                    this.backingAlpha = this.backingAlphaCache;
                }
            }
            // confirm not destroyed before looping more
            if (this.destroyed) {
                // if destroyed return will stop looping as update requests itself
                return;
            }
            this.inputHandler.update(this.inputState);
            // only billboard on translate
            if (this.inputHandler.state.translating) {
                if (this.billboardComponent !== null) {
                    this.billboardComponent.xAxisEnabled = this.xOnTranslate || this.xAlways;
                    this.billboardComponent.yAxisEnabled = this.yOnTranslate || this.yAlways;
                }
                if (!this.translatingLastFrame) {
                    // just started translating
                    const currentSqueeze = this.onMovingShrinkFactor;
                    this.tweenMarginSqueeze(currentSqueeze, this.squeezeAmount);
                    const currentTranslateMode = this.translateMode;
                    this.tweenTranslateMode(currentTranslateMode, 1);
                }
                this.translatingLastFrame = true;
            }
            else {
                if ((this.billboardComponent !== null && !this.isFollowing) ||
                    this.xAlways ||
                    this.yAlways) {
                    this.billboardComponent.xAxisEnabled = false || this.xAlways;
                    this.billboardComponent.yAxisEnabled = false || this.yAlways;
                }
                if (this.translatingLastFrame) {
                    // just stopped translating
                    const currentSqueeze = this.onMovingShrinkFactor;
                    this.tweenMarginSqueeze(currentSqueeze, 0);
                    const currentTranslateMode = this.translateMode;
                    this.tweenTranslateMode(currentTranslateMode, 0);
                }
                this.translatingLastFrame = false;
            }
            this.currentBorder = this.border - this.onMovingShrinkFactor;
            if (!this.innerSize.equal(this.targetScaleCache) ||
                this.currentBorder !== this.material.mainPass.frameMargin ||
                !this.constantPadding.equal(this.lastConstantPadding)) {
                this.targetScaleCache.x = this.innerSize.x;
                this.targetScaleCache.y = this.innerSize.y;
                this.lastConstantPadding.x = this.constantPadding.x;
                this.lastConstantPadding.y = this.constantPadding.y;
                this.scaleFrame();
            }
            this.inputState.innerInteractableActive =
                this.inputState.innerInteractableActive ||
                    this.inputHandler.state.hoveringInteractable;
            if (this.inputState.innerInteractableActive &&
                !this.hoveringInnerInteractableLast) {
                const currentOpacity = this._opacity;
                if (this.autoShowHide) {
                    this.tweenOpacity(currentOpacity, this.interactableHoverOpacity);
                }
                // start hovering inner interactable
                this.onHoverEnterInnerInteractableEvent.invoke();
            }
            else if (!this.inputState.innerInteractableActive &&
                this.hoveringInnerInteractableLast) {
                const currentOpacity = this._opacity;
                if (this.inputState.rawHovered) {
                    if (this.autoShowHide) {
                        this.tweenOpacity(currentOpacity, 1);
                    }
                }
                // stop hovering inner interactable
                this.onHoverExitInnerInteractableEvent.invoke();
            }
            this.hoveringInnerInteractableLast = this.inputState.innerInteractableActive;
            this.cursorHandler.update(this.inputState, this.inputHandler.state);
            this.material.mainPass.translateMode = this.translateMode;
            if (!this.scalingLastFrame && !this.translatingLastFrame) {
                this.material.mainPass.touchPosition = this.inputState.position;
            }
            if (this.inputHandler.state.scaling && !this.scalingLastFrame) {
                // first frame scaling
                (_a = this.smoothFollow) === null || _a === void 0 ? void 0 : _a.startDragging();
            }
            if (!this.inputHandler.state.scaling && this.scalingLastFrame) {
                // first frame NOT scaling
                (_b = this.smoothFollow) === null || _b === void 0 ? void 0 : _b.finishDragging();
            }
            this.scalingLastFrame = this.inputHandler.state.scaling;
            (_c = this.snapBehavior) === null || _c === void 0 ? void 0 : _c.setScaling(this.inputHandler.state.scaling);
            if (this.inputHandler.state.translating)
                (_d = this.snapBehavior) === null || _d === void 0 ? void 0 : _d.update();
            if (this.isFollowing) {
                (_e = this.smoothFollow) === null || _e === void 0 ? void 0 : _e.onUpdate();
            }
            this.animationManager.requestAnimationFrame(this.update);
        };
        this.scaleFrame = () => {
            var _a;
            this.material.mainPass.frameMargin = this.currentBorder;
            this.material.mainPass.scaleFactor = scaleFactor;
            const doubleMargin = this.currentBorder * 2;
            const meshEdges = scaleFactor * magicScalar;
            this.material.mainPass.scaleX =
                this.targetScaleCache.x +
                    doubleMargin -
                    meshEdges +
                    this.constantPadding.x;
            this.material.mainPass.scaleY =
                this.targetScaleCache.y +
                    doubleMargin -
                    meshEdges +
                    this.constantPadding.y;
            this.material.mainPass.scaleZ = scaleZ / zScaleAdjuster;
            this.material.mainPass.rawScale = new vec2(this.targetScaleCache.x + this.constantPadding.x, this.targetScaleCache.y + this.constantPadding.y);
            const fullScale = new vec2(this.targetScaleCache.x + this.constantPadding.x + doubleMargin, this.targetScaleCache.y + this.constantPadding.y + doubleMargin);
            this.material.mainPass.fullScale = new vec2(fullScale.x, fullScale.y);
            const aspectRatio = new vec2(1, 1);
            if (fullScale.x > fullScale.y) {
                aspectRatio.y = fullScale.x / fullScale.y;
            }
            else {
                aspectRatio.x = fullScale.y / fullScale.x;
            }
            this.material.mainPass.aspectRatio = new vec2(aspectRatio.x, aspectRatio.y);
            this.material.mainPass.originalScale = new vec2(this.originalScale.x + this.currentBorder, this.originalScale.y + this.currentBorder);
            this.colliderShape.size = new vec3((this.targetScaleCache.x +
                this.currentBorder * 2 +
                this.constantPadding.x) /
                scaleFactor, (this.targetScaleCache.y +
                this.currentBorder * 2 +
                this.constantPadding.y) /
                scaleFactor, scaleZ / zScaleAdjuster);
            this.renderMeshVisual.mainMaterial.mainPass.frustumCullMin = new vec3(this.colliderShape.size.x * -0.5 - this.frustumBuffer, this.colliderShape.size.y * -0.5 - this.frustumBuffer, this.colliderShape.size.z * -0.5);
            this.renderMeshVisual.mainMaterial.mainPass.frustumCullMax = new vec3(this.colliderShape.size.x * 0.5 + this.frustumBuffer, this.colliderShape.size.y * 0.5 + this.frustumBuffer, this.colliderShape.size.z * 0.5);
            this.inputHandler.gutterSize.x =
                this.currentBorder / (scaleFactor * this.colliderShape.size.x);
            this.inputHandler.gutterSize.y =
                this.currentBorder / (scaleFactor * this.colliderShape.size.y);
            this.scaleAndPositionButtons();
            this.frameTransform.setLocalPosition(vec3.zero());
            this.frameTransform.setLocalRotation(quat.quatIdentity());
            this.targetTransform.setLocalPosition(new vec3(0, 0, scaleZ + 0.5));
            this.targetTransform.setLocalRotation(quat.quatIdentity());
            if (this.autoScaleContent) {
                if (!this.forcePreserveScale) {
                    const factor = this.innerSize.div(this.originalScale);
                    this.targetTransform.setLocalScale(new vec3(factor.x, factor.y, 1));
                }
                else {
                    // update original with cloned cache to prevent reset on next scaling
                    this.originalScale = this.targetScaleCache.uniformScale(1);
                }
            }
            (_a = this.smoothFollow) === null || _a === void 0 ? void 0 : _a.resize(this.innerSize.x + doubleMargin + this.constantPadding.x);
            if (!this.forcePreserveScale) {
                this.onScalingUpdate.invoke();
            }
            else {
                this.forcePreserveScale = false;
            }
        };
        this.scaleAndPositionButtons = () => {
            this.closeButton.transform.setLocalScale(this.buttonScaleVector);
            this.followButton.transform.setLocalScale(this.buttonScaleVector);
            const halfFrameWidth = (this.innerSize.x * 0.5 +
                this.constantPadding.x * 0.5 +
                this.currentBorder) /
                scaleFactor;
            const halfFrameHeight = (this.innerSize.y * 0.5 +
                this.constantPadding.y * 0.5 +
                this.currentBorder) /
                scaleFactor;
            const buttonOffset = (this.buttonSize / scaleFactor) * -1 - BUTTON_CORNER_OFFSET;
            // CORNER POSITIONING
            this.closeButton.transform.setLocalPosition(new vec3(-halfFrameWidth - buttonOffset, halfFrameHeight + buttonOffset, 0.1));
            this.followButton.transform.setLocalPosition(new vec3(halfFrameWidth + buttonOffset, halfFrameHeight + buttonOffset, 0.1));
        };
        this.
        /**
         * setup billboarding component with the following parameters
         * @param useBillboard
         * @param xOnTranslate
         * @param xAlways
         * @param yOnTranslate
         * @param yAlways
         */
        setBillboarding = (useBillboard, xOnTranslate = false, xAlways = false, yOnTranslate = false, yAlways = false) => {
            this.useBillboarding = useBillboard;
            if (this.useBillboarding) {
                this.xOnTranslate = xOnTranslate;
                this.xAlways = xAlways;
                this.yOnTranslate = yOnTranslate;
                this.yAlways = yAlways;
                if (this.billboardComponent === null) {
                    this.billboardComponent = this.parent.createComponent(Billboard_1.Billboard.getTypeName());
                }
                this.billboardComponent.xAxisEnabled = false || this.xAlways;
                this.billboardComponent.yAxisEnabled = false || this.yAlways;
            }
            else {
                if (this.billboardComponent) {
                    this.billboardComponent.xAxisEnabled = false;
                    this.billboardComponent.yAxisEnabled = false;
                }
            }
        };
        this.setYAlways = (yAlways) => {
            this.setBillboarding(this.useBillboarding, this.xOnTranslate, this.xAlways, this.yOnTranslate, yAlways);
        };
        this.setUseBillboarding = (useBillboarding) => {
            this.setBillboarding(useBillboarding, this.xOnTranslate, this.xAlways, this.yOnTranslate, this.yAlways);
        };
        this.
        /**
         * @returns frame's Interactable
         */
        getInteractable = () => {
            if (this.interactableCached === null) {
                this.interactableCached = this.interactable;
            }
            return this.interactableCached;
        };
        this.
        /**
         * @returns frame's parent's Interactable
         */
        getParentInteractable = () => {
            return this.parentInteractable;
        };
        this.
        /**
         * @returns frame's InteractableManipulation
         */
        getInteractableManipulation = () => {
            if (this.manipulateCached === null) {
                this.manipulateCached = this.manipulate;
            }
            return this.manipulateCached;
        };
        this.
        /**
         * @param isInteractable set if content is interactable
         */
        setIsContentInteractable = (isInteractable) => {
            this.isContentInteractable = isInteractable;
            this.inputHandlerOptions.isInteractable = isInteractable;
        };
        this.
        /**
         * @param isSnappable turns on or off snappableBehavior
         */
        setIsSnappable = (isSnappable) => {
            this.useSnapping = isSnappable;
            if (isSnappable) {
                if (!this.snapBehavior) {
                    this.createSnappableBehavior();
                }
            }
            if (this.snapBehavior) {
                this.snapBehavior.isEnabled = isSnappable;
            }
        };
        this.setUseWorldSnapping = (enable) => {
            this.worldSnapping = enable;
            if (!this.snapBehavior && enable) {
                this.createSnappableBehavior();
            }
            this.snapBehavior.enableWorldSnapping(enable);
        };
        this.setUseItemSnapping = (enable) => {
            this.itemSnapping = enable;
            if (!this.snapBehavior && enable) {
                this.createSnappableBehavior();
            }
            this.snapBehavior.enableItemSnapping(enable);
        };
        this.createSnappableBehavior = () => {
            this.snapBehavior = new SnappableBehavior_1.SnappableBehavior({
                frame: this,
                worldSnapping: this.worldSnapping,
                itemSnapping: this.itemSnapping,
            });
            this.onSnappingComplete = this.snapBehavior.snappingComplete();
        };
        this.
        /**
         * abort snapping behavior
         */
        abortSnapping = () => {
            var _a;
            (_a = this.snapBehavior) === null || _a === void 0 ? void 0 : _a.abortSnapping();
        };
        this.
        /**
         * @param allowScaling enable or disable user scaling
         */
        setAllowScaling = (allowScaling) => {
            this.allowScaling = allowScaling;
            this.inputHandler.allowScaling = this.allowScaling;
            const scaleHandles = vec4.zero();
            if (allowScaling) {
                if (!this.showFollowButton)
                    scaleHandles.x = 1;
                scaleHandles.y = 1;
                scaleHandles.z = 1;
                if (!this.showCloseButton)
                    scaleHandles.w = 1;
            }
            this.material.mainPass.scaleHandles = scaleHandles;
        };
        this.setInnerSizePreserveScale = (newSize) => {
            this.forcePreserveScale = true;
            this.innerSize = newSize;
        };
        this.
        /**
         * @param useFollow enable or disable the option to turn on the default follow behavior with the follow button
         */
        setUseFollow = (useFollow) => {
            this.useFOVFollow = useFollow;
            if (useFollow && !this.smoothFollow) {
                this.smoothFollow = new SmoothFollow_1.SmoothFollow({
                    frame: this,
                });
            }
        };
        this.
        /**
         * @param isFollowing enable or disable the following button and defualt behavior ( if it is enabled )
         */
        setIsFollowing = (isFollowing) => {
            this.isFollowing = isFollowing;
            if (this.isFollowing) {
                if (this.billboardComponent !== null) {
                    this.billboardComponent.xAxisEnabled = this.xOnTranslate || this.xAlways;
                    this.billboardComponent.yAxisEnabled = this.yOnTranslate || this.yAlways;
                }
                this.followButton.toggled = true;
                this.followButton.setColor('trigger');
                this.followButton.setTexture(1);
            }
            else {
                this.followButton.setColor('default');
                this.followButton.toggled = false;
                this.followButton.setTexture(0);
            }
        };
        this.
        /**
         * @returns whether the snapping behavior is currently tweening
         */
        isSnappingTweening = () => {
            if (this.snapBehavior) {
                return this.snapBehavior.isTweening;
            }
            return false;
        };
        this.
        /**
         * @returns whether the snapping behavior is checking for snappable elements
         */
        isSnappingActive = () => {
            if (this.snapBehavior) {
                return this.snapBehavior.isActive;
            }
            return false;
        };
        this.
        /**
         * @param isActive whether or not to activate snapping
         */
        setSnappingActive = (isActive) => {
            if (this.snapBehavior) {
                this.snapBehavior.isActive = isActive;
            }
        };
        this.
        /**
         * @returns inner object which contains original children
         */
        getTargetObject = () => this.target;
        this.
        /**
         * @returns returns the frame sceneobject
         */
        getFrameObject = () => this.frame;
        this.
        /**
         * @param opacity
         * sets opacity of frame when hovering interactable content in the frame
         */
        setHoverInteractableOpacity = (opacity) => {
            this.interactableHoverOpacity = opacity;
        };
        this.
        /**
         * @param minimumSize set minimum scale of frame
         */
        setminimumSize = (minimumSize) => {
            this.inputHandler.minimumSize = minimumSize;
        };
        this.
        /**
         * @param maximumSize set maximum scale of frame
         */
        setmaximumSize = (maximumSize) => {
            this.inputHandler.maximumSize = maximumSize;
        };
        this.
        /**
         * @param isInteractable enable or disable interactable elements of the frame
         */
        enableInteractables = (isInteractable) => {
            for (let i = 0; i < this.allInteractables.length; i++) {
                this.allInteractables[i].enabled = isInteractable;
            }
        };
        this.
        /**
         * function for fully destroying the frame
         */
        destroy = () => {
            var _a;
            log.d('destroy isDestroyed:' + this.destroyed);
            if (!this.destroyed) {
                this.destroyed = true;
                this.unSubscribeList.forEach((sub) => {
                    sub();
                });
                this.parentHoverBehavior.destroy();
                (_a = this.snapBehavior) === null || _a === void 0 ? void 0 : _a.destroy();
                if (!isNull(this.frame)) {
                    this.frame.destroy();
                }
                this.enabled = false;
            }
        };
        this.
        /**
         * @returns follow button SceneObject
         */
        getFollowButton = () => this.followButton.object;
        this.
        /**
         * @returns close button SceneObject
         */
        getCloseButton = () => this.closeButton.object;
        this.
        /**
         * for setting additional close button trigger functions
         * @param onTrigger function that gets called on trigger
         */
        addCloseButtonOnTrigger = (onTrigger) => {
            this.closeButton.onTrigger.add(onTrigger);
        };
        this.
        /**
         * for setting additional follow button trigger functions
         * @param onTrigger function that gets called on trigger
         */
        addFollowButtonOnTrigger = (onTrigger) => {
            this.followButton.onTrigger.add(onTrigger);
        };
        this.
        /**
         *
         * @returns parent transform of top container object
         */
        getParentTransform = () => this.parentTransform;
        this.
        /**
         * tween to show visuals of frame and elements
         */
        showVisual = () => {
            const currentOpacity = this._opacity;
            // enable on show
            this.renderMeshVisual.enabled = true;
            if (this.closeButton && this.showCloseButton) {
                this.closeButton.object.enabled = true;
            }
            if (this.followButton && this.showFollowButton) {
                this.followButton.object.enabled = true;
            }
            this.tweenOpacity(currentOpacity, 1);
        };
        this.
        /**
         * tween to hide visuals of frame and elementss
         */
        hideVisual = () => {
            const currentOpacity = this._opacity;
            this.tweenOpacity(currentOpacity, 0, () => {
                // disable on hide
                this.renderMeshVisual.enabled = false;
                if (this.closeButton)
                    this.closeButton.object.enabled = false;
                if (this.followButton)
                    this.followButton.object.enabled = false;
            });
        };
        this.
        /**
         * tween from current opacity to target opacity, will cancel existing opacity tweens
         * @param currentOpacity
         * @param targetOpacity
         */
        tweenOpacity = (currentOpacity, targetOpacity, endCallback = () => { }) => {
            if (this.opacityCancel)
                this.opacityCancel.cancel();
            (0, animate_1.default)({
                duration: OPACITY_TWEEN_DURATION * Math.abs(targetOpacity - currentOpacity),
                update: (t) => {
                    this.opacity = (0, mathUtils_1.lerp)(currentOpacity, targetOpacity, t);
                },
                ended: endCallback,
                cancelSet: this.opacityCancel,
            });
        };
        this.
        /**
         * @param enabled set close button enabled or disabled
         */
        enableCloseButton = (enabled) => {
            this.closeButton.object.enabled = enabled;
            const scaleHandles = this.material.mainPass.scaleHandles;
            scaleHandles.w = enabled && this.allowScaling ? 1 : 0;
            this.material.mainPass.scaleHandles = scaleHandles;
        };
        this.
        /**
         * @param enabled set follow button enabled or disabled
         */
        enableFollowButton = (enabled) => {
            this.followButton.object.enabled = enabled;
            const scaleHandles = this.material.mainPass.scaleHandles;
            scaleHandles.y = enabled && this.allowScaling ? 1 : 0;
            this.material.mainPass.scaleHandles = scaleHandles;
        };
        this.tweenMarginSqueeze = (currentSqueeze, targetSqueeze) => {
            (0, animate_1.default)({
                duration: SQUEEZE_TWEEN_DURATION,
                easing: 'ease-out-back-cubic',
                update: (t) => {
                    this.onMovingShrinkFactor = (0, mathUtils_1.lerp)(currentSqueeze, targetSqueeze, t);
                },
                cancelSet: this.squeezeCancel,
            });
        };
        this.tweenTranslateMode = (current, target) => {
            (0, animate_1.default)({
                duration: SQUEEZE_TWEEN_DURATION,
                update: (t) => {
                    this.translateMode = (0, mathUtils_1.lerp)(current, target, t);
                },
                cancelSet: this.translateModeCancel,
            });
        };
    }
};
exports.ContainerFrame = ContainerFrame;
exports.ContainerFrame = ContainerFrame = __decorate([
    component
], ContainerFrame);
//# sourceMappingURL=ContainerFrame.js.map