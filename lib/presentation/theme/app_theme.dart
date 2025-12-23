import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Color Palette
  static const Color primaryNeon = Color(0xFFCFFF5E); // Electric Lime
  static const Color backgroundDark = Color(0xFF0F0F0F); // Deep Charcoal
  static const Color surfaceDark = Color(0xFF1A1A1A); // Lighter Charcoal
  static const Color accentBlue = Color(0xFF42A5F5);
  static const Color accentPurple = Color(0xFFD0BCFF);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      primary: const Color(0xFF6750A4),
      secondary: primaryNeon,
      surface: Colors.white,
      onSurface: Colors.black87,
      primaryContainer: const Color(0xFFEADDFF),
      onPrimaryContainer: const Color(0xFF21005D),
    ),
    textTheme: GoogleFonts.outfitTextTheme(),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: const Color(0xFFF7F2FA),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryNeon,
      secondary: accentBlue,
      surface: surfaceDark,
      onSurface: Colors.white,
      onPrimary: Colors.black,
      primaryContainer: Color(0xFF2D2D2D),
      onPrimaryContainer: Colors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: Colors.white),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: surfaceDark,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryNeon,
      foregroundColor: Colors.black,
      shape: StadiumBorder(),
    ),
  );
}
