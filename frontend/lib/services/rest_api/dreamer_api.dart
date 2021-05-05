import 'package:frontend/models/dreamer.dart';
import 'package:frontend/services/utils.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class DreamerApi extends Utils {

  Future<bool> login(Map<String, dynamic> dreamer, bool firstAccess) async {
    var response = await http.post(
        Uri.tryParse('${server}login'),
        headers: firstAccess ? headerFirstAccess : header(getToken()),
        body: jsonEncode(dreamer)
    );

    if (response.headers['authorization'] != null) {
      setToken(response.headers['authorization']);
    }

    return response.statusCode == 200;
  }


  Future<bool> registered(Dreamer dreamer) async {
    var response = await http.post(
        Uri.tryParse('${server}api/dreamers/createNew'),
        headers: header(getToken()),
        body: jsonEncode(dreamer.registered())
    );

    return response.statusCode == 200;
  }

}
