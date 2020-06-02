part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class WelcomeEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final username;
  final password;

  LoginEvent({@required this.username, @required this.password});

  @override
  List get props => [username, password];
}

class DisplayLoginEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final username;
  final password;

  SignUpEvent({@required this.username, @required this.password});

  @override
  List get props => [username, password];
}

class ResetPasswordEvent extends AuthEvent {
  final username;

  ResetPasswordEvent({@required this.username});

  @override
  List get props => [username];
}
