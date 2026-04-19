import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/error_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../../domain/entities/city_entity.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_widget.dart';
import '../../widgets/weather_background.dart';
import '../../widgets/weather_info_tile.dart';
import 'widgets/hourly_forecast_row.dart';
import 'widgets/daily_forecast_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();
    final current = weather.currentWeather;

    final isNight = current != null
        ? AppDateUtils.isNight(
            current.timestamp,
            sunrise: current.sunrise,
            sunset: current.sunset,
          )
        : false;
    final gradient = current != null
        ? WeatherUtils.getWeatherGradient(
            current.conditionCode,
            isNight: isNight,
          )
        : null;

    final content = weather.isLoading && current == null
        ? const WeatherShimmerCard()
        : weather.errorMessage != null && current == null
        ? _ErrorView(
            message: localizedError(S.of(context)!, weather.errorMessage!),
            onRetry: () => weather.refresh(),
          )
        : RefreshIndicator(
            onRefresh: () => weather.refresh(),
            color: Colors.white,
            backgroundColor: Colors.white24,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                // App bar: drawer icon + search
                SliverAppBar(
                  expandedHeight: 0,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.dashboard_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => context.push(AppRoutes.drawer),
                  ),
                  actions: [
                    // Favorite toggle
                    if (current != null)
                      IconButton(
                        icon: Icon(
                          settings.isFavorite(
                                CityEntity(
                                  name: current.cityName,
                                  country: current.country,
                                  lat: current.lat,
                                  lon: current.lon,
                                ),
                              )
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          final city = CityEntity(
                            name: current.cityName,
                            country: current.country,
                            lat: current.lat,
                            lon: current.lon,
                          );
                          settings.toggleFavorite(city);
                        },
                      ),
                    IconButton(
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => context.go(AppRoutes.search),
                    ),
                  ],
                ),

                if (current != null) ...[
                  SliverToBoxAdapter(
                    child: _SelectedCityForecastStrip(
                      weather: current,
                      isFahrenheit: settings.isFahrenheit,
                    ),
                  ),

                  // Big temperature display
                  SliverToBoxAdapter(
                    child: _CurrentWeatherHeader(
                      weather: current,
                      isFahrenheit: settings.isFahrenheit,
                      isNight: isNight,
                    ),
                  ),

                  // Quick info row
                  SliverToBoxAdapter(
                    child: _QuickInfoRow(
                      weather: current,
                      isFahrenheit: settings.isFahrenheit,
                      isMph: settings.isMph,
                    ),
                  ),

                  // Hourly forecast
                  if (weather.forecast != null)
                    SliverToBoxAdapter(
                      child: HourlyForecastRow(
                        forecasts: weather.forecast!.forecasts.take(8).toList(),
                        isFahrenheit: settings.isFahrenheit,
                        sunrise: weather.forecast!.sunrise,
                        sunset: weather.forecast!.sunset,
                      ),
                    ),

                  // Daily forecast
                  if (weather.forecast != null)
                    SliverToBoxAdapter(
                      child: DailyForecastCard(
                        forecastList: weather.forecast!,
                        isFahrenheit: settings.isFahrenheit,
                        onTap: () => context.go(AppRoutes.forecast),
                      ),
                    ),

                  // Air quality card
                  if (weather.airQuality != null)
                    SliverToBoxAdapter(
                      child: _AirQualityCard(
                        aqi: weather.airQuality!.aqi,
                        onTap: () => context.go(AppRoutes.airQuality),
                      ),
                    ),

                  // Last updated
                  SliverToBoxAdapter(
                    child: _LastUpdatedText(lastUpdated: weather.lastUpdated),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ],
            ),
          );

    return WeatherBackground(
      colors: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            if (current != null)
              IgnorePointer(
                child: Opacity(
                  opacity: 0.18,
                  child: CachedNetworkImage(
                    imageUrl: _cityImageUrl(current.cityName),
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ),
            content,
          ],
        ),
      ),
    );
  }
}

String _cityImageUrl(String cityName) {
  final q = Uri.encodeComponent('$cityName skyline weather');
  return 'https://source.unsplash.com/1600x2400/?$q';
}

class _SelectedCityForecastStrip extends StatelessWidget {
  final dynamic weather;
  final bool isFahrenheit;

  const _SelectedCityForecastStrip({
    required this.weather,
    required this.isFahrenheit,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.my_location_rounded, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${weather.cityName}, ${weather.country}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            ),
          ),
          Text(
            '${S.of(context)!.highLow}: ${WeatherUtils.formatTemperature(weather.tempMax, isFahrenheit: isFahrenheit)} / ${WeatherUtils.formatTemperature(weather.tempMin, isFahrenheit: isFahrenheit)}',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.08, end: 0);
  }
}

class _CurrentWeatherHeader extends StatelessWidget {
  final dynamic weather;
  final bool isFahrenheit;
  final bool isNight;

  const _CurrentWeatherHeader({
    required this.weather,
    required this.isFahrenheit,
    required this.isNight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white70,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                '${weather.cityName}, ${weather.country}',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 12),
          Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    WeatherUtils.formatTemperature(
                      weather.temp,
                      isFahrenheit: isFahrenheit,
                    ),
                    style: AppTextStyles.displayLarge.copyWith(
                      color: Colors.white,
                      fontSize: 96,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Icon(
                      WeatherUtils.getWeatherIcon(
                        weather.conditionCode,
                        isNight: isNight,
                      ),
                      size: 48,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 100.ms)
              .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
          const SizedBox(height: 4),
          Text(
                '${weather.conditionMain}  •  ${S.of(context)!.feelsLike} ${WeatherUtils.formatTemperature(weather.feelsLike, isFahrenheit: isFahrenheit)}',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms)
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 4),
          Text(
            'H: ${WeatherUtils.formatTemperature(weather.tempMax, isFahrenheit: isFahrenheit)}  L: ${WeatherUtils.formatTemperature(weather.tempMin, isFahrenheit: isFahrenheit)}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
        ],
      ),
    );
  }
}

class _QuickInfoRow extends StatelessWidget {
  final dynamic weather;
  final bool isFahrenheit;
  final bool isMph;

  const _QuickInfoRow({
    required this.weather,
    required this.isFahrenheit,
    required this.isMph,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          WeatherInfoTile(
            icon: Icons.air_rounded,
            label: S.of(context)!.wind,
            value: WeatherUtils.formatWindSpeed(
              weather.windSpeed,
              isMph: isMph,
            ),
          ),
          WeatherInfoTile(
            icon: Icons.water_drop_rounded,
            label: S.of(context)!.humidity,
            value: '${weather.humidity}%',
          ),
          WeatherInfoTile(
            icon: Icons.visibility_rounded,
            label: S.of(context)!.visibility,
            value: WeatherUtils.formatVisibility(weather.visibility),
          ),
          WeatherInfoTile(
            icon: Icons.compress_rounded,
            label: S.of(context)!.pressure,
            value: '${weather.pressure} hPa',
          ),
        ],
      ),
    );
  }
}

class _AirQualityCard extends StatelessWidget {
  final int aqi;
  final VoidCallback onTap;

  const _AirQualityCard({required this.aqi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final (label, color) = WeatherUtils.getAqiInfo(aqi);
    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.eco_rounded, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context)!.airQuality,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white60,
                  ),
                ),
                Text(
                  '$label — AQI $aqi',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}

class _LastUpdatedText extends StatelessWidget {
  final DateTime? lastUpdated;

  const _LastUpdatedText({this.lastUpdated});

  @override
  Widget build(BuildContext context) {
    if (lastUpdated == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Text(
        S.of(context)!.updated(AppDateUtils.timeAgo(lastUpdated!)),
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(
          color: Colors.white.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 72,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(S.of(context)!.tryAgain),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white24,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
