import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';
import 'package:receptio_mobile/core/usecases/usecase_post.dart';
import 'package:receptio_mobile/features/recipes/domain/repositories/repository.dart';
import 'package:receptio_mobile/features/recipes/domain/usecases/params.dart';

@Named('PostRecipe')
@injectable
class PostRecipe extends PostData<PostParam> {
  final Repository repository;

  PostRecipe(@Named('Repository') this.repository);

  @override
  Future<State> call(PostParam param) async {
    return await repository.postRecipe(param.parameters);
  }
}
