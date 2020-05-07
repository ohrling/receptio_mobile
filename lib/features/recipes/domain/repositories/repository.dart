import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:mockito/mockito.dart';

import '../../../../injection.dart';

abstract class Repository {
  Future<State> getRecipe(int id);
  Future<State> getRecipes(String searchString);
  Future<State> postRecipe(Map parameters);
  Future<State> getMeasurements();
  Future<State> getIngredients();
}

@Named('MockRepository')
@RegisterAs(Repository, env: Env.test)
@injectable
class MockRepository extends Mock implements Repository {}
