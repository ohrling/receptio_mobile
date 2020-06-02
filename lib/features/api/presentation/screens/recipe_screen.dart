import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/displayrecipe/bloc.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_ingredients_search_screen.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_list.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_name_search_screen.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_search.dart';
import 'package:receptio/features/api/presentation/widgets/message_display.dart';
import 'package:receptio/injection.dart';

class RecipeScreen extends StatefulWidget {
  final accessToken;

  RecipeScreen({Key key, this.accessToken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/food-background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xffedfdf0).withOpacity(0.4), BlendMode.exclusion),
          ),
        ),
        child: BlocProvider<DisplayRecipeBloc>(
          create: (BuildContext context) =>
              getIt.get(instanceName: 'DisplayRecipeBloc'),
          child: Column(
            children: <Widget>[
              BlocListener<DisplayRecipeBloc, DisplayRecipeState>(
                listener: (context, state) {
                  if (state is Error) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MessageDisplay(message: state.errorMessage)));
                  }
                },
                child: BlocBuilder<DisplayRecipeBloc, DisplayRecipeState>(
                  builder: (context, state) {
                    if (state is DisplayRecipeLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DisplayRecipeInitial) {
                      return RecipeSearch();
                    } else if (state is SearchResult) {
                      return RecipeList(recipes: state.recipes);
                    } else if (state is ShowSearchScreen) {
                      return RecipeSearch();
                    } else if (state is ShowNameSearch) {
                      return RecipeNameSearchScreen();
                    } else if (state is ShowIngredientsSearch) {
                      return RecipeIngredientsSearchScreen();
                    }
                    return MessageDisplay(
                      message: '',
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
