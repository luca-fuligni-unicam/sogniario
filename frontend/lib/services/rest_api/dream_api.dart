import 'package:frontend/services/utils.dart';
import 'package:frontend/models/dream.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class DreamApi extends Utils {

  Future<List<Dream>> getDreams(String date) async {
    var response = await http.get(
        Uri.tryParse('${server}api/reports/listByIdAndData/${getToken()}/$date'),
        headers: header
    );

    if (jsonDecode(response.body) is String) {
      return [Dream(id: null)];
    }

    return List.from(jsonDecode(response.body))
        .map((e) => Dream.fromJson(e))
        .toList();
  }

}
