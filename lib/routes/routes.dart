import "package:dev_hampter/screens/home_page.dart";
import "package:dev_hampter/screens/sign_up_page.dart";
import "package:dev_hampter/screens/sign_in_page.dart";
import "package:dev_hampter/screens/splash_screen.dart";
import "package:dev_hampter/screens/terms_of_service.dart";
import "package:dev_hampter/screens/welcome_page.dart";
import "package:get/get.dart";

class RoutesClass {
  static String splashScreen = "/splashScreen";
  static String welcomePage = "/welcomePage";
  static String signInPage = "/signInPage";
  static String signUpPage = "/signUpPage";
  static String homePage = "/homePage";
  static String termsOfServicePage = "/termsOfServicePage";

  static String getSplashRoute() => splashScreen;
  static String getWelcomePage() => welcomePage;
  static String getSignInPage() => signInPage;
  static String getHomePage() => homePage;
  static String getTermsOfServicePage() => termsOfServicePage;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
      name: welcomePage,
      page: () => const WelcomePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: signInPage,
      page: () => const SignInPage(),
    ),
    GetPage(
      name: signUpPage,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: termsOfServicePage,
      page: () => const TermsOfServicePage(),
    ),
  ];
}
