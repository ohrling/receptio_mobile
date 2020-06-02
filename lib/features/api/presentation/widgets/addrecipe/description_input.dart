import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/bloc.dart';

class DescriptionInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DescriptionInputField();
}

class _DescriptionInputField extends State<DescriptionInputField> {
  @override
  Widget build(BuildContext context) {
    final recipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    return SingleChildScrollView(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Text(
                  recipeBloc.parameters['name'],
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  autofocus: true,
                  onSubmitted: nextInput,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Recipe description',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void nextInput(String recipeDescription) {
    final recipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    recipeBloc.add(AddRecipeDescription(description: recipeDescription));
  }
}
