import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> addData(String userId, String note, DateTime date, bool type,
      int amount, int category) {
    final CollectionReference data = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Data');

    return data.add(
      {
        'Amount': amount,
        'Date': date,
        'Note': note,
        'Type': type,
        'Category': category,
      },
    );
  }
}
