import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';
import 'package:receptio/features/api/domain/usecases/get_name_search_recipe_list.dart';

import '../../../../fixtures/dummy_recipes.dart';
import '../../../../fixtures/mocks.dart';

void main() {
  GetNameSearchRecipeList useCase;
  ReceptioRepository repository;

  setUp(() {
    repository = MockReceptioRepository();
    useCase = GetNameSearchRecipeList(repository);
  });

  final tSearch = 'pizza';
  final tRecipes = getRecipesModel(1);
  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';

  group('GetNameSearchRecipeList', () {
    test(
      'should get successstate with recipes in it from the repository',
      () async {
        // arrange
        when(repository.getRecipesFromName(any, any))
            .thenAnswer((_) async => SuccessState(tRecipes));
        // act
        final actual = await useCase(
            SearchParam(searchValue: tSearch, accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<SuccessState>());
        verify(repository.getRecipesFromName(tSearch, tToken));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should get errorstate from the repository',
      () async {
        // arrange
        when(repository.getRecipesFromName(any, any))
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final actual = await useCase(
            SearchParam(searchValue: tSearch, accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<ErrorState>());
        verify(repository.getRecipesFromName(tSearch, tToken));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
