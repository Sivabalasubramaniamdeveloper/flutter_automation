import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void dispose() {
    // Reset to Default Orientation
    print("ssss");
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // final args = ModalRoute.of(context)!.settings.arguments as int;
    return Text("Screen1");
  }
}
