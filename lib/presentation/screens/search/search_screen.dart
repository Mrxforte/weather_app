import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/weather_provider.dart';

// City search screen with debounced search and results list
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
    // Auto-focus the search field when screen opens
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
    weather.clearSearch();
    weather.loadWeatherData(lat, lon, cityName: name);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar with back button
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      weather.clearSearch();
                      context.pop();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: _onSearchChanged,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: S.of(context)!.searchHint,
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: () {
                                  _searchController.clear();
                                  weather.clearSearch();
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1, end: 0),

            // Search results
            Expanded(
              child: weather.isSearching
                  ? const Center(child: CircularProgressIndicator())
                  : weather.searchResults.isEmpty
                  ? Center(
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
                              color: Colors.grey,
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
                        return ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xFFE3F2FD),
                                child: Icon(
                                  Icons.location_city_rounded,
                                  color: Color(0xFF2196F3),
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
                              onTap: () => _onCitySelected(
                                city.lat,
                                city.lon,
                                city.name,
                              ),
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
    );
  }
}
