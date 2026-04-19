import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/weather_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../providers/weather_provider.dart';

/// Shell scaffold that wraps the 5 main tabs with a bottom NavigationBar.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final weather = context.watch<WeatherProvider>();
    final current = weather.currentWeather;

    // Derive gradient from weather for nav bar tint
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
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gradient.last.withValues(alpha: 0.85),
              gradient.last.withValues(alpha: 0.95),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavItem(
                  icon: Icons.wb_sunny_outlined,
                  activeIcon: Icons.wb_sunny_rounded,
                  tooltip: l10n.home,
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => _onTap(0),
                ),
                _NavItem(
                  icon: Icons.calendar_today_outlined,
                  activeIcon: Icons.calendar_today_rounded,
                  tooltip: l10n.forecast,
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () => _onTap(1),
                ),
                _NavItem(
                  icon: Icons.search_outlined,
                  activeIcon: Icons.search_rounded,
                  tooltip: l10n.searchCity,
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: () => _onTap(2),
                ),
                _NavItem(
                  icon: Icons.eco_outlined,
                  activeIcon: Icons.eco_rounded,
                  tooltip: l10n.airQuality,
                  isSelected: navigationShell.currentIndex == 3,
                  onTap: () => _onTap(3),
                ),
                _NavItem(
                  icon: Icons.favorite_outline_rounded,
                  activeIcon: Icons.favorite_rounded,
                  tooltip: l10n.favorites,
                  isSelected: navigationShell.currentIndex == 4,
                  onTap: () => _onTap(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String tooltip;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.tooltip,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: tooltip,
      iconSize: 24,
      padding: const EdgeInsets.all(10),
      splashRadius: 24,
      icon: Icon(
        isSelected ? activeIcon : icon,
        color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.55),
      ),
    );
  }
}
