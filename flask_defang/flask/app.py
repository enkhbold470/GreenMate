from flask import Flask, jsonify, render_template
import pandas as pd
import requests
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
import os
from dotenv import load_dotenv

load_dotenv()

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

# Model training and setup
def train_model():
    print("Fetching data for training...")

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

    # Define target variable: needs water
    def needs_water(row):
        return 1 if row['field3'] < 30 else 0

    df['needs_water'] = df.apply(needs_water, axis=1)

    # Prepare features and labels
    X = df[['field1', 'field2', 'field3', 'field4']]
    y = df['needs_water']

    # Train the model
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)

    return model

# Initialize and train model
model = train_model()

# Define a route to render the HTML page
@app.route('/')
def home():
    return render_template('index.html')

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

    # Make the prediction
    prediction = model.predict(input_data)

    # Return the result as a JSON response
    result = "Plant needs water" if prediction[0] == 1 else "Plant does not need water"
    return jsonify({
        'prediction': result,
        'temperature': temperature,
        'humidity': humidity,
        'soil_moisture': soil_moisture,
        'sunlight_level': sunlight_level
    })

if __name__ == '__main__':
    host = '0.0.0.0'
    print(f"API endpoint is running at: http://{host}:{os.getenv('PORT')}/predict")
    app.run(debug=True, host=host, port=os.getenv('PORT'))
