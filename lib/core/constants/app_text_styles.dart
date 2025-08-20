//Predefined TextStyle objects to keep typography consistent.

import 'package:flutter/material.dart';
import '../../config/responsive/responsive_config.dart';
import '../../instance/locator.dart';

class AppTextStyles {
  ResponsiveConfig responsive = getIt<ResponsiveConfig>();
  late final TextStyle heading = TextStyle(
    fontSize: responsive.sp(17),
    fontWeight: FontWeight.bold,
  );

  late final TextStyle body = TextStyle(fontSize: responsive.sp(15));

  late final TextStyle caption = TextStyle(fontSize: responsive.sp(14));
}
