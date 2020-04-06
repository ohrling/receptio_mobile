import 'package:meta/meta.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel(
      {@required int id,
      @required String name,
      @required String description,
      @required int cookingTime,
      @required int servings,
      @required String instructions,
      @required List<dynamic> ingredients,
      @required String image,
      @required String source})
      : super(
            id: id,
            name: name,
            description: description,
            cookingTime: cookingTime,
            servings: servings,
            instructions: instructions,
            ingredients: ingredients,
            image: image,
            source: source);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        cookingTime: json['cookingTime'],
        servings: json['servings'],
        instructions: json['instructions'],
        ingredients: json['ingredients'],
        image: json['image'],
        source: json['source']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cookingTime': cookingTime,
      'servings': servings,
      'instructions': instructions,
      'ingredients': ingredients,
      'image': image,
      'source': source
    };
  }
}
