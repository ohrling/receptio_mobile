import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/core/util/input_converter.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/repositories/recipe_repository_impl.dart';
import 'package:receptio_mobile/features/getrecipe/domain/repositories/recipe_repository.dart';
import 'package:receptio_mobile/features/getrecipe/domain/usecases/get_recipe.dart';
import 'package:receptio_mobile/features/getrecipe/presentation/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Recipe
  // Bloc
  sl.registerFactory(() => RecipeBloc(
        getRecipe: sl(),
        inputConverter: sl(),
      ));
  // Use cases
  sl.registerLazySingleton(() => GetRecipe(sl()));
  // Repository
  sl.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));
  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<RecipeLocalDataSource>(
      () => RecipeLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
