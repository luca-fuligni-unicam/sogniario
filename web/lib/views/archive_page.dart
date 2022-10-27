import 'package:flutter/material.dart';
import 'package:web/models/dropped_file.dart';
import 'package:web/models/uploaded_file.dart';
import 'package:web/widgets/alert.dart';
import '../models/test_data.dart';
import '../widgets/dropzone_file_widget.dart';
import '../widgets/dropzone_widget.dart';

class ArchivePage extends StatefulWidget {
  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  //DroppedFile? file;
  UploadedFile? file;
  List<Map> staticData = TestData.data;
  Map<int, bool> selectedFlag = {};
  bool isSelectionMode = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Archive upload'),
        ),
        body: Row(children: [
          Expanded(
            child:
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UploadedFileWidget(file: file),
                const SizedBox(height: 16),
                Container(
                  height: 300,
                  child: DropzoneWidget(
                    onUploadedFile: (file) => setState(() {
                      this.file = file;
                    }),
                  ),
                ),
              ],
            ),
          ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (builder, index) {
                Map data = staticData[index];

                selectedFlag[index] = selectedFlag[index] ?? false;
                bool? isSelected = selectedFlag[index];

                return ListTile(
                  //onLongPress: () => onLongPress(isSelected!, index),
                  onTap: () => onTap(isSelected!, index),
                  title: Text("${data['name']}"),
                  subtitle: Text("${data['email']}"),
                  leading: _buildSelectIcon(isSelected!, data),
                );
              },
              itemCount: staticData.length,
            ),
          ),
        ]),
      );

  Widget _buildSelectIcon(bool isSelected, Map data) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
        //color: Colors.lightBlue.shade100,
      );
    } else {
      return CircleAvatar(
        child: Text('${data['id']}'),
      );
    }
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      // If there will be any true in the selectionFlag then
      // selection Mode will be true
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  /*void onTap(bool isSelected, int index) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        isSelectionMode = selectedFlag.containsValue(true);
      });
    } else {
      // Open Detail Page
    }
  }*/
}
