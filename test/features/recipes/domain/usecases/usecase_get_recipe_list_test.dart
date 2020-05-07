import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_recipe_list.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

import '../../../../fixtures/dummy_recipes.dart';

void main() {
  GetRecipeList useCase;
  MockRepository repository;

  setUp(() {
    repository = MockRepository();
    useCase = GetRecipeList(repository);
  });

  final tSearch = 'pizza';
  final tRecipes = getRecipesModel(1);

  group('GetRecipeList', () {
    test(
      'should get successstate with recipes in it from the repository',
      () async {
        // arrange
        when(repository.getRecipes(any))
            .thenAnswer((_) async => SuccessState(tRecipes));
        // act
        final result = await useCase(SearchParam(searchString: tSearch));
        // assert
        expect(result, isInstanceOf<SuccessState>());
        verify(repository.getRecipes(tSearch));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'shouldn\'t get errorstate from the repository',
      () async {
        // arrange
        when(repository.getRecipes(any))
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final result = await useCase(SearchParam(searchString: tSearch));
        // assert
        expect(result, isInstanceOf<ErrorState>());
        verify(repository.getRecipes(tSearch));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
