import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receptio/features/api/domain/entities/recipes.dart';

@immutable
abstract class DisplayRecipeState extends Equatable {
  DisplayRecipeState([List props = const []]) : super(props);
}

class DisplayRecipeInitial extends DisplayRecipeState {}

class DisplayRecipeLoading extends DisplayRecipeState {}

class Error extends DisplayRecipeState {
  final String errorMessage;

  Error({@required this.errorMessage}) : super([errorMessage]);
}

class SearchResult extends DisplayRecipeState {
  final Recipes recipes;

  SearchResult({@required this.recipes}) : super([recipes]);
}

class ShowSearchScreen extends DisplayRecipeState {}

class ShowNameSearch extends DisplayRecipeState {}

class ShowIngredientsSearch extends DisplayRecipeState {}
