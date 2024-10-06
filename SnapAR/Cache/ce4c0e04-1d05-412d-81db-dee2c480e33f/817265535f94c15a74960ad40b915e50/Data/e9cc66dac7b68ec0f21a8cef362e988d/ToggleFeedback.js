"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ToggleFeedback = void 0;
var __selfType = requireType("./ToggleFeedback");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Interactable_1 = require("../Interaction/Interactable/Interactable");
const ToggleButton_1 = require("../UI/ToggleButton/ToggleButton");
/*
 * PinchButton provides basic pinch button functionality for the prefab pinch button.
 * It is meant to be added to a Scene Object with an Interactable component, with visual behavior configured in the Lens Studio scene.
 */
let ToggleFeedback = class ToggleFeedback extends BaseScriptComponent {
    onAwake() {
        this.materials = [
            this.toggledOffMaterial,
            this.toggledOffSelectMaterial,
            this.toggledOnMaterial,
            this.toggledOnSelectMaterial,
            this.disabledMaterial,
        ];
        this.defineScriptEvents();
    }
    defineScriptEvents() {
        this.createEvent('OnStartEvent').bind(() => {
            this.init();
        });
    }
    init() {
        this.toggleButton = this.getSceneObject().getComponent(ToggleButton_1.ToggleButton.getTypeName());
        this.interactable = this.getSceneObject().getComponent(Interactable_1.Interactable.getTypeName());
        if (this.interactable === null || this.interactable === undefined) {
            throw new Error('UIToggleButtonCustomize script requires an Interactable on the ToggleButton');
        }
        this.setupInteractableCallbacks(this.interactable);
    }
    removeMaterials() {
        for (let i = 0; i < this.meshVisuals.length; i++) {
            const materials = [];
            const matCount = this.meshVisuals[i].getMaterialsCount();
            for (let k = 0; k < matCount; k++) {
                const material = this.meshVisuals[i].getMaterial(k);
                if (this.materials.includes(material)) {
                    continue;
                }
                materials.push(material);
            }
            this.meshVisuals[i].clearMaterials();
            for (let k = 0; k < materials.length; k++) {
                this.meshVisuals[i].addMaterial(materials[k]);
            }
        }
    }
    // Changes the material of each RenderMeshVisual provided.
    changeMeshes(material) {
        this.removeMaterials();
        this.meshVisuals.forEach(function (mesh) {
            mesh.addMaterial(material);
        });
    }
    // Sets up interactable callbacks.
    setupInteractableCallbacks(interactable) {
        interactable.onTriggerStart.add(() => {
            this.changeMeshes(this.toggleButton.isToggledOn
                ? this.toggledOnSelectMaterial
                : this.toggledOffSelectMaterial);
        });
        interactable.onTriggerCanceled.add(() => {
            this.changeMeshes(this.toggleButton.isToggledOn
                ? this.toggledOnMaterial
                : this.toggledOffMaterial);
        });
        this.toggleButton.createEvent('OnEnableEvent').bind(() => {
            this.changeMeshes(this.toggleButton.isToggledOn
                ? this.toggledOnMaterial
                : this.toggledOffMaterial);
        });
        this.toggleButton.createEvent('OnDisableEvent').bind(() => {
            this.changeMeshes(this.disabledMaterial);
        });
        this.toggleButton.onStateChanged.add((isToggledOn) => {
            this.changeMeshes(this.toggleButton.enabled === false
                ? this.disabledMaterial
                : isToggledOn
                    ? this.toggledOnMaterial
                    : this.toggledOffMaterial);
        });
    }
};
exports.ToggleFeedback = ToggleFeedback;
exports.ToggleFeedback = ToggleFeedback = __decorate([
    component
], ToggleFeedback);
//# sourceMappingURL=ToggleFeedback.js.map