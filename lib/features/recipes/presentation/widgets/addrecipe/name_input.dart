import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/bloc.dart';

class NameInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NameInputField();
}

class _NameInputField extends State<NameInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        autofocus: true,
        onSubmitted: nextInput,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          hintText: 'Recipe name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  void nextInput(String recipeName) {
    final recipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    recipeBloc.add(AddRecipeName(name: recipeName));
  }
}
