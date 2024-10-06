"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.InteractableSquishFeedback = void 0;
var __selfType = requireType("./InteractableSquishFeedback");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Interactable_1 = require("../Interaction/Interactable/Interactable");
let InteractableSquishFeedback = class InteractableSquishFeedback extends BaseScriptComponent {
    onAwake() {
        this.defineScriptEvents();
    }
    defineScriptEvents() {
        this.createEvent('OnStartEvent').bind(() => {
            this.init();
            this.createEvent('OnEnableEvent').bind(() => {
                this.squishEnabled = true;
            });
            this.createEvent('OnDisableEvent').bind(() => {
                this.squishEnabled = false;
            });
        });
    }
    init() {
        this.initialScale = this.squishObject.getTransform().getLocalScale();
        this.squishScale = new vec3(this.initialScale.x * this.horizontalSquish, this.initialScale.y * this.verticalSquish, this.initialScale.z);
        this.interactable = this.getSceneObject().getComponent(Interactable_1.Interactable.getTypeName());
        if (!this.interactable) {
            throw new Error('PointerSquishVisual script requires an Interactable');
        }
        this.setupInteractableCallbacks();
    }
    resetScale() {
        this.squishObject.getTransform().setLocalScale(this.initialScale);
        this.initialPinch = null;
    }
    updateSquish(event) {
        const currentPinch = event.interactor.interactionStrength;
        if (currentPinch !== null &&
            this.initialPinch !== null &&
            this.squishEnabled) {
            const pinchScale = MathUtils.remap(Math.max(this.initialPinch, currentPinch), Math.min(this.initialPinch, 0.95), 1, 0, 1);
            this.squishObject
                .getTransform()
                .setLocalScale(vec3.lerp(this.initialScale, this.squishScale, pinchScale));
        }
    }
    setupInteractableCallbacks() {
        this.interactable.onHoverEnter.add((event) => {
            this.initialPinch = event.interactor.interactionStrength;
        });
        this.interactable.onHoverUpdate.add(this.updateSquish.bind(this));
        this.interactable.onHoverExit.add(this.resetScale.bind(this));
        this.interactable.onTriggerCanceled.add(this.resetScale.bind(this));
    }
    __initialize() {
        super.__initialize();
        this.initialPinch = null;
        this.squishEnabled = true;
    }
};
exports.InteractableSquishFeedback = InteractableSquishFeedback;
exports.InteractableSquishFeedback = InteractableSquishFeedback = __decorate([
    component
], InteractableSquishFeedback);
//# sourceMappingURL=InteractableSquishFeedback.js.map