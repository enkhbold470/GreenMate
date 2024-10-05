import { Sun, Droplets, Thermometer, Sprout } from "lucide-react";

export const sensorTypes = [
  {
    icon: Thermometer,
    label: "Temperature",
    value: "24°C",
    color: "bg-asparagus-DEFAULT",
  },
  {
    icon: Droplets,
    label: "Humidity",
    value: "65%",
    color: "bg-fern_green-DEFAULT",
  },
  {
    icon: Sprout,
    label: "Soil Moisture",
    value: "80%",
    color: "bg-fern_green-700",
  },
  {
    icon: Sun,
    label: "Light",
    value: "750 lux",
    color: "bg-asparagus-700",
  },
];

export default sensorTypes;
