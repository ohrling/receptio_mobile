import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/usecases/usecase_get.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

@Named('GetRecipeList')
@injectable
class GetRecipeList extends GetData<SearchParam> {
  final Repository repository;

  GetRecipeList(@Named('Repository') this.repository);

  @override
  Future<State> call(SearchParam param) async {
    return await repository.getRecipes(param.searchString);
  }
}
