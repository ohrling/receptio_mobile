import 'package:flutter/material.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredients.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/displayrecipes/recipe_control_widget.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  RecipeDetail({this.recipe, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print(recipe);
    return RecipeDetailState(
        id: recipe.id,
        name: recipe.name,
        description: recipe.description,
        cookingTime: recipe.cookingTime,
        servings: recipe.servings,
        instructions: recipe.instructions,
        ingredients: recipe.ingredients,
        image: recipe.imageUrl,
        author: recipe.author);
  }
}

class RecipeDetailState extends State<RecipeDetail> {
  final int id;
  final String name;
  final String description;
  final int cookingTime;
  final int servings;
  final String instructions;
  final Ingredients ingredients;
  final String image;
  final String author;

  RecipeDetailState({
    this.id,
    this.name,
    this.description,
    this.cookingTime,
    this.servings,
    this.instructions,
    this.ingredients,
    this.image,
    this.author,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receptio')),
      body: Column(
        children: <Widget>[
          Text(
            name,
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
                      'Servings: ' + servings.toString(),
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
                      cookingTime.toString(),
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
                      'By: ' + (author != null ? author : 'Unknown'),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8),
                    child: ListView(
                      shrinkWrap: true,
                      children: _ingredientsTexts(ingredients),
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
                    padding: EdgeInsets.only(top: 8),
                    child: Flex(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: instructions,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade700,
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
          RecipeControlsWidget(),
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
