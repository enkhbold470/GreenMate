# GreenMate

GreenMate is a hardware-software integrated system designed to monitor plant health by detecting environmental parameters like soil moisture, light, and humidity levels. It uses predictive modeling to automate plant watering and utilizes both IoT and AI technologies for optimal plant care.

<img width="1317" alt="image" src="https://github.com/user-attachments/assets/ed6a1249-a96b-4222-b0d4-8c13819c162b">

## Snap AR Plant Tracking

https://github.com/user-attachments/assets/4899f539-b5b0-4cac-8d50-52982a8c6643



## Table of Contents

- [Architecture](#architecture)
  - [Hardware Components](#hardware-components)
  - [Software Components](#software-components)
- [Sponsors](#sponsors)
- [Competition Tracks](#competition-tracks)

## Architecture

### Hardware Components
<img width="1363" alt="image" src="https://github.com/user-attachments/assets/a9a1c82f-92f2-439b-aa19-d31bef9a6e80">

The hardware setup of GreenMate revolves around the **ESP32S3** microcontroller, which serves as the central hub for sensor data collection and wireless communication.

- **ESP32S3**: A powerful microcontroller used to gather data from various sensors and transmit it to software platforms for analysis.
- **Soil Moisture Sensor**: Measures the moisture level in the soil, allowing the system to assess when plants need watering.
- **WiFi Module**: Enables wireless data transfer from the ESP32S3 to cloud-based software.
- **Photoresistor Light Sensor**: Monitors the light intensity, which influences plant growth and watering needs.
- **DHT11 Humidity Sensor**: Captures environmental humidity and temperature, contributing to an accurate watering prediction model.
- **Snap AR Spectacles**: Augmented reality glasses used for visualization or capturing plant data.

### Software Components

GreenMate’s software ecosystem collects, analyzes, and visualizes data to make intelligent decisions about plant care.

- **ThingSpeak**: An IoT analytics platform for aggregating sensor data and visualizing trends in real-time.
- **MATLAB**: Used for data analysis and developing the prediction models based on sensor data.
- **Next.js**: A React framework that powers the **PWA (Progressive Web App)**, providing an intuitive user interface for monitoring and managing plant health.
- **PWA App**: A Progressive Web App that offers cross-platform access to GreenMate’s functionalities.
- **Kaggle**: A platform leveraged for data science purposes, likely involved in building the **Watering Prediction Model**.
- **Flask**: A Python-based web framework that hosts the watering prediction model and handles backend operations.
- **Watering Prediction Model**: A predictive model (machine learning or rule-based) to intelligently determine the optimal time to water plants.

## Sponsors

GreenMate is supported and sponsored by several organizations that provide resources, technology, and awards:

- **Snap AR**: Sponsor for the use of augmented reality technology through Snap AR Spectacles.
- **GoDaddy Registry (Best Domain Name)**: Supporting the project’s domain registration and providing recognition for creative domain naming.
- **NotebookLM**: A sponsor track focusing on the most innovative and creative use of the NotebookLM technology.

## Competition Tracks

GreenMate is part of various competition tracks, each highlighting different aspects of the project:

- **Snap AR Spectacles**: Demonstrating creative and impactful uses of Snap AR technology within GreenMate.
- **Most Creative Use of NotebookLM**: Acknowledging the innovative use of NotebookLM technology in the project.
- **Environment**: Recognizing projects that focus on environmental sustainability and positive ecological impact.
- **Hardware**: Highlighting the hardware innovation and integration in the project.
- **Best Selfie**: A fun and creative track focused on using Snap AR Spectacles to take interesting selfies.
- **Best Use of Defang**: A track rewarding unique technical implementations or creative challenges solved in the project.

---

<img width="1424" alt="image" src="https://github.com/user-attachments/assets/7ec89f57-f47e-4cc1-8868-61ac67066696">
