import 'package:flutter/material.dart';

class WeatherModel {
  final String cityName;
  final String countryCode;
  final double currentTemp;
  final String currentSky;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final List<HourlyForecast> hourlyForecasts;
  final DateTime lastUpdated;

  WeatherModel({
    required this.cityName,
    required this.countryCode,
    required this.currentTemp,
    required this.currentSky,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.hourlyForecasts,
    required this.lastUpdated,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final city = json['city'];
    final List forecastList = json['list'];
    
    return WeatherModel(
      cityName: city['name'],
      countryCode: city['country'],
      currentTemp: (forecastList[0]['main']['temp'] - 273.15),
      currentSky: forecastList[0]['weather'][0]['main'],
      humidity: forecastList[0]['main']['humidity'],
      windSpeed: forecastList[0]['wind']['speed'],
      pressure: forecastList[0]['main']['pressure'],
      lastUpdated: DateTime.now(),
      hourlyForecasts: List<HourlyForecast>.from(
        forecastList.take(8).map((item) => HourlyForecast.fromJson(item))
      ),
    );
  }
}

class HourlyForecast {
  final DateTime time;
  final String sky;
  final double temp;
  final int humidity;
  final double windSpeed;

  HourlyForecast({
    required this.time,
    required this.sky,
    required this.temp,
    required this.humidity,
    required this.windSpeed,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      sky: json['weather'][0]['main'],
      temp: (json['main']['temp'] - 273.15),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}