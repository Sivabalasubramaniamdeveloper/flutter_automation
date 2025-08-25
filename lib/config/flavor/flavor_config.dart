enum Flavor {
  sit, uat, prod
}

class FlavorConfig {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
 case Flavor.sit:
      return 'SIVA SIT'; case Flavor.uat:
      return 'SIVA UAT'; case Flavor.prod:
      return 'SIVA PROD';
      default:
        return 'SIVA';
    }
  }

  static bool get isDevelopment {
    switch (appFlavor) {
case Flavor.sit:
        return true;case Flavor.uat:
        return true;case Flavor.prod:
        return false;
      default:
        return false;
    }
  }

  static bool get isSIVA {
    switch (appFlavor) {
case Flavor.sit:
      return true;case Flavor.uat:
      return true;case Flavor.prod:
      return true;
      default:
        return true;
    }
  }
}
