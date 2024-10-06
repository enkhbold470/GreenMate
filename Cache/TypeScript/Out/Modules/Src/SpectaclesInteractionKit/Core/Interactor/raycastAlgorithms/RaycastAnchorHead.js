"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mathUtils_1 = require("../../../Utils/mathUtils");
const ContinousIrInteractionTransition_1 = require("./ContinousIrInteractionTransition");
const PinchJumpSuppressor_1 = require("./PinchJumpSuppressor");
const RaycastBase_1 = require("./RaycastBase");
const RgbIrTransitionJumpSuppressor_1 = require("./RgbIrTransitionJumpSuppressor");
const SwitchIrInteractionTransition_1 = require("./SwitchIrInteractionTransition");
const TAG = 'RaycastAnchorHead';
const farDirectionStartPointEnum = Object.freeze({
    CERVICAL_LINK: 'CervicalLink',
    EPAULET: 'Epaulet',
});
const highLowTargetingInputEnum = Object.freeze({
    HAND_PITCH: 'HandPitch',
    GAZE_PITCH: 'GazePitch',
});
const situationSpaceUpEnum = Object.freeze({
    WORLD_UP: 'WorldUp',
    DEVICE_UP: 'DeviceUp',
});
const situationSpaceForwardEnum = Object.freeze({
    WORLD_FORWARD: 'WorldForward',
    DEVICE_FORWARD: 'DeviceForward',
});
const RaycastAnchorHeadConfigDefault = {
    allowIrInteractionRotation: true,
    irInteractionTransitionMode: 'Continuous', //Continuous, Switch
    wristAmplificationForAnchorHead: 6.5,
    farDirectionStartPoint: 'CervicalLink', //CervicalLink, Epaulet
    cervicalLinkOffsetInDeviceSpace: new vec3(0, -7.5, 8),
    epauletOffsetInSituationSpace: new vec3(17.9, 0, 0),
    situationSpaceUp: 'WorldUp', //WorldUp, DeviceUp
    situationSpaceForward: 'DeviceForward', //WorldForward, DeviceForward
    epauletWeight: 1,
    extraXRotationDeg: 2,
    extraYRotationDeg: 3,
    facilitateHighLowTargeting: true,
    highLowTargetingInput: 'GazePitch', //HandPitch, GazePitch
    handPitchUpperThresholdPairHighDeg: 90,
    handPitchUpperThresholdPairLowDeg: 50,
    handPitchLowerThresholdPairHighDeg: 50,
    handPitchLowerThresholdPairLowDeg: 10,
    gazePitchUpperThresholdPairHighDeg: 90,
    gazePitchUpperThresholdPairLowDeg: 15,
    gazePitchLowerThresholdPairHighDeg: -20,
    gazePitchLowerThresholdPairLowDeg: -90,
    haloLevelYOffsetFromCervicalLinkInSituationSpace: 64.3,
    hipLevelYOffsetFromCervicalLinkInSituationSpace: -64.3,
    pinchJumpSuppressionEnabled: true,
    rgbIrTransitionJumpSuppressorEnabled: true,
};
/**
 * RaycastAnchorHead uses the Cervical Link location in device space to stabilize the ray, making it more tolerant to head movements.
 */
class RaycastAnchorHead extends RaycastBase_1.default {
    constructor(hand) {
        super(hand);
        this.config = RaycastAnchorHeadConfigDefault;
        this.extraXRotationRad = MathUtils.DegToRad * this.config.extraXRotationDeg;
        this.extraYRotationRad = MathUtils.DegToRad * this.config.extraYRotationDeg;
        this.irInteractionTransitionStrategy = this.config.allowIrInteractionRotation === true
            ? this.createIrInteractionTransitionStrategy()
            : undefined;
        this.pinchJumpSuppressor = this.config.pinchJumpSuppressionEnabled
            ? new PinchJumpSuppressor_1.PinchJumpSuppressor(hand)
            : null;
        this.rgbIrTransitionJumpSuppressor = this.config
            .rgbIrTransitionJumpSuppressorEnabled
            ? new RgbIrTransitionJumpSuppressor_1.default(hand)
            : null;
    }
    createIrInteractionTransitionStrategy() {
        const irInteractionTransitionMode = this.config.irInteractionTransitionMode;
        switch (irInteractionTransitionMode) {
            case 'Continuous': {
                return new ContinousIrInteractionTransition_1.default();
            }
            case 'Switch': {
                return new SwitchIrInteractionTransition_1.default();
            }
            default: {
                throw new Error(`${TAG}: No matching IrInteractionTransitionStrategy found, could not create strategy`);
            }
        }
    }
    /**
   * Computes the transform between world and Situation space
   */
    createTransformToWorldFromSituationBasedSpace(up, forward, cervicalLinkPos) {
        up = up.normalize();
        vec3.orthonormalize(up, forward);
        const right = up.cross(forward).normalize();
        const rotation = mat4.makeBasis(right, up, forward);
        const translation = mat4.fromTranslation(cervicalLinkPos);
        return translation.mult(rotation);
    }
    /**
   * Computes the Cervical Link position in world
   */
    computeCervicalLink(deviceCenterToWorld, deviceCenterInDeviceSpace) {
        const cervicalLinkInDeviceSpace = deviceCenterInDeviceSpace.add(this.config.cervicalLinkOffsetInDeviceSpace);
        return deviceCenterToWorld.multiplyPoint(cervicalLinkInDeviceSpace);
    }
    /**
   * Computes 'situation space' -> world space transformation.
   * 'Situation space' can be defined by using
   * the up vector of the world or the device and
   * the forward vector of the world or the device.
   * The center of this space is the user's Cervical Link.
   * The returned epaulet point is transformed to world.
   *
   * Recommended using: world's up and device's forward
   * This assures that the user's body rotates with the device around the Y axis
   * but won't be affected by head (device) rotation around its X and Z axes
   */
    computeTrasformToWorldFromSituationBasedSpace(deviceCenterToWorld, cervicalLinkInWorld) {
        let up = vec3.zero();
        if (this.config.situationSpaceUp === situationSpaceUpEnum.WORLD_UP) {
            up = vec3.up();
        }
        else {
            const deviceUpwardInWorld = deviceCenterToWorld.multiplyDirection(vec3.up());
            up = deviceUpwardInWorld;
        }
        let forward = vec3.zero();
        if (this.config.situationSpaceForward ===
            situationSpaceForwardEnum.WORLD_FORWARD) {
            forward = vec3.forward();
        }
        else {
            const deviceForwardInWorld = deviceCenterToWorld.multiplyDirection(vec3.forward());
            forward = deviceForwardInWorld;
        }
        const toWorldFromSituationSpace = this.createTransformToWorldFromSituationBasedSpace(up, forward, cervicalLinkInWorld);
        return toWorldFromSituationSpace;
    }
    /**
   * Computes the Epaulet position (point above shoulder) in world
   */
    computeEpaulet(toWorldFromSituationSpace) {
        const cervicalLinkInSituation = vec3.zero();
        const epauletOffsetInSituationSpace = new vec3(this.hand.handType === 'left'
            ? -this.config.epauletOffsetInSituationSpace.x
            : this.config.epauletOffsetInSituationSpace.x, this.config.epauletOffsetInSituationSpace.y, this.config.epauletOffsetInSituationSpace.z);
        const epauletInSituation = cervicalLinkInSituation.add(epauletOffsetInSituationSpace);
        return toWorldFromSituationSpace.multiplyPoint(epauletInSituation);
    }
    applyXRotation(vector, angleRad, toWorldFromSituationSpace) {
        const vector4d = new vec4(vector.x, vector.y, vector.z, 1);
        const situSpaceRight = toWorldFromSituationSpace.multiplyDirection(vec3.right());
        const rotQuat = quat.angleAxis(angleRad, situSpaceRight);
        const rotMat = mat4.compose(vec3.zero(), rotQuat, vec3.one());
        const vectorRotated4d = rotMat.multiplyVector(vector4d);
        return new vec3(vectorRotated4d.x, vectorRotated4d.y, vectorRotated4d.z);
    }
    applyYRotation(vector, angleRad, handType) {
        const vector4d = new vec4(vector.x, vector.y, vector.z, 1);
        const sign = handType === 'left' ? -1 : 1;
        const rotQuat = quat.angleAxis(sign * angleRad, vec3.up());
        const rotMat = mat4.compose(vec3.zero(), rotQuat, vec3.one());
        const vectorRotated4d = rotMat.multiplyVector(vector4d);
        return new vec3(vectorRotated4d.x, vectorRotated4d.y, vectorRotated4d.z);
    }
    determineHandPitchInRadians(wrist, index, middle) {
        if (!wrist || !index || !middle) {
            return 0;
        }
        const wristToIndex = index.sub(wrist);
        const wristToMiddle = middle.sub(wrist);
        const forward = wristToIndex.add(wristToMiddle);
        const forwardHoriz = Math.sqrt(forward.x * forward.x + forward.z * forward.z);
        return Math.atan2(forward.y, forwardHoriz);
    }
    determineGazePitchInRadians(rayAlgorithmData) {
        const forward = rayAlgorithmData.deviceCenterToWorld.multiplyDirection(vec3.back());
        const forwardHoriz = Math.sqrt(forward.x * forward.x + forward.z * forward.z);
        return Math.atan2(forward.y, forwardHoriz);
    }
    determineLowHighRatio(pitchRad, lowThresholdRad, highThresholdRad) {
        return MathUtils.clamp(MathUtils.remap(pitchRad, lowThresholdRad, highThresholdRad, 0, 1), 0, 1);
    }
    interpolateFarDirectionStartPoint(handPitch, lowThreshold, highThreshold, pointA, pointB) {
        const lowHighRatio = this.determineLowHighRatio(handPitch, lowThreshold, highThreshold);
        return (0, mathUtils_1.interpolateVec3)(pointA, pointB, lowHighRatio);
    }
    applyTargetingHeightControl(farDirectionStartPoint, rayAlgorithmData, toWorldFromSituationSpace) {
        const hipOffsetFromCervicalLinkInSituationSpace = new vec3(0, this.config.hipLevelYOffsetFromCervicalLinkInSituationSpace, 0);
        const haloOffsetFromCervicalLinkInSituationSpace = new vec3(0, this.config.haloLevelYOffsetFromCervicalLinkInSituationSpace, 0);
        const hipOffsetFromCervicalLinkInWorld = toWorldFromSituationSpace.multiplyDirection(hipOffsetFromCervicalLinkInSituationSpace);
        const haloOffsetFromCervicalLinkInWorld = toWorldFromSituationSpace.multiplyDirection(haloOffsetFromCervicalLinkInSituationSpace);
        const farDirectionStartPointHipLevel = farDirectionStartPoint.add(hipOffsetFromCervicalLinkInWorld);
        const farDirectionStartPointHaloLevel = farDirectionStartPoint.add(haloOffsetFromCervicalLinkInWorld);
        let pitchRad = 0;
        let upperThresholdPairHighRad = 0;
        let upperThresholdPairLowRad = 0;
        let lowerThresholdPairHighRad = 0;
        let lowerThresholdPairLowRad = 0;
        if (this.config.highLowTargetingInput === highLowTargetingInputEnum.HAND_PITCH) {
            pitchRad = this.determineHandPitchInRadians(rayAlgorithmData.wrist, rayAlgorithmData.index, rayAlgorithmData.mid);
            upperThresholdPairHighRad =
                MathUtils.RadToDeg * this.config.handPitchUpperThresholdPairHighDeg;
            upperThresholdPairLowRad =
                MathUtils.RadToDeg * this.config.handPitchUpperThresholdPairLowDeg;
            lowerThresholdPairHighRad =
                MathUtils.RadToDeg * this.config.handPitchLowerThresholdPairHighDeg;
            lowerThresholdPairLowRad =
                MathUtils.RadToDeg * this.config.handPitchLowerThresholdPairLowDeg;
        }
        else if (this.config.highLowTargetingInput === highLowTargetingInputEnum.GAZE_PITCH) {
            pitchRad = this.determineGazePitchInRadians(rayAlgorithmData);
            upperThresholdPairHighRad =
                MathUtils.RadToDeg * this.config.gazePitchUpperThresholdPairHighDeg;
            upperThresholdPairLowRad =
                MathUtils.RadToDeg * this.config.gazePitchUpperThresholdPairLowDeg;
            lowerThresholdPairHighRad =
                MathUtils.RadToDeg * this.config.gazePitchLowerThresholdPairHighDeg;
            lowerThresholdPairLowRad =
                MathUtils.RadToDeg * this.config.gazePitchLowerThresholdPairLowDeg;
        }
        const midThresholdRad = (upperThresholdPairLowRad + lowerThresholdPairHighRad) / 2;
        let farDirectionStartPointUpdated = vec3.zero();
        if (pitchRad > midThresholdRad) {
            farDirectionStartPointUpdated = this.interpolateFarDirectionStartPoint(pitchRad, upperThresholdPairLowRad, upperThresholdPairHighRad, farDirectionStartPoint, farDirectionStartPointHipLevel);
        }
        else {
            farDirectionStartPointUpdated = this.interpolateFarDirectionStartPoint(pitchRad, lowerThresholdPairLowRad, lowerThresholdPairHighRad, farDirectionStartPointHaloLevel, farDirectionStartPoint);
        }
        return farDirectionStartPointUpdated;
    }
    /** @inheritdoc */
    reset() {
        if (this.rgbIrTransitionJumpSuppressor) {
            this.rgbIrTransitionJumpSuppressor.reset();
        }
    }
    getRay() {
        var _a, _b;
        const data = this.getRayAlgorithmData();
        if (!data.thumb || !data.index || !data.mid || !data.wrist) {
            return null;
        }
        let locus = this.calculateInteractionLocus(data.thumb, data.index);
        const castAnchor = this.calculateCastAnchor(data.thumb, data.mid);
        const deviceCenterInDeviceSpace = vec3.zero();
        const cervicalLinkInWorld = this.computeCervicalLink(data.deviceCenterToWorld, deviceCenterInDeviceSpace);
        const toWorldFromSituationSpace = this.computeTrasformToWorldFromSituationBasedSpace(data.deviceCenterToWorld, cervicalLinkInWorld);
        let farDirectionStartPoint = vec3.zero();
        if (this.config.farDirectionStartPoint ===
            farDirectionStartPointEnum.CERVICAL_LINK) {
            farDirectionStartPoint = cervicalLinkInWorld;
        }
        else if (this.config.farDirectionStartPoint === farDirectionStartPointEnum.EPAULET) {
            const epauletInWorld = this.computeEpaulet(toWorldFromSituationSpace);
            farDirectionStartPoint = epauletInWorld
                .uniformScale(this.config.epauletWeight)
                .add(cervicalLinkInWorld.uniformScale(Math.max(1 - this.config.epauletWeight, 0)));
        }
        if (this.config.facilitateHighLowTargeting) {
            farDirectionStartPoint = this.applyTargetingHeightControl(farDirectionStartPoint, data, toWorldFromSituationSpace);
        }
        const farTargetingRay = castAnchor.sub(farDirectionStartPoint);
        const wristTargetingRay = castAnchor.sub(data.wrist);
        const closeTargetingRay = wristTargetingRay;
        let targetingRay = farTargetingRay.add(closeTargetingRay.uniformScale(this.config.wristAmplificationForAnchorHead));
        if (this.rgbIrTransitionJumpSuppressor) {
            this.rgbIrTransitionJumpSuppressor.update(targetingRay, locus);
            targetingRay =
                this.rgbIrTransitionJumpSuppressor.applyDirectionDelta(targetingRay);
            locus = this.rgbIrTransitionJumpSuppressor.applyLocusDelta(locus);
        }
        let smoothTargetingRay = this.directionOneEuroFilter.filter(targetingRay, getTime());
        let filteredLocus = this.locusOneEuroFilter.filter(locus, getTime());
        if (this.pinchJumpSuppressor) {
            this.pinchJumpSuppressor.updateState(this.pinchJumpSuppressor.knuckleSmoothingSpace === 'DeviceCenter'
                ? data.deviceCenterToWorld.inverse()
                : data.cameraToWorld.inverse());
            const rayData = this.pinchJumpSuppressor.applySuppression(smoothTargetingRay, filteredLocus);
            smoothTargetingRay = rayData.direction;
            filteredLocus = rayData.locus;
        }
        const irInteractionXRotationInRadians = (_b = (_a = this.irInteractionTransitionStrategy) === null || _a === void 0 ? void 0 : _a.computeXRotationInRadians(this.determineGazePitchInRadians(data), toWorldFromSituationSpace, filteredLocus)) !== null && _b !== void 0 ? _b : 0;
        let normalizedDirection = smoothTargetingRay.normalize();
        normalizedDirection = this.applyYRotation(this.applyXRotation(normalizedDirection, this.extraXRotationRad + irInteractionXRotationInRadians, toWorldFromSituationSpace).normalize(), this.extraYRotationRad, this.hand.handType).normalize();
        return {
            locus: filteredLocus,
            direction: normalizedDirection,
        };
    }
}
exports.default = RaycastAnchorHead;
//# sourceMappingURL=RaycastAnchorHead.js.map