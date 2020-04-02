import 'package:better_uuid/uuid.dart';
import 'package:dartz/dartz.dart';
import 'package:receptio_mobile/core/error/failures.dart';

class InputConverter {
  Either<Failure, Uuid> stringToUuid(String str) {
    try {
      if (str.length < 32) {
        throw FormatException();
      } else {
        final uuid = Uuid(str);
        return Right(uuid);
      }
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
