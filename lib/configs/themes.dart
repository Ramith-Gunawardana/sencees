import 'package:flutter/material.dart';
import 'package:sencees/constants/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.primaryLight,
      disabledColor: AppColors.appDisableColorLight
      // textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //         foregroundColor:
      //             WidgetStateProperty.all(AppColors.appDarkGray)))
      );

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.primaryDark,
      primaryColor: AppColors.primaryDark,
      brightness: Brightness.dark,
      disabledColor: AppColors.appDisableColorDark
      // textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //         foregroundColor:
      //             WidgetStateProperty.all(AppColors.appDarkGray)))
      );
}
