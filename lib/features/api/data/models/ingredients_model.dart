import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:receptio/features/api/data/models/ingredient_model.dart';
import 'package:receptio/features/api/domain/entities/ingredient.dart';
import 'package:receptio/features/api/domain/entities/ingredients.dart';

class IngredientsModel extends Ingredients {
  IngredientsModel({@required List<Ingredient> ingredients})
      : super(ingredients: ingredients);

  Map toMap() {
    final temp = {};

    for (var i = 0; i < ingredients.length; i++) {
      temp['id'] = ingredients[i].id;
      temp['name'] = ingredients[i].name;
      temp['imageUrl'] = ingredients[i].imageUrl;
      temp['measurementType'] = ingredients[i].measurementType;
      temp['amount'] = ingredients[i].amount;
    }
    return temp;
  }

  factory IngredientsModel.fromJson(List<dynamic> parsedJson) {
    if (parsedJson == null) return null;
    List<Ingredient> temp = [];

    for (var i = 0; i < parsedJson.length; i++) {
      temp.add(IngredientModel.fromJson(parsedJson[i]));
    }
    return IngredientsModel(ingredients: temp);
  }

  String toJson() => json.encode(toMap());
}
