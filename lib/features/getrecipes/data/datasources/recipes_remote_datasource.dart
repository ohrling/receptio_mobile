import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipes/data/models/recipes_model.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';

abstract class RecipesRemoteDataSource {
  /// Calls the http://receptio.herokuapp.com/recipe/searchString endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Recipes> getRecipes(String searchString);
}

class RecipesRemoteDataSourceImpl implements RecipesRemoteDataSource {
  final http.Client client;

  RecipesRemoteDataSourceImpl({@required this.client});

  @override
  Future<Recipes> getRecipes(String searchString) async {
    final _url =
        'http://receptio.herokuapp.com/recipe?searchString=' + searchString;
    final response = await client.get(_url);
    if (response.statusCode == 200) {
      return RecipesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Couldn\'t get the recipe.');
    }
  }
}
