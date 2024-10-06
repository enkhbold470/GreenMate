"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ColliderTargetProvider = void 0;
const TargetProvider_1 = require("../../Providers/TargetProvider/TargetProvider");
/**
 * Uses a collider positioned to detect a target
 */
class ColliderTargetProvider extends TargetProvider_1.default {
    constructor(interactor, config) {
        super();
        this.config = config;
        this.interactor = interactor;
        this.ownerSceneObject = global.scene.createSceneObject('ColliderTargetProvider');
        this.ownerSceneObject.setParent(this.interactor.sceneObject);
    }
    /** @inheritdoc */
    get startPoint() {
        return this.colliderPosition;
    }
    /** @inheritdoc */
    get endPoint() {
        return this.colliderPosition;
    }
    /**
   * @returns the direct collider position for direct manipulation
   */
    get colliderPosition() {
        return this.isAvailable()
            ? this.ownerSceneObject.getTransform().getWorldPosition()
            : vec3.zero();
    }
    /** @inheritdoc */
    update() {
        if (this.isAvailable()) {
            const newPosition = this.getNextPosition();
            this.ownerSceneObject.getTransform().setWorldPosition(newPosition);
            this.ownerSceneObject.enabled = true;
        }
        else {
            this.ownerSceneObject.enabled = false;
            this.clearCurrentInteractableHitInfo();
        }
    }
    /** @inheritdoc */
    destroy() {
        this.ownerSceneObject.destroy();
    }
    createCollider(sceneObject, radius, onOverlapStay, onOverlapExit, debugDrawEnabled) {
        const collider = sceneObject.createComponent('Physics.ColliderComponent');
        const shape = Shape.createSphereShape();
        shape.radius = radius;
        collider.shape = shape;
        collider.intangible = true;
        collider.debugDrawEnabled = debugDrawEnabled;
        if (onOverlapStay !== null) {
            collider.onOverlapStay.add(onOverlapStay);
        }
        if (onOverlapExit !== null) {
            collider.onOverlapExit.add(onOverlapExit);
        }
        return collider;
    }
    onColliderOverlapStay(event, allowOutOfFovInteraction = true) {
        var _a, _b;
        if ((_b = (_a = this.config).shouldPreventTargetUpdate) === null || _b === void 0 ? void 0 : _b.call(_a)) {
            return;
        }
        const hits = event.currentOverlaps
            .map((overlap) => {
            try {
                return {
                    collider: overlap.collider,
                    distance: overlap.collider
                        .getTransform()
                        .getWorldPosition()
                        .distance(this.endPoint),
                    normal: vec3.zero(),
                    position: this.endPoint,
                    skipRemaining: false,
                    t: 0,
                    triangle: null,
                    getTypeName: overlap.collider.getTypeName,
                    isTypeOf: overlap.collider.isOfType,
                    isSame: overlap.collider.isSame,
                    isOfType: overlap.collider.isOfType,
                };
            }
            catch {
                return null;
            }
        })
            .filter((hit) => hit !== null);
        this._currentInteractableHitInfo = this.getInteractableHitFromRayCast(hits, 0, allowOutOfFovInteraction);
    }
    onColliderOverlapExit(event) {
        var _a;
        if (event.overlap.collider === ((_a = this._currentInteractableHitInfo) === null || _a === void 0 ? void 0 : _a.hit.collider)) {
            this._currentInteractableHitInfo = null;
        }
    }
}
exports.ColliderTargetProvider = ColliderTargetProvider;
//# sourceMappingURL=ColliderTargetProvider.js.map