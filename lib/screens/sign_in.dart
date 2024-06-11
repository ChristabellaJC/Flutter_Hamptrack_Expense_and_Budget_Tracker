import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .1,
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
                      height: height * .1,
                    ),
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
