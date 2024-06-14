import 'package:dev_hampter/components/dates.dart';
import 'package:dev_hampter/components/mou_state.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:intl/intl.dart';
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
    String incomeAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(incomeAmt);
    String expenseAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(expenseAmt);
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
                height: height * .8,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * .15,
                            width: width * .30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    color: textColor,
                                    fontFamily: 'BalooThambi2',
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  incomeAmount,
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: 'BalooThambi2',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: height * .15,
                            width: width * .30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Expenses',
                                  style: TextStyle(
                                    color: textColor,
                                    fontFamily: 'BalooThambi2',
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  expenseAmount,
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: 'BalooThambi2',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                          // Handle the selected date
                          print('Selected Date: $selectedDate');
                        },
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

// void main() => runApp(const HomePage());

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double maxProgress = 250000;
//     double currentProgress = 25000;
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         backgroundColor: textColor,
//         body: Stack(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 padding: const EdgeInsets.fromLTRB(15, 90, 15, 40),
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height * 0.3,
//                 color: Colors.transparent,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Welcome Back",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: whiteColor,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 2,
//                             color: strokeColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       'Angela Chow',
//                       style: TextStyle(
//                         fontSize: 30,
//                         color: whiteColor,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 2,
//                             color: strokeColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height * 0.75,
//                 decoration: BoxDecoration(
//                   color: secondaryColor,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     //STATS EXPENSE DAN INCOME
//                     Column(
//                       children: [
//                         const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 25)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                                 width: 150,
//                                 height: 100,
//                                 decoration: BoxDecoration(
//                                   color: primaryColor,
//                                   borderRadius: BorderRadius.circular(13),
//                                 ),

//                                 // BOX EXPENSE
//                                 child: const Box(title: 'Expense', value: 250000)),
//                             const SizedBox(width: 30),
//                             // BOX INCOME
//                             Container(
//                               width: 150,
//                               height: 100,
//                               decoration: BoxDecoration(
//                                 color: primaryColor,
//                                 borderRadius: BorderRadius.circular(13),
//                               ),
//                               child: const Box(title: 'Income', value: 250000),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),

//                     const SizedBox(
//                       height: 20,
//                     ),

//                     //Progress
//                     const Text(
//                       'Budget',
//                     ),
//                     Stack(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                           width: double.infinity,
//                           height: 20,
//                           decoration: BoxDecoration(
//                             color: secondaryColor,
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: primaryColor, width: 1),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                           width: (currentProgress / maxProgress) *
//                               MediaQuery.of(context).size.width,
//                           height: 20,
//                           decoration: BoxDecoration(
//                             color: primaryColor,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "25.000",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             "250.000",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     //GAMBAR

//                     //MOU

//                     //DOING WELL

//                     //GARIS

//                     //HISTORY

//                     //ROW JAN2024 - DES2024

//                     //COLUMN
//                     //CONTAINER
//                     //ROW
//                     //ICON EXPENSE OR INCOME
//                     //COLUMN
//                     //NOMINAL
//                     //TANGGAL
//                     //ICON HAPUS
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         //   fontFamily: 'BalooThambi2',
//         //   // useMaterial3: true,
//         // ),
//         // initialRoute: RoutesClass.splashScreen,
//         // getPages: RoutesClass.routes,
//       ),
//     );
//   }
// }
