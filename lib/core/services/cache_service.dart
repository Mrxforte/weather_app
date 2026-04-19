import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Caches weather API responses in SharedPreferences for offline use.
class CacheService {
  final SharedPreferences _prefs;

  static const String _keyWeatherCache = 'weather_cache';
  static const String _keyCacheTimestamp = 'weather_cache_timestamp';
  static const String _keyCacheCity = 'weather_cache_city';
  static const Duration maxCacheAge = Duration(hours: 1);

  CacheService(this._prefs);

  /// Save the raw API JSON response for a given city
  Future<void> cacheWeatherData({
    required String cityKey,
    required Map<String, dynamic> data,
  }) async {
    await _prefs.setString(_keyWeatherCache, jsonEncode(data));
    await _prefs.setInt(
      _keyCacheTimestamp,
      DateTime.now().millisecondsSinceEpoch,
    );
    await _prefs.setString(_keyCacheCity, cityKey);
  }

  /// Get cached weather data if it exists and is not too old
  Map<String, dynamic>? getCachedWeatherData({String? cityKey}) {
    final json = _prefs.getString(_keyWeatherCache);
    if (json == null) return null;

    // If a specific city was requested, check it matches
    if (cityKey != null) {
      final cachedCity = _prefs.getString(_keyCacheCity);
      if (cachedCity != cityKey) return null;
    }

    return jsonDecode(json) as Map<String, dynamic>;
  }

  /// Check if cache is still fresh
  bool isCacheFresh() {
    final timestamp = _prefs.getInt(_keyCacheTimestamp);
    if (timestamp == null) return false;
    final cachedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cachedAt) < maxCacheAge;
  }

  /// Get the cached city key
  String? get cachedCityKey => _prefs.getString(_keyCacheCity);

  /// Get cache age as Duration
  Duration? get cacheAge {
    final timestamp = _prefs.getInt(_keyCacheTimestamp);
    if (timestamp == null) return null;
    final cachedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cachedAt);
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    await _prefs.remove(_keyWeatherCache);
    await _prefs.remove(_keyCacheTimestamp);
    await _prefs.remove(_keyCacheCity);
  }
}
