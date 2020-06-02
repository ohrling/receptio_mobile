import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import 'package:receptio/core/error/states.dart';

abstract class AuthDataSource {
  /// Calls  the Auth0 to authenticate the user
  Future<State> getAuthenticationToken(username, password);
  Future<State> getUserInfo(username, password);
  Future<State> signUp(username, password);
  Future<State> resetPassword(username);
}

@named
@Injectable(as: AuthDataSource)
@injectable
class Auth0DataSource extends AuthDataSource {
  final Auth0Auth _auth;

  Auth0DataSource(@Named('Auth') this._auth);

  @override
  Future<State> getAuthenticationToken(username, password) async {
    var response;
    try {
      response = await _auth.passwordRealm({
        'username': username,
        'password': password,
        'audience': 'https://receptio.herokuapp.com/',
        'realm': 'Username-Password-Authentication'
      });
    } catch (e) {
      return State<String>.error('$e');
    }
    return State<String>.success(response['access_token']);
  }

  @override
  Future<State> getUserInfo(username, password) async {
    try {
      var response = await _auth.passwordRealm({
        'username': username,
        'password': password,
        'realm': 'Username-Password-Authentication'
      });
      return State<String>.success(response['id_token']);
    } on ClientException {
      return State<String>.error('Bug from auth0_flutter');
    } catch (e) {
      return State<String>.error('$e');
    }
  }

  @override
  Future<State> signUp(username, password) async {
    try {
      var response = await _auth.createUser({
        'email': username,
        'password': password,
        'connection': 'Username-Password-Authentication'
      });
      return SuccessState<String>('${response['email']} added.');
    } catch (e) {
      return State<String>.error('$e');
    }
  }

  @override
  Future<State> resetPassword(username) async {
    try {
      await _auth.resetPassword({
        'email': username,
        'connection': 'Username-Password-Authentication'
      });
      return State<String>.success('Password restarted, check your inbox!');
    } catch (e) {
      return State<String>.error('$e');
    }
  }
}
