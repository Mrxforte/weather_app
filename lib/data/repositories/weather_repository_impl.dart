import '../../domain/entities/weather_entity.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/entities/air_quality_entity.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_api_service.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/air_quality_model.dart';
import '../models/city_model.dart';

// Connects the domain layer to the actual API data source
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _apiService;

  WeatherRepositoryImpl(this._apiService);

  @override
  Future<WeatherEntity> getCurrentWeather(double lat, double lon) async {
    final json = await _apiService.getCurrentWeather(lat, lon);
    return WeatherModel.fromJson(json);
  }

  @override
  Future<ForecastListEntity> getForecast(double lat, double lon) async {
    final json = await _apiService.getForecast(lat, lon);
    return ForecastListModel.fromJson(json);
  }

  @override
  Future<AirQualityEntity> getAirQuality(double lat, double lon) async {
    final json = await _apiService.getAirQuality(lat, lon);
    return AirQualityModel.fromJson(json);
  }

  @override
  Future<List<CityEntity>> searchCities(String query) async {
    final list = await _apiService.searchCities(query);
    return list
        .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
