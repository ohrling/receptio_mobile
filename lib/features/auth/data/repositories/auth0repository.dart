import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/network/network_info.dart';
import 'package:receptio/features/auth/data/datasources/auth_datasource.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';

@Named('Auth0Repository')
@Injectable(as: AuthRepository)
@injectable
class Auth0Repository extends AuthRepository {
  final _errorString = 'Is the internet on this device turnes ON?';
  final NetworkInfo networkInfo;
  final AuthDataSource dataSource;

  Auth0Repository(@Named.from(Auth0DataSource) this.dataSource,
      @Named('NetworkInfo') this.networkInfo);

  @override
  Future<State> getAuthToken(username, password) async {
    if (await networkInfo.isConnected) {
      return await dataSource.getAuthenticationToken(username, password);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> logIn(username, password) async {
    if (await networkInfo.isConnected) {
      return await dataSource.getUserInfo(username, password);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> resetPassword(username) async {
    if (await networkInfo.isConnected) {
      return await dataSource.resetPassword(username);
    }
    return State<String>.error(_errorString);
  }

  @override
  Future<State> signUp(username, password) async {
    if (await networkInfo.isConnected) {
      return await dataSource.signUp(username, password);
    }
    return State<String>.error(_errorString);
  }
}
