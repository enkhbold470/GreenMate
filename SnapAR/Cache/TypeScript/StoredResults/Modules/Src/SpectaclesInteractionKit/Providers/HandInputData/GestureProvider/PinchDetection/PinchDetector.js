"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PinchDetector = exports.PinchDetectionSelection = void 0;
const HciPinchDetectionStrategy_1 = require("./DetectionStrategies/HciPinchDetectionStrategy");
const HeuristicPinchDetectionStrategy_1 = require("./DetectionStrategies/HeuristicPinchDetectionStrategy");
const PinchDetectorStateMachine_1 = require("./PinchDetectorStateMachine");
const TAG = 'PinchDetector';
var PinchDetectionSelection;
(function (PinchDetectionSelection) {
    PinchDetectionSelection["Heuristic"] = "Heuristic";
    PinchDetectionSelection["LensCoreML"] = "LensCore ML";
    PinchDetectionSelection["Mock"] = "Mock";
})(PinchDetectionSelection || (exports.PinchDetectionSelection = PinchDetectionSelection = {}));
/**
 * Wraps PinchDetectionStrategy inside PinchDetectorStateMachine for pinch events
 */
class PinchDetector {
    constructor(config) {
        var _a, _b;
        this.config = config;
        this.pinchDetectorStateMachine = new PinchDetectorStateMachine_1.default();
        this.pinchStrength = 0;
        (_a = config.pinchDownThreshold) !== null && _a !== void 0 ? _a : (config.pinchDownThreshold = 1.75);
        (_b = config.pinchDetectionSelection) !== null && _b !== void 0 ? _b : (config.pinchDetectionSelection = PinchDetectionSelection.LensCoreML);
        this.pinchDetectionStrategy = this.createPinchDetectionStrategy();
        this.setupPinchEventCallback();
    }
    /**
   * Event called when the user has successfully pinched down.
   */
    get onPinchDown() {
        return this.pinchDetectorStateMachine.onPinchDown;
    }
    /**
   * Event called when the user has released pinching after they
   * have successfully pinched down.
   */
    get onPinchUp() {
        return this.pinchDetectorStateMachine.onPinchUp;
    }
    /**
   * Event called when the user's pinch is canceled by the system.
   */
    get onPinchCancel() {
        return this.pinchDetectorStateMachine.onPinchCancel;
    }
    /**
   * Determines if the user is pinching
   */
    isPinching() {
        return this.pinchDetectorStateMachine.isPinching();
    }
    /**
   * Returns a normalized value from 0-1, where:
   * 0 is the distance from a finger tip to the thumb tip in
   * resting/neutral hand pose.
   * 1 is when a finger tip to thumb tip are touching/pinching
   */
    getPinchStrength() {
        if (this.config.isTracked()) {
            return this.pinchStrength;
        }
        return 0;
    }
    createPinchDetectionStrategy() {
        const pinchDetection = this.config.pinchDetectionSelection;
        if (pinchDetection === undefined) {
            throw new Error('A PinchDetectionStrategy needs to be specified.');
        }
        switch (pinchDetection) {
            case PinchDetectionSelection.Heuristic: {
                return new HeuristicPinchDetectionStrategy_1.default({
                    ...this.config,
                    pinchDownThreshold: this.config.pinchDownThreshold,
                });
            }
            case PinchDetectionSelection.LensCoreML: {
                return new HciPinchDetectionStrategy_1.default(this.config);
            }
            default: {
                throw new Error(`${TAG}: No matching PinchDetectionSelection found, could not create strategy`);
            }
        }
    }
    setupPinchEventCallback() {
        this.pinchDetectionStrategy.onPinchDetected.add((pinchEvent) => {
            this.pinchDetectorStateMachine.notifyPinchEvent(pinchEvent);
        });
        this.pinchDetectionStrategy.onPinchProximity.add((proximity) => {
            this.pinchStrength = proximity;
        });
    }
}
exports.PinchDetector = PinchDetector;
//# sourceMappingURL=PinchDetector.js.map