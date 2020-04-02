import 'dart:convert';

import 'package:better_uuid/uuid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipe/data/datasources/recipe_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipe/data/models/recipe_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RecipeRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  String _tJsonRecipe = '''
  {
    "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "name": "Chicago Deep-dish Pizza",
    "description": "Classic chicago deep dish pizza with lots of pepperoni!",
    "cookingTime": 90,
    "servings": 4,
    "instructions": "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
    "ingredients": [
      {
      "id": "766c510a-4218-4686-86d2-259b8e172ebb",
      "name": "Cheese",
      "measurementType": "grams",
      "image": "/"
      }
    ],
    "image": "/images/pizza.jpg",
    "source": "John Doe"
  }''';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RecipeRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(_tJsonRecipe, 200));
  }

  group('getRecipe', () {
    final tId = Uuid.v4();
    final tRecipe = RecipeModel.fromJson(json.decode(_tJsonRecipe));

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
