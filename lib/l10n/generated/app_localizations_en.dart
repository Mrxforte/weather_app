// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'WeatherNow';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get searchCity => 'Search City';

  @override
  String get favorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get forecast => '3-Day Forecast';

  @override
  String get airQuality => 'Air Quality';

  @override
  String get weatherMap => 'Weather Map';

  @override
  String get weatherDetails => 'Weather Details';

  @override
  String get details => 'Details';

  @override
  String get tryAgain => 'Try Again';

  @override
  String updated(String time) {
    return 'Updated $time';
  }

  @override
  String get now => 'Now';

  @override
  String get hourlyForecast => 'Hourly Forecast';

  @override
  String get today => 'Today';

  @override
  String get feelsLike => 'Feels Like';

  @override
  String get humidity => 'Humidity';

  @override
  String get pressure => 'Pressure';

  @override
  String get wind => 'Wind';

  @override
  String get direction => 'Direction';

  @override
  String get visibility => 'Visibility';

  @override
  String get clouds => 'Clouds';

  @override
  String get gusts => 'Gusts';

  @override
  String get highLow => 'High / Low';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get sunset => 'Sunset';

  @override
  String get pollutants => 'Pollutants';

  @override
  String get healthAdvice => 'Health Advice';

  @override
  String get noWeatherData => 'No weather data available';

  @override
  String get noFavorites => 'No favorite cities yet';

  @override
  String get noFavoritesHint =>
      'Search for a city and add it to your favorites';

  @override
  String get noResults => 'No results found';

  @override
  String get searchHint => 'Enter city name...';

  @override
  String get minChars => 'Enter at least 2 characters';

  @override
  String get temperatureUnit => 'Temperature';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get windSpeed => 'Wind Speed';

  @override
  String get mph => 'Miles per hour';

  @override
  String get kmh => 'Kilometers per hour';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System default';

  @override
  String get themeLight => 'Light mode';

  @override
  String get themeDark => 'Dark mode';

  @override
  String get language => 'Language';

  @override
  String get units => 'Units';

  @override
  String get appearance => 'Appearance';

  @override
  String get more => 'More';

  @override
  String savedCities(int count) {
    return '$count saved';
  }

  @override
  String get appInfo => 'App information and credits';

  @override
  String get security => 'Security';

  @override
  String get appLock => 'App Lock';

  @override
  String get appLockHint => 'Protect your app with a pattern lock';

  @override
  String get patternSet => 'Pattern lock enabled';

  @override
  String get patternNotSet => 'Pattern lock disabled';

  @override
  String get setPattern => 'Draw your lock pattern';

  @override
  String get confirmPattern => 'Confirm your pattern';

  @override
  String get unlockApp => 'Draw pattern to unlock';

  @override
  String get patternSaved => 'Pattern lock enabled';

  @override
  String get patternRemoved => 'Pattern lock disabled';

  @override
  String get patternMismatch => 'Patterns don\'t match, try again';

  @override
  String get notifications => 'Notifications';

  @override
  String get dailyNotification => 'Daily Weather Update';

  @override
  String get dailyNotificationHint =>
      'Get weather notification once a day at 8:00 AM';

  @override
  String get notificationEnabled => 'Daily notification enabled';

  @override
  String get notificationDisabled => 'Daily notification disabled';

  @override
  String get networkError =>
      'No internet connection. Please check your network and try again.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get timeoutError => 'Connection timed out. Please try again.';

  @override
  String get unknownError => 'Something went wrong. Please try again.';

  @override
  String get rateLimitError => 'Too many requests. Please wait a moment.';

  @override
  String get apiKeyError => 'Invalid API key. Please check your configuration.';

  @override
  String get notFoundError => 'City not found. Try a different search.';

  @override
  String get good => 'Good';

  @override
  String get fair => 'Fair';

  @override
  String get moderate => 'Moderate';

  @override
  String get poor => 'Poor';

  @override
  String get veryPoor => 'Very Poor';

  @override
  String get unknown => 'Unknown';

  @override
  String get uvLow => 'Low';

  @override
  String get uvModerate => 'Moderate';

  @override
  String get uvHigh => 'High';

  @override
  String get uvVeryHigh => 'Very High';

  @override
  String get uvExtreme => 'Extreme';

  @override
  String get onboardingTitle1 => 'Real-Time Weather';

  @override
  String get onboardingDesc1 =>
      'Get accurate weather updates for any city in the world with real-time data.';

  @override
  String get onboardingTitle2 => '3-Day Forecast';

  @override
  String get onboardingDesc2 =>
      'Plan ahead with detailed hourly and daily forecasts up to 3 days.';

  @override
  String get onboardingTitle3 => 'Save Your Cities';

  @override
  String get onboardingDesc3 =>
      'Add your favorite cities for quick access to their weather anytime.';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get aboutDesc =>
      'WeatherNow brings you real-time weather data from around the world. Check current conditions, 3-day forecasts, air quality indexes, and more — all in a beautiful, easy-to-use interface.';

  @override
  String get dataSource => 'Data Source';

  @override
  String get dataSourceDesc =>
      'Weather data provided by WeatherAPI.com (free tier). This includes current conditions, 3-day hourly forecasts, air quality data, and city search.';

  @override
  String get builtWith => 'Built With';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyDesc =>
      'This app does not collect or store any personal data. Location is only used to fetch weather data and is never shared with third parties.';

  @override
  String get madeWith => 'Made with ❤️ using Flutter';

  @override
  String version(String v) {
    return 'Version $v';
  }

  @override
  String get aqiGoodAdvice =>
      'Air quality is satisfactory. Enjoy your outdoor activities!';

  @override
  String get aqiFairAdvice =>
      'Air quality is acceptable. Sensitive individuals should limit prolonged outdoor exertion.';

  @override
  String get aqiModerateAdvice =>
      'Sensitive groups may experience health effects. Consider reducing outdoor activities.';

  @override
  String get aqiPoorAdvice =>
      'Everyone may begin to experience health effects. Limit outdoor activities.';

  @override
  String get aqiVeryPoorAdvice =>
      'Health alert! Everyone should avoid outdoor activities.';

  @override
  String get layers => 'Layers';

  @override
  String get precipitation => 'Precipitation';

  @override
  String get temperature => 'Temperature';

  @override
  String get windLayer => 'Wind';

  @override
  String get pressureLayer => 'Pressure';

  @override
  String get location => 'Location';

  @override
  String get coordinates => 'Coordinates';
}
