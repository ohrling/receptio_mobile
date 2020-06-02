import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio/features/api/data/models/ingredient_model.dart';
import 'package:receptio/features/api/domain/entities/ingredient.dart';

void main() {
  final tIngredient = IngredientModel.fromJson(json.decode('''
        {
          "name":"pizza sauce",
          "imageUrl":null,
          "measurementType":"deciliters",
          "amount":3.5
        }'''));

  test(
    'should be a subclass of Measurements entity',
    () async {
      // assert
      expect(tIngredient, isA<Ingredient>());
    },
  );

  group('fromJson', () {
    String tJsonIngredient = '''
        {
          "name":"pizza sauce",
          "imageUrl":null,
          "measurementType":"deciliters",
          "amount":3.5
        }''';
    test(
      'should return a valid ingredientmodel',
      () async {
        // arrange
        final jsonMap = json.decode(tJsonIngredient);
        // act
        final result = IngredientModel.fromJson(jsonMap);
        // assert
        expect(result, isA<IngredientModel>());
        expect(result.name, 'pizza sauce');
      },
    );
  });
}
