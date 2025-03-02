# ModernWeather App

A beautifully designed weather application built with Flutter that provides real-time weather information with a modern UI and intuitive user experience.

## Features

- 🌦️ **Real-time Weather Data**: Current conditions and hourly forecasts
- 📍 **Location-based Weather**: Get weather based on your current location
- 🔍 **City Search**: Search for weather in any city worldwide
- 📋 **Recent Searches**: Quick access to your previously searched locations
- 📱 **Modern UI Design**: Beautiful, intuitive interface with smooth animations
- 🌓 **Detailed Weather Info**: Temperature, sky conditions, humidity, wind speed, and pressure
- 💾 **Persistent Storage**: Remembers your last search and settings

## Screenshots

<p align="center">
  <img src="screenshots/Home Screen.png" alt="Home Screen" width="250"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/Search Screen.png" alt="Search Screen" width="250"/>
</p>

## Installation

1. Clone this repository:
```
git clone https://github.com/atuldeswal/Flutter-Weather-App.git
```

2. Navigate to the project directory:
```
cd modern_weather
```

3. Get the dependencies:
```
flutter pub get
```

4. Create an API key:
   - Sign up at [OpenWeatherMap](https://openweathermap.org/api) to get your API key
   - Create a file at `lib/static/api_keys.dart` with the following content:
   ```dart
   const String apiKey = 'YOUR_API_KEY_HERE';
   ```

5. Run the app:
```
flutter run
```

## Project Structure

```
lib/
├── config/                   # Configuration files
│   └── theme/                # Theme configuration
│       └── weather_app_theme.dart
│
├── data/                     # Data layer
│   ├── models/               # Data models
│   │   └── weather_model.dart
│   └── services/             # API and data services
│       └── weather_service.dart
│
├── screens/                  # App screens
│   └── weather_screen.dart
│
├── widgets/                  # Reusable widgets
│   ├── additional_info.dart
│   ├── city_search.dart
│   ├── hourly_forecast.dart
│   └── weather_details.dart
│
├── static/                   # Static resources
│   └── api_keys.dart
│
└── main.dart                 # App entry point
```

## Dependencies

- [flutter](https://flutter.dev/) - UI toolkit for building natively compiled applications
- [http](https://pub.dev/packages/http) - HTTP requests for the weather API
- [intl](https://pub.dev/packages/intl) - For date/time formatting
- [geolocator](https://pub.dev/packages/geolocator) - For location services
- [shared_preferences](https://pub.dev/packages/shared_preferences) - For local storage

## API

This application uses the [OpenWeatherMap API](https://openweathermap.org/api) to fetch weather data.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Acknowledgments

- Weather data provided by [OpenWeatherMap](https://openweathermap.org/)
- Icons and design inspiration from [Material Design](https://material.io/design)
