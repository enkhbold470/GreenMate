"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.HandInputData = void 0;
const Singleton_1 = require("../../Decorators/Singleton");
const TrackedHand_1 = require("./TrackedHand");
const TAG = 'HandInputData';
/**
 * Main class for the hand data provider apis.
 * Available apis:
 * - getHand(handType: {@link HandType}) => {@link BaseHand} returns BaseHand Object that
 * represents {@link HandType}
 * - getDominantHand() => {@link BaseHand} returns BaseHand Object that
 * represents the dominant hand as specified in the system through a Tweak.
 * - getNonDominantHand() => {@link BaseHand} returns BaseHand Object that
 * represents the non dominant hand as specified in the system through a Tweak.
 */
let HandInputData = class HandInputData {
    constructor() {
        this._enabled = true;
        this.config = {
            dominantHand: 'right',
        };
        this.leftHand = this.createHand('left');
        this.rightHand = this.createHand('right');
    }
    /**
   * Sets the enabled state of the left and right hand.
   * Events will not be called if isEnabled is set to false.
   */
    set enabled(enabled) {
        if (this._enabled === enabled) {
            return;
        }
        this.leftHand.setEnabled(enabled);
        this.rightHand.setEnabled(enabled);
        this._enabled = enabled;
    }
    createHand(handType) {
        return new TrackedHand_1.default({
            handType: handType,
            isDominantHand: handType === this.config.dominantHand,
        });
    }
    getHand(handType) {
        return handType === 'left' ? this.leftHand : this.rightHand;
    }
    getDominantHand() {
        return this.getHand(this.config.dominantHand);
    }
    getNonDominantHand() {
        const nonDominantHandType = this.config.dominantHand === 'right' ? 'left' : 'right';
        return this.getHand(nonDominantHandType);
    }
    setDominantHand(dominant) {
        this.config.dominantHand = dominant;
        this.getHand('left').setIsDominantHand(dominant === 'left');
        this.getHand('right').setIsDominantHand(dominant === 'right');
    }
};
exports.HandInputData = HandInputData;
exports.HandInputData = HandInputData = __decorate([
    Singleton_1.Singleton
], HandInputData);
//# sourceMappingURL=HandInputData.js.map