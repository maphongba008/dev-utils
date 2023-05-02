import 'package:dart_code_viewer2/dart_code_viewer2.dart';
import 'package:dev_tools/providers/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransformationPad extends StatefulWidget {
  @override
  State<TransformationPad> createState() => _TransformationPadState();
}

class _TransformationPadState extends State<TransformationPad> {
  var code = "";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocListener<AppCubit, AppCubitState>(
            listenWhen: (previous, current) => previous.current != current.current,
            listener: (context, state) {
              _controller.value = _controller.value.copyWith(
                text: "",
              );
            },
            child: Container(),
          ),
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
          SizedBox(
            width: 16,
          ),
          BlocBuilder<AppCubit, AppCubitState>(
            builder: (context, state) {
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DartCodeViewer(
                    state.current?.transform?.call(code) ?? "No transformation selected",
                    backgroundColor: Colors.white,
                    copyButtonText: Text("Copy"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
