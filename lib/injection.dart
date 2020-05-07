import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/injection.iconfig.dart';

final getIt = GetIt.asNewInstance();

@injectableInit
void configureInjection(String environment) =>
  $initGetIt(getIt, environment: environment);

  abstract class Env {
    static const test = 'test';
    static const prod = 'prod';
  }