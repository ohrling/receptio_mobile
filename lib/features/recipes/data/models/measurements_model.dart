import 'package:flutter/foundation.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/measurements.dart';

class MeasurementsModel extends Measurements {
  MeasurementsModel({@required List<String> measurementType})
      : super(measurementType: measurementType);

  factory MeasurementsModel.fromJson(List<dynamic> parsedJson) {
    if (parsedJson == null) return null;
    List<String> temp = [];
    for (var i = 0; i < parsedJson.length; i++) {
      temp.add(parsedJson[i]['measurementType']);
    }
    return MeasurementsModel(
      measurementType: temp,
    );
  }

  @override
  String toString() => '$measurementType)';
}
