class UserModel {
  final String? id;
  final String email;
  final String password;
  final String phone;

  UserModel({this.id, required this.email, required this.password, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      "Email": email,
      "Password": password,
      "Phone": phone,
    };
  }
}
