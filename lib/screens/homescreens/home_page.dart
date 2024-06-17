import 'package:dev_hampter/components/block.dart';
import 'package:dev_hampter/components/dates.dart';
import 'package:dev_hampter/components/mou_state.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:stroke_text/stroke_text.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    String condition = mouCondition();
    String state = mouState();
    // String incomeAmount = NumberFormat.currency(
    //   locale: 'id_ID',
    //   symbol: 'Rp. ',
    //   decimalDigits: 0,
    // ).format(incomeAmt);
    // String expenseAmount = NumberFormat.currency(
    //   locale: 'id_ID',
    //   symbol: 'Rp. ',
    //   decimalDigits: 0,
    // ).format(expenseAmt);
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Container(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .05,
                    ),
                    StrokeText(
                      text: 'Welcome Back,',
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        fontFamily: 'BalooThambi2',
                        fontSize: 20,
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        height: .1,
                      ),
                      strokeColor: secTextColor,
                      strokeWidth: 5,
                    ),
                    StrokeText(
                      text: username,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        fontFamily: 'BalooThambi2',
                        fontSize: 40,
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      strokeColor: secTextColor,
                      strokeWidth: 5,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: padding,
                height: height * .7,
                width: width,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Container(
                      //       height: height * .15,
                      //       width: width * .21,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20),
                      //         color: primaryColor,
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'Income',
                      //             style: TextStyle(
                      //               color: textColor,
                      //               fontFamily: 'BalooThambi2',
                      //               fontSize: 25,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Text(
                      //             incomeAmount,
                      //             style: TextStyle(
                      //               color: whiteColor,
                      //               fontFamily: 'BalooThambi2',
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       height: height * .15,
                      //       width: width * .21,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20),
                      //         color: primaryColor,
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'Expenses',
                      //             style: TextStyle(
                      //               color: textColor,
                      //               fontFamily: 'BalooThambi2',
                      //               fontSize: 25,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Text(
                      //             expenseAmount,
                      //             style: TextStyle(
                      //               color: whiteColor,
                      //               fontFamily: 'BalooThambi2',
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Text(
                        'Budget',
                        style: TextStyle(
                          color: textColor,
                          fontFamily: 'BalooThambi2',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: iconColor, width: 2), // Outline border
                          borderRadius: BorderRadius.circular(
                              10), // Adjust border radius as needed
                        ),
                        child: GFProgressBar(
                          percentage: budgetProg,
                          lineHeight: 20,
                          backgroundColor: secondaryColor,
                          progressBarColor: primaryColor,
                          animation: true,
                        ),
                      ),
                      SizedBox(
                        height: height * .1,
                      ),
                      Image.asset(
                        state,
                        height: 150,
                      ),
                      Text(
                        'Mou',
                        style: TextStyle(
                          color: textColor,
                          fontFamily: 'BalooThambi2',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        condition,
                        style: TextStyle(
                          color: textColor,
                          fontFamily: 'BalooThambi2',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Divider(
                        color: iconColor,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Divider(
                        color: iconColor,
                        thickness: 2,
                        indent: 40,
                        endIndent: 40,
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      Text(
                        'History',
                        style: TextStyle(
                          color: textColor,
                          fontFamily: 'BalooThambi2',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      HorizontalCalendar(
                        onDateSelected: (selectedDate) {
                          print('Selected Date: $selectedDate');
                        },
                      ),
                      CustomBlock(
                        amount: 10000,
                        type: true,
                        date: DateTime.now(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
