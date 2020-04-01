import 'dart:convert';

import 'package:better_uuid/uuid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixute_reader.dart';

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
    final tRecipeModel =
        RecipeModel.fromJson(json.decode(fixture('recipe.json')));
    test(
      'should return Recipe from shared preferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('recipe.json'));
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
    final tRecipeModel = RecipeModel(
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
