import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_text_styles.dart';

// Pretty error view with icon, message, and retry action
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryLabel;
  final bool isTransparent;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel,
    this.isTransparent = true,
  });

  IconData _getErrorIcon() {
    final msg = message.toLowerCase();
    if (msg.contains('internet') ||
        msg.contains('network') ||
        msg.contains('connection')) {
      return Icons.wifi_off_rounded;
    }
    if (msg.contains('server')) return Icons.dns_rounded;
    if (msg.contains('timeout')) return Icons.timer_off_rounded;
    if (msg.contains('not found')) return Icons.location_off_rounded;
    if (msg.contains('too many')) return Icons.speed_rounded;
    if (msg.contains('api key')) return Icons.vpn_key_off_rounded;
    return Icons.cloud_off_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final fgColor = isTransparent
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface;
    final fgDim = isTransparent
        ? Colors.white70
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        (isTransparent
                                ? Colors.white
                                : Theme.of(context).colorScheme.errorContainer)
                            .withValues(alpha: 0.12),
                  ),
                  child: Icon(
                    _getErrorIcon(),
                    size: 48,
                    color: isTransparent
                        ? Colors.white.withValues(alpha: 0.7)
                        : Theme.of(context).colorScheme.error,
                  ),
                )
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.elasticOut,
                )
                .fadeIn(duration: 300.ms),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: fgDim,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(retryLabel ?? 'Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTransparent
                          ? Colors.white.withValues(alpha: 0.2)
                          : Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: fgColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 300.ms)
                  .slideY(begin: 0.2, end: 0),
            ],
          ],
        ),
      ),
    );
  }
}
