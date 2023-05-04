import 'package:dev_tools/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Md5Pad extends StatefulWidget {
  @override
  State<Md5Pad> createState() => _Md5PadState();
}

class _Md5PadState extends State<Md5Pad> {
  final _controller = TextEditingController();
  var code = "";

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to your clipboard !')));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: 'Enter your text',
          ),
          // minLines: 5,
          controller: _controller,
          textAlignVertical: TextAlignVertical.top,
          expands: true,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) {
            setState(() {
              code = value;
            });
          },
        )),
        SizedBox(width: 16),
        Expanded(
            child: Column(
          children: [
            Row(
              children: [
                Text("MD5: "),
                Text(generateMd5(code)),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    copyToClipboard(generateMd5(code));
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                      child: Text('Copy')),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("SHA1: "),
                Text(generateSHA1(code)),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    copyToClipboard(generateSHA1(code));
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                      child: Text('Copy')),
                )
              ],
            ),
          ],
        ))
        // Add this QRCode widget in place of the Container
      ],
    );
  }
}
