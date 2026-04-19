import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/weather_background.dart';
import '../../../domain/entities/city_entity.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<WeatherProvider>().searchCities(query);
  }

  void _onCitySelected(double lat, double lon, String name) {
    final weather = context.read<WeatherProvider>();
    final settings = context.read<SettingsProvider>();
    final selected = weather.searchResults.cast<CityEntity?>().firstWhere(
      (c) => c?.lat == lat && c?.lon == lon,
      orElse: () => null,
    );
    if (selected != null) {
      settings.addSearchHistory(selected);
    }
    weather.clearSearch();
    weather.loadWeatherData(lat, lon, cityName: name);
    context.go(AppRoutes.home);
  }

  void _onHistoryCitySelected(CityEntity city) {
    final weather = context.read<WeatherProvider>();
    final settings = context.read<SettingsProvider>();
    settings.addSearchHistory(city);
    weather.clearSearch();
    weather.loadWeatherData(city.lat, city.lon, cityName: city.name);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();
    final query = _searchController.text.trim();
    final cachedSuggestions = settings.searchSuggestions(query);
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
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onChanged: _onSearchChanged,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: S.of(context)!.searchHint,
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white70,
                      overflow: TextOverflow.ellipsis,
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.14),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              weather.clearSearch();
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                ),
              ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1, end: 0),

              // Results
              Expanded(
                child: weather.isSearching
                    ? const Center(child: CircularProgressIndicator())
                    : weather.searchResults.isEmpty
                    ? (query.isEmpty && settings.recentSearches.isNotEmpty)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    8,
                                    12,
                                    4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context)!.recentSearches,
                                        style: AppTextStyles.titleMedium
                                            .copyWith(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            settings.clearSearchHistory(),
                                        child: Text(
                                          S.of(context)!.clearHistory,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(color: Colors.white70),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    itemCount: settings.recentSearches.length,
                                    itemBuilder: (context, index) {
                                      final city =
                                          settings.recentSearches[index];
                                      return _buildCityTile(
                                        context,
                                        city: city,
                                        isFav: settings.isFavorite(city),
                                        onTap: () =>
                                            _onHistoryCitySelected(city),
                                        onFavoriteTap: () =>
                                            settings.toggleFavorite(city),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : (query.isNotEmpty && cachedSuggestions.isNotEmpty)
                          ? ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              itemCount: cachedSuggestions.length,
                              itemBuilder: (context, index) {
                                final city = cachedSuggestions[index];
                                return _buildCityTile(
                                  context,
                                  city: city,
                                  isFav: settings.isFavorite(city),
                                  onTap: () => _onHistoryCitySelected(city),
                                  onFavoriteTap: () =>
                                      settings.toggleFavorite(city),
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    size: 64,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? S.of(context)!.minChars
                                        : S.of(context)!.noResults,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: weather.searchResults.length,
                        itemBuilder: (context, index) {
                          final city = weather.searchResults[index];
                          final isFav = settings.isFavorite(city);
                          return _buildCityTile(
                                context,
                                city: city,
                                isFav: isFav,
                                onTap: () => _onCitySelected(
                                  city.lat,
                                  city.lon,
                                  city.name,
                                ),
                                onFavoriteTap: () =>
                                    settings.toggleFavorite(city),
                              )
                              .animate(delay: (index * 50).ms)
                              .fadeIn(duration: 250.ms)
                              .slideX(begin: 0.05, end: 0);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityTile(
    BuildContext context, {
    required CityEntity city,
    required bool isFav,
    required VoidCallback onTap,
    required VoidCallback onFavoriteTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        tileColor: Colors.white.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: 0.22),
          child: const Icon(Icons.location_city_rounded, color: Colors.white),
        ),
        title: Text(
          city.name,
          style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          city.displayName,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFav ? AppColors.accent : Colors.white54,
            size: 20,
          ),
          onPressed: onFavoriteTap,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        onTap: onTap,
      ),
    );
  }
}
