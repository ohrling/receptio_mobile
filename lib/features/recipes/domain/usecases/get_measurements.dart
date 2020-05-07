import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/usecases/usecase_get.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

@Named('GetMeasurements')
@injectable
class GetMeasurements extends GetData<NullParam> {
  final Repository repository;

  GetMeasurements(@Named('Repository') this.repository);

  @override
  Future<State> call(param) async {
    return await repository.getMeasurements();
  }
}
