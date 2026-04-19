import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

// About screen with app info, credits, and attribution
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // App icon
            Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.sunnyGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.wb_sunny_rounded,
                    size: 48,
                    color: Colors.white,
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

            const SizedBox(height: 20),

            Text(
              AppConstants.appName,
              style: AppTextStyles.headlineLarge,
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

            const SizedBox(height: 4),

            Text(
              l10n.version(AppConstants.appVersion),
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            const SizedBox(height: 32),

            _InfoCard(
                  icon: Icons.info_outline_rounded,
                  title: l10n.about,
                  content: l10n.aboutDesc,
                )
                .animate(delay: 300.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.05),

            _InfoCard(
                  icon: Icons.cloud_rounded,
                  title: l10n.dataSource,
                  content: l10n.dataSourceDesc,
                )
                .animate(delay: 400.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.05),

            _InfoCard(
                  icon: Icons.code_rounded,
                  title: l10n.builtWith,
                  content:
                      'Flutter & Dart  •  Clean Architecture\n'
                      'Provider  •  GetIt  •  GoRouter\n'
                      'Dio  •  FL Chart  •  Shimmer',
                )
                .animate(delay: 500.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.05),

            _InfoCard(
                  icon: Icons.privacy_tip_outlined,
                  title: l10n.privacy,
                  content: l10n.privacyDesc,
                )
                .animate(delay: 600.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.05),

            const SizedBox(height: 24),

            Text(
              l10n.madeWith,
              style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
            ).animate().fadeIn(delay: 700.ms, duration: 400.ms),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.titleMedium),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
