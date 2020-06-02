import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/usecases/usecase_get.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

@Named('GetMeasurements')
@injectable
class GetMeasurements extends GetData<TokenParam> {
  final ReceptioRepository repository;

  GetMeasurements(@Named('ReceptioRepository') this.repository);

  @override
  Future<State> call(param) async {
    return await repository.getMeasurements(param.accessToken);
  }
}
