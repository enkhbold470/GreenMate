"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.InteractableColorFeedback = void 0;
var __selfType = requireType("./InteractableColorFeedback");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Interactable_1 = require("../Interaction/Interactable/Interactable");
let InteractableColorFeedback = class InteractableColorFeedback extends BaseScriptComponent {
    onAwake() {
        this.defineScriptEvents();
    }
    defineScriptEvents() {
        this.createEvent('OnStartEvent').bind(() => {
            this.init();
        });
    }
    init() {
        this.interactable = this
            .getSceneObject()
            .getComponent(Interactable_1.Interactable.getTypeName());
        if (this.interactable === null || this.interactable === undefined) {
            throw new Error('PointerColorVisual script requires an Interactable on the same SceneObject');
        }
        this.setupMaterials();
        this.setupInteractableCallbacks(this.interactable);
    }
    changeColor(color) {
        if (color === undefined) {
            print('Color not defined - cannot change color using PointerColorVisual');
            return;
        }
        this.meshVisuals.forEach(function (mesh) {
            if (mesh.mainMaterial.mainPass.baseColor !== undefined) {
                mesh.mainMaterial.mainPass.baseColor = color;
            }
        });
    }
    setupInteractableCallbacks(interactable) {
        interactable.onHoverEnter.add(() => {
            this.changeColor(this.hoverColor);
        });
        interactable.onHoverExit.add(() => {
            this.changeColor(this.defaultColor);
        });
        interactable.onTriggerStart.add(() => {
            this.changeColor(this.pinchedColor);
        });
        interactable.onTriggerEnd.add(() => {
            this.changeColor(this.hoverColor);
        });
        interactable.onTriggerCanceled.add(() => {
            this.changeColor(this.defaultColor);
        });
        interactable.createEvent('OnEnableEvent').bind(() => {
            this.changeColor(this.defaultColor);
        });
        interactable.createEvent('OnDisableEvent').bind(() => {
            this.changeColor(this.disabledColor);
        });
    }
    setupMaterials() {
        this.meshVisuals.forEach(function (mesh) {
            mesh.mainMaterial = mesh.mainMaterial.clone();
        });
        this.changeColor(this.defaultColor);
    }
};
exports.InteractableColorFeedback = InteractableColorFeedback;
exports.InteractableColorFeedback = InteractableColorFeedback = __decorate([
    component
], InteractableColorFeedback);
//# sourceMappingURL=InteractableColorFeedback.js.map