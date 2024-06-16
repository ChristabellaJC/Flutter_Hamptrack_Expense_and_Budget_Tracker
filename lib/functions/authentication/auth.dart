import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/functions/authentication/user_model.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
