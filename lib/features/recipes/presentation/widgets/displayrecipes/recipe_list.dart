import 'package:flutter/material.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipes.dart';

class RecipeList extends StatefulWidget {
  final Recipes recipes;

  RecipeList({this.recipes});

  @override
  State<StatefulWidget> createState() {
    return RecipeState();
  }
}

class RecipeState extends State<RecipeList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: buildList(widget.recipes),
    );
  }

  Widget buildList(Recipes recipeList) {
    print(recipeList.recipes);
    return ListView.builder(
        itemCount: recipeList.recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                recipeList.recipes[index].name,
                style: TextStyle(
                  color: Colors.green.shade800,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              subtitle: Text(recipeList.recipes[index].description,
                  style: TextStyle(
                    color: Colors.green.shade800,
                  )),
              onTap: () => Navigator.pushNamed(context, '/recipeDetail',
                  arguments: recipeList.recipes[index]),
            ),
          );
        });
  }
}
