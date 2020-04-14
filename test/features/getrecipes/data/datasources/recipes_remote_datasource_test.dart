import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/exceptions.dart';
import 'package:receptio_mobile/features/getrecipes/data/datasources/recipes_remote_datasource.dart';
import 'package:receptio_mobile/features/getrecipes/data/models/recipes_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RecipesRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  final tSearchString = 'chicago%20pizza';
  String _tJsonRecipes = '''
    [{
      "id": 1,
      "name": "Chicago Deep-dish Pizza",
      "description": "Classic chicago deep dish pizza with lots of pepperoni!",
      "cookingTime": 90,
      "servings": 6,
      "instructions":
        "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
      "ingredients": [
        {
          "id": 45,
          "name": "Cheese",
          "measurementType": "grams",
          "image": "/",
          "amount": 300
        },
        {
          "id": 986,
          "name": "Pepperoni",
          "measurementType": "grams",
          "image": "/",
          "amount": 100
        },
        {
          "id": 983,
          "name": "Tomato sauce",
          "measurementType": "grams",
          "image": "/",
          "amount": 500
        }
      ],
      "image": "/images/pizza.jpg",
      "source": "John Doe"
    },
    {
      "id": 2,
      "name": "Chicago Deep-dish Pizza",
      "description": "Classic chicago deep dish pizza with lots of pepperoni!",
      "cookingTime": 90,
      "servings": 6,
      "instructions": "Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.",
      "ingredients": [
        {
          "id": 45,
          "name": "Cheese",
          "measurementType": "grams",
          "image": "/",
          "amount": 300
        },
        {
          "id": 986,
          "name": "Pepperoni",
          "measurementType": "grams",
          "image": "/",
          "amount": 100
        },
        {
          "id": 983,
          "name": "Tomato sauce",
          "measurementType": "grams",
          "image": "/",
          "amount": 500
        }
      ],
      "image": "/images/pizza.jpg",
      "source": "John Doe"
    }]
  ''';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RecipesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(_tJsonRecipes, 200));
  }

  group('getRecipes', () {
    final tRecipes = RecipesModel.fromJson(json.decode(_tJsonRecipes));
    test(
      'should returna a valid URL',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getRecipes(tSearchString);
        // assert
        verify(mockHttpClient.get(
            'http://receptio.herokuapp.com/recipe?searchString=chicago%20pizza'));
      },
    );
    test(
      'should return Recipes when the response is 200',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getRecipes(tSearchString);
        // assert
        expect(result, equals(tRecipes));
      },
    );
    test(
      'should throw a ServerException when the response code isn\'t 200',
      () async {
        // arrange
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response('Something went wrong', 400));
        // act
        final call = dataSource.getRecipes;
        // assert
        expect(() => call(tSearchString),
            throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
