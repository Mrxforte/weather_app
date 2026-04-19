import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/weather_background.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  bool _showChart = true;
  bool _showDetailed = false;

  void _shareForecast(BuildContext context) {
    final weather = context.read<WeatherProvider>();
    final settings = context.read<SettingsProvider>();
    final forecast = weather.forecast;
    if (forecast == null) return;

    final dailyMap = forecast.groupedByDay;
    final lines = <String>[
      '${forecast.cityName}, ${forecast.country}',
      S.of(context)!.forecast,
    ];

    for (final entry in dailyMap.entries.take(7)) {
      final date = DateTime.parse(entry.key);
      final dayForecasts = entry.value;
      double hi = double.negativeInfinity;
      double lo = double.infinity;
      for (final f in dayForecasts) {
        if (f.tempMax > hi) hi = f.tempMax;
        if (f.tempMin < lo) lo = f.tempMin;
      }

      lines.add(
        '${AppDateUtils.formatDate(date)}: '
        '${WeatherUtils.formatTemperature(hi, isFahrenheit: settings.isFahrenheit)} / '
        '${WeatherUtils.formatTemperature(lo, isFahrenheit: settings.isFahrenheit)}',
      );
    }

    Share.share(lines.join('\n'));
  }

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();
    final forecast = weather.forecast;

    if (forecast == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 64,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context)!.noWeatherData,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
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
        body: RefreshIndicator(
          onRefresh: () => weather.refresh(),
          color: Colors.white,
          backgroundColor: Colors.white24,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Text(
                  S.of(context)!.forecast,
                  style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.ios_share_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => _shareForecast(context),
                    tooltip: S.of(context)!.share,
                  ),
                  // Toggle chart / list view
                  IconButton(
                    icon: Icon(
                      _showChart
                          ? Icons.view_list_rounded
                          : Icons.show_chart_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() => _showChart = !_showChart),
                    tooltip: _showChart
                        ? S.of(context)!.listView
                        : S.of(context)!.chartView,
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(44),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: _ViewChip(
                            icon: Icons.view_stream_rounded,
                            label: S.of(context)!.details,
                            selected: _showDetailed,
                            onTap: () => setState(() => _showDetailed = true),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _ViewChip(
                            icon: Icons.short_text_rounded,
                            label: S.of(context)!.compact,
                            selected: !_showDetailed,
                            onTap: () => setState(() => _showDetailed = false),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Temperature chart
              if (_showChart && forecast.forecasts.length >= 4)
                SliverToBoxAdapter(
                  child: _TemperatureChart(
                    forecasts: forecast.forecasts.take(12).toList(),
                    isFahrenheit: settings.isFahrenheit,
                  ),
                ),

              // Daily sections
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final entry = dailyMap.entries.elementAt(index);
                  final date = DateTime.parse(entry.key);
                  final dayForecasts = entry.value;
                  final isToday =
                      DateTime.now().day == date.day &&
                      DateTime.now().month == date.month;

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
                            ...(_showDetailed
                                    ? dayForecasts
                                    : dayForecasts
                                          .asMap()
                                          .entries
                                          .where((e) => e.key % 3 == 0)
                                          .map((e) => e.value))
                                .map((f) {
                                  final time = AppDateUtils.formatTime(
                                    AppDateUtils.fromUnixTimestamp(f.timestamp),
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: _showDetailed ? 64 : 54,
                                          child: Text(
                                            time,
                                            style: AppTextStyles.bodySmall
                                                .copyWith(
                                                  color: Colors.white60,
                                                  fontSize: _showDetailed
                                                      ? 12
                                                      : 11,
                                                ),
                                          ),
                                        ),
                                        Icon(
                                          WeatherUtils.getWeatherIcon(
                                            f.conditionCode,
                                          ),
                                          size: _showDetailed ? 20 : 18,
                                          color: Colors.white70,
                                        ),
                                        SizedBox(width: _showDetailed ? 12 : 8),
                                        if (_showDetailed)
                                          Expanded(
                                            child: Text(
                                              f.conditionMain,
                                              style: AppTextStyles.bodySmall
                                                  .copyWith(
                                                    color: Colors.white60,
                                                  ),
                                            ),
                                          )
                                        else
                                          const Spacer(),
                                        if (f.pop != null && f.pop! > 0)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: _showDetailed ? 8 : 6,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.water_drop_rounded,
                                                  size: 11,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  '${(f.pop! * 100).round()}%',
                                                  style: AppTextStyles
                                                      .labelSmall
                                                      .copyWith(
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        fontSize: 10,
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
                                          style: AppTextStyles.titleMedium
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: _showDetailed
                                                    ? 16
                                                    : 14,
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
                }, childCount: dailyMap.length),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ViewChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withValues(alpha: 0.22)
              : Colors.white.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? Colors.white.withValues(alpha: 0.45)
                : Colors.white.withValues(alpha: 0.18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Temperature trend line chart for the next 12 hours
class _TemperatureChart extends StatelessWidget {
  final List<dynamic> forecasts;
  final bool isFahrenheit;

  const _TemperatureChart({
    required this.forecasts,
    required this.isFahrenheit,
  });

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < forecasts.length; i++) {
      final temp = isFahrenheit
          ? WeatherUtils.celsiusToFahrenheit(forecasts[i].temp)
          : forecasts[i].temp;
      spots.add(FlSpot(i.toDouble(), temp));
    }

    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 3;
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 3;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context)!.temperature,
            style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
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
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= forecasts.length) {
                          return const SizedBox.shrink();
                        }
                        final dt = AppDateUtils.fromUnixTimestamp(
                          forecasts[idx].timestamp,
                        );
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            AppDateUtils.formatTime(dt),
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white38,
                              fontSize: 9,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: minY,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.white,
                    barWidth: 2.5,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: 3,
                            color: Colors.white,
                            strokeWidth: 0,
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.25),
                          Colors.white.withValues(alpha: 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => spots
                        .map(
                          (s) => LineTooltipItem(
                            '${s.y.round()}°',
                            AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05);
  }
}
