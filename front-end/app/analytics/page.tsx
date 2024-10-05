export default function Analytics() {
  return (
    <div className="flex flex-col items-center mb-20">
      <div className="flex flex-col space-y-4">
        <div className="flex rounded-md w-[450px] h-72 sm:h-60">
          <iframe
            className="w-full h-full"
            src="https://thingspeak.mathworks.com/channels/2683851/widgets/935130"
            title="Light Intensity"
          ></iframe>
        </div>
        <iframe
          className="w-full h-[260px] sm:h-60"
          src="https://thingspeak.mathworks.com/channels/2683851/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Soil_moisture&type=line"
          title="Soil Moisture Chart"
        ></iframe>
        <iframe
          className="w-full h-[260px] sm:h-60"
          src="https://thingspeak.mathworks.com/channels/2683851/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Temperature&type=line"
          title="Temperature Chart"
        ></iframe>
        <iframe
          className="w-full h-[260px] sm:h-60"
          src="https://thingspeak.mathworks.com/channels/2683851/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Humidity&type=line"
          title="Humidity Chart"
        ></iframe>
      </div>
    </div>
  );
}
