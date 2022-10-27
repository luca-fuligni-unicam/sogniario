import 'package:flutter/material.dart';
//import '../models/dropped_file.dart';
import '../models/uploaded_file.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadedFileWidget extends StatelessWidget {
  //final DroppedFile? file;
  final UploadedFile? file;

  const UploadedFileWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (file != null) ? buildFileDetails(file!) : buildUploadInfo()
        ],
      );

  Widget buildUploadInfo() => buildDecoration(
          child: Container(
        height: 100,
        child: Center(
          child: Column(
            children: [
              Icon(Icons.cloud_upload, size: 80, color: Colors.black),
              Text('The chosen archive must be a zip!',
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ],
          ),
        ),
      ));

  Widget buildFileDetails(UploadedFile file) {

    final style = TextStyle(fontSize: 20);

    return buildDecoration(
        child: Container(
            margin: EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(file.name.toString(),
                    style: style.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                //Text(file.mime, style: style),
                //const SizedBox(height: 8),
                Text(file.size.toString(), style: style),
                const SizedBox(height: 8),
                Text('Please, select the user', style: style),
              ],
            )));
  }

  Widget buildDecoration({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.lightBlue.shade100,
        padding: EdgeInsets.all(10),
        child: DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.black87,
            strokeWidth: 3,
            padding: EdgeInsets.all(30),
            dashPattern: [8, 4],
            radius: Radius.circular(10),
            child: child),
      ),
    );
  }
}
