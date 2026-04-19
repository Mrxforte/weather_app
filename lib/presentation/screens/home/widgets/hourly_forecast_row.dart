import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/weather_utils.dart';
import '../../../../domain/entities/forecast_entity.dart';
import '../../../widgets/glass_card.dart';

// Horizontal scrolling hourly forecast strip
class HourlyForecastRow extends StatelessWidget {
  final List<ForecastEntity> forecasts;
  final bool isFahrenheit;
  final int sunrise;
  final int sunset;

  const HourlyForecastRow({
    super.key,
    required this.forecasts,
    required this.isFahrenheit,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 12),
            child: Text(
              S.of(context)!.hourlyForecast,
              style: AppTextStyles.labelSmall.copyWith(color: Colors.white60),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: forecasts.length,
              itemBuilder: (context, index) {
                final item = forecasts[index];
                final isNight = AppDateUtils.isNight(
                  item.timestamp,
                  sunrise: sunrise,
                  sunset: sunset,
                );
                final time = AppDateUtils.formatHour(
                  AppDateUtils.fromUnixTimestamp(item.timestamp),
                );

                return Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            index == 0 ? S.of(context)!.now : time,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          Icon(
                            WeatherUtils.getWeatherIcon(
                              item.conditionCode,
                              isNight: isNight,
                            ),
                            color: Colors.white.withValues(alpha: 0.85),
                            size: 28,
                          ),
                          Text(
                            WeatherUtils.formatTemperature(
                              item.temp,
                              isFahrenheit: isFahrenheit,
                            ),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          if (item.pop != null && item.pop! > 0)
                            Text(
                              '${(item.pop! * 100).round()}%',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: Colors.lightBlueAccent,
                              ),
                            )
                          else
                            const SizedBox(height: 14),
                        ],
                      ),
                    )
                    .animate(delay: (index * 50).ms)
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: 0.1, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
