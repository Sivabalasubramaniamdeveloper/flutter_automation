import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_automation/core/logger/app_logger.dart';
import 'package:flutter_automation/core/widgets/custom_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'app.dart';
import 'config/flavor/flavor_config.dart';
import 'core/network/alice.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      await EasyLocalization.ensureInitialized();
      // changeAppIcon();
      // const fatalError = true;
      // // Non-async exceptions
      // FlutterError.onError = (errorDetails) {
      //   if (fatalError) {
      //     // If you want to record a "fatal" exception
      //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      //     // ignore: dead_code
      //   } else {
      //     // If you want to record a "non-fatal" exception
      //     FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      //   }
      // };
      // // Async exceptions
      // PlatformDispatcher.instance.onError = (error, stack) {
      //   if (fatalError) {
      //     // If you want to record a "fatal" exception
      //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      //     // ignore: dead_code
      //   } else {
      //     // If you want to record a "non-fatal" exception
      //     FirebaseCrashlytics.instance.recordError(error, stack);
      //   }
      //   return true;
      // };
      await ScreenUtil.ensureScreenSize();
      final alice = Alice(showNotification: FlavorConfig.isDevelopment);
      await dioProvider.initAlice(alice);
      runApp(
        EasyLocalization(
          supportedLocales: [Locale('ta', ''), Locale('en', '')],
          path: 'assets/translations',
          fallbackLocale: Locale('ta'),
          child: FlavorConfig.isDevelopment
              ? OverlaySupport.global(child: MyApp())
              : MyApp(),
        ),
      );
    },
    (error, stack) {
      AppLogger.e(error.toString(), "runZonedGuarded");
    },
  );
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MyCustomErrorWidget(details);
  };
}

void changeAppIcon() async {
  final now = DateTime.now();
  final day = DateFormat('EEEE').format(now); // Monday, Tuesday, etc.

  const platform = MethodChannel('app.icon.change');

  if (day == 'Saturday' || day == 'Sunday') {
    await platform.invokeMethod('setIcon', {'icon': 'weekend'});
  } else {
    await platform.invokeMethod('setIcon', {'icon': 'weekday'});
  }
}
