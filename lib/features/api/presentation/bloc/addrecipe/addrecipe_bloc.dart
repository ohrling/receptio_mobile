import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:receptio/features/api/domain/entities/ingredient.dart';
import 'package:receptio/features/api/domain/usecases/post_recipe.dart';
import './bloc.dart';

@Named('AddRecipeBloc')
@injectable
class AddRecipeBloc extends Bloc<AddRecipeEvent, AddRecipeState> {
  final PostRecipe _postRecipe;
  final AuthBloc _authBloc;

  final List<Ingredient> ingredientMatches = [];
  final List<String> measurementsMatches = [];

  final Map parameters = Map<dynamic, dynamic>();

  AddRecipeBloc(
    @Named('AuthBloc') this._authBloc,
    @Named('PostRecipe') this._postRecipe,
  );

  @override
  AddRecipeState get initialState => AddRecipeInitial();

  @override
  Stream<AddRecipeState> mapEventToState(
    AddRecipeEvent event,
  ) async* {
    if (event is AddRecipeName) {
      parameters['name'] = event.name;
      yield AddDescription();
    } else if (event is AddRecipeDescription) {
      parameters['description'] = event.description;
      yield AddCookingTime();
    } else if (event is AddRecipeCookingTime) {
      parameters['cookingTime'] = event.cookingTime;
      yield AddServings();
    } else if (event is AddRecipeServings) {
      parameters['servings'] = event.servings;
      yield AddIngredients();
    } else if (event is AddRecipeIngredients) {
      var ingredients = event.ingredients;
      parameters['ingredients'] = ingredients;
      yield AddInstructions();
    } else if (event is SendRecipe) {
      yield PostingRecipe();
      parameters['instructions'] = event.instructions;
      parameters['image'] = null; // TODO: REMOVE WHEN IMPLEMENTED
      parameters['author'] = _authBloc.user.nickname;
      State state = await _postRecipe.call(SendParam(
          parameters: parameters, accessToken: _authBloc.accessToken));
      if (state is ErrorState) {
        yield Error(errorMessage: state.msg);
      } else if (state is SuccessState) {
        AddRecipeDone(state.value);
      } else {
        yield Error(errorMessage: 'Something went terribly wrong.');
      }
    }
  }

  void dispose() {
    close();
  }
}
