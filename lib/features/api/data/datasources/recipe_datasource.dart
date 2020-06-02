import 'dart:convert';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/features/api/data/models/ingredients_model.dart';
import 'package:receptio/features/api/data/models/measurements_model.dart';
import 'package:receptio/features/api/data/models/recipe_model.dart';
import 'package:receptio/features/api/data/models/recipes_model.dart';
import 'package:receptio/features/api/domain/entities/ingredients.dart';
import 'package:receptio/features/api/domain/entities/measurements.dart';

abstract class RecipeDataSource {
  /// Calls the http://receptio.herokuapp.com/recipe?name endpoint for name-searching.
  Future<State> searchRecipesByName(String searchString, accessToken);

  /// Calls the http://http://receptio.herokuapp.com/recipe?ingredients endpoint for ingredients-searching
  Future<State> searchRecipesByIngredients(
      List<String> searchList, accessToken);

  /// Calls the http://receptio.herokuapp.com/recipe/{id} endpoint id search.
  Future<State> fetchRecipe(int id, accessToken);

  /// Posts a recipe-object to the http://receptio.herokuapp.com/recipe endpoint .
  Future<State> sendRecipe(Map recipeParameters, accessToken);

  /// Calls the http://receptio.herokuapp.com/measurement endpoint to get a list of valid measurements.
  Future<State> getMeasurements(accessToken);

  /// Calls the http://receptio.herokuapp.com/ingredient endpoint to get a list of ingredients.
  Future<State> getIngredients(accessToken);

  /// Calls the http://receptio.herokuapp.com/user/recipe endpoint to get a user specific list of recipes
  Future<State> getUserRecipes(accessToken);
}

const _baseUrl = 'https://receptio.herokuapp.com';

@Named('RecipeDataSource')
@Injectable(as: RecipeDataSource)
@injectable
class RemoteRecipeDataSource implements RecipeDataSource {
  final Client _client;
  var _bearerToken;
  final _recipeUrl = '$_baseUrl/recipe';
  final _measurementsUrl = '$_baseUrl/measurement';
  final _ingredientsUrl = '$_baseUrl/ingredient';
  final _userRecipeUrl = '$_baseUrl/user/recipe';
  final _serverException = 'Couldn\'t connect to server. Errorcode: ';

  RemoteRecipeDataSource(@Named('Client') this._client)
      : assert(_client != null);

  @override
  Future<State> searchRecipesByName(String searchString, accessToken) async {
    _bearerToken = accessToken;
    try {
      final response = await _client
          .get('$_recipeUrl?name=$searchString', headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return State<RecipesModel>.success(
            RecipesModel.fromJson(json.decode(response.body)));
      }
      return State<String>.error(
          _serverException + response.statusCode.toString());
    } catch (e) {
      return State<String>.error('Can\'t connect to server.');
    }
  }

  @override
  Future<State> searchRecipesByIngredients(
      List<String> searchList, accessToken) async {
    _bearerToken = accessToken;
    final searchValue = searchList
        .toString()
        .replaceAll(', ', ',')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '%2C')
        .trim();
    try {
      final response = await _client
          .get('$_recipeUrl?ingredients=$searchValue', headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return State<RecipesModel>.success(
            RecipesModel.fromJson(json.decode(response.body)));
      }
      return State<String>.error(
          _serverException + response.statusCode.toString());
    } catch (e) {
      return State<String>.error('Can\'t connect to server.');
    }
  }

  @override
  Future<State> fetchRecipe(int id, accessToken) async {
    _bearerToken = accessToken;
    try {
      final response = await _client
          .get('$_recipeUrl/$id', headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return State<RecipeModel>.success(
            RecipeModel.fromJson(json.decode(response.body)));
      }
      return State<String>.error(
          _serverException + response.statusCode.toString());
    } catch (e) {
      return State<String>.error('Can\'t connect to server.');
    }
  }

  @override
  Future<State> sendRecipe(Map parameters, accessToken) async {
    _bearerToken = accessToken;
    try {
      final response = await _client
          .post(_recipeUrl, body: json.encode(parameters), headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 201) {
        return State<String>.success('Recipe added');
      } else if (response.statusCode == 409) {
        return State<String>.error('Recipe already exists.');
      }
      return State<String>.error('Something went wrong. StatusCode: ' +
          response.statusCode.toString());
    } catch (e) {
      return State<String>.error('Can\'t connect to server.');
    }
  }

  @override
  Future<State> getMeasurements(accessToken) async {
    _bearerToken = accessToken;
    try {
      final response = await _client
          .get('$_measurementsUrl', headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return State<Measurements>.success(
            MeasurementsModel.fromJson(json.decode(response.body)));
      }
      return State<String>.error(
          '$_serverException ' + response.statusCode.toString());
    } catch (e) {
      return State<String>.error('Can\'t connect to server.');
    }
  }

  @override
  Future<State> getIngredients(accessToken) async {
    _bearerToken = accessToken;
    try {
      final response = await _client
          .get('$_ingredientsUrl', headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return State<Ingredients>.success(
            IngredientsModel.fromJson(json.decode(response.body)));
      }
      return State<String>.error(
          '$_serverException ' + response.statusCode.toString());
    } catch (e) {
      return State<String>.error('Can\'t connect to server.');
    }
  }

  @override
  Future<State> getUserRecipes(accessToken) async {
    _bearerToken = accessToken;
    try {
      final response = await _client
          .get('$_userRecipeUrl', headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return State<RecipesModel>.success(
            RecipesModel.fromJson(json.decode(response.body)));
      }
      return State<String>.error(
          '$_serverException' + response.statusCode.toString());
    } catch (e) {
      return State<String>.error('Can\'t connect to server.');
    }
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_bearerToken",
      };
}
