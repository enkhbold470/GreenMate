"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Event_1 = require("../../Utils/Event");
const InteractionManager_1 = require("../InteractionManager/InteractionManager");
const DragProvider_1 = require("./DragProvider");
const Interactor_1 = require("./Interactor");
const TAG = 'BaseInteractor';
/**
 * Defines API for {@link Interactor} type
 */
class BaseInteractor extends BaseScriptComponent {
    release() {
        this.interactionManager.deregisterInteractor(this);
    }
    /**
     * Updates the targeting and trigger state of the interactor
     */
    updateState() {
        this.previousInteractable = this.currentInteractable;
        this.previousTrigger = this.currentTrigger;
        this.previousDragVector = this.currentDragVector;
        this._previousStartPoint = this.startPoint;
        this.currentInteractable = null;
    }
    /**
     * Disables or enables the input powering this interactor
     * @param enabled whether the input powering the interactor should be enabled
     */
    setInputEnabled(enabled) { }
    /**
     * Clears the current Interactable, used when an Interactable is deleted at runtime
     */
    clearCurrentInteractable() {
        this.currentInteractable = null;
        this.clearCurrentHitInfo();
    }
    /**
     * Returns the delta start position from previous frame
     */
    get deltaStartPosition() {
        if (this.startPoint === null || this._previousStartPoint === null) {
            return null;
        }
        return this.startPoint.sub(this._previousStartPoint);
    }
    get dragProvider() {
        return this._dragProvider;
    }
    set dragProvider(provider) {
        this._dragProvider = provider;
    }
    get planecastDragProvider() {
        return this._planecastDragProvider;
    }
    /**
     * @returns the drag vector projected onto the plane defined by the current Interactable's forward and origin
     */
    get planecastDragVector() {
        return this.planecastDragProvider.currentDragVector;
    }
    clearDragProviders() {
        this.dragProvider.clear();
        this.planecastDragProvider.clear();
    }
    updateDragVector() {
        var _a, _b, _c, _d;
        if ((this.currentTrigger & Interactor_1.InteractorTriggerType.Select) !== 0) {
            this.currentDragVector = this.dragProvider.getDragVector(this.getDragPoint(), (_b = (_a = this.currentInteractable) === null || _a === void 0 ? void 0 : _a.enableInstantDrag) !== null && _b !== void 0 ? _b : null);
            this.planecastDragProvider.getDragVector(this.planecastPoint, (_d = (_c = this.currentInteractable) === null || _c === void 0 ? void 0 : _c.enableInstantDrag) !== null && _d !== void 0 ? _d : null);
        }
        else {
            this.currentDragVector = null;
            this.clearDragProviders();
        }
    }
    getDragPoint() {
        return this.endPoint;
    }
    get planecastPoint() {
        return this.raycastPlaneIntersection(this.currentInteractable);
    }
    /**
     * Used to define the type of drag vector that the interactor is invoking.
     * By default, interactor drag vectors will be as SixDof drags.
     */
    get dragType() {
        if (this.currentDragVector !== null) {
            return Interactor_1.DragType.SixDof;
        }
        return null;
    }
    /**
     * Calculates the intersection of the Interactor's indirect raycast and the plane defined by the Interactable's forward vector / origin
     * @param interactable - the Interactable used to define the plane of intersection
     * @returns the intersection point of the indirect raycast and plane
     */
    raycastPlaneIntersection(interactable) {
        const origin = this.startPoint;
        const direction = this.direction;
        if (origin === null || direction === null || interactable === null) {
            return null;
        }
        // This logic uses the equation of t = ((p0-l0)·n)/(l·n) with l0 + l*t = the point of intersection.
        // l0 represents ray origin, l represents direction, p0 represents plane origin, and n represents the plane normal.
        const normal = interactable.sceneObject.getTransform().forward;
        const originToPlane = interactable.sceneObject
            .getTransform()
            .getWorldPosition()
            .sub(origin);
        const originDotProduct = originToPlane.dot(normal);
        const directionDotProduct = direction.dot(normal);
        const parametricValue = originDotProduct / directionDotProduct;
        if (parametricValue >= 0) {
            return origin.add(direction.uniformScale(parametricValue));
        }
        else {
            return null;
        }
    }
    /**
     * Projects the direct collider's position onto the plane defined by the Interactable's forward vector / origin
     * @param interactable - the Interactable used to define the plane of intersection
     * @returns the direct collider's position projected onto the plane
     */
    colliderPlaneIntersection(interactable) {
        const origin = this.startPoint;
        if (origin === null || interactable === null) {
            return null;
        }
        // This logic uses the equation of t = ((p0-l0)·n)/(l·n) with l0 + l*t = the point of intersection.
        // l0 represents ray origin, l represents direction, p0 represents plane origin, and n represents the plane normal.
        const normal = interactable.sceneObject.getTransform().forward;
        const originToPlane = interactable.sceneObject
            .getTransform()
            .getWorldPosition()
            .sub(origin);
        const originDotProduct = originToPlane.dot(normal);
        const directionDotProduct = normal.dot(normal);
        const parametricValue = originDotProduct / directionDotProduct;
        return origin.add(normal.uniformScale(parametricValue));
    }
    __initialize() {
        super.__initialize();
        this.interactionManager = InteractionManager_1.InteractionManager.getInstance();
        this._dragProvider = new DragProvider_1.DragProvider(this.indirectDragThreshold);
        this._planecastDragProvider = new DragProvider_1.DragProvider(0);
        this.
        /**
         * Defines the interactor's input type. This can be used for prioritization
         * or for discerning controller vs hands.
         */
        inputType = Interactor_1.InteractorInputType.None;
        this.
        /**
         * Returns the current targeted interactable or null.
         */
        currentInteractable = null;
        this.
        /**
         * Returns the previous targeted interactable or null.
         */
        previousInteractable = null;
        this.onCurrentInteractableChangedEvent = new Event_1.default();
        this.
        /**
         * Called whenever the Interactor changes the target Interactable
         */
        onCurrentInteractableChanged = this.onCurrentInteractableChangedEvent.publicApi();
        this.
        /**
         * Returns the previous trigger value
         */
        previousTrigger = Interactor_1.InteractorTriggerType.None;
        this.
        /**
         * Returns the current trigger value
         */
        currentTrigger = Interactor_1.InteractorTriggerType.None;
        this.
        /**
         * Returns the current vector associated to a dragging
         * movement since the last frame, and null if not dragging
         */
        currentDragVector = null;
        this.
        /**
         * Returns the nullable drag vector, computed in the
         * previous frame
         */
        previousDragVector = null;
        this._previousStartPoint = null;
        this.enabled = true;
        this.
        /**
         * Notifies that the Interactor has changed target Interactable
         */
        currentInteractableChanged = () => {
            if (this.currentInteractable !== this.previousInteractable) {
                this.onCurrentInteractableChangedEvent.invoke(this.currentInteractable);
            }
        };
        this.transform = this.getTransform();
        this.interactionManager.registerInteractor(this);
    }
}
exports.default = BaseInteractor;
//# sourceMappingURL=BaseInteractor.js.map