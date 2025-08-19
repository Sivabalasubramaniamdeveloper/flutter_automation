import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_providers.dart';
import 'config/router/route_generator.dart';
import 'config/router/route_names.dart';
import 'config/theme/app_theme.dart';
import 'core/network/alice.dart';
import 'core/network/internet_connectivity.dart';

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
            initialRoute: RouteNames.screen1,
            onGenerateRoute: AppRouter.generateRoute,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return BlocListener<ConnectivityCubit, ConnectivityStatus>(
                listener: (context, state) {
                  if (state == ConnectivityStatus.disconnected) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No internet connection ❌"),
                        backgroundColor: Colors.red,
                        duration: Duration(days: 1),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Back online "),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
