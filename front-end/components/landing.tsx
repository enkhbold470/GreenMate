"use client";
import React from "react";
// import YourPlants from "./YourPlants";
import SensorInfo from "./sensorInfo";
import sensorTypes from "../lib/sensorTypes";
import PlantCard from "./plant-card";
import { useEffect, useState } from "react";
import useWeather from "../hook/useWeather";
import { MapPinHouse, Thermometer } from "lucide-react";
export default function Landing() {
  //get plant name from backend
  const [wateringPrediction, setWateringPrediction] = useState(
    "Server Error... Please try again later"
  );
  const lat = 40.8068737;
  const lon = -73.9604592;
  const { weather } = useWeather(lat, lon);

  //loading to fetch for 1 second with time interv
  if (wateringPrediction === "") {
    setWateringPrediction("Loading...");
  }
  useEffect(() => {
    const fetchPrediction = async () => {
      const response = await fetch("/api/prediction");
      const data = await response.json();
      setWateringPrediction(data.prediction);
    };
    const timer = setTimeout(fetchPrediction, 1000); // Delay fetching for 1 second
    return () => clearTimeout(timer); // Cleanup the timer on unmount
  }, []);

  return (
    <div className="bg-anti-flash_white-DEFAULT min-h-screen font-sans text-fern_green-DEFAULT p-4">
      <header className="flex justify-between items-center mb-6">
        <div className="flex items-center space-x-2 gap-1">
          <img
            src="/greenmate.svg"
            alt="Profile"
            className="w-14 h-14 rounded-full border-2 border-fern_green-DEFAULT"
          />
          <p className="text-sm font-semibold">Enkhbold G.</p>
        </div>

        <div className="flex items-center space-x-2">
          <div>
            {weather ? (
              <div>
                <div className="flex flex-col items-end space-x-2 space-y-2">
                  {/* Location lucide icon */}
                  <h2 className="flex items-center space-x-2">
                    <span>Columbia University, NY</span>
                    <MapPinHouse />
                  </h2>
                  <div className="flex items-center space-x-2">
                    <p>
                      {weather.temperature}°{weather.temperatureUnit}
                    </p>
                    <Thermometer />
                  </div>
                </div>
              </div>
            ) : (
              <p>Loading...</p>
            )}
          </div>
        </div>
      </header>

      <h1 className="text-2xl font-bold mb-6">My Plant</h1>

      <PlantCard
        name="Monstera Deliciosa"
        image="https://images.unsplash.com/photo-1485955900006-10f4d324d411?q=80&w=872&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        prediction={wateringPrediction}
      />

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

      {/* <YourPlants /> */}
    </div>
  );
}
