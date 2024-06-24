import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDataStream(String userId, DateTime selectedDate) {
    if (userId.isEmpty) {
      return Stream.empty();
    }

    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1)
        .subtract(Duration(days: 1));

    return _db
        .collection('Users')
        .doc(userId)
        .collection('Data')
        .where('Date', isGreaterThanOrEqualTo: startOfMonth)
        .where('Date', isLessThanOrEqualTo: endOfMonth)
        .orderBy('Date', descending: true)
        .snapshots();
  }

  Future<void> addData(String userId, String note, DateTime date, bool type,
      int amount, int category) async {
    final CollectionReference data =
        _db.collection('Users').doc(userId).collection('Data');

    try {
      await data.add({
        'Amount': amount,
        'Date': date,
        'Note': note,
        'Type': type,
        'Category': category,
      });
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<void> deleteData(String userId, String docId) async {
    try {
      final docRef =
          _db.collection('Users').doc(userId).collection('Data').doc(docId);

      await docRef.delete();
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  Future<void> updateData(String docId, String userID, String note,
      DateTime date, bool type, int amount, int category) async {
    return _db
        .collection('Users')
        .doc(userID)
        .collection('Data')
        .doc(docId)
        .update({
      'Note': note,
      'Date': date,
      'Type': type,
      'Amount': amount,
      'Category': category,
    }).catchError((e) {
      print('Error updating data: $e');
    });
  }

  Future<Map<String, int>> getMonthlySummary(
      String userId, DateTime selectedDate) async {
    int totalIncome = 0;
    int totalExpense = 0;

    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);

    QuerySnapshot snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('Data')
        .where('Date', isGreaterThanOrEqualTo: startOfMonth)
        .where('Date', isLessThanOrEqualTo: endOfMonth)
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      bool type = data['Type'];
      int amount = data['Amount'];

      if (type) {
        totalIncome += amount;
      } else {
        totalExpense += amount;
      }
    }

    return {'income': totalIncome, 'expense': totalExpense};
  }

  Future<int> fetchMonthlyBudget(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _db.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        dynamic budget = userDoc['Budget'];
        if (budget is int) {
          return budget;
        } else if (budget is double) {
          return budget.toInt();
        } else {
          return 0;
        }
      }
      return 0;
    } catch (e) {
      print('Error fetching monthly budget: $e');
      return 0;
    }
  }
}
