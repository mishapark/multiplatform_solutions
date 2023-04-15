import 'dart:convert';

import 'package:adaptive_app/data/user.dart';
import 'package:flutter/services.dart';

class DataService {
  Future<List<User>> fetchFileFromAssets(String assetsPath) async {
    final decodedJson = await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
    return decodedJson.map<User>((user) => User.fromJson(user)).toList();
  }
}
