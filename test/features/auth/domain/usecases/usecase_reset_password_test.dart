import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';
import 'package:receptio/features/auth/domain/usecases/reset_password.dart';

import '../../../../fixtures/mocks.dart';

void main() {
  ResetPassword usecase;
  AuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = ResetPassword(repository);
  });

  final tUserName = 'username';

  group('resetPassword', () {
    test(
      'should get success from repository on valid username',
      () async {
        // arrange
        when(repository.resetPassword(any))
            .thenAnswer((_) async => SuccessState<String>(tUserName));
        // act
        final actual = await usecase.call(PassParam(username: tUserName));
        // assert
        expect(actual, isInstanceOf<SuccessState<String>>());
        verify(repository.resetPassword(tUserName));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should get a errorstate from the repository',
      () async {
        // arrange
        when(repository.resetPassword(any))
            .thenAnswer((_) async => ErrorState<String>('Error'));
        // act
        final actual = await usecase.call(PassParam(username: tUserName));
        // assert
        expect(actual, isInstanceOf<ErrorState<String>>());
        verify(repository.resetPassword(tUserName));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
