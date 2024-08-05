import 'package:flutter/material.dart';
import 'package:sencees/src/core/constants/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      disabledColor: AppColors.appDisableColorLight,
      dialogBackgroundColor: AppColors.appToastColorLight,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
      ),
      appBarTheme:
          const AppBarTheme(backgroundColor: AppColors.backgroundLight),
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
          borderSide:
              const BorderSide(color: AppColors.appLightBlue, width: 2.0),
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
      cardTheme: CardTheme(
        color: AppColors.primaryLight,
        elevation: 5,
        shadowColor: AppColors.appLightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ));

  static final darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      disabledColor: AppColors.appDisableColorDark,
      dialogBackgroundColor: AppColors.appToastColorDark,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.appDarkGray,
        ),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryDark),
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
          borderSide:
              const BorderSide(color: AppColors.appLightBlue, width: 2.0),
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
      cardTheme: CardTheme(
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ));
}
