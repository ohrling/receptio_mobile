import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/auth/data/models/UserModel.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';
import 'package:receptio/features/auth/domain/usecases/signin.dart';

import '../../../../fixtures/mocks.dart';

void main() {
  SignIn usecase;
  AuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignIn(mockAuthRepository);
  });

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

  group('LogIn', () {
    test(
      'should get a succestate with authmodel in it from the repository',
      () async {
        // arrange
        when(mockAuthRepository.logIn(any, any))
            .thenAnswer((_) async => SuccessState(tUserModel));
        // act
        final actual = await usecase
            .call(UserParam(username: 'username', password: 'password'));
        // assert
        expect(actual, isInstanceOf<SuccessState>());
        verify(mockAuthRepository.logIn('username', 'password'));
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
    test(
      'should get errorstate from the repository',
      () async {
        // arrange
        when(mockAuthRepository.logIn(any, any))
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final actual = await usecase
            .call(UserParam(username: 'username', password: 'password'));
        // assert
        expect(actual, isInstanceOf<ErrorState>());
        verify(mockAuthRepository.logIn('username', 'password'));
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}
