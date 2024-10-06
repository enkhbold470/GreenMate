"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ScrollBar = void 0;
var __selfType = requireType("./ScrollBar");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const Interactable_1 = require("../../Interaction/Interactable/Interactable");
const ScrollView_1 = require("../ScrollView/ScrollView");
const TAG = 'ScrollBar';
/*
 * ScrollBar handles the logic of passing information between ScrollView and the ScrollBar SceneObject/Interactable.
 */
let ScrollBar = class ScrollBar extends BaseScriptComponent {
    onAwake() {
        this.createEvent('OnStartEvent').bind(() => {
            this.transform = this.getSceneObject().getTransform();
            this.scrollView = this.findScrollView();
            this.scrollViewSceneObject = this.scrollView.getSceneObject();
            this.scrollViewScreenTransform = this.scrollViewSceneObject.getComponent('Component.ScreenTransform');
            this.interactable = this.setupInteractable();
            this.boundingHeight = this.calculateBoundingHeight();
            this.yOrigin = this.scrollViewSceneObject
                .getTransform()
                .getLocalPosition().y;
            this.setupScrollViewCallbacks();
            this.reset();
        });
    }
    setupInteractable() {
        const interactable = this.getSceneObject().getComponent(Interactable_1.Interactable.getTypeName());
        if (interactable === null) {
            throw new Error('ScrollBar requires an interactable to function.');
        }
        interactable.onDragStart((event) => {
            if (event.interactor.dragType === Interactor_1.DragType.Touchpad) {
                this.touchpadDragUpdate(event);
            }
            else {
                this.sixDofDragUpdate(event);
            }
        });
        interactable.onDragUpdate((event) => {
            if (event.interactor.dragType === Interactor_1.DragType.Touchpad) {
                this.touchpadDragUpdate(event);
            }
            else {
                this.sixDofDragUpdate(event);
            }
        });
        interactable.enableInstantDrag = true;
        return interactable;
    }
    setupScrollViewCallbacks() {
        this.scrollView.onReady.add(() => {
            this.reset();
        });
        this.scrollView.onScrollUpdate.add((event) => {
            this.onScroll(event);
        });
        this.scrollView.onSnapUpdate.add((event) => {
            this.onScroll(event);
        });
    }
    onScroll(event) {
        // If there is no overflow, don't move ScrollBar at all.
        if (this.overflow <= 0) {
            return;
        }
        const position = this.transform.getLocalPosition();
        position.y =
            this.yOrigin +
                MathUtils.lerp(this.boundingHeight, -this.boundingHeight, this.scrollPercentage);
        this.transform.setLocalPosition(position);
    }
    calculateBoundingHeight() {
        var _a, _b;
        const scrollViewHeight = this.scrollView.scrollAreaSize.y;
        /**
       *  aabbMax returns the maximum value along one side of an axis, unrotated/unscaled.
       * If aabbMax.x = 10 units, then the actual x-length of the mesh (before scaling) is 20 units.
       */
        let aabb = (_b = (_a = this.scrollBarMeshVisual) === null || _a === void 0 ? void 0 : _a.mesh.aabbMax) !== null && _b !== void 0 ? _b : vec3.zero();
        // In the case that the mesh is scaled/rotated, transform the AABB dimensions.
        aabb = this.getTransform().getWorldScale()
            .scale(aabb);
        aabb = this.getSceneObject()
            .getTransform()
            .getWorldRotation()
            .multiplyVec3(aabb);
        const localAabb = this.scrollViewSceneObject
            .getTransform()
            .getInvertedWorldTransform()
            .multiplyDirection(aabb);
        const boundingHeight = scrollViewHeight / 2 - localAabb.y - this.boundingHeightOffset;
        if (boundingHeight <= 0) {
            this.log.e('Bounding height of the ScrollBar is negative. Reduce the boundingHeightOffset parameter for proper ScrollBar behavior.');
        }
        return boundingHeight;
    }
    touchpadDragUpdate(event) {
        const deltaY = event.dragVector.y;
        const newPercentage = this.scrollPercentage - deltaY / (this.boundingHeight * 2);
        if (newPercentage < 0 || newPercentage > 1) {
            this.scrollToEdge(newPercentage < 0);
            return;
        }
        this.scrollView.scrollBy(new vec2(0, deltaY * this.scrollRatio));
    }
    sixDofDragUpdate(event) {
        if (event.interactor.planecastPoint !== null &&
            event.planecastDragVector !== null) {
            const newDragPoint = event.interactor.planecastPoint;
            const deltaY = this.localizeDragVector(event.planecastDragVector).y;
            if (this.scrollViewScreenTransform.worldPointToLocalPoint(newDragPoint).y >=
                1) {
                this.scrollToEdge(true);
                return;
            }
            if (this.scrollViewScreenTransform.worldPointToLocalPoint(newDragPoint).y <=
                -1) {
                this.scrollToEdge(false);
                return;
            }
            const newPercentage = this.scrollPercentage - deltaY / (this.boundingHeight * 2);
            if (newPercentage < 0 || newPercentage > 1) {
                this.scrollToEdge(newPercentage < 0);
                return;
            }
            this.scrollView.scrollBy(new vec2(0, deltaY * this.scrollRatio));
        }
    }
    get scrollRatio() {
        return -this.overflow / (this.boundingHeight * 2);
    }
    localizeDragVector(dragVector) {
        const transform = this.scrollViewSceneObject.getTransform();
        const localXAxis = transform.getWorldRotation().multiplyVec3(vec3.right());
        const localYAxis = transform.getWorldRotation().multiplyVec3(vec3.up());
        const localizedX = localXAxis.dot(dragVector) / transform.getWorldScale().x;
        const localizedY = localYAxis.dot(dragVector) / transform.getWorldScale().y;
        return new vec2(localizedX, localizedY);
    }
    scrollToEdge(topEdge) {
        const adjustedPercentage = topEdge
            ? this.scrollPercentage
            : -(1 - this.scrollPercentage);
        this.scrollView.scrollBy(new vec2(0, -adjustedPercentage * this.overflow));
    }
    // Search through the siblings of this SceneObject to allow for the script instantiation use case.
    findScrollView() {
        var _a;
        const parent = this.getSceneObject().getParent();
        const children = (_a = parent === null || parent === void 0 ? void 0 : parent.children) !== null && _a !== void 0 ? _a : null;
        if (children === null) {
            throw new Error('Sibling SceneObject with ScrollView component not found. Ensure that the ScrollView owner is a sibling of the ScrollBar owner.');
        }
        for (const child of children) {
            const scrollView = child.getComponent(ScrollView_1.ScrollView.getTypeName());
            if (scrollView !== null) {
                return scrollView;
            }
        }
        throw new Error('Sibling SceneObject with ScrollView component not found. Ensure that the ScrollView owner is a sibling of the ScrollBar owner.');
    }
    get scrollPercentage() {
        return this.scrollView.scrollPercentage;
    }
    get overflow() {
        return this.scrollView.overflow;
    }
    get scrollBarMeshVisual() {
        return this._scrollBarMeshVisual;
    }
    set scrollBarMeshVisual(mesh) {
        this._scrollBarMeshVisual = mesh;
        if (this.scrollView) {
            this.boundingHeight = this.calculateBoundingHeight();
        }
    }
    /**
     * @returns how far (in cm) the top edge of the ScrollBar mesh should sit from the edge of the canvas when at the top of the content.
     */
    get boundingHeightOffset() {
        return this._boundingHeightOffset;
    }
    /**
     * Sets the offset between the top edge of the mesh and the edge of the canvas.
     * @param offset - how far (in cm) the top edge of the ScrollBar mesh should sit from the edge of the canvas when at the top of the content.
     */
    set boundingHeightOffset(offset) {
        this._boundingHeightOffset = offset;
        if (this.scrollView) {
            this.boundingHeight = this.calculateBoundingHeight();
        }
    }
    get isEnabled() {
        return this.scrollBarMeshVisual.enabled;
    }
    set isEnabled(enabled) {
        this.scrollBarMeshVisual.enabled = enabled;
    }
    reset() {
        // If the ScrollView has not been found yet due to script execution ordering, then defer the reset for later.
        if (!this.scrollView) {
            return;
        }
        this.boundingHeight = this.calculateBoundingHeight();
        this.yOrigin = this.scrollViewSceneObject
            .getTransform()
            .getLocalPosition().y;
        const position = this.transform.getLocalPosition();
        position.y = this.yOrigin + this.boundingHeight;
        this.transform.setLocalPosition(position);
    }
    __initialize() {
        super.__initialize();
        this.log = new NativeLogger_1.default(TAG);
    }
};
exports.ScrollBar = ScrollBar;
exports.ScrollBar = ScrollBar = __decorate([
    component
], ScrollBar);
//# sourceMappingURL=ScrollBar.js.map