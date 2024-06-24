//User model
class UserModel {
  final String? id;
  final String username;
  final String email;
  final String password;
  final double budget;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.budget,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Username": username,
      "Email": email,
      "Password": password,
      "Budget": budget,
    };
  }
}
