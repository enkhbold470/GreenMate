"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Singleton = void 0;
/**
 * @param constructor
 */
function Singleton(constructor) {
    let _instance = null;
    const newConstructor = function (...args) {
        if (!_instance) {
            _instance = new constructor(...args);
        }
        return _instance;
    };
    // Copy prototype so instanceof operator still works
    newConstructor.prototype = constructor.prototype;
    // Add the static `getInstance` method to the decorated class
    newConstructor.getInstance = function () {
        if (!_instance) {
            _instance = new constructor();
        }
        return _instance;
    };
    return newConstructor;
}
exports.Singleton = Singleton;
//# sourceMappingURL=Singleton.js.map