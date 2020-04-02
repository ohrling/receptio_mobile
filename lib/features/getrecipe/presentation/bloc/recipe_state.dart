import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

@immutable
abstract class RecipeState extends Equatable {
  RecipeState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends RecipeState {}

class Loading extends RecipeState {}

class Loaded extends RecipeState {
  final Recipe recipe;

  Loaded({@required this.recipe}) : super([recipe]);
}

class Error extends RecipeState {
  final String errorMessage;

  Error({@required this.errorMessage}) : super([errorMessage]);
}
