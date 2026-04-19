import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/weather_background.dart';

// Interactive weather map showing precipitation, temperature and cloud layers
class WeatherMapScreen extends StatefulWidget {
  const WeatherMapScreen({super.key});

  @override
  State<WeatherMapScreen> createState() => _WeatherMapScreenState();
}

class _WeatherMapScreenState extends State<WeatherMapScreen> {
  String _selectedLayer = 'precipitation_new';

  Map<String, String> _layers(BuildContext context) {
    final l10n = S.of(context)!;
    return {
      'precipitation_new': l10n.precipitation,
      'temp_new': l10n.temperature,
      'clouds_new': l10n.clouds,
      'wind_new': l10n.wind,
      'pressure_new': l10n.pressure,
    };
  }

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final current = weather.currentWeather;

    return WeatherBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            S.of(context)!.weatherMap,
            style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: Column(
          children: [
            // Layer selection chips
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: _layers(context).entries.map((entry) {
                  final isSelected = _selectedLayer == entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(entry.value),
                      selected: isSelected,
                      onSelected: (_) =>
                          setState(() => _selectedLayer = entry.key),
                      selectedColor: Colors.white.withValues(alpha: 0.3),
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      labelStyle: AppTextStyles.bodySmall.copyWith(
                        color: isSelected ? Colors.white : Colors.white70,
                      ),
                      side: BorderSide(
                        color: isSelected ? Colors.white54 : Colors.white24,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1),

            const SizedBox(height: 8),

            // Map tile display area
            Expanded(
              child:
                  Container(
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withValues(alpha: 0.08),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              // Weather tile overlay (uses OWM tile API)
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.map_rounded,
                                      size: 80,
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      current != null
                                          ? '${current.cityName} — ${_layers(context)[_selectedLayer]}'
                                          : 'Weather Map',
                                      style: AppTextStyles.titleMedium.copyWith(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      current != null
                                          ? 'Lat: ${current.lat.toStringAsFixed(2)}, Lon: ${current.lon.toStringAsFixed(2)}'
                                          : '',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: Colors.white38,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // Note about map integration
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withValues(
                                          alpha: 0.08,
                                        ),
                                      ),
                                      child: Text(
                                        'Map tile layer: $_selectedLayer\n'
                                        'Tile URL: tile.openweathermap.org/map/$_selectedLayer/{z}/{x}/{y}.png',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: Colors.white38,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 100.ms, duration: 500.ms)
                      .scale(begin: const Offset(0.95, 0.95)),
            ),
          ],
        ),
      ),
    );
  }
}
