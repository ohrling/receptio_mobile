import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/util/recipe_converters.dart';
import 'package:receptio_mobile/features/getrecipes/domain/usecases/get_recipes.dart';
import 'package:receptio_mobile/features/getrecipes/presentation/bloc/bloc.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockGetRecipes extends Mock implements GetRecipes {}

class MockIngredientsConverter extends Mock implements RecipeConverter {}

void main() {
  RecipesBloc bloc;
  MockGetRecipes mockGetRecipes;
  MockIngredientsConverter mockInputConverter;

  setUp(() {
    mockGetRecipes = MockGetRecipes();
    mockInputConverter = MockIngredientsConverter();
    bloc = RecipesBloc(
        getRecipes: mockGetRecipes, inputConverter: mockInputConverter);
  });

  test('initialState should be empty', () async {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('RecipesBloc constructor', () {
    test(
      'should assert if GetRecipes is null',
      () async {
        // assert
        expect(
            () => RecipesBloc(
                getRecipes: null, inputConverter: mockInputConverter),
            throwsA(isAssertionError));
      },
    );
    test(
      'should assert if inputConverter is null',
      () async {
        // assert
        expect(
            () => RecipesBloc(getRecipes: mockGetRecipes, inputConverter: null),
            throwsA(isAssertionError));
      },
    );
  });
  group('GetRecipes', () {
    final tSearchString = 'Chicago Pizza';
    final tConvertedSearchString = 'chicago%20pizza';
    final tRecipes = getRecipesModel(1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.convert(any))
            .thenReturn(Right(tConvertedSearchString));
  });
}
