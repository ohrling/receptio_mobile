import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/features/getrecipe/domain/repositories/recipe_repository.dart';
import 'package:receptio_mobile/features/getrecipe/domain/usecases/get_recipe.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockGetRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  GetRecipe useCase;
  MockGetRecipeRepository mockGetRecipeRepository;

  setUp(() {
    mockGetRecipeRepository = MockGetRecipeRepository();
    useCase = GetRecipe(mockGetRecipeRepository);
  });

  final tId = 1;
  final tRecipe = getRecipeModel(tId);

  test(
    'should a recipe from the repository',
    () async {
      // arrange
      when(mockGetRecipeRepository.getRecipe(any))
          .thenAnswer((_) async => Right(tRecipe));
      // act
      final result = await useCase(Param(id: tId));
      // assert
      expect(result, Right(tRecipe));
      verify(mockGetRecipeRepository.getRecipe(tId));
      verifyNoMoreInteractions(mockGetRecipeRepository);
    },
  );
}
