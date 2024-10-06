import {SIK} from "SpectaclesInteractionKit/SIK";

@component
export class Blink extends BaseScriptComponent {
    @input
    objecttoBlink: SceneObject;
    @input
    remoteServiceModule: RemoteServiceModule;

    private flag: number = 0;
    private blinkEnabled: boolean = false;

    onAwake() {
        print("Blink component is awake!");
        this.createEvent("UpdateEvent").bind(() => { this.onUpdate() });
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
                } else {
                    this.objecttoBlink.enabled = false;
                    print("XXXXXXX");
                }
            } else {
                print("Error code:" + response.statusCode + "\n Body: " + response.body);
            }
        });
    }
}
