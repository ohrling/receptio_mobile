import 'package:dartz/dartz.dart';
import 'package:receptio_mobile/core/error/failures.dart';

abstract class RecipeConverter {
  Either<Failure, dynamic> convert(String str);
}

class InputConverter implements RecipeConverter {
  @override
  Either<Failure, int> convert(String str) {
    try {
      final id = int.parse(str);
      if (id < 1) {
        throw FormatException();
      } else {
        return Right(id);
      }
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }
}

class SearchValuesConverter implements RecipeConverter {
  @override
  Either<Failure, String> convert(String str) {
    try {
      String search = str.toLowerCase();
      search = search
          .split(RegExp('(?<=[a-z])\\s'))
          .join('%20')
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', '');
      return Right(search);
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }
}
