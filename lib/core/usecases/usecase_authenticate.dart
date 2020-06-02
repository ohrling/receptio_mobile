import 'package:receptio/core/error/states.dart';
import 'package:receptio/core/usecases/params.dart';

abstract class Authenticate<Param> {
  Future<State> call(Param authParam);
}

abstract class NewPassword<Param> {
  Future<State> call(PassParam passParam);
}
