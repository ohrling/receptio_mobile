import 'package:flutter/material.dart';
import 'package:receptio/features/api/domain/entities/recipes.dart';

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
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
            child: Text(
              'Results',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: buildList(widget.recipes),
        ),
      ],
    );
  }

  Widget buildList(Recipes recipeList) {
    return ListView.builder(
      itemCount: recipeList.recipes.length,
      itemBuilder: (BuildContext context, int index) {
        return recipeList.recipes[index].name != null ||
                recipeList.recipes[index].description != null
            ? Card(
                elevation: 10,
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  dense: true,
                  isThreeLine: true,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      recipeList.recipes[index].name == null ||
                              recipeList.recipes[index].name.length < 1
                          ? 'Error loading name'.toUpperCase()
                          : recipeList.recipes[index].name.toUpperCase(),
                      style: TextStyle(
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  leading: recipeList.recipes[index].imageUrl == null ||
                          !recipeList.recipes[index].imageUrl.contains('http')
                      ? Icon(
                          Icons.restaurant_menu,
                          color: Colors.green.shade700,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              NetworkImage(recipeList.recipes[index].imageUrl),
                        ),
                  trailing: Icon(Icons.chevron_right),
                  subtitle: Text(
                    recipeList.recipes[index].description == null ||
                            recipeList.recipes[index].description.length < 1
                        ? 'Error loading info'
                        : recipeList.recipes[index].description,
                    style: TextStyle(
                      color: Colors.green.shade800,
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/recipeDetail',
                      arguments: recipeList.recipes[index]),
                ),
              )
            : Text('');
      },
    );
  }
}
