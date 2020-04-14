import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/network/network_info.dart';
import 'package:receptio_mobile/features/getrecipes/data/datasources/recipes_local_datasource.dart';
import 'package:receptio_mobile/features/getrecipes/data/datasources/recipes_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipes/data/repositories/recipes_repository_impl.dart';
import 'package:receptio_mobile/features/getrecipes/domain/entities/recipes.dart';

import '../../../../fixtures/dummy_recipes.dart';

class MockRemoteDataSource extends Mock implements RecipesRemoteDataSource {}

class MockLocalDataSource extends Mock implements RecipesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  RecipesRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RecipesRepositoryImpl(
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

  final tSearchString = 'Chicago pizza';
  final Recipes tRecipes = getRecipesModel(2);

  group('getRecipes', () {
    test(
      'should check that the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getRecipes(tSearchString);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipes(any))
              .thenAnswer((_) async => tRecipes);
          // act
          final result = await repository.getRecipes(tSearchString);
          // assert
          verify(mockRemoteDataSource.getRecipes(tSearchString.toString()));
          expect(result, equals(Right(tRecipes)));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipes(tSearchString.toString()))
              .thenAnswer((_) async => tRecipes);
          // act
          await repository.getRecipes(tSearchString);
          // assert
          verify(mockRemoteDataSource.getRecipes(tSearchString.toString()));
          verify(mockLocalDataSource.cacheRecipes(tRecipes));
        },
      );

      test(
        'should return a serverfailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipes(any))
              .thenThrow(ServerException('Couldn\'t connect to server.'));
          // act
          final result = await repository.getRecipes(tSearchString);
          // assert
          verify(mockRemoteDataSource.getRecipes(tSearchString.toString()));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return a ServerFailure when offline',
        () async {
          // arrange
          when(mockRemoteDataSource.getRecipes(tSearchString.toString()))
              .thenThrow(ServerException(
                  'Couldn\'t get any recipes. Are you offline?'));
          // act
          final result = await repository.getRecipes(tSearchString);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
