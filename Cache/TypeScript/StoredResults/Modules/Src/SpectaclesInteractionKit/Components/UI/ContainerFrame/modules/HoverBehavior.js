"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.HoverBehavior = void 0;
const Event_1 = require("../../../../Utils/Event");
const NativeLogger_1 = require("../../../../Utils/NativeLogger");
const StateMachine_1 = require("../../../../Utils/StateMachine");
const TAG = 'HoverBehavior';
var State;
(function (State) {
    State["Inactive"] = "Inactive";
    State["InactiveToActive"] = "InactiveToActive";
    State["Active"] = "Active";
    State["ActiveToInactive"] = "ActiveToInactive";
})(State || (State = {}));
var Signal;
(function (Signal) {
    Signal["RequestActive"] = "RequestActive";
    Signal["RequestInActive"] = "RequestInActive";
})(Signal || (Signal = {}));
const STATE_CHANGE_DEBOUNCE_TIME_S = 0.05; // 50ms
const DEBUG_MESSAGES = false;
/**
 * Behavior for handling nested interactable hover events
 */
class HoverBehavior {
    constructor(interactable, script, name = 'HoverBehavior') {
        this.interactable = interactable;
        this.script = script;
        this.name = name;
        this.hoverStart = new Event_1.default();
        this.onHoverStart = this.hoverStart.publicApi();
        this.hoverEnd = new Event_1.default();
        this.onHoverEnd = this.hoverEnd.publicApi();
        this.hoverUpdate = new Event_1.default();
        this.onHoverUpdate = this.hoverUpdate.publicApi();
        this.stateMachine = new StateMachine_1.default(this.name);
        this.isActive = false;
        this.requestActive = false;
        this.unsubscribeList = [];
        this.isDestroyed = false;
        this.log = new NativeLogger_1.default(TAG);
        this.onHoverEnter = (eventData) => {
            this.requestActive = true;
            this.eventData = eventData;
        };
        this.onHoverExit = (eventData) => {
            this.requestActive = false;
            this.eventData = eventData;
        };
        this.onHoverUpdated = (eventData) => {
            this.eventData = eventData;
        };
        this.onLateUpdate = (eventData) => {
            if (this.isActive !== this.requestActive) {
                if (DEBUG_MESSAGES) {
                    this.log.d(`container requested active state:${this.requestActive}`);
                }
                this.stateMachine.sendSignal(this.requestActive ? Signal.RequestActive : Signal.RequestInActive);
            }
            // Update actual state immediately
            this.isActive = this.requestActive;
        };
        this.onDestroy = (eventData) => {
            this.destroy();
        };
        this.setupStateMachine();
        this.lateUpdate = this.script.createEvent('LateUpdateEvent');
        this.onDestroyEvent = this.script.createEvent('OnDestroyEvent');
        this.lateUpdate.bind(this.onLateUpdate);
        this.onDestroyEvent.bind(this.onDestroy);
        this.bindHoverEvents();
        this.stateMachine.enterState(State.Inactive);
    }
    destroy() {
        this.log.d('has been destroyed!');
        this.isDestroyed = true;
        this.unBindHoverEvents();
        this.lateUpdate.enabled = false;
    }
    bindHoverEvents() {
        this.unsubscribeList.push(this.interactable.onHoverEnter(this.onHoverEnter));
        this.unsubscribeList.push(this.interactable.onHoverExit(this.onHoverExit));
        this.unsubscribeList.push(this.interactable.onHoverUpdate(this.onHoverUpdated));
    }
    unBindHoverEvents() {
        this.unsubscribeList.forEach((sub) => {
            sub();
        });
        this.unsubscribeList = [];
    }
    setupStateMachine() {
        // Inactive State
        this.stateMachine.addState({
            name: State.Inactive,
            onEnter: (state) => {
                this.hoverEnd.invoke(this.eventData);
            },
            transitions: [
                {
                    nextStateName: State.InactiveToActive,
                    checkOnSignal: (signal, data) => {
                        return signal === Signal.RequestActive;
                    },
                },
            ],
        });
        // Inactive Transition State
        this.stateMachine.addState({
            name: State.InactiveToActive,
            transitions: [
                {
                    nextStateName: State.Inactive,
                    checkOnSignal: (signal, data) => {
                        return signal === Signal.RequestInActive;
                    },
                },
                {
                    nextStateName: State.Active,
                    checkOnUpdate: (state) => {
                        return state.stateElapsedTime > STATE_CHANGE_DEBOUNCE_TIME_S;
                    },
                },
            ],
        });
        // Active State
        this.stateMachine.addState({
            name: State.Active,
            onEnter: (state) => {
                this.hoverStart.invoke(this.eventData);
            },
            onUpdate: (state) => {
                if (this.isDestroyed) {
                    this.log.d('Already destroyed!');
                    return;
                }
                try {
                    this.hoverUpdate.invoke(this.eventData);
                }
                catch (e) {
                    // If we arrive here, the script is dead and will be cleaned up eventually
                    // Any calls that cross the native boundry could throw an exception
                    this.log.e('Error invoking hoverUpdate!');
                }
            },
            transitions: [
                {
                    nextStateName: State.ActiveToInactive,
                    checkOnSignal: (signal, data) => {
                        return signal === Signal.RequestInActive;
                    },
                },
            ],
        });
        //  Active Transition State
        this.stateMachine.addState({
            name: State.ActiveToInactive,
            transitions: [
                {
                    nextStateName: State.Inactive,
                    checkOnUpdate: (state) => {
                        return state.stateElapsedTime > STATE_CHANGE_DEBOUNCE_TIME_S;
                    },
                },
                {
                    nextStateName: State.Active,
                    checkOnSignal: (signal, data) => {
                        return signal === Signal.RequestActive;
                    },
                },
            ],
        });
    }
}
exports.HoverBehavior = HoverBehavior;
//# sourceMappingURL=HoverBehavior.js.map