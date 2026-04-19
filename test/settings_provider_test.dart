import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/domain/entities/city_entity.dart';
import 'package:weather_app/presentation/providers/settings_provider.dart';

void main() {
  late SettingsProvider provider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    provider = SettingsProvider(prefs);
  });

  group('SettingsProvider', () {
    test('default values are correct', () {
      expect(provider.isFahrenheit, false);
      expect(provider.isMph, false);
      expect(provider.themeMode, ThemeMode.system);
      expect(provider.languageCode, 'en');
      expect(provider.onboardingDone, false);
      expect(provider.isPatternLockEnabled, false);
      expect(provider.dailyNotification, false);
      expect(provider.favorites, isEmpty);
    });

    test('setTemperatureUnit switches between C and F', () async {
      expect(provider.isFahrenheit, false);
      await provider.setTemperatureUnit(true);
      expect(provider.isFahrenheit, true);
      await provider.setTemperatureUnit(false);
      expect(provider.isFahrenheit, false);
    });

    test('setWindSpeedUnit switches between kmh and mph', () async {
      expect(provider.isMph, false);
      await provider.setWindSpeedUnit(true);
      expect(provider.isMph, true);
      await provider.setWindSpeedUnit(false);
      expect(provider.isMph, false);
    });

    test('setLanguage updates language and locale', () async {
      await provider.setLanguage('ru');
      expect(provider.languageCode, 'ru');
      expect(provider.locale, const Locale('ru'));
    });

    test('setThemeMode persists theme', () async {
      await provider.setThemeMode(ThemeMode.dark);
      expect(provider.themeMode, ThemeMode.dark);
      await provider.setThemeMode(ThemeMode.light);
      expect(provider.themeMode, ThemeMode.light);
    });

    test('completeOnboarding sets flag', () async {
      expect(provider.onboardingDone, false);
      await provider.completeOnboarding();
      expect(provider.onboardingDone, true);
    });

    test('setPatternLock enables and clears lock', () async {
      await provider.setPatternLock('1234');
      expect(provider.isPatternLockEnabled, true);
      expect(provider.patternLock, '1234');

      await provider.setPatternLock(null);
      expect(provider.isPatternLockEnabled, false);
    });

    test('addFavorite and removeFavorite manage favorites list', () async {
      const city = CityEntity(
        name: 'London',
        country: 'GB',
        lat: 51.5,
        lon: -0.12,
      );
      await provider.toggleFavorite(city);
      expect(provider.favorites.length, 1);
      expect(provider.favorites.first.name, 'London');

      await provider.removeFavorite(city);
      expect(provider.favorites, isEmpty);
    });

    test('settings persist across instances', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final p1 = SettingsProvider(prefs);

      await p1.setTemperatureUnit(true);
      await p1.setLanguage('de');
      await p1.completeOnboarding();

      final p2 = SettingsProvider(prefs);
      expect(p2.isFahrenheit, true);
      expect(p2.languageCode, 'de');
      expect(p2.onboardingDone, true);
    });
  });
}
