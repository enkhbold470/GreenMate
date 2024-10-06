from flask import Flask, jsonify, render_template
import pandas as pd
import requests
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
import os
from dotenv import load_dotenv
from sklearn.metrics import accuracy_score


PORT=8082
app = Flask(__name__)

# Define API endpoints for the fields
base_url = 'https://api.thingspeak.com/channels/2683851/fields/'
field_urls = {
    'field1': base_url + '1.json',  # Temperature
    'field2': base_url + '2.json',  # Humidity
    'field3': base_url + '3.json',  # Soil Moisture
    'field4': base_url + '4.json',  # Sunlight Level
}

# Fetch data from ThingSpeak API
def fetch_field_data(field_name, field_url):
    response = requests.get(field_url)
    data = response.json()
    feeds = data['feeds']
    return [float(feed[field_name]) for feed in feeds]

# Fetch the data for each field
temperature = fetch_field_data('field1', field_urls['field1'])
humidity = fetch_field_data('field2', field_urls['field2'])
soil_moisture = fetch_field_data('field3', field_urls['field3'])
sunlight_level = fetch_field_data('field4', field_urls['field4'])

# Combine the data into a DataFrame
df = pd.DataFrame({
    'field1': temperature,     # temperature
    'field2': humidity,        # humidity
    'field3': soil_moisture,   # soil moisture
    'field4': sunlight_level   # sunlight level
})

# Create target variable: 'needs_water' based on soil moisture
df['needs_water'] = df['field3'].apply(lambda x: 1 if x < 30 else 0)

# Create target variable: 'temperature_ok' based on an ideal temperature range (e.g., 18-28 degrees Celsius)
df['temperature_ok'] = df['field1'].apply(lambda x: 1 if 18 <= x <= 28 else 0)

# Create target variable: 'sunlight_ok' based on an ideal sunlight threshold (e.g., 800-1200 units)
df['sunlight_ok'] = df['field4'].apply(lambda x: 1 if 800 <= x <= 1200 else 0)

# Create target variable: 'humidity_ok' based on an ideal humidity range (e.g., 40-60%)
df['humidity_ok'] = df['field2'].apply(lambda x: 1 if 40 <= x <= 60 else 0)

# Function to train a model for a given target variable
def train_model(df, target):
    X = df[['field1', 'field2', 'field3', 'field4']]  # Features: temperature, humidity, soil moisture, sunlight
    y = df[target]  # Target variable

    # Split the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Train the RandomForest model
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)

    # Evaluate the model
    y_train_pred = model.predict(X_train)
    y_test_pred = model.predict(X_test)
    
    train_accuracy = accuracy_score(y_train, y_train_pred)
    test_accuracy = accuracy_score(y_test, y_test_pred)
    
    print(f"Training Accuracy for {target}: {train_accuracy * 100:.2f}%")
    print(f"Test Accuracy for {target}: {test_accuracy * 100:.2f}%")

    return model


# Define a route to render the HTML page
@app.route('/')
def home():
    return render_template('index.html')

# Train models for each condition
water_model = train_model(df, 'needs_water')
temperature_model = train_model(df, 'temperature_ok')
sunlight_model = train_model(df, 'sunlight_ok')
humidity_model = train_model(df, 'humidity_ok')

# Define a route to predict plant needs using the most recent data
@app.route('/predict', methods=['GET'])
def predict_plant_needs():
    # Fetch the most recent data for each field
    temperature = fetch_field_data('field1', field_urls['field1'])[-1]
    humidity = fetch_field_data('field2', field_urls['field2'])[-1]
    soil_moisture = fetch_field_data('field3', field_urls['field3'])[-1]
    sunlight_level = fetch_field_data('field4', field_urls['field4'])[-1]

    # Prepare the data for prediction using the most recent data
    input_data = pd.DataFrame({
        'field1': [temperature],  # temperature
        'field2': [humidity],     # humidity
        'field3': [soil_moisture],# soil moisture
        'field4': [sunlight_level]# sunlight level
    })

    # Make the predictions for water, temperature, sunlight, and humidity
    water_prediction = water_model.predict(input_data)[0]
    temperature_prediction = temperature_model.predict(input_data)[0]
    sunlight_prediction = sunlight_model.predict(input_data)[0]
    humidity_prediction = humidity_model.predict(input_data)[0]

    # Interpret the predictions and provide actionable feedback
    water_result = "I am thirsty" if water_prediction == 1 else "I am not thirsty"
    
    if temperature_prediction == 1:
        temperature_result = "Temperature is suitable"
    else:
        if temperature < 18:
            temperature_result = "Temperature is too low, should be increased"
        elif temperature > 28:
            temperature_result = "Temperature is too high, should be decreased"
        else:
            temperature_result = "Temperature is not suitable"

    if sunlight_prediction == 1:
        sunlight_result = "Sunlight is sufficient"
    else:
        if sunlight_level < 800:
            sunlight_result = "Sunlight is too low, plant needs more sunlight"
        elif sunlight_level > 1200:
            sunlight_result = "Sunlight is too high, plant may be getting too much sun"

    if humidity_prediction == 1:
        humidity_result = "Humidity is ideal"
    else:
        if humidity < 40:
            humidity_result = "Humidity is too low, plant needs a more humid environment"
        elif humidity > 60:
            humidity_result = "Humidity is too high, plant needs a less humid environment"

    # Return the predictions and actionable advice as a JSON response
    return jsonify({
        'water_prediction': water_result,
        'temperature_prediction': temperature_result,
        'sunlight_prediction': sunlight_result,
        'humidity_prediction': humidity_result,
        'temperature': temperature,
        'humidity': humidity,
        'soil_moisture': soil_moisture,
        'sunlight_level': sunlight_level
    })

if __name__ == '__main__':
    host = '0.0.0.0'
    print(f"API endpoint is running at: http://{host}:{PORT}/predict")
    app.run(debug=True, host=host, port=PORT)
