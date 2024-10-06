import { useEffect, useState } from "react";

interface Weather {
  name: string;
  temperature: number;
  temperatureUnit: string;
  detailedForecast: string;
}

const useWeather = (lat: number, lon: number) => {
  const [weather, setWeather] = useState<Weather | null>(null);
  const [location, setLocation] = useState<string | null>(null);

  useEffect(() => {
    const fetchWeather = async () => {
      try {
        const response = await fetch(
          `https://api.weather.gov/points/${lat},${lon}`
        );
        const data = await response.json();
        const forecastUrl = data.properties.forecast;
        const state = data.properties.relativeLocation.properties.state;
        const city = data.properties.relativeLocation.properties.city;

        const forecastResponse = await fetch(forecastUrl);
        const forecastData = await forecastResponse.json();

        setWeather(forecastData.properties.periods[0]);
        setLocation(`${city}, ${state}`);
      } catch (error) {
        console.error("Error fetching weather data:", error);
      }
    };

    fetchWeather();
  }, [lat, lon]);

  return { weather, location };
};

export default useWeather;
