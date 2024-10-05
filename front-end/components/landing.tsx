import React from "react";
import YourPlants from "./YourPlants";
import SensorInfo from "./sensorInfo";
import sensorTypes from "../lib/sensorTypes";
const PlantCard = ({
  name,
  image,
  daysAgo,
}: {
  name: string;
  image: string;
  daysAgo: number;
}) => (
  <div className="bg-white rounded-3xl shadow-lg overflow-hidden">
    <img src={image} alt={name} className="w-full h-48 object-cover" />
    <div className="p-4">
      <h3 className="text-fern_green-DEFAULT font-semibold text-lg">{name}</h3>
      <p className="text-asparagus-300 text-sm">{daysAgo} days ago planted</p>
    </div>
  </div>
);

export default function Landing() {
  return (
    <div className="bg-anti-flash_white-DEFAULT min-h-screen font-sans text-fern_green-DEFAULT p-4">
      <header className="flex justify-between items-center mb-6">
        <img src="/EG.svg" alt="Profile" className="w-10 h-10 rounded-full" />
        <div className="flex items-center space-x-2">
          <span className="text-2xl">☀️</span>
          <span className="text-2xl">☁️</span>
        </div>
      </header>

      <h1 className="text-2xl font-bold mb-6">Manage Your Home Plants</h1>

      <PlantCard name="Monstera Deliciosa" image="/EG.svg" daysAgo={15} />

      <div className="mt-6 space-y-4">
        <h2 className="text-xl font-semibold">Dashboard</h2>
        <div className="grid grid-cols-2 gap-4">
          {sensorTypes.map((sensor) => (
            <SensorInfo
              key={sensor.label}
              icon={sensor.icon}
              label={sensor.label}
              value={sensor.value}
              color={sensor.color}
            />
          ))}
        </div>
      </div>

      <YourPlants />
    </div>
  );
}
