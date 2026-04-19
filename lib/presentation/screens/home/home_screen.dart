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
    final heroHeight = MediaQuery.sizeOf(context).height * 0.30;

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
                  // Big temperature display
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: heroHeight,
                      child: _CurrentWeatherHeader(
                        weather: current,
                        isFahrenheit: settings.isFahrenheit,
                        isNight: isNight,
                      ),
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
      conditionCode: current?.conditionCode,
      isNight: isNight,
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
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white70,
                size: 20,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${weather.cityName}, ${weather.country}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 450.ms).slideX(begin: -0.08, end: 0),
          const SizedBox(height: 6),
          Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      WeatherUtils.formatTemperature(
                        weather.temp,
                        isFahrenheit: isFahrenheit,
                      ),
                      style: AppTextStyles.displayLarge.copyWith(
                        color: Colors.white,
                        fontSize: 94,
                        height: 0.95,
                        letterSpacing: -1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    WeatherUtils.getWeatherIcon(
                      weather.conditionCode,
                      isNight: isNight,
                    ),
                    size: 52,
                    color: Colors.white,
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 550.ms, delay: 80.ms)
              .scale(begin: const Offset(0.97, 0.97), end: const Offset(1, 1)),
          const SizedBox(height: 6),
          Text(
            '${weather.conditionMain} • ${S.of(context)!.feelsLike} ${WeatherUtils.formatTemperature(weather.feelsLike, isFahrenheit: isFahrenheit)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ).animate().fadeIn(duration: 450.ms, delay: 160.ms),
          const Spacer(),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.22),
          ).animate().fadeIn(duration: 400.ms, delay: 190.ms),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.north_rounded, size: 18, color: Colors.white70),
              const SizedBox(width: 4),
              Text(
                'High ${WeatherUtils.formatTemperature(weather.tempMax, isFahrenheit: isFahrenheit)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.south_rounded, size: 18, color: Colors.white70),
              const SizedBox(width: 4),
              Text(
                'Low ${WeatherUtils.formatTemperature(weather.tempMin, isFahrenheit: isFahrenheit)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 450.ms, delay: 220.ms),
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
