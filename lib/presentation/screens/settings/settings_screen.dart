import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/section_header.dart';
import '../lock/lock_screen.dart';

// App settings screen with unit toggles, theme, language, notifications, lock
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
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
                  SectionHeader(title: l10n.units),
                  _SettingsTile(
                    icon: Icons.thermostat_rounded,
                    title: l10n.temperatureUnit,
                    subtitle: settings.isFahrenheit
                        ? l10n.fahrenheit
                        : l10n.celsius,
                    trailing: SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(value: false, label: Text('°C')),
                        ButtonSegment(value: true, label: Text('°F')),
                      ],
                      selected: {settings.isFahrenheit},
                      onSelectionChanged: (val) =>
                          settings.setTemperatureUnit(val.first),
                      style: ButtonStyle(
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
                      segments: const [
                        ButtonSegment(value: false, label: Text('km/h')),
                        ButtonSegment(value: true, label: Text('mph')),
                      ],
                      selected: {settings.isMph},
                      onSelectionChanged: (val) =>
                          settings.setWindSpeedUnit(val.first),
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Appearance section
                  SectionHeader(title: l10n.appearance),
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
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showLanguagePicker(context, settings, l10n),
                  ),

                  const SizedBox(height: 8),

                  // Notifications section
                  SectionHeader(title: l10n.notifications),
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
                  SectionHeader(title: l10n.security),
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
                  SectionHeader(title: l10n.more),
                  _SettingsTile(
                    icon: Icons.favorite_rounded,
                    title: l10n.favorites,
                    subtitle: l10n.savedCities(settings.favorites.length),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.push(AppRoutes.favorites),
                  ),
                  _SettingsTile(
                    icon: Icons.info_outline_rounded,
                    title: l10n.about,
                    subtitle: l10n.appInfo,
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.push(AppRoutes.about),
                  ),
                ]
                .animate(interval: 50.ms)
                .fadeIn(duration: 300.ms)
                .slideX(begin: 0.02, end: 0),
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
              Text(l10n.language, style: AppTextStyles.titleLarge),
              const SizedBox(height: 8),
              ...AppConstants.supportedLocales.map((code) {
                final name = AppConstants.localeNames[code] ?? code;
                final isSelected = settings.languageCode == code;
                return ListTile(
                  leading: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                  title: Text(name, style: AppTextStyles.titleMedium),
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
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(title, style: AppTextStyles.titleMedium),
      subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
