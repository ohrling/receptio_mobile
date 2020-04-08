import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/features/getrecipes/data/models/recipes_model.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  final tRecipes = RecipesModel(recipes: getRecipes(2).recipes);

  setUp(() {});

  test(
    'should be a subclass of Recipe entity',
    () async {
      // assert
      expect(tRecipes, isA<Recipes>());
    },
  );

  group('fromJson', () {
    String jsonString = '''
    [{
      "id": 1,
      "name": "Chicago Deep-dish Pizza",
      "description": "Classic chicago deep dish pizza with lots of pepperoni!",
      "cookingTime": 90,
      "servings": 6,
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
    },
    {
      "id": 2,
      "name": "Chicago Deep-dish Pizza",
      "description": "Classic chicago deep dish pizza with lots of pepperoni!",
      "cookingTime": 90,
      "servings": 6,
      "instructions": "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
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
    }]
    ''';
    test('should retura a valid recipesModel', () {
      // arrange
      final List<dynamic> jsonList = json.decode(jsonString);
      // act
      final result = RecipesModel.fromJson(jsonList);
      // assert
      expect(result, isA<RecipesModel>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // arrange
      final expectedMap = [
        {
          "id": 1,
          "name": "Chicago Deep-dish Pizza",
          "description": "Classic chicago deep dish pizza with lots of pepperoni!",
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
        },
        {
          "id": 2,
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
        }
      ];
      // act
      final result = tRecipes.toJson();
      print(result);
      // assert
      expect(result.toString().trim(), expectedMap.toString().trim());
    });
  });
}
