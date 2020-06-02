import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/usecases/usecase_authenticate.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';

@Named('SignIn')
@injectable
class SignIn extends Authenticate<UserParam> {
  final AuthRepository repository;

  SignIn(@Named('Auth0Repository') this.repository);

  @override
  Future<State> call(UserParam userParam) async {
    return await repository.logIn(userParam.username, userParam.password);
  }
}
