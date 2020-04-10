import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  final tRecipe = getRecipeModel(1);

  test(
    'should be a subclass of Recipe entity',
    () async {
      // assert
      expect(tRecipe, isA<Recipe>());
    },
  );

  group('fromJson', () {
    String _jsonRecipe = jsonRecipe();
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(_jsonRecipe);
        // act
        final result = RecipeModel.fromJson(jsonMap);
        // assert
        expect(result, isA<RecipeModel>());
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final expectedMap = {
          "id": 1,
          "name": "Chicago Deep-dish Pizza",
          "description":
              "Classic chicago deep dish pizza with lots of pepperoni!",
          "cookingTime": 90,
          "servings": 4,
          "instructions":
              "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
          "ingredients": [
            {
              "id": 45,
              "name": "Cheese",
              "measurementType": "grams",
              "image": "/",
              "amount": 300
            },
            {
              "id": 986,
              "name": "Pepperoni",
              "measurementType": "grams",
              "image": "/",
              "amount": 100
            },
            {
              "id": 983,
              "name": "Tomato sauce",
              "measurementType": "grams",
              "image": "/",
              "amount": 500
            }
          ],
          "image": "/images/pizza.jpg",
          "source": "John Doe"
        };
        // act
        final result = tRecipe.toJson();
        // assert
        expect(result, expectedMap);
      },
    );
  });
}
