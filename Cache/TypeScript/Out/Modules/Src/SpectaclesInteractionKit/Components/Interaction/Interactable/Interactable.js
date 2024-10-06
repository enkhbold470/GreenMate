"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Interactable = void 0;
var __selfType = requireType("./Interactable");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const InteractionManager_1 = require("../../../Core/InteractionManager/InteractionManager");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const SIK_1 = require("../../../SIK");
const Event_1 = require("../../../Utils/Event");
const TAG = 'Interactable';
let Interactable = class Interactable extends BaseScriptComponent {
    onAwake() {
        this.transform = this.getTransform();
        this.createEvent('OnDestroyEvent').bind(() => this.release());
        this.createEvent('OnEnableEvent').bind(() => {
            this.enableColliders(true);
        });
        this.createEvent('OnDisableEvent').bind(() => {
            this.enableColliders(false);
        });
        InteractionManager_1.InteractionManager.getInstance().registerInteractable(this);
    }
    release() {
        InteractionManager_1.InteractionManager.getInstance().deregisterInteractable(this);
    }
    /**
     * Interactors that are hovering this interactable
     */
    get hoveringInteractor() {
        return this._hoveringInteractor;
    }
    /**
     * Interactors that are triggering this interactable
     */
    get triggeringInteractor() {
        return this._triggeringInteractor;
    }
    dragStartOrUpdate(eventArgs) {
        const currentDragVector = eventArgs.interactor.currentDragVector;
        if (currentDragVector === null) {
            return;
        }
        const previousDragVector = eventArgs.interactor.previousDragVector;
        const dragInteractorEvent = {
            ...eventArgs,
            interactable: this,
            dragVector: currentDragVector,
            planecastDragVector: eventArgs.interactor.planecastDragVector,
        };
        if (previousDragVector === null) {
            this.onDragStartEvent.invoke(dragInteractorEvent);
            this.log.v('InteractionEvent : ' + 'On Drag Start Event');
        }
        else {
            this.onDragUpdateEvent.invoke(dragInteractorEvent);
        }
    }
    dragEnd(eventArgs) {
        const previousDragVector = eventArgs.interactor.previousDragVector;
        if (previousDragVector === null) {
            return;
        }
        this.onDragEndEvent.invoke({
            ...eventArgs,
            interactable: this,
            dragVector: previousDragVector,
            planecastDragVector: eventArgs.interactor.planecastDragVector,
        });
        this.log.v('InteractionEvent : ' + 'On Drag End Event');
    }
    enableColliders(enable) {
        for (let i = 0; i < this.colliders.length; i++) {
            this.colliders[i].enabled = enable;
        }
    }
    __initialize() {
        super.__initialize();
        this.onHoverEnterEvent = new Event_1.default();
        this.onHoverUpdateEvent = new Event_1.default();
        this.onHoverExitEvent = new Event_1.default();
        this.onInteractorHoverEnterEvent = new Event_1.default();
        this.onInteractorHoverExitEvent = new Event_1.default();
        this.onTriggerStartEvent = new Event_1.default();
        this.onTriggerUpdateEvent = new Event_1.default();
        this.onTriggerEndEvent = new Event_1.default();
        this.onInteractorTriggerStartEvent = new Event_1.default();
        this.onInteractorTriggerEndEvent = new Event_1.default();
        this.onDragStartEvent = new Event_1.default();
        this.onDragUpdateEvent = new Event_1.default();
        this.onDragEndEvent = new Event_1.default();
        this.onTriggerCanceledEvent = new Event_1.default();
        this.interactionConfigurationProvider = SIK_1.SIK.InteractionConfiguration;
        this.log = new NativeLogger_1.default(TAG);
        this.
        /**
       * Called whenever the interactable enters the hovered state
       */
        onHoverEnter = this.onHoverEnterEvent.publicApi();
        this.
        /**
       * Called whenever a new interactor hovers over this interactable
       */
        onInteractorHoverEnter = this.onInteractorHoverEnterEvent.publicApi();
        this.
        /**
       * Called whenever an interactor remains hovering over this interactable
       */
        onHoverUpdate = this.onHoverUpdateEvent.publicApi();
        this.
        /**
       *  Called whenever the interactable is no longer hovered
       */
        onHoverExit = this.onHoverExitEvent.publicApi();
        this.
        /**
       * Called whenever an interactor exits hovering this interactable
       */
        onInteractorHoverExit = this.onInteractorHoverExitEvent.publicApi();
        this.
        /**
       * Called whenever the interactable enters the triggered state
       */
        onTriggerStart = this.onTriggerStartEvent.publicApi();
        this.
        /**
       * Called whenever an interactor triggers an interactable
       */
        onInteractorTriggerStart = this.onInteractorTriggerStartEvent.publicApi();
        this.
        /**
       * Called whenever an interactor continues to trigger an interactable
       */
        onTriggerUpdate = this.onTriggerUpdateEvent.publicApi();
        this.
        /**
       * Called whenever the interactable exits the triggered state
       */
        onTriggerEnd = this.onTriggerEndEvent.publicApi();
        this.
        /**
       * Called whenever an interactor is no longer triggering the interactable
       */
        onInteractorTriggerEnd = this.onInteractorTriggerEndEvent.publicApi();
        this.
        /**
       * Called whenever an interactor is lost and was in a down event with this interactable
       */
        onTriggerCanceled = this.onTriggerCanceledEvent.publicApi();
        this.
        /**
       * Called when an interactor is in a down event with this interactable and
       * has moved a minimum drag distance
       */
        onDragStart = this.onDragStartEvent.publicApi();
        this.
        /**
       * Called when an interactor is in a down event with this interactable and
       * is moving
       */
        onDragUpdate = this.onDragUpdateEvent.publicApi();
        this.
        /**
       * Called when an interactor was in a down event with this interactable and
       * was dragging
       */
        onDragEnd = this.onDragEndEvent.publicApi();
        this._hoveringInteractor = Interactor_1.InteractorInputType.None;
        this._triggeringInteractor = Interactor_1.InteractorInputType.None;
        this.
        /**
       * Provides all colliders associated with this Interactable
       */
        colliders = [];
        this.
        /**
         * Notifies the interactable that it is entering hover state
         * @param eventArgs - the interactor that is driving the event {@link Interactor}
         */
        hoverEnter = (eventArgs) => {
            if (this._hoveringInteractor === Interactor_1.InteractorInputType.None) {
                this.onHoverEnterEvent.invoke({
                    ...eventArgs,
                    interactable: this,
                });
                this.log.v('InteractionEvent : ' + 'On Hover Enter Event');
            }
            this._hoveringInteractor |= eventArgs.interactor.inputType;
            this.onInteractorHoverEnterEvent.invoke({
                ...eventArgs,
                interactable: this,
            });
            this.log.v('InteractionEvent : ' + 'On Interactor Hover Enter Event');
        };
        this.
        /**
         * Notifies the interactable that it is still hovering
         * @param eventArgs - event parameters, with omitted interactable
         */
        hoverUpdate = (eventArgs) => {
            this.onHoverUpdateEvent.invoke({
                ...eventArgs,
                interactable: this,
            });
        };
        this.
        /**
         * Notifies the interactable that it is exiting hover state
         * @param eventArgs - event parameters, with omitted interactable
         */
        hoverExit = (eventArgs) => {
            this._hoveringInteractor &= ~eventArgs.interactor.inputType;
            this.onInteractorHoverExitEvent.invoke({
                ...eventArgs,
                interactable: this,
            });
            this.log.v('InteractionEvent : ' + 'On Interactor Hover Exit Event');
            if (this._hoveringInteractor === Interactor_1.InteractorInputType.None) {
                this.onHoverExitEvent.invoke({
                    ...eventArgs,
                    interactable: this,
                });
                this.log.v('InteractionEvent : ' + 'On Hover Exit Event');
            }
        };
        this.
        /**
         * Notifies the interactable that it is entering trigger state
         * @param eventArgs - event parameters, with omitted interactable
         */
        triggerStart = (eventArgs) => {
            if (this._triggeringInteractor === Interactor_1.InteractorInputType.None) {
                this.onTriggerStartEvent.invoke({
                    ...eventArgs,
                    interactable: this,
                });
                this.log.v('InteractionEvent : ' + 'On Trigger Start Event');
            }
            this._triggeringInteractor |= eventArgs.interactor.inputType;
            this.onInteractorTriggerStartEvent.invoke({
                ...eventArgs,
                interactable: this,
            });
            this.log.v('InteractionEvent : ' + 'On Interactor Trigger Start Event');
        };
        this.
        /**
         * Notifies the interactable that it is still in a triggering state
         * @param eventArgs - event parameters, with omitted interactable
         */
        triggerUpdate = (eventArgs) => {
            this.onTriggerUpdateEvent.invoke({
                ...eventArgs,
                interactable: this,
            });
            this.dragStartOrUpdate(eventArgs);
        };
        this.
        /**
         * Notifies the interactable that it is exiting trigger state
         * @param eventArgs - event parameters, with omitted interactable
         */
        triggerEnd = (eventArgs) => {
            this._triggeringInteractor &= ~eventArgs.interactor.inputType;
            this.onInteractorTriggerEndEvent.invoke({
                ...eventArgs,
                interactable: this,
            });
            this.log.v('InteractionEvent : ' + 'On Interactor Trigger End Event');
            if (this._triggeringInteractor === Interactor_1.InteractorInputType.None) {
                this.onTriggerEndEvent.invoke({
                    ...eventArgs,
                    interactable: this,
                });
                this.log.v('InteractionEvent : ' + 'On Trigger End Event');
            }
            this.dragEnd(eventArgs);
        };
        this.
        /**
         * Notifies the interactable that it is a cancelled state with the interactor
         * @param eventArgs - event parameters, with omitted interactable
         */
        triggerCanceled = (eventArgs) => {
            this._triggeringInteractor === Interactor_1.InteractorInputType.None;
            this.onTriggerCanceledEvent.invoke({
                ...eventArgs,
                interactable: this,
            });
            this.log.v('InteractionEvent : ' + 'On Trigger Canceled Event');
            this.dragEnd(eventArgs);
        };
    }
};
exports.Interactable = Interactable;
exports.Interactable = Interactable = __decorate([
    component
], Interactable);
//# sourceMappingURL=Interactable.js.map