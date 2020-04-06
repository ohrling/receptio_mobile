import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToInteger', () {
    test('should return an integer when the string represents an integer',
        () async {
      // arrange
      final str = 1.toString();
      // act
      final result = inputConverter.stringToInteger(str);
      //assert
      expect(result, Right(1));
    });
    test('should return an Failure when the string is not a integer', () async {
      // arrange
      final str = 'abc';
      // act
      final result = inputConverter.stringToInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return an Failure when the input is a negative integer',
        () async {
      // arrange
      final str = '-123';
      // act
      final result = inputConverter.stringToInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return an Failure when the input is lower than 1', () async {
      // arrange
      final str = '0';
      // act
      final result = inputConverter.stringToInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
