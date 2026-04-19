import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/weather_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../providers/weather_provider.dart';

/// Full-screen drawer menu accessible from the home screen.
class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final weather = context.watch<WeatherProvider>();
    final current = weather.currentWeather;

    // Match the weather gradient background when data is available
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
        : AppColors.sunnyGradient;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.wb_sunny_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.appName,
                              style: AppTextStyles.titleLarge.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'v${AppConstants.appVersion}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Divider(indent: 20, endIndent: 20, color: Colors.white24),
              const SizedBox(height: 8),

              // Menu items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children:
                      [
                            _DrawerTile(
                              icon: Icons.wb_sunny_rounded,
                              label: l10n.home,
                              onTap: () => context.pop(),
                            ),
                            _DrawerTile(
                              icon: Icons.thermostat_rounded,
                              label: l10n.weatherDetails,
                              onTap: () {
                                context.pop();
                                context.push(AppRoutes.weatherDetail);
                              },
                            ),
                            _DrawerTile(
                              icon: Icons.map_rounded,
                              label: l10n.weatherMap,
                              onTap: () {
                                context.pop();
                                context.push(AppRoutes.weatherMap);
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Divider(color: Colors.white24),
                            ),

                            _DrawerTile(
                              icon: Icons.settings_rounded,
                              label: l10n.settings,
                              onTap: () {
                                context.pop();
                                context.push(AppRoutes.settings);
                              },
                            ),
                            _DrawerTile(
                              icon: Icons.info_outline_rounded,
                              label: l10n.about,
                              onTap: () {
                                context.pop();
                                context.push(AppRoutes.about);
                              },
                            ),
                          ]
                          .animate(interval: 40.ms)
                          .fadeIn(duration: 250.ms)
                          .slideX(begin: -0.04, end: 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        tileColor: Colors.white.withValues(alpha: 0.08),
        leading: Icon(icon, color: Colors.white, size: 22),
        title: Text(
          label,
          style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.white38,
          size: 20,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
