import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:dev_hampter/components/bottomnavbar.dart';
import 'package:dev_hampter/components/buttons.dart';
import 'package:get/get.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/services.dart';


class EditBudgetPage extends StatefulWidget {
  const EditBudgetPage({Key? key}) : super(key: key);

  @override
  State<EditBudgetPage> createState() => _EditBudgetPageState();
}

class _EditBudgetPageState extends State<EditBudgetPage> {
  double height = 0, width = 0;
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                              onPressed: () {
                                Get.to(() => NavBar());
                              }, 
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
    );
  }
}