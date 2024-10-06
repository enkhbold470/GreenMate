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
let Blink = class Blink extends BaseScriptComponent {
    onAwake() {
        print("Blink component is awake!");
        this.createEvent("UpdateEvent").bind(() => { this.onUpdate(); });
    }
    onUpdate() {
        // Fetch the plant status using RemoteServiceModule
        let httpRequest = RemoteServiceHttpRequest.create();
        httpRequest.method = RemoteServiceHttpRequest.HttpRequestMethod.Get;
        httpRequest.url = "https://thomasc86-flask--8082.prod1a.defang.dev/predict";
        // httpRequest.url = "https://10.206.45.9:8080/predict";
        // httpRequest.setHeader("User-Agent", "curl/7.64.1");
        httpRequest.setHeader("accept", "application/json");
        // print("Fetching plant status...");
        this.remoteServiceModule.performHttpRequest(httpRequest, (response) => {
            if (response.statusCode == 200) {
                const data = JSON.parse(response.body);
                print("Success! Body: " + data);
                // print("Water prediction: " + data.water_prediction);
                if (data.water_prediction === "Plant needs water") {
                    this.objecttoBlink.enabled = true;
                    print("Plant needs water!");
                }
                else {
                    this.objecttoBlink.enabled = false;
                    print("XXXXXXX");
                }
            }
            else {
                print("Error code:" + response.statusCode + "\n Body: " + response.body);
            }
        });
    }
    __initialize() {
        super.__initialize();
        this.flag = 0;
        this.blinkEnabled = false;
    }
};
exports.Blink = Blink;
exports.Blink = Blink = __decorate([
    component
], Blink);
//# sourceMappingURL=Blink.js.map