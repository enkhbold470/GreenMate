"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Blink = void 0;
var __selfType = requireType("./Blink");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const SIK_1 = require("SpectaclesInteractionKit/SIK");
const debounce_1 = require("SpectaclesInteractionKit/Utils/debounce");
let Blink = class Blink extends BaseScriptComponent {
    onAwake() {
        print("Blink component is awake!");
        this.createEvent("OnStartEvent").bind(() => { this.onStart(); });
        this.createEvent("UpdateEvent").bind(() => { this.onUpdate(); });
        this.objecttoBlink.enabled = false;
        this.sun.enabled = false;
        this.drink.enabled = false;
        this.rain.enabled = false;
        this.dust.enabled = false;
    }
    onStart() {
        // Retrieve HandInputData from SIK's definitions.
        let handInputData = SIK_1.SIK.HandInputData;
        let rightHand = handInputData.getHand('right');
        rightHand.onPinchDown.add(() => {
            this.oneHot = (this.oneHot + 1) % 6;
        });
        let leftHand = handInputData.getHand('left');
        leftHand.onPinchDown.add(() => {
            // this.forDemoVid = !this.forDemoVid;
        });
    }
    onUpdate() {
        // Fetch the plant status using RemoteServiceModule
        if (!this.forDemoVid) {
            let httpRequest = RemoteServiceHttpRequest.create();
            httpRequest.method = RemoteServiceHttpRequest.HttpRequestMethod.Get;
            httpRequest.url = "https://thomasc86-flask--8082.prod1a.defang.dev/predict";
            // httpRequest.url = "https://10.206.45.9:8080/predict";
            httpRequest.setHeader("accept", "application/json");
            // print("Fetching plant status...");
            this.remoteServiceModule.performHttpRequest(httpRequest, (response) => {
                if (response.statusCode == 200) {
                    const data = JSON.parse(response.body);
                    print("Success! Body: " + data);
                    this.text1.text = "Humidity: " + data.humidity + " %\n" + "Temperature: " + data.temperature.toFixed(2) + " C\n" + "Sunlight: " + data.sunlight_level.toFixed(2) + " lux\n" + "Soil Moisture: " + data.soil_moisture;
                    // print("Water prediction: " + data.water_prediction);
                    // Compare with previous values and update oneHot number
                    const humidityChange = data.humidity - this.previousHumidity / this.previousHumidity;
                    const temperatureChange = data.temperature - this.previousTemperature / this.previousTemperature;
                    const sunlightChange = data.sunlight_level - this.previousSunlight / this.previousSunlight;
                    const soilMoistureChange = data.soil_moisture - this.previousSoilMoisture / this.previousSoilMoisture;
                    const changes = [
                        { value: humidityChange, index: 1 },
                        { value: temperatureChange, index: 2 },
                        { value: sunlightChange, index: 3 },
                        { value: soilMoistureChange, index: 4 }
                    ];
                    const minChanges = [
                        { value: humidityChange, index: 8 },
                        { value: temperatureChange, index: 7 },
                        { value: sunlightChange, index: 6 },
                        { value: soilMoistureChange, index: 5 }
                    ];
                    const maxChange = changes.reduce((prev, current) => (prev.value > current.value) ? prev : current);
                    const minChange = changes.reduce((prev, current) => (prev.value < current.value) ? prev : current);
                    if (maxChange.value > 0.1) {
                        this.oneHot = maxChange.index;
                    }
                    else if (minChange.value < -0.1) {
                        this.oneHot = minChange.index;
                    }
                    else {
                        this.oneHot = 0;
                    }
                    // Update previous values
                    this.previousHumidity = data.humidity;
                    this.previousTemperature = data.temperature;
                    this.previousSunlight = data.sunlight_level;
                    this.previousSoilMoisture = data.soil_moisture;
                    if (this.oneHot == 0) {
                        this.objecttoBlink.enabled = false;
                        this.drink.enabled = false;
                        this.sun.enabled = false;
                        this.rain.enabled = false;
                        this.dust.enabled = false;
                    }
                    else if (this.oneHot == 1) {
                        this.objecttoBlink.enabled = true;
                        this.drink.enabled = false;
                        this.sun.enabled = false;
                        this.rain.enabled = false;
                        this.dust.enabled = false;
                    }
                    else if (this.oneHot == 2) {
                        this.objecttoBlink.enabled = false;
                        this.drink.enabled = false;
                        this.sun.enabled = false;
                        this.rain.enabled = false;
                        this.dust.enabled = true;
                    }
                    else if (this.oneHot == 3) {
                        this.objecttoBlink.enabled = false;
                        this.drink.enabled = false;
                        this.sun.enabled = true;
                        this.rain.enabled = false;
                        this.dust.enabled = false;
                    }
                    else if (this.oneHot == 4) {
                        this.objecttoBlink.enabled = false;
                        this.drink.enabled = false;
                        this.sun.enabled = false;
                        this.rain.enabled = true;
                        this.dust.enabled = false;
                    }
                    else if (this.oneHot == 5) {
                        this.objecttoBlink.enabled = false;
                        this.drink.enabled = true;
                        this.sun.enabled = false;
                        this.rain.enabled = false;
                        this.dust.enabled = false;
                    }
                }
                else {
                    print("Error code:" + response.statusCode + "\n Body: " + response.body);
                }
            });
            (0, debounce_1.setTimeout)(this.timeToBlink, 30000);
        }
        else {
            if (this.oneHot == 0) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = false;
            }
            else if (this.oneHot == 1) {
                this.objecttoBlink.enabled = true;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = false;
            }
            else if (this.oneHot == 2) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = true;
            }
            else if (this.oneHot == 3) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = true;
                this.rain.enabled = false;
                this.dust.enabled = false;
            }
            else if (this.oneHot == 4) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = true;
                this.dust.enabled = false;
            }
            else {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = true;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = false;
            }
            (0, debounce_1.setTimeout)(this.timeToBlink, 10000);
        }
    }
    timeToBlink() {
    }
    __initialize() {
        super.__initialize();
        this.oneHot = 0;
        this.forDemoVid = true;
        this.previousHumidity = 0;
        this.previousTemperature = 0;
        this.previousSunlight = 0;
        this.previousSoilMoisture = 0;
    }
};
exports.Blink = Blink;
exports.Blink = Blink = __decorate([
    component
], Blink);
//# sourceMappingURL=Blink.js.map