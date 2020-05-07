import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredient.dart';

class Ingredients extends Equatable {
  final List<Ingredient> ingredients;

  Ingredients({@required this.ingredients}) : super([ingredients]);
}
