import 'package:dartz/dartz.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, Recipe>> getRecipe(int id);
}
