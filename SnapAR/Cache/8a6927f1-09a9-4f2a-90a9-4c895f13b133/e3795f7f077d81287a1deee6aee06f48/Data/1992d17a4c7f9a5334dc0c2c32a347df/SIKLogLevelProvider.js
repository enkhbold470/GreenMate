"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
const Singleton_1 = require("../../Decorators/Singleton");
const LogLevelProvider_1 = require("./LogLevelProvider");
/**
 * Provides the level of logging that we want to allow from SIK types.
 */
let SIKLogLevelProvider = class SIKLogLevelProvider extends LogLevelProvider_1.default {
    constructor() {
        super();
    }
};
SIKLogLevelProvider = __decorate([
    Singleton_1.Singleton
], SIKLogLevelProvider);
exports.default = SIKLogLevelProvider;
//# sourceMappingURL=SIKLogLevelProvider.js.map