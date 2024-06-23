import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dev_hampter/components/bottomnavbar.dart';
import 'package:dev_hampter/components/buttons.dart';
import 'package:get/get.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class EditBudgetPage extends StatefulWidget {
  const EditBudgetPage({Key? key}) : super(key: key);

  @override
  State<EditBudgetPage> createState() => _EditBudgetPageState();
}

class _EditBudgetPageState extends State<EditBudgetPage> {
  double height = 0, width = 0;
  final _amountController = TextEditingController();
  NumberFormat _numberFormat = NumberFormat.decimalPattern('id-ID');

    Future<void> _submitData(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle the case when the user is not signed in
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not signed in', 
          style: TextStyle(color: textColor)),
          backgroundColor: primaryColor,
        ),
      );
      return;
    }

    final String budgetStr = _amountController.text;
    if (budgetStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid amount', 
          style: TextStyle(color: textColor)),
          backgroundColor: primaryColor,
        ),
      );
      return;
    }

    final double? budget = double.tryParse(budgetStr);
    if (budget == null || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid amount',
        style: TextStyle(color: textColor)),
          backgroundColor: primaryColor,
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .update({'Budget': budget});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Budget updated successfully', 
          style: TextStyle(color: textColor)),
          backgroundColor: primaryColor,
          ),
      );
      Get.to(() => NavBar());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update budget: $e', 
        style: TextStyle(color: textColor)),
          backgroundColor: primaryColor,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserBudget();
  }


  Future<void> _loadUserBudget() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          final budget = userData['Budget'];
          if (budget != null) {
            _amountController.text = _numberFormat.format(budget);
          }
        }
      }
    } catch (e) {
      print('Error loading user budget: $e');
    }
  }

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
        backgroundColor: primaryColor,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * 0.8,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: accPadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(() => NavBar());
                          },
                          icon: Icon(
                            Icons.highlight_off,
                            color: iconColor,
                            size: titleAccFont,
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Edit Budget',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleAccFont,
                              fontFamily: 'BalooThambi2',
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Padding( 
                          padding: accPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: textColor,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      symbol,
                                      style: TextStyle(
                                        fontFamily: 'BalooThambi2',
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .6,
                                      child: TextField(
                                        controller: _amountController,
                                        cursorColor: whiteColor,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        style: TextStyle(
                                          fontFamily: 'BalooThambi2',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ], 
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                enabledText: "Save Budget", 
                                onPressed: () => _submitData(context),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      )
    );
  }
}