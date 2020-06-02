import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/data/models/recipes_model.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';
import 'package:receptio/features/api/domain/usecases/get_user_recipes.dart';

import '../../../../fixtures/dummy_recipes.dart';
import '../../../../fixtures/mocks.dart';

void main() {
  GetUserRecipes useCase;
  ReceptioRepository repository;

  setUp(() {
    repository = MockReceptioRepository();
    useCase = GetUserRecipes(repository);
  });

  final tRecipes = getRecipesModel(2);
  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';

  group('GetUserRecipes', () {
    test(
      'should get a successState with user specific recipes',
      () async {
        // arrange
        when(repository.getUserRecipes(any))
            .thenAnswer((_) async => SuccessState<RecipesModel>(tRecipes));
        // act
        final actual = await useCase(TokenParam(accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<SuccessState>());
        verify(repository.getUserRecipes(tToken));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should get a errorstate from the repository',
      () async {
        // arrange
        when(repository.getUserRecipes(any))
            .thenAnswer((_) async => ErrorState<String>('Error, error'));
        // act
        final actual = await useCase(TokenParam(accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<ErrorState>());
        verify(repository.getUserRecipes(tToken));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
