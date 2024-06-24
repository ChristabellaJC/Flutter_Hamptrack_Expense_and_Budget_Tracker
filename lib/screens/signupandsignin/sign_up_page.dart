import 'package:dev_hampter/components/buttons.dart';
import 'package:dev_hampter/components/checkbox.dart';
import 'package:dev_hampter/components/text_fields.dart';
import 'package:dev_hampter/functions/authentication/create_user.dart';
import 'package:dev_hampter/functions/authentication/user_model.dart';
import 'package:dev_hampter/routes/routes.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? errorMessage = '';
  bool isTOSChecked = false;

  Future<void> createUserWithEmailAndPassword() async {
    if (!isTOSChecked) {
      Get.snackbar(
        "Error",
        "You must agree to the Terms of Service",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: textColor,
      );
      return;
    }

    if (_usernameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Username cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: textColor,
      );
      return;
    }

    if (_emailController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: textColor,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: textColor,
      );
      return;
    }

    if (_passwordController.text != _checkPassController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: textColor,
      );
      return;
    }

    final user = UserModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      username: _usernameController.text.trim(),
    );
    createUser(user);

    try {
      await Auth().createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      // Navigate to the home page after successful sign up
      Get.toNamed(RoutesClass.navBar);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _checkPassController = TextEditingController();
  double height = 0, width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: padding,
                height: height * .8, // Adjust the height as needed
                width: width,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    StrokeText(
                      text: 'Join Us!',
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        fontFamily: 'BalooThambi2',
                        fontSize: 40,
                        color: secTextColor,
                        fontWeight: FontWeight.w800,
                      ),
                      strokeColor: whiteColor,
                      strokeWidth: 5,
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    CustomTextField(
                      text: 'Username...',
                      fontSize: 18,
                      height: 44,
                      width: width * .6,
                      controller: _usernameController,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomTextField(
                      text: 'Enter your E-Mail...',
                      fontSize: 18,
                      height: 44,
                      width: width * .6,
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomTextField(
                      text: 'Enter your Password...',
                      fontSize: 18,
                      height: 44,
                      width: width * .6,
                      isPassword: true,
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomTextField(
                      text: 'Repeat your Password...',
                      fontSize: 18,
                      height: 44,
                      width: width * .6,
                      isPassword: true,
                      controller: _checkPassController,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: height * .05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomCheckBox(
                          scaleSize: 1.0,
                          value: isTOSChecked,
                          onChanged: (value) {
                            setState(() {
                              isTOSChecked = value ?? false;
                            });
                          },
                        ),
                        const SizedBox(
                          width: .5,
                        ),
                        Text(
                          'Do you agree to our ',
                          style: TextStyle(
                            fontFamily: 'BalooThambi2',
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CustomTextButton(
                          onPressed: () {
                            Get.toNamed(RoutesClass.termsOfServicePage);
                          },
                          text: 'TOS',
                          textColor: secTextColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomButton(
                      enabledText: 'Sign Up',
                      onPressed: () async {
                        await createUserWithEmailAndPassword();
                      },
                      borderRadius: BorderRadius.circular(20),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                              fontFamily: 'BalooThambi2',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textColor),
                        ),
                        CustomTextButton(
                          onPressed: () {
                            Get.toNamed(RoutesClass.signInPage);
                          },
                          text: 'Sign In',
                          textColor: secTextColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (errorMessage != null)
              Align(
                alignment: Alignment.center,
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
