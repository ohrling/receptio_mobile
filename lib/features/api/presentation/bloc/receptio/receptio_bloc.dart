import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/domain/entities/recipe.dart';
import 'package:receptio/features/api/domain/entities/recipes.dart';
import 'package:receptio/features/api/domain/usecases/get_user_recipes.dart';

import 'bloc.dart';

@Named('ReceptioBloc')
@injectable
class ReceptioBloc extends Bloc<ReceptioEvent, ReceptioState> {
  final GetUserRecipes _getUserRecipes;
  Recipes userRecipes;

  ReceptioBloc(
    @Named('GetUserRecipes') this._getUserRecipes,
  );

  List<Recipe> get getRecipes => userRecipes.recipes;

  @override
  ReceptioState get initialState => ReceptioInitial();

  @override
  Stream<ReceptioState> mapEventToState(
    ReceptioEvent event,
  ) async* {
    if (event is LoadUserRecipes) {
      yield UserRecipesLoading();
      State state = await _getUserRecipes
          .call(TokenParam(accessToken: event.accessToken));
      if (state is ErrorState) {
        yield UserError(errorMessage: state.msg);
      } else if (state is SuccessState) {
        userRecipes = state.value;
        yield UserRecipesLoaded(recipes: userRecipes);
      }
    } else if (event is CheckUserIsRecipeOwner) {
      if (userRecipes == null ||
          userRecipes.getRecipes.isEmpty ||
          userRecipes == null) {
        yield UserIsRecipeSpectator();
      } else {
        for (var recipe in userRecipes.getRecipes) {
          if (recipe.id == event.id) {
            yield UserIsRecipeOwner();
          }
        }
      }
      ;
    }
  }
}
