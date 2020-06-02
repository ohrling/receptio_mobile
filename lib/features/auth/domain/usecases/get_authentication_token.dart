import 'package:injectable/injectable.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/usecase_authenticate.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';

@Named('GetAuthenticationToken')
@injectable
class GetAuthenticationToken extends Authenticate<UserParam> {
  final AuthRepository repository;

  GetAuthenticationToken(@Named('Auth0Repository') this.repository);

  @override
  Future<State> call(UserParam authParam) {
    return repository.getAuthToken(authParam.username, authParam.password);
  }
}
