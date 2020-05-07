import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipe.dart';

@immutable
abstract class RecipelistEvent extends Equatable {
  RecipelistEvent([List props = const []]) : super(props);

}

class GetRecipes extends RecipelistEvent {
  final String searchString;

  GetRecipes(this.searchString) : super([searchString]);

}

class GetRecipeDetail extends RecipelistEvent {
  final Recipe recipe;

  GetRecipeDetail(this.recipe);
  
}