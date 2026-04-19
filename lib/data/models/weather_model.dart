import '../../domain/entities/weather_entity.dart';

// Maps the WeatherAPI.com forecast.json response into a WeatherEntity
class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.id,
    required super.cityName,
    required super.country,
    required super.lat,
    required super.lon,
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
    required super.visibility,
    required super.windSpeed,
    required super.windDeg,
    super.windGust,
    required super.clouds,
    required super.conditionCode,
    required super.conditionMain,
    required super.conditionDescription,
    required super.icon,
    required super.sunrise,
    required super.sunset,
    required super.timestamp,
  });

  // Expects the FULL forecast.json response (not just the "current" part)
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>;
    final current = json['current'] as Map<String, dynamic>;
    final condition = current['condition'] as Map<String, dynamic>;

    // Pull min/max and sunrise/sunset from today's forecast if available
    double tempMin = (current['temp_c'] as num).toDouble();
    double tempMax = tempMin;
    int sunrise = 0;
    int sunset = 0;

    final forecast = json['forecast'] as Map<String, dynamic>?;
    if (forecast != null) {
      final days = forecast['forecastday'] as List<dynamic>;
      if (days.isNotEmpty) {
        final today = days[0] as Map<String, dynamic>;
        final day = today['day'] as Map<String, dynamic>;
        tempMin = (day['mintemp_c'] as num).toDouble();
        tempMax = (day['maxtemp_c'] as num).toDouble();

        final astro = today['astro'] as Map<String, dynamic>;
        final dateStr = today['date'] as String;
        sunrise = _parseSunTime(astro['sunrise'] as String, dateStr);
        sunset = _parseSunTime(astro['sunset'] as String, dateStr);
      }
    }

    return WeatherModel(
      id: 0,
      cityName: location['name'] as String,
      country: location['country'] as String,
      lat: (location['lat'] as num).toDouble(),
      lon: (location['lon'] as num).toDouble(),
      temp: (current['temp_c'] as num).toDouble(),
      feelsLike: (current['feelslike_c'] as num).toDouble(),
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: (current['pressure_mb'] as num).round(),
      humidity: (current['humidity'] as num).round(),
      visibility: ((current['vis_km'] as num).toDouble() * 1000).round(),
      windSpeed: (current['wind_kph'] as num).toDouble(),
      windDeg: (current['wind_degree'] as num).round(),
      windGust: (current['gust_kph'] as num?)?.toDouble(),
      clouds: (current['cloud'] as num).round(),
      conditionCode: condition['code'] as int,
      conditionMain: condition['text'] as String,
      conditionDescription: condition['text'] as String,
      icon: condition['icon'] as String,
      sunrise: sunrise,
      sunset: sunset,
      timestamp: current['last_updated_epoch'] as int,
    );
  }
}

// Convert "06:47 AM" + "2024-01-01" into a unix timestamp
int _parseSunTime(String timeStr, String dateStr) {
  final parts = timeStr.trim().split(' ');
  if (parts.length < 2) return 0;

  final timeParts = parts[0].split(':');
  int hour = int.tryParse(timeParts[0]) ?? 0;
  final minute = int.tryParse(timeParts.length > 1 ? timeParts[1] : '0') ?? 0;
  final isPm = parts[1].toUpperCase() == 'PM';

  if (isPm && hour != 12) hour += 12;
  if (!isPm && hour == 12) hour = 0;

  final date = DateTime.parse(dateStr);
  final combined = DateTime(date.year, date.month, date.day, hour, minute);
  return combined.millisecondsSinceEpoch ~/ 1000;
}
