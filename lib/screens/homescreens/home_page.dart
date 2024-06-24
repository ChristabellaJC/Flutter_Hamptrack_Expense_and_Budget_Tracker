import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/components/mou_state.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';

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
  double userBudget = 0; 
  double totalExpenses = 0.0;
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    fetchUsername();
    fetchData();
  }

  //Fetch username function
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
            userID = userData['id'] ?? '';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redCol,
          content: Text(
            'Failed to fetch data: $e',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  //Fetching data function
  Future<void> fetchData() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          String userID = userData['id'];

          //Get current month/year
          DateTime now = DateTime.now();
          DateTime startOfMonth = DateTime(now.year, now.month, 1);
          DateTime endOfMonth =
              DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

          //Get expenses for said date
          final expensesCollection = FirebaseFirestore.instance
              .collection('Users')
              .doc(userID)
              .collection('Data');

          final expensesQuery = await expensesCollection
              .where('Type', isEqualTo: true)
              .where('Date', isGreaterThanOrEqualTo: startOfMonth)
              .where('Date', isLessThanOrEqualTo: endOfMonth)
              .get();

          //Fetch budget
          final userBudgetDoc = await FirebaseFirestore.instance
              .collection('Users')
              .doc(userID)
              .get();

          if (userBudgetDoc.exists &&
              userBudgetDoc.data() != null &&
              userBudgetDoc.data()!['Budget'] != null) {
            setState(() {
              userBudget = (userBudgetDoc.data()!['Budget'] as num).toDouble();
            });
          }

          //Calculate total expenses
          int total = 0;
          for (var doc in expensesQuery.docs) {
            total += (doc['Amount'] as num).toInt();
          }

          setState(() {
            totalExpenses = total.toDouble(); 
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching expenses: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  //Calculate percentage for progress bar 
  double calculateBudgetPercentage() {
    if (userBudget <= 0.0 || totalExpenses < 0.0) {
      return 0.0;
    }

    double percentage = (userBudget - totalExpenses) / userBudget;

    //Ensure percentage is within range
    if (percentage.isNaN) {
      return 0.0;
    } else if (percentage < 0.0) {
      return 0.0;
    } else if (percentage > 1.0) {
      return 1.0;
    }
    return percentage;
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
                      height: height * .02,
                    ),
                    Text('Welcome Back,',
                        style: TextStyle(
                          fontFamily: 'BalooThambi2',
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        )),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            username,
                            style: TextStyle(
                              fontFamily: 'BalooThambi2',
                              fontSize: 40,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
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
                          border: Border.all(color: iconColor, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GFProgressBar(
                          percentage: calculateBudgetPercentage(),
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
                        mouState(calculateBudgetPercentage()),
                        height: 200,
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
                        mouCondition(calculateBudgetPercentage()),
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
