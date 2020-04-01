import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  @override
  RecipeState get initialState => InitialRecipeState();

  @override
  Stream<RecipeState> mapEventToState(
    RecipeEvent event,
  ) async* {
  }
}
