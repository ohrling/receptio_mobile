import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/features/recipes/data/datasources/recipe_datasource.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/measurements_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipes_model.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredients.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/measurements.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  RecipeDataSource recipeDataSource;

  setUp(() {
    recipeDataSource = MockDataSource();
  });

  group('RecipeDataSource tests', () {
    test(
      'should get a success when trying to fetch recipes',
      () async {
        // arrange
        when(recipeDataSource.fetchRecipes(any)).thenAnswer((_) async =>
            SuccessState<RecipesModel>(
                RecipesModel.fromJson(json.decode(jsonRecipes()))));
        // act
        final actual = await recipeDataSource.fetchRecipes('pizza');
        // assert
        expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
      },
    );
    test(
      'should get a failure when trying to fetch recipes',
      () async {
        // arrange
        when(recipeDataSource.fetchRecipes('pizza'))
            .thenAnswer((_) async => ErrorState<String>('Error, error'));
        // act
        final actual = await recipeDataSource.fetchRecipes('pizza');
        // assert
        expect(actual, isInstanceOf<ErrorState>());
      },
    );
    test(
      'should get a success when trying to fetch recipes',
      () async {
        // arrange
        when(recipeDataSource.fetchRecipe(any)).thenAnswer((_) async =>
            SuccessState<RecipeModel>(
                RecipeModel.fromJson(json.decode(jsonRecipe()))));
        // act
        final actual = await recipeDataSource.fetchRecipe(1);
        // assert
        expect(actual, isInstanceOf<SuccessState<RecipeModel>>());
      },
    );
    test(
      'should get a failure when trying to fetch recipes',
      () async {
        // arrange
        when(recipeDataSource.fetchRecipe(any))
            .thenAnswer((_) async => ErrorState<String>('Error, error'));
        // act
        final actual = await recipeDataSource.fetchRecipe(1);
        // assert
        expect(actual, isInstanceOf<ErrorState>());
      },
    );
    test(
      'should get a success when trying to post recipes',
      () async {
        // arrange
        when(recipeDataSource.sendRecipe(any))
            .thenAnswer((_) async => SuccessState<RecipeModel>(getRecipe()));
        // act
        final actual = await recipeDataSource
            .sendRecipe((getRecipe() as RecipeModel).toJson());
        // assert
        expect(actual, isInstanceOf<SuccessState<RecipeModel>>());
      },
    );
    test(
      'should get a errorstate when trying to post recipes fails',
      () async {
        // arrange
        when(recipeDataSource.sendRecipe(any))
            .thenAnswer((_) async => ErrorState<String>('Error'));
        // act
        final actual = await recipeDataSource
            .sendRecipe((getRecipe() as RecipeModel).toJson());
        // assert
        expect(actual, isInstanceOf<ErrorState<String>>());
      },
    );
    test(
      'should get a list of measurements when fetching measurements',
      () async {
        // arrange
        when(recipeDataSource.getMeasurements()).thenAnswer((_) async =>
            SuccessState<Measurements>(MeasurementsModel.fromJson(json.decode(
                '[{"measurementType":"deciliters"},{"measurementType":"grams"}]'))));
        // act
        final actual = await recipeDataSource.getMeasurements();
        // assert
        expect(actual, isInstanceOf<SuccessState<Measurements>>());
      },
    );
    test(
      'should get a errorstate when trying to get measurements fails',
      () async {
        // arrange
        when(recipeDataSource.getMeasurements())
            .thenAnswer((_) async => ErrorState<String>('Error'));
        // act
        final actual = await recipeDataSource.getMeasurements();
        // assert
        expect(actual, isInstanceOf<ErrorState<String>>());
      },
    );
    test(
      'should get a list of ingredients when fetching ingredients',
      () async {
        // arrange
        when(recipeDataSource.getIngredients()).thenAnswer((_) async =>
            SuccessState<Ingredients>(IngredientsModel.fromJson(json.decode(
                '[{"name":"pizza sauce","imageUrl":null,"measurementType":"deciliters","amount":3.5},{"name":"bread flour","imageUrl":null,"measurementType":"grams","amount":400.0}]'))));
        // act
        final actual = await recipeDataSource.getIngredients();
        // assert
        expect(actual, isInstanceOf<SuccessState<Ingredients>>());
      },
    );
    test(
      'should get a errorstate when trying to get ingredients fails',
      () async {
        // arrange
        when(recipeDataSource.getIngredients())
            .thenAnswer((_) async => ErrorState<String>('Error'));
        // act
        final actual = await recipeDataSource.getIngredients();
        // assert
        expect(actual, isInstanceOf<ErrorState<String>>());
      },
    );
  });
}
