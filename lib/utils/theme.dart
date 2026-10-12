import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBackground = Color(0xFFFAF7F2); // Warm Linen Off-White Background
  static const Color darkMaroonAccent = Color(0xFF420008); // Deep Dark Wine Maroon Accent for featured UI
  static const Color warmPaper = Color(0xFFFFFFFF); // Clean Crisp White Paper
  static const Color darkCharcoal = Color(0xFF1E1416); // Charcoal Dark Text
  static const Color deepBurgundy = Color(0xFF6B0F1A); // Crimson Maroon Red UI Accent
  static const Color waxSealRed = Color(0xFF8B0000); // Rich Red Wax Seal
  static const Color mutedRose = Color(0xFFD48A94);
  static const Color warmTaupe = Color(0xFFE5DDD0);
  static const Color softBeige = Color(0xFFF5EBE6);
  static const Color charcoalLight = Color(0xFF2E2926);
  static const Color mutedGray = Color(0xFF8C8074);
  static const Color goldAccent = Color(0xFFD4AF37); // South Indian Zari Gold

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: primaryBackground,
      primaryColor: deepBurgundy,
      colorScheme: const ColorScheme.light(
        primary: deepBurgundy,
        secondary: goldAccent,
        surface: primaryBackground,
        onSurface: darkCharcoal,
        onPrimary: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 56,
          fontWeight: FontWeight.w400,
          color: darkCharcoal,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          color: darkCharcoal,
          height: 1.2,
        ),
        displaySmall: GoogleFonts.cormorantGaramond(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: darkCharcoal,
          height: 1.25,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: darkCharcoal,
          fontStyle: FontStyle.italic,
        ),
        bodyLarge: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: darkCharcoal,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.cormorantGaramond(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: darkCharcoal,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.spaceMono(
          fontSize: 13,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w500,
          color: darkCharcoal,
        ),
        labelMedium: GoogleFonts.spaceMono(
          fontSize: 11,
          letterSpacing: 1.2,
          color: mutedGray,
        ),
      ),
    );
  }

  static TextStyle handwrittenStyle({
    double fontSize = 22,
    Color color = deepBurgundy,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.caveat(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: 1.3,
    ).copyWith(fontFamilyFallback: const ['cursive', 'sans-serif']);
  }

  static TextStyle romanticCalligraphyStyle({
    double fontSize = 42,
    Color color = deepBurgundy,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.greatVibes(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: 1.2,
    ).copyWith(fontFamilyFallback: const ['cursive', 'serif']);
  }

  static TextStyle serifStyle({
    double fontSize = 24,
    Color color = darkCharcoal,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.3,
  }) {
    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      color: color,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    ).copyWith(fontFamilyFallback: const ['Georgia', 'serif']);
  }

  static TextStyle monoStyle({
    double fontSize = 12,
    Color color = darkCharcoal,
    double letterSpacing = 1.2,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.spaceMono(
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
    ).copyWith(fontFamilyFallback: const ['Courier New', 'monospace']);
  }
}
