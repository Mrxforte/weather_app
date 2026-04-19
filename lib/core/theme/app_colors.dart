import 'package:flutter/material.dart';

// Centralized color palette for consistent theming
class AppColors {
  AppColors._();

  // Primary palette
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color accent = Color(0xFFFF9800);

  // Background gradients for weather conditions
  static const List<Color> sunnyGradient = [
    Color(0xFF56CCF2),
    Color(0xFF2F80ED),
  ];
  static const List<Color> nightGradient = [
    Color(0xFF0F2027),
    Color(0xFF203A43),
    Color(0xFF2C5364),
  ];
  static const List<Color> cloudyGradient = [
    Color(0xFF757F9A),
    Color(0xFFD7DDE8),
  ];
  static const List<Color> rainyGradient = [
    Color(0xFF373B44),
    Color(0xFF4286F4),
  ];
  static const List<Color> snowGradient = [
    Color(0xFFE6DADA),
    Color(0xFF274046),
  ];

  // Surface colors
  static const Color cardLight = Color(0x33FFFFFF);
  static const Color cardDark = Color(0x33000000);

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkSecondary = Color(0xB3FFFFFF);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);

  // AQI (Air Quality) level colors
  static const Color aqiGood = Color(0xFF4CAF50);
  static const Color aqiFair = Color(0xFFCDDC39);
  static const Color aqiModerate = Color(0xFFFF9800);
  static const Color aqiPoor = Color(0xFFF44336);
  static const Color aqiVeryPoor = Color(0xFF9C27B0);
}
