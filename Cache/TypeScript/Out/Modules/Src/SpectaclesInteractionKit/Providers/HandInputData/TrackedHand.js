"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TrackingEvent = void 0;
const Event_1 = require("../../Utils/Event");
const NativeLogger_1 = require("../../Utils/NativeLogger");
const PinchDetector_1 = require("./GestureProvider/PinchDetection/PinchDetector");
const Joints_1 = require("./Joints");
const WorldCameraFinderProvider_1 = require("../CameraProvider/WorldCameraFinderProvider");
const DefaultHandTrackingAssetProvider_1 = require("./DefaultHandTrackingAssetProvider");
const GestureModuleProvider_1 = require("./GestureProvider/GestureModuleProvider");
const PalmTapDetector_1 = require("./GestureProvider/PalmTapDetection/PalmTapDetector");
const Keypoint_1 = require("./Keypoint");
const LandmarkNames_1 = require("./LandmarkNames");
var TrackingEvent;
(function (TrackingEvent) {
    TrackingEvent["OnTrackingStarted"] = "OnTrackingStarted";
    TrackingEvent["OnTrackingLost"] = "OnTrackingLost";
})(TrackingEvent || (exports.TrackingEvent = TrackingEvent = {}));
const TAG = 'TrackedHand';
const HAND_FACING_THRESHOLD = 40.0;
const POINTING_PITCH_THRESHOLD = -60.0;
/**
 * Manages a tracked hand, instantiates fingers and wrists.
 * Also manages the {@link ObjectTracking3D} and creates
 * the needed scene object hierarchy to achieve hand mesh visualization as well as landmarks tracking
 */
class TrackedHand {
    constructor(config) {
        this.config = config;
        // Dependency injection
        this.handTrackingAssetProvider = DefaultHandTrackingAssetProvider_1.default.getInstance();
        this.sceneObjectManager = global.scene;
        this.worldCamera = WorldCameraFinderProvider_1.default.getInstance();
        this.gestureModuleProvider = GestureModuleProvider_1.default.getInstance();
        // Native Logging
        this.log = new NativeLogger_1.default(TAG);
        // SceneObject
        this._enabled = true;
        this.isDestroyed = false;
        // Events
        this.onEnabledChangedEvent = new Event_1.default();
        this.onEnabledChanged = this.onEnabledChangedEvent.publicApi();
        this.onHandFoundEvent = new Event_1.default();
        this.onHandFound = this.onHandFoundEvent.publicApi();
        this.onHandLostEvent = new Event_1.default();
        this.onHandLost = this.onHandLostEvent.publicApi();
        // Keypoints
        this.keypoints = new Map();
        this.allPoints = [];
        this.thumbFingerPoints = [];
        this.indexFingerPoints = [];
        this.middleFingerPoints = [];
        this.ringFingerPoints = [];
        this.pinkyFingerPoints = [];
        this._isDominantHand = this.config.isDominantHand;
        this._targetingData = null;
        this.ownerSceneObject = this.sceneObjectManager.createSceneObject(this.handType === 'left' ? 'LeftHandModelOwner' : 'RightHandModelOwner');
        this.ownerSceneObject.setParent(this.worldCamera.getComponent().getSceneObject());
        this.objectTracking3DComponent = this.ownerSceneObject.createComponent('Component.ObjectTracking3D');
        if (this.objectTracking3DComponent === undefined) {
            throw new Error('Failed to create Component.ObjectTracking3D');
        }
        this.objectTracking3DComponent.trackingAsset =
            this.handTrackingAssetProvider.get(this.config.handType);
        this.objectTracking3DComponent.objectIndex = 0;
        this.objectTracking3DComponent.trackingMode =
            ObjectTracking3D.TrackingMode.Attachment;
        const logObjectTrackingEvent = (eventName) => {
            this.log.d(`Received event from ObjectTracking3D: handType: ${this.config.handType}, eventType: ${eventName}`);
        };
        this.objectTracking3DComponent.onTrackingStarted = () => {
            logObjectTrackingEvent(TrackingEvent.OnTrackingStarted);
            this.onHandFoundEvent.invoke();
            this.log.v('HandEvent : ' + 'Hand Found Event');
        };
        this.objectTracking3DComponent.onTrackingLost = () => {
            logObjectTrackingEvent(TrackingEvent.OnTrackingLost);
            this.onHandLostEvent.invoke();
            this.log.v('HandEvent : ' + 'Hand Lost Event');
        };
        this.attachJoints(Joints_1.JOINT_HIERARCHY.children);
        this.setKeypointCollections();
        this.pinchDetector = new PinchDetector_1.PinchDetector({
            handType: this.config.handType,
            thumbTip: this.thumbTip,
            indexTip: this.indexTip,
            onHandLost: this.onHandLost,
            isTracked: () => {
                return this.isTracked();
            },
            pinchDetectionSelection: PinchDetector_1.PinchDetectionSelection.LensCoreML,
        });
        this.onPinchDown = this.pinchDetector.onPinchDown;
        this.onPinchUp = this.pinchDetector.onPinchUp;
        this.onPinchCancel = this.pinchDetector.onPinchCancel;
        const gestureModule = this.gestureModuleProvider.getGestureModule();
        try {
            if (gestureModule !== undefined) {
                const gestureHandType = this.handType === 'right'
                    ? GestureModule.HandType.Right
                    : GestureModule.HandType.Left;
                gestureModule.getTargetingDataEvent(gestureHandType).add((args) => {
                    const rayOriginInWorld = args.rayOriginInWorld;
                    const rayDirectionInWorld = args.rayDirectionInWorld;
                    this._targetingData = {
                        targetingDirectionInWorld: rayDirectionInWorld,
                        targetingLocusInWorld: rayOriginInWorld,
                    };
                    this.log.v('HandEvent : ' +
                        'Targeting Data Event' +
                        ' rayOriginInWorld: ' +
                        rayOriginInWorld +
                        ' rayDirectionInWorld: ' +
                        rayDirectionInWorld);
                });
            }
        }
        catch (error) {
            this.log.e(`Error subscribing to targeting ray event: ${error}`);
        }
        try {
            if (this.handType === 'right') {
                this.palmTapDetector = new PalmTapDetector_1.default(GestureModule.HandType.Right);
            }
        }
        catch (error) {
            this.log.w('PalmTapDetector is not supported');
        }
    }
    get enabled() {
        return this._enabled;
    }
    /** @inheritdoc */
    setEnabled(isEnabled) {
        if (this._enabled === isEnabled) {
            return;
        }
        this._enabled = isEnabled;
        this.objectTracking3DComponent.enabled = this.enabled;
        this.onEnabledChangedEvent.invoke(this._enabled);
        this.log.v('HandEvent : ' + 'Hand Enabled Changed Event' + ' to ' + this._enabled);
    }
    /** @inheritdoc */
    isFacingCamera() {
        if (!this.isTracked()) {
            return false;
        }
        const facingCameraAngle = this.getFacingCameraAngle();
        return Boolean(facingCameraAngle !== null && facingCameraAngle < HAND_FACING_THRESHOLD);
    }
    /** @inheritdoc */
    isInTargetingPose() {
        if (!this.isTracked()) {
            return false;
        }
        const pitchAngle = this.getPalmPitchAngle();
        return (!this.isFacingCamera() &&
            pitchAngle !== null &&
            pitchAngle > POINTING_PITCH_THRESHOLD);
    }
    /** @inheritdoc */
    getPinchDirection() {
        if (!this.isTracked()) {
            return null;
        }
        const thumbTipPosition = this.thumbTip.position;
        const thumbKnucklePosition = this.thumbKnuckle.position;
        const indexMidJointPosition = this.indexMidJoint.position;
        const forward = thumbTipPosition.sub(thumbKnucklePosition).normalize();
        const right = indexMidJointPosition.sub(thumbKnucklePosition).normalize();
        const up = this.handType === 'right' ? right.cross(forward) : forward.cross(right);
        return quat.lookAt(forward, up);
    }
    getHandOrientation() {
        /**
         * 1. Create a right vector between the index and middle distals
         * 2. Create a forward vector between the wrist and middle distal
         * 3. Derive an up vector from the previous two vectors
         */
        const handRightVector = this.indexMidJoint.position
            .sub(this.middleMidJoint.position)
            .normalize();
        const handForwardVector = this.middleMidJoint.position
            .sub(this.wrist.position)
            .normalize();
        const handUpVector = handRightVector.cross(handForwardVector);
        const handToCameraVector = this.worldCamera
            .getWorldPosition()
            .sub(this.wrist.position)
            .normalize();
        return {
            forward: handForwardVector,
            right: handRightVector,
            up: handUpVector,
            cameraForward: handToCameraVector,
        };
    }
    /** @inheritdoc */
    getFacingCameraAngle() {
        if (!this.isTracked()) {
            return null;
        }
        /**
     * Apply the camera to wrist direction against the derived up vector to get facing angle
     */
        const handOrientationVectors = this.getHandOrientation();
        const dotHandCamera = handOrientationVectors.up.dot(handOrientationVectors.cameraForward);
        const angle = MathUtils.RadToDeg *
            Math.acos(this.config.handType === 'right' ? dotHandCamera : -dotHandCamera);
        return angle;
    }
    /** @inheritdoc */
    getPalmPitchAngle() {
        if (!this.isTracked()) {
            return null;
        }
        /**
     * Compare the hand's forward direction to world up
     */
        const handOrientationVectors = this.getHandOrientation();
        const dotHandUp = handOrientationVectors.forward.dot(vec3.up());
        const angle = 90 - MathUtils.RadToDeg * Math.acos(dotHandUp);
        return angle;
    }
    /** @inheritdoc */
    getPalmCenter() {
        if (!this.isTracked()) {
            return null;
        }
        return this.indexKnuckle.position
            .add(this.pinkyKnuckle.position)
            .add(this.middleToWrist.position)
            .uniformScale(1.0 / 3.0);
    }
    /** @inheritdoc */
    get wrist() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.WRIST);
    }
    /** @inheritdoc */
    get thumbProximal() {
        return this.thumbToWrist;
    }
    /** @inheritdoc */
    get thumbToWrist() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.WRIST_TO_THUMB);
    }
    /** @inheritdoc */
    get thumbIntermediate() {
        return this.thumbBaseJoint;
    }
    /** @inheritdoc */
    get thumbBaseJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.THUMB_0);
    }
    /** @inheritdoc */
    get thumbDistal() {
        return this.thumbKnuckle;
    }
    /** @inheritdoc */
    get thumbKnuckle() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.THUMB_1);
    }
    /** @inheritdoc */
    get thumbPad() {
        return this.thumbMidJoint;
    }
    /** @inheritdoc */
    get thumbMidJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.THUMB_2);
    }
    /** @inheritdoc */
    get thumbTip() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.THUMB_3);
    }
    /** @inheritdoc */
    get indexProximal() {
        return this.indexToWrist;
    }
    /** @inheritdoc */
    get indexToWrist() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.WRIST_TO_INDEX);
    }
    /** @inheritdoc */
    get indexIntermediate() {
        return this.indexKnuckle;
    }
    /** @inheritdoc */
    get indexKnuckle() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.INDEX_0);
    }
    /** @inheritdoc */
    get indexDistal() {
        return this.indexMidJoint;
    }
    /** @inheritdoc */
    get indexMidJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.INDEX_1);
    }
    /** @inheritdoc */
    get indexPad() {
        return this.indexUpperJoint;
    }
    /** @inheritdoc */
    get indexUpperJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.INDEX_2);
    }
    /** @inheritdoc */
    get indexTip() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.INDEX_3);
    }
    /** @inheritdoc */
    get middleProximal() {
        return this.middleToWrist;
    }
    /** @inheritdoc */
    get middleToWrist() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.WRIST_TO_MIDDLE);
    }
    /** @inheritdoc */
    get middleIntermediate() {
        return this.middleKnuckle;
    }
    /** @inheritdoc */
    get middleKnuckle() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.MIDDLE_0);
    }
    /** @inheritdoc */
    get middleDistal() {
        return this.middleMidJoint;
    }
    /** @inheritdoc */
    get middleMidJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.MIDDLE_1);
    }
    /** @inheritdoc */
    get middlePad() {
        return this.middleUpperJoint;
    }
    /** @inheritdoc */
    get middleUpperJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.MIDDLE_2);
    }
    /** @inheritdoc */
    get middleTip() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.MIDDLE_3);
    }
    /** @inheritdoc */
    get ringProximal() {
        return this.ringToWrist;
    }
    /** @inheritdoc */
    get ringToWrist() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.WRIST_TO_RING);
    }
    /** @inheritdoc */
    get ringIntermediate() {
        return this.ringKnuckle;
    }
    /** @inheritdoc */
    get ringKnuckle() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.RING_0);
    }
    /** @inheritdoc */
    get ringDistal() {
        return this.ringMidJoint;
    }
    /** @inheritdoc */
    get ringMidJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.RING_1);
    }
    /** @inheritdoc */
    get ringPad() {
        return this.ringUpperJoint;
    }
    /** @inheritdoc */
    get ringUpperJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.RING_2);
    }
    /** @inheritdoc */
    get ringTip() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.RING_3);
    }
    /** @inheritdoc */
    get pinkyProximal() {
        return this.pinkyToWrist;
    }
    /** @inheritdoc */
    get pinkyToWrist() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.WRIST_TO_PINKY);
    }
    /** @inheritdoc */
    get pinkyIntermediate() {
        return this.pinkyKnuckle;
    }
    /** @inheritdoc */
    get pinkyKnuckle() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.PINKY_0);
    }
    /** @inheritdoc */
    get pinkyDistal() {
        return this.pinkyMidJoint;
    }
    /** @inheritdoc */
    get pinkyMidJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.PINKY_1);
    }
    /** @inheritdoc */
    get pinkyPad() {
        return this.pinkyUpperJoint;
    }
    /** @inheritdoc */
    get pinkyUpperJoint() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.PINKY_2);
    }
    /** @inheritdoc */
    get pinkyTip() {
        return this.getKeypoint(LandmarkNames_1.LandmarkName.PINKY_3);
    }
    /** @inheritdoc */
    get thumbFinger() {
        return this.thumbFingerPoints;
    }
    /** @inheritdoc */
    get indexFinger() {
        return this.indexFingerPoints;
    }
    /** @inheritdoc */
    get middleFinger() {
        return this.middleFingerPoints;
    }
    /** @inheritdoc */
    get ringFinger() {
        return this.ringFingerPoints;
    }
    /** @inheritdoc */
    get pinkyFinger() {
        return this.pinkyFingerPoints;
    }
    /** @inheritdoc */
    get points() {
        return this.allPoints;
    }
    /** @inheritdoc */
    get handType() {
        return this.config.handType;
    }
    /** @inheritdoc */
    get isDominantHand() {
        return this._isDominantHand;
    }
    /** @inheritdoc */
    get objectTracking3D() {
        return this.objectTracking3DComponent;
    }
    /** @inheritdoc */
    get targetingData() {
        return this._targetingData;
    }
    /** @inheritdoc */
    isTracked() {
        return this.objectTracking3DComponent.isTracking();
    }
    /** @inheritdoc */
    getSceneObject() {
        return this.ownerSceneObject;
    }
    /** @inheritdoc */
    setIsDominantHand(isDominantHand) {
        this._isDominantHand = isDominantHand;
    }
    /** @inheritdoc */
    isPinching() {
        return this.pinchDetector.isPinching();
    }
    /** @inheritdoc */
    isTapping() {
        if (this.palmTapDetector === undefined) {
            return {
                state: 'unsupported',
            };
        }
        else {
            return {
                state: 'available',
                data: { isTapping: this.palmTapDetector.isTapping },
            };
        }
    }
    /** @inheritdoc */
    getPinchStrength() {
        if (!this.isTracked()) {
            return null;
        }
        return this.pinchDetector.getPinchStrength();
    }
    /** @inheritdoc */
    setTrackingMode(trackingMode) {
        this.objectTracking3DComponent.trackingMode = trackingMode;
    }
    /** @inheritdoc */
    getHandVisuals() {
        var _a;
        return (_a = this.handVisuals) !== null && _a !== void 0 ? _a : null;
    }
    /** @inheritdoc */
    attachHandVisuals(handVisuals) {
        this.handVisuals = handVisuals;
        this.objectTracking3DComponent.trackingMode =
            ObjectTracking3D.TrackingMode.ProportionsAndPose;
        this.handVisuals.root.setParent(this.ownerSceneObject);
        // Wrist
        this.wrist.addAttachmentPoint(this.handVisuals.wrist);
        // Thumb
        this.thumbToWrist.addAttachmentPoint(this.handVisuals.thumbToWrist);
        this.thumbBaseJoint.addAttachmentPoint(this.handVisuals.thumbBaseJoint);
        this.thumbKnuckle.addAttachmentPoint(this.handVisuals.thumbKnuckle);
        this.thumbMidJoint.addAttachmentPoint(this.handVisuals.thumbMidJoint);
        this.thumbTip.addAttachmentPoint(this.handVisuals.thumbTip);
        // Index
        this.indexToWrist.addAttachmentPoint(this.handVisuals.indexToWrist);
        this.indexKnuckle.addAttachmentPoint(this.handVisuals.indexKnuckle);
        this.indexMidJoint.addAttachmentPoint(this.handVisuals.indexMidJoint);
        this.indexUpperJoint.addAttachmentPoint(this.handVisuals.indexUpperJoint);
        this.indexTip.addAttachmentPoint(this.handVisuals.indexTip);
        // Middle
        this.middleToWrist.addAttachmentPoint(this.handVisuals.middleToWrist);
        this.middleKnuckle.addAttachmentPoint(this.handVisuals.middleKnuckle);
        this.middleMidJoint.addAttachmentPoint(this.handVisuals.middleMidJoint);
        this.middleUpperJoint.addAttachmentPoint(this.handVisuals.middleUpperJoint);
        this.middleTip.addAttachmentPoint(this.handVisuals.middleTip);
        // Ring
        this.ringToWrist.addAttachmentPoint(this.handVisuals.ringToWrist);
        this.ringKnuckle.addAttachmentPoint(this.handVisuals.ringKnuckle);
        this.ringMidJoint.addAttachmentPoint(this.handVisuals.ringMidJoint);
        this.ringUpperJoint.addAttachmentPoint(this.handVisuals.ringUpperJoint);
        this.ringTip.addAttachmentPoint(this.handVisuals.ringTip);
        // Pinky
        this.pinkyToWrist.addAttachmentPoint(this.handVisuals.pinkyToWrist);
        this.pinkyKnuckle.addAttachmentPoint(this.handVisuals.pinkyKnuckle);
        this.pinkyMidJoint.addAttachmentPoint(this.handVisuals.pinkyMidJoint);
        this.pinkyUpperJoint.addAttachmentPoint(this.handVisuals.pinkyUpperJoint);
        this.pinkyTip.addAttachmentPoint(this.handVisuals.pinkyTip);
    }
    /** @inheritdoc */
    detachHandVisuals(handVisuals) {
        if (this.handVisuals !== handVisuals) {
            return;
        }
        this.objectTracking3DComponent.trackingMode =
            ObjectTracking3D.TrackingMode.Attachment;
        this.keypoints.forEach((keypoint) => keypoint.clearAttachmentPoint());
        this.handVisuals = undefined;
    }
    /**
   * Destroys the hand and associated keypoints
   */
    destroy() {
        if (this.isDestroyed) {
            return;
        }
        this.ownerSceneObject.destroy();
        this.isDestroyed = true;
    }
    attachJoints(children) {
        for (const joint of children) {
            this.keypoints.set(joint.name, new Keypoint_1.Keypoint(joint.name, this.objectTracking3DComponent));
            this.attachJoints(joint.children);
        }
    }
    getKeypoint(landmarkName) {
        const keypoint = this.keypoints.get(landmarkName);
        if (!keypoint) {
            throw new Error(`Keypoint ${landmarkName} is not supported.`);
        }
        return keypoint;
    }
    setKeypointCollections() {
        this.thumbFingerPoints.push(this.thumbToWrist, this.thumbBaseJoint, this.thumbKnuckle, this.thumbMidJoint, this.thumbTip);
        this.indexFingerPoints.push(this.indexToWrist, this.indexKnuckle, this.indexMidJoint, this.indexUpperJoint, this.indexTip);
        this.middleFingerPoints.push(this.middleToWrist, this.middleKnuckle, this.middleMidJoint, this.middleUpperJoint, this.middleTip);
        this.ringFingerPoints.push(this.ringToWrist, this.ringKnuckle, this.ringMidJoint, this.ringUpperJoint, this.ringTip);
        this.pinkyFingerPoints.push(this.pinkyToWrist, this.pinkyKnuckle, this.pinkyMidJoint, this.pinkyUpperJoint, this.pinkyTip);
        this.allPoints.push(...this.thumbFingerPoints, ...this.indexFingerPoints, ...this.middleFingerPoints, ...this.ringFingerPoints, ...this.pinkyFingerPoints);
    }
}
exports.default = TrackedHand;
//# sourceMappingURL=TrackedHand.js.map