import "package:dev_hampter/screens/splash_screen.dart";
import "package:get/get.dart";

class RoutesClass {
  static String splashScreen = "/splashScreen";

  static String getSplashRoute() => splashScreen;

  static List<GetPage> routes = [
    GetPage(
      name: '/splashScreen',
      page: () => SplashScreenPage(),
    ),
  ];
}
