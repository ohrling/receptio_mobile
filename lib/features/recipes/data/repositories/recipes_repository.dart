import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/features/recipes/data/datasources/recipe_datasource.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';

@Named('Repository')
@RegisterAs(Repository)
@injectable
class RecipesRepository implements Repository {
  final _errorString = 'Is the internet on this device turned ON?';
  final RecipeDataSource dataSource;
  final NetworkInfo networkInfo;

  RecipesRepository(@Named('RecipeDataSource') this.dataSource,
      @Named('NetworkInfo') this.networkInfo);

  @override
  Future<State> getRecipe(int id) async {
    if (await networkInfo.isConnected) {
      return await dataSource.fetchRecipe(id);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getRecipes(String searchString) async {
    if (await networkInfo.isConnected) {
      return await dataSource.fetchRecipes(searchString);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> postRecipe(Map parameters) async {
    if (await networkInfo.isConnected) {
      return await dataSource.sendRecipe(parameters);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getMeasurements() async {
    if (await networkInfo.isConnected) {
      return await dataSource.getMeasurements();
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getIngredients() async {
    if (await networkInfo.isConnected) {
      return await dataSource.getIngredients();
    }
    return State<String>.error(_errorString);
  }
}
