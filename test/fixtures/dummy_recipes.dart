import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipes/data/models/recipes_model.dart';

RecipeModel getRecipeModel(int id) {
  return _recipeModel(id);
}

Recipe getRecipe() {
  return _recipeModel(1);
}

RecipesModel getRecipesModel(int numberOfRecipes) {
  List<Recipe> _recipes = [];
  int i = 0;
  while (i < numberOfRecipes) {
    _recipes.add(_recipeModel(i + 1));
    i++;
  }
  return RecipesModel(recipes: _recipes);
}

String jsonRecipe() {
  return '''{"id": 1,
        "name": "Chicago Deep-dish Pizza",
        "description": "Classic chicago deep dish pizza with lots of pepperoni!",
        "cookingTime": 90,
        "servings": 4,
        "instructions": "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
        "ingredients": [
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
        "image": "/images/pizza.jpg",
        "source": "John Doe"
        }
        ''';
}

String jsonRecipes() {
  return '''
    [{
      "id": 1,
      "name": "Chicago Deep-dish Pizza",
      "description": "Classic chicago deep dish pizza with lots of pepperoni!",
      "cookingTime": 90,
      "servings": 6,
      "instructions":
        "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
      "ingredients": [
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
      "image": "/images/pizza.jpg",
      "source": "John Doe"
    },
    {
      "id": 2,
      "name": "Chicago Deep-dish Pizza",
      "description": "Classic chicago deep dish pizza with lots of pepperoni!",
      "cookingTime": 90,
      "servings": 6,
      "instructions": "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
      "ingredients": [
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
      "image": "/images/pizza.jpg",
      "source": "John Doe"
    }]
  ''';
}

_recipeModel(int id) {
  return RecipeModel(
      id: id,
      name: 'Chicago Deep-dish Pizza',
      description: 'Classic chicago deep dish pizza with lots of pepperoni!',
      cookingTime: 90,
      servings: 4,
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
}
