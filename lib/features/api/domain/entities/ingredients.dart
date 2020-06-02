import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:receptio/features/api/domain/entities/ingredient.dart';

class Ingredients extends Equatable {
  final List<Ingredient> ingredients;

  Ingredients({@required this.ingredients}) : super([ingredients]);
}
