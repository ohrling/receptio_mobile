import 'package:better_uuid/uuid.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/core/util/input_converter.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipe/domain/usecases/get_recipe.dart';
import 'package:receptio_mobile/features/getrecipe/presentation/bloc/bloc.dart';

class MockGetRecipe extends Mock implements GetRecipe {}

class MockInputConverter extends Mock implements InputConverter {}

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

  group('GetRecipe', () {
    final tIdString = 'd290f1ee-6c54-4b01-90e6-d701748f0851';
    final tIdParsed = Uuid('d290f1ee-6c54-4b01-90e6-d701748f0851');
    final tRecipe = Recipe(
        id: Uuid('d290f1ee-6c54-4b01-90e6-d701748f0851'),
        name: 'Chicago Deep-dish Pizza',
        description: 'Classic chicago deep dish pizza with lots of pepperoni!',
        cookingTime: 90,
        servings: 4,
        instructions:
            'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.',
        ingredients: ['Cheese', 'Pepperoni', 'Tomato sauce'],
        image: '/images/pizza.jpg',
        source: 'John Doe');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUuid(any)).thenReturn(Right(tIdParsed));

    test(
        'should call the inputconverter to validate and convert the string an unsigned integer',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      // act
      bloc.dispatch(GetRecipeById(tIdString));
      await untilCalled(mockInputConverter.stringToUuid(any));
      // assert
      verify(mockInputConverter.stringToUuid(tIdString));
    });
    test('should emit [Error] when the input is invalid', () async {
      // arrange
      when(mockInputConverter.stringToUuid(any))
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
      verify(mockGetRecipe(Params(id: tIdParsed)));
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
