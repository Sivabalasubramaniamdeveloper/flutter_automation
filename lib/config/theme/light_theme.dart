import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.lightPrimary,
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightPrimary,
    titleTextStyle: AppTextStyles.heading.copyWith(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    bodyLarge: AppTextStyles.body,
    bodyMedium: AppTextStyles.caption,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.lightPrimary,elevation: 2
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.lightSecondary,
    error: AppColors.error,
  ),
);
