import "package:dev_hampter/components/bottomnavbar.dart";
import "package:dev_hampter/screens/account/about_page.dart";
import "package:dev_hampter/screens/account/account_page.dart";
import "package:dev_hampter/screens/account/account_settings_page.dart";
import "package:dev_hampter/screens/homescreens/details_page.dart";
import "package:dev_hampter/screens/homescreens/home_page.dart";
import "package:dev_hampter/screens/signupandsignin/sign_up_page.dart";
import "package:dev_hampter/screens/signupandsignin/sign_in_page.dart";
import "package:dev_hampter/screens/splashscreens/splash_screen.dart";
import "package:dev_hampter/screens/signupandsignin/terms_of_service.dart";
import "package:dev_hampter/screens/splashscreens/welcome_page.dart";
import "package:dev_hampter/screens/account/about_page.dart";
import "package:get/get.dart";

class RoutesClass {
  static String splashScreen = "/splashScreen";
  static String welcomePage = "/welcomePage";
  static String signInPage = "/signInPage";
  static String signUpPage = "/signUpPage";
  static String homePage = "/homePage";
  static String termsOfServicePage = "/termsOfServicePage";
  static String addPage = "/addPage";
  static String addDetailsPage = "/addDetailsPage";
  static String detailsPage = "/detailsPage";
  static String accountPage = "/accountPage";
  static String accountSettingsPage = "/accountSettingsPage";
  static String navBar = "/navBar";
  static String aboutPage = "/aboutPage";
  static String editBudgetPage = "/editBudgetPage";

  static String getSplashRoute() => splashScreen;
  static String getWelcomePage() => welcomePage;
  static String getSignInPage() => signInPage;
  static String getHomePage() => homePage;
  static String getTermsOfServicePage() => termsOfServicePage;
  static String getAddPage() => addPage;
  static String getAddDetailsPage() => addDetailsPage;
  static String getDetailsPage() => detailsPage;
  static String getAccountPage() => accountPage;
  static String getAccountSettingsPage() => accountSettingsPage;
  static String getNavBar() => navBar;
  static String getAboutPage() => aboutPage;
  static String getEditBudgetPage() => editBudgetPage;

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
    // GetPage(    // GetPage(
    //   name: addDetailsPage,
    //   page: () => const AddDetailsPage(),
    // ),
    //   name: addPage,
    //   page: () => const AddPage(),
    // ),

    GetPage(
      name: detailsPage,
      page: () => const DetailsPage(),
    ),
    GetPage(
      name: accountPage,
      page: () => const AccountPage(),
    ),
    GetPage(
      name: accountSettingsPage,
      page: () => const AccountSettingsPage(),
    ),
    GetPage(
      name: navBar,
      page: () => const NavBar(),
    ),
    GetPage(
      name: aboutPage,
      page: () => const AboutPage(),
    ),
  ];
}
