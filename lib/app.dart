import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_providers.dart';
import 'config/router/route_generator.dart';
import 'config/router/route_names.dart';
import 'config/theme/app_theme.dart';
import 'core/network/alice.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getAppProviders(Connectivity()),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(412, 846),
        builder: (context, child) {
          return MaterialApp(
            title: "Flutter Automation",
            navigatorKey: dioProvider.navigatorKey,
            theme: AppTheme.getNaturalTheme(),
            initialRoute: RouteNames.home,
            onGenerateRoute: AppRouter.generateRoute,
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
      ),
    );
  }
}
