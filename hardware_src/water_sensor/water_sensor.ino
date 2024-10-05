int sensorPin = 42;        // select the input pin for the potentiometer
int ledPin = LED_BUILTIN; // select the pin for the LED
int sensorValue = 0;      // variable to store the value coming from the sensor

void setup()
{
  // declare the ledPin as an OUTPUT:
  Serial.begin(9600);
  Serial.println("HI, it's me, the soil moisture sensor!");
  pinMode(ledPin, OUTPUT);
}

void loop()
{
  sensorValue = analogRead(sensorPin);
  Serial.println("The current moisture level is: " + String(sensorValue));
}