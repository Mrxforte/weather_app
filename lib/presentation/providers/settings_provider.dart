import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/city_entity.dart';

// Manages user settings, favorites, and app preferences
class SettingsProvider extends ChangeNotifier {
  final SharedPreferences _prefs;

  SettingsProvider(this._prefs) {
    _loadSettings();
  }

  // Temperature: true = Fahrenheit, false = Celsius
  bool _isFahrenheit = false;
  bool get isFahrenheit => _isFahrenheit;

  // Wind speed: true = mph, false = km/h
  bool _isMph = false;
  bool get isMph => _isMph;

  // Theme mode
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  // Language code
  String _languageCode = 'en';
  String get languageCode => _languageCode;
  Locale get locale => Locale(_languageCode);

  // Whether onboarding has been completed
  bool _onboardingDone = false;
  bool get onboardingDone => _onboardingDone;

  // Pattern lock
  String? _patternLock;
  bool get isPatternLockEnabled =>
      _patternLock != null && _patternLock!.isNotEmpty;
  String? get patternLock => _patternLock;

  // Daily notification
  bool _dailyNotification = false;
  bool get dailyNotification => _dailyNotification;

  // Favorite cities list
  List<CityEntity> _favorites = [];
  List<CityEntity> get favorites => List.unmodifiable(_favorites);

  // Search history cache (max 20)
  List<CityEntity> _searchHistory = [];
  List<CityEntity> get searchHistory => List.unmodifiable(_searchHistory);
  List<CityEntity> get recentSearches => _searchHistory.take(5).toList();

  void _loadSettings() {
    _isFahrenheit = _prefs.getString(AppConstants.keyTemperatureUnit) == 'F';
    _isMph = _prefs.getString(AppConstants.keyWindSpeedUnit) == 'mph';
    _onboardingDone = _prefs.getBool(AppConstants.keyOnboardingDone) ?? false;

    // Load theme preference
    final themeStr = _prefs.getString(AppConstants.keyThemeMode);
    _themeMode = switch (themeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    // Load language
    _languageCode = _prefs.getString(AppConstants.keyLanguage) ?? 'en';

    // Load pattern lock
    _patternLock = _prefs.getString(AppConstants.keyPatternLock);

    // Load daily notification
    _dailyNotification =
        _prefs.getBool(AppConstants.keyDailyNotification) ?? false;

    // Load saved favorites
    final favJson = _prefs.getStringList(AppConstants.keyFavoriteCities) ?? [];
    _favorites = favJson
        .map((s) => CityEntity.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();

    // Load cached search history
    final historyJson =
        _prefs.getStringList(AppConstants.keySearchHistory) ?? [];
    _searchHistory = historyJson
        .map((s) => CityEntity.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> setTemperatureUnit(bool fahrenheit) async {
    _isFahrenheit = fahrenheit;
    await _prefs.setString(
      AppConstants.keyTemperatureUnit,
      fahrenheit ? 'F' : 'C',
    );
    notifyListeners();
  }

  Future<void> setWindSpeedUnit(bool mph) async {
    _isMph = mph;
    await _prefs.setString(AppConstants.keyWindSpeedUnit, mph ? 'mph' : 'kmh');
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final str = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(AppConstants.keyThemeMode, str);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _languageCode = code;
    await _prefs.setString(AppConstants.keyLanguage, code);
    notifyListeners();
  }

  Future<void> setPatternLock(String? pattern) async {
    _patternLock = pattern;
    if (pattern != null && pattern.isNotEmpty) {
      await _prefs.setString(AppConstants.keyPatternLock, pattern);
    } else {
      await _prefs.remove(AppConstants.keyPatternLock);
    }
    notifyListeners();
  }

  Future<void> setDailyNotification(bool enabled) async {
    _dailyNotification = enabled;
    await _prefs.setBool(AppConstants.keyDailyNotification, enabled);
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    await _prefs.setBool(AppConstants.keyOnboardingDone, true);
    notifyListeners();
  }

  bool isFavorite(CityEntity city) => _favorites.contains(city);

  Future<void> toggleFavorite(CityEntity city) async {
    if (_favorites.contains(city)) {
      _favorites.remove(city);
    } else {
      _favorites.add(city);
    }
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> removeFavorite(CityEntity city) async {
    _favorites.remove(city);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final favJson = _favorites.map((c) => jsonEncode(c.toJson())).toList();
    await _prefs.setStringList(AppConstants.keyFavoriteCities, favJson);
  }

  Future<void> addSearchHistory(CityEntity city) async {
    _searchHistory.remove(city);
    _searchHistory.insert(0, city);
    if (_searchHistory.length > 20) {
      _searchHistory = _searchHistory.take(20).toList();
    }
    await _saveSearchHistory();
    notifyListeners();
  }

  List<CityEntity> searchSuggestions(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return recentSearches;
    return _searchHistory
        .where(
          (c) =>
              c.name.toLowerCase().contains(q) ||
              c.displayName.toLowerCase().contains(q),
        )
        .take(5)
        .toList();
  }

  Future<void> clearSearchHistory() async {
    _searchHistory = [];
    await _prefs.remove(AppConstants.keySearchHistory);
    notifyListeners();
  }

  Future<void> _saveSearchHistory() async {
    final historyJson = _searchHistory
        .map((c) => jsonEncode(c.toJson()))
        .toList();
    await _prefs.setStringList(AppConstants.keySearchHistory, historyJson);
  }
}
