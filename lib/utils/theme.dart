import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

ThemeData _baseTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppConstants.primary,
    brightness: brightness,
    primary: AppConstants.primary,
    secondary: AppConstants.secondary,
  );

  final textTheme = GoogleFonts.interTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? Colors.white10 : Colors.black.withOpacity(0.03),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.6),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 1.5,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
      ),
      margin: const EdgeInsets.all(12),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    ),
    chipTheme: ChipThemeData(
      shape: StadiumBorder(side: BorderSide(color: Colors.grey.withOpacity(0.2))),
      labelStyle: textTheme.labelMedium,
      backgroundColor: isDark ? Colors.white10 : Colors.black.withOpacity(0.03),
    ),
  );
}

ThemeData buildLightTheme() => _baseTheme(Brightness.light);
ThemeData buildDarkTheme() => _baseTheme(Brightness.dark);

