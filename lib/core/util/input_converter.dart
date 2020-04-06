import 'package:dartz/dartz.dart';
import 'package:receptio_mobile/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToInteger(String str) {
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

class InvalidInputFailure extends Failure {}
