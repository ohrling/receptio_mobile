import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';
import 'package:receptio/features/auth/domain/usecases/get_authentication_token.dart';

import '../../../../fixtures/mocks.dart';

void main() {
  GetAuthenticationToken useCase;
  AuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    useCase = GetAuthenticationToken(repository);
  });

  group('getApiAuthToken', () {
    test(
      'should get a successstate containing the accesstoken',
      () async {
        // arrange
        when(repository.getAuthToken(any, any))
            .thenAnswer((_) async => SuccessState('token'));
        // act
        final actual = await useCase
            .call(UserParam(username: 'username', password: 'password'));
        // assert
        expect(actual, isInstanceOf<SuccessState>());
        verify(repository.getAuthToken('username', 'password'));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should get a errorstate when there was an error retrieving the accesstoken',
      () async {
        // arrange
        when(repository.getAuthToken(any, any))
            .thenAnswer((_) async => ErrorState('Error, error'));
        // act
        final actual = await useCase
            .call(UserParam(username: 'username', password: 'password'));
        // assert
        expect(actual, isInstanceOf<ErrorState>());
        verify(repository.getAuthToken('username', 'password'));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
