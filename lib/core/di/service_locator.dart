import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/weather_api_service.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../presentation/providers/weather_provider.dart';
import '../../presentation/providers/settings_provider.dart';
import '../services/cache_service.dart';

final getIt = GetIt.instance;

// Register all dependencies in the service locator
Future<void> setupDependencies() async {
  // Shared prefs needs to be initialised before anything else
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Cache service
  getIt.registerSingleton<CacheService>(CacheService(prefs));

  // Data layer
  getIt.registerLazySingleton<WeatherApiService>(
    () => WeatherApiService(cacheService: getIt<CacheService>()),
  );
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt<WeatherApiService>()),
  );

  // Providers
  getIt.registerFactory<WeatherProvider>(
    () => WeatherProvider(getIt<WeatherRepository>()),
  );
  getIt.registerLazySingleton<SettingsProvider>(
    () => SettingsProvider(getIt<SharedPreferences>()),
  );
}
