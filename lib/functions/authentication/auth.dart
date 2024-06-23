import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Inisialisasi budget default
    await _firestore.collection('Users').doc(userCredential.user?.uid).set({
      'Email': email,
      'Budget': 1000000,  // Default budget
    });

    return userCredential;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByEmail(String email) async {
    final querySnapshot = await _firestore
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.first
        : throw Exception('User not found');
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updateUserData(String userId, Map<String, dynamic> userData) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update(userData);
    } catch (e) {
      print('Error updating user data: $e');
      throw Exception('Failed to update user data');
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);

        // Jika berhasil, update juga email di Firestore
        await updateUserEmailInFirestore(user.uid, newEmail);
      } else {
        throw Exception('Current user is null');
      }
    } catch (e) {
      print('Error updating email: $e');
      throw Exception('Failed to update email');
    }
  }

  Future<void> updateUserEmailInFirestore(String userId, String newEmail) async {
    try {
      await _firestore.collection('Users').doc(userId).update({
        'Email': newEmail,
      });
    } catch (e) {
      print('Error updating email in Firestore: $e');
      throw Exception('Failed to update email in Firestore');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception('Current user is null');
      }
    } catch (e) {
      print('Error updating password: $e');
      throw Exception('Failed to update password');
    }
  }
}
