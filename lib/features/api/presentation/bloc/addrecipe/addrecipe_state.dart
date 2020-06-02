import 'package:receptio/features/api/domain/entities/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddRecipeState extends Equatable {
  AddRecipeState([List props = const []]) : super(props);
}

class AddRecipeInitial extends AddRecipeState {}

class AddDescription extends AddRecipeState {}

class AddCookingTime extends AddRecipeState {}

class AddServings extends AddRecipeState {}

class Loading extends AddRecipeState {}

class AddIngredients extends AddRecipeState {}

class Suggestions extends AddRecipeState {
  final List<String> suggestions;

  Suggestions(this.suggestions) : super([suggestions]);
}

class AddInstructions extends AddRecipeState {}

class PostingRecipe extends AddRecipeState {}

class AddRecipeDone extends AddRecipeState {
  final Recipe result;

  AddRecipeDone(this.result) : super([result]);
}

class Error extends AddRecipeState {
  final String errorMessage;

  Error({@required this.errorMessage}) : super([errorMessage]);
}
