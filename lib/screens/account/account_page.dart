import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/components/settingfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stroke_text/stroke_text.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  double height = 0, width = 0;
  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          setState(() {
            _username = userData['Username'];
            _email = userData['Email'];
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }


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
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 90, 15, 40),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_username != null)
                    StrokeText(
                      text: _username!,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        fontFamily: 'BalooThambi2',
                        fontSize: 40,
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        height: 0.1,
                      ),
                      strokeColor: secTextColor,
                      strokeWidth: 5,
                    ),
                  SizedBox(height: 16),
                  if (_email != null)
                    StrokeText(
                      text: _email!,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        fontFamily: 'BalooThambi2',
                        fontSize: 20,
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      strokeColor: secTextColor,
                      strokeWidth: 5,
                    ),
            ],),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: padding,
              height: height * .6,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            }, 
                            icon: Icon(
                              Icons.highlight_off,
                              color: iconColor,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    


                    ],
                  ),
                ),
            ],)
          ),
          ),
        ],
        
      )
    ),
    );
  }
}
