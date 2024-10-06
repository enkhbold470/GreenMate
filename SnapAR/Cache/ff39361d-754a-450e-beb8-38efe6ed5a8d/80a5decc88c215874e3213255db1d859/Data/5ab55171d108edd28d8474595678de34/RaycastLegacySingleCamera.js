"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const RaycastBase_1 = require("./RaycastBase");
const SHOULDER_POSITION_RELATIVE_TO_CAMERA = new vec3(15, -20, 0);
/**
 * Raycast Legacy uses the algorithm previously used for Hermosa ray casting.
 * Meant for use with single-camera tracking, to unblock anything requiring more stable targeting until stereo tracking is available
 */
class RaycastLegacySingleCamera extends RaycastBase_1.default {
    /**
   * Calculates a simple ray direction anchor based on camera position only.
   * @returns ray direction anchor
   */
    calculateRayDirectionAnchor() {
        return this.camera
            .getWorldTransform()
            .multiplyPoint(SHOULDER_POSITION_RELATIVE_TO_CAMERA);
    }
    getRay() {
        if (this.hand.middleKnuckle === null) {
            return null;
        }
        else {
            // Find the ray direction
            const targetingRay = this.hand.middleKnuckle.position.sub(this.calculateRayDirectionAnchor());
            return {
                locus: this.locusOneEuroFilter.filter(this.hand.middleKnuckle.position, getTime()),
                direction: this.directionOneEuroFilter
                    .filter(targetingRay, getTime())
                    .normalize(),
            };
        }
    }
}
exports.default = RaycastLegacySingleCamera;
//# sourceMappingURL=RaycastLegacySingleCamera.js.map