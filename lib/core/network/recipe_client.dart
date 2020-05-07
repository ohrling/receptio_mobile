import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import '../../injection.dart';

abstract class RecipeClient{
  Client getClient();
}

@Named('Client')
@RegisterAs(RecipeClient, env: Env.prod)
@injectable
class RemoteClient implements RecipeClient{
  @override
  Client getClient() {
    return Client();
  }
}

@Named('MockedClient')
@RegisterAs(RecipeClient, env: Env.test)
@injectable
class MockClient extends Mock implements RecipeClient {}