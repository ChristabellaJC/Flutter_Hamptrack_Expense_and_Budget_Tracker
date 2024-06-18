import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/components/block.dart';
import 'package:dev_hampter/components/dates.dart';
import 'package:dev_hampter/components/mou_state.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  String username = '';
  String userID = '';
  bool isLoading = true;
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

// Inside _HomePageState class
  void _handleDateSelected(DateTime selectedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

  Future<void> fetchUsername() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          setState(() {
            username = userData['Username'];
            userID = userData['id'];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                    isLoading
                        ? CircularProgressIndicator()
                        : StrokeText(
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
                        mouState(),
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
                        mouCondition(),
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
                        onDateSelected: _handleDateSelected,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: firestoreService.getDataStream(
                            userID, selectedDate),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // If we reach here, we have data
                          List<DocumentSnapshot> data = snapshot.data!.docs;

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 10),
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> dataMap =
                                  data[index].data() as Map<String, dynamic>;
                              int amount = dataMap['Amount'];
                              bool type = dataMap['Type'];
                              DateTime date = dataMap['Date'].toDate();

                              return CustomBlock(
                                amount: amount,
                                type: type,
                                date: date,
                              );
                            },
                          );
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