import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/usecases/usecase_get.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

@Named('GetIngredients')
@injectable
class GetIngredients extends GetData<NullParam> {
  final Repository repository;

  GetIngredients(@Named('Repository') this.repository);

  @override
  Future<State> call(param) async {
    return await repository.getIngredients();
  }
}
