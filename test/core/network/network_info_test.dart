import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/network/network_info.dart';

import '../../fixtures/mocks.dart';

void main() {
  NetworkInfoImpl networkInfo;
  DataConnectionChecker dataConnectionChecker;

  setUp(() {
    dataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(dataConnectionChecker);
  });
  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(dataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = networkInfo.isConnected;
        // assert
        verify(networkInfo.dataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
