import 'package:flutter/material.dart';
import 'package:flutter_automation/config/router/route_functions.dart';
import 'package:flutter_automation/core/constants/app_text_styles.dart';
import '../core/widgets/bullet_points_text.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Flutter Automation Setup'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🚀 Welcome to Flutter Automation App',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 20),
              const Text(
                '🔧 How to use:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
               Text('- Open your terminal or Git Bash',style: AppTextStyles.body,),
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

              ElevatedButton(
                onPressed: () {
                  RouteFunctions.navigateToWithArgs(context, '/screen1', 123);
                },
                child: const Text('screen1'),
              ),
              ElevatedButton(
                onPressed: () {
                  RouteFunctions.navigateTo(context, '/screen2');
                },
                child: const Text('screen2'),
              ),
              ElevatedButton(
                onPressed: () {
                  RouteFunctions.pushNamedAndRemoveUntil(context, '/screen3', {
                    's': "sss",
                  });
                },
                child: const Text('screen3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
