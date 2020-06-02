import 'package:meta/meta.dart';
import 'package:receptio/features/api/data/models/ingredients_model.dart';
import 'package:receptio/features/api/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel(
      {@required id,
      @required name,
      @required description,
      @required cookingTime,
      @required servings,
      @required instructions,
      @required ingredients,
      @required imageUrl,
      @required author})
      : super(
            id: id,
            name: name,
            description: description,
            cookingTime: cookingTime,
            servings: servings,
            instructions: instructions,
            ingredients: ingredients,
            imageUrl: imageUrl,
            author: author);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        cookingTime: json['cookingTime'],
        servings: json['servings'],
        instructions: json['instructions'],
        ingredients: IngredientsModel.fromJson(json['ingredients']),
        imageUrl: json['imageUrl'],
        author: json['author']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cookingTime': cookingTime,
      'servings': servings,
      'instructions': instructions,
      'ingredients': (ingredients as IngredientsModel).toJson(),
      'imageUrl': imageUrl,
      'author': author
    };
  }
}
