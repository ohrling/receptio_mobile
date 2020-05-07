import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/displayrecipe/bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/displayrecipes/recipe_search.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/message_display.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/displayrecipes/recipe_list.dart';
import 'package:receptio_mobile/injection.dart';

class RecipeScreen extends StatefulWidget {
  final recipeListBloc = getIt.get(instanceName: 'RecipelistBloc');

  RecipeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                Icon(
                  Icons.restaurant_menu,
                ),
                Text(
                  'Receptio',
                ),
              ],
            ),
          ],
        ),
        textTheme: TextTheme(headline: TextStyle(color: Colors.white)),
      ),
      body: buildRecipeListBody(context),
    );
  }

  BlocProvider<RecipelistBloc> buildRecipeListBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt.get(instanceName: 'RecipelistBloc'),
      child: Wrap(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  BlocBuilder<RecipelistBloc, RecipeListState>(
                    builder: (context, state) {
                      if (state is RecipeListInitial) {
                        return RecipeSearch().build(context);
                      } else if (state is RecipeListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is RecipeListLoaded) {
                        if (state.recipes.recipes.isNotEmpty) {
                          return RecipeList(recipes: state.recipes);
                        } else {
                          return MessageDisplay(
                            message: 'Didn\'t find any recipes.',
                          );
                        }
                      } else if (state is Error) {
                        return MessageDisplay(
                          message: state.errorMessage,
                        );
                      } else {
                        return MessageDisplay(
                          message: '',
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.recipeListBloc.dispose();
  }
}
