"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GlowEffectViewModel = exports.StateMachineSignals = exports.GlowEffectStates = void 0;
const Event_1 = require("../../../Utils/Event");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const StateMachine_1 = require("../../../Utils/StateMachine");
const TAG = 'GlowEffectViewModel';
var GlowEffectStates;
(function (GlowEffectStates) {
    GlowEffectStates["IdleTargeting"] = "IdleTargeting";
    GlowEffectStates["IdleNotTargeting"] = "IdleNotTargeting";
    GlowEffectStates["NearPinching"] = "NearPinching";
    GlowEffectStates["Pinching"] = "Pinching";
    GlowEffectStates["PinchingNotTargeting"] = "PinchingNotTargeting";
    GlowEffectStates["NearTapping"] = "NearTapping";
    GlowEffectStates["Tapping"] = "Tapping";
})(GlowEffectStates || (exports.GlowEffectStates = GlowEffectStates = {}));
var StateMachineSignals;
(function (StateMachineSignals) {
    StateMachineSignals["EnterTargeting"] = "EnterTargeting";
    StateMachineSignals["ExitTargeting"] = "ExitTargeting";
    StateMachineSignals["EnterNearPinch"] = "EnterNearPinch";
    StateMachineSignals["ExitNearPinch"] = "ExitNearPinch";
    StateMachineSignals["EnterPinch"] = "EnterPinch";
    StateMachineSignals["ExitPinch"] = "ExitPinch";
    StateMachineSignals["EnterPalmUIMode"] = "EnterPalmUIMode";
    StateMachineSignals["ExitPalmUIMode"] = "ExitPalmUIMode";
    StateMachineSignals["EnterTap"] = "EnterTap";
    StateMachineSignals["ExitTap"] = "ExitTap";
})(StateMachineSignals || (exports.StateMachineSignals = StateMachineSignals = {}));
/*
 * GlowEffectViewModel manages the state of the glow effect for pinch and tap on hand visuals
 */
class GlowEffectViewModel {
    constructor(config) {
        this.config = config;
        // Get LogLevel from config, this avoids having a SIK dependency in the ViewModel
        this.log = new NativeLogger_1.default(TAG);
        // Events used to communicate with the GlowEffectView
        this.animateIndexGlowBaseEvent = new Event_1.default();
        this.animateIndexGlowBase = this.animateIndexGlowBaseEvent.publicApi();
        this.animateIndexGlowBonusEvent = new Event_1.default();
        this.animateIndexGlowBonus = this.animateIndexGlowBonusEvent.publicApi();
        this.animateThumbGlowBaseEvent = new Event_1.default();
        this.animateThumbGlowBase = this.animateThumbGlowBaseEvent.publicApi();
        this.animateThumbGlowBonusEvent = new Event_1.default();
        this.animateThumbGlowBonus = this.animateThumbGlowBonusEvent.publicApi();
        this.tapModeChangedEvent = new Event_1.default();
        this.tapModeChanged = this.tapModeChangedEvent.publicApi();
        this.stateMachine = this.createStateMachine();
    }
    /**
   * Call to notify that we have entered or exited targeting mode
   *
   * @param enteredTargeting Whether we have entered targeting mode (hand not facing the camera)
   */
    targetingEvent(enteredTargeting) {
        enteredTargeting
            ? this.stateMachine.sendSignal(StateMachineSignals.EnterTargeting)
            : this.stateMachine.sendSignal(StateMachineSignals.ExitTargeting);
    }
    /**
   * Call to notify that we have entered or exited near pinch mode
   *
   * @param enteredNearPinch Whether we have entered near pinch mode
   */
    nearPinchEvent(enteredNearPinch) {
        enteredNearPinch
            ? this.stateMachine.sendSignal(StateMachineSignals.EnterNearPinch)
            : this.stateMachine.sendSignal(StateMachineSignals.ExitNearPinch);
    }
    /**
   * Call to notify that we have entered or exited pinch mode
   *
   * @param enteredPinch Whether we have entered pinch mode
   */
    pinchEvent(enteredPinch) {
        enteredPinch
            ? this.stateMachine.sendSignal(StateMachineSignals.EnterPinch)
            : this.stateMachine.sendSignal(StateMachineSignals.ExitPinch);
    }
    /**
   * Call to notify that we have entered or exited palm UI mode
   *
   * @param enteredPalmUIMode Whether we have entered palm UI mode
   */
    palmUIModeEvent(enteredPalmUIMode) {
        enteredPalmUIMode
            ? this.stateMachine.sendSignal(StateMachineSignals.EnterPalmUIMode)
            : this.stateMachine.sendSignal(StateMachineSignals.ExitPalmUIMode);
    }
    /**
   * Call to notify that we have entered or exited tap mode
   *
   * @param enteredTap Whether we have entered tap mode
   */
    tapEvent(enteredTap) {
        enteredTap
            ? this.stateMachine.sendSignal(StateMachineSignals.EnterTap)
            : this.stateMachine.sendSignal(StateMachineSignals.ExitTap);
    }
    /**
   * Get the current state of the state machine used to manage the glow effects
   *
   * @returns GlowEffectStates the state that the state machine is currently in
   */
    get currentState() {
        if (this.stateMachine.currentState === null) {
            throw new Error('GlowEffectStateMachine does not have a current state!');
        }
        return this.stateMachine.currentState.name;
    }
    createStateMachine() {
        const stateMachine = new StateMachine_1.default('GlowEffectStateMachine');
        stateMachine.addState({
            name: GlowEffectStates.IdleTargeting,
            onEnter: () => {
                this.log.v(`${this.config.handType} Entered state: ${this.currentState}`);
                this.animateIndexGlowBaseEvent.invoke(false);
                this.animateIndexGlowBonusEvent.invoke(false);
                this.animateThumbGlowBaseEvent.invoke(false);
                this.animateThumbGlowBonusEvent.invoke(false);
            },
            transitions: [
                {
                    nextStateName: GlowEffectStates.IdleNotTargeting,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitTargeting;
                    },
                },
                {
                    nextStateName: GlowEffectStates.NearPinching,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.EnterNearPinch;
                    },
                },
                {
                    nextStateName: GlowEffectStates.NearTapping,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.EnterPalmUIMode;
                    },
                },
            ],
        });
        stateMachine.addState({
            name: GlowEffectStates.IdleNotTargeting,
            onEnter: () => {
                this.log.v(`${this.config.handType} Entered state: ${this.currentState}`);
                this.animateIndexGlowBaseEvent.invoke(false);
                this.animateIndexGlowBonusEvent.invoke(false);
                this.animateThumbGlowBaseEvent.invoke(false);
                this.animateThumbGlowBonusEvent.invoke(false);
            },
            transitions: [
                {
                    nextStateName: GlowEffectStates.IdleTargeting,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.EnterTargeting;
                    },
                },
            ],
        });
        stateMachine.addState({
            name: GlowEffectStates.NearPinching,
            onEnter: () => {
                this.log.v(`${this.config.handType} Entered state: ${this.currentState}`);
                this.animateIndexGlowBaseEvent.invoke(true);
                this.animateIndexGlowBonusEvent.invoke(false);
                this.animateThumbGlowBaseEvent.invoke(true);
                this.animateThumbGlowBonusEvent.invoke(false);
            },
            transitions: [
                {
                    nextStateName: GlowEffectStates.IdleTargeting,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitNearPinch;
                    },
                },
                {
                    nextStateName: GlowEffectStates.IdleNotTargeting,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitTargeting;
                    },
                },
                {
                    nextStateName: GlowEffectStates.NearTapping,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.EnterPalmUIMode;
                    },
                },
                {
                    nextStateName: GlowEffectStates.Pinching,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.EnterPinch;
                    },
                },
            ],
        });
        stateMachine.addState({
            name: GlowEffectStates.Pinching,
            onEnter: () => {
                this.log.v(`${this.config.handType} Entered state: ${this.currentState}`);
                this.animateIndexGlowBaseEvent.invoke(true);
                this.animateIndexGlowBonusEvent.invoke(true);
                this.animateThumbGlowBaseEvent.invoke(true);
                this.animateThumbGlowBonusEvent.invoke(true);
            },
            transitions: [
                {
                    nextStateName: GlowEffectStates.PinchingNotTargeting,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitTargeting;
                    },
                },
                {
                    nextStateName: GlowEffectStates.NearPinching,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitPinch;
                    },
                },
            ],
        });
        stateMachine.addState({
            name: GlowEffectStates.PinchingNotTargeting,
            onEnter: () => {
                this.log.v(`${this.config.handType} Entered state: ${this.currentState}`);
                this.animateIndexGlowBaseEvent.invoke(true);
                this.animateIndexGlowBonusEvent.invoke(true);
                this.animateThumbGlowBaseEvent.invoke(true);
                this.animateThumbGlowBonusEvent.invoke(true);
            },
            transitions: [
                {
                    nextStateName: GlowEffectStates.IdleNotTargeting,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitPinch;
                    },
                },
                {
                    nextStateName: GlowEffectStates.Pinching,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.EnterTargeting;
                    },
                },
            ],
        });
        stateMachine.addState({
            name: GlowEffectStates.NearTapping,
            onEnter: () => {
                this.log.v(`${this.config.handType} Entered state: ${this.currentState}`);
                this.tapModeChangedEvent.invoke(true);
                this.animateIndexGlowBaseEvent.invoke(true);
                this.animateIndexGlowBonusEvent.invoke(false);
                this.animateThumbGlowBaseEvent.invoke(false);
                this.animateThumbGlowBonusEvent.invoke(false);
            },
            transitions: [
                {
                    nextStateName: GlowEffectStates.IdleTargeting,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitPalmUIMode;
                    },
                    onExecution: () => {
                        this.tapModeChangedEvent.invoke(false);
                    },
                },
                {
                    nextStateName: GlowEffectStates.Tapping,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.EnterTap;
                    },
                },
            ],
        });
        stateMachine.addState({
            name: GlowEffectStates.Tapping,
            onEnter: () => {
                this.log.v(`${this.config.handType} Entered state: ${this.currentState}`);
                this.animateIndexGlowBaseEvent.invoke(true);
                this.animateIndexGlowBonusEvent.invoke(true);
                this.animateThumbGlowBaseEvent.invoke(false);
                this.animateThumbGlowBonusEvent.invoke(false);
            },
            transitions: [
                {
                    nextStateName: GlowEffectStates.NearTapping,
                    checkOnSignal: (signal) => {
                        return signal === StateMachineSignals.ExitTap;
                    },
                },
            ],
        });
        stateMachine.enterState(GlowEffectStates.IdleTargeting, true);
        return stateMachine;
    }
}
exports.GlowEffectViewModel = GlowEffectViewModel;
//# sourceMappingURL=GlowEffectViewModel.js.map