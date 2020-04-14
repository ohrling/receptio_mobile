import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/core/error/failures.dart';
import 'package:receptio_mobile/core/util/recipe_converters.dart';

void main() {
  group('convert() string to integer', () {
    RecipeConverter inputConverter = InputConverter();
    test('should return an integer when the string represents an integer',
        () async {
      // arrange
      final str = 1.toString();
      // act
      final result = inputConverter.convert(str);
      //assert
      expect(result, Right(1));
    });
    test('should return an Failure when the string is not a integer', () async {
      // arrange
      final str = 'abc';
      // act
      final result = inputConverter.convert(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return an Failure when the input is a negative integer',
        () async {
      // arrange
      final str = '-123';
      // act
      final result = inputConverter.convert(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return an Failure when the input is lower than 1', () async {
      // arrange
      final str = '0';
      // act
      final result = inputConverter.convert(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });

  group('convert() list to string', () {
    RecipeConverter converter = SearchValuesConverter();
    test(
      'should convert a list to string lowercase string',
      () async {
        // act
        final result = converter.convert(['Lemon'].toString());
        // assert
        expect(result, Right('lemon'));
      },
    );
    test(
      'should convert a list to string with valid space-replacements',
      () async {
        // act
        final result = converter.convert(['Lemon Juice'].toString());
        // assert
        expect(result, Right('lemon%20juice'));
      },
    );
    test(
      'should convert a list to a string of words separated with commas',
      () async {
        // act
        final result =
            converter.convert(['Ham', 'Cheese', 'Lemon Juice'].toString());
        // assert
        expect(
            result,
            Right(
                'ham,cheese,lemon%20juice')); // todo: Actual: Right<Failure, String>:<Right(ham,%20cheese,%20lemon%20juice)>
      },
    );
  });
}
