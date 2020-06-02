import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/bloc.dart';

class IngredientsInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IngredientsInputField();
}

class _IngredientsInputField extends State<IngredientsInputField> {
  var chosenIngredients = [];
  TextEditingController _ingredient = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _measurement = TextEditingController();
  var tempIngredient = {};

  @override
  Widget build(BuildContext context) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    FocusNode amount = FocusNode();
    FocusNode measurements = FocusNode();
    return Wrap(
      children: <Widget>[
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30),
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
                                addRecipeBloc.parameters['cookingTime']
                                    .toString(),
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
              ],
            ),
            GridView.builder(
              padding: EdgeInsets.only(top: 10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    chosenIngredients.removeAt(index);
                    setState(() {});
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 60,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green.shade700,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              chosenIngredients[index]['name'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              chosenIngredients[index]['amount'].toString() +
                                  ' ' +
                                  chosenIngredients[index]['measurementType'],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: chosenIngredients.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                childAspectRatio: 2,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _ingredient,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(amount),
                    decoration: InputDecoration(
                      hintText: 'Choose ingredient',
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Colors.white70,
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 150,
                        child: TextField(
                          focusNode: amount,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(measurements),
                          controller: _amount,
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            contentPadding: EdgeInsets.only(left: 10),
                            filled: true,
                            fillColor: Colors.white70,
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.black54),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green.shade500,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 210,
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          controller: _measurement,
                          focusNode: measurements,
                          decoration: InputDecoration(
                            hintText: 'Measurement',
                            contentPadding: EdgeInsets.only(left: 10),
                            filled: true,
                            fillColor: Colors.white70,
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.black54),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green.shade500,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () => addIngredient(),
            ),
            RaisedButton(
              disabledColor: Colors.grey.shade400,
              child: Text('Done'),
              onPressed: () => nextInput(chosenIngredients),
            )
          ],
        ),
      ],
    );
  }

  addIngredient() {
    Map<String, dynamic> newIngredient = {
      'name': _ingredient.text,
      'measurementType': _measurement.text,
      'amount': _amount.text
    };
    chosenIngredients.add(newIngredient);
    _amount.clear();
    _ingredient.clear();
    _measurement.clear();
    setState(() {});
  }

  void nextInput(ingredients) {
    if (ingredients.isEmpty) {
      return null;
    } else {
      final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
      addRecipeBloc.add(AddRecipeIngredients(ingredients: ingredients));
    }
  }
}
