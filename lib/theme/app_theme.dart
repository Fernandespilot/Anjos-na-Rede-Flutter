import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF2A9D8F);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFB2DFDB);
  static const secondary = Color(0xFFF4A261);
  static const onSecondary = Color(0xFF000000);
  static const background = Color(0xFFF8FFFE);
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF1A1A2E);
  static const onSurfaceVariant = Color(0xFF5C6B73);
  static const criticalCoral = Color(0xFFE63946);
  static const safetyGreen = Color(0xFF52B788);
  static const goldSoft = Color(0xFFFFF0C4);
  static const skyBlueLight = Color(0xFFE0F4FF);
}

ThemeData get appTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onSurface,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: const Color(0xFFFFE0B2),
        onSecondaryContainer: AppColors.onSurface,
        error: AppColors.criticalCoral,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: const Color(0xFFEEF2F5),
        outline: const Color(0xFFB0BEC5),
        outlineVariant: const Color(0xFFCFD8DC),
      ),
      textTheme: GoogleFonts.quicksandTextTheme().copyWith(
        headlineLarge: GoogleFonts.quicksand(
            fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        headlineMedium: GoogleFonts.quicksand(
            fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        bodyLarge: GoogleFonts.nunitoSans(fontSize: 16, color: AppColors.onSurface),
        bodyMedium: GoogleFonts.nunitoSans(fontSize: 14, color: AppColors.onSurface),
        labelLarge: GoogleFonts.quicksand(
            fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onSurface),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        titleTextStyle: GoogleFonts.quicksand(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFEEF2F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
