import 'package:flutter/material.dart';
import 'package:flutter_automation/core/logger/app_logger.dart';

class MyCustomErrorWidget extends StatefulWidget {
  final FlutterErrorDetails details;

  const MyCustomErrorWidget(this.details, {super.key});

  @override
  State<MyCustomErrorWidget> createState() => _MyCustomErrorWidgetState();
}

class _MyCustomErrorWidgetState extends State<MyCustomErrorWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppLogger.e(widget.details.exception.toString(), widget.details.library);
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.readLogs().then((onValue) => print(onValue));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 80),
            const SizedBox(height: 16),
            const Text(
              "Oops! Something went wrong.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.details.exception.toString(), // show error message
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
