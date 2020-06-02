import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:receptio/injection.iconfig.dart';

final getIt = GetIt.asNewInstance();

@injectableInit
void configureInjection() => $initGetIt(getIt);
