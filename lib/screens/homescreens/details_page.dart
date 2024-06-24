import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/components/block.dart';
import 'package:dev_hampter/components/dates.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/functions/chart/pie_chart.dart';

void main() => runApp(const DetailsPage());

//Details Page
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DateTime selectedDate = DateTime.now();
  String username = '';
  String userID = '';
  bool isLoading = true;
  int monthlyBudget = 0;
  FirestoreService firestoreService = FirestoreService();

  int totalIncome = 0;
  int totalExpense = 0;

  @override

  //Initialize before page loads
  void initState() {
    super.initState();
    fetchUserID();
  }

  //To determine what date user picked
  void _handleDateSelected(DateTime selectedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
    fetchMonthlySummary();
  }

  //Fetch userID
  Future<void> fetchUserID() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          setState(() {
            userID = userData['id'] ?? '';
            isLoading = false;
          });
          fetchMonthlySummary();
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  //Fetching data for each month/year
  Future<void> fetchMonthlySummary() async {
    try {
      if (userID.isNotEmpty) {
        Map<String, int> summary =
            await firestoreService.getMonthlySummary(userID, selectedDate);
        int budget = await firestoreService.fetchMonthlyBudget(userID);
        setState(() {
          totalIncome = summary['income']!;
          totalExpense = summary['expense']!;
          monthlyBudget = budget;
        });
      }
    } catch (e) {
      print('Error fetching monthly summary: $e');
    }
  }

  //Function to delete data
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
      fetchMonthlySummary();
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
              child: Align(
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
                        //Details Start
                        Text(
                          'Details',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'BalooThambi2',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        //Calendar picker
                        HorizontalCalendar(
                          onDateSelected: _handleDateSelected,
                        ),
                        Divider(
                          color: textColor,
                        ),
                        Divider(
                          color: textColor,
                          endIndent: 80,
                          indent: 80,
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        //Budget shown
                        CustomBlockTwo(
                          icon: Icons.account_balance_outlined,
                          size: width,
                          text: 'Budget',
                          amount: monthlyBudget,
                          numberSize: 20,
                          titleSize: 25,
                          iconBack: 70,
                          iconSize: 50,
                          width: 10,
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        //Income and Expense shown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBlockTwo(
                              size: width * .44,
                              icon: Icons.savings,
                              text: 'Income',
                              amount: totalExpense,
                              numberSize: 15,
                              titleSize: 20,
                              iconBack: 60,
                              iconSize: 40,
                              width: 5,
                            ),
                            CustomBlockTwo(
                              size: width * .44,
                              icon: Icons.payments,
                              text: 'Expense',
                              amount: totalIncome,
                              numberSize: 15,
                              titleSize: 20,
                              iconBack: 60,
                              iconSize: 40,
                              width: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'Average',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'BalooThambi2',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.15,
                        ),
                        //Pie chart shown
                        PieChartSample2(
                          userId: userID,
                          selectedDate: selectedDate,
                        ),
                        SizedBox(height: height * .01),
                        Text(
                          'History',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'BalooThambi2',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height * .02),
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
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<DocumentSnapshot> data = snapshot.data!.docs;
                            if (data.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Data Yet!',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            //Build list for history
                            return Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.length,
                                  separatorBuilder: (context, index) => Divider(
                                    color: secondaryColor,
                                  ),
                                  itemBuilder: (context, index) {
                                    var doc = data[index];
                                    var docId = doc.id;
                                    var amount = doc['Amount'];
                                    var type = doc['Type'];
                                    var date =
                                        (doc['Date'] as Timestamp).toDate();
                                    var note = doc['Note'];
                                    var category = doc['Category'];
                                    return CustomBlock(
                                      amount: amount,
                                      category: category,
                                      type: type,
                                      date: date,
                                      note: note,
                                      docId: docId,
                                      onDelete: _deleteData,
                                      userId: userID,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
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
