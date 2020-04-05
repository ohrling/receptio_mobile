import 'package:flutter/material.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';

class RecipeDisplay extends StatelessWidget {
  final Recipe recipe;

  const RecipeDisplay({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: <Widget>[
          Text(
            recipe.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.restaurant_menu,
                      size: 8,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Servings: ' + recipe.servings.toString(),
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 8,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      recipe.cookingTime.toString(),
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.perm_identity,
                      size: 8,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'By: ' + recipe.source,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8),
                    child: ListView(
                      children: _ingredientsTexts(recipe.ingredients),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: VerticalDivider(
                    thickness: 0.5,
                    color: Colors.black26,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      recipe.instructions,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Row> _ingredientsTexts(List<dynamic> ingredients) {
    List<Row> ingredientText = [];
    for (var ingredient in ingredients) {
      ingredientText.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ingredient['name'],
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.right,
            ),
            Text(
              ingredient['amount'].toString() + ingredient['measurementType'],
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );
    }
    return ingredientText;
  }
}
