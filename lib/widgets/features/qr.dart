import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPad extends StatefulWidget {
  @override
  State<QrPad> createState() => _QrPadState();
}

class _QrPadState extends State<QrPad> {
  final _controller = TextEditingController();
  var code = "";

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
        SizedBox(height: 16),
        Expanded(
            child: Center(
          child: QrImage(
            data: code,
            version: QrVersions.auto,
            size: 300,
          ),
        ))
        // Add this QRCode widget in place of the Container
      ],
    );
  }
}
