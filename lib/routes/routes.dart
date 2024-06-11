import "dart:async";

import "package:dev_hampter/screens/home_page.dart";
import "package:dev_hampter/screens/sign_in_page.dart";
import "package:dev_hampter/screens/splash_screen.dart";
import "package:dev_hampter/screens/welcome_page.dart";
import "package:get/get.dart";

class RoutesClass {
  static String splashScreen = "/splashScreen";
  static String welcomePage = "/welcomePage";
  static String signInPage = "/signInPage";
  static String homePage = "/homePage";

  static String getSplashRoute() => splashScreen;
  static String getWelcomePage() => welcomePage;
  static String getSignInPage() => signInPage;
  static String getHomePage() => homePage;

  static List<GetPage> routes = [
    GetPage(
      name: '/splashScreen',
      page: () => SplashScreenPage(),
    ),
    GetPage(
      name: welcomePage,
      page: () => WelcomePage(),
      transition: Transition.fadeIn, // Add fade-in transition
      transitionDuration: Duration(milliseconds: 500), // Transition duration
    ),
    GetPage(
      name: '/signInPage',
      page: () => SignInPage(),
    ),
    GetPage(
      name: '/homePage',
      page: () => HomePage(),
    ),
  ];
}
