import 'package:flutter_test/flutter_test.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/util/recipe_converters.dart';

void main() {
  InputConverter converter;

  setUp(() {
    converter = InputConverter();
  });

  group('convert() string to integer', () {
    test('should return an integer when the string represents an integer',
        () async {
      // arrange
      final str = '1';
      // act
      final result = converter.stringToInteger(str);
      //assert
      expect(result, isInstanceOf<SuccessState<int>>());
      expect((result as SuccessState).value, 1);
    });
    test('should return an Failure when the string is not a integer', () async {
      // arrange
      final str = 'abc';
      // act
      final result = converter.stringToInteger(str);
      print(result);
      //assert
      expect(result, isInstanceOf<ErrorState<String>>());
    });
    test('should return an Failure when the input is a negative integer',
        () async {
      // arrange
      final str = '-123';
      // act
      final result = converter.stringToInteger(str);
      //assert
      expect(result, isInstanceOf<ErrorState<String>>());
    });
    test('should return an Failure when the input is lower than 1', () async {
      // arrange
      final str = '0';
      // act
      final result = converter.stringToInteger(str);
      //assert
      expect(result, isInstanceOf<ErrorState<String>>());
    });
  });

  group('convert() list to string', () {
    test(
      'should convert a list to string lowercase string',
      () async {
        // act
        final result = converter.listToString(['Lemon']);
        // assert
        expect((result as SuccessState).value, 'lemon');
      },
    );
    test(
      'should convert a list to string with valid space-replacements',
      () async {
        // act
        final result = converter.listToString(['Lemon Juice']);
        // assert
        expect((result as SuccessState).value, 'lemon%20juice');
      },
    );
    test(
      'should convert a list to a string of words separated with commas',
      () async {
        // act
        final result =
            converter.listToString(['Ham', 'Cheese', 'Lemon Juice']);
        // assert
        expect((result as SuccessState).value, 'ham,cheese,lemon%20juice');
      },
    );
    test(
      'should return errorstate if something went wrong',
      ()async {
        // act
        final result = converter.listToString(null);        
        // assert
        expect(result, isInstanceOf<ErrorState<String>>());
      },
    );
  });
}
