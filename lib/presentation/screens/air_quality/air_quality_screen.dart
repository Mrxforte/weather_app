import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/weather_background.dart';

// Air quality detail screen with pollutant breakdown
class AirQualityScreen extends StatelessWidget {
  const AirQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final aq = weather.airQuality;

    if (aq == null) {
      return const Scaffold(
        body: Center(child: Text('No air quality data available')),
      );
    }

    final (label, color) = WeatherUtils.getAqiInfo(aq.aqi);

    return WeatherBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            S.of(context)!.airQuality,
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
              const SizedBox(height: 24),

              // Big AQI badge
              Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.2),
                      border: Border.all(color: color, width: 3),
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
                            color: color,
                            fontWeight: FontWeight.w600,
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
                _getAqiDescription(aq.aqi),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              const SizedBox(height: 24),

              // Pollutant breakdown
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
                        _PollutantRow(name: 'O₃', value: aq.o3, unit: 'μg/m³'),
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
                        _PollutantRow(name: 'CO', value: aq.co, unit: 'μg/m³'),
                      ],
                    ),
                  )
                  .animate(delay: 100.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.05),

              // Health recommendations
              GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.health_and_safety_rounded,
                              color: color,
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
                          _getHealthAdvice(aq.aqi),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                            height: 1.5,
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

  String _getAqiDescription(int aqi) {
    return switch (aqi) {
      1 => 'Air quality is excellent. Perfect for outdoor activities.',
      2 =>
        'Air quality is acceptable. Sensitive individuals should be cautious.',
      3 => 'Moderate air quality. Consider reducing outdoor activities.',
      4 => 'Poor air quality. Limit prolonged outdoor exposure.',
      5 => 'Very poor air quality. Avoid outdoor activities if possible.',
      _ => 'Air quality data unavailable.',
    };
  }

  String _getHealthAdvice(int aqi) {
    return switch (aqi) {
      1 =>
        'Enjoy your outdoor activities! Air quality poses no risk. Great conditions for exercise, walks, and spending time outside.',
      2 =>
        'Generally safe for most people. Those with respiratory issues may want to limit prolonged strenuous activity outdoors.',
      3 =>
        'Sensitive groups (children, elderly, those with asthma) should reduce prolonged outdoor exertion. Consider wearing a mask.',
      4 =>
        'Everyone may experience health effects. Reduce physical outdoor activity and keep windows closed. Use air purifiers indoors.',
      5 =>
        'Health warning: Emergency conditions. Stay indoors, keep windows shut, and use an air purifier. Avoid all outdoor activities.',
      _ => 'Unable to provide advice without air quality data.',
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              name,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (value / 300).clamp(0.0, 1.0),
                backgroundColor: Colors.white12,
                valueColor: AlwaysStoppedAnimation(_getBarColor(value)),
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
              style: AppTextStyles.bodySmall.copyWith(color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBarColor(double value) {
    if (value < 50) return AppColors.aqiGood;
    if (value < 100) return AppColors.aqiFair;
    if (value < 150) return AppColors.aqiModerate;
    if (value < 200) return AppColors.aqiPoor;
    return AppColors.aqiVeryPoor;
  }
}
