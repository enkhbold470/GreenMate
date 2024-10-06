"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.logWithTag = void 0;
const printFn = print;
const logWithTag = (tag) => (...args) => {
    let result = `${tag}:`;
    for (const arg of args) {
        result += ' ' + arg;
    }
    printFn(result);
};
exports.logWithTag = logWithTag;
//# sourceMappingURL=logger.js.map