import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/functions/authentication/user_model.dart';
import 'package:dev_hampter/repositories/user_repository.dart';
import 'package:dev_hampter/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final userRepo = Get.put(UserRepository());

Future<void> createUser(UserModel user) async {
  try {
    UserCredential userCredential = await Auth().createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    // Update user ID
    final userId = userCredential.user?.uid ?? '';
    final newUser = UserModel(
      id: userId,
      email: user.email,
      password: user.password,
      username: user.username,
    );

    await userRepo.createUser(newUser);

    // Navigate to the home page after successful sign up
    Get.toNamed(RoutesClass.homePage);
  } catch (e) {
    print(e.toString());
    Get.snackbar("Error", "Could not create account",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}
