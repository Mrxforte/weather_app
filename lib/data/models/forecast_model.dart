import '../../domain/entities/forecast_entity.dart';

// Maps a single hourly forecast entry from WeatherAPI.com
class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
    required super.conditionCode,
    required super.conditionMain,
    required super.conditionDescription,
    required super.icon,
    required super.windSpeed,
    required super.windDeg,
    required super.clouds,
    super.pop,
    super.rain3h,
    super.snow3h,
    required super.timestamp,
  });

  // Parses a single hour entry from forecastday[].hour[]
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final condition = json['condition'] as Map<String, dynamic>;

    return ForecastModel(
      temp: (json['temp_c'] as num).toDouble(),
      feelsLike: (json['feelslike_c'] as num).toDouble(),
      tempMin: (json['temp_c'] as num).toDouble(),
      tempMax: (json['temp_c'] as num).toDouble(),
      pressure: (json['pressure_mb'] as num).round(),
      humidity: (json['humidity'] as num).round(),
      conditionCode: condition['code'] as int,
      conditionMain: condition['text'] as String,
      conditionDescription: condition['text'] as String,
      icon: condition['icon'] as String,
      windSpeed: (json['wind_kph'] as num).toDouble(),
      windDeg: (json['wind_degree'] as num).round(),
      clouds: (json['cloud'] as num).round(),
      // chance_of_rain is 0-100, we store 0.0-1.0 for consistency
      pop: (json['chance_of_rain'] as num?)?.toDouble() != null
          ? (json['chance_of_rain'] as num).toDouble() / 100.0
          : null,
      rain3h: (json['precip_mm'] as num?)?.toDouble(),
      snow3h: (json['snow_cm'] as num?)?.toDouble(),
      timestamp: json['time_epoch'] as int,
    );
  }
}

// Wraps all forecast days, pulling hourly entries into a flat list
class ForecastListModel extends ForecastListEntity {
  const ForecastListModel({
    required super.cityName,
    required super.country,
    required super.lat,
    required super.lon,
    required super.sunrise,
    required super.sunset,
    required super.forecasts,
  });

  // Expects the FULL forecast.json response
  factory ForecastListModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>;
    final forecastData = json['forecast'] as Map<String, dynamic>;
    final days = forecastData['forecastday'] as List<dynamic>;

    int sunrise = 0;
    int sunset = 0;
    final List<ForecastEntity> allHours = [];

    for (final dayJson in days) {
      final day = dayJson as Map<String, dynamic>;
      final astro = day['astro'] as Map<String, dynamic>;
      final dateStr = day['date'] as String;

      // Use the first day's astro for sunrise/sunset
      if (sunrise == 0) {
        sunrise = _parseSunTime(astro['sunrise'] as String, dateStr);
        sunset = _parseSunTime(astro['sunset'] as String, dateStr);
      }

      final hours = day['hour'] as List<dynamic>;
      for (final h in hours) {
        allHours.add(ForecastModel.fromJson(h as Map<String, dynamic>));
      }
    }

    return ForecastListModel(
      cityName: location['name'] as String,
      country: location['country'] as String,
      lat: (location['lat'] as num).toDouble(),
      lon: (location['lon'] as num).toDouble(),
      sunrise: sunrise,
      sunset: sunset,
      forecasts: allHours,
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
