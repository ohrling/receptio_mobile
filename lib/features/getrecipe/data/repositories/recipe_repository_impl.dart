import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/getrecipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final RecipeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, Recipe>> getRecipe(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRecipe = await remoteDataSource.getRecipe(id);
        localDataSource.cacheRecipe(remoteRecipe);
        return Right(remoteRecipe);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
