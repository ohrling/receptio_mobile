import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipes.dart';

@immutable
abstract class RecipeListState extends Equatable {
  RecipeListState([List props = const []]) : super(props);
}

class RecipeListInitial extends RecipeListState {}

class RecipeListLoading extends RecipeListState {}

class RecipeListLoaded extends RecipeListState {
  final Recipes recipes;

  RecipeListLoaded(this.recipes) : super([recipes]);
}

class Error extends RecipeListState {
  final String errorMessage;

  Error({@required this.errorMessage}) : super([errorMessage]);
}

class RecipeListDetail extends RecipeListState {
  final Recipe recipe;

  RecipeListDetail(this.recipe) : super([recipe]);
}
