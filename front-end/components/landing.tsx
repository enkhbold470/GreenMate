    // Start of Selection
    "use client"
    import React, { useEffect, useState } from "react"
    import { Droplets, Thermometer, Sun, Sprout } from "lucide-react"
    import { PlantData } from "@/lib/types"
    import PlantCard from "./plant-card"
    import InfoCard from "./infoCard" // Updated casing
    import Header from "./header"
    import LoadingSpinner from "./loading"
    
    
    export default function Landing() {
      const [plantData, setPlantData] = useState<PlantData | null>(null)
      const [loading, setLoading] = useState(true)
    
      useEffect(() => {
        let isMounted = true
        const fetchData = async () => {
          try {
            const response = await fetch("/api/prediction")
            if (!response.ok) {
              throw new Error("Network response was not ok")
            }
            const data: PlantData = await response.json()
            if (isMounted) {
              setPlantData(data)
              setLoading(false)
            }
          } catch (error) {
            console.error(
              "There was a problem with the fetch operation:",
              error
            )
            if (isMounted) {
              // Remove the random data fallback
              setPlantData(null)
              setLoading(false)
            }
          }
        }
    
        // Initial fetch
        fetchData()
        // Set interval to fetch every 15 seconds
        const intervalId = setInterval(fetchData, 15000)
    
        // Cleanup on unmount
        return () => {
          isMounted = false
          clearInterval(intervalId)
        }
      }, [])
    
      return (
        <div className="min-h-screen bg-gray-100 p-4 sm:p-6 md:p-8">
          <Header />
          <main className="grid grid-cols-1 md:grid-cols-2 gap-4 max-w-4xl mx-auto mb-20">
            <PlantCard
              name="Monstera Deliciosa"
              image="https://images.unsplash.com/photo-1647166545674-ce28ce93bdca"
              prediction="Your plant is doing well, but needs some attention to humidity and watering."
            />
            {loading ? (
              <div className="col-span-full flex justify-center items-center">
                <LoadingSpinner />
              </div>
            ) : plantData ? (
              <div className="grid grid-cols-1 gap-4">
                <InfoCard
                  icon={<Droplets className="w-6 h-6 text-blue-500" />}
                  title="Humidity"
                  value={`${plantData.humidity}%`}
                  prediction={plantData.humidity_prediction}
                />
                <InfoCard
                  icon={<Thermometer className="w-6 h-6 text-red-500" />}
                  title="Temperature"
                  value={`${plantData.temperature}°C`}
                  prediction={plantData.temperature_prediction}
                />
                <InfoCard
                  icon={<Sun className="w-6 h-6 text-yellow-500" />}
                  title="Sunlight"
                  value={`${plantData.sunlight_level} lux`}
                  prediction={plantData.sunlight_prediction}
                />
                <InfoCard
                  icon={<Sprout className="w-6 h-6 text-green-500" />}
                  title="Soil Moisture"
                  value={`${plantData.soil_moisture}`}
                  prediction={plantData.water_prediction}
                />
              </div>
            ) : (
              <div className="col-span-full text-center text-red-500">
                Failed to load plant data. Please try again later.
              </div>
            )}
          </main>
        </div>
      )
    }