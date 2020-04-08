import 'package:meta/meta.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';

class RecipesModel extends Recipes {
  RecipesModel({@required List<Recipe> recipes}) : super(recipes: recipes);

  factory RecipesModel.fromJson(List<dynamic> json) {
    List _recipes =
        json.map((recipeJson) => RecipeModel.fromJson(recipeJson)).toList();

    return RecipesModel(recipes: _recipes);
  }

  List<dynamic> toJson() {
    print(recipes.toString());
    var _recipes = [];
    for (var recipe in recipes) {
      _recipes.add({
        'id': recipe.id,
        'name': recipe.name,
        'description': recipe.description,
        'cookingTime': recipe.cookingTime,
        'servings': recipe.servings,
        'instructions': recipe.instructions,
        'ingredients': recipe.ingredients,
        'image': recipe.image,
        'source': recipe.source
      });
      //};
      //_recipes.add(_recipe);
    }
    return _recipes;
  }
}
