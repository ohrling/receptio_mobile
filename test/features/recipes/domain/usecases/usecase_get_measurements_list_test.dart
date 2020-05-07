import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/features/recipes/data/models/measurements_model.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/get_measurements.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

void main() {
  GetMeasurements useCase;
  MockRepository repository;

  setUp(() {
    repository = MockRepository();
    useCase = GetMeasurements(repository);
  });

  final tMeasurements = MeasurementsModel.fromJson(json.decode('''
      [
        {
          "measurementType":"deciliters"
        },
        {
          "measurementType":"grams"
        },
        {
          "measurementType":"deciliters"
        },
        {
          "measurementType":"grams"
        },
        {
          "measurementType":"grams"
        },
        {
          "measurementType":"grams"
        },
        {
          "measurementType":"grams"
        },
        {
          "measurementType":"grams"
        },
        {
          "measurementType":"asd"
        },
        {
          "measurementType":"asd"
        },
        {
          "measurementType":"asd"
        }
      ]'''));

  group('GetMeasurements', () {
    test(
      'should get successstate with measurements in it from the repository',
      () async {
        // arrange
        when(repository.getMeasurements())
            .thenAnswer((_) async => SuccessState(tMeasurements));
        // act
        final result = await useCase(NullParam());
        // assert
        expect(result, isInstanceOf<SuccessState>());
        verify(repository.getMeasurements());
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'shouldn\'t get errorstate from the repository',
      () async {
        // arrange
        when(repository.getMeasurements())
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final result = await useCase(NullParam());
        // assert
        expect(result, isInstanceOf<ErrorState>());
        verify(repository.getMeasurements());
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
