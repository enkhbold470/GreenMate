"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CursorControllerProvider = void 0;
const Singleton_1 = require("../../Decorators/Singleton");
let CursorControllerProvider = class CursorControllerProvider {
    constructor() {
        this.cursors = new Map();
    }
    registerCursor(cursor) {
        if (cursor.interactor === undefined) {
            throw Error('InteractorCursor must have a set Interactor before registering to SIK.CursorController.');
        }
        if (this.cursors.has(cursor.interactor)) {
            throw Error('Multiple cursors for a single Interactor have been registered.\nThe CursorController and InteractorCursor components cannot both be present in the scene hierarchy before runtime, use one or the other.');
        }
        this.cursors.set(cursor.interactor, cursor);
    }
    /**
   * @deprecated in favor of getCursorByInteractor
   * Gets the InteractorCursor for a specified interactor
   * @param interactor The interactor to get the cursor for
   * @returns the InteractorCursor for the requested interactor, or null if it doesn't exist
   */
    getCursor(interactor) {
        return this.getCursorByInteractor(interactor);
    }
    /**
   * Gets the InteractorCursor for a specified interactor
   * @param interactor The interactor to get the cursor for
   * @returns the InteractorCursor for the requested interactor, or null if it doesn't exist
   */
    getCursorByInteractor(interactor) {
        var _a;
        return (_a = this.cursors.get(interactor)) !== null && _a !== void 0 ? _a : null;
    }
    /**
   * Gets the InteractorCursor for a specified input type
   * @param inputType The InteractorInputType to get the cursor for
   * @returns the InteractorCursor for the requested InteractorInputType, or null if it doesn't exist
   */
    getCursorByInputType(inputType) {
        let interactor;
        for (const mapInteractor of this.cursors.keys()) {
            if (mapInteractor.inputType === inputType) {
                interactor = mapInteractor;
                break;
            }
        }
        return interactor !== undefined
            ? this.getCursorByInteractor(interactor)
            : null;
    }
    /**
   * Gets all InteractorCursors within the scene
   * @returns a list of InteractorCursors
   */
    getAllCursors() {
        return Array.from(this.cursors.values());
    }
};
exports.CursorControllerProvider = CursorControllerProvider;
exports.CursorControllerProvider = CursorControllerProvider = __decorate([
    Singleton_1.Singleton
], CursorControllerProvider);
//# sourceMappingURL=CursorControllerProvider.js.map