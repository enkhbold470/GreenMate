"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SIK = void 0;
const InteractionManager_1 = require("./Core/InteractionManager/InteractionManager");
const CursorControllerProvider_1 = require("./Providers/CursorControllerProvider/CursorControllerProvider");
const HandInputData_1 = require("./Providers/HandInputData/HandInputData");
const InteractionConfigurationProvider_1 = require("./Providers/InteractionConfigurationProvider/InteractionConfigurationProvider");
const SIKLogLevelProvider_1 = require("./Providers/InteractionConfigurationProvider/SIKLogLevelProvider");
const MobileInputData_1 = require("./Providers/MobileInputData/MobileInputData");
exports.SIK = new Proxy({}, {
    get: (target, prop) => {
        switch (prop) {
            case 'SIKLogLevelProvider':
                return SIKLogLevelProvider_1.default.getInstance();
            case 'InteractionConfiguration':
                return InteractionConfigurationProvider_1.InteractionConfigurationProvider.getInstance();
            case 'HandInputData':
                return HandInputData_1.HandInputData.getInstance();
            case 'MobileInputData':
                return MobileInputData_1.MobileInputData.getInstance();
            case 'InteractionManager':
                return InteractionManager_1.InteractionManager.getInstance();
            case 'CursorController':
                return CursorControllerProvider_1.CursorControllerProvider.getInstance();
            default:
                throw new Error(`Property ${String(prop)} does not exist on SIK API`);
        }
    },
});
//# sourceMappingURL=SIK.js.map