"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getSafeReference = void 0;
/**
 * Used to check if an Object reference has been destroyed on the LensCore side
 * @param reference - the reference to check, typically a SceneObject or Component
 * @returns - the same reference if not destroyed on the LensCore side, or null if destroyed
 */
function getSafeReference(reference) {
    if (reference && !isNull(reference)) {
        return reference;
    }
    return null;
}
exports.getSafeReference = getSafeReference;
//# sourceMappingURL=SafeReference.js.map