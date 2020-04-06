import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';
import 'package:receptio_mobile/features/getrecipes/domain/repositories/recipes_repository.dart';
import 'package:receptio_mobile/features/getrecipes/domain/usecases/get_recipes.dart';

class MockGetRecipesRepository extends Mock implements RecipesRepository {}

void main() {
  UseCaseGetRecipes useCase;
  MockGetRecipesRepository mockGetRecipesRepository;

  setUp(() {
    mockGetRecipesRepository = MockGetRecipesRepository();
    useCase = GetRecipes(mockGetRecipesRepository);
  });

  final tRecipes = Recipes(recipes: _getArrayOfRecipes());
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

_getArrayOfRecipes() {
  final recipeOne = Recipe(
      id: 42,
      name: 'Flygande Jakob',
      description: 'The swedish classic, let it blow you away!',
      cookingTime: 90,
      servings: 6,
      instructions:
          'Cook the rice, make the curry, cook the chicken. Put the rice in the bottom and mix the chicken, curry, banana and peanuts around and put it into the owen!',
      ingredients: [
        {
          "id": 20,
          "name": "Rice",
          "measurementType": "dl",
          "imageUrl": "/",
          "amount": 200
        },
        {
          "id": 21,
          "name": "Banana",
          "measurementType": "pc",
          "imageUrl": "/",
          "amount": 1
        },
        {
          "id": 12,
          "name": "Cicken",
          "measurementType": "pc",
          "imageUrl": "/",
          "amount": 3
        }
      ],
      image: '/images/flygande_jakob.jpg',
      source: 'John Doe');
  final recipeTwo = Recipe(
      id: 45,
      name: 'Chicago Deep-dish Pizza',
      description: 'Classic chicago deep dish pizza with lots of pepperoni!',
      cookingTime: 90,
      servings: 6,
      instructions:
          'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.',
      ingredients: [
        {
          "id": 45,
          "name": "Cheese",
          "measurementType": "grams",
          "image": "/",
          "amount": 300
        },
        {
          "id": 986,
          "name": "Pepperoni",
          "measurementType": "grams",
          "image": "/",
          "amount": 100
        },
        {
          "id": 983,
          "name": "Tomato sauce",
          "measurementType": "grams",
          "image": "/",
          "amount": 500
        }
      ],
      image: '/images/pizza.jpg',
      source: 'John Doe');
  return [recipeOne, recipeTwo];
}
