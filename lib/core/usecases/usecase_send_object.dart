import 'package:receptio/core/error/states.dart';

abstract class SendObject<Param> {
  Future<State> call(Param param);
}
