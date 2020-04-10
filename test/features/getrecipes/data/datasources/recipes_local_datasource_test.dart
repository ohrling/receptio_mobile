import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipes/data/datasources/recipes_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipes/data/models/recipes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  RecipesLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        RecipesLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastRecipe', () {
    String _jsonRecipes = jsonRecipes();

    final tRecipesModel = RecipesModel.fromJson(json.decode(_jsonRecipes));

    test(
        'should return Recipes from shared preferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(_jsonRecipes);
      // act
      final result = await dataSource.getLastRecipes();
      // assert
      verify(mockSharedPreferences.getString(CACHED_RECIPES));
      expect(result, equals(tRecipesModel));
    });

    test('should throw CacheException when there is no cached values',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastRecipes;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });
  group('cacheRecipes', () {
    final tRecipesModel = getRecipesModel(2);

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheRecipes(tRecipesModel);
      // assert
      final expectedJsonString = json.encode(tRecipesModel.toJson());
      verify(
          mockSharedPreferences.setString(CACHED_RECIPES, expectedJsonString));
    });
  });
}
