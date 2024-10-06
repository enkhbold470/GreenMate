import { Droplets, Sprout, Sun, Thermometer } from "lucide-react";

export type SensorPrediction = {
  humidity: number | "N/A";
  humidity_prediction: string | "N/A";
  soil_moisture: number | "N/A";
  sunlight_level: number | "N/A";
  sunlight_prediction: string | "N/A";
  temperature: number | "N/A";
  temperature_prediction: string | "N/A";
  water_prediction: string | "N/A";
};

export type SensorType = {
  icon: React.ElementType;
  label: string;
  value: string;
  color: string;
};

export const sensorTypes: SensorType[] = [
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
