import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/features/recipes/data/datasources/recipe_datasource.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/measurements_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipes_model.dart';
import 'package:receptio_mobile/features/recipes/data/repositories/recipes_repository.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  RecipesRepository repository;
  RecipeDataSource dataSource;
  NetworkInfo networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockDataSource();
    repository = RecipesRepository(dataSource, networkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getRecipe', () {
    final tId = 1;
    final tRecipe = getRecipeModel(1);
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getRecipe(tId);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with RecipeModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.fetchRecipe(any))
              .thenAnswer((_) async => SuccessState<RecipeModel>(tRecipe));
          // act,
          final actual = await repository.getRecipe(tId);
          // assert
          verify(dataSource.fetchRecipe(tId));
          expect(actual, isInstanceOf<SuccessState<RecipeModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.fetchRecipe(any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getRecipe(tId);
          // assert
          verify(dataSource.fetchRecipe(tId));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.fetchRecipe(tId))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getRecipe(tId);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('getRecipes', () {
    final tSearchString = 'pizza';
    final tRecipes = getRecipesModel(1);
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getRecipes(tSearchString);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with RecipesModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.fetchRecipes(any))
              .thenAnswer((_) async => SuccessState<RecipesModel>(tRecipes));
          // act,
          final actual = await repository.getRecipes(tSearchString);
          // assert
          verify(dataSource.fetchRecipes(tSearchString));
          expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.fetchRecipes(any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getRecipes(tSearchString);
          // assert
          verify(dataSource.fetchRecipes(tSearchString));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.fetchRecipes(tSearchString))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getRecipes(tSearchString);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });

  group('postRecipe', () {
    final tRecipe = getRecipe();
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.postRecipe((tRecipe as RecipeModel).toJson());
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with String when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.sendRecipe(any))
              .thenAnswer((_) async => SuccessState<String>('Granted'));
          // act,
          final actual =
              await repository.postRecipe((tRecipe as RecipeModel).toJson());
          // assert
          verify(dataSource.sendRecipe((tRecipe as RecipeModel).toJson()));
          expect(actual, isInstanceOf<SuccessState<String>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.sendRecipe(any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual =
              await repository.postRecipe((tRecipe as RecipeModel).toJson());
          // assert
          verify(dataSource.sendRecipe((tRecipe as RecipeModel).toJson()));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.sendRecipe((tRecipe as RecipeModel).toJson()))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual =
              await repository.postRecipe((tRecipe as RecipeModel).toJson());
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });

  group('getMeasurements', () {
    final tMeasurementsModel = MeasurementsModel.fromJson(json.decode('''
    [
      {
        "measurementType":"deciliters"
      },
      {
        "measurementType":"grams"
      },
      {
        "measurementType":"deciliters"
      }
    ] '''));
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getMeasurements();
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with MeasurementsModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.getMeasurements()).thenAnswer(
              (_) async => SuccessState<MeasurementsModel>(tMeasurementsModel));
          // act,
          final actual = await repository.getMeasurements();
          // assert
          verify(dataSource.getMeasurements());
          expect(actual, isInstanceOf<SuccessState<MeasurementsModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.getMeasurements())
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getMeasurements();
          // assert
          verify(dataSource.getMeasurements());
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.getMeasurements())
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getMeasurements();
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('getIngredients', () {
    final tIngredientsModel = IngredientsModel.fromJson(json.decode('''
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
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getIngredients();
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with IngredientsModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.getIngredients()).thenAnswer(
              (_) async => SuccessState<IngredientsModel>(tIngredientsModel));
          // act,
          final actual = await repository.getIngredients();
          // assert
          verify(dataSource.getIngredients());
          expect(actual, isInstanceOf<SuccessState<IngredientsModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.getIngredients())
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getIngredients();
          // assert
          verify(dataSource.getIngredients());
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.getIngredients())
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getIngredients();
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
}
