import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/util/recipe_converters.dart';
import 'package:receptio_mobile/features/getrecipes/domain/usecases/get_recipes.dart';

import 'bloc.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  GetRecipes getRecipes;
  RecipeConverter inputConverter;

  RecipesBloc({@required this.getRecipes, @required this.inputConverter})
      : assert(getRecipes != null),
        assert(inputConverter != null);

  @override
  RecipesState get initialState => Empty();

  @override
  Stream<RecipesState> mapEventToState(
    RecipesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
