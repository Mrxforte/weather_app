import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/section_header.dart';
import '../../widgets/weather_background.dart';
import '../lock/lock_screen.dart';

// App settings screen with unit toggles, theme, language, notifications, lock
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final weather = context.watch<WeatherProvider>();
    final l10n = S.of(context)!;

    final forecast = weather.forecast;
    final isNight = weather.currentWeather != null && forecast != null
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

    return WeatherBackground(
      colors: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            l10n.settings,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
          children:
              [
                    // Units section
                    SectionHeader(title: l10n.units, color: Colors.white70),
                    _SettingsTile(
                      icon: Icons.thermostat_rounded,
                      title: l10n.temperatureUnit,
                      subtitle: settings.isFahrenheit
                          ? l10n.fahrenheit
                          : l10n.celsius,
                      trailing: SegmentedButton<bool>(
                        segments: [
                          ButtonSegment(
                            value: false,
                            label: Text(l10n.celsiusShort),
                          ),
                          ButtonSegment(
                            value: true,
                            label: Text(l10n.fahrenheitShort),
                          ),
                        ],
                        selected: {settings.isFahrenheit},
                        onSelectionChanged: (val) =>
                            settings.setTemperatureUnit(val.first),
                        style: ButtonStyle(
                          foregroundColor: const WidgetStatePropertyAll(
                            Colors.white,
                          ),
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color?>((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.white.withValues(alpha: 0.22);
                                }
                                return Colors.white.withValues(alpha: 0.08);
                              }),
                          side: WidgetStatePropertyAll(
                            BorderSide(
                              color: Colors.white.withValues(alpha: 0.24),
                            ),
                          ),
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.air_rounded,
                      title: l10n.windSpeed,
                      subtitle: settings.isMph ? l10n.mph : l10n.kmh,
                      trailing: SegmentedButton<bool>(
                        segments: [
                          ButtonSegment(
                            value: false,
                            label: Text(l10n.kmhShort),
                          ),
                          ButtonSegment(
                            value: true,
                            label: Text(l10n.mphShort),
                          ),
                        ],
                        selected: {settings.isMph},
                        onSelectionChanged: (val) =>
                            settings.setWindSpeedUnit(val.first),
                        style: ButtonStyle(
                          foregroundColor: const WidgetStatePropertyAll(
                            Colors.white,
                          ),
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color?>((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.white.withValues(alpha: 0.22);
                                }
                                return Colors.white.withValues(alpha: 0.08);
                              }),
                          side: WidgetStatePropertyAll(
                            BorderSide(
                              color: Colors.white.withValues(alpha: 0.24),
                            ),
                          ),
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Appearance section
                    SectionHeader(
                      title: l10n.appearance,
                      color: Colors.white70,
                    ),
                    _SettingsTile(
                      icon: Icons.palette_rounded,
                      title: l10n.theme,
                      subtitle: _getThemeLabel(settings.themeMode, l10n),
                      trailing: SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment(
                            value: ThemeMode.system,
                            icon: Icon(Icons.auto_mode_rounded, size: 18),
                          ),
                          ButtonSegment(
                            value: ThemeMode.light,
                            icon: Icon(Icons.light_mode_rounded, size: 18),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            icon: Icon(Icons.dark_mode_rounded, size: 18),
                          ),
                        ],
                        selected: {settings.themeMode},
                        onSelectionChanged: (val) =>
                            settings.setThemeMode(val.first),
                        style: ButtonStyle(
                          foregroundColor: const WidgetStatePropertyAll(
                            Colors.white,
                          ),
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color?>((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.white.withValues(alpha: 0.22);
                                }
                                return Colors.white.withValues(alpha: 0.08);
                              }),
                          side: WidgetStatePropertyAll(
                            BorderSide(
                              color: Colors.white.withValues(alpha: 0.24),
                            ),
                          ),
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.language_rounded,
                      title: l10n.language,
                      subtitle:
                          AppConstants.localeNames[settings.languageCode] ??
                          'English',
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white70,
                      ),
                      onTap: () => _showLanguagePicker(context, settings, l10n),
                    ),

                    const SizedBox(height: 8),

                    // Notifications section
                    SectionHeader(
                      title: l10n.notifications,
                      color: Colors.white70,
                    ),
                    _SettingsTile(
                      icon: Icons.notifications_rounded,
                      title: l10n.dailyNotification,
                      subtitle: l10n.dailyNotificationHint,
                      trailing: Switch.adaptive(
                        value: settings.dailyNotification,
                        onChanged: (val) async {
                          if (val) {
                            final granted =
                                await NotificationService.requestPermissions();
                            if (!granted) return;
                            await NotificationService.scheduleDailyNotification();
                          } else {
                            await NotificationService.cancelDailyNotification();
                          }
                          settings.setDailyNotification(val);
                        },
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Security section
                    SectionHeader(title: l10n.security, color: Colors.white70),
                    _SettingsTile(
                      icon: Icons.lock_rounded,
                      title: l10n.appLock,
                      subtitle: settings.isPatternLockEnabled
                          ? l10n.patternSet
                          : l10n.patternNotSet,
                      trailing: Switch.adaptive(
                        value: settings.isPatternLockEnabled,
                        onChanged: (val) {
                          if (val) {
                            showSetPatternDialog(context);
                          } else {
                            settings.setPatternLock(null);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.patternRemoved)),
                            );
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Navigation section
                    SectionHeader(title: l10n.more, color: Colors.white70),
                    _SettingsTile(
                      icon: Icons.favorite_rounded,
                      title: l10n.favorites,
                      subtitle: l10n.savedCities(settings.favorites.length),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white70,
                      ),
                      onTap: () => context.push(AppRoutes.favorites),
                    ),
                    _SettingsTile(
                      icon: Icons.info_outline_rounded,
                      title: l10n.about,
                      subtitle: l10n.appInfo,
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white70,
                      ),
                      onTap: () => context.push(AppRoutes.about),
                    ),
                  ]
                  .animate(interval: 50.ms)
                  .fadeIn(duration: 300.ms)
                  .slideX(begin: 0.02, end: 0),
        ),
      ),
    );
  }

  String _getThemeLabel(ThemeMode mode, S l10n) {
    return switch (mode) {
      ThemeMode.system => l10n.themeSystem,
      ThemeMode.light => l10n.themeLight,
      ThemeMode.dark => l10n.themeDark,
    };
  }

  void _showLanguagePicker(
    BuildContext context,
    SettingsProvider settings,
    S l10n,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.language,
                style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              ...AppConstants.supportedLocales.map((code) {
                final name = AppConstants.localeNames[code] ?? code;
                final isSelected = settings.languageCode == code;
                return ListTile(
                  leading: isSelected
                      ? Icon(Icons.check_circle_rounded, color: Colors.white)
                      : const Icon(
                          Icons.circle_outlined,
                          color: Colors.white54,
                        ),
                  title: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    settings.setLanguage(code);
                    Navigator.pop(ctx);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
