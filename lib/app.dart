import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/router/route_names.dart';
import 'config/router/routes.dart';
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
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
