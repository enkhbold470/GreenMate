"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PalmTapDetectorState = void 0;
const SIK_1 = require("../../../../SIK");
const Event_1 = require("../../../../Utils/Event");
const StateMachine_1 = require("../../../../Utils/StateMachine");
const PalmTapEvent_1 = require("../PalmTapEvent");
const TAG = 'PalmTapDetectorStateMachine';
var PalmTapDetectorState;
(function (PalmTapDetectorState) {
    PalmTapDetectorState["Idle"] = "Idle";
    PalmTapDetectorState["Tap"] = "Tap";
})(PalmTapDetectorState || (exports.PalmTapDetectorState = PalmTapDetectorState = {}));
/**
 * Tracks states and transitions of palm tapping
 */
class PalmTapDetectorStateMachine {
    constructor() {
        this.interactionConfigurationProvider = SIK_1.SIK.InteractionConfiguration;
        this.stateMachine = new StateMachine_1.default('PalmTapDetectorStateMachine');
        this.onPalmTapDownEvent = new Event_1.default();
        this.onPalmTapDown = this.onPalmTapDownEvent.publicApi();
        this.onPalmTapUpEvent = new Event_1.default();
        this.onPalmTapUp = this.onPalmTapUpEvent.publicApi();
        this.setupStateMachine();
    }
    /**
   * @returns whether the user is tapping
   */
    isTapping() {
        var _a;
        return ((_a = this.stateMachine.currentState) === null || _a === void 0 ? void 0 : _a.name) === PalmTapDetectorState.Tap;
    }
    /**
   * Notifies that a palm tap event has been detected
   * @param palmTapEventType The type of event that was detected
   */
    notifyPalmTapEvent(palmTapEventType) {
        this.stateMachine.sendSignal(palmTapEventType);
    }
    setupStateMachine() {
        this.stateMachine.addState({
            name: PalmTapDetectorState.Idle,
            onEnter: () => { },
            transitions: [
                {
                    nextStateName: PalmTapDetectorState.Tap,
                    checkOnSignal: (signal) => {
                        return signal === PalmTapEvent_1.PalmTapEventType.Down;
                    },
                },
            ],
        });
        this.stateMachine.addState({
            name: PalmTapDetectorState.Tap,
            onEnter: () => {
                this.onPalmTapDownEvent.invoke();
            },
            onExit: () => {
                this.onPalmTapUpEvent.invoke();
            },
            transitions: [
                {
                    nextStateName: PalmTapDetectorState.Idle,
                    checkOnSignal: (signal) => {
                        return signal === PalmTapEvent_1.PalmTapEventType.Up;
                    },
                },
            ],
        });
        this.stateMachine.enterState(PalmTapDetectorState.Idle);
    }
}
exports.default = PalmTapDetectorStateMachine;
//# sourceMappingURL=PalmTapDetectorStateMachine.js.map