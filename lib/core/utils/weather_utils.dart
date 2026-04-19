import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Helper functions for weather data formatting and icon mapping
// All temperatures are in Celsius, wind speeds in kph (WeatherAPI.com units)
class WeatherUtils {
  WeatherUtils._();

  // Snow/ice condition codes from WeatherAPI
  static const _snowCodes = {
    1066,
    1069,
    1072,
    1114,
    1117,
    1204,
    1207,
    1210,
    1213,
    1216,
    1219,
    1222,
    1225,
    1237,
    1249,
    1252,
    1255,
    1258,
    1261,
    1264,
  };

  // Map WeatherAPI condition codes to readable descriptions
  static String getWeatherDescription(int conditionCode) {
    if (conditionCode == 1000) return 'Clear Sky';
    if (conditionCode <= 1009) return 'Cloudy';
    if (conditionCode == 1030 ||
        conditionCode == 1135 ||
        conditionCode == 1147) {
      return 'Fog';
    }
    if (conditionCode == 1087 || conditionCode >= 1273) return 'Thunderstorm';
    if (_snowCodes.contains(conditionCode)) return 'Snow';
    return 'Rain';
  }

  // Pick the right icon based on WeatherAPI condition code
  static IconData getWeatherIcon(int conditionCode, {bool isNight = false}) {
    if (conditionCode == 1000) {
      return isNight ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded;
    }
    if (conditionCode <= 1009) return Icons.cloud_queue_rounded;
    if (conditionCode == 1030 ||
        conditionCode == 1135 ||
        conditionCode == 1147) {
      return Icons.cloud_rounded;
    }
    if (conditionCode == 1087 || conditionCode >= 1273) {
      return Icons.flash_on_rounded;
    }
    if (_snowCodes.contains(conditionCode)) return Icons.ac_unit_rounded;
    return Icons.water_drop_rounded;
  }

  // Background gradient based on WeatherAPI condition code
  static List<Color> getWeatherGradient(
    int conditionCode, {
    bool isNight = false,
  }) {
    if (isNight) return AppColors.nightGradient;
    if (conditionCode == 1000) return AppColors.sunnyGradient;
    if (conditionCode <= 1009) return AppColors.cloudyGradient;
    if (conditionCode == 1030 ||
        conditionCode == 1135 ||
        conditionCode == 1147) {
      return AppColors.cloudyGradient;
    }
    if (conditionCode == 1087 || conditionCode >= 1273)
      return AppColors.rainyGradient;
    if (_snowCodes.contains(conditionCode)) return AppColors.snowGradient;
    return AppColors.rainyGradient;
  }

  // Convert Celsius to Fahrenheit
  static double celsiusToFahrenheit(double celsius) => celsius * 9 / 5 + 32;

  // Format temperature string with degree symbol (input is Celsius)
  static String formatTemperature(double celsius, {bool isFahrenheit = false}) {
    final temp = isFahrenheit ? celsiusToFahrenheit(celsius) : celsius;
    return '${temp.round()}°';
  }

  // Convert kph to mph
  static double kphToMph(double kph) => kph * 0.621371;

  // Format wind speed nicely (input is kph)
  static String formatWindSpeed(double kph, {bool isMph = false}) {
    final speed = isMph ? kphToMph(kph) : kph;
    final unit = isMph ? 'mph' : 'km/h';
    return '${speed.round()} $unit';
  }

  // Human-readable wind direction from degrees
  static String windDirectionFromDegrees(int degrees) {
    const directions = [
      'N',
      'NNE',
      'NE',
      'ENE',
      'E',
      'ESE',
      'SE',
      'SSE',
      'S',
      'SSW',
      'SW',
      'WSW',
      'W',
      'WNW',
      'NW',
      'NNW',
    ];
    final index = ((degrees / 22.5) + 0.5).floor() % 16;
    return directions[index];
  }

  // Get AQI label and color
  static (String, Color) getAqiInfo(int aqi) {
    return switch (aqi) {
      1 => ('Good', AppColors.aqiGood),
      2 => ('Fair', AppColors.aqiFair),
      3 => ('Moderate', AppColors.aqiModerate),
      4 => ('Poor', AppColors.aqiPoor),
      5 => ('Very Poor', AppColors.aqiVeryPoor),
      _ => ('Unknown', Colors.grey),
    };
  }

  // Format visibility in km
  static String formatVisibility(int meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
    return '$meters m';
  }

  // Get UV index severity label
  static String getUvLabel(double uvIndex) {
    if (uvIndex <= 2) return 'Low';
    if (uvIndex <= 5) return 'Moderate';
    if (uvIndex <= 7) return 'High';
    if (uvIndex <= 10) return 'Very High';
    return 'Extreme';
  }
}
