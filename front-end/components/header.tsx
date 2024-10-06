import React from "react";
import { MapPin } from "lucide-react";
import Image from "next/image";
import { WeatherData } from "@/lib/types";

const weatherData: WeatherData = {
  temperature: 22,
  city: "New York",
};

export default function Header() {
  return (
    <header className="flex justify-between items-center mb-8 bg-white p-4 rounded-lg shadow-md">
      <div className="flex items-center space-x-4">
        <div className="relative w-16 h-16">
          <Image
            src="/EG.svg"
            alt="Profile Avatar"
            width={64}
            height={64}
            className="rounded-full"
          />
        </div>
        <div>
          <h2 className="text-xl font-semibold">Enkhbold Ganbold</h2>
          <p className="text-gray-600">Plant Enthusiast</p>
        </div>
      </div>
      <div className="flex items-center space-x-2">
        <MapPin className="w-5 h-5 text-gray-500" />
        <span className="text-gray-700">{weatherData.city}</span>
        <span className="text-gray-700">{weatherData.temperature}°C</span>
      </div>
    </header>
  );
}