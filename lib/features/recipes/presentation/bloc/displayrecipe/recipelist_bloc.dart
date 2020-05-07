import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_recipe_list.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

import 'bloc.dart';

@Named('RecipelistBloc')
@injectable
class RecipelistBloc extends Bloc<RecipelistEvent, RecipeListState> {
  final GetRecipeList _getRecipeList;

  RecipelistBloc(@Named('GetRecipeList') this._getRecipeList);

  @override
  RecipeListState get initialState => RecipeListInitial();

  @override
  Stream<RecipeListState> mapEventToState(
    RecipelistEvent event,
  ) async* {
    if (event is GetRecipes) {
      yield RecipeListLoading();
      State state = await _getRecipeList
          .call(SearchParam(searchString: event.searchString));
      if (state is ErrorState) {
        yield Error(errorMessage: state.msg);
      } else if (state is SuccessState) {
        yield RecipeListLoaded(state.value);
      } else {
        yield Error(errorMessage: 'Something went terribly wrong.');
      }
    }
  }

  void dispose() {
    close();
  }
}
