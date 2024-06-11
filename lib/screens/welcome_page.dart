import 'package:dev_hampter/components/buttons.dart';
import 'package:dev_hampter/routes/routes.dart';
import 'package:dev_hampter/screens/sign_in_page.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double height = 0, width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: secondaryColor,
                )
              ],
            ),
            ClipPath(
              clipper: BezierClipper1(),
              child: Container(
                height: height * .7,
                decoration: BoxDecoration(
                    color: primaryColor,
                    image: const DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/welcomeMou.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StrokeText(
                    text: 'Manage your',
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: 'BalooThambi2',
                      fontSize: 47,
                      color: secTextColor,
                      fontWeight: FontWeight.w800,
                    ),
                    strokeColor: whiteColor,
                    strokeWidth: 5,
                  ),
                  StrokeText(
                    text: 'Finances',
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: 'BalooThambi2',
                      fontSize: 47,
                      color: secTextColor,
                      fontWeight: FontWeight.w800,
                    ),
                    strokeColor: whiteColor,
                    strokeWidth: 5,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    enabledText: 'Get Started',
                    borderRadius: BorderRadius.circular(20),
                    onPressed: () {
                      Get.toNamed(RoutesClass.signInPage);
                    },
                  ),
                  SizedBox(
                    height: height * .05,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BezierClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, size.height);
    path.cubicTo(size.width, size.height * 0.94, size.width * 0.8,
        size.height * 0.78, 0, size.height * 0.69);
    path.cubicTo(0, size.height * 0.69, 0, 0, 0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.cubicTo(
        size.width, 0, size.width, size.height, size.width, size.height);
    path.cubicTo(size.width, size.height, size.width, size.height, size.width,
        size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
