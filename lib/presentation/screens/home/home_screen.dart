import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/error_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_widget.dart';
import '../../widgets/weather_background.dart';
import '../../widgets/weather_info_tile.dart';
import 'widgets/hourly_forecast_row.dart';
import 'widgets/daily_forecast_card.dart';

// Main screen showing current weather, hourly and daily forecasts
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();
    final current = weather.currentWeather;

    // Figure out the gradient based on actual weather conditions
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

    return WeatherBackground(
      colors: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: weather.isLoading && current == null
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
                    // Custom app bar with city name and nav buttons
                    SliverAppBar(
                      expandedHeight: 0,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => _showDrawer(context),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => context.push(AppRoutes.search),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => context.push(AppRoutes.settings),
                        ),
                      ],
                    ),

                    if (current != null) ...[
                      // Big temperature and city name
                      SliverToBoxAdapter(
                        child: _CurrentWeatherHeader(
                          weather: current,
                          isFahrenheit: settings.isFahrenheit,
                          isNight: isNight,
                        ),
                      ),

                      // Quick info row (wind, humidity, etc.)
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
                            forecasts: weather.forecast!.forecasts
                                .take(8)
                                .toList(),
                            isFahrenheit: settings.isFahrenheit,
                            sunrise: weather.forecast!.sunrise,
                            sunset: weather.forecast!.sunset,
                          ),
                        ),

                      // Daily forecast summary
                      if (weather.forecast != null)
                        SliverToBoxAdapter(
                          child: DailyForecastCard(
                            forecastList: weather.forecast!,
                            isFahrenheit: settings.isFahrenheit,
                            onTap: () => context.push(AppRoutes.forecast),
                          ),
                        ),

                      // Air quality quick card
                      if (weather.airQuality != null)
                        SliverToBoxAdapter(
                          child: _AirQualityCard(
                            aqi: weather.airQuality!.aqi,
                            onTap: () => context.push(AppRoutes.airQuality),
                          ),
                        ),

                      // Last updated text
                      SliverToBoxAdapter(
                        child: _LastUpdatedText(
                          lastUpdated: weather.lastUpdated,
                        ),
                      ),

                      // Bottom spacer
                      const SliverToBoxAdapter(child: SizedBox(height: 40)),
                    ],
                  ],
                ),
              ),
      ),
    );
  }

  void _showDrawer(BuildContext context) {
    final l10n = S.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _DrawerItem(
              icon: Icons.home_rounded,
              label: l10n.home,
              onTap: () => Navigator.pop(ctx),
            ),
            _DrawerItem(
              icon: Icons.search_rounded,
              label: l10n.searchCity,
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.search);
              },
            ),
            _DrawerItem(
              icon: Icons.favorite_rounded,
              label: l10n.favorites,
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.favorites);
              },
            ),
            _DrawerItem(
              icon: Icons.calendar_month_rounded,
              label: l10n.forecast,
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.forecast);
              },
            ),
            _DrawerItem(
              icon: Icons.air_rounded,
              label: l10n.airQuality,
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.airQuality);
              },
            ),
            _DrawerItem(
              icon: Icons.map_rounded,
              label: l10n.weatherMap,
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.weatherMap);
              },
            ),
            _DrawerItem(
              icon: Icons.settings_rounded,
              label: l10n.settings,
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.settings);
              },
            ),
            _DrawerItem(
              icon: Icons.info_outline_rounded,
              label: l10n.about,
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.about);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Large temperature display with city name and weather description
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
          // City and country
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

          // Temperature
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

          // Condition + feels like
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

// Single row of key weather stats below the temperature
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

// Tappable AQI indicator card
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
            child: Icon(Icons.air_rounded, color: color),
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

// Tiny "last updated" timestamp at the bottom
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

// Navigation drawer item
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

// Retry view for network errors
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
