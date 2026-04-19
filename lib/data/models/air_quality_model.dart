import '../../domain/entities/air_quality_entity.dart';

// Maps the air quality data embedded in WeatherAPI forecast response
class AirQualityModel extends AirQualityEntity {
  const AirQualityModel({
    required super.aqi,
    required super.co,
    required super.no,
    required super.no2,
    required super.o3,
    required super.so2,
    required super.pm25,
    required super.pm10,
    required super.nh3,
  });

  // Expects the FULL forecast.json response; extracts current.air_quality
  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    final aq = current['air_quality'] as Map<String, dynamic>? ?? {};

    return AirQualityModel(
      aqi: _mapEpaIndex(aq['us-epa-index'] as int? ?? 1),
      co: (aq['co'] as num?)?.toDouble() ?? 0,
      no: 0, // not provided by WeatherAPI
      no2: (aq['no2'] as num?)?.toDouble() ?? 0,
      o3: (aq['o3'] as num?)?.toDouble() ?? 0,
      so2: (aq['so2'] as num?)?.toDouble() ?? 0,
      pm25: (aq['pm2_5'] as num?)?.toDouble() ?? 0,
      pm10: (aq['pm10'] as num?)?.toDouble() ?? 0,
      nh3: 0, // not provided by WeatherAPI
    );
  }

  // Map EPA 1-6 scale to our 1-5 scale used in the UI
  static int _mapEpaIndex(int epa) {
    return switch (epa) {
      1 => 1,
      2 => 2,
      3 => 3,
      4 => 4,
      5 || 6 => 5,
      _ => 1,
    };
  }
}
