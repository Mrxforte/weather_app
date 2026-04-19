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

// Full 5-day forecast with expandable daily sections
class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();
    final forecast = weather.forecast;

    if (forecast == null) {
      return const Scaffold(
        body: Center(child: Text('No forecast data available')),
      );
    }

    final isNight = weather.currentWeather != null
        ? AppDateUtils.isNight(
            weather.currentWeather!.timestamp,
            sunrise: forecast.sunrise,
            sunset: forecast.sunset,
          )
        : false;
    final gradient = weather.currentWeather != null
        ? WeatherUtils.getWeatherGradient(
            weather.currentWeather!.conditionCode,
            isNight: isNight,
          )
        : null;

    final dailyMap = forecast.groupedByDay;

    return WeatherBackground(
      colors: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            S.of(context)!.forecast,
            style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 8, bottom: 40),
          itemCount: dailyMap.length,
          itemBuilder: (context, index) {
            final entry = dailyMap.entries.elementAt(index);
            final date = DateTime.parse(entry.key);
            final dayForecasts = entry.value;
            final isToday =
                DateTime.now().day == date.day &&
                DateTime.now().month == date.month;

            // Compute day highs and lows
            double hi = double.negativeInfinity;
            double lo = double.infinity;
            for (final f in dayForecasts) {
              if (f.tempMax > hi) hi = f.tempMax;
              if (f.tempMin < lo) lo = f.tempMin;
            }

            return GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isToday
                                ? S.of(context)!.today
                                : AppDateUtils.formatDate(date),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${WeatherUtils.formatTemperature(hi, isFahrenheit: settings.isFahrenheit)} / ${WeatherUtils.formatTemperature(lo, isFahrenheit: settings.isFahrenheit)}',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      const Divider(color: Colors.white12, height: 1),
                      const SizedBox(height: 8),

                      // Hourly breakdown for the day
                      ...dayForecasts.map((f) {
                        final time = AppDateUtils.formatTime(
                          AppDateUtils.fromUnixTimestamp(f.timestamp),
                        );
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 64,
                                child: Text(
                                  time,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                              Icon(
                                WeatherUtils.getWeatherIcon(f.conditionCode),
                                size: 20,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  f.conditionMain,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                              if (f.pop != null && f.pop! > 0)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.water_drop_rounded,
                                        size: 12,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${(f.pop! * 100).round()}%',
                                        style: AppTextStyles.labelSmall
                                            .copyWith(
                                              color: Colors.lightBlueAccent,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              Text(
                                WeatherUtils.formatTemperature(
                                  f.temp,
                                  isFahrenheit: settings.isFahrenheit,
                                ),
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                )
                .animate(delay: (index * 100).ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.05, end: 0);
          },
        ),
      ),
    );
  }
}
