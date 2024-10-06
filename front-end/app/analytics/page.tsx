export default function Analytics() {
  return (
    <div className="flex flex-col items-center mb-20">
      <div className="flex flex-col space-y-4">
        <div className="flex rounded-md w-[450px] h-72 sm:h-60">
          <iframe
            className="w-full h-full"
            src="https://thingspeak.mathworks.com/channels/2683851/charts/4?bgcolor=%23ffffff&color=%23FFA500&dynamic=true&results=30&type=line&yaxismax=3000&yaxismin=0"
            title="Light Intensity"
          ></iframe>
        </div>
        <iframe
          className="w-full h-[260px] sm:h-60"
          src="https://thingspeak.mathworks.com/channels/2683851/charts/3?bgcolor=%23ffffff&color=%23008000&dynamic=true&results=30&type=line&yaxismax=3000&yaxismin=0"
          title="Soil Moisture Chart"
        ></iframe>
        <iframe
          className="w-full h-[260px] sm:h-60"
          src="https://thingspeak.mathworks.com/channels/2683851/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=30&type=line&yaxismax=40&yaxismin=0"
          title="Temperature Chart"
        ></iframe>
        <iframe
          className="w-full h-[260px] sm:h-60"
          src="https://thingspeak.mathworks.com/channels/2683851/charts/2?bgcolor=%23ffffff&color=%230000FF&dynamic=true&results=30&type=line&yaxismax=50&yaxismin=0"
          title="Humidity Chart"
        ></iframe>
      </div>
    </div>
  );
}
