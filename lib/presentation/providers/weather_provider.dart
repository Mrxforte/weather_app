import 'package:flutter/material.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/entities/air_quality_entity.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/weather_repository.dart';

// Main weather state provider that powers most screens
class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository;

  WeatherProvider(this._repository);

  // Current weather
  WeatherEntity? _currentWeather;
  WeatherEntity? get currentWeather => _currentWeather;

  // Forecast
  ForecastListEntity? _forecast;
  ForecastListEntity? get forecast => _forecast;

  // Air quality
  AirQualityEntity? _airQuality;
  AirQualityEntity? get airQuality => _airQuality;

  // Search results
  List<CityEntity> _searchResults = [];
  List<CityEntity> get searchResults => _searchResults;

  // Loading and error states
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // The city we're currently showing weather for
  CityEntity? _selectedCity;
  CityEntity? get selectedCity => _selectedCity;

  // Last time we successfully fetched data
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;

  // Load all weather data for a location at once
  Future<void> loadWeatherData(
    double lat,
    double lon, {
    String? cityName,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fire all three requests in parallel for speed
      final results = await Future.wait([
        _repository.getCurrentWeather(lat, lon),
        _repository.getForecast(lat, lon),
        _repository.getAirQuality(lat, lon),
      ]);

      _currentWeather = results[0] as WeatherEntity;
      _forecast = results[1] as ForecastListEntity;
      _airQuality = results[2] as AirQualityEntity;
      _lastUpdated = DateTime.now();

      if (cityName != null) {
        _selectedCity = CityEntity(
          name: cityName,
          country: _currentWeather!.country,
          lat: lat,
          lon: lon,
        );
      }
    } catch (e) {
      _errorMessage = _parseError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search for cities by name
  Future<void> searchCities(String query) async {
    if (query.trim().length < 2) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      _searchResults = await _repository.searchCities(query.trim());
    } catch (e) {
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }

  // Refresh current location data
  Future<void> refresh() async {
    if (_selectedCity != null) {
      await loadWeatherData(
        _selectedCity!.lat,
        _selectedCity!.lon,
        cityName: _selectedCity!.name,
      );
    }
  }

  // Turn API exceptions into error type keys
  String _parseError(dynamic error) {
    final msg = error.toString().toLowerCase();
    if (msg.contains('socket') || msg.contains('connection')) {
      return 'network';
    }
    if (msg.contains('timeout')) {
      return 'timeout';
    }
    if (msg.contains('401')) {
      return 'apiKey';
    }
    if (msg.contains('404')) {
      return 'notFound';
    }
    if (msg.contains('429')) {
      return 'rateLimit';
    }
    if (msg.contains('500') || msg.contains('502') || msg.contains('503')) {
      return 'server';
    }
    return 'unknown';
  }
}
