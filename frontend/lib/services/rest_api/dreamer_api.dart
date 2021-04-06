import 'package:frontend/models/dreamer.dart';
import 'package:frontend/services/utils.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class DreamerApi extends Utils {

  Future<bool> registered(Dreamer dreamer) async {
    var response = await http.post(
        Uri.tryParse('${server}api/dreamers/createNew'),
        headers: header,
        body: jsonEncode(dreamer.registered())
    );

    return response.statusCode == 200;
  }

}
