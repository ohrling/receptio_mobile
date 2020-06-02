part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class Welcome extends AuthState {
  @override
  List<Object> get props => [];
}

class DisplayLogin extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedUp extends AuthState {
  final String message;

  SignedUp(this.message) : super([message]);
}

class PasswordResetted extends AuthState {
  final String message;

  PasswordResetted(this.message) : super([message]);
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage) : super([errorMessage]);
}
