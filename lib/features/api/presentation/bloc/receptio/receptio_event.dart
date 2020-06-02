import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ReceptioEvent extends Equatable {
  ReceptioEvent([List props = const []]) : super(props);
}

class LoadUserRecipes extends ReceptioEvent {
  final accessToken;

  LoadUserRecipes(this.accessToken) : super([accessToken]);
}

class CheckUserIsRecipeOwner extends ReceptioEvent {
  final id;

  CheckUserIsRecipeOwner({this.id}) : super([id]);
}

class DeleteRecipe extends ReceptioEvent {
  final id;

  DeleteRecipe({this.id}) : super([id]);
}

class UpdateRecipe extends ReceptioEvent {
  final recipe;

  UpdateRecipe({this.recipe}) : super([recipe]);
}
