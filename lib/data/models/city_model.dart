import '../../domain/entities/city_entity.dart';

// Maps the WeatherAPI.com search.json response
class CityModel extends CityEntity {
  const CityModel({
    required super.name,
    required super.country,
    super.state,
    required super.lat,
    required super.lon,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] as String,
      country: json['country'] as String,
      state: json['region'] as String?, // WeatherAPI uses 'region' not 'state'
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }
}
