import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecipeEvent extends Equatable {
  RecipeEvent([List props = const <dynamic>[]]) : super(props);
}
