import '../entities/weather_entity.dart';
import '../entities/forecast_entity.dart';
import '../entities/air_quality_entity.dart';
import '../entities/city_entity.dart';

// Contract for weather data access — implemented by data layer
abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather(double lat, double lon);
  Future<ForecastListEntity> getForecast(double lat, double lon);
  Future<AirQualityEntity> getAirQuality(double lat, double lon);
  Future<List<CityEntity>> searchCities(String query);
}
