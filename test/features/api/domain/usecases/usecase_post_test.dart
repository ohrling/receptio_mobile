import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/data/models/recipe_model.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';
import 'package:receptio/features/api/domain/usecases/post_recipe.dart';

import '../../../../fixtures/dummy_recipes.dart';
import '../../../../fixtures/mocks.dart';

void main() {
  PostRecipe useCase;
  ReceptioRepository repository;

  setUp(() {
    repository = MockReceptioRepository();
    useCase = PostRecipe(repository);
  });

  final tRecipe = getRecipe();
  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';

  group('PostRecipe', () {
    test(
      'should post a recipe with one recipe and get a SuccessState from the repository',
      () async {
        // arrange
        when(repository.postRecipe(any, any))
            .thenAnswer((_) async => SuccessState('Added'));
        // act
        final actual = await useCase(SendParam(
            parameters: (tRecipe as RecipeModel).toJson(),
            accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<SuccessState>());
        verify(
            repository.postRecipe((tRecipe as RecipeModel).toJson(), tToken));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'shouldn\'nt be able to post a recipe so should get a ErrorState from the repository',
      () async {
        // arrange
        when(repository.postRecipe(any, any))
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final actual = await useCase(SendParam(
            parameters: (tRecipe as RecipeModel).toJson(),
            accessToken: tToken));
        // assert
        expect(actual, isInstanceOf<ErrorState>());
        verify(
            repository.postRecipe((tRecipe as RecipeModel).toJson(), tToken));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
