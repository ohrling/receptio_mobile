import 'package:dartz/dartz.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipe/domain/repositories/recipe_repository.dart';

class GetRecipe implements UseCase<Recipe, Params> {
  final RecipeRepository repository;

  GetRecipe(this.repository);

  @override
  Future<Either<Failure, Recipe>> call(Params params) async {
    return await repository.getRecipe(params.id);
  }
}
