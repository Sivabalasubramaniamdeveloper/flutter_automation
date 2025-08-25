enum Flavor { sit, uat, prod }

class FlavorConfig {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.sit:
        return 'Example SIT';
      case Flavor.uat:
        return 'Example UAT';
      case Flavor.prod:
        return 'Example PROD';
      default:
        return 'Example';
    }
  }

  static bool get isDevelopment {
    switch (appFlavor) {
      case Flavor.sit:
        return true;
      case Flavor.uat:
        return true;
      case Flavor.prod:
        return false;
      default:
        return false;
    }
  }

  static bool get isExample {
    switch (appFlavor) {
      case Flavor.sit:
        return true;
      case Flavor.uat:
        return true;
      case Flavor.prod:
        return true;
      default:
        return true;
    }
  }
}
