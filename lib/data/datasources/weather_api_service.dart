import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/services/cache_service.dart';

// Handles all HTTP calls to the WeatherAPI.com endpoints
class WeatherApiService {
  final Dio _dio;
  final CacheService? _cacheService;

  // Simple cache so the 3 parallel calls from the provider
  // only trigger one actual HTTP request
  Map<String, dynamic>? _cachedForecast;
  String? _cachedKey;
  DateTime? _cachedAt;

  WeatherApiService({Dio? dio, CacheService? cacheService})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          ),
      _cacheService = cacheService;

  // Internal fetch with short-lived cache (30s) and persistent disk cache
  Future<Map<String, dynamic>> _fetchForecast(double lat, double lon) async {
    final key = '${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';

    // Memory cache (30s)
    if (_cachedKey == key &&
        _cachedAt != null &&
        DateTime.now().difference(_cachedAt!).inSeconds < 30) {
      return _cachedForecast!;
    }

    try {
      final response = await _dio.get(
        ApiConstants.forecast,
        queryParameters: {
          'key': ApiConstants.apiKey,
          'q': '$lat,$lon',
          'days': 3,
          'aqi': 'yes',
        },
      );

      final data = response.data as Map<String, dynamic>;
      _cachedForecast = data;
      _cachedKey = key;
      _cachedAt = DateTime.now();

      // Persist to disk for offline use
      _cacheService?.cacheWeatherData(cityKey: key, data: data);

      return data;
    } on DioException {
      // Network failed — try disk cache
      final cached = _cacheService?.getCachedWeatherData(cityKey: key);
      if (cached != null) return cached;

      // Try any cached data regardless of city
      final anyCached = _cacheService?.getCachedWeatherData();
      if (anyCached != null) return anyCached;

      rethrow;
    }
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
