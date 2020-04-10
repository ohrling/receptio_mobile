import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/util/input_converter.dart';
import 'package:receptio_mobile/features/getrecipes/domain/usecases/get_recipes.dart';

class MockGetRecipes extends Mock implements GetRecipes {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  /*RecipesBloc bloc;
  MockGetRecipes mockGetRecipes;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRecipes = MockGetRecipes();
    mockInputConverter = MockInputConverter();
    bloc = RecipesBloc(
        getRecipes: mockGetRecipes, inputConverter: mockInputConverter);
  });

  test('initialState should be empty', () async {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });*/
}
