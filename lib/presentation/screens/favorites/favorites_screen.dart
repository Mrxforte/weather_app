import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/city_entity.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';

// Saved cities screen where users can tap to load weather or swipe to remove
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final favorites = settings.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.favorites),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 72,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context)!.noFavorites,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      S.of(context)!.noFavoritesHint,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final city = favorites[index];
                return Dismissible(
                  key: ValueKey('${city.lat}_${city.lon}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    color: Colors.red.shade400,
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (_) {
                    settings.removeFavorite(city);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${city.name} removed'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () => settings.toggleFavorite(city),
                        ),
                      ),
                    );
                  },
                  child:
                      ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              child: Text(
                                city.country,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            title: Text(
                              city.name,
                              style: AppTextStyles.titleMedium,
                            ),
                            subtitle: Text(
                              city.displayName,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.north_west_rounded,
                              size: 16,
                              color: Colors.grey,
                            ),
                            onTap: () => _loadCity(context, city),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 4,
                            ),
                          )
                          .animate(delay: (index * 60).ms)
                          .fadeIn(duration: 300.ms)
                          .slideX(begin: 0.05, end: 0),
                );
              },
            ),
    );
  }

  void _loadCity(BuildContext context, CityEntity city) {
    context.read<WeatherProvider>().loadWeatherData(
      city.lat,
      city.lon,
      cityName: city.name,
    );
    context.go(AppRoutes.home);
  }
}
