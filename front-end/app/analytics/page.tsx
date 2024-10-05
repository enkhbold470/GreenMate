export default function Analytics() {
  return (
    <div>
      <h1 className="text-2xl font-bold">Analytics</h1>
      <iframe
        width="100%"
        height="200"
        src="https://thingspeak.mathworks.com/channels/2683851/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Temperature&type=line"
      ></iframe>
      <iframe
        width="100%"
        height="200"
        src="https://thingspeak.mathworks.com/channels/2683851/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Humidity&type=line"
      ></iframe>
      <iframe
        width="100%"
        height="200"
        src="https://thingspeak.mathworks.com/channels/2683851/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Soil_moisture&type=line"
      ></iframe>
      {/* <iframe
        width="100%"
        height="200"
        src="https://thingspeak.mathworks.com/channels/2683851/widgets/935119"
      ></iframe> */}
    </div>
  );
}
