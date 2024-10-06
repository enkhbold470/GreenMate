"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ConfigurationValidator = void 0;
var __selfType = requireType("./ConfigurationValidator");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const TAG = 'ConfigurationValidator';
let ConfigurationValidator = class ConfigurationValidator extends BaseScriptComponent {
    onAwake() {
        if (!global.deviceInfoSystem.isSpectacles() &&
            global.deviceInfoSystem.isEditor()) {
            throw new Error('To run Spectacles Interaction Kit in the Lens Studio Preview, set the Preview Panel\'s Device Type Override to Spectacles, or the Simulation Mode to Spectacles (2024)!');
        }
    }
};
exports.ConfigurationValidator = ConfigurationValidator;
exports.ConfigurationValidator = ConfigurationValidator = __decorate([
    component
], ConfigurationValidator);
//# sourceMappingURL=ConfigurationValidator.js.map