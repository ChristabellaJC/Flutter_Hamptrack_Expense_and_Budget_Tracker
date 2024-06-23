import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/components/block.dart';
import 'package:dev_hampter/components/dates.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:dev_hampter/functions/chart/pie_chart.dart';

void main() => runApp(const DetailsPage());

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
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

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
            userID = userData['id'] ?? '';
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
                        HorizontalCalendar(
                          onDateSelected: _handleDateSelected,
                        ),
                        CustomBlockTwo(
                          icon: Icons.account_balance_outlined,
                          text: 'Budget',
                          amount: monthlyBudget,
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

                            return Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.length,
                                  separatorBuilder: (context, index) =>
                                      Divider(),
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
                                      userId: userID, // Pass the userID here
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
