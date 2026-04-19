import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Reusable text styles across the whole app
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge =>
      GoogleFonts.inter(fontSize: 72, fontWeight: FontWeight.w200, height: 1.0);

  static TextStyle get displayMedium =>
      GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.w300, height: 1.1);

  static TextStyle get headlineLarge =>
      GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700);

  static TextStyle get headlineMedium =>
      GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600);

  static TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle get titleMedium =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
