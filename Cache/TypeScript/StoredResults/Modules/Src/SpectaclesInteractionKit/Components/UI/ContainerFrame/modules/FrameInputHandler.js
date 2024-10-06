"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FrameInputHandler = exports.Modes = void 0;
const InteractorCursor_1 = require("../../../../Components/Interaction/InteractorCursor/InteractorCursor");
const Event_1 = require("../../../../Utils/Event");
const NativeLogger_1 = require("../../../../Utils/NativeLogger");
const TAG = 'FrameInputController';
const log = new NativeLogger_1.default(TAG);
/**
 *
 * Container Frame Input Modes
 * Auto ( no explicit mode )
 * Scaling ( with corners defined )
 * Rotating
 * Translating
 *
 */
var Modes;
(function (Modes) {
    Modes["Auto"] = "auto";
    Modes["ScaleTopLeft"] = "scaleTopLeft";
    Modes["ScaleBottomRight"] = "scaleBottomRight";
    Modes["ScaleTopRight"] = "scaleTopRight";
    Modes["ScaleBottomLeft"] = "scaleBottomLeft";
    Modes["Translating"] = "translating";
})(Modes || (exports.Modes = Modes = {}));
// affects speed of scaling
const SCALE_AMPLIFIER = 0.2;
class FrameInputHandler {
    constructor(options) {
        var _a, _b;
        this.options = options;
        /**
       *
       * This class takes the inputs from the raycaster
       * and uses it to control the frame manipulations
       * as well as provide that information to visual affordances
       *
       */
        this.edge = 0.5;
        this.gutterSize = new vec2(0.08, 0.08);
        this.allowScaling = this.options.allowScaling;
        this.allowScalingTopLeft = (_a = this.options.allowScalingTopLeft) !== null && _a !== void 0 ? _a : true;
        this.allowScalingTopRight = (_b = this.options.allowScalingTopRight) !== null && _b !== void 0 ? _b : true;
        this.corner = new vec2(1, 1);
        this.aspect = new vec2(1, 1);
        this.frame = this.options.frame;
        this.parentTransform = this.options.parentTransform;
        this.manipulate = this.options.manipulate;
        this.target = this.options.target;
        this.targetTransform = this.target.getTransform();
        this.targetWorldScaleCache = this.targetTransform.getWorldScale();
        this.lastTouch = vec3.zero();
        this.lastHovered = false;
        this.scalingStarted = false;
        this.cursorHandler = this.options.cursorHandler;
        this.mode = Modes.Auto;
        this.state = {
            rotating: false,
            scaling: false,
            translating: false,
            ignoring: false,
            hoveringInteractable: false,
            interacting: false,
        };
        this.onTranslationStartEvent = new Event_1.default();
        /**
       * Callback for when translation begins
       *
       * NOTE: The reason we need to add this event in FrameInputHandler, instead of relying on the container frame's
       * internal InteractableManipulation component is because the way this class keeps track of state means that
       * we don't set the InteractableManipulation's canTranslate property until after the user has started translating,
       * which has the effect of causing InteractableManipulation to NOT invoke the onTranslationStart event.
       */
        this.onTranslationStart = this.onTranslationStartEvent.publicApi();
        this.onTranslationEndEvent = new Event_1.default();
        /**
       * Callback for when translation ends
       */
        this.onTranslationEnd = this.onTranslationEndEvent.publicApi();
        this.minimumSize = this.targetWorldScaleCache.x > this.targetWorldScaleCache.y
            ? new vec2(3, (3 * this.targetWorldScaleCache.y) / this.targetWorldScaleCache.x)
            : new vec2((3 * this.targetWorldScaleCache.x) / this.targetWorldScaleCache.y, 3);
        this.maximumSize = this.targetWorldScaleCache.x > this.targetWorldScaleCache.y
            ? new vec2(400, (400 * this.targetWorldScaleCache.y) / this.targetWorldScaleCache.x)
            : new vec2((400 * this.targetWorldScaleCache.x) / this.targetWorldScaleCache.y, 400);
        this.update = (inputState) => {
            const touch = inputState.position;
            this.state.hoveringInteractable = false;
            if (touch.x < -this.edge + this.gutterSize.x &&
                touch.y < -this.edge + this.gutterSize.y &&
                this.allowScaling) {
                this.mode = Modes.ScaleBottomLeft;
            }
            else if (touch.x < -this.edge + this.gutterSize.x &&
                touch.y > this.edge - this.gutterSize.y &&
                this.allowScaling) {
                if (this.allowScalingTopLeft) {
                    this.mode = Modes.ScaleTopLeft;
                }
                else {
                    this.state.ignoring = true;
                }
            }
            else if (touch.x > this.edge - this.gutterSize.x &&
                touch.y < -this.edge + this.gutterSize.y &&
                this.allowScaling) {
                this.mode = Modes.ScaleBottomRight;
            }
            else if (touch.x > this.edge - this.gutterSize.x &&
                touch.y > this.edge - this.gutterSize.y &&
                this.allowScaling) {
                if (this.allowScalingTopRight) {
                    this.mode = Modes.ScaleTopRight;
                }
                else {
                    this.state.ignoring = true;
                }
            }
            else if (touch.x > this.edge - this.gutterSize.x) {
                // right edge
                this.mode = Modes.Translating;
            }
            else if (touch.x < -this.edge + this.gutterSize.x) {
                // left edge
                this.mode = Modes.Translating;
            }
            else if (touch.y < -this.edge + this.gutterSize.y) {
                // bottom edge
                this.mode = Modes.Translating;
            }
            else if (touch.y > this.edge - this.gutterSize.y) {
                // top edge
                this.mode = Modes.Translating;
            }
            else {
                // not in corner or on edge
                if (this.isInteractable === false) {
                    this.mode = Modes.Translating;
                }
                else if (!this.state.ignoring &&
                    !this.state.scaling &&
                    !this.state.translating) {
                    // hovering interactable
                    this.mode = Modes.Auto;
                    if (inputState.rawHovered) {
                        this.state.hoveringInteractable = true;
                    }
                    else {
                        this.state.hoveringInteractable = false;
                    }
                }
            }
            if (inputState.isPinching) {
                if (!this.state.ignoring &&
                    !this.state.scaling &&
                    !this.state.translating &&
                    !this.state.rotating &&
                    !this.state.interacting) {
                    // if pinching and not already in am ode
                    if (this.mode === Modes.ScaleBottomLeft) {
                        this.corner.x = -1;
                        this.corner.y = -1;
                        this.startScaling(touch);
                    }
                    else if (this.mode === Modes.ScaleTopLeft) {
                        this.corner.x = -1;
                        this.corner.y = 1;
                        this.startScaling(touch);
                    }
                    else if (this.mode === Modes.ScaleBottomRight) {
                        this.corner.x = 1;
                        this.corner.y = -1;
                        this.startScaling(touch);
                    }
                    else if (this.mode === Modes.ScaleTopRight) {
                        this.corner.x = 1;
                        this.corner.y = 1;
                        this.startScaling(touch);
                    }
                    else if (this.mode === Modes.Translating) {
                        this.setStateTranslating(true);
                    }
                    else {
                        // touching but not in corner or on edge
                        if (this.isInteractable === false) {
                            // content is not interactable, activating translation
                            this.setStateTranslating(true);
                        }
                        else {
                            // content is interactable
                            this.state.interacting = true;
                        }
                    }
                }
            }
            else {
                if (this.state.scaling) {
                    // end scaling
                    this.frame.onScalingEnd.invoke();
                }
                this.setStateTranslating(false);
                this.state.scaling = false;
                this.state.rotating = false;
                this.state.ignoring = false;
                this.state.interacting = false;
                this.lastTouch = vec3.zero();
            }
            if (this.frame.allowTranslation) {
                this.manipulate.setCanTranslate(this.state.translating);
            }
            //
            // handle cursor swaps
            if (!this.state.scaling || !this.state.translating) {
                if (!this.state.interacting) {
                    if (this.mode === Modes.ScaleBottomLeft ||
                        this.mode === Modes.ScaleTopRight) {
                        this.cursorHandler.mode = InteractorCursor_1.CursorMode.ScaleTopRight;
                    }
                    else if (this.mode === Modes.ScaleBottomRight ||
                        this.mode === Modes.ScaleTopLeft) {
                        this.cursorHandler.mode = InteractorCursor_1.CursorMode.ScaleTopLeft;
                    }
                    else if (this.mode === Modes.Translating) {
                        this.cursorHandler.mode = InteractorCursor_1.CursorMode.Translate;
                    }
                    else {
                        this.cursorHandler.mode = InteractorCursor_1.CursorMode.Auto;
                    }
                }
                if (this.state.scaling) {
                    const scaleAmount = inputState.drag.x * this.corner.x + inputState.drag.y * this.corner.y;
                    const currentScale = this.frame.innerSize;
                    if (currentScale.x > currentScale.y) {
                        this.aspect.x = 1;
                        this.aspect.y = currentScale.y / currentScale.x;
                    }
                    else {
                        this.aspect.x = currentScale.x / currentScale.y;
                        this.aspect.y = 1;
                    }
                    let addScale = new vec2(scaleAmount * this.scaleAmplifier, scaleAmount * this.scaleAmplifier);
                    addScale = addScale.mult(this.aspect);
                    const newScale = currentScale.add(addScale);
                    if (newScale.x > this.minimumSize.x &&
                        newScale.y > this.minimumSize.y &&
                        newScale.x < this.maximumSize.x &&
                        newScale.y < this.maximumSize.y) {
                        this.frame.innerSize = new vec2(newScale.x, newScale.y);
                    }
                }
                else {
                    this.lastTouch = vec3.zero();
                }
                if (this.lastHovered === false && inputState.isHovered) {
                    inputState.isHovered = false;
                }
                if (this.lastHovered === true && !inputState.isHovered) {
                    inputState.isHovered = true;
                }
                this.lastHovered = false;
            }
        };
        this.startScaling = (touchPosition) => {
            this.lastTouch = touchPosition;
            this.state.scaling = true;
            this.frame.onScalingStart.invoke();
        };
        if (this.options.minimumSize) {
            this.minimumSize = this.options.minimumSize;
        }
        if (this.options.maximumSize) {
            this.maximumSize = this.options.maximumSize;
        }
    }
    /*
   * Helper for programatic components
   */
    get isInteractable() {
        return this.options.isInteractable;
    }
    get scaleAmplifier() {
        var _a;
        return (_a = this.options.scaleSpeed) !== null && _a !== void 0 ? _a : SCALE_AMPLIFIER;
    }
    setStateTranslating(isTranslating) {
        if (isTranslating === this.state.translating) {
            return;
        }
        this.state.translating = isTranslating;
        this.state.translating
            ? this.onTranslationStartEvent.invoke()
            : this.onTranslationEndEvent.invoke();
    }
}
exports.FrameInputHandler = FrameInputHandler;
//# sourceMappingURL=FrameInputHandler.js.map