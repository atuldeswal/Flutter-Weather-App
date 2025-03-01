import 'package:flutter/material.dart';
import 'package:weather/config/theme/weather_app_theme.dart';

class CitySearch extends StatefulWidget {
  final List<String> recentSearches;
  final Function(String) onCitySelected;

  const CitySearch({
    Key? key,
    required this.recentSearches,
    required this.onCitySelected,
  }) : super(key: key);

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search City',
            style: WeatherAppTheme.headingStyle,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter city name',
              prefixIcon: const Icon(Icons.search, color: WeatherAppTheme.accentColor),
              filled: true,
              fillColor: WeatherAppTheme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            style: const TextStyle(color: Colors.white),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                widget.onCitySelected(value);
                Navigator.pop(context);
              }
            },
          ),
          if (widget.recentSearches.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Recent Searches',
              style: WeatherAppTheme.subheadingStyle,
            ),
            const SizedBox(height: 8),
            ...widget.recentSearches.map((city) => ListTile(
              leading: const Icon(Icons.history, color: WeatherAppTheme.accentColor),
              title: Text(city, style: const TextStyle(color: Colors.white)),
              onTap: () {
                widget.onCitySelected(city);
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ],
      ),
    );
  }
}