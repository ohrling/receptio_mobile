import 'package:better_uuid/uuid.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipe/domain/repositories/recipe_repository.dart';
import 'package:receptio_mobile/features/getrecipe/domain/usecases/get_recipe.dart';

class MockGetRecipesRepository extends Mock implements RecipeRepository {}

void main() {
  GetRecipe useCase;
  MockGetRecipesRepository mockGetRecipesRepository;

  setUp(() {
    mockGetRecipesRepository = MockGetRecipesRepository();
    useCase = GetRecipe(mockGetRecipesRepository);
  });

  final tId = Uuid('d290f1ee-6c54-4b01-90e6-d701748f0851');
  final tName = 'Chicago Deep-dish Pizza';
  final tDescription =
      'Classic chicago deep dish pizza with lots of pepperoni!';
  final tCookingTime = 90;
  final tServings = 4;
  final tInstructions =
      'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.';
  final tIngredients = ['Cheese', 'Pepperoni', 'Tomato sauce'];
  final tImage = '/images/pizza.jpg';
  final tSource = 'John Doe';
  final tRecipe = Recipe(
      id: tId,
      name: tName,
      description: tDescription,
      cookingTime: tCookingTime,
      servings: tServings,
      instructions: tInstructions,
      ingredients: tIngredients,
      image: tImage,
      source: tSource);

  test(
    'should a recipe from the repository',
    () async {
      // arrange
      when(mockGetRecipesRepository.getRecipe(any))
          .thenAnswer((_) async => Right(tRecipe));
      // act
      final result = await useCase(Params(id: tId));
      // assert
      expect(result, Right(tRecipe));
      verify(mockGetRecipesRepository.getRecipe(tId));
      verifyNoMoreInteractions(mockGetRecipesRepository);
    },
  );
}
