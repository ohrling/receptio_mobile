import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

class Recipes extends Equatable {
  final List<Recipe> recipes;

  Recipes({@required this.recipes}) : super([recipes]);
}
