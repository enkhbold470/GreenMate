"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SnappableBehavior = void 0;
const animate_1 = require("../../../../Utils/animate");
const Event_1 = require("../../../../Utils/Event");
const NativeLogger_1 = require("../../../../Utils/NativeLogger");
const Interactor_1 = require("../../../../Core/Interactor/Interactor");
const SIK_1 = require("../../../../SIK");
const ContainerFrame_1 = require("../ContainerFrame");
const TAG = 'SnappableBehavior';
const log = new NativeLogger_1.default(TAG);
// A variable for 'up' (but not exactly up) We can't have it be exactly up because when
// we do a cross to get our angles and our raycast result points straiught up we cross two
// vectors that are the same and it won't give us a sane result
const NOT_QUITE_UP = new vec3(0.0000001, 0.9999999, 0.0000001).normalize();
/*
 * Class for the snapping behavior of quickview items
 * Specifically implemented for 2D content... so far!
 *
 */
class SnappableBehavior {
    get getAspectRatio() {
        return this.aspectRatio;
    }
    constructor(options) {
        var _a;
        this.options = options;
        this.stickyZoneSize = 1;
        this.gutterSize = 4;
        this.ghostMaterial = requireAsset('../Materials/Ghost Material.mat');
        this.snappableDebugDraw = false;
        this.frame = this.options.frame;
        this.frameTransform = this.frame.getFrameObject().getTransform();
        this.content = this.frame.getTargetObject();
        this.parent = this.content.getParent();
        this.parentTransform = (_a = this.parent) === null || _a === void 0 ? void 0 : _a.getTransform();
        this.parentParent = this.parent
            ? this.parent.getParent()
            : null;
        this.contentTransform = this.content.getTransform();
        this.contentPosition = this.contentTransform.getWorldPosition();
        this.scale = this.contentTransform.getWorldScale();
        this.frameSceneObject = this.frame.getFrameObject();
        this.interactable = this.frame.getInteractable();
        this.manipulate = this.frame.getInteractableManipulation();
        this.animationCancelSet = new animate_1.CancelSet();
        this.aspectRatio = 1;
        this.isAspectRatioSet = false;
        this.ghost = global.scene.createSceneObject('Ghost');
        this.ghostTransform = this.ghost.getTransform();
        this.ghostImageComponent = this.ghost.createComponent('Image');
        this.itemSnapping = this.options.itemSnapping;
        this.boundingBox = global.scene.createSceneObject('boundingBox');
        this.boundingBoxTransform = this.boundingBox.getTransform();
        this.useConstantBoundingBoxPadding = true;
        this.snapTo = null;
        this.snapPosition = vec3.zero();
        this.colliderTransform = null;
        this.colliderPosition = vec3.zero();
        this.colliderRotation = quat.quatIdentity();
        this.colliderScale = vec3.zero();
        this.colliderAspectRatio = 1;
        this.itemSnappingRange = false;
        this.worldSnappingRange = false;
        this.isTweening = false;
        this.isActive = false;
        this.isEnabled = true;
        this.isScaling = false;
        this.wasScaling = false;
        this.scalingDebouncer = null;
        this.quatId = quat.quatIdentity();
        this.onSnappingComplete = new Event_1.default();
        this.snappingComplete = () => this.onSnappingComplete.publicApi();
        this.unSubscribeList = [];
        this.rightHand = SIK_1.SIK.HandInputData.getHand('right');
        this.leftHand = SIK_1.SIK.HandInputData.getHand('left');
        this.worldQueryAsset = null;
        this.hitTestSession = null;
        this.useWorldQuery = false;
        this.queryBuffer = [];
        this.queryBufferMaxLength = 20;
        this.lastIndexTipPosition = vec3.zero();
        this.lastIndexForward = vec3.forward();
        this.missedCount = 0;
        this.hitTestSessionStarted = false;
        this.worldQueryTweenCancel = new animate_1.CancelSet();
        this.enableWorldSnapping = (enable) => {
            if (enable) {
                if (this.worldQueryAsset === null) {
                    this.worldQueryAsset =
                        require('LensStudio:WorldQueryModule');
                    const sessionOptions = HitTestSessionOptions.create();
                    sessionOptions.filter = true;
                    this.hitTestSession =
                        this.worldQueryAsset.createHitTestSessionWithOptions(sessionOptions);
                    // turn off until used
                    this.hitTestSession.stop();
                }
            }
            this.useWorldQuery = enable;
        };
        this.enableItemSnapping = (enable) => {
            this.itemSnapping = enable;
        };
        this.scaleConstantBoundingBox = () => {
            // the padding of the constant size added to the bounding box
            const frameWorldScale = new vec2(this.frame.innerSize.x + this.frame.constantPadding.x + this.frame.border, this.frame.innerSize.y + this.frame.constantPadding.y + this.frame.border);
            const boxPadding = 10;
            const boxDepth = Math.max(Math.min((Math.max(frameWorldScale.x, frameWorldScale.y), 40)), 1);
            this.boundingBoxTransform.setWorldScale(new vec3(frameWorldScale.x + boxPadding, frameWorldScale.y + boxPadding, boxDepth));
        };
        this.setActive = (val) => {
            this.isActive = val;
        };
        this.setTweening = (val) => {
            this.isTweening = val;
        };
        this.setScaling = (val) => {
            this.isScaling = val;
        };
        this.deParent = () => {
            var _a, _b;
            if (((_a = this.parent) === null || _a === void 0 ? void 0 : _a.getParent()) !== this.parentParent) {
                (_b = this.parent) === null || _b === void 0 ? void 0 : _b.setParentPreserveWorldTransform(this.parentParent);
            }
            if (!isNull(this.ghost) && this.ghost.getParent() !== this.parent) {
                this.ghost.setParentPreserveWorldTransform(this.parent);
            }
        };
        this.abortTweening = () => {
            this.animationCancelSet.cancel();
            this.deParent();
            this.setTweening(false);
        };
        this.setAspectRatio = () => {
            // if not set
            const scale = new vec2(this.frame.innerSize.x +
                this.frame.constantPadding.x +
                this.frame.border * 2, this.frame.innerSize.y +
                this.frame.constantPadding.y +
                this.frame.border * 2);
            this.aspectRatio = scale.x / scale.y;
            if (this.aspectRatio > 1) {
                scale.y *= this.aspectRatio;
                this.ghostImageComponent.mainMaterial.mainPass.boxSize = new vec2(0.5, 0.5 / this.aspectRatio);
            }
            else {
                scale.x /= this.aspectRatio;
                this.ghostImageComponent.mainMaterial.mainPass.boxSize = new vec2(0.5 * this.aspectRatio, 0.5);
            }
            this.ghostTransform.setWorldScale(new vec3(scale.x, scale.y, 1));
        };
        this.abortSnapping = () => {
            this.setActive(false);
            if (!isNull(this.ghost)) {
                this.ghost.enabled = false;
            }
            this.isEnabled = false;
            this.itemSnappingRange = false;
            this.worldSnappingRange = false;
        };
        this.onTriggerStart = (e) => {
            if (this.isTweening) {
                this.abortTweening();
            }
            if (!this.isTweening && !this.isScaling && !this.isActive) {
                this.setAspectRatio();
                if (this.useWorldQuery) {
                    this.queryBuffer = [];
                    this.hitTestSession.start();
                    this.hitTestSessionStarted = true;
                }
                this.setActive(true);
            }
            this.wasScaling = this.isScaling;
        };
        this.onTriggerRelease = (e) => {
            var _a, _b, _c, _d;
            if (this.useWorldQuery && this.hitTestSessionStarted) {
                this.hitTestSession.stop();
                this.hitTestSessionStarted = false;
            }
            if (this.isActive && !this.isScaling && this.isEnabled) {
                this.setActive(false);
                this.ghost.enabled = false;
                if (this.itemSnappingRange &&
                    !this.isTweening &&
                    ((_a = this.parent) === null || _a === void 0 ? void 0 : _a.getParent()) !== this.snapTo) {
                    this.setTweening(true);
                    this.itemSnappingRange = false;
                    (_b = this.parent) === null || _b === void 0 ? void 0 : _b.setParentPreserveWorldTransform(this.snapTo);
                    const startPosition = ((_c = this.parentTransform) === null || _c === void 0 ? void 0 : _c.getLocalPosition()) || vec3.zero();
                    (0, animate_1.default)({
                        cancelSet: this.animationCancelSet,
                        duration: 0.15,
                        start: 0,
                        end: 1,
                        ended: this.tweenCompleted,
                        update: (t) => {
                            var _a;
                            (_a = this.parentTransform) === null || _a === void 0 ? void 0 : _a.setLocalPosition((0, animate_1.mix)(startPosition, this.snapPosition, t));
                        },
                    });
                    const startRot = ((_d = this.parentTransform) === null || _d === void 0 ? void 0 : _d.getWorldRotation()) || quat.quatIdentity();
                    const endRot = this.snapTo.getTransform().getWorldRotation();
                    (0, animate_1.default)({
                        cancelSet: this.animationCancelSet,
                        duration: 0.14,
                        start: 0,
                        end: 1,
                        update: (t) => {
                            var _a;
                            (_a = this.parentTransform) === null || _a === void 0 ? void 0 : _a.setWorldRotation((0, animate_1.mix)(startRot, endRot, t));
                        },
                    });
                }
                else if (this.worldSnappingRange && !this.isTweening) {
                    this.setTweening(true);
                    this.worldSnappingRange = false;
                    const startPosition = this.parentTransform.getWorldPosition();
                    (0, animate_1.default)({
                        cancelSet: this.animationCancelSet,
                        duration: 0.15,
                        start: 0,
                        end: 1,
                        ended: this.tweenCompleted,
                        update: (t) => {
                            this.parentTransform.setWorldPosition((0, animate_1.mix)(startPosition, this.colliderPosition, t));
                        },
                    });
                    const startRot = this.parentTransform.getWorldRotation();
                    const endRot = this.colliderRotation;
                    (0, animate_1.default)({
                        cancelSet: this.animationCancelSet,
                        duration: 0.14,
                        start: 0,
                        end: 1,
                        update: (t) => {
                            this.parentTransform.setWorldRotation((0, animate_1.mix)(startRot, endRot, t));
                        },
                    });
                }
            }
            this.wasScaling = false;
        };
        this.queryWorld = () => {
            const rayLength = 300;
            const containerPosition = this.parentTransform.getWorldPosition();
            let indexTipPos, indexForward;
            let thisHand = this.rightHand;
            if (this.frame.currentInteractor.inputType === Interactor_1.InteractorInputType.RightHand) {
                thisHand = this.rightHand;
            }
            else if (this.frame.currentInteractor.inputType === Interactor_1.InteractorInputType.LeftHand) {
                thisHand = this.leftHand;
            }
            if (thisHand.isTracked() && thisHand.indexTip) {
                indexTipPos = thisHand.indexTip.position;
                this.lastIndexTipPosition = indexTipPos;
                indexForward = containerPosition.sub(indexTipPos).normalize();
                this.lastIndexForward = indexForward;
            }
            else {
                indexTipPos = this.lastIndexTipPosition;
                indexForward = this.lastIndexForward;
            }
            const endPos = indexTipPos.add(indexForward.uniformScale(rayLength));
            if (this.hitTestSessionStarted) {
                const hitTest = this.hitTestSession.hitTest(indexTipPos, endPos, (hitResult) => {
                    if (hitResult === null) {
                        // log.d("No Point of Collision")
                        this.missedCount += 1;
                        return;
                    }
                    else {
                        const hitPosition = hitResult.position;
                        const hitNormal = hitResult.normal;
                        const containerFromHit = containerPosition.distanceSquared(hitPosition);
                        if (containerFromHit > 2500) {
                            // more than 25 away from world mesh too far away
                            this.missedCount += 1;
                            return;
                        }
                        const indexDistance = indexTipPos.distance(hitPosition);
                        if (hitPosition === vec3.zero()) {
                            this.missedCount += 1;
                            return;
                        }
                        if (indexDistance < 20) {
                            // probably an error
                            this.missedCount += 1;
                            return;
                        }
                        this.queryBuffer.push({
                            distance: indexDistance,
                            hitPosition: hitPosition,
                            hitNormal: hitNormal,
                        });
                        if (this.queryBuffer.length === this.queryBufferMaxLength) {
                            let sumDist = 0;
                            let sumPosition = vec3.zero();
                            let sumNormal = vec3.zero();
                            this.queryBuffer.forEach((queryObj, i) => {
                                sumDist += queryObj.distance;
                                sumPosition = sumPosition.add(queryObj.hitPosition);
                                sumNormal = sumNormal.add(queryObj.hitNormal);
                            });
                            const avgPositon = sumPosition.uniformScale(1 / this.queryBuffer.length);
                            const avgNormal = sumNormal.uniformScale(1 / this.queryBuffer.length);
                            let toRotation;
                            if (avgNormal.y > 0.95) {
                                // log.d(`probably on the floor! or some`)
                                toRotation = quat.lookAt(avgNormal, this.frame.worldCamera.getTransform().back);
                            }
                            else {
                                // log.d(`probably on something else?`)
                                toRotation = quat.lookAt(avgNormal, NOT_QUITE_UP);
                            }
                            const ghostPos = this.ghostTransform.getWorldPosition();
                            const ghostRot = this.ghostTransform.getWorldRotation();
                            if (this.worldQueryTweenCancel)
                                this.worldQueryTweenCancel();
                            (0, animate_1.default)({
                                duration: 0.05,
                                cancelSet: this.worldQueryTweenCancel,
                                update: (t) => {
                                    this.ghostTransform.setWorldPosition(vec3.lerp(ghostPos, avgPositon, t));
                                    this.ghostTransform.setWorldRotation(quat.slerp(ghostRot, toRotation, t));
                                },
                            });
                            this.colliderPosition = avgPositon;
                            this.colliderRotation = toRotation;
                            this.colliderScale = this.scale;
                            this.colliderAspectRatio = this.aspectRatio;
                            this.worldSnappingRange = true;
                            this.queryBuffer.shift();
                            this.missedCount = 0;
                        }
                        else {
                            this.worldSnappingRange = false;
                            this.missedCount = 0;
                        }
                    }
                });
            }
            if (this.missedCount >= 20)
                this.worldSnappingRange = false;
        };
        this.calculateItemSnapping = () => {
            if (this.ghost.getParent() !== this.snapTo) {
                this.ghost.setParentPreserveWorldTransform(this.snapTo);
            }
            this.contentPosition = this.contentTransform
                .getWorldPosition()
                .sub(this.colliderPosition);
            this.scale = this.contentTransform.getWorldScale();
            this.contentPosition = this.colliderRotation.multiplyVec3(this.contentPosition);
            const snapToScalar = this.snapTo.getTransform().getWorldScale();
            // assuming height of 1
            const halfThisImageScale = {
                x: (this.frame.innerSize.x * 0.5 +
                    this.frame.constantPadding.x * 0.5 +
                    this.frame.border) /
                    snapToScalar.x,
                y: (this.frame.innerSize.y * 0.5 +
                    this.frame.constantPadding.y * 0.5 +
                    this.frame.border) /
                    snapToScalar.y,
            };
            const halfColliderImageScale = {
                x: (this.colliderScale.x * 0.5) / snapToScalar.x,
                y: (this.colliderScale.y * 0.5) / snapToScalar.y,
            };
            let xOffset = 0;
            let yOffset = 0;
            if (Math.abs(this.contentPosition.x) >= Math.abs(this.contentPosition.y)) {
                // snap to left or right
                xOffset =
                    halfColliderImageScale.x +
                        halfThisImageScale.x +
                        this.gutterSize / snapToScalar.x;
                if (this.contentPosition.x > 0) {
                    this.snapPosition.x = xOffset;
                }
                else {
                    this.snapPosition.x = -xOffset;
                }
                if (Math.abs(this.contentPosition.y) < this.stickyZoneSize) {
                    // in sticky center
                    this.snapPosition.y = 0;
                }
                else if (Math.abs(this.contentPosition.y +
                    halfThisImageScale.y -
                    halfColliderImageScale.y) < this.stickyZoneSize) {
                    // at top
                    this.snapPosition.y = halfColliderImageScale.y - halfThisImageScale.y;
                }
                else if (Math.abs(this.contentPosition.y -
                    halfThisImageScale.y +
                    halfColliderImageScale.y) < this.stickyZoneSize) {
                    // at bottom
                    this.snapPosition.y = -halfColliderImageScale.y + halfThisImageScale.y;
                }
                else {
                    // sliding
                    this.snapPosition.y = this.contentPosition.y;
                }
                this.snapPosition.y /= snapToScalar.y;
            }
            else {
                // snap to top or bottom
                yOffset =
                    halfColliderImageScale.y +
                        halfThisImageScale.y +
                        this.gutterSize / snapToScalar.y;
                if (this.contentPosition.y > 0) {
                    this.snapPosition.y = yOffset;
                }
                else {
                    this.snapPosition.y = -yOffset;
                }
                if (Math.abs(this.contentPosition.x) < this.stickyZoneSize) {
                    // in sticky center
                    this.snapPosition.x = 0;
                }
                else if (Math.abs(this.contentPosition.x +
                    halfThisImageScale.x -
                    halfColliderImageScale.x) < this.stickyZoneSize) {
                    // at right
                    this.snapPosition.x = halfColliderImageScale.x - halfThisImageScale.x;
                }
                else if (Math.abs(this.contentPosition.x -
                    halfThisImageScale.x +
                    halfColliderImageScale.x) < this.stickyZoneSize) {
                    // at left
                    this.snapPosition.x = -halfColliderImageScale.x + halfThisImageScale.x;
                }
                else {
                    // sliding
                    this.snapPosition.x = this.contentPosition.x;
                }
                this.snapPosition.x /= snapToScalar.x;
            }
            this.snapPosition.z = 0;
            // scale snap positioning for local space w/in the collider
            // this.snapPosition = this.snapPosition.div(this.colliderScale)
            // ghost temporarily parented to snapTo object
            this.ghostTransform.setLocalRotation(this.quatId);
            this.ghostTransform.setLocalPosition(this.snapPosition);
            if (!this.ghost.enabled)
                this.ghost.enabled = true;
        };
        this.update = () => {
            if (this.isActive &&
                !this.isScaling &&
                this.isEnabled &&
                !this.frame.isFollowing) {
                if (this.itemSnappingRange) {
                    this.calculateItemSnapping();
                }
                else if (this.useWorldQuery) {
                    this.queryWorld();
                }
                else if (!this.worldSnappingRange) {
                    // if not in snapping range
                    if (!this.isTweening && this.content.getParent() !== this.parent) {
                        this.deParent();
                    }
                    if (this.ghost.enabled)
                        this.ghost.enabled = false;
                }
                // confirm ghost
                if (this.worldSnappingRange) {
                    if (!this.ghost.enabled)
                        this.ghost.enabled = true;
                }
            }
            else {
                if (this.ghost.enabled)
                    this.ghost.enabled = false;
                if (!this.isTweening && this.content.getParent() !== this.parent) {
                    this.deParent();
                }
            }
            if (this.tryingSnap) {
                if (this.lastEvent)
                    this.onTriggerRelease(this.lastEvent);
                this.tryingSnap = false;
                this.lastEvent = null;
            }
            if (!this.worldSnappingRange && !this.itemSnappingRange) {
                if (this.ghost.enabled)
                    this.ghost.enabled = false;
                this.ghostTransform.setWorldPosition(this.frame.parentTransform.getWorldPosition());
                this.ghostTransform.setWorldRotation(this.frame.parentTransform.getWorldRotation());
            }
        };
        this.checkItemOverlaps = (e) => {
            this.lastEvent = e;
            if (this.isActive &&
                !this.isScaling &&
                !this.isTweening &&
                !this.frame.isFollowing &&
                this.itemSnapping &&
                this.isEnabled) {
                let lastDistance = Infinity;
                for (let i = 0; i < e.currentOverlaps.length; i++) {
                    const overlap = e.currentOverlaps[i];
                    const colliderObject = overlap.collider
                        .getSceneObject()
                        .getParent()
                        .getParent();
                    // getParent of boundingBox
                    const colliderFrameComponent = colliderObject.getComponent(ContainerFrame_1.ContainerFrame.getTypeName());
                    if (isNull(colliderFrameComponent)) {
                        continue;
                    }
                    if (colliderFrameComponent.isSnappingActive() ||
                        colliderFrameComponent.isSnappingTweening()) {
                        continue;
                    }
                    if (colliderObject === this.parent) {
                        continue;
                    }
                    this.colliderTransform = colliderObject.getTransform();
                    const thisColliderPosition = this.colliderTransform.getWorldPosition();
                    const thisDistance = thisColliderPosition.distanceSquared(this.contentTransform.getWorldPosition());
                    if (thisDistance < lastDistance) {
                        this.snapTo = overlap.collider.getSceneObject().getParent();
                        this.colliderPosition = thisColliderPosition;
                        this.colliderScale = new vec3(colliderFrameComponent.innerSize.x +
                            colliderFrameComponent.constantPadding.x +
                            colliderFrameComponent.border * 2, colliderFrameComponent.innerSize.y +
                            colliderFrameComponent.constantPadding.y +
                            colliderFrameComponent.border * 2, 1);
                        this.colliderAspectRatio = this.colliderScale.y / this.colliderScale.x;
                        this.colliderRotation = this.colliderTransform.getWorldRotation();
                        this.colliderRotation.x *= -1;
                        this.colliderRotation.y *= -1;
                        this.colliderRotation.z *= -1;
                        this.itemSnappingRange = true;
                        lastDistance = thisDistance;
                    }
                }
            }
        };
        this.tryToSnap = () => {
            this.setActive(true);
            this.tryingSnap = true;
            if (this.lastEvent) {
                this.checkItemOverlaps(this.lastEvent);
            }
        };
        this.tweenCompleted = () => {
            // deparent when tween complete
            this.deParent();
            this.setTweening(false);
            this.onSnappingComplete.invoke();
        };
        this.onOverlapExit = (e) => {
            if (e.currentOverlaps.length === 0) {
                this.ghost.enabled = false;
                this.itemSnappingRange = false;
            }
        };
        if (options.worldSnapping) {
            this.enableWorldSnapping(true);
        }
        this.unSubscribeList.push(this.interactable.onTriggerStart.add(this.onTriggerStart));
        this.unSubscribeList.push(this.interactable.onTriggerEnd.add(this.onTriggerRelease));
        this.unSubscribeList.push(this.interactable.onTriggerCanceled.add(this.onTriggerRelease));
        const contentLocalScale = new vec3(this.frame.innerSize.x +
            this.frame.constantPadding.x +
            this.frame.border * 2, this.frame.innerSize.y +
            this.frame.constantPadding.y +
            this.frame.border * 2, 1);
        this.ghost.enabled = false;
        this.ghost.setParent(this.parent);
        this.ghostTransform = this.ghost.getTransform();
        this.ghostTransform.setLocalScale(contentLocalScale);
        this.ghostImageComponent.stretchMode = StretchMode.Stretch;
        this.ghostImageComponent.mainMaterial = this.ghostMaterial.clone();
        const ghostAlpha = 0.33;
        this.ghostImageComponent.mainMaterial.mainPass.baseColor.a = ghostAlpha;
        this.ghostImageComponent.mainPass.depthTest = true;
        this.ghostImageComponent.mainPass.depthWrite = true;
        this.ghostImageComponent.setRenderOrder(this.frame.renderOrder);
        this.boundingBox.setParent(this.content);
        this.boundingBox.layer = LayerSet.fromNumber(4);
        const boundingBoxFilter = Physics.Filter.create();
        boundingBoxFilter.onlyLayers = this.boundingBox.layer;
        const boundingBoxCollider = this.boundingBox.createComponent('ColliderComponent');
        const boxShape = Shape.createBoxShape();
        if (!this.useConstantBoundingBoxPadding) {
            // maximumDepthForBoundingBox
            const maxBoxDepth = 40;
            // amplifier for boxDepth
            const boxDepthScalar = 0.4;
            // amplifier for shapeSize
            const shapeScalar = 1.34;
            const frameWorldScale = new vec2(this.frame.innerSize.x +
                this.frame.constantPadding.x +
                this.frame.border, this.frame.innerSize.y +
                this.frame.constantPadding.y +
                this.frame.border);
            const boxSize = Math.max(frameWorldScale.x, frameWorldScale.y);
            const boxDepth = Math.max(Math.min(Math.max(boxSize, maxBoxDepth)), 1);
            this.boundingBoxTransform.setWorldScale(new vec3(frameWorldScale.x, frameWorldScale.y, boxDepth * boxDepthScalar));
            boxShape.size = vec3.one().uniformScale(shapeScalar);
        }
        else {
            boxShape.size = vec3.one();
        }
        boundingBoxCollider.shape = boxShape;
        boundingBoxCollider.filter = boundingBoxFilter;
        boundingBoxCollider.overlapFilter = boundingBoxFilter;
        boundingBoxCollider.debugDrawEnabled = this.snappableDebugDraw;
        const onOverlapEnterEvent = boundingBoxCollider.onOverlapEnter.add(this.checkItemOverlaps);
        const onOverlapStayEvent = boundingBoxCollider.onOverlapStay.add(this.checkItemOverlaps);
        const onOverlapExitEvent = boundingBoxCollider.onOverlapExit.add(this.onOverlapExit);
        this.unSubscribeList.push(() => {
            boundingBoxCollider.onOverlapEnter.remove(onOverlapEnterEvent);
        });
        this.unSubscribeList.push(() => {
            boundingBoxCollider.onOverlapStay.remove(onOverlapStayEvent);
        });
        this.unSubscribeList.push(() => {
            boundingBoxCollider.onOverlapExit.remove(onOverlapExitEvent);
        });
        if (this.useConstantBoundingBoxPadding) {
            this.unSubscribeList.push(this.frame.onScalingUpdateEvent.add(this.scaleConstantBoundingBox));
            this.scaleConstantBoundingBox();
        }
        this.unSubscribeList.push(this.frame.onScalingUpdateEvent.add(this.setAspectRatio));
        this.setAspectRatio();
    }
    destroy() {
        log.d('destroy');
        this.abortTweening();
        this.abortSnapping();
        this.unSubscribeList.forEach((sub) => {
            sub();
        });
    }
}
exports.SnappableBehavior = SnappableBehavior;
//# sourceMappingURL=SnappableBehavior.js.map