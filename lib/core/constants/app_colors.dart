import 'package:flutter/material.dart';

//	Centralized color definitions (Color(0xFF123456) or ColorName.primary).
class AppColors {
  // Common Colors

  static const Color whiteColor = Colors.white;
  static const Color redColor = Colors.red;
  static const Color blackColor = Colors.black;
  static const Color black87Color = Colors.black87;
  static const Color black54Color = Colors.black54;
  static const Color greenColor = Colors.green;
  static const Color error = Color(0xFFB00020);
  // Light Colors
  static const Color lightBackground = Colors.white;
  static const Color lightText = Colors.black;
  static const Color lightPrimary = Color(0xFF6200EE);
  static const Color lightSecondary = Color(0xFF03DAC6);


  // Dark Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkText = Colors.white;
  static const Color darkPrimary = Color(0xFF6200EE);
  static const Color darkSecondary = Color(0xFF03DAC6);

  // Natural Colors
  static final Color naturalBackground =  Colors.green[700]!;
  static const Color naturalText = Colors.white;
  static final Color naturalSecondary = Colors.brown[400]!;
}
