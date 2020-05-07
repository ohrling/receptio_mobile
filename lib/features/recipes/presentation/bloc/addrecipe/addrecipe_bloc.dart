import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredient_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/data/models/measurements_model.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredient.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_ingredients.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_measurements.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/post_recipe.dart';
import './bloc.dart';

@Named('AddRecipeBloc')
@injectable
class AddRecipeBloc extends Bloc<AddRecipeEvent, AddRecipeState> {
  final PostRecipe _postRecipe;
  final GetIngredients _getIngredients;
  final GetMeasurements _getMeasurements;

  final List<Ingredient> _ingredients = [];
  final List<String> _measurements = [];
  final List<Ingredient> ingredientMatches = [];
  final List<String> measurementsMatches = [];

  final Map parameters = Map<String, dynamic>();

  AddRecipeBloc(
      @Named('PostRecipe') this._postRecipe,
      @Named('GetIngredients') this._getIngredients,
      @Named('GetMeasurements') this._getMeasurements);

  @override
  AddRecipeState get initialState => AddRecipeInitial();

  @override
  Stream<AddRecipeState> mapEventToState(
    AddRecipeEvent event,
  ) async* {
    // TODO: Can this be a switch instead?
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
      print(event.servings.toString());
      yield Loading();
      State ingredientsState = await _getIngredients.call(NullParam());
      if (ingredientsState is SuccessState) {
        print(ingredientsState.value);
        _ingredients
            .addAll((ingredientsState.value as IngredientsModel).ingredients);
        State measurementState = await _getMeasurements.call(NullParam());
        if (measurementState is SuccessState) {
          print(measurementState.value);
          _measurements.addAll(
              (measurementState.value as MeasurementsModel).measurementType);
          yield AddIngredients();
        } else {
          yield Error(errorMessage: (measurementState as ErrorState).msg);
        }
      } else {
        yield Error(errorMessage: (ingredientsState as ErrorState).msg);
      }
    } else if (event is GetIngredientsSuggestion) {
      _getIngredientSuggestions(event.input);
    } else if (event is GetMeasurementSuggestion) {
      _getMeasurementSuggestions(event.input);
    } else if (event is AddRecipeIngredients) {
      List<Map> ingredients = [];
      for (var i = 0; i < event.ingredients.length; i++) {
        ingredients.add((event.ingredients[i] as IngredientModel).toMap());
      }
      parameters['ingredients'] = ingredients;
      print(parameters['ingredients'].toString());
      print(parameters);
      yield AddInstructions();
    } else if (event is SendRecipe) {
      yield PostingRecipe();
      parameters['instructions'] = event.instructions;
      parameters['image'] = null; // TODO: REMOVE WHEN IMPLEMENTED
      parameters['source'] = 'TP'; // TODO: REMOVE WHEN USER IS IMPLEMENTED
      State state = await _postRecipe.call(PostParam(parameters: parameters));
      if (state is ErrorState) {
        yield Error(errorMessage: state.msg);
      } else if (state is SuccessState) {
        AddRecipeDone(state.value);
      } else {
        yield Error(errorMessage: 'Something went terribly wrong.');
      }
    }
  }

  void _getIngredientSuggestions(String query) async {
    ingredientMatches.addAll(_ingredients);
    ingredientMatches
        .retainWhere((s) => s.name.toLowerCase().contains(query.toLowerCase()));
  }

  void _getMeasurementSuggestions(String query) async {
    measurementsMatches.addAll(_measurements);
    measurementsMatches.retainWhere(
        (s) => s.toString().toLowerCase().contains(query.toLowerCase()));
  }

  void dispose() {
    close();
  }
}
