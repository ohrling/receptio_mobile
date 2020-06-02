import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/usecases/usecase_get.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

@Named('GetNameSearchRecipeList')
@injectable
class GetNameSearchRecipeList extends GetData<SearchParam> {
  final ReceptioRepository repository;

  GetNameSearchRecipeList(@Named('ReceptioRepository') this.repository);

  @override
  Future<State> call(SearchParam param) async {
    return await repository.getRecipesFromName(
        param.searchValue, param.accessToken);
  }
}
