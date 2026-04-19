// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SDe extends S {
  SDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'WeatherNow';

  @override
  String get home => 'Startseite';

  @override
  String get search => 'Suche';

  @override
  String get searchCity => 'Stadt suchen';

  @override
  String get favorites => 'Favoriten';

  @override
  String get settings => 'Einstellungen';

  @override
  String get about => 'Über';

  @override
  String get forecast => '3-Tage-Vorhersage';

  @override
  String get airQuality => 'Luftqualität';

  @override
  String get weatherMap => 'Wetterkarte';

  @override
  String get weatherDetails => 'Wetterdetails';

  @override
  String get details => 'Details';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String updated(String time) {
    return 'Aktualisiert $time';
  }

  @override
  String get now => 'Jetzt';

  @override
  String get hourlyForecast => 'Stündliche Vorhersage';

  @override
  String get today => 'Heute';

  @override
  String get feelsLike => 'Gefühlt wie';

  @override
  String get humidity => 'Luftfeuchtigkeit';

  @override
  String get pressure => 'Luftdruck';

  @override
  String get wind => 'Wind';

  @override
  String get direction => 'Richtung';

  @override
  String get visibility => 'Sicht';

  @override
  String get clouds => 'Bewölkung';

  @override
  String get gusts => 'Böen';

  @override
  String get highLow => 'Hoch / Tief';

  @override
  String get sunrise => 'Sonnenaufgang';

  @override
  String get sunset => 'Sonnenuntergang';

  @override
  String get pollutants => 'Schadstoffe';

  @override
  String get healthAdvice => 'Gesundheitshinweise';

  @override
  String get noWeatherData => 'Keine Wetterdaten verfügbar';

  @override
  String get noFavorites => 'Noch keine Lieblingsstädte';

  @override
  String get noFavoritesHint =>
      'Suchen Sie eine Stadt und fügen Sie sie zu den Favoriten hinzu';

  @override
  String get noResults => 'Keine Ergebnisse gefunden';

  @override
  String get searchHint => 'Stadtname eingeben...';

  @override
  String get minChars => 'Mindestens 2 Zeichen eingeben';

  @override
  String get temperatureUnit => 'Temperatur';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get windSpeed => 'Windgeschwindigkeit';

  @override
  String get mph => 'Meilen pro Stunde';

  @override
  String get kmh => 'Kilometer pro Stunde';

  @override
  String get theme => 'Design';

  @override
  String get themeSystem => 'Systemstandard';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get language => 'Sprache';

  @override
  String get units => 'Einheiten';

  @override
  String get appearance => 'Darstellung';

  @override
  String get more => 'Mehr';

  @override
  String savedCities(int count) {
    return '$count gespeichert';
  }

  @override
  String get appInfo => 'App-Informationen';

  @override
  String get security => 'Sicherheit';

  @override
  String get appLock => 'App-Sperre';

  @override
  String get appLockHint => 'Schützen Sie Ihre App mit einem Muster';

  @override
  String get patternSet => 'Mustersperre aktiviert';

  @override
  String get patternNotSet => 'Mustersperre deaktiviert';

  @override
  String get setPattern => 'Zeichnen Sie Ihr Entsperrmuster';

  @override
  String get confirmPattern => 'Bestätigen Sie Ihr Muster';

  @override
  String get unlockApp => 'Muster zum Entsperren zeichnen';

  @override
  String get patternSaved => 'Mustersperre aktiviert';

  @override
  String get patternRemoved => 'Mustersperre deaktiviert';

  @override
  String get patternMismatch =>
      'Muster stimmen nicht überein, versuchen Sie es erneut';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get dailyNotification => 'Tägliches Wetter-Update';

  @override
  String get dailyNotificationHint =>
      'Erhalten Sie täglich um 8:00 Uhr eine Wetterbenachrichtigung';

  @override
  String get notificationEnabled => 'Tägliche Benachrichtigungen aktiviert';

  @override
  String get notificationDisabled => 'Tägliche Benachrichtigungen deaktiviert';

  @override
  String get networkError =>
      'Keine Internetverbindung. Bitte überprüfen Sie Ihr Netzwerk und versuchen Sie es erneut.';

  @override
  String get serverError =>
      'Serverfehler. Bitte versuchen Sie es später erneut.';

  @override
  String get timeoutError =>
      'Verbindungs-Timeout. Bitte versuchen Sie es erneut.';

  @override
  String get unknownError =>
      'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';

  @override
  String get rateLimitError =>
      'Zu viele Anfragen. Bitte warten Sie einen Moment.';

  @override
  String get apiKeyError =>
      'Ungültiger API-Schlüssel. Bitte überprüfen Sie Ihre Konfiguration.';

  @override
  String get notFoundError =>
      'Stadt nicht gefunden. Versuchen Sie eine andere Suche.';

  @override
  String get good => 'Gut';

  @override
  String get fair => 'Ausreichend';

  @override
  String get moderate => 'Mäßig';

  @override
  String get poor => 'Schlecht';

  @override
  String get veryPoor => 'Sehr schlecht';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get uvLow => 'Niedrig';

  @override
  String get uvModerate => 'Mäßig';

  @override
  String get uvHigh => 'Hoch';

  @override
  String get uvVeryHigh => 'Sehr hoch';

  @override
  String get uvExtreme => 'Extrem';

  @override
  String get onboardingTitle1 => 'Echtzeit-Wetter';

  @override
  String get onboardingDesc1 =>
      'Erhalten Sie genaue Wetter-Updates für jede Stadt der Welt in Echtzeit.';

  @override
  String get onboardingTitle2 => '3-Tage-Vorhersage';

  @override
  String get onboardingDesc2 =>
      'Planen Sie voraus mit detaillierten stündlichen und täglichen Vorhersagen bis zu 3 Tage.';

  @override
  String get onboardingTitle3 => 'Städte speichern';

  @override
  String get onboardingDesc3 =>
      'Fügen Sie Ihre Lieblingsstädte für schnellen Zugriff auf deren Wetter hinzu.';

  @override
  String get skip => 'Überspringen';

  @override
  String get next => 'Weiter';

  @override
  String get getStarted => 'Los geht\'s';

  @override
  String get aboutDesc =>
      'WeatherNow bringt Ihnen Echtzeit-Wetterdaten aus der ganzen Welt. Aktuelle Bedingungen, 3-Tage-Vorhersagen, Luftqualitätsindizes und mehr — alles in einer schönen, benutzerfreundlichen Oberfläche.';

  @override
  String get dataSource => 'Datenquelle';

  @override
  String get dataSourceDesc =>
      'Wetterdaten bereitgestellt von WeatherAPI.com (kostenlose Stufe). Dies umfasst aktuelle Bedingungen, 3-Tage-Stundenvorhersagen, Luftqualitätsdaten und Stadtsuche.';

  @override
  String get builtWith => 'Erstellt mit';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get privacyDesc =>
      'Diese App sammelt oder speichert keine persönlichen Daten. Der Standort wird nur zum Abrufen von Wetterdaten verwendet und niemals an Dritte weitergegeben.';

  @override
  String get madeWith => 'Mit ❤️ in Flutter erstellt';

  @override
  String version(String v) {
    return 'Version $v';
  }

  @override
  String get aqiGoodAdvice =>
      'Die Luftqualität ist zufriedenstellend. Genießen Sie Ihre Outdoor-Aktivitäten!';

  @override
  String get aqiFairAdvice =>
      'Die Luftqualität ist akzeptabel. Empfindliche Personen sollten längere Anstrengungen im Freien begrenzen.';

  @override
  String get aqiModerateAdvice =>
      'Empfindliche Gruppen können gesundheitliche Auswirkungen spüren. Erwägen Sie, Outdoor-Aktivitäten zu reduzieren.';

  @override
  String get aqiPoorAdvice =>
      'Jeder kann beginnen, gesundheitliche Auswirkungen zu spüren. Begrenzen Sie Outdoor-Aktivitäten.';

  @override
  String get aqiVeryPoorAdvice =>
      'Gesundheitswarnung! Jeder sollte Outdoor-Aktivitäten vermeiden.';

  @override
  String get layers => 'Ebenen';

  @override
  String get precipitation => 'Niederschlag';

  @override
  String get temperature => 'Temperatur';

  @override
  String get windLayer => 'Wind';

  @override
  String get pressureLayer => 'Luftdruck';

  @override
  String get location => 'Standort';

  @override
  String get coordinates => 'Koordinaten';
}
