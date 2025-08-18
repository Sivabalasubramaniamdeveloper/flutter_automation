import 'package:flutter/material.dart';
import 'package:flutter_automation/config/router/route_names.dart';
import 'package:flutter_automation/features/info/presentation/pages/info_screen.dart';
import 'package:flutter_automation/features/info/presentation/pages/screen1.dart';
import 'package:flutter_automation/features/info/presentation/pages/screen2.dart';
import 'package:flutter_automation/features/info/presentation/pages/screen3.dart';
import 'package:flutter_automation/features/products/presentation/pages/products_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return _buildPageRoute(InfoScreen(), settings);
      case RouteNames.screen1:
        return _buildPageRoute(Screen1(), settings);
      case RouteNames.screen2:
        return _buildPageRoute(Screen2(), settings);
      case RouteNames.screen3:
        return _buildPageRoute(Screen3(), settings);
      case RouteNames.products:
        return _buildPageRoute(ProductsPage(), settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static PageRouteBuilder _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // From left
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
