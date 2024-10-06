"use client";
import React, { useEffect, useState } from "react";
import SensorInfo from "./sensorInfo";
import PlantCard from "./plant-card";
import useWeather from "../hook/useWeather";
import { MapPinHouse, Thermometer, Droplets, Sun } from "lucide-react";
import { SensorPrediction } from "@/lib/sensorPrediction";
import LoadingSpinner from './loading'; // Import the LoadingSpinner component
import Image from "next/image";
export default function Landing() {
  const [sensorData, setSensorData] = useState<SensorPrediction>(); // Changed to use SensorType array

  const lat = 40.8068737;
  const lon = -73.9604592;
  const { weather } = useWeather(lat, lon);

  useEffect(() => {
    const fetchPrediction = async () => {
      try {
        const response = await fetch("/api/prediction");
        const data: SensorPrediction = await response.json(); // Ensure data is of type SensorPrediction
        console.log(data);
        setSensorData(data); // Map sensor types to include fetched data
      } catch (error) {
        console.error("Error fetching prediction:", error);
      }
    };

    const timer = setInterval(fetchPrediction, 3000); // Fetch every 3 seconds
    return () => clearInterval(timer); // Cleanup the timer on unmount
  }, []);

  return (
    <div className="bg-anti-flash_white-DEFAULT min-h-screen font-sans text-fern_green-DEFAULT p-4 mb-20">
      <div className="flex justify-between items-center mb-6">
        <div className="flex items-center space-x-2 gap-1">
          <Image
            src="/greenmate.svg"
            alt="Profile"
            width={56}
            height={56}
            className="rounded-full border-2 border-fern_green-DEFAULT"
          />
          <div className="text-sm font-semibold">Enkhbold G.</div>
        </div>

        <div className="flex items-center space-x-2">
          {weather ? (
            <div className="flex flex-col items-end space-y-2">
              <div className="flex items-center space-x-2">
                <span>Columbia University, NY</span>
                <MapPinHouse />
              </div>
              <div className="flex items-center space-x-2">
                <div>
                  {weather.temperature}°{weather.temperatureUnit}
                </div>
                <Thermometer />
              </div>
            </div>
          ) : (
            <LoadingSpinner />
          )}
        </div>
      </div>

      <div className="text-2xl font-bold mb-6">My Plant</div>

      <PlantCard
        name="Monstera Deliciosa"
        image="https://images.unsplash.com/photo-1485955900006-10f4d324d411?q=80&w=872&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        prediction={sensorData?.water_prediction ?? "Loading..."}
      />
    
      <div className="mt-6 space-y-4">
        <div className="text-xl font-semibold">Predictions</div>
        <div className="grid grid-cols-2 gap-4">
          <SensorInfo
            icon={Droplets}
            label="Humidity Prediction"
            value={sensorData?.humidity_prediction ?? <LoadingSpinner />}
            color="text-blue-500"
          />
          <SensorInfo
            icon={Sun}
            label="Sunlight Prediction"
            value={sensorData?.sunlight_prediction ?? <LoadingSpinner />}
            color="text-yellow-500"
          />
          <SensorInfo
            icon={Thermometer}
            label="Temperature Prediction"
            value={sensorData?.temperature_prediction ?? <LoadingSpinner />}
            color="text-red-500"
          />
          <SensorInfo
            icon={Droplets}
            label="Water Prediction"
            value={sensorData?.water_prediction ?? <LoadingSpinner />}
            color="text-blue-700"
          />
        </div>
      </div>

     
    </div>
  );
}