"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
const Singleton_1 = require("../../../Decorators/Singleton");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const TAG = 'GestureModuleProvider';
/**
 * Provides gesture related apis
 */
let GestureModuleProvider = class GestureModuleProvider {
    constructor() {
        this.gestureModule = undefined;
        this.log = new NativeLogger_1.default(TAG);
    }
    /**
   * Tries to create an Asset.GestureModule using the assetSystem.
   * Stores and returns the created object if it can be successfully created.
   * Returns undefined if error happens during creation.
   *
   * @returns the created GestureModule or undefined if it cannot be created
   */
    getGestureModule() {
        if (this.gestureModule === undefined) {
            try {
                this.gestureModule =
                    require('LensStudio:GestureModule');
            }
            catch (error) {
                this.log.e(`Error creating GestureModule: ${error}`);
            }
        }
        return this.gestureModule;
    }
};
GestureModuleProvider = __decorate([
    Singleton_1.Singleton
], GestureModuleProvider);
exports.default = GestureModuleProvider;
//# sourceMappingURL=GestureModuleProvider.js.map