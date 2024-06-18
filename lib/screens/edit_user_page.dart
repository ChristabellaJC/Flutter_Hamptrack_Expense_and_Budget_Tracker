import 'package:flutter/material.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/components/settingfields.dart';
import 'package:dev_hampter/components/buttons.dart';
import 'package:get/get.dart';
import 'package:dev_hampter/routes/routes.dart';
import 'package:dev_hampter/utils/sizes.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double height = 0, width = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  //MISAL
  void _loadUserData(){
    _usernameController.text = "johndoe";
    _emailController.text = "johndoe@example.com";
    setState(() {});
  }

  void _updateUserData() {
    print("Username: ${_usernameController.text}");
    print("Email: ${_emailController.text}");
    print("Password: ${_passwordController.text}");
    _passwordController.clear();
    Get.toNamed(RoutesClass.homePage);
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
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.transparent,
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
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                            'Settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'BalooThambi2',
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      SettingFields(label: 'Username', controller: _usernameController),
                      const SizedBox(height: 16),
                      SettingFields(label: 'Email', controller: _emailController),
                      const SizedBox(height: 16),
                      SettingFields(label: 'Password', controller: _passwordController, isObscured: true),
                      const SizedBox(height: 32),
                      Center(
                        child: CustomButton(
                          enabledText: 'Save Changes',
                          onPressed: _updateUserData,
                          borderRadius: BorderRadius.circular(20),
                        ),
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