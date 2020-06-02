import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/data/models/ingredients_model.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';
import 'package:receptio/features/api/domain/usecases/get_ingredients.dart';

import '../../../../fixtures/mocks.dart';

void main() {
  GetIngredients useCase;
  ReceptioRepository repository;

  setUp(() {
    repository = MockReceptioRepository();
    useCase = GetIngredients(repository);
  });

  final tIngredients = IngredientsModel.fromJson(json.decode('''
      [
        {
          "name":"pizza sauce",
          "imageUrl":null,
          "measurementType":"deciliters",
          "amount":3.5
        },
        {
          "name":"bread flour",
          "imageUrl":null,
          "measurementType":"grams",
          "amount":400.0
        }
      ]'''));
  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';

  group('GetIngredient', () {
    test(
      'should get successstate with ingredients in it from the repository',
      () async {
        // arrange
        when(repository.getIngredients(any)).thenAnswer(
            (_) async => SuccessState<IngredientsModel>(tIngredients));
        // act
        final result = await useCase(TokenParam(accessToken: tToken));
        // assert
        expect(result, isInstanceOf<SuccessState>());
        verify(repository.getIngredients(tToken));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should get errorstate from the repository',
      () async {
        // arrange
        when(repository.getIngredients(any))
            .thenAnswer((_) async => ErrorState<String>('Error'));
        // act
        final result = await useCase(TokenParam(accessToken: tToken));
        // assert
        expect(result, isInstanceOf<ErrorState>());
        verify(repository.getIngredients(tToken));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
