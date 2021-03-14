import 'package:frontend/services/utils.dart';
import 'package:frontend/models/survey.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class SurveyApi extends Utils {

  Future<List<Survey>> getSurveys() async {
    var response = await http.get(
        Uri.tryParse('${server}questionnaires/api/questGet/getAllQuestUsers'),
        headers: header(getToken())
    );

    return [];
  }

  Future<bool> insertSurvey() async {
    var response = await http.post(
        Uri.tryParse('${server}questionnaires/api/questGet/getAllQuestUsers'),
        headers: header(getToken()),
        body: jsonEncode({})
    );

    return response.statusCode == 200;
  }

}
