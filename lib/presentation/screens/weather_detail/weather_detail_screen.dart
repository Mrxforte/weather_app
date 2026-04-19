import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/weather_background.dart';
import '../../widgets/weather_info_tile.dart';

// Detailed weather view with all available data points
class WeatherDetailScreen extends StatelessWidget {
  const WeatherDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();
    final current = weather.currentWeather;

    if (current == null) {
      return Scaffold(body: Center(child: Text(S.of(context)!.noWeatherData)));
    }

    final isNight = AppDateUtils.isNight(
      current.timestamp,
      sunrise: current.sunrise,
      sunset: current.sunset,
    );
    final gradient = WeatherUtils.getWeatherGradient(
      current.conditionCode,
      isNight: isNight,
    );

    return WeatherBackground(
      colors: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            S.of(context)!.weatherDetails,
            style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Sun times
              GlassCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _SunTimeWidget(
                      icon: Icons.wb_sunny_rounded,
                      label: S.of(context)!.sunrise,
                      time: AppDateUtils.formatTime(
                        AppDateUtils.fromUnixTimestamp(current.sunrise),
                      ),
                    ),
                    Container(width: 1, height: 50, color: Colors.white12),
                    _SunTimeWidget(
                      icon: Icons.nights_stay_rounded,
                      label: S.of(context)!.sunset,
                      time: AppDateUtils.formatTime(
                        AppDateUtils.fromUnixTimestamp(current.sunset),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05),

              // Detailed stats grid
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context)!.details,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.1,
                      children: [
                        WeatherInfoTile(
                          icon: Icons.thermostat_rounded,
                          label: 'Feels Like',
                          value: WeatherUtils.formatTemperature(
                            current.feelsLike,
                            isFahrenheit: settings.isFahrenheit,
                          ),
                        ),
                        WeatherInfoTile(
                          icon: Icons.water_drop_rounded,
                          label: 'Humidity',
                          value: '${current.humidity}%',
                        ),
                        WeatherInfoTile(
                          icon: Icons.compress_rounded,
                          label: 'Pressure',
                          value: '${current.pressure} hPa',
                        ),
                        WeatherInfoTile(
                          icon: Icons.air_rounded,
                          label: 'Wind',
                          value: WeatherUtils.formatWindSpeed(
                            current.windSpeed,
                            isMph: settings.isMph,
                          ),
                        ),
                        WeatherInfoTile(
                          icon: Icons.explore_rounded,
                          label: 'Direction',
                          value: WeatherUtils.windDirectionFromDegrees(
                            current.windDeg,
                          ),
                        ),
                        WeatherInfoTile(
                          icon: Icons.visibility_rounded,
                          label: 'Visibility',
                          value: WeatherUtils.formatVisibility(
                            current.visibility,
                          ),
                        ),
                        WeatherInfoTile(
                          icon: Icons.cloud_rounded,
                          label: 'Clouds',
                          value: '${current.clouds}%',
                        ),
                        if (current.windGust != null)
                          WeatherInfoTile(
                            icon: Icons.storm_rounded,
                            label: 'Gusts',
                            value: WeatherUtils.formatWindSpeed(
                              current.windGust!,
                              isMph: settings.isMph,
                            ),
                          ),
                        WeatherInfoTile(
                          icon: Icons.thermostat_auto_rounded,
                          label: 'High / Low',
                          value:
                              '${WeatherUtils.formatTemperature(current.tempMax, isFahrenheit: settings.isFahrenheit)} / ${WeatherUtils.formatTemperature(current.tempMin, isFahrenheit: settings.isFahrenheit)}',
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.05),

              // Description
              GlassCard(
                    child: Row(
                      children: [
                        Icon(
                          WeatherUtils.getWeatherIcon(
                            current.conditionCode,
                            isNight: isNight,
                          ),
                          size: 40,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                current.conditionMain,
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                current.conditionDescription
                                    .split(' ')
                                    .map(
                                      (w) =>
                                          w[0].toUpperCase() + w.substring(1),
                                    )
                                    .join(' '),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

class _SunTimeWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;

  const _SunTimeWidget({
    required this.icon,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber, size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(color: Colors.white60),
        ),
        Text(
          time,
          style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
