import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:mockito/mockito.dart';
import 'package:receptio/core/network/network_info.dart';
import 'package:receptio/features/auth/domain/repositories/auth_repository.dart';
import 'package:receptio/features/api/data/datasources/recipe_datasource.dart';
import 'package:receptio/features/api/domain/repositories/receptio_repository.dart';

class MockReceptioRepository extends Mock implements ReceptioRepository {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockReceptioDataSource extends Mock implements RecipeDataSource {}

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuth0Auth extends Mock implements Auth0Auth {}
