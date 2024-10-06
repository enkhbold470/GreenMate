"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MobileRayProvider = void 0;
const SIK_1 = require("../../SIK");
const NativeLogger_1 = require("../../Utils/NativeLogger");
const TAG = 'MobileRayProvider';
const MOBILE_ROTATION = quat.angleAxis(Math.PI / 2, vec3.right());
/**
 * Constructs the {@link RaycastInfo} from the {@link MobileInputData} data.
 */
class MobileRayProvider {
    constructor() {
        // Native Logging
        this.log = new NativeLogger_1.default(TAG);
        this.mobileInputData = SIK_1.SIK.MobileInputData;
        this.raycastInfo = null;
    }
    /** @inheritdoc */
    getRaycastInfo() {
        var _a, _b, _c;
        if (this.mobileInputData.isAvailable()) {
            this.raycastInfo = {
                direction: (_b = (_a = this.mobileInputData.rotation) === null || _a === void 0 ? void 0 : _a.multiply(MOBILE_ROTATION).multiplyVec3(vec3.back())) !== null && _b !== void 0 ? _b : vec3.zero(),
                locus: (_c = this.mobileInputData.position) !== null && _c !== void 0 ? _c : vec3.zero(),
            };
        }
        else {
            this.log.d('Mobile ray provider could not get raycast info because mobile input data provider was not available.');
            this.raycastInfo = {
                direction: vec3.zero(),
                locus: vec3.zero(),
            };
        }
        return this.raycastInfo;
    }
    /** @inheritdoc */
    isAvailable() {
        return this.mobileInputData.isAvailable();
    }
    /** @inheritdoc */
    reset() { }
}
exports.MobileRayProvider = MobileRayProvider;
//# sourceMappingURL=MobileRayProvider.js.map