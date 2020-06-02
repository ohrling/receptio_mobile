import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/features/auth/data/datasources/auth_datasource.dart';

import '../../../../fixtures/mocks.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  AuthDataSource authDataSource;
  Auth0Auth auth0;

  setUp(() {
    auth0 = MockAuth0Auth();
    authDataSource = Auth0DataSource(auth0);
  });

  final Map<dynamic, dynamic> tResponse = {};
  tResponse['access_token'] = '8bsAZTAcXbpeLMzyzYPKiegLgTaD5-sh';
  tResponse['id_token'] =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZ6NzFBQlZIdFpVa19CMF9BSTItUCJ9.eyJuaWNrbmFtZSI6InZpdHRsZWpvbiIsIm5hbWUiOiJ2aXR0bGVqb25AZ21haWwuY29tIiwicGljdHVyZSI6Imh0dHBzOi8vcy5ncmF2YXRhci5jb20vYXZhdGFyL2EzNmMwN2Q2MDFmZmViY2I0ZGQzN2Y3MjkyZTEzYTk4P3M9NDgwJnI9cGcmZD1odHRwcyUzQSUyRiUyRmNkbi5hdXRoMC5jb20lMkZhdmF0YXJzJTJGdmkucG5nIiwidXBkYXRlZF9hdCI6IjIwMjAtMDUtMjBUMTY6NTc6NTIuMDU5WiIsImVtYWlsIjoidml0dGxlam9uQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJpc3MiOiJodHRwczovL2ZhbGxpbmctc3VyZi01ODkxLmV1LmF1dGgwLmNvbS8iLCJzdWIiOiJhdXRoMHw1ZWI1NDRlZTNiMTBkNjBjMDE2MDY4ZjAiLCJhdWQiOiJhY1FIcjFvQlFEakwxYTN4ejJrUHZHYk8zT2FUbVBQayIsImlhdCI6MTU4OTk5Mzg3MiwiZXhwIjoxNTkwMDI5ODcyfQ.I6usaE5F2dKJ88MqLltBxvfmRlSyRUJx1kMoKdUEzuk_hZpbSOhty57xwm4mWF6kxeO7B5chctlK_fO5rl9liSyW23_hXc-NYuNTCt3Xe3gCrLiXPoH7Z8CKGkemCUE9jbNNAy5JeK8IvatMG1xvNCIdQPqgWR5iFFZ43BAB4UK_E3VpQ5Bu-BvY_hDbNrD_0h2TSH3uVH66VdfmQtHkkMrtiQFeU7zRJCXwHRF5j8kJFpcE4ISlk9OqoMuPNOgL944yfruFC8Fbucd_QDLW0oIF1RuuKYV4vNrTHh_cBdl9v9rW5wVWcA15FHUN8IR-CFax_nWfKQTeLzrqdYJTAQ';

  group('getAuthenticationToken tests', () {
    final tAuthToken = {};
    tAuthToken['access_token'] = 'etst';
    tAuthToken['id_token'] =
        'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZ6NzFBQlZIdFpVa19CMF9BSTItUCJ9.eyJpc3MiOiJodHRwczovL2ZhbGxpbmctc3VyZi01ODkxLmV1LmF1dGgwLmNvbS8iLCJzdWIiOiJNa2s2SHpRNU1CU01qWDJ5YXNlSndlMkFpZHVGUDNRMEBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9yZWNlcHRpby5oZXJva3VhcHAuY29tLyIsImlhdCI6MTU5MDA0NzIxNCwiZXhwIjoxNTkwMTMzNjE0LCJhenAiOiJNa2s2SHpRNU1CU01qWDJ5YXNlSndlMkFpZHVGUDNRMCIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.wEDhOwChV22YAyyTJXcOeg47AlXz_KNmbuBGCFLLglCgwggjPd63Vy0qoZdoxtXxfix6EilDP2ZrVW06vyEedYIqjL7XzfX75mVm-xtAK9XV_oORkNamhgmkLtfrh8V77qPwg9mJkAvgurSIpLLtx4q9tL8kq2v-DRuutO8ecjMG-mX1p5L42KrJGFyz4BiJwiwdP9Je2HeAUOkzwi0SUh7UeQ5604qr9qwJpZk33N0qXb9Dv_Wda1wXNs0BQXD3n-29mRqQ4VmZ6l2aYWdLlM16bUBbJR6rCqM3zZE6ACmP-DDNCHshXvgzcASq4oVwgG4IBdgkIw0YAWZWEa7k0Q';
    test(
      'should get a success when trying to fetch the authtoken',
      () async {
        // arrange
        when(auth0.passwordRealm(any)).thenAnswer(
          (_) async => Future.value(tAuthToken),
        );
        // act
        final actual =
            await authDataSource.getAuthenticationToken('username', 'password');
        // assert
        expect(actual, isInstanceOf<SuccessState>());
      },
    );
    test(
      'should get a error when trying to log in without success',
      () async {
        // arrange
        when(auth0.passwordRealm(any))
            .thenAnswer((_) async => Future.value(throw Auth0Exeption));
        // act
        final actual =
            await authDataSource.getAuthenticationToken('username', 'password');
        // assert
        expect(actual, isInstanceOf<ErrorState>());
      },
    );
  });

  group('signIn tests', () {
    test(
      'should get a success when trying to log in',
      () async {
        // arrange
        when(auth0.passwordRealm(any)).thenAnswer(
          (_) async => Future.value(tResponse),
        );
        // act
        final actual = await authDataSource.getUserInfo('username', 'password');
        // assert
        expect(actual, isInstanceOf<SuccessState>());
      },
    );
    test(
      'should get a error when trying to log in without success',
      () async {
        // arrange
        when(auth0.passwordRealm(any))
            .thenAnswer((_) async => Future.value(throw Auth0Exeption));
        // act
        final actual = await authDataSource.getUserInfo('username', 'password');
        // assert
        expect(actual, isInstanceOf<ErrorState>());
      },
    );
  });
  group('resetPassword tests', () {
    test(
      'should get a successState when the request is successful',
      () async {
        // arrange
        when(auth0.resetPassword(any))
            .thenAnswer((_) async => Future.value('success'));
        // act
        final actual = await authDataSource.resetPassword('username');
        // assert
        expect(actual, isInstanceOf<SuccessState<String>>());
      },
    );
    test(
      'should get a errorstate when password couldn\'t reset',
      () async {
        // arrange
        when(auth0.resetPassword(any))
            .thenAnswer((_) async => Future.value(throw Auth0Exeption));
        // act
        final actual = await authDataSource.resetPassword('username');
        // assert
        expect(actual, isInstanceOf<ErrorState<String>>());
      },
    );
  });
  group('signUp tests', () {
    final tSignUpResponse = {'email': 'email@gmail.com'};
    test(
      'should get a successState when sign up is successful',
      () async {
        // arrange
        when(auth0.createUser(any))
            .thenAnswer((_) async => Future.value(tSignUpResponse));
        // act
        final actual = await authDataSource.signUp('username', 'password');
        // assert
        expect(actual, isInstanceOf<SuccessState<String>>());
      },
    );
    test(
      'should get a errorstate when the sign up is unsuccessful',
      () async {
        // arrange
        when(auth0.createUser(any))
            .thenAnswer((_) async => ErrorState<String>('Error, error'));
        // act
        final actual = await authDataSource.signUp('username', 'password');
        // assert
        expect(actual, isInstanceOf<ErrorState>());
      },
    );
  });
}
