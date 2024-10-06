export interface PlantData {
  humidity: number
  humidity_prediction: string
  soil_moisture: number
  sunlight_level: number
  sunlight_prediction: string
  temperature: number
  temperature_prediction: string
  water_prediction: string
}

export interface WeatherData {
  temperature: number
  city: string
}
