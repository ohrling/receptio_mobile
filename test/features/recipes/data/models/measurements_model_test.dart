import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/features/recipes/data/models/measurements_model.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/measurements.dart';

void main() {
  final tMeasurement = MeasurementsModel.fromJson(json.decode('''
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

  test(
    'should be a subclass of Measurements entity',
    () async {
      print(tMeasurement);
      // assert
      expect(tMeasurement, isA<Measurements>());
    },
  );

  group('fromJson', () {
    String tJsonMeasurement = '''
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
      ]''';
    test(
      'should return a valid model',
      () async {
        // arrange
        final jsonMap = json.decode(tJsonMeasurement);
        // act
        final result = MeasurementsModel.fromJson(jsonMap);
        // assert
        expect(result, isA<MeasurementsModel>());
      },
    );
  });
}
