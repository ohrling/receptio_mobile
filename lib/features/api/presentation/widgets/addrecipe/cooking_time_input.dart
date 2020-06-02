import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/bloc.dart';

class CookingTimeInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CookingTimeInputField();
}

class _CookingTimeInputField extends State<CookingTimeInputField> {
  @override
  Widget build(BuildContext context) {
    final recipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    recipeBloc.parameters['name'],
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    recipeBloc.parameters['description'],
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextField(
              autofocus: true,
              onSubmitted: nextInput,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                filled: true,
                fillColor: Colors.white70,
                hintText: 'Cooking time',
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
          ),
        ],
      ),
    );
  }

  void nextInput(String cookingTime) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    addRecipeBloc
        .add(AddRecipeCookingTime(cookingTime: int.parse(cookingTime)));
  }
}
