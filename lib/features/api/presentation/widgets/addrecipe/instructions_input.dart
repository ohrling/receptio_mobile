import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/bloc.dart';

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
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      addRecipeBloc.parameters['description'],
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            addRecipeBloc.parameters['cookingTime'].toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.restaurant_menu,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            addRecipeBloc.parameters['servings'].toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.all(8.0),
                children: <Widget>[
                  _displayIngredients(),
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
                contentPadding: EdgeInsets.only(left: 10),
                filled: true,
                fillColor: Colors.white70,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green.shade500,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
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
    List<Widget> list = List<Widget>();
    addRecipeBloc.parameters['ingredients']
        .forEach((ingredient) => list.add(Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    ingredient['name'],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
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
