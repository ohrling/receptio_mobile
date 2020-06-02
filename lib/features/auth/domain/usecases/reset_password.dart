import 'package:injectable/injectable.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/usecase_authenticate.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';

@Named('ResetPassword')
@injectable
class ResetPassword extends NewPassword {
  final AuthRepository repository;

  ResetPassword(@Named('Auth0Repository') this.repository);

  @override
  Future<State> call(PassParam passParam) async {
    return await repository.resetPassword(passParam.username);
  }
}
