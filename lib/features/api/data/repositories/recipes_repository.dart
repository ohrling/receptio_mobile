import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/network/network_info.dart';
import 'package:receptio/features/api/data/datasources/recipe_datasource.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

@Named('ReceptioRepository')
@Injectable(as: ReceptioRepository)
@injectable
class RecipesRepository implements ReceptioRepository {
  final _errorString = 'Is the internet on this device turned ON?';
  final RecipeDataSource dataSource;
  final NetworkInfo networkInfo;

  RecipesRepository(@Named('RecipeDataSource') this.dataSource,
      @Named('NetworkInfo') this.networkInfo);

  @override
  Future<State> getRecipe(int id, String accessToken) async {
    if (await networkInfo.isConnected) {
      return await dataSource.fetchRecipe(id, accessToken);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getRecipesFromName(
      String searchString, String accessToken) async {
    if (await networkInfo.isConnected) {
      return await dataSource.searchRecipesByName(searchString, accessToken);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getRecipesFromIngredients(
      List<String> searchList, String accessToken) async {
    if (await networkInfo.isConnected) {
      return await dataSource.searchRecipesByIngredients(
          searchList, accessToken);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> postRecipe(Map parameters, String accessToken) async {
    if (await networkInfo.isConnected) {
      return await dataSource.sendRecipe(parameters, accessToken);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getMeasurements(String accessToken) async {
    if (await networkInfo.isConnected) {
      return await dataSource.getMeasurements(accessToken);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getIngredients(String accessToken) async {
    if (await networkInfo.isConnected) {
      return await dataSource.getIngredients(accessToken);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> getUserRecipes(String accessToken) async {
    if (await networkInfo.isConnected) {
      return dataSource.getUserRecipes(accessToken);
    }
    return State<String>.error(_errorString);
  }
}
