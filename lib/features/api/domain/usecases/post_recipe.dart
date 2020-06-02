import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/usecases/usecase_send_object.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

@Named('PostRecipe')
@injectable
class PostRecipe extends SendObject<SendParam> {
  final ReceptioRepository repository;

  PostRecipe(@Named('ReceptioRepository') this.repository);

  @override
  Future<State> call(SendParam param) async {
    return await repository.postRecipe(param.parameters, param.accessToken);
  }
}
