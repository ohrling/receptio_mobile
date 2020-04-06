import 'package:dartz/dartz.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';
import 'package:receptio_mobile/features/getrecipes/domain/repositories/recipes_repository.dart';

class GetRecipes implements UseCaseGetRecipes<Recipes, Params> {
  final RecipesRepository repository;

  GetRecipes(this.repository);

  @override
  Future<Either<Failure, Recipes>> call(Params params) async {
    return await repository.getRecipes(params.searchValues);
  }
}
