import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_recipe_list.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/displayrecipe/bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/displayrecipe/recipelist_bloc.dart';

import '../../../../../fixtures/dummy_recipes.dart';

class MockGetRecipeList extends Mock implements GetRecipeList {}

void main() {
  RecipelistBloc bloc;
  MockGetRecipeList getRecipeList;

  setUp(() {
    getRecipeList = MockGetRecipeList();
    bloc = RecipelistBloc(getRecipeList);
  });

  test(
    'initialState should be empty',
    () async {
      // assert
      expect(bloc.initialState, equals(RecipeListInitial()));
    },
  );

  group('GetRecipeList', () {
    final tSeatchString = ' chicago pizza ';
    final tCleanedString = 'chicago pizza';
    final tRecipes = getRecipesModel(1);
    test(
      'should call the string cleaner to make shure the search is longer than three letters',
      () async {
        // arrange
        // act

        // assert
      },
    );
    test(
      'should call the string cleaner to clean up the searchstring',
      () async {
        // arrange

        // act

        // assert
      },
    );
  });
  tearDown(() {
    bloc?.close();
  });
}
