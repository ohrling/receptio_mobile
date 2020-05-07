import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipe.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  final tRecipe = RecipeModel(
    id: 1,
    name: 'Chicago Deep-dish Pizza',
    description: 'Classic chicago deep dish pizza with lots of pepperoni!',
    cookingTime: 90,
    servings: 4,
    instructions:
        'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.',
    ingredients: getIngredientsModel(),
    imageUrl: '/images/pizza.jpg',
    author: 'John Doe',
  );

  test(
    'should be a subclass of Recipe entity',
    () async {
      // assert
      expect(tRecipe, isA<Recipe>());
    },
  );

  group('fromJson', () {
    String tjsonRecipe = jsonRecipe();
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(tjsonRecipe);
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
          'id': 1,
          'name': 'Chicago Deep-dish Pizza',
          'description':
              'Classic chicago deep dish pizza with lots of pepperoni!',
          'cookingTime': 90,
          'servings': 4,
          'instructions':
              'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.',
          'ingredients': (getIngredientsModel() as IngredientsModel).toJson(),
          'imageUrl': '/images/pizza.jpg',
          'author': 'John Doe'
        };
        // act
        print(tRecipe);
        final result = tRecipe.toJson();
        // assert
        expect(result, expectedMap);
      },
    );
  });
}
