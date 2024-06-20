import 'dart:async';
import 'package:dev_hampter/routes/routes.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _visible = !_visible;
      });
    });

    Timer(const Duration(seconds: 5), () {
      Get.toNamed(RoutesClass.getWelcomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.2,
              0.6,
              0.9,
            ],
            colors: [
              Color(0xFFFFED9E),
              Color(0xFFFFE675),
              Color(0xFFE9C317),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset('assets/images/splashMou.png', width: 180),
              const SizedBox(height: 15),
              StrokeText(
                textAlign: TextAlign.center,
                text: "HampTrack",
                textStyle: TextStyle(
                  fontFamily: 'BalooThambi2',
                  fontSize: 47,
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(1.0, 5.0),
                      blurRadius: 5.0,
                      color: shadowColor,
                    ),
                  ],
                ),
                strokeColor: textColor,
                strokeWidth: 5,
              ),
              StrokeText(
                textAlign: TextAlign.center,
                text: "Dev_Hampter",
                textStyle: TextStyle(
                  fontFamily: 'BalooThambi2',
                  fontSize: 25,
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(1.0, 5.0),
                      blurRadius: 5.0,
                      color: shadowColor,
                    ),
                  ],
                ),
                strokeColor: textColor,
                strokeWidth: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
