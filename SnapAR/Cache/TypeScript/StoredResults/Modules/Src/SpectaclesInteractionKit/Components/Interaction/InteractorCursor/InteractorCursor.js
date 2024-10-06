"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.InteractorCursor = exports.CursorMode = void 0;
var __selfType = requireType("./InteractorCursor");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const CursorViewModel_1 = require("./CursorViewModel");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const SIK_1 = require("../../../SIK");
const Event_1 = require("../../../Utils/Event");
const LineRenderer_1 = require("../../../Utils/views/LineRenderer/LineRenderer");
const CircleVisual_1 = require("./CircleVisual");
var CursorMode;
(function (CursorMode) {
    CursorMode["Auto"] = "Auto";
    CursorMode["Translate"] = "Translate";
    CursorMode["ScaleTopLeft"] = "ScaleTopLeft";
    CursorMode["ScaleTopRight"] = "ScaleTopRight";
    CursorMode["Disabled"] = "Disabled";
    CursorMode["Custom"] = "Custom";
})(CursorMode || (exports.CursorMode = CursorMode = {}));
const TAG = 'InteractorCursor';
const LINE_VERTICES = 10;
const LINE_MIDPOINT = 0.7;
const DEFAULT_IDLE_OUTLINE_OFFSET = 0.0;
const DEFAULT_HOVER_OUTLINE_OFFSET = 0.1;
const DEFAULT_IDLE_SCALE = 1.0;
const DEFAULT_SQUISH_SCALE = 0.6;
const DEFAULT_IDLE_OUTLINE_ALPHA = 1.0;
const DEFAULT_HOVER_OUTLINE_ALPHA = 0.5;
const MESH_SCENE_OBJECT_INDEX = 0;
/*
 * InteractorCursor manages the behavior and visualization of the targeting position of the selected Interactor.
 */
let InteractorCursor = class InteractorCursor extends BaseScriptComponent {
    onAwake() {
        var _a;
        this.defineScriptEvents();
        this.visual = this.createVisual();
        this.circleVisualConfig = {
            meshSceneObject: this.visual,
            textures: {
                translate: requireAsset('./translate.png'),
                scaleTL: requireAsset('./scale-tl.png'),
                scaleTR: requireAsset('./scale-tr.png'),
                disabled: requireAsset('./disabled.png'),
            },
        };
        this.manipulateLineConfig = {
            points: [new vec3(0, 0, 0), new vec3(0, 100, 0)],
            material: requireAsset('./ManipulateLineMaterial.mat'),
            startWidth: 0.1,
            endWidth: 0.1,
            startColor: new vec4(1, 1, 1, 1),
            endColor: new vec4(1, 1, 1, 1),
            enabled: false,
        };
        this.circleVisual = new CircleVisual_1.CircleVisual(this.circleVisualConfig);
        this.manipulateLine = new LineRenderer_1.default(this.manipulateLineConfig);
        this.manipulateLine.getSceneObject().setParent(this.getSceneObject());
        this.viewModel = new CursorViewModel_1.CursorViewModel(this.enableCursorSnapping, this.enableFilter, (_a = this.interactor) !== null && _a !== void 0 ? _a : undefined);
        this.viewModel.onStateChange.add(this.onStateChange);
        this.viewModel.onCursorUpdate.add(this.onCursorUpdate);
        if (this._interactor !== undefined) {
            this.interactor = this._interactor;
        }
    }
    set interactor(interactor) {
        if (interactor === undefined) {
            throw Error('InteractorCursor cannot have an undefined Interactor reference.');
        }
        this._interactor = interactor;
        this.viewModel.setInteractor(interactor);
        this.cursorController.registerCursor(this);
        let handType;
        switch (interactor.inputType) {
            case Interactor_1.InteractorInputType.LeftHand:
                handType = 'left';
                break;
            case Interactor_1.InteractorInputType.RightHand:
                handType = 'right';
                break;
        }
        this.circleVisual.handType = handType;
    }
    get interactor() {
        return this._interactor;
    }
    /**
     * Programmatically instantiates the cursor visual
     * @returns The SceneObject for the cursor visual
     */
    createVisual() {
        const visual = global.scene.createSceneObject('CursorVisual');
        visual.setParent(this.getSceneObject());
        const visualMesh = visual.createComponent('Component.RenderMeshVisual');
        visualMesh.mesh = requireAsset('./Plane.mesh');
        visualMesh.mainMaterial = requireAsset('./Cursor.mat');
        return visual;
    }
    updateWorldCursor(data) {
        this.circleVisual.worldPosition = data.position;
        if (data.interactionStrength !== null) {
            this.circleVisual.circleSquishScale = MathUtils.lerp(DEFAULT_IDLE_SCALE, DEFAULT_SQUISH_SCALE, data.interactionStrength);
        }
        else {
            this.circleVisual.circleSquishScale = DEFAULT_IDLE_SCALE;
        }
        this.circleVisual.isTriggering = data.isTriggering;
        this.circleVisual.worldScale = vec3.one().uniformScale(data.scale);
    }
    /**
     * Get the world position of this interactor's cursor visual
     * @returns vec3 of the worldPosition
     */
    get cursorPosition() {
        return this.viewModel.cursorPosition;
    }
    /**
     * Set the world position of this interactor's cursor visual
     * @param position - vec3 of the worldPosition, null to revert to default behavior to follow raycast
     */
    set cursorPosition(position) {
        this.viewModel.positionOverride = position;
    }
    /**
     * Set the {@link CursorMode} of the cursor to change the visual
     * To return the cursor to its default {@link StateMachine} logic, use {@link CursorMode}.Auto
     * @param mode the new mode of the cursor visual
     */
    set cursorMode(mode) {
        this.circleVisual.cursorMode = mode;
    }
    /**
     * Set the {@link Texture} of the cursor when using the {@link CursorMode}.Custom mode
     * Must explicitly set the {@link CursorMode} to {@link CursorMode}.Custom before the texture appears.
     * @param texture the custom texture (typically cached via requireAsset(.../assetName.png) as Texture) to use
     */
    set customTexture(texture) {
        this.circleVisual.customTexture = texture;
    }
    /**
     * Set the render order of the cursor visual.
     */
    set renderOrder(renderOrder) {
        this.circleVisual.renderOrder = renderOrder;
    }
    updateManipulateLine(data) {
        this.manipulateLine.points = this.getCurvedLinePoints(data.origin, data.endPoint, data.delta);
    }
    defineScriptEvents() {
        this.createEvent('OnEnableEvent').bind(() => {
            this.onEnable();
        });
        this.createEvent('OnDisableEvent').bind(() => {
            this.onDisable();
        });
        this.createEvent('OnDestroyEvent').bind(() => {
            this.onDestroy();
        });
    }
    /**
     * Enable the cursor visual.
     */
    onEnable() {
        this.circleVisualEnabled = true;
    }
    /**
     * Disable the cursor visual.
     */
    onDisable() {
        this.circleVisualEnabled = false;
    }
    onDestroy() {
        this.visual.destroy();
    }
    /**
     * Creates the points of the curved line used for far field manipulation.
     * @param start - where the line starts
     * @param end - where the line ends
     * @param curveOffset - the vector that the line's midpoint will be offset by to create the curve
     * @returns an array of points along the curved line created from start to end.
     */
    getCurvedLinePoints(start, end, curveOffset) {
        let midPoint = vec3.lerp(start, end, LINE_MIDPOINT);
        if (curveOffset !== null) {
            midPoint = midPoint.add(curveOffset);
        }
        const points = [];
        for (let ratio = 0; ratio <= 1; ratio += 1 / LINE_VERTICES) {
            const tangent1 = vec3.lerp(start, midPoint, ratio);
            const tangent2 = vec3.lerp(midPoint, end, ratio);
            const curve = vec3.lerp(tangent1, tangent2, ratio);
            points.push(curve);
        }
        return points;
    }
    checkMultipleInteractorsActive() {
        const interactors = this.interactionManager.getInteractorsByType(Interactor_1.InteractorInputType.All);
        const activeInteractors = interactors.filter((interactor) => {
            return interactor.isActive() && interactor.isTargeting();
        });
        return activeInteractors.length > 1;
    }
    __initialize() {
        super.__initialize();
        this.circleVisualEnabled = true;
        this.interactionManager = SIK_1.SIK.InteractionManager;
        this.cursorController = SIK_1.SIK.CursorController;
        this.onEnableChangedEvent = new Event_1.default();
        this.
        /**
       * Called whenever the cursor changes enabled state (showing / hiding the cursor visual)
       */
        onEnableChanged = this.onEnableChangedEvent.publicApi();
        this.onStateChange = (state) => {
            switch (state) {
                case CursorViewModel_1.CursorState.Inactive:
                    // If the visual is already hidden, do not invoke the extra event.
                    if (this.circleVisual.isShown) {
                        this.onEnableChangedEvent.invoke(false);
                    }
                    this.circleVisual.isShown = false;
                    this.circleVisual.outlineOffset = DEFAULT_IDLE_OUTLINE_OFFSET;
                    break;
                case CursorViewModel_1.CursorState.Idle:
                    this.circleVisual.outlineAlpha = DEFAULT_IDLE_OUTLINE_ALPHA;
                    this.circleVisual.outlineOffset = DEFAULT_IDLE_OUTLINE_OFFSET;
                    break;
                case CursorViewModel_1.CursorState.Hovering:
                    this.circleVisual.outlineAlpha = DEFAULT_HOVER_OUTLINE_ALPHA;
                    this.circleVisual.outlineOffset = DEFAULT_HOVER_OUTLINE_OFFSET;
                    break;
            }
        };
        this.onCursorUpdate = (viewState) => {
            // If the script component has been disabled, do not show the cursor visual.
            const shouldShow = viewState.cursorEnabled && this.circleVisualEnabled;
            if (shouldShow !== this.circleVisual.isShown) {
                this.onEnableChangedEvent.invoke(shouldShow);
            }
            this.circleVisual.isShown = shouldShow;
            this.circleVisual.multipleInteractorsActive =
                this.checkMultipleInteractorsActive();
            this.manipulateLine.setEnabled(viewState.lineEnabled);
            if (viewState.cursorEnabled) {
                this.updateWorldCursor(viewState.cursorData);
            }
            if (viewState.lineEnabled) {
                this.updateManipulateLine(viewState.lineData);
            }
        };
    }
};
exports.InteractorCursor = InteractorCursor;
exports.InteractorCursor = InteractorCursor = __decorate([
    component
], InteractorCursor);
//# sourceMappingURL=InteractorCursor.js.map