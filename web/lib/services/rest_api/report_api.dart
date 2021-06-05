import 'package:web/services/utils.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;


class ReportApi extends Utils {

  void download(DateTime before, DateTime after) async {
    var uri = '${server}api/reports/getReportArchiveBetweenTwoDates/${before.toString().substring(0, 10)}/${after.toString().substring(0, 10)}';
    var response = await http.get(
        Uri.parse(uri),
        headers: header(getToken())
    );

    if (response.statusCode == 200) {
      final blob = html.Blob([response.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'release_${DateTime.now().toString().substring(0, 10)}.zip';

      html.document.body!.children.add(anchor);
      anchor.click();

      html.document.body!.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    }
  }

}
