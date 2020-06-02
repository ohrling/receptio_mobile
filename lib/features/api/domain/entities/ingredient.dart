import 'package:flutter/foundation.dart';

class Ingredient {
  final int id;
  final String name;
  final String imageUrl;
  String measurementType;
  double amount;

  Ingredient(
      {@required this.id,
      @required this.name,
      this.imageUrl,
      this.measurementType,
      this.amount});
}
