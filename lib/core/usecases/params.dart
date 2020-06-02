import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Param extends Equatable {}

class TokenParam extends Param {
  final accessToken;

  TokenParam({@required this.accessToken});
}

class IdParam extends Param {
  final int id;
  final accessToken;

  IdParam({@required this.id, @required this.accessToken});
}

class SearchParam extends Param {
  final searchValue;
  final accessToken;

  SearchParam({@required this.searchValue, @required this.accessToken});
}

class SendParam extends Param {
  final Map parameters;
  final accessToken;

  SendParam({@required this.parameters, @required this.accessToken});
}

class UserParam extends Param {
  final username;
  final password;

  UserParam({@required this.username, @required this.password});
}

class PassParam extends Param {
  final username;

  PassParam({@required this.username});
}
