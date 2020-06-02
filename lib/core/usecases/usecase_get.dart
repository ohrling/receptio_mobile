import 'package:receptio/core/error/states.dart';

abstract class GetData<Param> {
  Future<State> call(Param param);
}
