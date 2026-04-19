import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/weather_utils.dart';
import '../../providers/settings_provider.dart';
import '../../providers/weather_provider.dart';

class WeatherMapScreen extends StatefulWidget {
  const WeatherMapScreen({super.key});

  @override
  State<WeatherMapScreen> createState() => _WeatherMapScreenState();
}

class _WeatherMapScreenState extends State<WeatherMapScreen> {
  late final MapController _mapController;
  String _selectedLayer = 'none';

  static const _layerKeys = [
    'none',
    'precipitation',
    'temperature',
    'clouds',
    'wind',
  ];

  Map<String, String> _layerLabels(BuildContext context) {
    final l10n = S.of(context)!;
    return {
      'none': l10n.baseLayer,
      'precipitation': l10n.precipitation,
      'temperature': l10n.temperature,
      'clouds': l10n.clouds,
      'wind': l10n.wind,
    };
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final settings = context.watch<SettingsProvider>();
    final current = weather.currentWeather;

    final center = current != null
        ? LatLng(current.lat, current.lon)
        : const LatLng(41.0, 69.0);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(
          S.of(context)!.weatherMap,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (current != null)
            IconButton(
              icon: const Icon(Icons.my_location_rounded),
              onPressed: () => _mapController.move(center, 10),
              tooltip: S.of(context)!.centerOnCity,
            ),
        ],
      ),
      body: Stack(
        children: [
          // Interactive map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: center,
              initialZoom: 8,
              minZoom: 3,
              maxZoom: 16,
            ),
            children: [
              // Base OSM tile layer
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.weather_app',
              ),

              // Weather marker
              if (current != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: center,
                      width: 150,
                      height: 70,
                      child: _WeatherMarker(
                        temp: WeatherUtils.formatTemperature(
                          current.temp,
                          isFahrenheit: settings.isFahrenheit,
                        ),
                        condition: current.conditionMain,
                        icon: WeatherUtils.getWeatherIcon(
                          current.conditionCode,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ).animate().fadeIn(duration: 400.ms),

          // Layer chips at top
          Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _layerKeys.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final key = _layerKeys[index];
                  final isSelected = _selectedLayer == key;
                  return ChoiceChip(
                    label: Text(_layerLabels(context)[key] ?? key),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedLayer = key),
                    selectedColor: Colors.white.withValues(alpha: 0.24),
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.36)
                          : Colors.white.withValues(alpha: 0.18),
                    ),
                  );
                },
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2),
          ),

          // Weather info card at bottom
          if (current != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      WeatherUtils.getWeatherIcon(current.conditionCode),
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            current.cityName,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${WeatherUtils.formatTemperature(current.temp, isFahrenheit: settings.isFahrenheit)} · ${current.conditionMain}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.water_drop_rounded,
                              size: 14,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${current.humidity}%',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.air_rounded,
                              size: 14,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              WeatherUtils.formatWindSpeed(
                                current.windSpeed,
                                isMph: settings.isMph,
                              ),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.15),
            ),
        ],
      ),
    );
  }
}

class _WeatherMarker extends StatelessWidget {
  final String temp;
  final String condition;
  final IconData icon;

  const _WeatherMarker({
    required this.temp,
    required this.condition,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              condition,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
