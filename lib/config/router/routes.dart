import 'package:flutter/cupertino.dart';
import 'package:flutter_automation/config/router/route_names.dart';
import 'package:flutter_automation/features/info/presentation/pages/screen1.dart';
import 'package:flutter_automation/features/info/presentation/pages/screen2.dart';
import 'package:flutter_automation/features/info/presentation/pages/screen3.dart';
import '../../features/info/presentation/pages/info_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RouteNames.home: (context) => const InfoScreen(),
      RouteNames.screen1: (context) => const Screen1(),
      RouteNames.screen2: (context) => const Screen2(),
      RouteNames.screen3: (context) => const Screen3(),
    };
  }
}
