import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/functions/authentication/user_model.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:get/get.dart';

//User repository
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
      Get.snackbar("Success", "Your account has been created",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: textColor);
    } catch (error) {
      Get.snackbar("Error", "Something went wrong, try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: textColor);
      print(error.toString());
    }
  }
}
