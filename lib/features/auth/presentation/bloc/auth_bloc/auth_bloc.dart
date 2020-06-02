import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/auth/data/models/UserModel.dart';
import 'package:receptio/features/auth/domain/entities/user.dart';
import 'package:receptio/features/auth/domain/usecases/get_authentication_token.dart';
import 'package:receptio/features/auth/domain/usecases/reset_password.dart';
import 'package:receptio/features/auth/domain/usecases/signin.dart';
import 'package:receptio/features/auth/domain/usecases/signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Named('AuthBloc')
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthenticationToken _getAuthenticationToken;
  final SignIn _signIn;
  final SignUp _signUp;
  final ResetPassword _resetPassword;
  User _user = null;
  String _accessToken;

  dynamic get accessToken => _accessToken;

  User get user => _user;

  AuthBloc(
    @Named('GetAuthenticationToken') this._getAuthenticationToken,
    @Named('SignIn') this._signIn,
    @Named('SignUp') this._signUp,
    @Named('ResetPassword') this._resetPassword,
  );
  @override
  AuthState get initialState => Welcome();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is DisplayLoginEvent) {
      yield DisplayLogin();
    } else if (event is LoginEvent) {
      yield AuthLoading();
      final state = await _getAuthenticationToken
          .call(UserParam(username: event.username, password: event.password));
      if (state is SuccessState) {
        _accessToken = state.value;
        final userState = await _signIn.call(
            UserParam(username: event.username, password: event.password));
        if (userState is SuccessState) {
          _user = UserModel.fromJson(parseJwt(userState.value));
          yield LoggedIn();
        } else if (userState is ErrorState) {
          yield AuthError(userState.msg);
        }
      } else if (state is ErrorState) {
        yield AuthError(state.msg);
      }
    } else if (event is SignUpEvent) {
      final state = await _signUp
          .call(UserParam(username: event.username, password: event.password));
      if (state is SuccessState) {
        yield SignedUp(state.value);
      } else if (state is ErrorState) {
        yield AuthError(state.msg);
      }
    } else if (event is ResetPasswordEvent) {
      final state =
          await _resetPassword.call(PassParam(username: event.username));
      if (state is SuccessState) {
        yield PasswordResetted(state.value);
      } else if (state is ErrorState) {
        yield AuthError(state.msg);
      }
    }
  }

  Map<String, dynamic> parseJwt(String accessToken) {
    final parts = accessToken.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
