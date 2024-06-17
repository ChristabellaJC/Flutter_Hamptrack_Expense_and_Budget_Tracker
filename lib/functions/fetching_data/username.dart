import 'package:dev_hampter/functions/authentication/auth.dart';

Future<String?> fetchUsername() async {
  try {
    final auth = Auth();
    final user = auth.currentUser;
    if (user != null) {
      final userDoc = await auth.getUserByEmail(user.email!);
      final userData = userDoc.data();
      if (userData != null) {
        return userData['Username'];
      }
    }
  } catch (e) {
    print('Error fetching user data: $e');
  }
  return null;
}
