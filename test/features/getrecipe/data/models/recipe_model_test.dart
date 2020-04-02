import 'dart:convert';

import 'package:better_uuid/uuid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

void main() {
  final tRecipe = RecipeModel(
    id: Uuid('d290f1ee-6c54-4b01-90e6-d701748f0851'),
    name: 'Chicago Deep-dish Pizza',
    description: 'Classic chicago deep dish pizza with lots of pepperoni!',
    cookingTime: 90,
    servings: 4,
    instructions:
        'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.',
    ingredients: [
      {
        "id": "766c510a-4218-4686-86d2-259b8e172ebb",
        "name": "Cheese",
        "measurementType": "grams",
        "image": "/"
      }
    ],
    image: '/images/pizza.jpg',
    source: 'John Doe',
  );

  test(
    'should be a subclass of Recipe entity',
    () async {
      // assert
      expect(tRecipe, isA<Recipe>());
    },
  );

  group('fromJson', () {
    String jsonRecipe = '''{"id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
        "name": "Chicago Deep-dish Pizza",
        "description": "Classic chicago deep dish pizza with lots of pepperoni!",
        "cookingTime": 90,
        "servings": 4,
        "instructions": "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
        "ingredients": [
        {
        "id": "766c510a-4218-4686-86d2-259b8e172ebb",
        "name": "Cheese",
        "measurementType": "grams",
        "image": "/"
        }
        ],
        "image": "/images/pizza.jpg",
        "source": "John Doe"}''';
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(jsonRecipe);
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
          "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
          "name": "Chicago Deep-dish Pizza",
          "description":
              "Classic chicago deep dish pizza with lots of pepperoni!",
          "cookingTime": 90,
          "servings": 4,
          "instructions":
              "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
          "ingredients": [
            {
              "id": "766c510a-4218-4686-86d2-259b8e172ebb",
              "name": "Cheese",
              "measurementType": "grams",
              "image": "/"
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
