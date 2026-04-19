// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'WeatherNow';

  @override
  String get home => 'Inicio';

  @override
  String get search => 'Buscar';

  @override
  String get searchCity => 'Buscar ciudad';

  @override
  String get favorites => 'Favoritos';

  @override
  String get settings => 'Configuración';

  @override
  String get about => 'Acerca de';

  @override
  String get forecast => 'Pronóstico semanal';

  @override
  String get share => 'Compartir';

  @override
  String get airQuality => 'Calidad del aire';

  @override
  String get weatherMap => 'Mapa del clima';

  @override
  String get weatherDetails => 'Detalles del clima';

  @override
  String get details => 'Detalles';

  @override
  String get tryAgain => 'Reintentar';

  @override
  String updated(String time) {
    return 'Actualizado $time';
  }

  @override
  String get now => 'Ahora';

  @override
  String get hourlyForecast => 'Pronóstico por hora';

  @override
  String get today => 'Hoy';

  @override
  String get feelsLike => 'Sensación térmica';

  @override
  String get humidity => 'Humedad';

  @override
  String get pressure => 'Presión';

  @override
  String get wind => 'Viento';

  @override
  String get direction => 'Dirección';

  @override
  String get visibility => 'Visibilidad';

  @override
  String get clouds => 'Nubes';

  @override
  String get gusts => 'Ráfagas';

  @override
  String get highLow => 'Máx / Mín';

  @override
  String get sunrise => 'Amanecer';

  @override
  String get sunset => 'Atardecer';

  @override
  String get pollutants => 'Contaminantes';

  @override
  String get healthAdvice => 'Consejos de salud';

  @override
  String get noWeatherData => 'No hay datos meteorológicos disponibles';

  @override
  String get noFavorites => 'No hay ciudades favoritas aún';

  @override
  String get noFavoritesHint => 'Busca una ciudad y agrégala a tus favoritos';

  @override
  String get noResults => 'No se encontraron resultados';

  @override
  String get searchHint => 'Ingresa el nombre de la ciudad...';

  @override
  String get minChars => 'Ingresa al menos 2 caracteres';

  @override
  String get temperatureUnit => 'Temperatura';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get windSpeed => 'Velocidad del viento';

  @override
  String get mph => 'Millas por hora';

  @override
  String get kmh => 'Kilómetros por hora';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Predeterminado del sistema';

  @override
  String get themeLight => 'Modo claro';

  @override
  String get themeDark => 'Modo oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get units => 'Unidades';

  @override
  String get appearance => 'Apariencia';

  @override
  String get more => 'Más';

  @override
  String savedCities(int count) {
    return '$count guardadas';
  }

  @override
  String get appInfo => 'Información de la aplicación';

  @override
  String get security => 'Seguridad';

  @override
  String get appLock => 'Bloqueo de la app';

  @override
  String get appLockHint => 'Protege tu app con un patrón de bloqueo';

  @override
  String get patternSet => 'Bloqueo por patrón activado';

  @override
  String get patternNotSet => 'Bloqueo por patrón desactivado';

  @override
  String get setPattern => 'Dibuja tu patrón de bloqueo';

  @override
  String get confirmPattern => 'Confirma tu patrón';

  @override
  String get unlockApp => 'Dibuja el patrón para desbloquear';

  @override
  String get patternSaved => 'Bloqueo por patrón activado';

  @override
  String get patternRemoved => 'Bloqueo por patrón desactivado';

  @override
  String get patternMismatch => 'Los patrones no coinciden, inténtalo de nuevo';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get dailyNotification => 'Actualización diaria del clima';

  @override
  String get dailyNotificationHint =>
      'Recibe una notificación del clima todos los días a las 8:00 AM';

  @override
  String get notificationEnabled => 'Notificaciones diarias activadas';

  @override
  String get notificationDisabled => 'Notificaciones diarias desactivadas';

  @override
  String get networkError =>
      'Sin conexión a internet. Verifica tu red e inténtalo de nuevo.';

  @override
  String get serverError => 'Error del servidor. Inténtalo más tarde.';

  @override
  String get timeoutError => 'Tiempo de conexión agotado. Inténtalo de nuevo.';

  @override
  String get unknownError => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get rateLimitError => 'Demasiadas solicitudes. Espera un momento.';

  @override
  String get apiKeyError => 'Clave API inválida. Verifica tu configuración.';

  @override
  String get notFoundError =>
      'Ciudad no encontrada. Intenta una búsqueda diferente.';

  @override
  String get good => 'Bueno';

  @override
  String get fair => 'Aceptable';

  @override
  String get moderate => 'Moderado';

  @override
  String get poor => 'Malo';

  @override
  String get veryPoor => 'Muy malo';

  @override
  String get unknown => 'Desconocido';

  @override
  String get uvLow => 'Bajo';

  @override
  String get uvModerate => 'Moderado';

  @override
  String get uvHigh => 'Alto';

  @override
  String get uvVeryHigh => 'Muy alto';

  @override
  String get uvExtreme => 'Extremo';

  @override
  String get onboardingTitle1 => 'Clima en tiempo real';

  @override
  String get onboardingDesc1 =>
      'Obtén actualizaciones precisas del clima para cualquier ciudad del mundo en tiempo real.';

  @override
  String get onboardingTitle2 => 'Pronóstico semanal';

  @override
  String get onboardingDesc2 =>
      'Planifica con anticipación con pronósticos detallados por hora y por día hasta 7 días.';

  @override
  String get onboardingTitle3 => 'Guarda tus ciudades';

  @override
  String get onboardingDesc3 =>
      'Agrega tus ciudades favoritas para acceder rápidamente a su clima en cualquier momento.';

  @override
  String get skip => 'Omitir';

  @override
  String get next => 'Siguiente';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get aboutDesc =>
      'WeatherNow te trae datos meteorológicos en tiempo real de todo el mundo. Consulta las condiciones actuales, pronósticos de 7 días, índices de calidad del aire y más — todo en una interfaz hermosa y fácil de usar.';

  @override
  String get dataSource => 'Fuente de datos';

  @override
  String get dataSourceDesc =>
      'Datos meteorológicos proporcionados por WeatherAPI.com (nivel gratuito). Incluye condiciones actuales, pronósticos horarios de 7 días, datos de calidad del aire y búsqueda de ciudades.';

  @override
  String get builtWith => 'Construido con';

  @override
  String get privacy => 'Privacidad';

  @override
  String get privacyDesc =>
      'Esta aplicación no recopila ni almacena datos personales. La ubicación se usa solo para obtener datos meteorológicos y nunca se comparte con terceros.';

  @override
  String get madeWith => 'Hecho con ❤️ usando Flutter';

  @override
  String version(String v) {
    return 'Versión $v';
  }

  @override
  String get aqiGoodAdvice =>
      'La calidad del aire es satisfactoria. ¡Disfruta tus actividades al aire libre!';

  @override
  String get aqiFairAdvice =>
      'La calidad del aire es aceptable. Las personas sensibles deben limitar el esfuerzo prolongado al aire libre.';

  @override
  String get aqiModerateAdvice =>
      'Los grupos sensibles pueden experimentar efectos en la salud. Considera reducir las actividades al aire libre.';

  @override
  String get aqiPoorAdvice =>
      'Todos pueden comenzar a experimentar efectos en la salud. Limita las actividades al aire libre.';

  @override
  String get aqiVeryPoorAdvice =>
      '¡Alerta de salud! Todos deben evitar las actividades al aire libre.';

  @override
  String get layers => 'Capas';

  @override
  String get precipitation => 'Precipitación';

  @override
  String get temperature => 'Temperatura';

  @override
  String get windLayer => 'Viento';

  @override
  String get pressureLayer => 'Presión';

  @override
  String get location => 'Ubicación';

  @override
  String get coordinates => 'Coordenadas';

  @override
  String get undo => 'Deshacer';

  @override
  String favoriteRemoved(String city) {
    return '$city eliminada';
  }

  @override
  String get listView => 'Vista de lista';

  @override
  String get chartView => 'Vista de gráfico';

  @override
  String get compact => 'Compacto';

  @override
  String get detailView => 'Vista detallada';

  @override
  String get simpleView => 'Vista simple';

  @override
  String get baseLayer => 'Base';

  @override
  String get centerOnCity => 'Centrar en la ciudad';

  @override
  String get aqiGoodDescription =>
      'La calidad del aire es excelente. Perfecta para actividades al aire libre.';

  @override
  String get aqiFairDescription =>
      'La calidad del aire es aceptable. Las personas sensibles deben tener precaución.';

  @override
  String get aqiModerateDescription =>
      'Calidad del aire moderada. Considera reducir actividades al aire libre.';

  @override
  String get aqiPoorDescription =>
      'Mala calidad del aire. Limita la exposición prolongada al aire libre.';

  @override
  String get aqiVeryPoorDescription =>
      'Muy mala calidad del aire. Evita actividades al aire libre si es posible.';

  @override
  String get celsiusShort => '°C';

  @override
  String get fahrenheitShort => '°F';

  @override
  String get kmhShort => 'km/h';

  @override
  String get mphShort => 'mph';

  @override
  String get weatherCompanion => 'Tu compañero del clima';

  @override
  String get recentSearches => 'Búsquedas recientes';

  @override
  String get clearHistory => 'Limpiar';
}
