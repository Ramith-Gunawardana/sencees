import 'package:flutter/material.dart';
import 'package:sencees/src/core/constants/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.primaryLight,
    disabledColor: AppColors.appDisableColorLight,
    dialogBackgroundColor: AppColors.appToastColorLight,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey,
        textStyle: const TextStyle(fontWeight: FontWeight.w900),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      filled: true,
      fillColor: AppColors.appInputFelidColorLight,
      hintStyle: const TextStyle(fontSize: 17),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color(0x589E9E9E), width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.appLightBlue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red.shade800, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red.shade800, width: 2.0),
      ),
      errorStyle: TextStyle(
        color: Colors.red.shade800,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
      headlineLarge: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.primaryDark,
    disabledColor: AppColors.appDisableColorDark,
    dialogBackgroundColor: AppColors.appToastColorDark,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey,
        textStyle: const TextStyle(fontWeight: FontWeight.w900),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      filled: true,
      fillColor: AppColors.appInputFelidColorDark,
      hintStyle: const TextStyle(fontSize: 17),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color(0x589E9E9E), width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.appLightBlue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width: 2.0, color: Colors.red.shade200),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width: 2.0, color: Colors.red.shade200),
      ),
      errorStyle: TextStyle(
        color: Colors.red.shade200,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
    ),
  );
}
