"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.LensConfig = void 0;
const Singleton_1 = require("../Decorators/Singleton");
const UpdateDispatcher_1 = require("./UpdateDispatcher");
let LensConfig = class LensConfig {
    constructor() {
        this.sceneObject = global.scene.createSceneObject('LensConfig-EventDispatcher');
        this.script = this.sceneObject.createComponent('ScriptComponent');
        this.updateDispatcher = new UpdateDispatcher_1.UpdateDispatcher(this.script);
    }
};
exports.LensConfig = LensConfig;
exports.LensConfig = LensConfig = __decorate([
    Singleton_1.Singleton
], LensConfig);
//# sourceMappingURL=LensConfig.js.map