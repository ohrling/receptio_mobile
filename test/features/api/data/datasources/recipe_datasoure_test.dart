import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/features/api/data/datasources/recipe_datasource.dart';
import 'package:receptio/features/api/data/models/recipe_model.dart';
import 'package:receptio/features/api/data/models/recipes_model.dart';
import 'package:receptio/features/api/domain/entities/ingredients.dart';
import 'package:receptio/features/api/domain/entities/measurements.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  RemoteRecipeDataSource recipeDataSource;

  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';
  group('RecipeDataSource tests', () {
    group('searchRecipesByName', () {
      test(
        'should get a success when trying to search recipes by name',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(jsonRecipes(), 200);
            }),
          );
          // act
          final actual =
              await recipeDataSource.searchRecipesByName('pizza', tToken);
          // assert
          expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
        },
      );
      test(
        'should get a error when trying to search recipes by name without success',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '{"Error": "Didnt find anything}', 401);
            }),
          );
          // act
          final actual =
              await recipeDataSource.searchRecipesByName('dator', tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    group('searchRecipesByIngredients', () {
      test(
        'should get a success when trying to search recipes by ingredients',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(jsonRecipes(), 200);
            }),
          );
          // act
          final actual = await recipeDataSource
              .searchRecipesByIngredients(['salt', 'cheese'], tToken);
          // assert
          expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
        },
      );
      test(
        'should get a error when trying to search recipes by name without success',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '{"Error": "Didnt find anything}', 401);
            }),
          );
          // act
          final actual = await recipeDataSource
              .searchRecipesByIngredients(['dator', 'asfalt'], tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    group('getUserRecipes', () {
      test(
        'should get a successtate with a list of recipes',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(jsonRecipes(), 200);
            }),
          );
          // act
          final actual = await recipeDataSource.getUserRecipes(tToken);
          // assert
          expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
        },
      );
      test(
        'should get a errorstate when trying to get lists',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '{"Error": "Didnt find anything}', 401);
            }),
          );
          // act
          final actual = await recipeDataSource.getUserRecipes(tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    group('fetchRecipe', () {
      test(
        'should get a success when trying to fetch recipe',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(jsonRecipe(), 200);
            }),
          );
          // act
          final actual = await recipeDataSource.fetchRecipe(1, tToken);
          // assert
          expect(actual, isInstanceOf<SuccessState<RecipeModel>>());
        },
      );
      test(
        'should get a failure when trying to fetch recipe without success',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '{"Error": "Didnt find anything}', 401);
            }),
          );
          // act
          final actual = await recipeDataSource.fetchRecipe(1, tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    group('sendRecipe', () {
      test(
        'should get a success when trying to post recipe',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(jsonRecipe(), 201);
            }),
          );
          final actual = await recipeDataSource.sendRecipe(
              (getRecipe() as RecipeModel).toJson(), tToken);
          // assert
          expect(actual, isInstanceOf<SuccessState<String>>());
        },
      );
      test(
        'should return a errorstate from statuscode 409 when the recipe already exists',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(MockClient((request) async {
            return await http.Response(
                '{"Error": "Recipe already exists."}', 409);
          }));
          // act
          final actual = await recipeDataSource.sendRecipe(
              (getRecipe() as RecipeModel).toJson(), tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
          expect((actual as ErrorState).msg, 'Recipe already exists.');
        },
      );
      test(
        'should get a errorstate when trying to post recipe fails',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '{"Error": "Invalid input, object invalid"}', 400);
            }),
          );
          // act
          final actual = await recipeDataSource.sendRecipe(
              (getRecipe() as RecipeModel).toJson(), tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    group('getMeasurments', () {
      test(
        'should get a list of measurements when fetching measurements',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '[{"measurementType":"deciliters"},{"measurementType":"grams"}]',
                  200);
            }),
          );
          // act
          final actual = await recipeDataSource.getMeasurements(tToken);
          // assert
          expect(actual, isInstanceOf<SuccessState<Measurements>>());
        },
      );
      test(
        'should get a errorstate when trying to get measurements fails',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '{"Error": "Didnt find anything}', 400);
            }),
          );
          // act
          final actual = await recipeDataSource.getMeasurements(tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    group('getIngredients', () {
      test(
        'should get a list of ingredients when fetching ingredients',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '[{"name":"pizza sauce","imageUrl":null,"measurementType":"deciliters","amount":3.5},{"name":"bread flour","imageUrl":null,"measurementType":"grams","amount":400.0}]',
                  200);
            }),
          );
          // act
          final actual = await recipeDataSource.getIngredients(tToken);
          // assert
          expect(actual, isInstanceOf<SuccessState<Ingredients>>());
        },
      );
      test(
        'should get a errorstate when trying to get ingredients fails',
        () async {
          // arrange
          recipeDataSource = RemoteRecipeDataSource(
            MockClient((request) async {
              return await http.Response(
                  '{"Error": "Didnt find anything}', 400);
            }),
          );
          // act
          final actual = await recipeDataSource.getIngredients(tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
}
