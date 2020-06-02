import 'package:flutter/material.dart';
import 'package:receptio/features/api/domain/entities/ingredients.dart';
import 'package:receptio/features/api/domain/entities/recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  RecipeDetail({this.recipe, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RecipeDetailState(recipe: recipe);
  }
}

class RecipeDetailState extends State<RecipeDetail> {
  final Recipe recipe;

  RecipeDetailState({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/food-background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xffedfdf0).withOpacity(0.4), BlendMode.exclusion),
          ),
        ),
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: buildDisplay(),
      ),
    );
  }

  Container buildDisplay() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
          Text(
            recipe.name,
            style: TextStyle(
              fontSize: 30,
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
                      size: 15,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Servings: ' + recipe.servings.toString(),
                      style: TextStyle(
                        fontSize: 15,
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
                      size: 15,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      recipe.cookingTime.toString(),
                      style: TextStyle(
                        fontSize: 15,
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
                      size: 15,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'By: ' +
                          (recipe.author != null ? recipe.author : 'Unknown'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(
                      shrinkWrap: true,
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
                Container(
                  width: (MediaQuery.of(context).size.width / 2) +
                      (MediaQuery.of(context).size.width / 10),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20),
                    child: Flex(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: recipe.instructions,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                      direction: Axis.vertical,
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

  List<Padding> _ingredientsTexts(Ingredients ingredients) {
    List<Padding> ingredientText = [];
    for (var ingredient in ingredients.ingredients) {
      ingredientText.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  ingredient.name,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  ingredient.amount.toString() +
                      ' ' +
                      ingredient.measurementType.toString(),
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ingredientText;
  }
}
