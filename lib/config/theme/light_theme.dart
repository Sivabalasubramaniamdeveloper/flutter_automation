import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    titleTextStyle: AppTextStyles.heading.copyWith(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    bodyLarge: AppTextStyles.body,
    bodyMedium: AppTextStyles.caption,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.secondary,
    error: AppColors.error,
  ),
);
