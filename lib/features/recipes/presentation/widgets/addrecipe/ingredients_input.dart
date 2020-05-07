import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:receptio_mobile/features/recipes/data/models/ingredient_model.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/ingredient.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/bloc.dart';

class IngredientsInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IngredientsInputField();
}

class _IngredientsInputField extends State<IngredientsInputField> {
  List<Ingredient> choosenIngredients = [];
  TextEditingController _ingredient = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _measurement = TextEditingController();
  IngredientModel tempIngredient = null;

  @override
  Widget build(BuildContext context) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
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
                ],
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.only(top: 10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // TODO: should be able to remove a choosen ingredient
                return GestureDetector(
                  onTap: () {
                    choosenIngredients.removeAt(index);
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
                              choosenIngredients[index].name,
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
                              choosenIngredients[index].amount.toString() +
                                  ' ' +
                                  choosenIngredients[index].measurementType,
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
              itemCount: choosenIngredients.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                childAspectRatio: 2,
              ),
            ),
            TypeAheadField(
              keepSuggestionsOnSuggestionSelected: false,
              textFieldConfiguration: TextFieldConfiguration(
                controller: _ingredient,
                enabled: tempIngredient == null,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Choose ingredient',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              suggestionsCallback: (pattern) async {
                addRecipeBloc.add(GetIngredientsSuggestion(input: pattern));
                return addRecipeBloc.ingredientMatches;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text((suggestion as Ingredient).name),
                );
              },
              onSuggestionSelected: (suggestion) {
                tempIngredient = suggestion;
                print(tempIngredient.toString());
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _amount,
              decoration: InputDecoration(
                hintText: 'Amount',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                textInputAction: TextInputAction.go,
                controller: _measurement,
                decoration: InputDecoration(
                  hintText: 'Measurement',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              suggestionsCallback: (pattern) async {
                addRecipeBloc.add(GetMeasurementSuggestion(input: pattern));
                return addRecipeBloc.measurementsMatches;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.toString()),
                );
              },
              onSuggestionSelected: (suggestion) {
                tempIngredient.measurementType = suggestion;
                tempIngredient.amount = double.parse(_amount.text);
                choosenIngredients.add(tempIngredient);
                _amount.clear();
                _ingredient.clear();
                _measurement.clear();
                tempIngredient = null;
                setState(() {});
              },
            ),
            RaisedButton(
              disabledColor: Colors.grey.shade400,
              child: Text('Done'),
              onPressed: (choosenIngredients.length < 1)
                  ? null
                  : () => nextInput(choosenIngredients),
            )
          ],
        ),
      ],
    );
  }

  void nextInput(List<Ingredient> ingredients) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    addRecipeBloc.add(AddRecipeIngredients(ingredients: ingredients));
  }
}
