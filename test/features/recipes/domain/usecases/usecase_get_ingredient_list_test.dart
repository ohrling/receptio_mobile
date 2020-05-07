import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_ingredients.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

void main() {
  GetIngredients useCase;
  MockRepository repository;

  setUp(() {
    repository = MockRepository();
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

  group('GetIngredient', () {
    test(
      'should get successstate with ingredients in it from the repository',
      () async {
        // arrange
        when(repository.getIngredients()).thenAnswer(
            (_) async => SuccessState<IngredientsModel>(tIngredients));
        // act
        final result = await useCase(NullParam());
        // assert
        expect(result, isInstanceOf<SuccessState>());
        verify(repository.getIngredients());
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should get errorstate from the repository',
      () async {
        // arrange
        when(repository.getIngredients())
            .thenAnswer((_) async => ErrorState<String>('Error'));
        // act
        final result = await useCase(NullParam());
        // assert
        expect(result, isInstanceOf<ErrorState>());
        verify(repository.getIngredients());
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
