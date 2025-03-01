import 'package:flutter/material.dart';
import 'package:weather/config/theme/weather_app_theme.dart';

class AdditionalInfo extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  
  const AdditionalInfo({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WeatherAppTheme.cardColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: WeatherAppTheme.accentColor,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: WeatherAppTheme.subheadingStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}