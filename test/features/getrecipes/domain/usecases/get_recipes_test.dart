import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';
import 'package:receptio_mobile/features/getrecipes/domain/repositories/recipes_repository.dart';
import 'package:receptio_mobile/features/getrecipes/domain/usecases/get_recipes.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockGetRecipesRepository extends Mock implements RecipesRepository {}

void main() {
  UseCaseGetRecipes useCase;
  MockGetRecipesRepository mockGetRecipesRepository;

  setUp(() {
    mockGetRecipesRepository = MockGetRecipesRepository();
    useCase = GetRecipes(mockGetRecipesRepository);
  });

  final tRecipes = Recipes(recipes: getRecipesModel(2).recipes);
  final tSearchValues = ['cheese', 'salami', 'banan'];

  test(
    'should a recipes from the repository',
    () async {
      // arrange
      when(mockGetRecipesRepository.getRecipes(any))
          .thenAnswer((_) async => Right(tRecipes));
      // act
      final result = await useCase(Params(searchValues: tSearchValues));
      // assert
      expect(result, Right(tRecipes));
      verify(mockGetRecipesRepository.getRecipes(tSearchValues));
      verifyNoMoreInteractions(mockGetRecipesRepository);
    },
  );
}
