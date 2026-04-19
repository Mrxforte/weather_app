import 'package:flutter/material.dart';

// Centralized color palette for consistent theming
class AppColors {
  AppColors._();

  // Primary palette — modern teal/cyan
  static const Color primary = Color(0xFF006D77);
  static const Color primaryDark = Color(0xFF004E57);
  static const Color primaryLight = Color(0xFF83C5BE);
  static const Color accent = Color(0xFFE29578);

  // Secondary
  static const Color secondary = Color(0xFFFDDB92);
  static const Color tertiary = Color(0xFFEDF6F9);

  // Background gradients for weather conditions
  static const List<Color> sunnyGradient = [
    Color(0xFF4FACFE),
    Color(0xFF00F2FE),
  ];
  static const List<Color> nightGradient = [
    Color(0xFF0D1B2A),
    Color(0xFF1B2838),
    Color(0xFF243B55),
  ];
  static const List<Color> cloudyGradient = [
    Color(0xFF8E9AAF),
    Color(0xFFCBD4E6),
  ];
  static const List<Color> rainyGradient = [
    Color(0xFF2C3E50),
    Color(0xFF3498DB),
  ];
  static const List<Color> snowGradient = [
    Color(0xFFD5DEE7),
    Color(0xFF596E79),
  ];

  // Surface colors
  static const Color cardLight = Color(0xCCFFFFFF);
  static const Color cardDark = Color(0x33FFFFFF);

  // Scaffold backgrounds for light/dark
  static const Color scaffoldLight = Color(0xFFF8F9FA);
  static const Color scaffoldDark = Color(0xFF121212);

  // Text colors — high contrast
  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF5F6368);
  static const Color textOnDark = Color(0xFFF8F9FA);
  static const Color textOnDarkSecondary = Color(0xCCF8F9FA);

  // Status colors
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFC62828);

  // AQI (Air Quality) level colors
  static const Color aqiGood = Color(0xFF2E7D32);
  static const Color aqiFair = Color(0xFF9E9D24);
  static const Color aqiModerate = Color(0xFFEF6C00);
  static const Color aqiPoor = Color(0xFFC62828);
  static const Color aqiVeryPoor = Color(0xFF6A1B9A);

  // Bottom nav / surface tint
  static const Color navBarLight = Color(0xFFFFFFFF);
  static const Color navBarDark = Color(0xFF1E1E1E);
}
