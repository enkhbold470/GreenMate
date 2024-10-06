"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ScreenTransformAdapter = void 0;
var __selfType = requireType("./ScreenTransformAdapter");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let ScreenTransformAdapter = class ScreenTransformAdapter extends BaseScriptComponent {
    onAwake() {
        this.defineScriptEvents();
    }
    defineScriptEvents() {
        this.createEvent('OnStartEvent').bind(() => {
            this.init();
        });
    }
    init() {
        const sceneObject = this.getSceneObject();
        const transform = sceneObject.getTransform();
        const parent = sceneObject.getParent();
        if (isNull(parent)) {
            return;
        }
        if (!isNull(parent.getComponent('Component.Canvas')) ||
            !isNull(parent.getComponent('Component.ScreenTransform'))) {
            const canvas = sceneObject.getComponent('Component.Canvas');
            if (!isNull(canvas)) {
                const perservedPosition = transform.getLocalPosition();
                const perservedRotation = transform.getLocalRotation();
                const size = canvas.getSize();
                canvas.destroy();
                const screenTransform = sceneObject.createComponent('Component.ScreenTransform');
                screenTransform.anchors = Rect.create(0, 0, 0, 0);
                screenTransform.offsets.setSize(size);
                screenTransform.position = perservedPosition;
                screenTransform.rotation = perservedRotation;
            }
        }
    }
};
exports.ScreenTransformAdapter = ScreenTransformAdapter;
exports.ScreenTransformAdapter = ScreenTransformAdapter = __decorate([
    component
], ScreenTransformAdapter);
//# sourceMappingURL=ScreenTransformAdapter.js.map