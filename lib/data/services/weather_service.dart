import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/static/api_keys.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherService {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  
  // Get weather for a city
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/forecast?q=$cityName&APPID=$apiKey'),
      );

      if (response.statusCode != 200) {
        throw 'Failed to load weather data. Status code: ${response.statusCode}';
      }

      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw 'API Error: ${data['message']}';
      }

      // Save the last search
      _saveLastSearch(cityName);
      
      return WeatherModel.fromJson(data);
    } catch (e) {
      throw e.toString();
    }
  }

  // Get weather by geolocation
  Future<WeatherModel> getWeatherByLocation(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/forecast?lat=$lat&lon=$lon&APPID=$apiKey'),
      );

      if (response.statusCode != 200) {
        throw 'Failed to load weather data. Status code: ${response.statusCode}';
      }

      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw 'API Error: ${data['message']}';
      }

      // Save the city name from response
      final cityName = data['city']['name'];
      _saveLastSearch(cityName);
      
      return WeatherModel.fromJson(data);
    } catch (e) {
      throw e.toString();
    }
  }

  // Save last search to local storage
  Future<void> _saveLastSearch(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get existing searches
    List<String> recentSearches = prefs.getStringList('recent_searches') ?? [];
    
    // Remove if already exists and add to beginning
    recentSearches.remove(cityName);
    recentSearches.insert(0, cityName);
    
    // Keep only last 5 searches
    if (recentSearches.length > 5) {
      recentSearches = recentSearches.sublist(0, 5);
    }
    
    await prefs.setStringList('recent_searches', recentSearches);
    await prefs.setString('last_search', cityName);
  }

  // Get recent searches
  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recent_searches') ?? [];
  }

  // Get last search
  Future<String> getLastSearch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_search') ?? 'London';
  }
}