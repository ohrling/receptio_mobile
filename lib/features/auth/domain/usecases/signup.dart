import 'package:injectable/injectable.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/usecase_authenticate.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';

@Named('SignUp')
@injectable
class SignUp extends Authenticate<UserParam> {
  final AuthRepository repository;

  SignUp(@Named('Auth0Repository') this.repository);

  @override
  Future<State> call(UserParam userParam) async {
    return await repository.signUp(userParam.username, userParam.password);
  }
}
