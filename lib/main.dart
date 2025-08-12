import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'app.dart';
import 'core/network/alice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  final alice = Alice(showNotification: true);
  await dioProvider.initAlice(alice);
  runApp(OverlaySupport.global(child: MyApp()));
}
