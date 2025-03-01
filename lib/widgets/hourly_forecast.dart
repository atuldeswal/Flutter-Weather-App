import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/config/theme/weather_app_theme.dart';
import 'package:weather/data/models/weather_model.dart';

class HourlyForecastCard extends StatelessWidget {
  final HourlyForecast forecast;
  final bool isSelected;
  final VoidCallback onTap;

  const HourlyForecastCard({
    Key? key,
    required this.forecast,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF5D50FE), Color(0xFF3F51B5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : WeatherAppTheme.cardGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('h a').format(forecast.time),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Icon(
                WeatherAppTheme.getWeatherIcon(forecast.sky),
                size: 30,
                color: WeatherAppTheme.accentColor,
              ),
              const SizedBox(height: 12),
              Text(
                '${forecast.temp.toStringAsFixed(1)}°C',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}