import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

/// Shell scaffold that wraps the 5 main tabs with a bottom NavigationBar.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.wb_sunny_outlined),
            selectedIcon: const Icon(Icons.wb_sunny_rounded),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon: const Icon(Icons.calendar_today_rounded),
            label: l10n.forecast,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: const Icon(Icons.search_rounded),
            label: l10n.searchCity,
          ),
          NavigationDestination(
            icon: const Icon(Icons.eco_outlined),
            selectedIcon: const Icon(Icons.eco_rounded),
            label: l10n.airQuality,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline_rounded),
            selectedIcon: const Icon(Icons.favorite_rounded),
            label: l10n.favorites,
          ),
        ],
      ),
    );
  }
}
