import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Full-screen drawer menu accessible from the home screen.
class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
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
                          gradient: const LinearGradient(
                            colors: AppColors.sunnyGradient,
                          ),
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
                            style: AppTextStyles.titleLarge,
                          ),
                          Text(
                            'v${AppConstants.appVersion}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isDark
                                  ? AppColors.textOnDarkSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Divider(indent: 20, endIndent: 20),
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

                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Divider(),
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
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Icon(icon, color: colorScheme.primary, size: 22),
        title: Text(label, style: AppTextStyles.titleMedium),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: colorScheme.onSurface.withValues(alpha: 0.3),
          size: 20,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
