import { NextResponse } from "next/server";

export async function GET() {
  try {
    const response = await fetch("http://10.206.45.9:8080/predict");

    // Check if the response is ok (status in the range 200-299)
    if (!response.ok) {
      return NextResponse.json(
        { error: "Failed to fetch data" },
        { status: response.status }
      );
    }

    const data = await response.json();

    // Check if the necessary data is present
    if (!data) {
      return NextResponse.json({ error: "No data available" }, { status: 404 });
    }

    return NextResponse.json({
      humidity: data.humidity || null,
      prediction: data.prediction || null,
      soil_moisture: data.soil_moisture || null,
      sunlight_level: data.sunlight_level || null,
      temperature: data.temperature || null,
    });
  } catch (error) {
    console.error(error);
    return NextResponse.json({ error: "Server Error" }, { status: 500 });
  }
}
