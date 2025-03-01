import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/config/theme/weather_app_theme.dart';
import 'package:weather/data/models/weather_model.dart';

class WeatherDetails extends StatelessWidget {
  final HourlyForecast forecast;
  final String cityName;
  
  const WeatherDetails({
    Key? key,
    required this.forecast,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: WeatherAppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, d MMM').format(forecast.time),
                    style: const TextStyle(
                      fontSize: 16,
                      color: WeatherAppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('h:mm a').format(forecast.time),
                    style: const TextStyle(
                      fontSize: 14,
                      color: WeatherAppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                cityName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${forecast.temp.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        forecast.sky,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        WeatherAppTheme.getWeatherIcon(forecast.sky),
                        color: WeatherAppTheme.accentColor,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                WeatherAppTheme.getWeatherIcon(forecast.sky),
                color: WeatherAppTheme.accentColor,
                size: 80,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white30),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailItem(Icons.water_drop, 'Humidity', '${forecast.humidity}%'),
              _buildDetailItem(Icons.air, 'Wind', '${forecast.windSpeed.toStringAsFixed(1)} m/s'),
              _buildDetailItem(Icons.thermostat, 'Feels Like', '${(forecast.temp - 1.5).toStringAsFixed(1)}°C'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: WeatherAppTheme.accentColor,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: WeatherAppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}