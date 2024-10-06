"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.SIKLogLevelConfiguration = void 0;
var __selfType = requireType("./SIKLogLevelConfiguration");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const SIKLogLevelProvider_1 = require("../../Providers/InteractionConfigurationProvider/SIKLogLevelProvider");
const LogLevelConfiguration_1 = require("./LogLevelConfiguration");
const TAG = 'SIKLogLevelConfiguration';
/**
 * Allows the user to select the log level filter for SIK types from a lens studio component.
 */
let SIKLogLevelConfiguration = class SIKLogLevelConfiguration extends LogLevelConfiguration_1.LogLevelConfiguration {
    onAwake() {
        this.SIKLogLevelProvider.logLevel = this.logLevelFilter;
    }
    __initialize() {
        super.__initialize();
        this.SIKLogLevelProvider = SIKLogLevelProvider_1.default.getInstance();
    }
};
exports.SIKLogLevelConfiguration = SIKLogLevelConfiguration;
exports.SIKLogLevelConfiguration = SIKLogLevelConfiguration = __decorate([
    component
], SIKLogLevelConfiguration);
//# sourceMappingURL=SIKLogLevelConfiguration.js.map