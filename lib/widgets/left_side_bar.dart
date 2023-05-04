import 'package:dev_tools/models/feature.dart';
import 'package:dev_tools/providers/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureItem extends StatelessWidget {
  final Feature item;

  FeatureItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(
      builder: (context, state) {
        var isSelected = state.current?.name == item.name;
        return InkWell(
          onTap: () {
            context.read<AppCubit>().setCurrentFeature(item);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            color: isSelected ? Colors.blue[300] : Colors.transparent,
            child: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 16),
                Text(item.name, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LeftSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(
        builder: (context, state) => SizedBox(
              width: 250,
              child: ListView(children: [...state.features.map((feature) => FeatureItem(item: feature)).toList()]),
            ));
  }
}
