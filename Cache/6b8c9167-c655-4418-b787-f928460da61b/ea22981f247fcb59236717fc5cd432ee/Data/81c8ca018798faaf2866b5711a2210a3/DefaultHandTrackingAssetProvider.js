"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
const Singleton_1 = require("../../Decorators/Singleton");
const LEFT_HAND_ASSET = requireAsset('./LeftHandAsset.handTracking3D');
const RIGHT_HAND_ASSET = requireAsset('./RightHandAsset.handTracking3D');
/**
 * Implementation of the default hand tracking asset provider which is the default
 * asset from Lens Studio
 */
let DefaultHandTrackingAssetProvider = class DefaultHandTrackingAssetProvider {
    constructor() {
        this.leftHandAsset = LEFT_HAND_ASSET;
        this.rightHandAsset = RIGHT_HAND_ASSET;
    }
    /** @inheritdoc */
    get(handType) {
        return handType === 'left' ? this.leftHandAsset : this.rightHandAsset;
    }
};
DefaultHandTrackingAssetProvider = __decorate([
    Singleton_1.Singleton
], DefaultHandTrackingAssetProvider);
exports.default = DefaultHandTrackingAssetProvider;
//# sourceMappingURL=DefaultHandTrackingAssetProvider.js.map