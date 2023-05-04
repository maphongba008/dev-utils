import 'package:bloc/bloc.dart';
import 'package:dev_tools/models/feature.dart';
import 'package:dev_tools/models/feature_type.dart';
import 'package:equatable/equatable.dart';
import 'package:dev_tools/utils/index.dart';

class AppCubitState extends Equatable {
  final List<Feature> features;
  final int index;
  final Feature? current;

  AppCubitState({required this.features, required this.index, this.current});

  @override
  List<Object?> get props => [features, index, current];

  copyWith({List<Feature>? features, int? index, Feature? current}) {
    return AppCubitState(
        features: features ?? this.features, index: index ?? this.index, current: current ?? this.current);
  }
}

class AppCubit extends Cubit<AppCubitState> {
  AppCubit()
      : super(AppCubitState(features: [
          Feature(name: "JSON Formatter", description: "", icon: "", transform: formatJSON),
          Feature(name: "Base64 Encode", description: "", icon: "", transform: base64Encoder),
          Feature(name: "Base64 Decode", description: "", icon: "", transform: base64Decoder),
          Feature(name: "JWT Debugger", description: "", icon: "", transform: jwtDecoder),
          Feature(name: "UUID Generator", description: "", icon: "", type: FeatureType.uuid),
          Feature(name: "URL Encode", description: "", icon: "", transform: urlEncoder),
          Feature(name: "URL Decode", description: "", icon: "", transform: urlDecoder),
          Feature(name: "MD5 Generator", description: "", icon: "", type: FeatureType.hash),
          Feature(name: "QR Code Generator", description: "", icon: "", type: FeatureType.qr),
        ], index: 0));

  setCurrentFeature(Feature feature) {
    emit(state.copyWith(current: feature));
  }
}
