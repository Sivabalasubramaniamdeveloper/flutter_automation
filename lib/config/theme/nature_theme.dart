import 'package:flutter/material.dart';

ThemeData natureTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green[700],
  scaffoldBackgroundColor: const Color(0xFFF4F1EE),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green[700],
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.green[700]!,
    onPrimary: Colors.white,
    secondary: Colors.brown[400]!,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black54),
    headlineSmall: TextStyle(color: Colors.green),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);