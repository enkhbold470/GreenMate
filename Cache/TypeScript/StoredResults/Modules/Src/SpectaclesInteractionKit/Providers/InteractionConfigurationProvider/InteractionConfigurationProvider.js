"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.InteractionConfigurationProvider = void 0;
const Singleton_1 = require("../../Decorators/Singleton");
let InteractionConfigurationProvider = class InteractionConfigurationProvider {
    requireType(componentName) {
        switch (componentName) {
            case 'Billboard':
                return requireType('../../Components/Interaction/Billboard/Billboard');
            case 'ContainerFrame':
                return requireType('../../Components/UI/ContainerFrame/ContainerFrame');
            case 'HandInteractor':
                return requireType('../../Core/HandInteractor/HandInteractor');
            case 'HandVisual':
                return requireType('../../Components/Interaction/HandVisual/HandVisual');
            case 'Headlock':
                return requireType('../../Components/Interaction/Headlock/Headlock');
            case 'Interactable':
                return requireType('../../Components/Interaction/Interactable/Interactable');
            case 'InteractableManipulation':
                return requireType('../../Components/Interaction/InteractableManipulation/InteractableManipulation');
            case 'PinchButton':
                return requireType('../../Components/UI/PinchButton/PinchButton');
            case 'ScrollView':
                return requireType('../../Components/UI/ScrollView/ScrollView');
            case 'ScrollBar':
                return requireType('../../Components/UI/ScrollBar/ScrollBar');
            case 'Slider':
                return requireType('../../Components/UI/Slider/Slider');
            case 'ToggleButton':
                return requireType('../../Components/UI/ToggleButton/ToggleButton');
            case 'MouseInteractor':
                return requireType('../../Core/MouseInteractor/MouseInteractor');
            default:
                throw new Error(`Could not find typename for component ${componentName}`);
        }
    }
};
exports.InteractionConfigurationProvider = InteractionConfigurationProvider;
exports.InteractionConfigurationProvider = InteractionConfigurationProvider = __decorate([
    Singleton_1.Singleton
], InteractionConfigurationProvider);
//# sourceMappingURL=InteractionConfigurationProvider.js.map