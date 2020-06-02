import 'package:meta/meta.dart';
import 'package:receptio/features/api/data/models/recipe_model.dart';
import 'package:receptio/features/api/domain/entities/recipe.dart';
import 'package:receptio/features/api/domain/entities/recipes.dart';

class RecipesModel extends Recipes {
  RecipesModel({@required List<Recipe> recipes}) : super(recipes: recipes);

  factory RecipesModel.fromJson(List<dynamic> json) {
    List<Recipe> temp = [];
    for (int i = 0; i < json.length; i++) {
      Recipe recipe = RecipeModel.fromJson(json[i]);
      temp.add(recipe);
    }

    return RecipesModel(recipes: temp);
  }
}
