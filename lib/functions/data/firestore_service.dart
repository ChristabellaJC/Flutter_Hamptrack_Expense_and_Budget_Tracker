import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> getDataStream(String userId, DateTime selectedDate) {
    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1)
        .subtract(Duration(days: 1));

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Data')
        .where('Date', isGreaterThanOrEqualTo: startOfMonth)
        .where('Date', isLessThanOrEqualTo: endOfMonth)
        .orderBy('Date', descending: true)
        .snapshots();
  }

  Future<void> addData(String userId, String note, DateTime date, bool type,
      int amount, int category) {
    final CollectionReference data = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Data');

    return data.add({
      'Amount': amount,
      'Date': date,
      'Note': note,
      'Type': type,
      'Category': category,
    });
  }
}