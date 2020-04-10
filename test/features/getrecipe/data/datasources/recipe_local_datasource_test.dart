import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  RecipeLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        RecipeLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastRecipe', () {
    String _jsonRecipe = jsonRecipe();

    final tRecipeModel = RecipeModel.fromJson(json.decode(_jsonRecipe));

    test(
      'should return Recipe from shared preferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(_jsonRecipe);
        // act
        final result = await dataSource.getLastRecipe();
        // assert
        verify(mockSharedPreferences.getString(CACHED_RECIPE));
        expect(result, equals(tRecipeModel));
      },
    );
    test(
      'should throw CacheException when there is no cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastRecipe;
        // assert
        expect(() => call(), throwsA(isInstanceOf<CacheException>()));
      },
    );
  });
  group('cacheRecipe', () {
    final tRecipeModel = getRecipeModel(1);

    test('should call SharedPreferenced to cache the data', () async {
      // act
      dataSource.cacheRecipe(tRecipeModel);
      // assert
      final expectedJsonString = json.encode(tRecipeModel.toJson());
      verify(
          mockSharedPreferences.setString(CACHED_RECIPE, expectedJsonString));
    });
  });
}
