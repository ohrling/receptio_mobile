import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio/features/api/data/models/recipes_model.dart';
import 'package:receptio/features/api/domain/entities/recipes.dart';
import '../../../../fixtures/dummy_recipes.dart';

void main() {
  final tRecipes = RecipesModel(recipes: getRecipesModel(2).recipes);

  setUp(() {});

  test(
    'should be a subclass of Recipe entity',
    () async {
      // assert
      expect(tRecipes, isA<Recipes>());
    },
  );

  group('fromJson', () {
    String _jsonString = jsonRecipes();
    test('should retura a valid recipesModel', () {
      // arrange
      final List<dynamic> jsonList = json.decode(_jsonString);
      // act
      final result = RecipesModel.fromJson(jsonList);
      // assert
      expect(result, isA<RecipesModel>());
    });
  });
}
