import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  IngredientModel(
      {@required id, @required name, imageUrl, measurementType, amount})
      : super(
            id: id,
            name: name,
            imageUrl: imageUrl,
            measurementType: measurementType,
            amount: amount);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'measurementType': measurementType,
      'amount': amount
    };
  }

  static IngredientModel fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) return null;
    return IngredientModel(
        id: parsedJson['id']?.toInt(),
        name: parsedJson['name'],
        imageUrl: parsedJson['imageUrl'],
        measurementType: parsedJson['measurementType']?.toString(),
        amount: parsedJson['amount']?.toDouble());
  }

  String toJson() => json.encode(toMap());
}
