import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // ================= LIGHT THEME =================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentPurple,
      surface: AppColors.lightBackground,
      onSurface:
          AppColors.primaryGreen, // Default text color green set kar diya
      surfaceContainerHighest: AppColors.lightInputField,
      primaryContainer: AppColors.greenwaste,
      secondaryContainer: AppColors.otherwaste,
    ),
    // Yahan text styles define ho gayi
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: AppColors.primaryGreen,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppColors.primaryGreen,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.primaryGreen),
      bodyMedium: TextStyle(color: AppColors.primaryGreen),
      bodySmall: TextStyle(
        color: AppColors.accentPurple, // Hint ya secondary line ke liye
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightInputField,
      hintStyle: TextStyle(
        color: AppColors.primaryGreen.withOpacity(1),
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );

  // ================= DARK THEME =================
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentPurple,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkTextLight, // Dark mode mein readable light text
      surfaceContainerHighest: AppColors.darkInputField,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: AppColors.darkTextLight,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppColors.darkTextLight,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.darkTextLight),
      bodyMedium: TextStyle(color: AppColors.darkMutedText),
      bodySmall: TextStyle(color: AppColors.accentPurple),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputField,
      hintStyle: const TextStyle(color: AppColors.darkMutedText, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
