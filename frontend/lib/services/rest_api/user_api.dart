import 'package:frontend/services/utils.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class UserApi extends Utils {

  Future<bool> registered() async {
    var response = await http.post(
        Uri.tryParse('${server}auth/api/public/signupUser'),
        headers: header(getToken()),
        body: jsonEncode({'token': getToken()})
    );

    return response.statusCode == 200;
  }

}
