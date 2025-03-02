import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/widgets/city_search.dart';
import 'package:weather/config/theme/weather_app_theme.dart';
import 'package:weather/widgets/additional_info.dart';
import 'package:weather/widgets/hourly_forecast.dart';
import 'package:weather/widgets/weather_details.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  late Future<WeatherModel> _weatherFuture;
  String _cityName = 'London';
  int _selectedForecastIndex = 0;
  List<String> _recentSearches = [];
  bool _isLocationLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize _weatherFuture immediately to prevent null errors
    _weatherFuture = _weatherService.getWeatherByCity('London');
    _loadLastSearch();
  }

  Future<void> _loadLastSearch() async {
    final lastCity = await _weatherService.getLastSearch();
    final searches = await _weatherService.getRecentSearches();
    
    setState(() {
      _cityName = lastCity;
      _recentSearches = searches;
      // Refresh weather with the loaded city
      _weatherFuture = _weatherService.getWeatherByCity(_cityName);
    });
  }

  void _refreshWeather() {
    setState(() {
      _selectedForecastIndex = 0;
      _weatherFuture = _weatherService.getWeatherByCity(_cityName);
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLocationLoading = true;
    });

    try {
      // Request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permission denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permission permanently denied';
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition();

      // Get weather for the location
      setState(() {
        _weatherFuture = _weatherService.getWeatherByLocation(
          position.latitude,
          position.longitude,
        );
      });

      // Update city name after getting the weather
      final weather = await _weatherFuture;
      setState(() {
        _cityName = weather.cityName;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLocationLoading = false;
      });
    }
  }

  void _showSearchModal() async {
    // Update recent searches list first
    _recentSearches = await _weatherService.getRecentSearches();

    showModalBottomSheet(
      context: context,
      backgroundColor: WeatherAppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CitySearch(
            recentSearches: _recentSearches,
            onCitySelected: (city) {
              setState(() {
                _cityName = city;
                _refreshWeather();
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Weather App',
          style: WeatherAppTheme.titleStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchModal,
          ),
          IconButton(
            icon: _isLocationLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.my_location),
            onPressed: _isLocationLoading ? null : _getCurrentLocation,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshWeather,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: WeatherAppTheme.primaryGradient,
        ),
        child: FutureBuilder<WeatherModel>(
          future: _weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: WeatherAppTheme.accentColor,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _refreshWeather,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: WeatherAppTheme.accentColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Data Available'),
              );
            }

            final weatherData = snapshot.data!;

            // Create a current weather HourlyForecast with the correct types
            final currentForecast = HourlyForecast(
              time: DateTime.now(),
              sky: weatherData.currentSky,
              temp: weatherData.currentTemp,
              humidity: weatherData.humidity,  // This is already an int as required by HourlyForecast
              windSpeed: weatherData.windSpeed,
            );

            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Weather details card for the selected forecast
                      WeatherDetails(
                        forecast: _selectedForecastIndex == 0
                            ? currentForecast
                            : weatherData.hourlyForecasts[_selectedForecastIndex - 1],
                        cityName: weatherData.cityName,
                      ),
                      const SizedBox(height: 30),

                      // Last updated
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Hourly Forecast',
                              style: WeatherAppTheme.headingStyle,
                            ),
                            Text(
                              'Updated: ${DateFormat('h:mm a').format(weatherData.lastUpdated)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: WeatherAppTheme.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Hourly forecast
                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          itemCount: weatherData.hourlyForecasts.length + 1,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              // Current weather
                              return HourlyForecastCard(
                                forecast: currentForecast,
                                isSelected: _selectedForecastIndex == 0,
                                onTap: () {
                                  setState(() {
                                    _selectedForecastIndex = 0;
                                  });
                                },
                              );
                            }

                            final hourlyForecast =
                                weatherData.hourlyForecasts[index - 1];
                            return HourlyForecastCard(
                              forecast: hourlyForecast,
                              isSelected: _selectedForecastIndex == index,
                              onTap: () {
                                setState(() {
                                  _selectedForecastIndex = index;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Additional information
                      const Text(
                        'Additional Information',
                        style: WeatherAppTheme.headingStyle,
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdditionalInfo(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            value: '${weatherData.humidity}%',
                          ),
                          AdditionalInfo(
                            icon: Icons.air,
                            label: 'Wind Speed',
                            value: '${weatherData.windSpeed.toStringAsFixed(1)} m/s',
                          ),
                          AdditionalInfo(
                            icon: Icons.compress,
                            label: 'Pressure',
                            value: '${weatherData.pressure} hPa',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
