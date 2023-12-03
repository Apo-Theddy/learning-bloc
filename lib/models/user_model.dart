class UserModel {
  final String username;
  final String email;
  UserModel({this.username = "", this.email = ""});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(username: json["username"], email: json["email"]);
  }
}
