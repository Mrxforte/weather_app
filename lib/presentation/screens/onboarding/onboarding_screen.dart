import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';

// Onboarding flow with 3 pages explaining app features
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  List<_OnboardingPage> _buildPages(BuildContext context) {
    final l10n = S.of(context)!;
    return [
      _OnboardingPage(
        icon: Icons.wb_sunny_rounded,
        title: l10n.onboardingTitle1,
        description: l10n.onboardingDesc1,
        gradient: AppColors.sunnyGradient,
      ),
      _OnboardingPage(
        icon: Icons.calendar_month_rounded,
        title: l10n.onboardingTitle2,
        description: l10n.onboardingDesc2,
        gradient: AppColors.rainyGradient,
      ),
      _OnboardingPage(
        icon: Icons.favorite_rounded,
        title: l10n.onboardingTitle3,
        description: l10n.onboardingDesc3,
        gradient: AppColors.nightGradient,
      ),
    ];
  }

  void _onNext() async {
    final pages = _buildPages(context);
    if (_currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      // Mark onboarding complete and load initial weather
      final settings = context.read<SettingsProvider>();
      await settings.completeOnboarding();

      if (!mounted) return;
      final weather = context.read<WeatherProvider>();
      await weather.loadWeatherData(
        AppConstants.defaultLat,
        AppConstants.defaultLon,
        cityName: AppConstants.defaultCity,
      );
      if (mounted) context.go(AppRoutes.home);
    }
  }

  void _onSkip() async {
    final settings = context.read<SettingsProvider>();
    await settings.completeOnboarding();

    if (!mounted) return;
    final weather = context.read<WeatherProvider>();
    await weather.loadWeatherData(
      AppConstants.defaultLat,
      AppConstants.defaultLon,
      cityName: AppConstants.defaultCity,
    );
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages(context);
    return Scaffold(
      body: Stack(
        children: [
          // Page view
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) => pages[index],
          ),

          // Skip button (top right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 20,
            child: TextButton(
              onPressed: _onSkip,
              child: Text(
                S.of(context)!.skip,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
              ),
            ),
          ),

          // Bottom navigation area
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Page dots
                SmoothPageIndicator(
                  controller: _controller,
                  count: pages.length,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white38,
                    spacing: 12,
                  ),
                ),
                const SizedBox(height: 40),
                // Next / Get Started button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == pages.length - 1
                            ? S.of(context)!.getStarted
                            : S.of(context)!.next,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Single onboarding page with a centered icon, title and description
class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Icon(icon, size: 120, color: Colors.white)
                .animate()
                .scale(
                  begin: const Offset(0.6, 0.6),
                  end: const Offset(1.0, 1.0),
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                )
                .fadeIn(duration: 500.ms),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child:
                  Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child:
                  Text(
                        description,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.5,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
