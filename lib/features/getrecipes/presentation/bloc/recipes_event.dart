import 'package:equatable/equatable.dart';

abstract class RecipesEvent extends Equatable {
  RecipesEvent([List props = const <dynamic>[]]): super(props);
}

class GetRecipesByIngredients extends RecipesEvent {
  final List<String> ingredients;

  GetRecipesByIngredients(this.ingredients): super([ingredients]);

}