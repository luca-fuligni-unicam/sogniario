import 'package:web/services/utils.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class LoginApi extends Utils {

  Future<bool> login(Map<String, String> login, bool first) async {
    var response = await http.post(
      Uri.parse('${server}login'),
      headers: !first ? headerFirstAccess : header(getToken()),
      body: jsonEncode(login)
    );

    if (response.headers['authorization'] != null) {
      setToken(response.headers['authorization']);
    }

    return response.statusCode == 200;
  }

}
