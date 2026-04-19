import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../../domain/entities/city_entity.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/weather_background.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final weather = context.watch<WeatherProvider>();
    final favorites = settings.favorites;
    final forecast = weather.forecast;
    final isNight = weather.currentWeather != null && forecast != null
        ? AppDateUtils.isNight(
            weather.currentWeather!.timestamp,
            sunrise: forecast.sunrise,
            sunset: forecast.sunset,
          )
        : false;
    final gradient = weather.currentWeather != null
        ? WeatherUtils.getWeatherGradient(
            weather.currentWeather!.conditionCode,
            isNight: isNight,
          )
        : null;

    return WeatherBackground(
      colors: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  S.of(context)!.favorites,
                  style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
                ),
              ),
              Expanded(
                child: favorites.isEmpty
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
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                              ),
                              child: Text(
                                S.of(context)!.noFavoritesHint,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 400.ms),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final city = favorites[index];
                          return Dismissible(
                            key: ValueKey('${city.lat}_${city.lon}'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              color: Colors.red.shade500,
                              child: const Icon(
                                Icons.delete_rounded,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) {
                              settings.removeFavorite(city);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    S.of(context)!.favoriteRemoved(city.name),
                                  ),
                                  action: SnackBarAction(
                                    label: S.of(context)!.undo,
                                    onPressed: () =>
                                        settings.toggleFavorite(city),
                                  ),
                                ),
                              );
                            },
                            child:
                                Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      child: ListTile(
                                        tileColor: Colors.white.withValues(
                                          alpha: 0.1,
                                        ),
                                        minLeadingWidth: 44,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.white
                                              .withValues(alpha: 0.22),
                                          child: Text(
                                            _countryBadgeText(city.country),
                                            style: AppTextStyles.labelSmall
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                        title: Text(
                                          city.name,
                                          style: AppTextStyles.titleMedium
                                              .copyWith(color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          city.displayName,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(color: Colors.white70),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: const Icon(
                                          Icons.north_west_rounded,
                                          size: 16,
                                          color: Colors.white70,
                                        ),
                                        onTap: () => _loadCity(context, city),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 4,
                                            ),
                                      ),
                                    )
                                    .animate(delay: (index * 60).ms)
                                    .fadeIn(duration: 300.ms)
                                    .slideX(begin: 0.05, end: 0),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
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

  String _countryBadgeText(String country) {
    final cleaned = country.trim();
    if (cleaned.isEmpty) return '--';

    final parts = cleaned
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }

    final first = cleaned.substring(0, 1).toUpperCase();
    final second = cleaned.length > 1
        ? cleaned.substring(1, 2).toUpperCase()
        : '';
    return '$first$second';
  }
}
