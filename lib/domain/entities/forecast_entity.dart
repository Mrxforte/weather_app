// Single forecast time slot from 5-day / 3-hour forecast
class ForecastEntity {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int conditionCode;
  final String conditionMain;
  final String conditionDescription;
  final String icon;
  final double windSpeed;
  final int windDeg;
  final int clouds;
  final double? pop; // Probability of precipitation
  final double? rain3h;
  final double? snow3h;
  final int timestamp;

  const ForecastEntity({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.conditionCode,
    required this.conditionMain,
    required this.conditionDescription,
    required this.icon,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    this.pop,
    this.rain3h,
    this.snow3h,
    required this.timestamp,
  });
}

// Wraps the full 5-day forecast list with city metadata
class ForecastListEntity {
  final String cityName;
  final String country;
  final double lat;
  final double lon;
  final int sunrise;
  final int sunset;
  final List<ForecastEntity> forecasts;

  const ForecastListEntity({
    required this.cityName,
    required this.country,
    required this.lat,
    required this.lon,
    required this.sunrise,
    required this.sunset,
    required this.forecasts,
  });

  // Group forecasts by date for daily view
  Map<String, List<ForecastEntity>> get groupedByDay {
    final map = <String, List<ForecastEntity>>{};
    for (final forecast in forecasts) {
      final date = DateTime.fromMillisecondsSinceEpoch(
        forecast.timestamp * 1000,
      );
      final key =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      map.putIfAbsent(key, () => []).add(forecast);
    }
    return map;
  }
}
