import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

abstract class RecipeRemoteDataSource {
  /// Calls the http://receptio.herokuapp.com/recipe/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<Recipe> getRecipe(int id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({@required this.client});
  @override
  Future<Recipe> getRecipe(int id) async {
    final response = await client
        .get('http://receptio.herokuapp.com/recipe/' + id.toString());
    if (response.statusCode == 200) {
      return RecipeModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Couldn\'t get the recipe.');
    }
  }
}
