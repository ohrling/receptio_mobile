import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'env.dart';

@module
abstract class RegisterModule {
  final _clientId = environment['clientId'];
  final _url = environment['authUrl'];

  @Named('Client')
  Client get client => Client();
  DataConnectionChecker get connectionChecker => DataConnectionChecker();
  @Named('Auth')
  Auth0Auth auth(
          @Named('clientId') String clientId, @Named('url') String url) =>
      Auth0Auth(clientId, url);
  @Named('clientId')
  String get clientId => _clientId;
  @Named('url')
  String get url => _url;
}
