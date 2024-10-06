// @input Asset.RemoteServiceModule remoteServiceModule

// Import module
const Module = require("./Placeholder API Module");
const ApiModule = new Module.ApiModule(script.remoteServiceModule);

/*
// Example of calling an endpoint in ApiModule, replace with actual endpoint name
ApiModule.endpointName({
    // There might be required parameters
    parameters: {
        "parameter1": "12345"  // Replace with actual parameter names and values
    },
    // Body might be optional
    body: JSON.stringify({
        "additionalInfo": "Some info"  // Adjust based on the actual endpoint requirements
    })
}).then((response) => {
    // Parse response as JSON string and log it
    print("Response metadata: " + JSON.stringify(response.metadata))
    print("Response body: " + response.bodyAsString());
}).catch((error) => {
    print(error + "\n" + error.stack);
});
*/
