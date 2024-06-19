import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> getDataStream(String userId, DateTime selectedDate) {
    if (userId.isEmpty) {
      return Stream.empty();
    }

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
      int amount, int category) async {
    final CollectionReference data = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Data');

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
      final docRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Data')
          .doc(docId);

      await docRef.delete();
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  Future<void> updateData(String docId, String userID, String note,
      DateTime date, bool type, int amount, int category) async {
    return FirebaseFirestore.instance
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
}
