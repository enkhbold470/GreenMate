import { NextResponse } from "next/server";

export async function GET() {
  const response = await fetch("http://10.206.45.9:8080/predict");
  const data = await response.json();
  return NextResponse.json({
    humidity: data.humidity,
    prediction: data.prediction,
    soil_moisture: data.soil_moisture,
    sunlight_level: data.sunlight_level,
    temperature: data.temperature,
  });
}
