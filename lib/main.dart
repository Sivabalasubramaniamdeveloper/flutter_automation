import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'core/network/alice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  final alice = Alice(showNotification: true);
  await dioProvider.initAlice(alice);
  runApp(OverlaySupport.global(child: MyApp()));
}

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
          home: InfoScreen(),
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

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Automation Setup'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🚀 Welcome to Flutter Automation App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                '🔧 How to use:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('- Open your terminal or Git Bash'),
              const Text('- Run the following command:'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const SelectableText(
                  './help.sh',
                  style: TextStyle(fontSize: 16, fontFamily: 'Courier'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '⚙️ Features Available:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const BulletPoint(text: 'App name customization'),
              const BulletPoint(text: 'Bundle ID setup'),
              const BulletPoint(text: 'App icon configuration'),
              const BulletPoint(text: 'Flavor initialization'),
              const BulletPoint(text: 'Firebase integration via CLI'),
              const BulletPoint(text: 'Sample login page injection'),
              const SizedBox(height: 20),
              const Text(
                '✅ Use this automation tool to quickly set up your Flutter project with best practices!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
