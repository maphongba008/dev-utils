import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

var generator = Uuid();

class UuidPad extends StatefulWidget {
  @override
  State<UuidPad> createState() => _UuidPadState();
}

enum UuidVersion { v1, v4 }

class RadioRow extends StatelessWidget {
  final String title;
  final UuidVersion selectedVersion;
  final UuidVersion version;
  final Function(UuidVersion) onChanged;

  RadioRow({required this.title, required this.selectedVersion, required this.version, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onChanged(version)},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Radio<UuidVersion>(
              value: version,
              groupValue: selectedVersion,
              onChanged: (UuidVersion? value) {
                onChanged(value!);
              }),
          Text(title),
        ]),
      ),
    );
  }
}

class UuidItem {
  final String title;
  final UuidVersion version;

  UuidItem({required this.title, required this.version});
}

class UuidView extends StatelessWidget {
  final List<String> uuids;

  UuidView({required this.uuids});

  @override
  Widget build(BuildContext context) {
    var i = 1;
    return ListView(children: [
      ...uuids.map((text) {
        return Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: SelectableText(
            "${i++}. $text",
            style: TextStyle(fontSize: 18),
          ),
        );
      })
    ]);
  }
}

class _UuidPadState extends State<UuidPad> {
  var version = UuidVersion.v4;
  var uuids = <String>[];
  final _controller = TextEditingController();
  void generateUUID() {
    try {
      var numOfUuids = int.parse(_controller.text);
      var result = List.generate(numOfUuids, (i) => generator.v4());
      setState(() {
        uuids = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid number")));
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      UuidItem(title: "Version 4", version: UuidVersion.v4),
      UuidItem(title: "Version 1", version: UuidVersion.v1),
    ];
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Choose version:",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              ...data.map((item) => RadioRow(
                  title: item.title,
                  selectedVersion: version,
                  version: item.version,
                  onChanged: (v) {
                    print('changed');
                    setState(() {
                      version = v;
                    });
                  })),
              SizedBox(height: 16),
              Row(
                children: [
                  Text("How many?"),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number of UUIDs',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                      onPressed: generateUUID,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 4, right: 4),
                        child: Text("Generate"),
                      ))
                ],
              )
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: UuidView(
            uuids: uuids,
          ),
        )
      ],
    );
  }
}
