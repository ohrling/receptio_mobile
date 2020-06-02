import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio/features/auth/data/models/UserModel.dart';
import 'package:receptio/features/auth/domain/entities/user.dart';

void main() {
  final tUserModel = UserModel.fromJson(json.decode('''{
    "nickname": "username",
    "name": "username@gmail.com",
    "picture": "https://s.gravatar.com/avatar/a36c07d601ffebcb4dd37f7292e13a98?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fvi.png",
    "updated_at": "2020-05-15T13:36:52.578Z",
    "email": "username@gmail.com",
    "email_verified": true,
    "iss": "https://falling-surf-5891.eu.auth0.com/",
    "sub": "auth0|5eb544ee3b10d60c016068e0",
    "aud": "acQHr1oBQDjL1a3xz2kPvGbO3OaTmPPk",
    "iat": 1589549812,
    "exp": 1589585812
  }'''));

  test(
    'should be a subclass of User entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    String tJsonUser = '''{
      "nickname": "username",
      "name": "username@gmail.com",
      "picture": "https://s.gravatar.com/avatar/a36c07d601ffebcb4dd37f7292e13a98?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fvi.png",
      "updated_at": "2020-05-15T13:36:52.578Z",
      "email": "username@gmail.com",
      "email_verified": true,
      "iss": "https://falling-surf-5891.eu.auth0.com/",
      "sub": "auth0|5eb544ee3b10d60c016068e0",
      "aud": "acQHr1oBQDjL1a3xz2kPvGbO3OaTmPPk",
      "iat": 1589549812,
      "exp": 1589585812
    }''';
    test(
      'should return a valid usermodel',
      () async {
        // arrange
        final jsonMap = json.decode(tJsonUser);
        // act
        final result = UserModel.fromJson(jsonMap);
        // assert
        expect(result, isA<UserModel>());
        expect(result.nickname, 'username');
      },
    );
  });
}
