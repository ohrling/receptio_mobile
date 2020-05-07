import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredients.dart';

void main() {
  final tIngredients = IngredientsModel.fromJson(json.decode('''
      [
        {
          "name":"pizza sauce",
          "imageUrl":null,
          "measurementType":"deciliters",
          "amount":3.5
        },
        {
          "name":"bread flour",
          "imageUrl":null,
          "measurementType":"grams",
          "amount":400.0
        }
      ]'''));

  setUp(() {});

  test(
    'should be a subclass of Recipe entity',
    () async {
      // assert
      expect(tIngredients, isA<Ingredients>());
    },
  );

  group('fromJson', () {
    String tJsonString = '''
      [
        {
          "name":"pizza sauce",
          "imageUrl":null,
          "measurementType":"deciliters",
          "amount":3.5
        },
        {
          "name":"bread flour",
          "imageUrl":null,
          "measurementType":"grams",
          "amount":400.0
        }
      ]''';
    test('should retura a valid recipesModel', () {
      // arrange
      final List<dynamic> jsonList = json.decode(tJsonString);
      // act
      final result = IngredientsModel.fromJson(jsonList);
      // assert
      expect(result, isA<IngredientsModel>());
    });
    test(
      'should contain a list of ingredients',
      () async {
        // arrange
        final jsonList = json.decode(tJsonString);
        // act
        final result = IngredientsModel.fromJson(jsonList);
        // assert
        print(result.toString());
        expect('pizza sauce', result.ingredients[0].name);
      },
    );
  });
}
