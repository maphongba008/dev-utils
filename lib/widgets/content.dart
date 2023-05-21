import 'package:dev_tools/models/feature_type.dart';
import 'package:dev_tools/providers/app_cubit.dart';
import 'package:dev_tools/widgets/features/icon.dart';
import 'package:dev_tools/widgets/features/md5.dart';
import 'package:dev_tools/widgets/features/qr.dart';
import 'package:dev_tools/widgets/features/transformation.dart';
import 'package:dev_tools/widgets/features/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(
      builder: (context, state) {
        var current = state.current;
        if (current == null) {
          return Container();
        }
        return Center(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  current.name,
                  style: TextStyle(fontSize: 28),
                )));
      },
    );
  }
}

class FeatureContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(
      builder: (context, state) {
        var current = state.current;
        if (current == null) {
          return Container();
        }
        switch (current.type) {
          case FeatureType.transformation:
            return TransformationPad();
          case FeatureType.uuid:
            return UuidPad();
          case FeatureType.qr:
            return QrPad();
          case FeatureType.hash:
            return Md5Pad();
          case FeatureType.icon:
            return IconPad();
        }
        return Container();
      },
    );
  }
}

class ContentBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FeatureTitle(),
            Expanded(child: FeatureContent()),
          ],
        ),
      ),
    );
  }
}
