"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GlowEffectView = void 0;
const WorldCameraFinderProvider_1 = require("../../../Providers/CameraProvider/WorldCameraFinderProvider");
const SIKLogLevelProvider_1 = require("../../../Providers/InteractionConfigurationProvider/SIKLogLevelProvider");
const SIK_1 = require("../../../SIK");
const animate_1 = require("../../../Utils/animate");
const LensConfig_1 = require("../../../Utils/LensConfig");
const GlowEffectViewModel_1 = require("./GlowEffectViewModel");
const TAG = 'GlowEffectView';
const BILLBOARD_ANIMATION_DURATION_SECS = 0.033;
const GLOW_QUAD_WORLD_SCALE = new vec3(0.3, 0.3, 0.3);
const PINCH_BASE_BONUS_RATIO = 0.8;
const MAX_HAND_MESH_MATERIAL_BRIGHTNESS = 0.35;
const PINCH_ANIMATION_DURATION = 0.3;
const PINCH_STRENGTH_NEAR_PINCH_EXIT_THRESHOLD = 0.2;
const PINCH_STRENGTH_NEAR_PINCH_ENTER_THRESHOLD = 0.5;
/*
 * This determines what we consider to be "palm facing the camera", so a smaller value
 * means that your palm would need to be to be looking more "directly" at the camera
 * for us to consider it to be "facing the camera"
 */
const HAND_FACING_CAMERA_THRESHOLD_DEGREES = 90;
const VEC3_UP = vec3.up();
/**
 * GlowEffectView controls the glow effect that happens when pinching and tapping.
 *
 * I did not extend View class because while this q
 * acts like a View in the sense that it is messing with UI/visuals, it does so through SceneObjects and textures which are passed
 * in as parameters, instead of needing its own SceneObject hierarchy to be added.
 */
class GlowEffectView {
    constructor(config) {
        this.config = config;
        this.sikLogLevelProvider = SIKLogLevelProvider_1.default.getInstance();
        this.updateDispatcher = LensConfig_1.LensConfig.getInstance().updateDispatcher;
        this.handProvider = SIK_1.SIK.HandInputData;
        this.tapGlowEnabled = this.handProvider.getDominantHand().handType === this.config.handType;
        this.hand = this.handProvider.getHand(this.config.handType);
        this.handVisuals = this.hand.getHandVisuals();
        this.indexTipSceneObject = this.handVisuals.indexTip;
        this.thumbTipSceneObject = this.handVisuals.thumbTip;
        // handToTap is the hand NOT passed to this class
        this.handToTap = this.handProvider.getHand(this.config.handType === 'left' ? 'right' : 'left');
        this.camera = WorldCameraFinderProvider_1.default.getInstance();
        /*
       * Pinch glow effect uses a quad with glow material and texture on index
       * and thumb tip, both billboarded towards the camera
       */
        this.indexQuadSceneObject = this.setupTipQuadSceneObject(this.indexTipSceneObject, 'indexTipQuadSceneObject');
        this.indexQuadTransform = this.indexQuadSceneObject.getTransform();
        this.thumbQuadSceneObject = this.setupTipQuadSceneObject(this.thumbTipSceneObject, 'thumbTipQuadSceneObject');
        this.thumbQuadTransform = this.thumbQuadSceneObject.getTransform();
        /**
       * Pinch glow effect manipulates these materials to create the "glow"
       */
        this.tipGlowMaterialIndexTip = this.indexQuadSceneObject.getComponent('Component.RenderMeshVisual')
            .mainMaterial;
        this.tipGlowMaterialThumbTip = this.thumbQuadSceneObject.getComponent('Component.RenderMeshVisual')
            .mainMaterial;
        this.indexGlowBonusCancelSet = new animate_1.CancelSet();
        this.indexGlowStrengthCancelSet = new animate_1.CancelSet();
        this.thumbGlowBonusCancelSet = new animate_1.CancelSet();
        this.thumbGlowStrengthCancelSet = new animate_1.CancelSet();
        this.indexGlowBonus = 0;
        this.indexGlowBase = 0;
        this.thumbGlowBonus = 0;
        this.thumbGlowBase = 0;
        this.isInPalmUIMode = false;
        this.isInTargetingMode = false;
        this.isInNearPinchMode = false;
        this.glowEffectViewModel = new GlowEffectViewModel_1.GlowEffectViewModel({
            handType: this.config.handType,
            logLevel: this.sikLogLevelProvider.logLevel,
        });
        // Cached value from API .enabled calls
        this._enabled = true;
        // Connect to ViewModel events. This is how the glow effect will be driven
        this.glowEffectViewModel.animateIndexGlowBase.add((animateGlowBaseUp) => {
            this.animateIndexGlowBase(animateGlowBaseUp);
        });
        this.glowEffectViewModel.animateIndexGlowBonus.add((animateGlowBonusUp) => {
            this.animateIndexGlowBonus(animateGlowBonusUp);
        });
        this.glowEffectViewModel.animateThumbGlowBase.add((animateGlowBaseUp) => {
            this.animateThumbGlowBase(animateGlowBaseUp);
        });
        this.glowEffectViewModel.animateThumbGlowBonus.add((animateGlowBonusUp) => {
            this.animateThumbGlowBonus(animateGlowBonusUp);
        });
        this.glowEffectViewModel.tapModeChanged((tapModeEntered) => {
            if (tapModeEntered === true) {
                this.handVisuals.handMesh.mainPass['handGlowTex'] =
                    this.config.tapTexture;
            }
            else {
                this.handVisuals.handMesh.mainPass['handGlowTex'] =
                    this.config.pinchTexture;
            }
        });
        // Set up initial conditions
        this.setIsInPalmUiMode(this.calculateIsInPalmUIMode());
        this.setIsInTargetingMode(this.calculateIsInTargetingMode());
        this.setupPinchEvents();
        this.updateDispatcher
            .createUpdateEvent('GlowEffectViewUpdateEvent')
            .bind(() => {
            // If disabled via API, do not update the glow.
            if (!this._enabled) {
                return;
            }
            if (this.hand.getPinchStrength() === 0) {
                if (this.indexQuadSceneObject.enabled) {
                    this.indexQuadSceneObject.enabled = false;
                    this.thumbQuadSceneObject.enabled = false;
                }
            }
            else {
                const cameraPosition = this.camera.getWorldPosition();
                this.indexQuadTransform.setWorldRotation(quat.lookAt(cameraPosition.sub(this.indexQuadTransform.getWorldPosition()), VEC3_UP));
                this.thumbQuadTransform.setWorldRotation(quat.lookAt(cameraPosition.sub(this.thumbQuadTransform.getWorldPosition()), VEC3_UP));
                if (!this.indexQuadSceneObject.enabled) {
                    this.indexQuadSceneObject.enabled = true;
                    this.thumbQuadSceneObject.enabled = true;
                }
            }
            this.setIsInPalmUiMode(this.calculateIsInPalmUIMode());
            this.setIsInTargetingMode(this.calculateIsInTargetingMode());
            this.setIsInNearPinchMode(this.calculateIsInNearPinchMode());
        });
        this.updateDispatcher
            .createLateUpdateEvent('GlowEffectViewLateUpdateEvent')
            .bind(() => {
            // If disabled via API, do not update the glow.
            if (!this._enabled) {
                return;
            }
            this.updateMaterial();
        });
    }
    /**
   * Enable/disable the SceneObject's created by this class
   * @param isEnabled boolean representing whether to enable or disable this class
   */
    set enabled(isEnabled) {
        this._enabled = isEnabled;
        this.indexQuadSceneObject.enabled = isEnabled;
        this.thumbQuadSceneObject.enabled = isEnabled;
    }
    /**
   * Clean up the SceneObject's created by PinchGlow
   */
    destroy() {
        this.indexQuadSceneObject.destroy();
        this.thumbQuadSceneObject.destroy();
    }
    setupTipQuadSceneObject(parentSceneObject, sceneObjectName) {
        // Create the quad SceneObject to hold glow material and texture
        const quadSceneObject = global.scene.createSceneObject(sceneObjectName);
        quadSceneObject.setParent(parentSceneObject);
        quadSceneObject.getTransform().setWorldScale(GLOW_QUAD_WORLD_SCALE);
        const quadComponent = quadSceneObject.createComponent('Component.RenderMeshVisual');
        quadComponent.mesh = this.config.unitPlaneMesh;
        // Glow quad render order 10,000
        quadComponent.setRenderOrder(this.config.tipGlowRenderOrder);
        // Initialize the quad RenderMeshVisual with the glow material
        const tipGlowMaterial = this.config.tipGlowMaterial.clone();
        tipGlowMaterial.mainPass.depthTest = true;
        tipGlowMaterial.mainPass.depthWrite = false;
        tipGlowMaterial.mainPass.tintColor = this.config.idleColor;
        quadComponent.mainMaterial = tipGlowMaterial;
        return quadSceneObject;
    }
    updateMaterial() {
        const scaledIndexGlowBase = this.indexGlowBase * PINCH_BASE_BONUS_RATIO;
        const scaledIndexGlowBonus = this.indexGlowBonus * (1 - PINCH_BASE_BONUS_RATIO);
        const combinedIndexGlowFactor = scaledIndexGlowBase + scaledIndexGlowBonus;
        const scaledThumbGlowBase = this.thumbGlowBase * PINCH_BASE_BONUS_RATIO;
        const scaledThumbGlowBonus = this.indexGlowBonus * (1 - PINCH_BASE_BONUS_RATIO);
        const combinedThumbGlowFactor = scaledThumbGlowBase + scaledThumbGlowBonus;
        this.applyMaterialUpdates(combinedIndexGlowFactor, combinedThumbGlowFactor);
        this.updateMaterialTintColor(this.indexGlowBonus, this.thumbGlowBonus);
        this.handVisuals.handMesh.mainMaterial.mainPass['brightness'] =
            combinedIndexGlowFactor * MAX_HAND_MESH_MATERIAL_BRIGHTNESS;
    }
    applyMaterialUpdates(combinedIndexGlowFactor, combinedThumbGlowFactor) {
        this.tipGlowMaterialIndexTip.mainPass['fadeLevel'] = combinedIndexGlowFactor;
        this.tipGlowMaterialThumbTip.mainPass['fadeLevel'] = combinedThumbGlowFactor;
    }
    updateMaterialTintColor(indexGlowBonus, thumbGlowBonus) {
        const indexTintColor = vec4.lerp(this.config.idleColor, this.config.pinchDownColor, indexGlowBonus);
        const thumbTintColor = vec4.lerp(this.config.idleColor, this.config.pinchDownColor, thumbGlowBonus);
        this.tipGlowMaterialIndexTip.mainPass['tintColor'] = indexTintColor;
        this.tipGlowMaterialThumbTip.mainPass['tintColor'] = thumbTintColor;
    }
    setIsInPalmUiMode(isInPalmUIMode) {
        if (isInPalmUIMode === this.isInPalmUIMode) {
            return;
        }
        this.isInPalmUIMode = isInPalmUIMode;
        this.glowEffectViewModel.palmUIModeEvent(this.isInPalmUIMode);
    }
    setIsInTargetingMode(isInTargetingMode) {
        if (isInTargetingMode === this.isInTargetingMode) {
            return;
        }
        this.isInTargetingMode = isInTargetingMode;
        this.glowEffectViewModel.targetingEvent(this.isInTargetingMode);
    }
    setIsInNearPinchMode(isInNearPinchMode) {
        if (isInNearPinchMode === this.isInNearPinchMode) {
            return;
        }
        this.isInNearPinchMode = isInNearPinchMode;
        this.glowEffectViewModel.nearPinchEvent(this.isInNearPinchMode);
    }
    setupPinchEvents() {
        this.hand.onPinchDown.add(() => {
            this.glowEffectViewModel.pinchEvent(true);
        });
        this.hand.onPinchUp.add(() => {
            this.glowEffectViewModel.pinchEvent(false);
        });
        this.hand.onPinchCancel.add(() => {
            this.glowEffectViewModel.pinchEvent(false);
        });
    }
    calculateIsInNearPinchMode() {
        var _a;
        const pinchStrength = (_a = this.hand.getPinchStrength()) !== null && _a !== void 0 ? _a : 0;
        if (pinchStrength > PINCH_STRENGTH_NEAR_PINCH_ENTER_THRESHOLD &&
            this.isInNearPinchMode === false) {
            return true;
        }
        else if (pinchStrength < PINCH_STRENGTH_NEAR_PINCH_EXIT_THRESHOLD &&
            this.hand.isPinching() === false) {
            return false;
        }
        return true;
    }
    /**
   * @returns boolean
   */
    calculateIsInTargetingMode() {
        return !this.isHandFacingCamera(this.hand);
    }
    /**
   * Cannot use this.config.hand.isFacingCamera() as that only triggers if hand
   * is facing directly at camera, where we need more broad definition
   *
   * @param hand the BaseHand to check
   * @returns boolean
   */
    isHandFacingCamera(hand) {
        const handAngle = hand.getFacingCameraAngle();
        if (handAngle === null ||
            handAngle > HAND_FACING_CAMERA_THRESHOLD_DEGREES) {
            return false;
        }
        return true;
    }
    /*
   * isInPalmUI
   * 1) are both hands tracked
   * 2) are both hands visible / important landmarks visible in the display fov
   * 3) non dominant hand isPalmFacingCamera == true and dominant hand is not facing camera
   * 4) if distance between index finger tip and palm center is less than the threshold
   */
    calculateIsInPalmUIMode() {
        if (!this.tapGlowEnabled || !this.bothHandsTracked()) {
            return false;
        }
        const handToTapPinkyKnuckle = this.handToTap.pinkyKnuckle;
        const tappingHandIndexTip = this.hand.indexTip;
        if (handToTapPinkyKnuckle === null || tappingHandIndexTip === null) {
            return false;
        }
        const handToTapPinkyKnucklePos = handToTapPinkyKnuckle.position;
        const tappingHandIndexTipPos = tappingHandIndexTip.position;
        if (!this.camera.inFoV(handToTapPinkyKnucklePos) ||
            !this.camera.inFoV(tappingHandIndexTipPos)) {
            return false;
        }
        if (!this.isHandFacingCamera(this.handToTap) ||
            this.isHandFacingCamera(this.hand)) {
            return false;
        }
        const handToTapPalmCenterPos = this.handToTap.getPalmCenter();
        if (handToTapPalmCenterPos === null) {
            return false;
        }
        const distanceToPalmCenter = tappingHandIndexTipPos.distance(handToTapPalmCenterPos);
        if (distanceToPalmCenter >= this.config.tapProximityThreshold) {
            return false;
        }
        return true;
    }
    bothHandsTracked() {
        return (this.handProvider.getDominantHand().isTracked() &&
            this.handProvider.getNonDominantHand().isTracked());
    }
    animateIndexGlowBase(animateUp) {
        this.indexGlowStrengthCancelSet();
        (0, animate_1.default)({
            cancelSet: this.indexGlowStrengthCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: 'ease-in-out-back-cubic',
            start: this.indexGlowBase,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.indexGlowBase = t;
            },
        });
    }
    animateIndexGlowBonus(animateUp) {
        this.indexGlowBonusCancelSet();
        (0, animate_1.default)({
            cancelSet: this.indexGlowBonusCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: 'ease-in-out-back-cubic',
            start: this.indexGlowBonus,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.indexGlowBonus = t;
            },
        });
    }
    animateThumbGlowBase(animateUp) {
        this.thumbGlowStrengthCancelSet();
        (0, animate_1.default)({
            cancelSet: this.thumbGlowStrengthCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: 'ease-in-out-back-cubic',
            start: this.thumbGlowBase,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.thumbGlowBase = t;
            },
        });
    }
    animateThumbGlowBonus(animateUp) {
        this.thumbGlowBonusCancelSet();
        (0, animate_1.default)({
            cancelSet: this.thumbGlowBonusCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: 'ease-in-out-back-cubic',
            start: this.thumbGlowBonus,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.thumbGlowBonus = t;
            },
        });
    }
}
exports.GlowEffectView = GlowEffectView;
//# sourceMappingURL=GlowEffectView.js.map