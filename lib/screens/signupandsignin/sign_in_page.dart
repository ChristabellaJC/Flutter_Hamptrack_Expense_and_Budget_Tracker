import 'package:dev_hampter/components/buttons.dart';
import 'package:dev_hampter/components/checkbox.dart';
import 'package:dev_hampter/components/textFields.dart';
import 'package:dev_hampter/routes/routes.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                height: height * .8,
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
                      text: 'Welcome Back!',
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
                      height: height * .1,
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
                        ),
                        SizedBox(
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
                      enabledText: 'Sign In',
                      onPressed: () {
                        Get.toNamed(RoutesClass.navBar);
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
                          "Don't have an account? ",
                          style: TextStyle(
                              fontFamily: 'BalooThambi2',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textColor),
                        ),
                        CustomTextButton(
                          onPressed: () {
                            Get.toNamed(RoutesClass.signUpPage);
                          },
                          text: 'Sign Up',
                          textColor: secTextColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
