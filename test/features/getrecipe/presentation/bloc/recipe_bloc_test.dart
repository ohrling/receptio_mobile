import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/core/util/recipe_converters.dart';
import 'package:receptio_mobile/features/getrecipe/domain/usecases/get_recipe.dart';
import 'package:receptio_mobile/features/getrecipe/presentation/bloc/bloc.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockGetRecipe extends Mock implements GetRecipe {}

class MockInputConverter extends Mock implements RecipeConverter {}

void main() {
  RecipeBloc bloc;
  MockGetRecipe mockGetRecipe;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRecipe = MockGetRecipe();
    mockInputConverter = MockInputConverter();
    bloc = RecipeBloc(
        getRecipe: mockGetRecipe, inputConverter: mockInputConverter);
  });

  test('initialState should be empty', () async {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('RecipeBloc constructor', () {
    test('should assert if GetRecipe is null', () {
      expect(
          () => RecipeBloc(getRecipe: null, inputConverter: mockInputConverter),
          throwsA(isAssertionError));
    });
    test('should assert if inputConverter is null', () {
      expect(() => RecipeBloc(getRecipe: mockGetRecipe, inputConverter: null),
          throwsA(isAssertionError));
    });
  });

  group('GetRecipe', () {
    final tIdString = "1";
    final tIdParsed = 1;
    final tRecipe = getRecipeModel(tIdParsed);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.convert(any)).thenReturn(Right(tIdParsed));

    test(
        'should call the inputconverter to validate and convert the string an unsigned integer',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      // act
      bloc.dispatch(GetRecipeById(tIdString));
      await untilCalled(mockInputConverter.convert(any));
      // assert
      verify(mockInputConverter.convert(tIdString));
    });
    test('should emit [Error] when the input is invalid', () async {
      // arrange
      when(mockInputConverter.convert(any))
          .thenReturn(Left(InvalidInputFailure()));
      // assert later
      final expected = [
        Empty(),
        Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetRecipeById(tIdString));
    });
    test('should get data from the usecase', () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetRecipe(any)).thenAnswer((_) async => Right(tRecipe));
      // act
      bloc.dispatch(GetRecipeById(tIdString));
      await untilCalled(mockGetRecipe(any));
      // assert
      verify(mockGetRecipe(Param(id: tIdParsed)));
    });
    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetRecipe(any)).thenAnswer((_) async => Right(tRecipe));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(recipe: tRecipe),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetRecipeById(tIdString));
    });
    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetRecipe(any)).thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(errorMessage: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetRecipeById(tIdString));
    });
    test(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetRecipe(any)).thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(errorMessage: CACHED_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetRecipeById(tIdString));
    });
  });
}
