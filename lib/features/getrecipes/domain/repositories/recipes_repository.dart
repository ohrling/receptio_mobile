import 'package:dartz/dartz.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';

abstract class RecipesRepository {
  Future<Either<Failure, Recipes>> getRecipes(List<String> searchValues);
}
