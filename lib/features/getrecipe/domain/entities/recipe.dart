import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Recipe extends Equatable {
  final int id;
  final String name;
  final String description;
  final int cookingTime;
  final int servings;
  final String instructions;
  final List<dynamic> ingredients;
  final String image;
  final String source;

  Recipe(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.cookingTime,
      @required this.servings,
      @required this.instructions,
      @required this.ingredients,
      @required this.image,
      @required this.source})
      : super([
          id,
          name,
          description,
          cookingTime,
          servings,
          instructions,
          ingredients,
          image,
          source
        ]);
}
