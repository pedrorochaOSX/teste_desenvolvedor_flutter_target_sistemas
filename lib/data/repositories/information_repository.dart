import 'dart:convert';

import 'package:teste_desenvolvedor_flutter_target_sistemas/data/models/information_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const informationListKey = 'information_list';

class InformationRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Information>> getInformationList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString =
        sharedPreferences.getString(informationListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Information.fromJson(e)).toList();
  }

  void saveInformationList(List<Information> informations) {
    final jsonString = json.encode(informations);
    sharedPreferences.setString('information_list', jsonString);
  }
}