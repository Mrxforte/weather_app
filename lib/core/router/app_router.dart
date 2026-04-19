import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/weather_detail/weather_detail_screen.dart';
import '../../presentation/screens/forecast/forecast_screen.dart';
import '../../presentation/screens/air_quality/air_quality_screen.dart';
import '../../presentation/screens/favorites/favorites_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/about/about_screen.dart';
import '../../presentation/screens/weather_map/weather_map_screen.dart';
import '../../presentation/screens/lock/lock_gate_screen.dart';
import '../../presentation/screens/drawer/drawer_screen.dart';
import '../../presentation/screens/shell/main_shell.dart';

// Route path constants
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String lock = '/lock';
  static const String home = '/home';
  static const String search = '/search';
  static const String weatherDetail = '/weather-detail';
  static const String forecast = '/forecast';
  static const String airQuality = '/air-quality';
  static const String favorites = '/favorites';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String weatherMap = '/weather-map';
  static const String drawer = '/drawer';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _forecastNavKey = GlobalKey<NavigatorState>(debugLabel: 'forecast');
final _searchNavKey = GlobalKey<NavigatorState>(debugLabel: 'search');
final _airQualityNavKey = GlobalKey<NavigatorState>(debugLabel: 'airQuality');
final _favoritesNavKey = GlobalKey<NavigatorState>(debugLabel: 'favorites');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    // Non-tabbed routes
    GoRoute(
      path: AppRoutes.splash,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SplashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: AppRoutes.lock,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const LockGateScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),

    // Bottom navigation shell with 5 tabs
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavKey,
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _forecastNavKey,
          routes: [
            GoRoute(
              path: AppRoutes.forecast,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ForecastScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _searchNavKey,
          routes: [
            GoRoute(
              path: AppRoutes.search,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SearchScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _airQualityNavKey,
          routes: [
            GoRoute(
              path: AppRoutes.airQuality,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AirQualityScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _favoritesNavKey,
          routes: [
            GoRoute(
              path: AppRoutes.favorites,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: FavoritesScreen()),
            ),
          ],
        ),
      ],
    ),

    // Full-screen overlay routes
    _slideRoute(AppRoutes.drawer, const DrawerScreen(), fromLeft: true),
    _slideRoute(AppRoutes.weatherDetail, const WeatherDetailScreen()),
    _slideRoute(AppRoutes.settings, const SettingsScreen()),
    _slideRoute(AppRoutes.about, const AboutScreen()),
    _slideRoute(
      AppRoutes.weatherMap,
      const WeatherMapScreen(),
      fromBottom: true,
    ),
  ],
);

GoRoute _slideRoute(
  String path,
  Widget child, {
  bool fromLeft = false,
  bool fromBottom = false,
}) {
  final begin = fromLeft
      ? const Offset(-1.0, 0.0)
      : fromBottom
      ? const Offset(0.0, 1.0)
      : const Offset(1.0, 0.0);
  return GoRoute(
    path: path,
    parentNavigatorKey: _rootNavigatorKey,
    pageBuilder: (context, state) => CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: begin,
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ),
  );
}
