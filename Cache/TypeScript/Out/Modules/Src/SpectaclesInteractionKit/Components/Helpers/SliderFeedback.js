"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.SliderFeedback = void 0;
var __selfType = requireType("./SliderFeedback");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Slider_1 = require("../UI/Slider/Slider");
const SLIDER_LEVEL_MIN = 0.15;
const SLIDER_LEVEL_MAX = 0.85;
let SliderFeedback = class SliderFeedback extends BaseScriptComponent {
    onAwake() {
        this.materials = [
            this.sliderKnobIdleMaterial,
            this.sliderKnobSelectedMaterial,
        ];
        this.defineScriptEvents();
    }
    defineScriptEvents() {
        this.createEvent('OnStartEvent').bind(() => {
            this.init();
        });
    }
    /**
     * Returns the AudioComponent used for feedback for further configuration (volume).
     */
    get audioComponent() {
        return this._audioComponent;
    }
    init() {
        if (!this.showDebug) {
            this.debugElements.forEach(function (element) {
                element.enabled = false;
            });
        }
        this.trackMaterial = this.sliderTrackMaterial.clone();
        this.sliderTrackMesh.mainMaterial = this.trackMaterial;
        this.currentSlider = this.getSceneObject().getComponent(Slider_1.Slider.getTypeName());
        this._audioComponent = this.getSceneObject().createComponent('Component.AudioComponent');
        this.audioComponent.playbackMode = Audio.PlaybackMode.LowLatency;
        // Set up the material so that it reflects the selected colors and slider level
        this.trackMaterial.mainPass.Level = this.getSliderLevelFromValue(this.currentSlider.currentValue);
        // Set up the slider audio
        if (!isNull(this.sliderProgressAudio)) {
            this.audioComponent.audioTrack = this.sliderProgressAudio;
        }
        this.setupSliderCallbacks();
    }
    setupSliderCallbacks() {
        // Modify the material on slider changes by subscribing to value updates
        this.currentSlider.onValueUpdate.add((value) => {
            this.trackMaterial.mainPass.Level = this.getSliderLevelFromValue(value);
            if (!isNull(this.audioComponent.audioTrack)) {
                this.audioComponent.play(1);
            }
        });
        this.currentSlider.onSlideStart.add(() => {
            this.changeMesh(this.sliderKnobSelectedMaterial);
        });
        this.currentSlider.onSlideEnd.add(() => {
            this.changeMesh(this.sliderKnobIdleMaterial);
        });
    }
    getSliderLevelFromValue(value) {
        if (value <= this.currentSlider.minValue) {
            return 0;
        }
        else if (value >= this.currentSlider.maxValue) {
            return 1;
        }
        else {
            const progress = (value - this.currentSlider.minValue) /
                (this.currentSlider.maxValue - this.currentSlider.minValue);
            return SLIDER_LEVEL_MIN + (SLIDER_LEVEL_MAX - SLIDER_LEVEL_MIN) * progress;
        }
    }
    removeMaterials() {
        const materials = [];
        const matCount = this.sliderKnobMesh.getMaterialsCount();
        for (let k = 0; k < matCount; k++) {
            const material = this.sliderKnobMesh.getMaterial(k);
            if (this.materials.includes(material)) {
                continue;
            }
            materials.push(material);
        }
        this.sliderKnobMesh.clearMaterials();
        for (let k = 0; k < materials.length; k++) {
            this.sliderKnobMesh.addMaterial(materials[k]);
        }
    }
    // Changes the material of provided RenderMeshVisual.
    changeMesh(material) {
        this.removeMaterials();
        this.sliderKnobMesh.addMaterial(material);
    }
};
exports.SliderFeedback = SliderFeedback;
exports.SliderFeedback = SliderFeedback = __decorate([
    component
], SliderFeedback);
//# sourceMappingURL=SliderFeedback.js.map