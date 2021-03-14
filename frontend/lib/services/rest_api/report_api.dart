import 'package:frontend/services/utils.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class ReportApi extends Utils {

  /*
      "getReports" : "reports/api/users/findReportsByNicknameAndDataRangeUser",
    "getReportsMap" : "reports/api/users/getWordsPercent",
    "postReport" : "reports/api/users/store/",
   */

  Future<bool> insertReport() async {
    var response = await http.post(
      Uri.tryParse('${server}reports/api/users/store/'),
      headers: header(getToken()),
      body: jsonEncode({})
    );

    return response.statusCode == 200;
  }

}
