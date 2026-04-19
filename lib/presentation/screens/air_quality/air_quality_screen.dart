import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/weather_background.dart';

class AirQualityScreen extends StatelessWidget {
  const AirQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final aq = weather.airQuality;
    final current = weather.currentWeather;
    final forecast = weather.forecast;

    final isNight = current != null && forecast != null
        ? AppDateUtils.isNight(
            current.timestamp,
            sunrise: forecast.sunrise,
            sunset: forecast.sunset,
          )
        : false;
    final gradient = current != null
        ? WeatherUtils.getWeatherGradient(
            current.conditionCode,
            isNight: isNight,
          )
        : null;

    if (aq == null) {
      return WeatherBackground(
        colors: gradient,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.eco_rounded,
                  size: 64,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context)!.noWeatherData,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final (label, _) = WeatherUtils.getAqiInfo(aq.aqi);

    return WeatherBackground(
      colors: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () => weather.refresh(),
          color: Colors.white,
          backgroundColor: Colors.white24,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context)!.airQuality,
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Big AQI badge
                  Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.45),
                            width: 2.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${aq.aqi}',
                              style: AppTextStyles.displayMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              label,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .scale(
                        begin: const Offset(0.7, 0.7),
                        end: const Offset(1, 1),
                        duration: 500.ms,
                        curve: Curves.elasticOut,
                      )
                      .fadeIn(duration: 400.ms),

                  const SizedBox(height: 12),
                  Text(
                    _getAqiDescription(context, aq.aqi),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white70,
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                  const SizedBox(height: 24),

                  // Pollutant bar chart
                  GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context)!.pollutants,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 180,
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY:
                                      [
                                        aq.pm25,
                                        aq.pm10,
                                        aq.o3,
                                        aq.no2,
                                        aq.so2,
                                        aq.co / 10,
                                      ].reduce((a, b) => a > b ? a : b) *
                                      1.3,
                                  barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                            final names = [
                                              'PM2.5',
                                              'PM10',
                                              'O₃',
                                              'NO₂',
                                              'SO₂',
                                              'CO',
                                            ];
                                            return BarTooltipItem(
                                              '${names[groupIndex]}\n${rod.toY.toStringAsFixed(1)} μg/m³',
                                              AppTextStyles.bodySmall.copyWith(
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          const labels = [
                                            'PM2.5',
                                            'PM10',
                                            'O₃',
                                            'NO₂',
                                            'SO₂',
                                            'CO',
                                          ];
                                          final idx = value.toInt();
                                          if (idx < 0 || idx >= labels.length) {
                                            return const SizedBox.shrink();
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Text(
                                              labels[idx],
                                              style: AppTextStyles.labelSmall
                                                  .copyWith(
                                                    color: Colors.white70,
                                                    fontSize: 9,
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  gridData: const FlGridData(show: false),
                                  barGroups: [
                                    _bar(0, aq.pm25, Colors.white70),
                                    _bar(1, aq.pm10, Colors.white70),
                                    _bar(2, aq.o3, Colors.white70),
                                    _bar(3, aq.no2, Colors.white70),
                                    _bar(4, aq.so2, Colors.white70),
                                    _bar(5, aq.co / 10, Colors.white70),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 100.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.05),

                  // Pollutant details
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
                            const SizedBox(height: 12),
                            _PollutantRow(
                              name: 'PM2.5',
                              value: aq.pm25,
                              unit: 'μg/m³',
                            ),
                            _PollutantRow(
                              name: 'PM10',
                              value: aq.pm10,
                              unit: 'μg/m³',
                            ),
                            _PollutantRow(
                              name: 'O₃',
                              value: aq.o3,
                              unit: 'μg/m³',
                            ),
                            _PollutantRow(
                              name: 'NO₂',
                              value: aq.no2,
                              unit: 'μg/m³',
                            ),
                            _PollutantRow(
                              name: 'SO₂',
                              value: aq.so2,
                              unit: 'μg/m³',
                            ),
                            _PollutantRow(
                              name: 'CO',
                              value: aq.co,
                              unit: 'μg/m³',
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 200.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.05),

                  // Health advice
                  GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.health_and_safety_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  S.of(context)!.healthAdvice,
                                  style: AppTextStyles.titleMedium.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _getHealthAdvice(context, aq.aqi),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white70,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.05),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _bar(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color.withValues(alpha: 0.9),
          width: 18,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }

  String _getAqiDescription(BuildContext context, int aqi) {
    final l10n = S.of(context)!;
    return switch (aqi) {
      1 => l10n.aqiGoodDescription,
      2 => l10n.aqiFairDescription,
      3 => l10n.aqiModerateDescription,
      4 => l10n.aqiPoorDescription,
      5 => l10n.aqiVeryPoorDescription,
      _ => l10n.unknown,
    };
  }

  String _getHealthAdvice(BuildContext context, int aqi) {
    final l10n = S.of(context)!;
    return switch (aqi) {
      1 => l10n.aqiGoodAdvice,
      2 => l10n.aqiFairAdvice,
      3 => l10n.aqiModerateAdvice,
      4 => l10n.aqiPoorAdvice,
      5 => l10n.aqiVeryPoorAdvice,
      _ => l10n.unknown,
    };
  }
}

class _PollutantRow extends StatelessWidget {
  final String name;
  final double value;
  final String unit;

  const _PollutantRow({
    required this.name,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(
              name,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (value / 300).clamp(0.0, 1.0),
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation(_pollutantColor(value)),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              '${value.toStringAsFixed(1)} $unit',
              textAlign: TextAlign.end,
              style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Color _pollutantColor(double val) {
    if (val < 50) return AppColors.aqiGood;
    if (val < 100) return AppColors.aqiFair;
    if (val < 150) return AppColors.aqiModerate;
    if (val < 200) return AppColors.aqiPoor;
    return AppColors.aqiVeryPoor;
  }
}
