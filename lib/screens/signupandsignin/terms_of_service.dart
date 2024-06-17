import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:dev_hampter/utils/terms_of_service_text.dart';

class TermsOfServicePage extends StatefulWidget {
  const TermsOfServicePage({Key? key}) : super(key: key);

  @override
  State<TermsOfServicePage> createState() => _TermsOfServicePage();
}

class _TermsOfServicePage extends State<TermsOfServicePage> {
  double height = 0, width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
                    SizedBox(
                      height: height * .02,
                    ),
                    StrokeText(
                      text: 'Terms of Service',
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
                    Expanded(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            child: Text(
                              tosText,
                              style: TextStyle(
                                fontFamily: 'BalooThambi2',
                                fontWeight: FontWeight.normal,
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
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
