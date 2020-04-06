import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipe/domain/repositories/recipe_repository.dart';
import 'package:receptio_mobile/features/getrecipe/domain/usecases/get_recipe.dart';

class MockGetRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  GetRecipe useCase;
  MockGetRecipeRepository mockGetRecipeRepository;

  setUp(() {
    mockGetRecipeRepository = MockGetRecipeRepository();
    useCase = GetRecipe(mockGetRecipeRepository);
  });

  final tId = 1;
  final tName = 'Chicago Deep-dish Pizza';
  final tDescription =
      'Classic chicago deep dish pizza with lots of pepperoni!';
  final tCookingTime = 90;
  final tServings = 4;
  final tInstructions =
      'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.';
  final tIngredients = [
    '''
    {
      "id": "45",
      "name": "Cheese",
      "measurementType": "grams",
      "image": "/"
    }''',
    '''{
      "id": "986",
      "name": "Pepperoni",
      "measurementType": "grams",
      "image": "/"
    }''',
    '''{
      "id": "983",
      "name": "Tomato sauce",
      "measurementType": "grams",
      "image": "/"
    }'''
  ];
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
