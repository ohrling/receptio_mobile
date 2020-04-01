import 'dart:convert';

import 'package:better_uuid/uuid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';

import '../../../../fixtures/fixute_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RecipeRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RecipeRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('recipe.json'), 200));
  }

  group('getRecipe', () {
    final tId = Uuid.v4();
    final tRecipe = RecipeModel.fromJson(json.decode(fixture('recipe.json')));

    test('should perform a GET request on a URL with id being the endpoint',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getRecipe(tId);
      // assert
      verify(mockHttpClient
          .get('http://receptio.herokuapp.com/api/recipe/?recipeId=$tId'));
    });

    test('should return Recipe when the response is 200', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getRecipe(tId);
      // assert
      expect(result, equals(tRecipe));
    });

    test('should throw a ServerException when the response code isn\'t 200',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 400));
      // act
      final call = dataSource.getRecipe;
      // assert
      expect(() => call(tId), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
