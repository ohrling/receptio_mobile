// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/core/util/recipe_converters.dart';
import 'package:receptio_mobile/core/network/recipe_client.dart';
import 'package:receptio_mobile/features/recipes/data/datasources/recipe_datasource.dart';
import 'package:receptio_mobile/features/recipes/data/repositories/recipes_repository.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_ingredients.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_measurements.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_recipe_list.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/post_recipe.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/displayrecipe/recipelist_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/addrecipe_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerModule = _$RegisterModule();
  g.registerFactory<InputConverter>(() => InputConverter());
  g.registerFactory<Repository>(
      () => RecipesRepository(
          g<RecipeDataSource>(instanceName: 'RecipeDataSource'),
          g<NetworkInfo>(instanceName: 'NetworkInfo')),
      instanceName: 'Repository');
  g.registerFactory<GetIngredients>(
      () => GetIngredients(g<Repository>(instanceName: 'Repository')),
      instanceName: 'GetIngredients');
  g.registerFactory<GetMeasurements>(
      () => GetMeasurements(g<Repository>(instanceName: 'Repository')),
      instanceName: 'GetMeasurements');
  g.registerFactory<GetRecipeList>(
      () => GetRecipeList(g<Repository>(instanceName: 'Repository')),
      instanceName: 'GetRecipeList');
  g.registerFactory<PostRecipe>(
      () => PostRecipe(g<Repository>(instanceName: 'Repository')),
      instanceName: 'PostRecipe');
  g.registerFactory<RecipelistBloc>(
      () => RecipelistBloc(g<GetRecipeList>(instanceName: 'GetRecipeList')),
      instanceName: 'RecipelistBloc');
  g.registerFactory<AddRecipeBloc>(
      () => AddRecipeBloc(
            g<PostRecipe>(instanceName: 'PostRecipe'),
            g<GetIngredients>(instanceName: 'GetIngredients'),
            g<GetMeasurements>(instanceName: 'GetMeasurements'),
          ),
      instanceName: 'AddRecipeBloc');

  //Register test Dependencies --------
  if (environment == 'test') {
    g.registerFactory<DataConnectionChecker>(() => MockDataConnectionChecker(),
        instanceName: 'DataConnectionChecker');
    g.registerFactory<NetworkInfo>(() => MockNetworkInfo(),
        instanceName: 'MockNetworkInfo');
    g.registerFactory<RecipeClient>(() => MockClient(),
        instanceName: 'MockedClient');
    g.registerFactory<RecipeDataSource>(() => MockDataSource(),
        instanceName: 'MockDataSource');
    g.registerFactory<Repository>(() => MockRepository(),
        instanceName: 'MockRepository');
  }

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerFactory<NetworkInfo>(
        () => NetworkInfoImpl(
            g<DataConnectionChecker>(instanceName: 'DataConnectionChecker')),
        instanceName: 'NetworkInfo');
    g.registerFactory<RecipeClient>(() => RemoteClient(),
        instanceName: 'Client');
    g.registerFactory<RecipeDataSource>(
        () => RemoteRecipeDataSource(g<RecipeClient>(instanceName: 'Client')),
        instanceName: 'RecipeDataSource');
  }

  //Eager singletons must be registered in the right order
  g.registerSingleton<DataConnectionChecker>(
      registerModule.dataConnectionChecker,
      instanceName: 'DataConnectionChecker');
}

class _$RegisterModule extends RegisterModule {
  @override
  DataConnectionChecker get dataConnectionChecker => DataConnectionChecker();
}
