import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/usecases/usecase_get.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

@Named('GetIngredientSearchRecipeList')
@injectable
class GetIngredientSearchRecipeList extends GetData<SearchParam> {
  final ReceptioRepository repository;

  GetIngredientSearchRecipeList(@Named('ReceptioRepository') this.repository);

  @override
  Future<State> call(SearchParam param) async {
    return await repository.getRecipesFromIngredients(
        param.searchValue, param.accessToken);
  }
}
