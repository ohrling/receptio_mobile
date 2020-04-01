import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecipeState extends Equatable {
  RecipeState();
}

class InitialRecipeState extends RecipeState {
  @override
  List<Object> get props => [];
}
