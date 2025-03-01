import 'package:flutter/material.dart';
import 'package:weather/config/theme/weather_app_theme.dart';
import 'package:weather/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: WeatherAppTheme.darkTheme,
      home: const WeatherScreen(),
    );
  }
}