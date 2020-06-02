import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:receptio/features/api/domain/entities/ingredients.dart';

class Recipe extends Equatable {
  final int id;
  final String name;
  final String description;
  final int cookingTime;
  final int servings;
  final String instructions;
  final Ingredients ingredients;
  final String imageUrl;
  final String author;

  Recipe(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.cookingTime,
      @required this.servings,
      @required this.instructions,
      @required this.ingredients,
      @required this.imageUrl,
      @required this.author})
      : super([
          id,
          name,
          description,
          cookingTime,
          servings,
          instructions,
          ingredients,
          imageUrl,
          author
        ]);

  @override
  String toString() {
    return 'id: $id, name: $name';
  }
}
