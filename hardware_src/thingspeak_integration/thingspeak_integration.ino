#include <WiFi.h>
#include "DHT.h"
#include <ThingSpeak.h>
#include "secret.h"
// WiFi credentials
const char ssid[] = SECRET_SSID;
const char password[] = SECRET_PASS;

// ThingSpeak credentials
int channelID = THINGSPEAK_CHANNEL;
const char apiKey[] = THINGSPEAK_API_KEY;

// Pin definitions
#define DHTPIN 2        // DHT11 data pin
#define SOIL_PIN 4     // Soil moisture sensor pin
#define PHOTO_PIN 1     // Photoresistor pin
#define DHTTYPE DHT11   // DHT11 sensor type

// Initialize sensors
DHT dht(DHTPIN, DHTTYPE);
WiFiClient client;

// Variables for sensor readings
float temperature;
float humidity;
int soilMoisture;
int lightLevel, reversedLightLevel;

void setup() {
  Serial.begin(115200);
  
  // Initialize WiFi
  WiFi.begin(ssid);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
  
  // Initialize sensors
  dht.begin();
  
  // Initialize ThingSpeak
  ThingSpeak.begin(client);
}

void readSensors() {
  // Read DHT11
  humidity = dht.readHumidity();
  temperature = dht.readTemperature();
  
  // Read soil moisture
  soilMoisture = analogRead(SOIL_PIN);
  
  // Read light level
  lightLevel = analogRead(PHOTO_PIN);
  reversedLightLevel = map(lightLevel, 0, 4096, 4096, 0);
  
  // Print readings to Serial
  Serial.println("Sensor Readings:");
  Serial.println("Temperature: " + String(temperature) + "°C");
  Serial.println("Humidity: " + String(humidity) + "%");
  Serial.println("Soil Moisture: " + String(soilMoisture));
  Serial.println("Light Level: " + String(reversedLightLevel));
}

void sendToThingSpeak() {
  // Set fields for ThingSpeak
  ThingSpeak.setField(1, temperature);
  ThingSpeak.setField(2, humidity);
  ThingSpeak.setField(3, soilMoisture);
  ThingSpeak.setField(4, lightLevel);
  
  // Send data to ThingSpeak
int response = ThingSpeak.writeFields((unsigned long)channelID, apiKey);
  
  if (response == 200) {
    Serial.println("Data sent to ThingSpeak successfully");
  } else {
    Serial.println("Error sending data to ThingSpeak");
  }
}

void loop() {
  // Check WiFi connection
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("WiFi connection lost! Reconnecting...");
    WiFi.begin(ssid, password);
    return;
  }
  
  // Read sensors
  readSensors();
  
  // Send data to ThingSpeak
  sendToThingSpeak();
  
  // ThingSpeak has a rate limit of 15 seconds
  delay(15000);
}