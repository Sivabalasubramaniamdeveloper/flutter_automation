import 'flavor_config.dart';
import 'package:flutter_automation/main.dart' as app;

Future<void> main() async {
  FlavorConfig.appFlavor = Flavor.uat;
  await app.main();
}
