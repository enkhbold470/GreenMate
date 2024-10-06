"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.HandRayProvider = void 0;
const SIK_1 = require("../../SIK");
const RaycastAnchorHead_1 = require("./raycastAlgorithms/RaycastAnchorHead");
const RaycastAnchorVariableShoulder_1 = require("./raycastAlgorithms/RaycastAnchorVariableShoulder");
const RaycastLegacySingleCamera_1 = require("./raycastAlgorithms/RaycastLegacySingleCamera");
const RaycastProxy_1 = require("./raycastAlgorithms/RaycastProxy");
class HandRayProvider {
    constructor(config) {
        this.config = config;
        this.handProvider = SIK_1.SIK.HandInputData;
        this.hand = this.handProvider.getHand(this.config.handType);
        // Set raycast algorithm used
        switch (config.raycastAlgorithm) {
            case 'LegacySingleCamera': {
                this.raycast = new RaycastLegacySingleCamera_1.default(this.hand);
                break;
            }
            case 'AnchorHead': {
                this.raycast = new RaycastAnchorHead_1.default(this.hand);
                break;
            }
            case 'Proxy': {
                this.raycast = new RaycastProxy_1.default(this.hand);
                break;
            }
            default: {
                this.raycast = new RaycastAnchorVariableShoulder_1.default(this.hand);
                break;
            }
        }
    }
    /** @inheritdoc */
    getRaycastInfo() {
        var _a;
        return ((_a = this.raycast.getRay()) !== null && _a !== void 0 ? _a : {
            direction: vec3.zero(),
            locus: vec3.zero(),
        });
    }
    /** @inheritdoc */
    isAvailable() {
        return ((this.hand.isInTargetingPose() && this.hand.isTracked()) ||
            this.hand.isPinching());
    }
    /** @inheritdoc */
    reset() {
        this.raycast.reset();
    }
}
exports.HandRayProvider = HandRayProvider;
//# sourceMappingURL=HandRayProvider.js.map