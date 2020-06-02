import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/usecases/usecase_get.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

@Named('GetUserRecipes')
@injectable
class GetUserRecipes extends GetData<TokenParam> {
  final ReceptioRepository repository;

  GetUserRecipes(@Named('ReceptioRepository') this.repository);

  @override
  Future<State> call(TokenParam param) async {
    return await repository.getUserRecipes(param.accessToken);
  }
}
