import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/data/models/recipes_model.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';
import 'package:receptio/features/api/domain/usecases/get_ingredient_search_recipe_list.dart';

import '../../../../fixtures/dummy_recipes.dart';
import '../../../../fixtures/mocks.dart';

void main() {
  GetIngredientSearchRecipeList useCase;
  ReceptioRepository repository;

  setUp(() {
    repository = MockReceptioRepository();
    useCase = GetIngredientSearchRecipeList(repository);
  });

  final tRecipes = getRecipesModel(2);
  final tSearch = ['cheese', 'pepperoni'];
  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';

  group('GetIngredientsSearchRecipeList', () {
    test(
      'should get successState with recipes in it from the repository',
      () async {
        // arrange
        when(repository.getRecipesFromIngredients(any, any))
            .thenAnswer((_) async => SuccessState<RecipesModel>(tRecipes));
        // act
        final actual = await useCase(
            SearchParam(searchValue: tSearch, accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<SuccessState>());
        verify(repository.getRecipesFromIngredients(tSearch, tToken));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should get errorstate from the repository',
      () async {
        // arrange
        when(repository.getRecipesFromIngredients(any, any))
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final actual = await useCase(
            SearchParam(searchValue: tSearch, accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<ErrorState>());
        verify(repository.getRecipesFromIngredients(tSearch, tToken));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
