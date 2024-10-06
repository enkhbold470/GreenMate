"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CursorController = void 0;
var __selfType = requireType("./CursorController");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const InteractionManager_1 = require("../../../Core/InteractionManager/InteractionManager");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const SIK_1 = require("../../../SIK");
const InteractorCursor_1 = require("./InteractorCursor");
let CursorController = class CursorController extends BaseScriptComponent {
    onAwake() {
        const interactors = InteractionManager_1.InteractionManager.getInstance().getInteractorsByType(Interactor_1.InteractorInputType.All);
        interactors.forEach((interactor) => {
            const cursor = this.getSceneObject().createComponent(InteractorCursor_1.InteractorCursor.getTypeName());
            cursor.interactor = interactor;
        });
    }
    /**
   * @deprecated in favor of getCursorByInteractor
   * Gets the InteractorCursor for a specified interactor
   * @param interactor The interactor to get the cursor for
   * @returns the InteractorCursor for the requested interactor, or null if it doesn't exist
   */
    getCursor(interactor) {
        return this.cursorControllerProvider.getCursor(interactor);
    }
    /**
   * Gets the InteractorCursor for a specified interactor
   * @param interactor The interactor to get the cursor for
   * @returns the InteractorCursor for the requested interactor, or null if it doesn't exist
   */
    getCursorByInteractor(interactor) {
        return this.cursorControllerProvider.getCursorByInteractor(interactor);
    }
    /**
   * Gets the InteractorCursor for a specified input type
   * @param inputType The InteractorInputType to get the cursor for
   * @returns the InteractorCursor for the requested InteractorInputType, or null if it doesn't exist
   */
    getCursorByInputType(inputType) {
        return this.cursorControllerProvider.getCursorByInputType(inputType);
    }
    /**
   * Gets all InteractorCursors within the scene
   * @returns a list of InteractorCursors
   */
    getAllCursors() {
        return this.cursorControllerProvider.getAllCursors();
    }
    __initialize() {
        super.__initialize();
        this.cursorControllerProvider = SIK_1.SIK.CursorController;
    }
};
exports.CursorController = CursorController;
exports.CursorController = CursorController = __decorate([
    component
], CursorController);
//# sourceMappingURL=CursorController.js.map