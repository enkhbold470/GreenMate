"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ScrollView = exports.EDGE_TYPE = exports.AXIS_DIRECTION = void 0;
var __selfType = requireType("./ScrollView");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const NativeLogger_1 = require("../../../Utils/NativeLogger");
const VisualBoundariesProvider_1 = require("./boundariesProvider/VisualBoundariesProvider");
const ScrollArea_1 = require("./ScrollArea");
const ScrollProvider_1 = require("./ScrollProvider");
exports.AXIS_DIRECTION = [-1, 0, 1];
exports.EDGE_TYPE = ['Content', 'ScrollLimit'];
const TAG = 'ScrollView';
/**
 * ScrollView will have two children:
 * - the content wrapper: created by ScrollView user
 * - scroll area: implemented internally by ScrollView
 * and not exposed to the user.
 *
 * To avoid issues related to
 * initialization order, we check the number of children
 * on StartEvent
 */
const EXPECTED_CHILDREN_COUNT = 2;
/**
 * ScrollView component
 */
let ScrollView = class ScrollView extends BaseScriptComponent {
    onAwake() {
        this.transform = this.sceneObject.getTransform();
        this.scrollArea = this.createScrollArea();
        this.scrollProvider = this.createScrollProvider(this.scrollArea);
        this.mask = this.sceneObject.createComponent('Component.MaskingComponent');
        this.defineScriptEvents();
    }
    onDestroy() {
        this.scrollArea.destroy();
    }
    createScrollArea() {
        const scrollArea = new ScrollArea_1.ScrollArea({
            debugDrawEnabled: this.debugDrawEnabled,
            parentSceneObject: this.sceneObject,
            scrollAreaBounds: this.scrollAreaBounds,
        });
        return scrollArea;
    }
    createScrollProvider(scrollArea) {
        const scrollProvider = new ScrollProvider_1.ScrollProvider({
            scrollArea: this.scrollArea.boundariesProvider,
            scrollLimit: this.scrollLimit,
            enableScrollInertia: this.enableScrollInertia,
            enableScrollLimit: this.enableScrollLimit,
            enableHorizontalScroll: this.enableHorizontalScroll,
            enableVerticalScroll: this.enableVerticalScroll,
            scrollView: this,
            screenTransform: this.sceneObject.getComponent('Component.ScreenTransform'),
            updateEvent: this.updateEvent,
        });
        scrollArea.onDragStart.add((event) => {
            this.processPlanecastDrag(event);
            this.processTouchpadDrag(event);
        });
        scrollArea.onDragUpdate.add((event) => {
            this.processPlanecastDrag(event);
            this.processTouchpadDrag(event);
        });
        scrollArea.onDragEnd.add((event) => {
            scrollProvider.onGrabEnd(event);
        });
        scrollArea.onTriggerStart.add((event) => {
            scrollProvider.onGrabStart(event);
        });
        return scrollProvider;
    }
    createContentBoundariesProvider() {
        if (this.sceneObject.getChildrenCount() !== EXPECTED_CHILDREN_COUNT) {
            throw new Error('ScrollView requires exactly one child that wraps the content');
        }
        let contentSceneObject;
        for (const child of this.sceneObject.children) {
            if (child !== this.scrollArea.getSceneObject()) {
                contentSceneObject = child;
            }
        }
        if (contentSceneObject === undefined) {
            throw new Error('Couldn\'t find content scene object among ScrollView children.');
        }
        return new VisualBoundariesProvider_1.VisualBoundariesProvider(contentSceneObject);
    }
    defineScriptEvents() {
        this.createEvent('OnDestroyEvent').bind(() => this.onDestroy());
        this.createEvent('OnStartEvent').bind(() => {
            this.contentBoundariesProvider = this.createContentBoundariesProvider();
            this.scrollProvider.setContent(this.contentBoundariesProvider);
            this.scrollProvider.snapToEdges({ x: -1, y: 1, type: 'Content' });
            this.scrollProvider.resetContentOrigin();
            // We recompute boundaries once more to ensure that the scroll limit anchor is set properly.
            this.scrollProvider.recomputeBoundaries();
        });
    }
    get onScrollUpdate() {
        return this.scrollProvider.onScrollUpdate;
    }
    get onSnapUpdate() {
        return this.scrollProvider.onSnapUpdate;
    }
    get onReady() {
        return this.scrollProvider.onReady;
    }
    get onFocusEnter() {
        return this.scrollArea.onFocusEnter;
    }
    get onFocusExit() {
        return this.scrollArea.onFocusExit;
    }
    get debugDrawEnabled() {
        return this._debugDrawEnabled;
    }
    set debugDrawEnabled(debugDrawEnabled) {
        if (debugDrawEnabled === this._debugDrawEnabled) {
            return;
        }
        this._debugDrawEnabled = debugDrawEnabled;
        this.scrollArea.debugDrawEnabled = debugDrawEnabled;
    }
    get enableScrollInertia() {
        return this._enableScrollInertia;
    }
    set enableScrollInertia(enableScrollInertia) {
        if (enableScrollInertia === this._enableScrollInertia) {
            return;
        }
        this._enableScrollInertia = enableScrollInertia;
        this.scrollProvider.enableScrollInertia = enableScrollInertia;
    }
    get scrollLimit() {
        return this._scrollLimit;
    }
    set scrollLimit(limit) {
        if (this._scrollLimit === limit) {
            return;
        }
        this._scrollLimit = limit;
        this.scrollProvider.scrollLimit = limit;
    }
    get contentPosition() {
        return this.scrollProvider.contentPosition;
    }
    set contentPosition(position) {
        this.scrollProvider.contentPosition = position;
    }
    /**
     * @returns the offset to each content edge and the ScrollArea in world units relative to the canvas' rotation.
     */
    get contentOffset() {
        return this.scrollProvider.convertLocalOffsetToParentOffset(this.scrollProvider.contentOffset);
    }
    /**
     * @returns the length of the content along the y-axis in local units relative to the ScrollView canvas.
     */
    get contentLength() {
        return this.scrollProvider.contentLength;
    }
    /**
     * @param length - the length of the content along the y-axis in local units relative to the ScrollView canvas.
     */
    set contentLength(length) {
        if (length === this.scrollProvider.contentLength) {
            return;
        }
        this.scrollProvider.contentLength = length;
    }
    /**
     * Resets the content origin for the purpose of calculating scrollPercentage.
     * Assumes that the ScrollView is currently at the top of content in the pooling use case.
     */
    resetContentOrigin() {
        this.scrollProvider.resetContentOrigin();
    }
    /**
     * @returns the ScrollArea's size in local units relative to the ScrollView canvas.
     */
    get scrollAreaSize() {
        return this.scrollProvider.convertLocalUnitsToParentUnits(this.scrollArea.boundariesProvider.size);
    }
    /**
     * @returns the ScrollArea collider's BoxShape's bounds.
     */
    get scrollColliderBounds() {
        return this.scrollArea.scrollColliderBounds;
    }
    /**
     * @param bounds - the ScrollArea collider's BoxShape's bounds.
     */
    set scrollColliderBounds(bounds) {
        this.scrollArea.scrollColliderBounds = bounds;
    }
    /**
     * @returns the amount of content overflow along the y-axis in local units relative to the ScrollView's canvas.
     */
    get overflow() {
        return this.scrollProvider.overflow;
    }
    /**
     * @returns the scroll percentage of the ScrollView (0=top of ScrollView, 1= bottom).
     */
    get scrollPercentage() {
        return this.scrollProvider.scrollPercentage;
    }
    /**
     * Checks if both inputted content edges are fully visible in the ScrollArea.
     * @param xEdge - 0 if not checking any x-axis edge, 1 for right edge, -1 for left edge.
     * @param yEdge - 0 if not checking any y-axis edge, 1 for top edge, -1 for bottom edge.
     */
    checkContentEdgeFullyVisible(xEdge, yEdge) {
        return this.scrollProvider.checkContentEdgeFullyVisible(xEdge, yEdge);
    }
    localizeDragVector(dragVector) {
        const transform = this.sceneObject.getTransform();
        const localXAxis = transform.getWorldRotation().multiplyVec3(vec3.right());
        const localYAxis = transform.getWorldRotation().multiplyVec3(vec3.up());
        const localizedX = localXAxis.dot(dragVector) / transform.getWorldScale().x;
        const localizedY = localYAxis.dot(dragVector) / transform.getWorldScale().y;
        return new vec2(localizedX, localizedY);
    }
    localizeTouchpadVector(touchpadVector) {
        const screenTransform = this.sceneObject.getComponent('Component.ScreenTransform');
        // Mobile touchpad drag uses a screen space of [0,1], while screen transforms use a screen space of [-1,1]
        const touchpadVector2D = new vec2(touchpadVector.x * 2, touchpadVector.y * 2);
        const origin = screenTransform.localPointToWorldPoint(vec2.zero());
        const worldSpaceVector = screenTransform
            .localPointToWorldPoint(touchpadVector2D)
            .sub(origin);
        return this.localizeDragVector(worldSpaceVector);
    }
    processPlanecastDrag(event) {
        if (event.planecastDragVector === null) {
            return;
        }
        const localDrag = this.localizeDragVector(event.planecastDragVector);
        this.scrollProvider.scrollBy(localDrag);
    }
    processTouchpadDrag(event) {
        var _a, _b;
        if (event.interactor.inputType === Interactor_1.InteractorInputType.Mobile) {
            const mobileInteractor = event.interactor;
            if (mobileInteractor.touchpadDragVector !== null) {
                const screenSpaceTouchpadDrag = (_b = (_a = mobileInteractor.touchpadDragVector) === null || _a === void 0 ? void 0 : _a.uniformScale(1 / mobileInteractor.touchpadScrollSpeed)) !== null && _b !== void 0 ? _b : vec3.zero();
                this.scrollProvider.scrollBy(this.localizeTouchpadVector(screenSpaceTouchpadDrag));
            }
        }
    }
    __initialize() {
        super.__initialize();
        this.log = new NativeLogger_1.default(TAG);
        this.updateEvent = this.createEvent('UpdateEvent');
        this.recomputeBoundaries = () => {
            if (!this.scrollProvider.isReady) {
                this.log.w('recomputeBoundaries called before OnStartEvent. Call ignored.');
            }
            else {
                this.scrollProvider.recomputeBoundaries();
            }
        };
        this.deferOnReady = (callback) => {
            if (!this.scrollProvider.isReady) {
                this.scrollProvider.onReady.add(callback);
            }
            else {
                callback();
            }
        };
        this.snapToEdges = (selectedEdges) => {
            this.deferOnReady(() => this.scrollProvider.snapToEdges(selectedEdges));
        };
        this.scrollBy = (dragVector) => {
            this.deferOnReady(() => this.scrollProvider.scrollBy(dragVector));
        };
    }
};
exports.ScrollView = ScrollView;
exports.ScrollView = ScrollView = __decorate([
    component
], ScrollView);
//# sourceMappingURL=ScrollView.js.map