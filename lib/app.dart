import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/router/route_names.dart';
import 'config/router/routes.dart';
import 'config/theme/app_theme.dart';
import 'core/network/alice.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(412, 846),
      builder: (context, child) {
        return MaterialApp(
          title: "Flutter Automation",
          navigatorKey: dioProvider.navigatorKey,
          theme: AppTheme.getDarkTheme(),
          // darkTheme: AppTheme.getDarkTheme(),
          // themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: RouteNames.home,
          routes: Routes.getRoutes(),
          supportedLocales: [
            Locale('en'),
            Locale('zh'),
            Locale('fr'),
            Locale('es'),
            Locale('de'),
            Locale('ru'),
            Locale('ja'),
            Locale('ar'),
            Locale('fa'),
            Locale("es"),
            Locale("it"),
            Locale("ta"),
            Locale('ms'),
          ],
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
