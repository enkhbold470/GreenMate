"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.InteractableAudioFeedback = void 0;
var __selfType = requireType("./InteractableAudioFeedback");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Interactable_1 = require("../Interaction/Interactable/Interactable");
let InteractableAudioFeedback = class InteractableAudioFeedback extends BaseScriptComponent {
    onAwake() {
        this.defineScriptEvents();
    }
    defineScriptEvents() {
        this.createEvent('OnStartEvent').bind(() => {
            this.init();
        });
    }
    /**
     * Returns the AudioComponent used for hover feedback for further configuration (such as volume).
     */
    get hoverAudioComponent() {
        return this._hoverAudioComponent;
    }
    /**
     * Returns the AudioComponent used for trigger start feedback for further configuration (such as volume).
     */
    get triggerStartAudioComponent() {
        return this._triggerStartAudioComponent;
    }
    /**
     * Returns the AudioComponent used for trigger end feedback for further configuration (such as volume).
     */
    get triggerEndAudioComponent() {
        return this._triggerEndAudioComponent;
    }
    setupInteractableCallbacks() {
        this.interactable.onHoverEnter.add(() => {
            try {
                if (this._hoverAudioComponent) {
                    this._hoverAudioComponent.play(1);
                }
            }
            catch (e) {
                print('Error playing hover audio: ' + e);
            }
        });
        this.interactable.onTriggerStart.add(() => {
            try {
                if (this._triggerStartAudioComponent) {
                    this._triggerStartAudioComponent.play(1);
                }
            }
            catch (e) {
                print('Error playing trigger start audio: ' + e);
            }
        });
        this.interactable.onTriggerEnd.add(() => {
            try {
                if (this._triggerEndAudioComponent) {
                    this._triggerEndAudioComponent.play(1);
                }
            }
            catch (e) {
                print('Error playing trigger end audio: ' + e);
            }
        });
    }
    init() {
        if (this.hoverAudioTrack) {
            this._hoverAudioComponent = this.getSceneObject().createComponent('Component.AudioComponent');
            this._hoverAudioComponent.playbackMode = Audio.PlaybackMode.LowLatency;
            this._hoverAudioComponent.audioTrack = this.hoverAudioTrack;
        }
        if (this.triggerStartAudioTrack) {
            this._triggerStartAudioComponent = this.getSceneObject().createComponent('Component.AudioComponent');
            this._triggerStartAudioComponent.playbackMode =
                Audio.PlaybackMode.LowLatency;
            this._triggerStartAudioComponent.audioTrack = this.triggerStartAudioTrack;
        }
        if (this.triggerEndAudioTrack) {
            this._triggerEndAudioComponent = this.getSceneObject().createComponent('Component.AudioComponent');
            this._triggerEndAudioComponent.playbackMode =
                Audio.PlaybackMode.LowLatency;
            this._triggerEndAudioComponent.audioTrack = this.triggerEndAudioTrack;
        }
        this.interactable = this.getSceneObject().getComponent(Interactable_1.Interactable.getTypeName());
        if (!this.interactable) {
            throw new Error('Could not find Interactable component on this SceneObject.');
        }
        this.setupInteractableCallbacks();
    }
};
exports.InteractableAudioFeedback = InteractableAudioFeedback;
exports.InteractableAudioFeedback = InteractableAudioFeedback = __decorate([
    component
], InteractableAudioFeedback);
//# sourceMappingURL=InteractableAudioFeedback.js.map