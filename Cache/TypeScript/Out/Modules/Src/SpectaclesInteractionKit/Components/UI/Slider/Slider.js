"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Slider = void 0;
var __selfType = requireType("./Slider");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Event_1 = require("../../../Utils/Event");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const animate_1 = require("../../../Utils/animate");
const InspectorCallbacks_1 = require("../../../Utils/InspectorCallbacks");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const Interactable_1 = require("../../Interaction/Interactable/Interactable");
const TAG = 'Slider';
/**
 * A numerical slider control powered by Interaction Kit 1.1's hand tracking interactions.
 */
let Slider = class Slider extends BaseScriptComponent {
    onAwake() {
        this.interactable = this.sliderKnob.getComponent(Interactable_1.Interactable.getTypeName());
        this.sliderKnobScreenTransform = this.sliderKnob.getComponent('Component.ScreenTransform');
        this.transform = this.getTransform();
        this.sliderBounds = {
            start: this.transform
                .getInvertedWorldTransform()
                .multiplyPoint(this.sliderMin.getTransform().getWorldPosition()),
            end: this.transform
                .getInvertedWorldTransform()
                .multiplyPoint(this.sliderMax.getTransform().getWorldPosition()),
            minAnchor: this.sliderMin.getComponent('Component.ScreenTransform')
                .anchors,
            maxAnchor: this.sliderMax.getComponent('Component.ScreenTransform')
                .anchors,
        };
        this._startPosition = this.sliderBounds.start;
        this._endPosition = this.sliderBounds.end;
        this.minBound = this.sliderBounds.minAnchor.getCenter();
        this.maxBound = this.sliderBounds.maxAnchor.getCenter();
        this.trackState = this.getTrackState();
        this.sliderState = this.getInitialSliderState();
        this.onHoverEnterEvent = new Event_1.default();
        this.onHoverExitEvent = new Event_1.default();
        this.onSlideStartEvent = new Event_1.default();
        this.onSlideEndEvent = new Event_1.default();
        this.onMinValueReachedEvent = new Event_1.default();
        this.onMaxValueReachedEvent = new Event_1.default();
        this.onValueUpdateEvent = new Event_1.default((value) => {
            if (value >= this._maxValue) {
                this.onMaxValueReachedEvent.invoke(this._maxValue);
            }
            else if (value <= this._minValue) {
                this.onMinValueReachedEvent.invoke(this._minValue);
            }
        });
        this.onHoverEnter = this.onHoverEnterEvent.publicApi();
        this.onHoverExit = this.onHoverExitEvent.publicApi();
        this.onSlideStart = this.onSlideStartEvent.publicApi();
        this.onSlideEnd = this.onSlideEndEvent.publicApi();
        this.onValueUpdate = this.onValueUpdateEvent.publicApi();
        this.onMinValueReached = this.onMinValueReachedEvent.publicApi();
        this.onMaxValueReached = this.onMaxValueReachedEvent.publicApi();
        if (this._minValue > this._maxValue || this._maxValue < this._minValue) {
            throw new Error('Error: SliderComponent\'s maxValue must be less than its minValue.');
        }
        if (this._stepSize < 0 ||
            this._stepSize > this._maxValue - this._minValue) {
            throw new Error('Error: SliderComponent\'s stepSize must be greater than or equal to 0, and less than its value range.');
        }
        this.updateUI();
        // Waiting for the OnStartEvent ensures that Interactable components are initialized before we add slider callbacks.
        this.createEvent('OnStartEvent').bind(() => {
            if (!this.interactable) {
                throw new Error('Slider Knob must contain an Interactable component for the slider to work - please ensure that one is added to the SceneObject.');
            }
            if (!this.sliderKnobScreenTransform) {
                throw new Error('Slider Knob must be a Screen Transform for the slider to work - please ensure that one is added to the SceneObject.');
            }
            this.setupInteractable();
        });
        this.createEvent('OnDestroyEvent').bind(() => {
            this.unsubscribeCallbacks();
        });
        if (this.editEventCallbacks) {
            if (this.customFunctionForOnHoverEnter) {
                this.onHoverEnter.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnHoverEnter, this.onHoverEnterFunctionNames));
            }
            if (this.customFunctionForOnHoverExit) {
                this.onHoverExit.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnHoverExit, this.onHoverExitFunctionNames));
            }
            if (this.customFunctionForOnSlideStart) {
                this.onSlideStart.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnSlideStart, this.onSlideStartFunctionNames));
            }
            if (this.customFunctionForOnSlideEnd) {
                this.onSlideEnd.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnSlideEnd, this.onSlideEndFunctionNames));
            }
            if (this.customFunctionForOnValueUpdate) {
                this.onValueUpdate.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnValueUpdate, this.onValueUpdateFunctionNames));
            }
            if (this.customFunctionForOnMinValueReached) {
                this.onMinValueReached.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnMinValueReached, this.onMinValueReachedFunctionNames));
            }
            if (this.customFunctionForOnMaxValueReached) {
                this.onMaxValueReached.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnMaxValueReached, this.onMaxValueReachedFunctionNames));
            }
        }
    }
    get minValue() {
        return this._minValue;
    }
    set minValue(value) {
        if (value >= this._maxValue) {
            this.log.e(`Could not set minimum value to ${value} as it cannot be greater than or equal to the maximum value: ${this._maxValue}`);
            return;
        }
        this._minValue = value;
        let displayValue = this.sliderState.displayValue;
        if (value > this.sliderState.displayValue) {
            this.log.w(`Setting current value ${this.sliderState.displayValue} to the new minimum value ${value} provided as it is now out of range.`);
            displayValue = value;
        }
        this.updateSliderStateFromDisplayValue(displayValue);
    }
    get maxValue() {
        return this._maxValue;
    }
    set maxValue(value) {
        if (value <= this._minValue) {
            this.log.e(`Could not set maximum value to ${value} as it cannot be less than or equal to the minimum value: ${this._minValue}`);
            return;
        }
        this._maxValue = value;
        let displayValue = this.sliderState.displayValue;
        if (value < this.sliderState.displayValue) {
            this.log.w(`Setting current value ${this.sliderState.displayValue} to the new maximum value ${value} provided as it is now out of range.`);
            displayValue = value;
        }
        this.updateSliderStateFromDisplayValue(displayValue);
    }
    get currentValue() {
        return this.sliderState.displayValue;
    }
    set currentValue(value) {
        if (value < this._minValue) {
            this.log.w(`Slider value will be set to the minimum value: ${this._minValue} as the provided value ${value} was less than the minimum value allowed.`);
            value = this._minValue;
        }
        else if (value > this._maxValue) {
            this.log.w(`Slider value will be set to the maximum value: ${this._maxValue} as the provided value ${value} was greater than the maximum value allowed.`);
            value = this._maxValue;
        }
        this.updateSliderStateFromDisplayValue(value);
    }
    get stepSize() {
        return this._stepSize;
    }
    set stepSize(stepSize) {
        if (stepSize > this._maxValue - this._minValue) {
            this.log.e(`Could not set step size to ${stepSize} as it must be less than the slider's value range.`);
            return;
        }
        else if (stepSize < 0) {
            this.log.e(`Could not set step size to ${stepSize} as it must be greater than or equal to 0.`);
            return;
        }
        this._stepSize = stepSize;
    }
    get startPosition() {
        return this._startPosition;
    }
    set startPosition(position) {
        this._startPosition = position;
        this.trackState = this.getTrackState();
        this.updateSliderState(null);
    }
    get endPosition() {
        return this._endPosition;
    }
    set endPosition(position) {
        this._endPosition = position;
        this.trackState = this.getTrackState();
        this.updateSliderState(null);
    }
    get sliderKnob() {
        return this._sliderKnob;
    }
    getInitialSliderState() {
        const rawValue = this.calculateRawValueFromDisplayValue(this.startValue);
        const displayValue = this.getSteppedDisplayValue(this.startValue);
        const snappedValue = this.calculateRawValueFromDisplayValue(displayValue);
        return {
            dragVector: null,
            rawValue: rawValue,
            snappedValue: snappedValue,
            displayValue: displayValue,
        };
    }
    getTrackState() {
        const direction = this._endPosition.sub(this._startPosition).normalize();
        const min = -this._startPosition.length;
        const max = this._endPosition.length;
        return {
            trackMin: min,
            trackMax: max,
            trackSize: max - min,
            trackDirection: direction,
        };
    }
    /**
     * Sets up event callbacks for behavior on the Interactable's interaction events.
     */
    setupInteractable() {
        if (this.interactable === null) {
            throw new Error('Slider Knob must contain an Interactable component for the slider to work - please ensure that one is added to the SceneObject.');
        }
        // If this is not a slider with step size, enable instant dragging for more responsive behavior.
        if (this.stepSize === 0) {
            this.interactable.enableInstantDrag = true;
        }
        this.unsubscribeBag.push(this.interactable.onHoverEnter.add(() => {
            this.onHoverEnterEvent.invoke();
        }));
        this.unsubscribeBag.push(this.interactable.onHoverExit.add(() => {
            this.onHoverExitEvent.invoke();
        }));
        this.unsubscribeBag.push(this.interactable.onDragStart.add((event) => {
            this.onSlideStartEvent.invoke(this.sliderState.displayValue);
            this.isDragging = true;
            this.updateSliderState({
                dragVector: event.interactor.dragType !== Interactor_1.DragType.Touchpad
                    ? event.planecastDragVector
                    : event.dragVector,
                dragPoint: event.interactor.planecastPoint,
            });
        }));
        this.unsubscribeBag.push(this.interactable.onDragUpdate.add((event) => {
            this.updateSliderState({
                dragVector: event.interactor.dragType !== Interactor_1.DragType.Touchpad
                    ? event.planecastDragVector
                    : event.dragVector,
                dragPoint: event.interactor.planecastPoint,
            });
        }));
        this.unsubscribeBag.push(this.interactable.onDragEnd.add(() => {
            this.onSlideEndEvent.invoke(this.sliderState.displayValue);
            this.isDragging = false;
            this.updateSliderState(null);
        }));
        this.unsubscribeBag.push(this.interactable.onTriggerEnd.add(() => {
            this.toggleSliderState();
        }));
    }
    calculateRawValueFromDragVector(dragVector) {
        if (dragVector === null) {
            return this.sliderState.rawValue;
        }
        dragVector = this.transform
            .getInvertedWorldTransform()
            .multiplyDirection(dragVector);
        return MathUtils.clamp(this.sliderState.rawValue +
            this.trackState.trackDirection.dot(dragVector), this.trackState.trackMin, this.trackState.trackMax);
    }
    calculateDisplayValueFromRawValue(rawValue) {
        const displayValue = MathUtils.remap(rawValue, this.trackState.trackMin, this.trackState.trackMax, this._minValue, this._maxValue);
        return this.getSteppedDisplayValue(displayValue);
    }
    calculateRawValueFromDisplayValue(displayValue) {
        return MathUtils.remap(displayValue, this._minValue, this._maxValue, this.trackState.trackMin, this.trackState.trackMax);
    }
    getSteppedDisplayValue(displayValue) {
        return this._stepSize > 0
            ? this._minValue +
                Math.round((displayValue - this._minValue) / this._stepSize) *
                    this._stepSize
            : displayValue;
    }
    /**
     * Updates SliderState representing the most updated version of the slider, using the drag vector if active.
     * @param dragUpdate - the drag vector provided by the Interactor, or null if a drag is not active.
     */
    updateSliderState(dragUpdate) {
        if (dragUpdate === null) {
            this.sliderState.dragVector = null;
            return;
        }
        const localizedDragPoint = this.transform
            .getInvertedWorldTransform()
            .multiplyPoint(dragUpdate.dragPoint);
        // Check that the drag point is between the start/end points.
        const dragPointCheck = this.checkOutsideTrackBoundary(localizedDragPoint);
        if (dragPointCheck === -1) {
            this.currentValue = this.minValue;
            return;
        }
        else if (dragPointCheck === 1) {
            this.currentValue = this.maxValue;
            return;
        }
        const rawValue = this.calculateRawValueFromDragVector(dragUpdate.dragVector);
        const displayValue = this.calculateDisplayValueFromRawValue(rawValue);
        const snappedValue = this.calculateRawValueFromDisplayValue(displayValue);
        if (this.sliderState.displayValue !== displayValue) {
            this.onValueUpdateEvent.invoke(displayValue);
        }
        this.sliderState = {
            dragVector: dragUpdate.dragVector,
            rawValue: rawValue,
            snappedValue: snappedValue,
            displayValue: displayValue,
        };
        this.updateUI();
    }
    // Check if a local point is to the left of the start point (-1) or the right of the end point (1).
    checkOutsideTrackBoundary(localPoint) {
        const isPastStartPoint = localPoint
            .sub(this.sliderBounds.start)
            .angleTo(this.trackState.trackDirection) >
            Math.PI / 2;
        const isPastEndPoint = localPoint
            .sub(this.sliderBounds.end)
            .angleTo(this.trackState.trackDirection) <
            Math.PI / 2;
        if (isPastStartPoint) {
            return -1;
        }
        if (isPastEndPoint) {
            return 1;
        }
        return 0;
    }
    toggleSliderState() {
        if (this.isDragging) {
            return;
        }
        const initialValue = this.currentValue;
        if (this.stepSize === this.maxValue - this.minValue) {
            if (initialValue === this.minValue) {
                this.currentValue = this.maxValue;
            }
            else if (initialValue === this.maxValue) {
                this.currentValue = this.minValue;
            }
            this.animateToggleUI(initialValue < this.currentValue);
        }
    }
    animateToggleUI(toggledOn) {
        (0, animate_1.default)({
            duration: this.toggleDuration,
            easing: 'ease-out-cubic',
            update: (t) => {
                const lerpValue = toggledOn ? t : 1 - t;
                this.sliderKnobScreenTransform.anchors.setCenter(vec2.lerp(this.minBound, this.maxBound, lerpValue));
            },
        });
    }
    /**
     * Updates SliderState representing the most updated version of the slider, using a provided display value.
     * @param displayValue - the desired display value.
     */
    updateSliderStateFromDisplayValue(displayValue) {
        const snappedValue = this.calculateRawValueFromDisplayValue(displayValue);
        if (displayValue !== this.sliderState.displayValue) {
            this.onValueUpdateEvent.invoke(displayValue);
        }
        this.sliderState = {
            dragVector: null,
            rawValue: snappedValue,
            snappedValue: snappedValue,
            displayValue: displayValue,
        };
        this.updateUI();
    }
    /**
     * Updates the slider UI based on the snapped value, by moving the knob's position.
     */
    updateUI() {
        this.sliderKnobScreenTransform.anchors.setCenter(vec2.lerp(this.minBound, this.maxBound, (this.sliderState.snappedValue - this.trackState.trackMin) /
            this.trackState.trackSize));
    }
    /**
     * Unsubscribes all the slider-specific callbacks to the Interactable component before this component is destroyed.
     */
    unsubscribeCallbacks() {
        this.unsubscribeBag.forEach((unsubscribeCallback) => {
            unsubscribeCallback();
        });
        this.unsubscribeBag = [];
    }
    __initialize() {
        super.__initialize();
        this.log = new NativeLogger_1.default(TAG);
        this.unsubscribeBag = [];
        this.isDragging = false;
    }
};
exports.Slider = Slider;
exports.Slider = Slider = __decorate([
    component
], Slider);
//# sourceMappingURL=Slider.js.map