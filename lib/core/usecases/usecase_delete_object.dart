import 'package:receptio/core/error/states.dart';

abstract class DeleteObject<Param> {
  Future<State> call(Param param);
}
