import 'package:dev_hampter/components/buttons.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/screens/account/account_settings_page.dart';
import 'package:dev_hampter/screens/signupandsignin/sign_in_page.dart';
import 'package:dev_hampter/screens/account/about_page.dart';
import 'package:dev_hampter/screens/account/editbudget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  double height = 0, width = 0;
  String username = '';
  String email = '';
  String userID = '';

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  //Fetch username
  Future<void> fetchUsername() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          setState(() {
            username = userData['Username'];
            userID = userData['id'] ?? '';
            email = userData['Email'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Container(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Text(username,
                        style: TextStyle(
                          fontFamily: 'BalooThambi2',
                          fontSize: 40,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(email,
                        style: TextStyle(
                          fontFamily: 'BalooThambi2',
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: padding,
                  height: height * .7,
                  width: width,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(height: 10),
                      CustomButton(
                        enabledText: 'Settings',
                        onPressed: () {
                          Get.to(() => const AccountSettingsPage());
                        },
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [primaryColor, primaryColor]),
                        width: width * .8,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        enabledText: 'Edit Budget',
                        onPressed: () {
                          Get.to(() => const EditBudgetPage());
                        },
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [primaryColor, primaryColor]),
                        width: width * .8,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        enabledText: 'About Us',
                        onPressed: () {
                          Get.to(() => const AboutPage());
                        },
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [primaryColor, primaryColor]),
                        width: width * .8,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        enabledText: 'Logout',
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Get.to(() => const SignInPage());
                        },
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [primaryColor, primaryColor]),
                        width: width * .8,
                      ),
                    ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
