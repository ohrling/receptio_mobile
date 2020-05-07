import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/network/recipe_client.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/measurements_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipes_model.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredients.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/measurements.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:receptio_mobile/injection.dart';

const _baseUrl = 'http://receptio.herokuapp.com';

abstract class RecipeDataSource {
  /// Calls the http://receptio.herokuapp.com/recipe?name endpoint for name-searching.
  Future<State> fetchRecipes(String searchString);

  /// Calls the http://receptio.herokuapp.com/recipe/{id} endpoint id search.
  Future<State> fetchRecipe(int id);

  /// Posts a recipe-object to the http://receptio.herokuapp.com/recipe endpoint .
  Future<State> sendRecipe(Map parameters);

  /// Calls the http://receptio.herokuapp.com/measurement endpoint to get a list of valid measurements.
  Future<State> getMeasurements();

  /// Calls the http://receptio.herokuapp.com/ingredient endpoint to get a list of ingredients.
  Future<State> getIngredients();
}

@Named('MockDataSource')
@RegisterAs(RecipeDataSource, env: Env.test)
@injectable
class MockDataSource extends Mock implements RecipeDataSource {}

@Named('RecipeDataSource')
@RegisterAs(RecipeDataSource, env: Env.prod)
@injectable
class RemoteRecipeDataSource implements RecipeDataSource {
  final RecipeClient _clientGenerator;
  // TODO: Remove the bearerToken when user is integrated
  final _bearerToken =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZ6NzFBQlZIdFpVa19CMF9BSTItUCJ9.eyJpc3MiOiJodHRwczovL2ZhbGxpbmctc3VyZi01ODkxLmV1LmF1dGgwLmNvbS8iLCJzdWIiOiI4QjB4R0huSHJINlJRQUlCSG9NZk02ZXQ2UUVvV1diQkBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9yZWNlcHRpby5oZXJva3VhcHAuY29tLyIsImlhdCI6MTU4ODc2OTA3NiwiZXhwIjoxNTg4ODU1NDc2LCJhenAiOiI4QjB4R0huSHJINlJRQUlCSG9NZk02ZXQ2UUVvV1diQiIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.ai7UkZl5E5xK7iNoqVs0ApBAwi8fqygsMeeMEON5XrOjsz5TQwQ3f9pJTsCe7LsX-dtVOIb5N4tMtHeP2xH4Gs_vC29r0opUS7HlSVwztjkVvxn6j8II9dcIUf8UzRD4JZSu9hJMFkcTqKtfjjj0hFHAH6rf79s3zgECkvjdBer6euAmuQWUc0qhatvfFQLAhVzaEDKbvNJaNksvg1s-13D9CMpGtMWvEdQBTW2mBy5c_rN6Maj57pwEX_vMAixMorGKXZccCcLgh9I7x_fIjr9DME5cgDUeNPobV0IgaZtpBywBe4sA8vl2NSs7xY5Hg2Kbn9OrPBcSVEEPbxf7Og';
  final _recipeUrl = '$_baseUrl/recipe';
  final _measurementsUrl = '$_baseUrl/measurement';
  final _ingredientsUrl = '$_baseUrl/ingredient';
  final _serverException = 'Couldn\'t connect to server. Errorcode: ';

  RemoteRecipeDataSource(@Named('Client') this._clientGenerator)
      : assert(_clientGenerator != null);

  @override
  Future<State> fetchRecipes(String searchString) async {
    final response = await _clientGenerator
        .getClient()
        .get('$_recipeUrl?name=$searchString');
    if (response.statusCode == 200) {
      return State<RecipesModel>.success(
          RecipesModel.fromJson(json.decode(response.body)));
    }
    print(response.body);
    return State<String>.error(
        _serverException + response.statusCode.toString());
  }

  @override
  Future<State> fetchRecipe(int id) async {
    final response = await _clientGenerator.getClient().get('$_recipeUrl/$id');
    if (response.statusCode == 200) {
      print('Response ' + response.body);
      return State<RecipeModel>.success(
          RecipeModel.fromJson(json.decode(response.body)));
    }
    return State<String>.error(
        _serverException + response.statusCode.toString());
  }

  @override
  Future<State> sendRecipe(Map parameters) async {
    print(parameters);
    final response = await _clientGenerator
        .getClient()
        .post(_recipeUrl, body: json.encode(parameters), headers: headers);
    if (response.statusCode == 201) {
      return State<Recipe>.success(
          RecipeModel.fromJson(json.decode(response.body)));
    } else if (response.statusCode == 400) {
      return State<String>.error('Recipe invalid.');
    } else if (response.statusCode == 409) {
      return State<String>.error('Recipe already exists.');
    }
    return State<String>.error(
        'Something went wrong. StatusCode: ' + response.statusCode.toString());
  }

  @override
  Future<State> getMeasurements() async {
    final response = await _clientGenerator
        .getClient()
        .get('$_measurementsUrl', headers: headers);
    if (response.statusCode == 200) {
      return State<Measurements>.success(
          MeasurementsModel.fromJson(json.decode(response.body)));
    }
    return State<String>.error(
        '$_serverException ' + response.statusCode.toString());
  }

  @override
  Future<State> getIngredients() async {
    final response = await _clientGenerator
        .getClient()
        .get('$_ingredientsUrl', headers: headers);
    if (response.statusCode == 200) {
      return State<Ingredients>.success(
          IngredientsModel.fromJson(json.decode(response.body)));
    }
    return State<String>.error(
        '$_serverException ' + response.statusCode.toString());
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_bearerToken",
      };
}
