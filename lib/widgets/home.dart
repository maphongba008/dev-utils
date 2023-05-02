import 'package:dev_tools/providers/app_cubit.dart';
import 'package:dev_tools/widgets/content.dart';
import 'package:dev_tools/widgets/left_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(builder: (context, state) {
      print("size: ${state.features.length}");
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          LeftSideBar(),
          ContentBox(),
        ],
      );
    });
  }
}
