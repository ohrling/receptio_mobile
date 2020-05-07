import 'package:receptio_mobile/core/error/states.dart';

abstract class PostData<Param> {
  Future<State> call(Param param);
}
