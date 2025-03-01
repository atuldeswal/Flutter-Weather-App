import 'package:flutter/material.dart';

class WeatherAppTheme {
  // App-wide colors
  static const Color primaryColor = Color(0xFF5D50FE);
  static const Color secondaryColor = Color(0xFF90CAF9);
  static const Color accentColor = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFF303F9F);
  static const Color cardColor = Color(0xFF3F51B5);
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFBBDEFB);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF303F9F), Color(0xFF1A237E)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3F51B5), Color(0xFF303F9F)],
  );

  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle temperatureStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle headingStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
  );

  // Theme data
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: titleStyle,
        iconTheme: IconThemeData(color: textColor),
      ),
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      iconTheme: const IconThemeData(color: accentColor),
      textTheme: const TextTheme(
        displayLarge: titleStyle,
        displayMedium: temperatureStyle,
        displaySmall: headingStyle,
        titleMedium: subheadingStyle,
        bodyLarge: bodyStyle,
      ),
    );
  }

  // Weather icons mapping
  static IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return Icons.cloud_queue;
      default:
        return Icons.wb_sunny;
    }
  }
}
