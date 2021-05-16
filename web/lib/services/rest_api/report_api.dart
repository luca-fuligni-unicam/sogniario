import 'package:web/services/utils.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;


class ReportApi extends Utils {

  void download(bool semester) async {
    int _semester = semester ? 1 : 2;
    var uri = '${server}api/reports/reportArchiveByYearAndSemester/${DateTime.now().year}/$_semester';

    var response = await http.get(Uri.parse(uri), headers: header(getToken()));

    if (response.statusCode == 200) {
      final blob = html.Blob([response.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'semester_$_semester.zip';
      html.document.body.children.add(anchor);
      anchor.click();

      html.document.body.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    }
  }

}
