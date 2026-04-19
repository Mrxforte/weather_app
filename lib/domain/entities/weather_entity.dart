// Core weather data entity used throughout the app
class WeatherEntity {
  final int id;
  final String cityName;
  final String country;
  final double lat;
  final double lon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final int clouds;
  final int conditionCode;
  final String conditionMain;
  final String conditionDescription;
  final String icon;
  final int sunrise;
  final int sunset;
  final int timestamp;

  const WeatherEntity({
    required this.id,
    required this.cityName,
    required this.country,
    required this.lat,
    required this.lon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.clouds,
    required this.conditionCode,
    required this.conditionMain,
    required this.conditionDescription,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.timestamp,
  });
}
