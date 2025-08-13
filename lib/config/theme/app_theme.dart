import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';
import 'nature_theme.dart';

class AppTheme {
  static ThemeData getLightTheme() => lightTheme;
  static ThemeData getDarkTheme() => darkTheme;
  static ThemeData getNaturalTheme() => natureTheme;
}
