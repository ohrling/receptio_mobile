import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Measurements extends Equatable {
  final List<String> measurementType;
  Measurements({
    @required this.measurementType,
  });
}
