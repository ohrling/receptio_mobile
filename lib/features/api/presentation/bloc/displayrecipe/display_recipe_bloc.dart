import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/domain/usecases/get_ingredient_search_recipe_list.dart';
import 'package:receptio/features/api/domain/usecases/get_name_search_recipe_list.dart';

import 'bloc.dart';

@Named('DisplayRecipeBloc')
@injectable
class DisplayRecipeBloc extends Bloc<DisplayRecipeEvent, DisplayRecipeState> {
  final GetNameSearchRecipeList _getNameSearchRecipeList;
  final GetIngredientSearchRecipeList _getIngredientSearchRecipeList;
  final _error = 'Something went terribly wrong.';

  DisplayRecipeBloc(
    @Named('GetNameSearchRecipeList') this._getNameSearchRecipeList,
    @Named('GetIngredientSearchRecipeList') this._getIngredientSearchRecipeList,
  );

  @override
  DisplayRecipeState get initialState => DisplayRecipeInitial();

  @override
  Stream<DisplayRecipeState> mapEventToState(
    DisplayRecipeEvent event,
  ) async* {
    if (event is DisplaySearchScreen) {
      yield ShowSearchScreen();
    } else if (event is DisplayIngredientsSearch) {
      yield ShowIngredientsSearch();
    } else if (event is DisplayNameSearch) {
      yield ShowNameSearch();
    }
    if (event is GetRecipesByString) {
      yield DisplayRecipeLoading();
      State state = await _getNameSearchRecipeList.call(SearchParam(
          searchValue: event.searchString, accessToken: event.accessToken));
      if (state is ErrorState) {
        yield Error(errorMessage: state.msg);
      } else if (state is SuccessState) {
        yield SearchResult(recipes: state.value);
      } else {
        yield Error(errorMessage: _error);
      }
    } else if (event is GetRecipesByIngredients) {
      yield DisplayRecipeLoading();
      State state = await _getIngredientSearchRecipeList.call(SearchParam(
          searchValue: event.searchValues, accessToken: event.accessToken));
      if (state is ErrorState) {
        yield Error(errorMessage: state.msg);
      } else if (state is SuccessState) {
        yield SearchResult(recipes: state.value);
      } else {
        yield Error(errorMessage: _error);
      }
    }
  }
}
