import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/repositories/recipe_repository_impl.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockRemoteDataSource extends Mock implements RecipeRemoteDataSource {}

class MockLocalDataSource extends Mock implements RecipeLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  RecipeRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RecipeRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  final tId = 1;
  final Recipe tRecipe = getRecipeModel(tId);

  group('getRecipe', () {
    test(
      'should check that the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getRecipe(tId);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipe(any))
              .thenAnswer((_) async => tRecipe);
          // act
          final result = await repository.getRecipe(tId);
          // assert
          verify(mockRemoteDataSource.getRecipe(tId));
          expect(result, equals(Right(tRecipe)));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipe(any))
              .thenAnswer((_) async => tRecipe);
          // act
          await repository.getRecipe(tId);
          // assert
          verify(mockRemoteDataSource.getRecipe(tId));
          verify(mockLocalDataSource.cacheRecipe(tRecipe));
        },
      );

      test(
        'should return serverfailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipe(any))
              .thenThrow(ServerException('Couldn\'t connect to server.'));
          // act
          final result = await repository.getRecipe(tId);
          // assert
          verify(mockRemoteDataSource.getRecipe(tId));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ServerFailure when offline',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipe(tId)).thenThrow(
              ServerException('Couldn\'t get any recipes. Are you offline?'));
          // act
          final result = await repository.getRecipe(tId);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
