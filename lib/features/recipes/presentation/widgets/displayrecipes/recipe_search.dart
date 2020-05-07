import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/displayrecipe/bloc.dart';

class RecipeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SearchInputField(context),
    );
  }
}

class SearchInputField extends StatefulWidget {
  final BuildContext context;
  SearchInputField(this.context, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchInputField(context);
}

class _SearchInputField extends State<SearchInputField> {
  final context;
  _SearchInputField(this.context);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: TextField(
          onSubmitted: submitRecipeSearch,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search for a recipe',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            suffixIcon: Icon(
              Icons.search,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  void submitRecipeSearch(String searchString) {
    final recipesBloc = BlocProvider.of<RecipelistBloc>(context);
    recipesBloc.add(GetRecipes(searchString));
    recipesBloc.close();
  }
}
