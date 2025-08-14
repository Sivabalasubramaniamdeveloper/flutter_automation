import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'app.dart';
import 'core/network/alice.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  setupLocator();
  // changeAppIcon();
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  await ScreenUtil.ensureScreenSize();
  final alice = Alice(showNotification: true);
  await dioProvider.initAlice(alice);
  runApp(OverlaySupport.global(child: MyApp()));
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
