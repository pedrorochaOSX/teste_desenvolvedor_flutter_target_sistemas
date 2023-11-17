class User {
  User({
    required this.username,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  String username;
  String password;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
