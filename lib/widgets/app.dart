import 'package:dev_tools/providers/app_cubit.dart';
import 'package:dev_tools/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var i = 0;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AppCubit(),
        child: Scaffold(
          body: HomeScreen(),
          appBar: AppBar(
            title: Text("Dev Tools"),
          ),
        ));
  }
}

class TextWithGreenBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                Container(color: Colors.amber, child: Text("Long Long text")),
              ],
            ),
            Row(
              children: [
                Container(color: Colors.red, child: Text("Short Text")),
              ],
            ),
          ],
        ),
        Expanded(child: Container(color: Colors.yellow, child: Expanded(child: Text("Sample 3")))),
      ],
    );
  }
}
