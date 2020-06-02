import 'package:receptio/core/error/states.dart';

abstract class ReceptioRepository {
  Future<State> getRecipe(int id, String accessToken);
  Future<State> getRecipesFromName(String searchString, String accessToken);
  Future<State> getRecipesFromIngredients(
      List<String> searchList, String accessToken);
  Future<State> postRecipe(Map recipeParameters, String accessToken);
  Future<State> getMeasurements(String accessToken);
  Future<State> getIngredients(String accessToken);
  Future<State> getUserRecipes(String accessToken);
}
