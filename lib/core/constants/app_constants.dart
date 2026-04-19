// General app-wide constants
class AppConstants {
  AppConstants._();

  static const String appName = 'WeatherNow';
  static const String appVersion = '2.0.0';

  // Shared prefs keys
  static const String keyOnboardingDone = 'onboarding_done';
  static const String keyTemperatureUnit = 'temperature_unit';
  static const String keyWindSpeedUnit = 'wind_speed_unit';
  static const String keyFavoriteCities = 'favorite_cities';
  static const String keySearchHistory = 'search_history';
  static const String keyLastCity = 'last_city';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyPatternLock = 'pattern_lock';
  static const String keyDailyNotification = 'daily_notification';

  // Default config
  static const String defaultCity = 'London';
  static const double defaultLat = 51.5074;
  static const double defaultLon = -0.1278;

  // Supported locales
  static const supportedLocales = ['en', 'ru', 'uz', 'ar', 'fr', 'de', 'es'];
  static const Map<String, String> localeNames = {
    'en': 'English',
    'ru': 'Русский',
    'uz': 'O\'zbekcha',
    'ar': 'العربية',
    'fr': 'Français',
    'de': 'Deutsch',
    'es': 'Español',
  };
}
