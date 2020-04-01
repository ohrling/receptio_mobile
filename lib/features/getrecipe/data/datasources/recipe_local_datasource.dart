import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RecipeLocalDataSource {
  /// Gets cached [RecipeModel] which was used last time
  /// the user had the app open.
  ///
  /// Throws [CacheException] if no chached data is present.
  Future<Recipe> getLastRecipe();

  Future<void> cacheRecipe(RecipeModel recipeToCache);
}

const CACHED_RECIPE = 'CACHED_RECIPE';

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final SharedPreferences sharedPreferences;

  RecipeLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheRecipe(RecipeModel recipeToCache) {
    return sharedPreferences.setString(
        CACHED_RECIPE, json.encode(recipeToCache.toJson()));
  }

  @override
  Future<Recipe> getLastRecipe() {
    final jsonString = sharedPreferences.getString(CACHED_RECIPE);
    if (jsonString != null) {
      return Future.value(RecipeModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException('Cached recipe is missing.');
    }
  }
}
