import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

// Gradient background wrapper that changes based on weather conditions
class WeatherBackground extends StatelessWidget {
  final List<Color>? colors;
  final Widget child;

  const WeatherBackground({super.key, this.colors, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient =
        colors ?? (isDark ? AppColors.nightGradient : AppColors.sunnyGradient);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient,
        ),
      ),
      child: child,
    );
  }
}
