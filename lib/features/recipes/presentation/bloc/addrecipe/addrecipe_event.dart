import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredient.dart';

@immutable
abstract class AddRecipeEvent extends Equatable {
  AddRecipeEvent([List props = const []]) : super(props);
}

class AddRecipeName extends AddRecipeEvent {
  final String name;
  AddRecipeName({@required this.name}) : assert(name != null);

  @override
  List<Object> get props => [name];
}

class AddRecipeDescription extends AddRecipeEvent {
  final String description;

  AddRecipeDescription({@required this.description})
      : assert(description != null);

  @override
  List<Object> get props => [description];
}

class AddRecipeCookingTime extends AddRecipeEvent {
  final int cookingTime;

  AddRecipeCookingTime({@required this.cookingTime}) : super([cookingTime]);

  @override
  List<Object> get props => [cookingTime];
}

class AddRecipeServings extends AddRecipeEvent {
  final int servings;

  AddRecipeServings({@required this.servings}) : super([servings]);

  @override
  List<Object> get props => [servings];
}

class AddRecipeIngredients extends AddRecipeEvent {
  final List<Ingredient> ingredients;

  AddRecipeIngredients({@required this.ingredients}) : super([ingredients]);

  @override
  List<Object> get props => [ingredients];
}

class GetIngredientsSuggestion extends AddRecipeEvent {
  final String input;

  GetIngredientsSuggestion({@required this.input}) : super([input]);

  @override
  List<Object> get props => [input];
}

class GetMeasurementSuggestion extends AddRecipeEvent {
  final String input;

  GetMeasurementSuggestion({@required this.input}) : super([input]);
}

// TODO: Add back when images is available
/*
class AddRecipeInstructions extends AddRecipeEvent {
  final String instructions;

  AddRecipeInstructions({@required this.instructions}) : super([instructions]);

  
  @override
  List<Object> get props => [instructions];
}
*/
class GetInputParameters extends AddRecipeEvent {}

class SendRecipe extends AddRecipeEvent {
  final String instructions;

  SendRecipe({@required this.instructions}) : super([instructions]);

  @override
  List<Object> get props => [instructions];
}
