import 'package:dev_hampter/components/buttons.dart';
import 'package:dev_hampter/components/textFields.dart';
import 'package:dev_hampter/routes/routes.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                    SizedBox(
                      height: height * .02,
                    ),
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
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    CustomButton(
                      enabledText: 'Sign Up',
                      onPressed: () {
                        Get.toNamed(RoutesClass.homePage);
                      },
                      borderRadius: BorderRadius.circular(20),
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
