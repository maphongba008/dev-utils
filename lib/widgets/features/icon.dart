import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class IconPad extends StatefulWidget {
  @override
  State<IconPad> createState() => _IconPadState();
}

var allowFiles = ["png", "jpg", "jpeg"];

Future<List<String>> pickFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, allowedExtensions: allowFiles);
  return result?.files
          .map((e) => e.path ?? "")
          .where((e) => allowFiles.contains(e.substring(e.lastIndexOf(".") + 1)))
          .where((element) => element.isNotEmpty)
          .toList() ??
      [];
}

Future<String> chooseOutputPath() async {
  String? destination = await FilePicker.platform.getDirectoryPath(dialogTitle: "Save to");
  return destination ?? "";
}

Future<void> generateFiles(
    {required List<String> paths, required bool android, required bool ios, required bool reactNative}) async {}

class _IconPadState extends State<IconPad> {
  bool isAndroid = false;
  bool isIOS = false;
  bool isReactNative = false;
  List<String> icons = [];
  var _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var isGenerateEnabled = isAndroid || isIOS || isReactNative;
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () async {
                  var files = await pickFiles();
                  setState(() {
                    icons = [...icons, ...files.toList()];
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [Icon(Icons.add_a_photo, size: 60), Text("Add 3x icons")],
                  ),
                ),
              ),
            ),
            Images(
              images: icons,
              onDelete: (path) {
                setState(() {
                  icons.remove(path);
                });
              },
            ),
            SizedBox(height: 16),
            MyCheckbox(
              label: "Android",
              value: isAndroid,
              onChanged: (v) {
                setState(() {
                  isAndroid = v;
                });
              },
            ),
            MyCheckbox(
              label: "iOS",
              value: isIOS,
              onChanged: (v) {
                setState(() {
                  isIOS = v;
                });
              },
            ),
            MyCheckbox(
              label: "React Native",
              value: isReactNative,
              onChanged: (v) {
                setState(() {
                  isReactNative = v;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Output path:"),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Choose output path',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                    onPressed: () async {
                      var path = await chooseOutputPath();
                      _inputController.text = path;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [Icon(Icons.folder), SizedBox(width: 16), Text("Browse")]),
                    )),
              ],
            ),
            SizedBox(height: 56),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: isGenerateEnabled ? () {} : null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [Icon(Icons.download), SizedBox(width: 16), Text("Generate")]),
                    )),
              ),
            ),
          ],
        )),
      ],
    );
  }
}

class MyCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

  MyCheckbox({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(children: [
        Checkbox(
            value: value,
            onChanged: (v) {
              onChanged(v ?? false);
            }),
        Text(label)
      ]),
    );
  }
}

class Images extends StatelessWidget {
  final List<String> images;
  final Function(String) onDelete;

  Images({required this.images, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container();
    }
    return Row(
      children: images
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Image.file(
                      File(e),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          onDelete(e);
                        },
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
