import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/functions/authentication/user_model.dart';
import 'package:dev_hampter/repositories/user_repository.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

final userRepo = Get.put(UserRepository());

Future<void> createUser(UserModel user) async {
  //Creating user
  try {
    UserCredential userCredential = await Auth().createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    //Update userId
    final userId = userCredential.user?.uid ?? '';
    final newUser = UserModel(
      id: userId,
      email: user.email,
      password: user.password,
      username: user.username,
    );

    await userRepo.createUser(newUser);
  } catch (e) {
    print(e.toString());
    Get.snackbar("Error", "Could not create account",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: redCol,
        colorText: whiteColor);
  }
}
