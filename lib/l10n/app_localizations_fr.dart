// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SFr extends S {
  SFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'WeatherNow';

  @override
  String get home => 'Accueil';

  @override
  String get search => 'Rechercher';

  @override
  String get searchCity => 'Rechercher une ville';

  @override
  String get favorites => 'Favoris';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get forecast => 'Prévisions 3 jours';

  @override
  String get airQuality => 'Qualité de l\'air';

  @override
  String get weatherMap => 'Carte météo';

  @override
  String get weatherDetails => 'Détails météo';

  @override
  String get details => 'Détails';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String updated(String time) {
    return 'Mis à jour $time';
  }

  @override
  String get now => 'Maintenant';

  @override
  String get hourlyForecast => 'Prévisions horaires';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get feelsLike => 'Ressenti';

  @override
  String get humidity => 'Humidité';

  @override
  String get pressure => 'Pression';

  @override
  String get wind => 'Vent';

  @override
  String get direction => 'Direction';

  @override
  String get visibility => 'Visibilité';

  @override
  String get clouds => 'Nuages';

  @override
  String get gusts => 'Rafales';

  @override
  String get highLow => 'Max / Min';

  @override
  String get sunrise => 'Lever du soleil';

  @override
  String get sunset => 'Coucher du soleil';

  @override
  String get pollutants => 'Polluants';

  @override
  String get healthAdvice => 'Conseils santé';

  @override
  String get noWeatherData => 'Aucune donnée météo disponible';

  @override
  String get noFavorites => 'Aucune ville favorite';

  @override
  String get noFavoritesHint =>
      'Recherchez une ville et ajoutez-la à vos favoris';

  @override
  String get noResults => 'Aucun résultat trouvé';

  @override
  String get searchHint => 'Entrez le nom de la ville...';

  @override
  String get minChars => 'Entrez au moins 2 caractères';

  @override
  String get temperatureUnit => 'Température';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get windSpeed => 'Vitesse du vent';

  @override
  String get mph => 'Miles par heure';

  @override
  String get kmh => 'Kilomètres par heure';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Par défaut du système';

  @override
  String get themeLight => 'Mode clair';

  @override
  String get themeDark => 'Mode sombre';

  @override
  String get language => 'Langue';

  @override
  String get units => 'Unités';

  @override
  String get appearance => 'Apparence';

  @override
  String get more => 'Plus';

  @override
  String savedCities(int count) {
    return '$count enregistrées';
  }

  @override
  String get appInfo => 'Informations sur l\'application';

  @override
  String get security => 'Sécurité';

  @override
  String get appLock => 'Verrouillage de l\'application';

  @override
  String get appLockHint =>
      'Protégez votre application avec un schéma de verrouillage';

  @override
  String get patternSet => 'Verrouillage par schéma activé';

  @override
  String get patternNotSet => 'Verrouillage par schéma désactivé';

  @override
  String get setPattern => 'Dessinez votre schéma de verrouillage';

  @override
  String get confirmPattern => 'Confirmez votre schéma';

  @override
  String get unlockApp => 'Dessinez le schéma pour déverrouiller';

  @override
  String get patternSaved => 'Verrouillage par schéma activé';

  @override
  String get patternRemoved => 'Verrouillage par schéma désactivé';

  @override
  String get patternMismatch => 'Les schémas ne correspondent pas, réessayez';

  @override
  String get notifications => 'Notifications';

  @override
  String get dailyNotification => 'Mise à jour quotidienne';

  @override
  String get dailyNotificationHint =>
      'Recevez une notification météo chaque jour à 8h00';

  @override
  String get notificationEnabled => 'Notifications quotidiennes activées';

  @override
  String get notificationDisabled => 'Notifications quotidiennes désactivées';

  @override
  String get networkError =>
      'Pas de connexion internet. Vérifiez votre réseau et réessayez.';

  @override
  String get serverError => 'Erreur du serveur. Veuillez réessayer plus tard.';

  @override
  String get timeoutError => 'Délai de connexion expiré. Veuillez réessayer.';

  @override
  String get unknownError => 'Une erreur est survenue. Veuillez réessayer.';

  @override
  String get rateLimitError =>
      'Trop de requêtes. Veuillez patienter un instant.';

  @override
  String get apiKeyError => 'Clé API invalide. Vérifiez votre configuration.';

  @override
  String get notFoundError => 'Ville non trouvée. Essayez une autre recherche.';

  @override
  String get good => 'Bon';

  @override
  String get fair => 'Acceptable';

  @override
  String get moderate => 'Modéré';

  @override
  String get poor => 'Mauvais';

  @override
  String get veryPoor => 'Très mauvais';

  @override
  String get unknown => 'Inconnu';

  @override
  String get uvLow => 'Faible';

  @override
  String get uvModerate => 'Modéré';

  @override
  String get uvHigh => 'Élevé';

  @override
  String get uvVeryHigh => 'Très élevé';

  @override
  String get uvExtreme => 'Extrême';

  @override
  String get onboardingTitle1 => 'Météo en temps réel';

  @override
  String get onboardingDesc1 =>
      'Obtenez des mises à jour météo précises pour n\'importe quelle ville dans le monde en temps réel.';

  @override
  String get onboardingTitle2 => 'Prévisions 3 jours';

  @override
  String get onboardingDesc2 =>
      'Planifiez à l\'avance avec des prévisions horaires et quotidiennes détaillées jusqu\'à 3 jours.';

  @override
  String get onboardingTitle3 => 'Sauvegardez vos villes';

  @override
  String get onboardingDesc3 =>
      'Ajoutez vos villes favorites pour accéder rapidement à leur météo à tout moment.';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get getStarted => 'Commencer';

  @override
  String get aboutDesc =>
      'WeatherNow vous apporte des données météo en temps réel du monde entier. Consultez les conditions actuelles, les prévisions sur 3 jours, les indices de qualité de l\'air et bien plus — dans une interface belle et facile à utiliser.';

  @override
  String get dataSource => 'Source des données';

  @override
  String get dataSourceDesc =>
      'Données météo fournies par WeatherAPI.com (niveau gratuit). Cela inclut les conditions actuelles, les prévisions horaires sur 3 jours, les données de qualité de l\'air et la recherche de villes.';

  @override
  String get builtWith => 'Construit avec';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get privacyDesc =>
      'Cette application ne collecte ni ne stocke aucune donnée personnelle. La localisation est uniquement utilisée pour récupérer les données météo et n\'est jamais partagée avec des tiers.';

  @override
  String get madeWith => 'Fait avec ❤️ en Flutter';

  @override
  String version(String v) {
    return 'Version $v';
  }

  @override
  String get aqiGoodAdvice =>
      'La qualité de l\'air est satisfaisante. Profitez de vos activités en plein air !';

  @override
  String get aqiFairAdvice =>
      'La qualité de l\'air est acceptable. Les personnes sensibles devraient limiter les efforts prolongés en extérieur.';

  @override
  String get aqiModerateAdvice =>
      'Les groupes sensibles peuvent ressentir des effets sur la santé. Envisagez de réduire les activités en extérieur.';

  @override
  String get aqiPoorAdvice =>
      'Tout le monde peut commencer à ressentir des effets sur la santé. Limitez les activités en extérieur.';

  @override
  String get aqiVeryPoorAdvice =>
      'Alerte santé ! Tout le monde devrait éviter les activités en extérieur.';

  @override
  String get layers => 'Couches';

  @override
  String get precipitation => 'Précipitations';

  @override
  String get temperature => 'Température';

  @override
  String get windLayer => 'Vent';

  @override
  String get pressureLayer => 'Pression';

  @override
  String get location => 'Emplacement';

  @override
  String get coordinates => 'Coordonnées';
}
