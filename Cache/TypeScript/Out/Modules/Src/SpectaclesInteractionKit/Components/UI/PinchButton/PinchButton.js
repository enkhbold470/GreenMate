"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PinchButton = void 0;
var __selfType = requireType("./PinchButton");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Event_1 = require("../../../Utils/Event");
const InspectorCallbacks_1 = require("../../../Utils/InspectorCallbacks");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const Interactable_1 = require("../../Interaction/Interactable/Interactable");
const TAG = 'PinchButton';
/*
 * PinchButton provides basic pinch button functionality for the prefab pinch button.
 * It is meant to be added to a Scene Object with an Interactable component, with visual behavior configured in the Lens Studio scene.
 */
let PinchButton = class PinchButton extends BaseScriptComponent {
    onAwake() {
        this.interactable = this.getSceneObject().getComponent(Interactable_1.Interactable.getTypeName());
        this.createEvent('OnStartEvent').bind(() => {
            if (!this.interactable) {
                throw new Error('Pinch Button requires an Interactable Component on the same Scene object in order to work - please ensure one is added.');
            }
            this.interactable.onTriggerEnd.add((interactorEvent) => {
                try {
                    if (this.enabled) {
                        this.onButtonPinchedEvent.invoke(interactorEvent);
                    }
                }
                catch (e) {
                    this.log.e('Error invoking onButtonPinchedEvent!');
                }
            });
        });
        if (this.editEventCallbacks && this.customFunctionForOnButtonPinched) {
            this.onButtonPinched.add((0, InspectorCallbacks_1.createCallback)(this.customFunctionForOnButtonPinched, this.onButtonPinchedFunctionNames));
        }
    }
    __initialize() {
        super.__initialize();
        this.onButtonPinchedEvent = new Event_1.default();
        this.onButtonPinched = this.onButtonPinchedEvent.publicApi();
        this.log = new NativeLogger_1.default(TAG);
    }
};
exports.PinchButton = PinchButton;
exports.PinchButton = PinchButton = __decorate([
    component
], PinchButton);
//# sourceMappingURL=PinchButton.js.map