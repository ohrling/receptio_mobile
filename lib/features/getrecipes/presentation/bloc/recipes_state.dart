import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecipesState extends Equatable {
  RecipesState([List props = const <dynamic>[]]): super(props);
}

class Empty extends RecipesState {}

/*class Error extends RecipesState {
  final String errorMessage;

  Error({@required this.errorMessage}): super([errorMessage]);
}*/