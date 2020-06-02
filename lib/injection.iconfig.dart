// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:receptio/register_module.dart';
import 'package:http/src/client.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:receptio/core/network/network_info.dart';
import 'package:receptio/features/api/data/datasources/recipe_datasource.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:receptio/features/auth/data/datasources/auth_datasource.dart';
import 'package:receptio/features/auth/data/repositories/auth0repository.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';
import 'package:receptio/features/auth/domain/usecases/get_authentication_token.dart';
import 'package:receptio/features/api/data/repositories/recipes_repository.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';
import 'package:receptio/features/auth/domain/usecases/reset_password.dart';
import 'package:receptio/features/auth/domain/usecases/signin.dart';
import 'package:receptio/features/auth/domain/usecases/signup.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:receptio/features/api/domain/usecases/get_ingredient_search_recipe_list.dart';
import 'package:receptio/features/api/domain/usecases/get_ingredients.dart';
import 'package:receptio/features/api/domain/usecases/get_measurements.dart';
import 'package:receptio/features/api/domain/usecases/get_name_search_recipe_list.dart';
import 'package:receptio/features/api/domain/usecases/get_user_recipes.dart';
import 'package:receptio/features/api/domain/usecases/post_recipe.dart';
import 'package:receptio/features/api/presentation/bloc/receptio/receptio_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/addrecipe_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/displayrecipe/display_recipe_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerModule = _$RegisterModule();
  g.registerFactory<Client>(() => registerModule.client,
      instanceName: 'Client');
  g.registerFactory<DataConnectionChecker>(
      () => registerModule.connectionChecker);
  g.registerFactory<NetworkInfo>(
      () => NetworkInfoImpl(g<DataConnectionChecker>()),
      instanceName: 'NetworkInfo');
  g.registerFactory<RecipeDataSource>(
      () => RemoteRecipeDataSource(g<Client>(instanceName: 'Client')),
      instanceName: 'RecipeDataSource');
  g.registerFactory<String>(() => registerModule.clientId,
      instanceName: 'clientId');
  g.registerFactory<String>(() => registerModule.url, instanceName: 'url');
  g.registerFactory<Auth0Auth>(
      () => registerModule.auth(
          g<String>(instanceName: 'clientId'), g<String>(instanceName: 'url')),
      instanceName: 'Auth');
  g.registerFactory<AuthDataSource>(
      () => Auth0DataSource(g<Auth0Auth>(instanceName: 'Auth')),
      instanceName: 'Auth0DataSource');
  g.registerFactory<AuthRepository>(
      () => Auth0Repository(g<AuthDataSource>(instanceName: 'Auth0DataSource'),
          g<NetworkInfo>(instanceName: 'NetworkInfo')),
      instanceName: 'Auth0Repository');
  g.registerFactory<GetAuthenticationToken>(
      () => GetAuthenticationToken(
          g<AuthRepository>(instanceName: 'Auth0Repository')),
      instanceName: 'GetAuthenticationToken');
  g.registerFactory<ReceptioRepository>(
      () => RecipesRepository(
          g<RecipeDataSource>(instanceName: 'RecipeDataSource'),
          g<NetworkInfo>(instanceName: 'NetworkInfo')),
      instanceName: 'ReceptioRepository');
  g.registerFactory<ResetPassword>(
      () => ResetPassword(g<AuthRepository>(instanceName: 'Auth0Repository')),
      instanceName: 'ResetPassword');
  g.registerFactory<SignIn>(
      () => SignIn(g<AuthRepository>(instanceName: 'Auth0Repository')),
      instanceName: 'SignIn');
  g.registerFactory<SignUp>(
      () => SignUp(g<AuthRepository>(instanceName: 'Auth0Repository')),
      instanceName: 'SignUp');
  g.registerFactory<AuthBloc>(
      () => AuthBloc(
            g<GetAuthenticationToken>(instanceName: 'GetAuthenticationToken'),
            g<SignIn>(instanceName: 'SignIn'),
            g<SignUp>(instanceName: 'SignUp'),
            g<ResetPassword>(instanceName: 'ResetPassword'),
          ),
      instanceName: 'AuthBloc');
  g.registerFactory<GetIngredientSearchRecipeList>(
      () => GetIngredientSearchRecipeList(
          g<ReceptioRepository>(instanceName: 'ReceptioRepository')),
      instanceName: 'GetIngredientSearchRecipeList');
  g.registerFactory<GetIngredients>(
      () => GetIngredients(
          g<ReceptioRepository>(instanceName: 'ReceptioRepository')),
      instanceName: 'GetIngredients');
  g.registerFactory<GetMeasurements>(
      () => GetMeasurements(
          g<ReceptioRepository>(instanceName: 'ReceptioRepository')),
      instanceName: 'GetMeasurements');
  g.registerFactory<GetNameSearchRecipeList>(
      () => GetNameSearchRecipeList(
          g<ReceptioRepository>(instanceName: 'ReceptioRepository')),
      instanceName: 'GetNameSearchRecipeList');
  g.registerFactory<GetUserRecipes>(
      () => GetUserRecipes(
          g<ReceptioRepository>(instanceName: 'ReceptioRepository')),
      instanceName: 'GetUserRecipes');
  g.registerFactory<PostRecipe>(
      () =>
          PostRecipe(g<ReceptioRepository>(instanceName: 'ReceptioRepository')),
      instanceName: 'PostRecipe');
  g.registerFactory<ReceptioBloc>(
      () => ReceptioBloc(g<GetUserRecipes>(instanceName: 'GetUserRecipes')),
      instanceName: 'ReceptioBloc');
  g.registerFactory<AddRecipeBloc>(
      () => AddRecipeBloc(g<AuthBloc>(instanceName: 'AuthBloc'),
          g<PostRecipe>(instanceName: 'PostRecipe')),
      instanceName: 'AddRecipeBloc');
  g.registerFactory<DisplayRecipeBloc>(
      () => DisplayRecipeBloc(
          g<GetNameSearchRecipeList>(instanceName: 'GetNameSearchRecipeList'),
          g<GetIngredientSearchRecipeList>(
              instanceName: 'GetIngredientSearchRecipeList')),
      instanceName: 'DisplayRecipeBloc');
}

class _$RegisterModule extends RegisterModule {}
