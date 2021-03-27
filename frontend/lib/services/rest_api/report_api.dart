import 'package:frontend/services/utils.dart';
import 'package:frontend/models/report.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class ReportApi extends Utils {

  Future<bool> insertReport(Report report) async {
    var response = await http.post(
      Uri.tryParse('${server}api/reports/createNew'),
      headers: header(getToken()),
      body: jsonEncode(report.dreamReport())
    );

    return response.statusCode == 200;
  }

}
