import 'package:better_uuid/uuid.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUuid', () {
    test('should return an uuid when the string represents an Uuid', () async {
      // arrange
      final str = 'd290f1ee-6c54-4b01-90e6-d701748f0851';
      // act
      final result = inputConverter.stringToUuid(str);
      //assert
      expect(result, Right(Uuid('d290f1ee-6c54-4b01-90e6-d701748f0851')));
    });
    test('should return an Failure when the string is not a Uuid', () async {
      // arrange
      final str = 'abc';
      // act
      final result = inputConverter.stringToUuid(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return an Failure when the input is a negative integer',
        () async {
      // arrange
      final str = '-123';
      // act
      final result = inputConverter.stringToUuid(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
