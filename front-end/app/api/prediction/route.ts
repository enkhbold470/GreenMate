import { NextResponse } from "next/server";

export async function GET() {
  try {
    const response = await fetch("https://thomasc86-flask--8082.prod1a.defang.dev/predict");

    // Check if the response is ok (status in the range 200-299)
    if (!response.ok) {
      console.log(response.status);
      return NextResponse.json(
        { error: "Failed to fetch data" },
        { status: response.status }
      );
    }

    const data = await response.json();
    console.log(data);
    // Check if the necessary data is present
    if (!data || Object.keys(data).length === 0) {
      return NextResponse.json({ error: "No data available" }, { status: 404 });
    }

    return NextResponse.json(data);
  } catch (error) {
    console.error(error);
    return NextResponse.json({ error: "Server Error" }, { status: 500 });
  }
}
