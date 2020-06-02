import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/usecases/usecase_get.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

@Named('GetIngredients')
@injectable
class GetIngredients extends GetData<TokenParam> {
  final ReceptioRepository repository;

  GetIngredients(@Named('ReceptioRepository') this.repository);

  @override
  Future<State> call(param) async {
    return await repository.getIngredients(param.accessToken);
  }
}
