import 'package:dev_tools/models/feature_type.dart';

typedef ValidationFunc = String? Function(String input);
typedef TransformFunc = String? Function(String input);

class Feature {
  String name;
  String description;
  String icon;
  TransformFunc? transform;
  FeatureType type;

  Feature({
    required this.name,
    required this.description,
    required this.icon,
    this.transform,
    this.type = FeatureType.transformation,
  });
}
