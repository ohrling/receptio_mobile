import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/features/getrecipes/data/datasources/recipes_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipes/data/datasources/recipes_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';
import 'package:receptio_mobile/features/getrecipes/domain/repositories/recipes_repository.dart';

class RecipesRepositoryImpl extends RecipesRepository {
  final RecipesRemoteDataSource remoteDataSource;
  final RecipesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RecipesRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, Recipes>> getRecipes(List<String> searchValues) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRecipes = await remoteDataSource.getRecipes(searchValues);
        localDataSource.cacheRecipes(remoteRecipes);
        return Right(remoteRecipes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
