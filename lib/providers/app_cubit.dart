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
          Feature(name: "JSON Formatter", description: "", icon: "json.png", transform: formatJSON),
          Feature(name: "Base64 Encode", description: "", icon: "base64.png", transform: base64Encoder),
          Feature(name: "Base64 Decode", description: "", icon: "base64.png", transform: base64Decoder),
          Feature(name: "JWT Debugger", description: "", icon: "jwt.png", transform: jwtDecoder),
          Feature(name: "UUID Generator", description: "", icon: "uuid.png", type: FeatureType.uuid),
          Feature(name: "URL Encode", description: "", icon: "url.png", transform: urlEncoder),
          Feature(name: "URL Decode", description: "", icon: "url.png", transform: urlDecoder),
          Feature(name: "MD5 Generator", description: "", icon: "md5.png", type: FeatureType.hash),
          Feature(name: "QR Code Generator", description: "", icon: "qrcode.png", type: FeatureType.qr),
        ], index: 0));

  setCurrentFeature(Feature feature) {
    emit(state.copyWith(current: feature));
  }
}
