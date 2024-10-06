import {SIK} from "SpectaclesInteractionKit/SIK";
import { setTimeout } from "SpectaclesInteractionKit/Utils/debounce";

@component
export class Blink extends BaseScriptComponent {
    @input
    objecttoBlink: SceneObject;
    @input
    sun: SceneObject;
    @input
    drink: SceneObject;
    @input
    rain: SceneObject;
    @input
    dust: SceneObject;
    @input
    remoteServiceModule: RemoteServiceModule;

    @input
    text1: Text3D;

    private oneHot: number = 0;
    private forDemoVid: boolean = true;
    private previousHumidity: number = 0;
    private previousTemperature: number = 0;
    private previousSunlight: number = 0;
    private previousSoilMoisture: number = 0;

    onAwake() {
        print("Blink component is awake!");
        if (this.forDemoVid){
            this.createEvent("OnStartEvent").bind(() => { this.onStart();});
        }
        this.createEvent("UpdateEvent").bind(() => { this.onUpdate() });
        this.objecttoBlink.enabled = false;
        this.sun.enabled = false;
        this.drink.enabled = false;
        this.rain.enabled = false;
        this.dust.enabled = false;

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
                } else{
                    print("Error code:" + response.statusCode + "\n Body: " + response.body);
                }
            });
        
    }

    onStart() {
        // Retrieve HandInputData from SIK's definitions.
        let handInputData = SIK.HandInputData;
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
        if (!this.forDemoVid){
            // print("Fetching plant status...");        
            let httpRequest = RemoteServiceHttpRequest.create();
            httpRequest.method = RemoteServiceHttpRequest.HttpRequestMethod.Get;
            httpRequest.url = "https://thomasc86-flask--8082.prod1a.defang.dev/predict";
            // httpRequest.url = "https://10.206.45.9:8080/predict";
            httpRequest.setHeader("accept", "application/json");
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
                                    } else if (minChange.value < -0.1) {
                                        this.oneHot = minChange.index;
                                    } else {
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
                                    } else if (this.oneHot == 1) {
                                        this.objecttoBlink.enabled = true;
                                        this.drink.enabled = false;
                                        this.sun.enabled = false;
                                        this.rain.enabled = false;
                                        this.dust.enabled = false;
                                    } else if (this.oneHot == 2) {
                                        this.objecttoBlink.enabled = false;
                                        this.drink.enabled = false;
                                        this.sun.enabled = false;
                                        this.rain.enabled = false;
                                        this.dust.enabled = true;
                                    } else if (this.oneHot == 3) {
                                        this.objecttoBlink.enabled = false;
                                        this.drink.enabled = false;
                                        this.sun.enabled = true;
                                        this.rain.enabled = false;
                                        this.dust.enabled = false;
                                    } else if (this.oneHot == 4) {
                                        this.objecttoBlink.enabled = false;
                                        this.drink.enabled = false;
                                        this.sun.enabled = false;
                                        this.rain.enabled = true;
                                        this.dust.enabled = false;
                                    } else if (this.oneHot == 5) {
                                        this.objecttoBlink.enabled = false;
                                        this.drink.enabled = true;
                                        this.sun.enabled = false;
                                        this.rain.enabled = false;
                                        this.dust.enabled = false;
                                    }
                } else{
                    print("Error code:" + response.statusCode + "\n Body: " + response.body);
                }
            });
            setTimeout(this.timeToBlink, 30000);
        } else {
            
            // setTimeout(this.timeToBlink, 30000);
            if (this.oneHot == 0) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = false;
            } else if (this.oneHot == 1) {
                this.objecttoBlink.enabled = true;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = false;
            } else if (this.oneHot == 2) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = true;
            } else if (this.oneHot == 3) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = true;
                this.rain.enabled = false;
                this.dust.enabled = false;
            } else if (this.oneHot == 4) {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = false;
                this.sun.enabled = false;
                this.rain.enabled = true;
                this.dust.enabled = false;
            } else {
                this.objecttoBlink.enabled = false;
                this.drink.enabled = true;
                this.sun.enabled = false;
                this.rain.enabled = false;
                this.dust.enabled = false;
            }
            // setTimeout(this.timeToBlink, 10000);
        
        }
    }

    timeToBlink() {
    }
}
