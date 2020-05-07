import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import '../../injection.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@Named('MockNetworkInfo')
@RegisterAs(NetworkInfo, env: Env.test)
@injectable
class MockNetworkInfo extends Mock implements NetworkInfo{}

@Named('NetworkInfo')
@RegisterAs(NetworkInfo, env: Env.prod)
@injectable
class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(@Named('DataConnectionChecker')this.dataConnectionChecker);

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}

@registerModule
abstract class RegisterModule{
  
  @Named('DataConnectionChecker')
  @singleton
  DataConnectionChecker get dataConnectionChecker;
}


@Named('DataConnectionChecker')
@RegisterAs(DataConnectionChecker, env: Env.test)
@injectable
class MockDataConnectionChecker extends Mock implements DataConnectionChecker{}
