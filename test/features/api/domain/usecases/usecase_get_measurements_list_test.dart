import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';
import 'package:receptio/features/api/data/models/measurements_model.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';
import 'package:receptio/features/api/domain/usecases/get_measurements.dart';

import '../../../../fixtures/mocks.dart';

void main() {
  GetMeasurements useCase;
  ReceptioRepository repository;

  setUp(() {
    repository = MockReceptioRepository();
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
  final tToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ0b3B0YWwuY29tI iwiZXhwIjoxNDI2NDIwODAwLCJodHRwOi8vdG9wdGFsLmNvbS9qd3RfY2xhaW1zL2lzX2FkbWluI jp0cnVlLCJjb21wYW55IjoiVG9wdGFsIiwiYXdlc29tZSI6dHJ1ZX0.yRQYnWzskCZUxPwaQupWk iUzKELZ49eM7oWxAQK_ZXw';

  group('GetMeasurements', () {
    test(
      'should get successstate with measurements in it from the repository',
      () async {
        // arrange
        when(repository.getMeasurements(any))
            .thenAnswer((_) async => SuccessState(tMeasurements));
        // act
        final result = await useCase(TokenParam(accessToken: tToken));
        // assert
        expect(result, isInstanceOf<SuccessState>());
        verify(repository.getMeasurements(tToken));
        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'shouldn\'t get errorstate from the repository',
      () async {
        // arrange
        when(repository.getMeasurements(any))
            .thenAnswer((_) async => ErrorState('Error'));
        // act
        final result = await useCase(TokenParam(accessToken: tToken));
        // assert
        expect(result, isInstanceOf<ErrorState>());
        verify(repository.getMeasurements(tToken));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
