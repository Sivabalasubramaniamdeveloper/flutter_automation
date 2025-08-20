import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkPrimary,
    titleTextStyle: AppTextStyles.heading.copyWith(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    bodyLarge: AppTextStyles.body,
    bodyMedium: AppTextStyles.caption,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkPrimary,elevation: 2
  ),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
  ).copyWith(secondary: AppColors.darkSecondary, error: AppColors.error),
);
