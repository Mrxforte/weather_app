import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'WeatherNow'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchCity.
  ///
  /// In en, this message translates to:
  /// **'Search City'**
  String get searchCity;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @forecast.
  ///
  /// In en, this message translates to:
  /// **'Weekly Forecast'**
  String get forecast;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @airQuality.
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get airQuality;

  /// No description provided for @weatherMap.
  ///
  /// In en, this message translates to:
  /// **'Weather Map'**
  String get weatherMap;

  /// No description provided for @weatherDetails.
  ///
  /// In en, this message translates to:
  /// **'Weather Details'**
  String get weatherDetails;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @updated.
  ///
  /// In en, this message translates to:
  /// **'Updated {time}'**
  String updated(String time);

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @hourlyForecast.
  ///
  /// In en, this message translates to:
  /// **'Hourly Forecast'**
  String get hourlyForecast;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @feelsLike.
  ///
  /// In en, this message translates to:
  /// **'Feels Like'**
  String get feelsLike;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// No description provided for @clouds.
  ///
  /// In en, this message translates to:
  /// **'Clouds'**
  String get clouds;

  /// No description provided for @gusts.
  ///
  /// In en, this message translates to:
  /// **'Gusts'**
  String get gusts;

  /// No description provided for @highLow.
  ///
  /// In en, this message translates to:
  /// **'High / Low'**
  String get highLow;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @sunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunset;

  /// No description provided for @pollutants.
  ///
  /// In en, this message translates to:
  /// **'Pollutants'**
  String get pollutants;

  /// No description provided for @healthAdvice.
  ///
  /// In en, this message translates to:
  /// **'Health Advice'**
  String get healthAdvice;

  /// No description provided for @noWeatherData.
  ///
  /// In en, this message translates to:
  /// **'No weather data available'**
  String get noWeatherData;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite cities yet'**
  String get noFavorites;

  /// No description provided for @noFavoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a city and add it to your favorites'**
  String get noFavoritesHint;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Enter city name...'**
  String get searchHint;

  /// No description provided for @minChars.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 2 characters'**
  String get minChars;

  /// No description provided for @temperatureUnit.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperatureUnit;

  /// No description provided for @fahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit (°F)'**
  String get fahrenheit;

  /// No description provided for @celsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius (°C)'**
  String get celsius;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get windSpeed;

  /// No description provided for @mph.
  ///
  /// In en, this message translates to:
  /// **'Miles per hour'**
  String get mph;

  /// No description provided for @kmh.
  ///
  /// In en, this message translates to:
  /// **'Kilometers per hour'**
  String get kmh;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get themeDark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @savedCities.
  ///
  /// In en, this message translates to:
  /// **'{count} saved'**
  String savedCities(int count);

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'App information and credits'**
  String get appInfo;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @appLock.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get appLock;

  /// No description provided for @appLockHint.
  ///
  /// In en, this message translates to:
  /// **'Protect your app with a pattern lock'**
  String get appLockHint;

  /// No description provided for @patternSet.
  ///
  /// In en, this message translates to:
  /// **'Pattern lock enabled'**
  String get patternSet;

  /// No description provided for @patternNotSet.
  ///
  /// In en, this message translates to:
  /// **'Pattern lock disabled'**
  String get patternNotSet;

  /// No description provided for @setPattern.
  ///
  /// In en, this message translates to:
  /// **'Draw your lock pattern'**
  String get setPattern;

  /// No description provided for @confirmPattern.
  ///
  /// In en, this message translates to:
  /// **'Confirm your pattern'**
  String get confirmPattern;

  /// No description provided for @unlockApp.
  ///
  /// In en, this message translates to:
  /// **'Draw pattern to unlock'**
  String get unlockApp;

  /// No description provided for @patternSaved.
  ///
  /// In en, this message translates to:
  /// **'Pattern lock enabled'**
  String get patternSaved;

  /// No description provided for @patternRemoved.
  ///
  /// In en, this message translates to:
  /// **'Pattern lock disabled'**
  String get patternRemoved;

  /// No description provided for @patternMismatch.
  ///
  /// In en, this message translates to:
  /// **'Patterns don\'t match, try again'**
  String get patternMismatch;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @dailyNotification.
  ///
  /// In en, this message translates to:
  /// **'Daily Weather Update'**
  String get dailyNotification;

  /// No description provided for @dailyNotificationHint.
  ///
  /// In en, this message translates to:
  /// **'Get weather notification once a day at 8:00 AM'**
  String get dailyNotificationHint;

  /// No description provided for @notificationEnabled.
  ///
  /// In en, this message translates to:
  /// **'Daily notification enabled'**
  String get notificationEnabled;

  /// No description provided for @notificationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Daily notification disabled'**
  String get notificationDisabled;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network and try again.'**
  String get networkError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get serverError;

  /// No description provided for @timeoutError.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again.'**
  String get timeoutError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get unknownError;

  /// No description provided for @rateLimitError.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please wait a moment.'**
  String get rateLimitError;

  /// No description provided for @apiKeyError.
  ///
  /// In en, this message translates to:
  /// **'Invalid API key. Please check your configuration.'**
  String get apiKeyError;

  /// No description provided for @notFoundError.
  ///
  /// In en, this message translates to:
  /// **'City not found. Try a different search.'**
  String get notFoundError;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get fair;

  /// No description provided for @moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// No description provided for @poor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get poor;

  /// No description provided for @veryPoor.
  ///
  /// In en, this message translates to:
  /// **'Very Poor'**
  String get veryPoor;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @uvLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get uvLow;

  /// No description provided for @uvModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get uvModerate;

  /// No description provided for @uvHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get uvHigh;

  /// No description provided for @uvVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get uvVeryHigh;

  /// No description provided for @uvExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get uvExtreme;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Weather'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Get accurate weather updates for any city in the world with real-time data.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Weekly Forecast'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Plan ahead with detailed hourly and daily forecasts up to 7 days.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Save Your Cities'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Add your favorite cities for quick access to their weather anytime.'**
  String get onboardingDesc3;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @aboutDesc.
  ///
  /// In en, this message translates to:
  /// **'WeatherNow brings you real-time weather data from around the world. Check current conditions, 7-day forecasts, air quality indexes, and more — all in a beautiful, easy-to-use interface.'**
  String get aboutDesc;

  /// No description provided for @dataSource.
  ///
  /// In en, this message translates to:
  /// **'Data Source'**
  String get dataSource;

  /// No description provided for @dataSourceDesc.
  ///
  /// In en, this message translates to:
  /// **'Weather data provided by WeatherAPI.com (free tier). This includes current conditions, 7-day hourly forecasts, air quality data, and city search.'**
  String get dataSourceDesc;

  /// No description provided for @builtWith.
  ///
  /// In en, this message translates to:
  /// **'Built With'**
  String get builtWith;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyDesc.
  ///
  /// In en, this message translates to:
  /// **'This app does not collect or store any personal data. Location is only used to fetch weather data and is never shared with third parties.'**
  String get privacyDesc;

  /// No description provided for @madeWith.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ using Flutter'**
  String get madeWith;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {v}'**
  String version(String v);

  /// No description provided for @aqiGoodAdvice.
  ///
  /// In en, this message translates to:
  /// **'Air quality is satisfactory. Enjoy your outdoor activities!'**
  String get aqiGoodAdvice;

  /// No description provided for @aqiFairAdvice.
  ///
  /// In en, this message translates to:
  /// **'Air quality is acceptable. Sensitive individuals should limit prolonged outdoor exertion.'**
  String get aqiFairAdvice;

  /// No description provided for @aqiModerateAdvice.
  ///
  /// In en, this message translates to:
  /// **'Sensitive groups may experience health effects. Consider reducing outdoor activities.'**
  String get aqiModerateAdvice;

  /// No description provided for @aqiPoorAdvice.
  ///
  /// In en, this message translates to:
  /// **'Everyone may begin to experience health effects. Limit outdoor activities.'**
  String get aqiPoorAdvice;

  /// No description provided for @aqiVeryPoorAdvice.
  ///
  /// In en, this message translates to:
  /// **'Health alert! Everyone should avoid outdoor activities.'**
  String get aqiVeryPoorAdvice;

  /// No description provided for @layers.
  ///
  /// In en, this message translates to:
  /// **'Layers'**
  String get layers;

  /// No description provided for @precipitation.
  ///
  /// In en, this message translates to:
  /// **'Precipitation'**
  String get precipitation;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @windLayer.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get windLayer;

  /// No description provided for @pressureLayer.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressureLayer;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @coordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get coordinates;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @favoriteRemoved.
  ///
  /// In en, this message translates to:
  /// **'{city} removed'**
  String favoriteRemoved(String city);

  /// No description provided for @listView.
  ///
  /// In en, this message translates to:
  /// **'List view'**
  String get listView;

  /// No description provided for @chartView.
  ///
  /// In en, this message translates to:
  /// **'Chart view'**
  String get chartView;

  /// No description provided for @compact.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get compact;

  /// No description provided for @detailView.
  ///
  /// In en, this message translates to:
  /// **'Detail view'**
  String get detailView;

  /// No description provided for @simpleView.
  ///
  /// In en, this message translates to:
  /// **'Simple view'**
  String get simpleView;

  /// No description provided for @baseLayer.
  ///
  /// In en, this message translates to:
  /// **'Base'**
  String get baseLayer;

  /// No description provided for @centerOnCity.
  ///
  /// In en, this message translates to:
  /// **'Center on city'**
  String get centerOnCity;

  /// No description provided for @aqiGoodDescription.
  ///
  /// In en, this message translates to:
  /// **'Air quality is excellent. Perfect for outdoor activities.'**
  String get aqiGoodDescription;

  /// No description provided for @aqiFairDescription.
  ///
  /// In en, this message translates to:
  /// **'Air quality is acceptable. Sensitive individuals should be cautious.'**
  String get aqiFairDescription;

  /// No description provided for @aqiModerateDescription.
  ///
  /// In en, this message translates to:
  /// **'Moderate air quality. Consider reducing outdoor activities.'**
  String get aqiModerateDescription;

  /// No description provided for @aqiPoorDescription.
  ///
  /// In en, this message translates to:
  /// **'Poor air quality. Limit prolonged outdoor exposure.'**
  String get aqiPoorDescription;

  /// No description provided for @aqiVeryPoorDescription.
  ///
  /// In en, this message translates to:
  /// **'Very poor air quality. Avoid outdoor activities if possible.'**
  String get aqiVeryPoorDescription;

  /// No description provided for @celsiusShort.
  ///
  /// In en, this message translates to:
  /// **'°C'**
  String get celsiusShort;

  /// No description provided for @fahrenheitShort.
  ///
  /// In en, this message translates to:
  /// **'°F'**
  String get fahrenheitShort;

  /// No description provided for @kmhShort.
  ///
  /// In en, this message translates to:
  /// **'km/h'**
  String get kmhShort;

  /// No description provided for @mphShort.
  ///
  /// In en, this message translates to:
  /// **'mph'**
  String get mphShort;

  /// No description provided for @weatherCompanion.
  ///
  /// In en, this message translates to:
  /// **'Your weather companion'**
  String get weatherCompanion;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get recentSearches;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearHistory;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'ru',
    'uz',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'de':
      return SDe();
    case 'en':
      return SEn();
    case 'es':
      return SEs();
    case 'fr':
      return SFr();
    case 'ru':
      return SRu();
    case 'uz':
      return SUz();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
