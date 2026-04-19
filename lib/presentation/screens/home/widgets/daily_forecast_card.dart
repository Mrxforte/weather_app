import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/weather_utils.dart';
import '../../../../domain/entities/forecast_entity.dart';
import '../../../widgets/glass_card.dart';

// Collapsible daily forecast card on the home screen
class DailyForecastCard extends StatelessWidget {
  final ForecastListEntity forecastList;
  final bool isFahrenheit;
  final VoidCallback? onTap;

  const DailyForecastCard({
    super.key,
    required this.forecastList,
    required this.isFahrenheit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Group by day and take one entry per day
    final dailyMap = forecastList.groupedByDay;
    final days = dailyMap.entries.take(7).toList();
    final title = days.length >= 7
        ? S.of(context)!.forecast
        : '${days.length}-Day Forecast';

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.labelSmall.copyWith(color: Colors.white60),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.4),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...days.asMap().entries.map((entry) {
            final index = entry.key;
            final dayForecasts = entry.value.value;

            // Get the hi/lo for the day
            double hi = double.negativeInfinity;
            double lo = double.infinity;
            int conditionCode = dayForecasts.first.conditionCode;

            for (final f in dayForecasts) {
              if (f.tempMax > hi) hi = f.tempMax;
              if (f.tempMin < lo) lo = f.tempMin;
            }

            final date = DateTime.parse(entry.value.key);
            final isToday =
                DateTime.now().day == date.day &&
                DateTime.now().month == date.month;

            return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 52,
                        child: Text(
                          isToday
                              ? S.of(context)!.today
                              : AppDateUtils.formatDayOfWeek(date),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: isToday
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(
                        WeatherUtils.getWeatherIcon(conditionCode),
                        color: Colors.white70,
                        size: 22,
                      ),
                      const Spacer(),
                      Text(
                        WeatherUtils.formatTemperature(
                          lo,
                          isFahrenheit: isFahrenheit,
                        ),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Temperature range bar
                      SizedBox(
                        width: 80,
                        height: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation(
                              Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        WeatherUtils.formatTemperature(
                          hi,
                          isFahrenheit: isFahrenheit,
                        ),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
                .animate(delay: (index * 80).ms)
                .fadeIn(duration: 300.ms)
                .slideX(begin: 0.05, end: 0);
          }),
        ],
      ),
    );
  }
}
