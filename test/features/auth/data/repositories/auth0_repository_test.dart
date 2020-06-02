import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/network/network_info.dart';
import 'package:receptio/features/auth/data/datasources/auth_datasource.dart';
import 'package:receptio/features/auth/data/models/UserModel.dart';
import 'package:receptio/features/auth/data/repositories/auth0repository.dart';

import '../../../../fixtures/mocks.dart';
import '../datasources/auth_datasource_test.dart';

void main() {
  Auth0Repository repository;
  AuthDataSource dataSource;
  NetworkInfo networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockAuthDataSource();
    repository = Auth0Repository(dataSource, networkInfo);
  });

  final tUser = UserModel.fromJson(json.decode('''{
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

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAuthToken', () {
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.getAuthToken('username', 'password');
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return a successState with a UserModel when the call to auth data source is successful',
        () async {
          // arrange
          when(dataSource.getAuthenticationToken(any, any))
              .thenAnswer((_) async => SuccessState<UserModel>(tUser));
          // act
          final actual = await repository.getAuthToken('username', 'password');
          // assert
          verify(dataSource.getAuthenticationToken('username', 'password'));
          expect(actual, isInstanceOf<SuccessState<UserModel>>());
        },
      );
      test(
        'should return errorState when the call to auth data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.getAuthenticationToken(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getAuthToken('username', 'password');
          // assert
          verify(dataSource.getAuthenticationToken('username', 'password'));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.getAuthenticationToken(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.getAuthToken('username', 'password');
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('signIn', () {
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.logIn('username', 'password');
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return a successState with a UserModel when the call to auth data source is successful',
        () async {
          // arrange
          when(dataSource.getUserInfo(any, any))
              .thenAnswer((_) async => SuccessState<UserModel>(tUser));
          // act
          final actual = await repository.logIn('username', 'password');
          // assert
          verify(dataSource.getUserInfo('username', 'password'));
          expect(actual, isInstanceOf<SuccessState<UserModel>>());
        },
      );
      test(
        'should return errorState when the call to auth data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.getUserInfo(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.logIn('username', 'password');
          // assert
          verify(dataSource.getUserInfo('username', 'password'));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.getUserInfo(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.logIn('username', 'password');
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('ResetPassword', () {
    test(
      'should control that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.resetPassword('username');
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return a successState when the password reset is successful',
        () async {
          // arrange
          when(dataSource.resetPassword(any))
              .thenAnswer((_) async => SuccessState<String>(''));
          // act
          final actual = await repository.resetPassword('username');
          // assert
          verify(dataSource.resetPassword('username'));
          expect(actual, isInstanceOf<SuccessState<String>>());
        },
      );
      test(
        'should return errorState when the call to auth data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.resetPassword(any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.resetPassword('username');
          // assert
          verify(dataSource.resetPassword('username'));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.resetPassword(any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.resetPassword('username');
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
  group('signUp', () {
    test(
      'should check that the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        // act
        repository.signUp('username', 'password');
        // assert
        verify(networkInfo.isConnected);
      },
    );
    runTestsOnline(() {
      test(
        'should return a successState with usermodel when the sign up is successful',
        () async {
          // arrange
          when(dataSource.signUp(any, any))
              .thenAnswer((_) async => SuccessState<UserModel>(tUser));
          // act
          final actual = await repository.signUp('username', 'password');
          // assert
          verify(dataSource.signUp('username', 'password'));
          expect(actual, isInstanceOf<SuccessState<UserModel>>());
        },
      );
      test(
        'should return errorState when the call to auth data source is unsuccessful',
        () async {
          // arrange
          when(dataSource.signUp(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.signUp('username', 'password');
          // assert
          verify(dataSource.signUp('username', 'password'));
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return errorState when device is offline',
        () async {
          // arrange
          when(dataSource.signUp(any, any))
              .thenAnswer((_) async => ErrorState<String>('Error, error'));
          // act
          final actual = await repository.signUp('username', 'password');
          // assert
          expect(actual, isInstanceOf<ErrorState<String>>());
        },
      );
    });
  });
}
