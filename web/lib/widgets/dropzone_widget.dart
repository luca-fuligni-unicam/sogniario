import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:web/models/uploaded_file.dart';
import '../models/dropped_file.dart';
import 'package:file_picker/file_picker.dart';

class DropzoneWidget extends StatefulWidget {
  //final ValueChanged<DroppedFile> onDroppedFile;
  final ValueChanged<UploadedFile> onUploadedFile;
  const DropzoneWidget({
    Key? key,
    //required this.onDroppedFile,
    required this.onUploadedFile,
  }) : super(key: key);

  @override
  _DropzoneWidgetState createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  //late DropzoneViewController controller;

  late FilePickerResult result;
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final colorButton = Colors.white60;

    //return buildDecoration( child:
        return Stack(
      children: [
        /*DropzoneView(
              onCreated: (controller) => this.controller = controller,
              onHover: () => setState(() => isHighlighted = true),
              onLeave: () => setState(() => isHighlighted = false),
              onDrop: acceptFile
          ),*/
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icon(Icons.cloud_upload, size: 80, color: Colors.white),
            //Text(
            //  'Here you can upload the archive. The archive format must be with the .zip extension.',
            //  style: TextStyle(color: Colors.white, fontSize: 12)
            //),
            //const SizedBox(height:16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                //padding: EdgeInsets.symmetric(horizontal: 64, vertical: 20),
                backgroundColor: colorButton,
                shape: RoundedRectangleBorder(),
                minimumSize: Size(400, 60),
              ),
              icon: Icon(Icons.search, color: Colors.black87, size: 32),
              label: Text('CHOOSE ARCHIVE',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  )),
              onPressed: () async {
                //final events = await controller.pickFiles(mime: ["application/zip"]);
                //if (events.isEmpty) return;
                //acceptFile(events.first);
                //setState(() => archiveChosen = true);
                result = (await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['zip']))!;
                acceptFile(result);
              },
            ),
            SizedBox(height: 16),
            /*ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                //padding: EdgeInsets.symmetric(horizontal: 64, vertical: 20),
                backgroundColor: colorButton,
                shape: RoundedRectangleBorder(),
                minimumSize: Size(400, 60),
              ),
              icon: Icon(Icons.account_circle_rounded,
                  color: Colors.black87, size: 32),
              label: Text('SELECT USER',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  )),
              onPressed: () async {
                //TODO: Reperire lista dreamer
              },
            ),
            SizedBox(height: 16),*/
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                //padding: EdgeInsets.symmetric(horizontal: 64, vertical: 20),
                backgroundColor: colorButton,
                shape: RoundedRectangleBorder(),
                minimumSize: Size(400, 60),
              ),
              icon: Icon(Icons.cloud_upload_rounded,
                  color: Colors.black87, size: 32),
              label: Text('UPLOAD ARCHIVE',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  )),
              onPressed: () async {
                //TODO: Upload dell'archivio
              },
            ),
          ],
        )),
      ],
    );
  }



  Future acceptFile(dynamic event) async {
    //final name = event.name;
    //final mime = await controller.getFileMIME(event);
    //final bytes = await controller.getFileSize(event);
    //final url = await controller.createFileUrl(event);
    final name = result.files.single.name;
    final bytes = result.files.single.size;

    print('Name: $name');
    //print('Mime: $mime');
    print('Bytes: $bytes');
    //print('Url: $url');

    /*final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );*/

    final uploadedFile = UploadedFile(name: name, bytes: bytes);

    //widget.onDroppedFile(droppedFile);
    widget.onUploadedFile(uploadedFile);
    //setState(() => isHighlighted = false);
  }
}
