import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredients_model.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/bloc.dart';

class InstructionsInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InstructionsInputField();
}

class _InstructionsInputField extends State<InstructionsInputField> {
  TextEditingController _instructions = TextEditingController();
  AddRecipeBloc addRecipeBloc;
  @override
  Widget build(BuildContext context) {
    addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    return Wrap(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    addRecipeBloc.parameters['name'],
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    addRecipeBloc.parameters['description'],
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.green.shade600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 11,
                          ),
                          Text(
                            addRecipeBloc.parameters['cookingTime'].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.restaurant_menu,
                            size: 11,
                          ),
                          Text(
                            addRecipeBloc.parameters['servings'].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _displayIngredients(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _instructions,
              textInputAction: TextInputAction.newline,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Instructions',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
            RaisedButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white70),
              ),
              color: Colors.green.shade800,
              onPressed: () {
                addRecipeBloc.add(
                  SendRecipe(instructions: _instructions.text),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _displayIngredients() {
    IngredientsModel ingredientsModel =
        IngredientsModel.fromJson(addRecipeBloc.parameters['ingredients']);
    List<Widget> list = List<Widget>();
    ingredientsModel.ingredients.forEach((ingredient) => list.add(Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                ingredient.name +
                    ', ' +
                    ingredient.amount.toString() +
                    ' ' +
                    ingredient.measurementType,
                style: TextStyle(
                  color: Colors.green.shade700,
                ),
              ),
            )
          ],
        )));
    return Wrap(
      children: list,
      direction: Axis.vertical,
    );
  }
}
