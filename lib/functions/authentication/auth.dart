import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Authorize Users class
class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Create new user
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    //Set default budget
    await _firestore.collection('Users').doc(userCredential.user?.uid).set({
      'Email': email,
      'Budget': 1000000,
    });

    return userCredential;
  }

  //Sign in
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //Get user by E-mail
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByEmail(
      String email) async {
    final querySnapshot = await _firestore
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.first
        : throw Exception('User not found');
  }

  //Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //Update data
  Future<void> updateUserData(
      String userId, Map<String, dynamic> userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update(userData);
    } catch (e) {
      print('Error updating user data: $e');
      throw Exception('Failed to update user data');
    }
  }
}
