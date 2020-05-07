import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/features/recipes/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/post_recipe.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  PostRecipe useCase;
  MockRepository repository;

  setUp(() {
    repository = MockRepository();
    useCase = PostRecipe(repository);
  });

  final tRecipe = getRecipe();

  group('PostRecipe', () {
    test(
      'should post a recipe with one recipe and get a SuccessState from the repository',
      () async {
        // arrange
        when(repository.postRecipe(any))
            .thenAnswer((_) async => SuccessState(true));
        // act
        final result = await useCase(
            PostParam(parameters: (tRecipe as RecipeModel).toJson()));
        // assert
        expect(result, isInstanceOf<SuccessState>());
        verify(repository.postRecipe((tRecipe as RecipeModel).toJson()));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'shouldn\'nt be able to post a recipe so should get a ErrorState from the repository',
      () async {
        // arrange
        when(repository.postRecipe(any))
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final result = await useCase(
            PostParam(parameters: (tRecipe as RecipeModel).toJson()));
        // assert
        expect(result, isInstanceOf<ErrorState>());
        verify(repository.postRecipe((tRecipe as RecipeModel).toJson()));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
