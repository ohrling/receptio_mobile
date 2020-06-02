import 'package:receptio/core/error/states.dart';

abstract class AuthRepository {
  Future<State> getAuthToken(username, password);
  Future<State> logIn(username, password);
  Future<State> resetPassword(username);
  Future<State> signUp(username, password);
}
