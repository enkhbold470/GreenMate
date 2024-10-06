// Event: Lens Initialized
//@ui {"widget":"group_start", "label":"Objects"}
//@input Component.ScreenTransform pointScreenTransform
//@input Component.BaseMeshVisual touchZone
//@input Component.Camera camera
//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":"Values"}
//@input float minValue
//@input float maxValue
//@input bool usedStep
//@input float step {"showIf":"usedStep"}
//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":"Textures"}
//@input Asset.Texture white
//@input Asset.Texture color
//@input int sliderType = "0" {"widget":"combobox", "values":[{"label":"white", "value":"0"}, {"label":"color", "value":"1"}]}
//@ui {"widget":"group_end"}
//@ui {"widget":"separator"}
//@ui {"widget":"group_start", "label":"Advanced"}
//@input bool hide = false
//@input Component.ScreenTransform hideScreenTransform {"showIf":"hide"}
//@input Component.ScreenTransform mainScreenTransform {"showIf":"hide"}
//@input float returnTime {"showIf":"hide"}
//@input float returnSpeed {"showIf":"hide", "widget":"slider", "min":0.0, "max":1.0, "step":0.01}
//@input Asset.Material spritePresetMaterial {"showIf":"hide"}
//@input Component.Image spritePreset1Image {"showIf":"hide"}
//@input Component.Image spritePreset2Image {"showIf":"hide"}
//@input Asset.Texture spritePreset1Texture {"showIf":"hide"}
//@input Asset.Texture spritePreset2Texture {"showIf":"hide"}
//@ui {"widget":"group_end"}

setMaterials();

function setMaterials() {
    let newMaterial = script.spritePresetMaterial.clone();
    newMaterial.mainPass.baseTex = script.spritePreset1Texture;
    script.spritePreset1Image.mainMaterial = newMaterial;

    newMaterial = script.spritePresetMaterial.clone();
    newMaterial.mainPass.baseTex = script.spritePreset2Texture;
    script.spritePreset2Image.mainMaterial = newMaterial;
}

const EMPTY_CALLBACKS = [function() { }];
let SliderType;
(function(SliderType) {
    SliderType[SliderType['white'] = 0] = 'white';
    SliderType[SliderType['color'] = 1] = 'color';
})(SliderType || (SliderType = {}));
const Slider = /** @class */ (function() {
    function Slider(touchZone, point, camera, minValue, maxValue, whiteTexture, colorTexture, sliderType, hide, usedStep, hideScreenTransform, sliderScreenTransform, returnTime, returnSpeed, step) {
        const _this = this;
        this.onValueChangedCallbacks = EMPTY_CALLBACKS;
        this.textures = [];
        this.opacities = [0.6, 1];
        this._minValue = 0;
        this._maxValue = 1;
        this._step = 0.01;
        this.activeTouch = false;
        this.speedLerpMax = 0.15;
        this.speedLerpMin = 0.02;
        this.sliderScreenTransform = sliderScreenTransform;
        this.pointScreenTransform = point;
        this.pointCenter = this.pointScreenTransform.anchors.getCenter();
        this.minValue = minValue;
        this.maxValue = maxValue;
        this.setTextures(whiteTexture, colorTexture);
        this.setSliderTexture(sliderType);
        this.usedStep = usedStep;
        if (this.usedStep) {
            this.step = step;
        }
        const touchComponent = touchZone.getSceneObject().getComponent('Component.InteractionComponent');
        touchComponent.onTouchMove.add(function(e) {
            return _this.onSliderChangedCallback(_this.pointScreenTransform.screenPointToParentPoint(e.position).y);
        });
        this.hide = hide;
        if (this._hide) {
            this.returnTime = returnTime;
            this.returnSpeed = this.fitTo(0, 1, this.speedLerpMin, this.speedLerpMax, returnSpeed);
            this.hideScreenTransform = hideScreenTransform;
            this.hidePosition = this.hideScreenTransform.anchors.getCenter();
            this.hideSize = this.hideScreenTransform.anchors.getSize();
            this.showPosition = this.sliderScreenTransform.anchors.getCenter();
            this.showSize = this.sliderScreenTransform.anchors.getSize();
            touchComponent.onTouchStart.add(function() {
                return _this.sliderShow();
            });
            touchComponent.onTouchEnd.add(function() {
                return _this.sliderHide();
            });
            this.updateSlider = script.createEvent('UpdateEvent');
            this.updateSlider.enabled = false;
            this.updateSlider.bind(function() {
                return _this.updateSliderPosition();
            });
            this.delayCallback = script.createEvent('DelayedCallbackEvent');
            this.delayCallback.bind(function() {
                return _this.delayToHide();
            });
            this.sliderScreenTransform.anchors.setCenter(this.hidePosition);
            this.sliderScreenTransform.anchors.setSize(this.hideSize);
        }
    }
    Slider.prototype.setOnValueChangedCallbacks = function(callbacks) {
        const _this = this;
        this.onValueChangedCallbacks = callbacks;
        callbacks.forEach(function(callback) {
            callback(_this.getSliderValue());
        });
    };
    Slider.prototype.addOnValueChangedCallbacks = function(callback) {
        this.onValueChangedCallbacks.push(callback);
        callback(this.getSliderValue());
    };
    Object.defineProperty(Slider.prototype, 'step', {
        set: function(stepValue) {
            this.usedStep = true;
            this._step = stepValue;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Slider.prototype, 'minValue', {
        get: function() {
            return this._minValue;
        },
        set: function(min) {
            this._minValue = min;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Slider.prototype, 'maxValue', {
        get: function() {
            return this._maxValue;
        },
        set: function(max) {
            this._maxValue = max;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Slider.prototype, 'hide', {
        set: function(isHide) {
            if (this._hide) {
                this.sliderShow();
            }
            this._hide = isHide;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Slider.prototype, 'returnTime', {
        set: function(time) {
            this._returnTime = time;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Slider.prototype, 'returnSpeed', {
        set: function(speed) {
            this._returnSpeed = speed;
        },
        enumerable: false,
        configurable: true
    });
    Slider.prototype.setSliderTexture = function(sliderType) {
        return;
        const sliderImg = this.pointScreenTransform.getSceneObject().getParent()
            .getFirstComponent('Component.Image');
        sliderImg.mainMaterial.mainPass.baseTex = this.textures[sliderType];
        const color = sliderImg.mainMaterial.mainPass.baseColor;
        color.a = this.opacities[sliderType];
        sliderImg.mainMaterial.mainPass.baseColor = color;
    };
    Slider.prototype.setTextures = function(white, color) {
        this.textures.push(white);
        this.textures.push(color);
    };
    Slider.prototype.onSliderChangedCallback = function(value) {
        let sliderValue = value;
        if (this.usedStep) {
            sliderValue = this.roundPointPosition(sliderValue);
        }
        sliderValue = this.clamp(-1, 1, sliderValue);
        this.setPointPosition(sliderValue);
        const valueForCallback = this.getSliderValue();
        this.onValueChangedCallbacks.forEach(function(el) {
            return el(valueForCallback);
        });
    };
    Slider.prototype.getSliderValue = function() {
        return this.fitTo(-1, 1, this.minValue, this.maxValue, this.pointCenter.y);
    };
    Slider.prototype.setPointPosition = function(newCenter) {
        this.pointCenter.y = newCenter;
        this.pointScreenTransform.anchors.setCenter(this.pointCenter);
    };
    Slider.prototype.roundPointPosition = function(value) {
        const left = (value >= 0) ? value - value % this._step : value - (this._step + value % this._step);
        const right = left + this._step;
        return (value - left < right - value) ? left : right;
    };
    Slider.prototype.sliderHide = function() {
        this.activeTouch = false;
        this.delayCallback.reset(this._returnTime);
    };
    Slider.prototype.delayToHide = function() {
        if (this.activeTouch || !this._hide) {
            return;
        }
        this.targetSize = this.hideSize;
        this.targetPosition = this.hidePosition;
        this.updateSlider.enabled = true;
    };
    Slider.prototype.sliderShow = function() {
        if (!this._hide) {
            return;
        }
        this.activeTouch = true;
        this.targetSize = this.showSize;
        this.targetPosition = this.showPosition;
        this.updateSlider.enabled = true;
    };
    Slider.prototype.updateSliderPosition = function() {
        const currentSize = this.sliderScreenTransform.anchors.getSize();
        const currentPosition = this.sliderScreenTransform.anchors.getCenter();
        this.sliderScreenTransform.anchors.setSize(vec2.lerp(currentSize, this.targetSize, this._returnSpeed));
        this.sliderScreenTransform.anchors.setCenter(vec2.lerp(currentPosition, this.targetPosition, this._returnSpeed));
        if (this.targetPosition.distance(currentPosition) < 0.001) {
            this.sliderScreenTransform.anchors.setSize(this.targetSize);
            this.sliderScreenTransform.anchors.setCenter(this.targetPosition);
            this.updateSlider.enabled = false;
        }
    };
    Slider.prototype.fitTo = function(sliderMin, sliderMax, effectMin, effectMax, sliderValue) {
        return (sliderValue - sliderMin) * (effectMax - effectMin) / (sliderMax - sliderMin) + effectMin;
    };
    Slider.prototype.clamp = function(min, max, val) {
        return Math.min(Math.max(min, val), max);
    };
    return Slider;
}());
const slider = new Slider(script.touchZone, script.pointScreenTransform, script.camera, script.minValue, script.maxValue, script.white, script.color, script.sliderType, script.hide, script.usedStep, script.hideScreenTransform, script.mainScreenTransform, script.returnTime, script.returnSpeed, script.step);
script.api.setOnValueChangedCallbacks = function(callbacks) {
    return slider.setOnValueChangedCallbacks(callbacks);
};
script.api.addOnValueChangedCallbacks = function(callback) {
    return slider.addOnValueChangedCallbacks(callback);
};
script.api.setMinValue = function(min) {
    return slider.minValue = min;
};
script.api.setMaxValue = function(max) {
    return slider.maxValue = max;
};
script.api.getMinValue = function() {
    return slider.minValue;
};
script.api.getMaxValue = function() {
    return slider.maxValue;
};
script.api.setStepValue = function(step) {
    return slider.step = step;
};
script.api.setHide = function(hide) {
    return slider.hide = hide;
};
script.api.setSliderTexture = function(sliderType) {
    return slider.setSliderTexture(sliderType);
};
script.api.setReturnTime = function(time) {
    return slider.returnTime = time;
};
script.api.setReturnSpeed = function(speed) {
    return slider.returnSpeed = speed;
};
script.api.setSliderValue = function(value) {
    return slider.onSliderChangedCallback(value);
};
