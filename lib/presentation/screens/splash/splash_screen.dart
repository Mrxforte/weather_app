import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';

// Animated splash screen with branding and initial data load
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    // Let the animations play for a moment
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;

    final settings = context.read<SettingsProvider>();

    if (!settings.onboardingDone) {
      context.go(AppRoutes.onboarding);
    } else {
      // Try to use device GPS location, fall back to default city
      double lat = AppConstants.defaultLat;
      double lon = AppConstants.defaultLon;
      String cityName = AppConstants.defaultCity;

      try {
        final permission = await Geolocator.checkPermission();
        final canUseLocation =
            permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse ||
            await Geolocator.requestPermission() ==
                LocationPermission.whileInUse;

        if (canUseLocation) {
          final position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.low,
              timeLimit: Duration(seconds: 5),
            ),
          );
          lat = position.latitude;
          lon = position.longitude;
          cityName = '';
        }
      } catch (_) {
        // Location unavailable — use default
      }

      final weather = context.read<WeatherProvider>();
      await weather.loadWeatherData(
        lat,
        lon,
        cityName: cityName.isNotEmpty ? cityName : null,
      );
      if (mounted) {
        // Check for pattern lock
        if (settings.isPatternLockEnabled) {
          context.go(AppRoutes.lock);
        } else {
          context.go(AppRoutes.home);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.sunnyGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated weather icon
            Icon(Icons.wb_sunny_rounded, size: 100, color: Colors.white)
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.elasticOut,
                )
                .fadeIn(duration: 600.ms),
            const SizedBox(height: 24),
            // App name
            Text(
                  AppConstants.appName,
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 8),
            Text(
                  S.of(context)!.weatherCompanion,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 1,
                  ),
                )
                .animate()
                .fadeIn(delay: 700.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 60),
            // Subtle loading spinner
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
              ),
            ).animate().fadeIn(delay: 1200.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
