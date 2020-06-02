import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/network/network_info.dart';
import 'package:receptio/features/api/data/datasources/recipe_datasource.dart';
import 'package:receptio/features/api/data/models/ingredients_model.dart';
import 'package:receptio/features/api/data/models/measurements_model.dart';
import 'package:receptio/features/api/data/models/recipe_model.dart';
import 'package:receptio/features/api/data/models/recipes_model.dart';
import 'package:receptio/features/api/data/repositories/recipes_repository.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

import '../../../../fixtures/dummy_recipes.dart';
import '../../../../fixtures/mocks.dart';

void main() {
  ReceptioRepository repository;
  RecipeDataSource dataSource;
  NetworkInfo networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockReceptioDataSource();
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

  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';

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
        repository.getRecipe(tId, tToken);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with RecipeModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.fetchRecipe(any, any))
              .thenAnswer((_) async => SuccessState<RecipeModel>(tRecipe));
          // act,
          final actual = await repository.getRecipe(tId, tToken);
          // assert
          verify(dataSource.fetchRecipe(tId, tToken));
          expect(actual, isInstanceOf<SuccessState<RecipeModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.fetchRecipe(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getRecipe(tId, tToken);
          // assert
          verify(dataSource.fetchRecipe(tId, tToken));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.fetchRecipe(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getRecipe(tId, tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('getRecipesFromName', () {
    final tSearchString = 'pizza';
    final tRecipes = getRecipesModel(1);
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getRecipesFromName(tSearchString, tToken);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with RecipesModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.searchRecipesByName(any, any))
              .thenAnswer((_) async => SuccessState<RecipesModel>(tRecipes));
          // act,
          final actual =
              await repository.getRecipesFromName(tSearchString, tToken);
          // assert
          verify(dataSource.searchRecipesByName(tSearchString, tToken));
          expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.searchRecipesByName(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual =
              await repository.getRecipesFromName(tSearchString, tToken);
          // assert
          verify(dataSource.searchRecipesByName(tSearchString, tToken));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.searchRecipesByName(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual =
              await repository.getRecipesFromName(tSearchString, tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('getRecipesFromIngredients', () {
    final tSearchList = ['tomato', 'cheese'];
    final tRecipes = getRecipesModel(1);
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getRecipesFromIngredients(tSearchList, tToken);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with RecipesModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.searchRecipesByIngredients(any, any))
              .thenAnswer((_) async => SuccessState<RecipesModel>(tRecipes));
          // act,
          final actual =
              await repository.getRecipesFromIngredients(tSearchList, tToken);
          // assert
          verify(dataSource.searchRecipesByIngredients(tSearchList, tToken));
          expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.searchRecipesByIngredients(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual =
              await repository.getRecipesFromIngredients(tSearchList, tToken);
          // assert
          verify(dataSource.searchRecipesByIngredients(tSearchList, tToken));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.searchRecipesByIngredients(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual =
              await repository.getRecipesFromIngredients(tSearchList, tToken);
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
        repository.postRecipe((tRecipe as RecipeModel).toJson(), tToken);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with String when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.sendRecipe(any, any))
              .thenAnswer((_) async => SuccessState<String>('Granted'));
          // act,
          final actual = await repository.postRecipe(
              (tRecipe as RecipeModel).toJson(), tToken);
          // assert
          verify(
              dataSource.sendRecipe((tRecipe as RecipeModel).toJson(), tToken));
          expect(actual, isInstanceOf<SuccessState<String>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.sendRecipe(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.postRecipe(
              (tRecipe as RecipeModel).toJson(), tToken);
          // assert
          verify(
              dataSource.sendRecipe((tRecipe as RecipeModel).toJson(), tToken));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.sendRecipe((tRecipe as RecipeModel).toJson(), tToken))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.postRecipe(
              (tRecipe as RecipeModel).toJson(), tToken);
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
        repository.getMeasurements(tToken);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with MeasurementsModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.getMeasurements(any)).thenAnswer(
              (_) async => SuccessState<MeasurementsModel>(tMeasurementsModel));
          // act,
          final actual = await repository.getMeasurements(tToken);
          // assert
          verify(dataSource.getMeasurements(tToken));
          expect(actual, isInstanceOf<SuccessState<MeasurementsModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.getMeasurements(any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getMeasurements(tToken);
          // assert
          verify(dataSource.getMeasurements(tToken));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.getMeasurements(any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getMeasurements(tToken);
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
        repository.getIngredients(tToken);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with IngredientsModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.getIngredients(any)).thenAnswer(
              (_) async => SuccessState<IngredientsModel>(tIngredientsModel));
          // act,
          final actual = await repository.getIngredients(tToken);
          // assert
          verify(dataSource.getIngredients(tToken));
          expect(actual, isInstanceOf<SuccessState<IngredientsModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.getIngredients(any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getIngredients(tToken);
          // assert
          verify(dataSource.getIngredients(tToken));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.getIngredients(any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getIngredients(tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('getUserRecipes', () {
    final tRecipes = getRecipesModel(1);
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getUserRecipes(tToken);
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return successState with RecipesModel when the call to remote data source is successful',
        () async {
          // arrange
          when(dataSource.getUserRecipes(any))
              .thenAnswer((_) async => SuccessState<RecipesModel>(tRecipes));
          // act,
          final actual = await repository.getUserRecipes(tToken);
          // assert
          verify(dataSource.getUserRecipes(tToken));
          expect(actual, isInstanceOf<SuccessState<RecipesModel>>());
        },
      );
      test(
        'should return errorState when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.getUserRecipes(any))
              .thenAnswer((_) async => ErrorState<String>('Error, Error'));
          // act
          final actual = await repository.getUserRecipes(tToken);
          // assert
          verify(dataSource.getUserRecipes(tToken));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.getUserRecipes(any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getUserRecipes(tToken);
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
}
