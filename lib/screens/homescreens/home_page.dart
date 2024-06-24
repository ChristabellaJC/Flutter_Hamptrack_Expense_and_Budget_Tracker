import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';
import 'package:stroke_text/stroke_text.dart';
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
  double userBudget = 0; // This will hold the user's set budget
  double totalExpenses = 0.0; // Sum of all expenses
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    fetchUsername();
    fetchData();
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

  void _deleteData(String docId) async {
    try {
      await firestoreService.deleteData(userID, docId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: greenCol,
          content: Text(
            'Data deleted successfully',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redCol,
          content: Text(
            'Failed to delete data: $e',
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

  Future<void> fetchData() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          String userID = userData['id'];

          // Get current month's start and end dates
          DateTime now = DateTime.now();
          DateTime startOfMonth = DateTime(now.year, now.month, 1);
          DateTime endOfMonth =
              DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1));

          // Fetch expenses for the current month
          final expensesCollection = FirebaseFirestore.instance
              .collection('Users')
              .doc(userID)
              .collection('Data');

          final expensesQuery = await expensesCollection
              .where('Type', isEqualTo: true)
              .where('Date', isGreaterThanOrEqualTo: startOfMonth)
              .where('Date', isLessThanOrEqualTo: endOfMonth)
              .get();

          //fetch user budget
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

          // Calculate total expenses
          int total = 0;
          for (var doc in expensesQuery.docs) {
            total += (doc['Amount'] as num).toInt();
          }

          setState(() {
            totalExpenses = total.toDouble(); // Convert to double if necessary
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

  // Function to calculate percentage spent
  double calculateBudgetPercentage() {
    if (userBudget <= 0.0 || totalExpenses < 0.0) {
      return 0.0;
    }

    double percentage = (userBudget - totalExpenses) / userBudget;

    // Ensure the percentage is within the valid range
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
                        ? CircularProgressIndicator()
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
