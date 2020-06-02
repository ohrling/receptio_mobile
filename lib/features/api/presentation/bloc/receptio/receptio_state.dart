import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:receptio/features/api/domain/entities/recipes.dart';

@immutable
abstract class ReceptioState extends Equatable {
  ReceptioState([List props = const []]) : super(props);
}

class ReceptioInitial extends ReceptioState {
  @override
  List<Object> get props => [];
}

class UserRecipesLoading extends ReceptioState {}

class UserRecipesLoaded extends ReceptioState {
  final Recipes recipes;

  UserRecipesLoaded({@required this.recipes});
}

class UserIsRecipeOwner extends ReceptioState {}

class UserIsRecipeSpectator extends ReceptioState {}

class RecipeDeleted extends ReceptioState {}

class StartToUpdateRecipe extends ReceptioState {}

class UserError extends ReceptioState {
  final errorMessage;

  UserError({this.errorMessage});
}
