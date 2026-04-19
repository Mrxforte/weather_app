import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

// Handles all HTTP calls to the WeatherAPI.com endpoints
class WeatherApiService {
  final Dio _dio;

  // Simple cache so the 3 parallel calls from the provider
  // only trigger one actual HTTP request
  Map<String, dynamic>? _cachedForecast;
  String? _cachedKey;
  DateTime? _cachedAt;

  WeatherApiService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  // Internal fetch with short-lived cache (30s)
  Future<Map<String, dynamic>> _fetchForecast(double lat, double lon) async {
    final key = '${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';
    if (_cachedKey == key &&
        _cachedAt != null &&
        DateTime.now().difference(_cachedAt!).inSeconds < 30) {
      return _cachedForecast!;
    }

    final response = await _dio.get(
      ApiConstants.forecast,
      queryParameters: {
        'key': ApiConstants.apiKey,
        'q': '$lat,$lon',
        'days': 3,
        'aqi': 'yes',
      },
    );
    _cachedForecast = response.data as Map<String, dynamic>;
    _cachedKey = key;
    _cachedAt = DateTime.now();
    return _cachedForecast!;
  }

  // Returns the full forecast response (current + forecast + AQ)
  Future<Map<String, dynamic>> getCurrentWeather(double lat, double lon) =>
      _fetchForecast(lat, lon);

  Future<Map<String, dynamic>> getForecast(double lat, double lon) =>
      _fetchForecast(lat, lon);

  Future<Map<String, dynamic>> getAirQuality(double lat, double lon) =>
      _fetchForecast(lat, lon);

  // Search cities by name
  Future<List<dynamic>> searchCities(String query) async {
    final response = await _dio.get(
      ApiConstants.search,
      queryParameters: {'key': ApiConstants.apiKey, 'q': query},
    );
    return response.data as List<dynamic>;
  }

  // Bust the cache so the next request makes a fresh call
  void clearCache() {
    _cachedForecast = null;
    _cachedKey = null;
    _cachedAt = null;
  }
}
