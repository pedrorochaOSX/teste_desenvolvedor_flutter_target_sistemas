import 'dart:convert';

import 'package:teste_desenvolvedor_flutter_target_sistemas/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userListKey = 'user_list';

class UserRepository {
  late SharedPreferences sharedPreferences;

  Future<List<User>> getUserList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString =
        sharedPreferences.getString(userListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => User.fromJson(e)).toList();
  }

  void saveUserList(List<User> users) {
    final jsonString = json.encode(users);
    sharedPreferences.setString('user_list', jsonString);
  }
}