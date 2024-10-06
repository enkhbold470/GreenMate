"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const BistableThreshold_1 = require("../../../../../Utils/BistableThreshold");
const Event_1 = require("../../../../../Utils/Event");
const LensConfig_1 = require("../../../../../Utils/LensConfig");
const mathUtils_1 = require("../../../../../Utils/mathUtils");
const NativeLogger_1 = require("../../../../../Utils/NativeLogger");
const WorldCameraFinderProvider_1 = require("../../../../CameraProvider/WorldCameraFinderProvider");
const PinchEventType_1 = require("../../PinchEventType");
const TAG = 'HeuristicPinchDetection';
const MIN_PINCH_DISTANCE = 2;
const MAX_PINCH_DISTANCE = 7;
/**
 * Class to detect pinch using a bistable threshold and the distance between index and thumb tips
 */
class HeuristicPinchDetectionStrategy {
    constructor(config) {
        this.config = config;
        // Native Logging
        this.log = new NativeLogger_1.default(TAG);
        this.worldCamera = WorldCameraFinderProvider_1.default.getInstance();
        this.pinchEnterThreshold = new BistableThreshold_1.default({
            edgeActivate: this.config.pinchDownThreshold,
            edgeDeactivate: 3.5,
        });
        this.thumbProjectThreshold = new BistableThreshold_1.default({
            edgeActivate: 3.0,
            edgeDeactivate: 4.5,
        });
        this.currentPinchProximity = 0;
        this.previousPinchProximity = 0;
        this._onPinchDetectedEvent = new Event_1.default();
        this._onPinchDetected = this._onPinchDetectedEvent.publicApi();
        this._onPinchProximityEvent = new Event_1.default();
        this._onPinchProximity = this._onPinchProximityEvent.publicApi();
        const lensConfig = LensConfig_1.LensConfig.getInstance();
        const updateDispatcher = lensConfig.updateDispatcher;
        updateDispatcher
            .createUpdateEvent('HeuristicPinchDetectionStrategyUpdate')
            .bind(() => {
            this.update();
        });
    }
    /** @inheritdoc */
    get onPinchDetected() {
        return this._onPinchDetected;
    }
    /** @inheritdoc */
    get onPinchProximity() {
        return this._onPinchProximity;
    }
    update() {
        const adjustedThumbPosition = this.adjustThumbDepthToPointer(this.config.thumbTip.position, this.config.indexTip.position);
        const pinchDistance = adjustedThumbPosition.sub(this.config.indexTip.position).lengthSquared;
        const thresholdResult = this.pinchEnterThreshold.update(pinchDistance);
        // thresholdResult will be null if the bistable threshold was not just crossed, false if just crossed to "deactivate" side, and true if just crossed to "activate" side
        if (thresholdResult === false) {
            this._onPinchDetectedEvent.invoke(PinchEventType_1.PinchEventType.Up);
        }
        else if (thresholdResult === true) {
            this._onPinchDetectedEvent.invoke(PinchEventType_1.PinchEventType.Down);
        }
        this.updatePinchProximity();
    }
    updatePinchProximity() {
        const distance = this.config.thumbTip.position.distance(this.config.indexTip.position);
        if (distance === null || distance > MAX_PINCH_DISTANCE) {
            this.currentPinchProximity = 0;
        }
        const mappedDistance = (0, mathUtils_1.mapValue)((0, mathUtils_1.clamp)(distance, MIN_PINCH_DISTANCE, MAX_PINCH_DISTANCE), MAX_PINCH_DISTANCE, MIN_PINCH_DISTANCE, 1, 0);
        this.currentPinchProximity = 1 - mappedDistance;
        if (this.currentPinchProximity !== this.previousPinchProximity) {
            this.previousPinchProximity = this.currentPinchProximity;
            this._onPinchProximityEvent.invoke(this.currentPinchProximity);
        }
    }
    adjustThumbDepthToPointer(thumb, pointer) {
        // project the thumb onto the plane that the pointer is on
        const cameraPosition = this.worldCamera.getWorldPosition();
        const thumbRay = thumb.sub(cameraPosition);
        const thumbDir = thumbRay.normalize();
        const pointerRay = pointer.sub(cameraPosition);
        const pointerDist = pointerRay.length;
        const adjustedThumb = cameraPosition.add(thumbDir.uniformScale(pointerDist));
        const change = adjustedThumb.sub(thumb).length;
        this.thumbProjectThreshold.update(change);
        const closeEnough = this.thumbProjectThreshold.getState();
        return closeEnough === true ? adjustedThumb : thumb;
    }
}
exports.default = HeuristicPinchDetectionStrategy;
//# sourceMappingURL=HeuristicPinchDetectionStrategy.js.map