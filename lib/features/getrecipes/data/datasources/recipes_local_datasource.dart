import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipes/data/models/recipes_model.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RecipesLocalDataSource {
  /// Gets cached [RecipesModel] which was used last time
  /// the user had the app open.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<Recipes> getLastRecipes();
  Future<void> cacheRecipes(RecipesModel recipesToCache);
}

const CACHED_RECIPES = 'CACHED_RECIPES';

class RecipesLocalDataSourceImpl implements RecipesLocalDataSource {
  SharedPreferences sharedPreferences;

  RecipesLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheRecipes(RecipesModel recipesToCache) {
    return sharedPreferences.setString(
        CACHED_RECIPES, json.encode(recipesToCache.toJson()));
  }

  @override
  Future<Recipes> getLastRecipes() {
    final jsonString = sharedPreferences.getString(CACHED_RECIPES);
    if (jsonString != null) {
      return Future.value(RecipesModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException('There isn\'t any recipes in the cache.');
    }
  }
}
