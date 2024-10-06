"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Event_1 = require("../../../../../Utils/Event");
const NativeLogger_1 = require("../../../../../Utils/NativeLogger");
const GestureModuleProvider_1 = require("../../../GestureProvider/GestureModuleProvider");
const PinchEventType_1 = require("../../PinchEventType");
const TAG = 'HciPinchDetection';
/**
 * Class to detect pinch by calling into HCI Gesture APIs at lenscore level
 */
class HciPinchDetectionStrategy {
    constructor(config) {
        this.config = config;
        // Native Logging
        this.log = new NativeLogger_1.default(TAG);
        this.gestureModuleProvider = GestureModuleProvider_1.default.getInstance();
        this.gestureModule = undefined;
        this._onPinchDetectedEvent = new Event_1.default();
        this._onPinchDetected = this._onPinchDetectedEvent.publicApi();
        this._onPinchProximityEvent = new Event_1.default();
        this._onPinchProximity = this._onPinchProximityEvent.publicApi();
        this.setupPinchApi();
    }
    /** @inheritdoc */
    get onPinchDetected() {
        return this._onPinchDetected;
    }
    /** @inheritdoc */
    get onPinchProximity() {
        return this._onPinchProximity;
    }
    get gestureHandType() {
        return this.config.handType === 'right'
            ? GestureModule.HandType.Right
            : GestureModule.HandType.Left;
    }
    setupPinchApi() {
        this.gestureModule = this.gestureModuleProvider.getGestureModule();
        if (this.gestureModule !== undefined) {
            this.gestureModule.getPinchDownEvent(this.gestureHandType).add(() => {
                this._onPinchDetectedEvent.invoke(PinchEventType_1.PinchEventType.Down);
            });
            this.gestureModule.getPinchUpEvent(this.gestureHandType).add(() => {
                this._onPinchDetectedEvent.invoke(PinchEventType_1.PinchEventType.Up);
            });
            if (this.gestureModule.getPinchStrengthEvent !== undefined) {
                this.gestureModule
                    .getPinchStrengthEvent(this.gestureHandType)
                    .add((args) => {
                    const proximity = args.strength;
                    this._onPinchProximityEvent.invoke(proximity);
                    this.log.v('PinchEvent : ' +
                        'Pinch Strength Event' +
                        ' : proximity : ' +
                        proximity);
                });
            }
        }
    }
}
exports.default = HciPinchDetectionStrategy;
//# sourceMappingURL=HciPinchDetectionStrategy.js.map