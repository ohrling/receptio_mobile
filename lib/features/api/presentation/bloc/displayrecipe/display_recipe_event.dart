import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DisplayRecipeEvent extends Equatable {
  DisplayRecipeEvent([List props = const []]) : super(props);
}

class DisplaySearchScreen extends DisplayRecipeEvent {}

class DisplayIngredientsSearch extends DisplayRecipeEvent {}

class DisplayNameSearch extends DisplayRecipeEvent {}

class GetRecipesByString extends DisplayRecipeEvent {
  final String searchString;
  final accessToken;

  GetRecipesByString({this.searchString, this.accessToken})
      : super([searchString, accessToken]);
}

class GetRecipesByIngredients extends DisplayRecipeEvent {
  final List<String> searchValues;
  final accessToken;

  GetRecipesByIngredients({this.searchValues, this.accessToken})
      : super([searchValues, accessToken]);
}
