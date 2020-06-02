import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/bloc.dart';

class NameInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NameInputField();
}

class _NameInputField extends State<NameInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(fontSize: 14, color: Colors.black),
        autofocus: true,
        onSubmitted: nextInput,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          hintText: 'Recipe name',
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
    );
  }

  void nextInput(String recipeName) {
    final recipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    recipeBloc.add(AddRecipeName(name: recipeName));
  }
}
