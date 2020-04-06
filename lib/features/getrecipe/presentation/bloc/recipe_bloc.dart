import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/usecases/usecase.dart';
import 'package:receptio_mobile/core/util/input_converter.dart';
import 'package:receptio_mobile/features/getrecipe/domain/usecases/get_recipe.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHED_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The value must be a valid Uuid.';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipe getRecipe;
  final InputConverter inputConverter;

  RecipeBloc({@required this.getRecipe, @required this.inputConverter})
      : assert(getRecipe != null),
        assert(inputConverter != null);

  @override
  RecipeState get initialState => Empty();

  @override
  Stream<RecipeState> mapEventToState(
    RecipeEvent event,
  ) async* {
    if (event is GetRecipeById) {
      final inputEither = inputConverter.stringToInteger(event.idString);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (int) async* {
          yield Loading();
          final failureOrRecipe = await getRecipe(Params(id: int));
          yield failureOrRecipe.fold(
            (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
            (recipe) => Loaded(recipe: recipe),
          );
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
