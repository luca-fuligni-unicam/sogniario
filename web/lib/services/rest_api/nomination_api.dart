import 'package:web/models/nomination.dart';
import 'package:web/services/utils.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class NominationApi extends Utils {

  Future<List<Nomination>> nominations() async {
    var response = await http.get(
        Uri.parse('${server}api/nominations/NominationPendenti'),
        headers: header(getToken()),
    );

    return List.of(jsonDecode(response.body))
        .map((e) => Nomination.fromJson(e))
        .toList();
  }


  Future<bool> registered(Nomination nomination) async {
    var response = await http.post(
        Uri.parse('${server}api/nominations/createNew'),
        headers: header(getToken()),
        body: jsonEncode(nomination.registered())
    );

    return response.statusCode == 200;
  }


  Future<bool> accept(String email) async {
    var response = await http.post(
        Uri.parse('${server}api/nominations/acceptNomination/$email'),
        headers: header(getToken()),
    );

    return response.statusCode == 200;
  }


  Future<bool> reject(String email) async {
    var response = await http.post(
        Uri.parse('${server}api/nominations/rejectNomination/$email'),
        headers: header(getToken()),
    );

    return response.statusCode == 200;
  }

}
