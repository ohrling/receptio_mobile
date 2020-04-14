import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receptio_mobile/core/error/failures.dart';

abstract class UseCaseGetRecipe<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

abstract class UseCaseGetRecipes<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Param extends Equatable {
  final int id;

  Param({@required this.id}) : super([id]);
}

class Params extends Equatable {
  final String searchValues;

  Params({@required this.searchValues}) : super([searchValues]);
}
