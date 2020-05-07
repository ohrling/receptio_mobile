import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/bloc.dart';

class DescriptionInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DescriptionInputField();
}

class _DescriptionInputField extends State<DescriptionInputField> {
  @override
  Widget build(BuildContext context) {
    final recipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          Text(
            recipeBloc.parameters['name'],
            style: TextStyle(
              fontSize: 30,
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            autofocus: true,
            onSubmitted: nextInput,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: 'Recipe Description',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  void nextInput(String recipeDescription) {
    final recipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    print(recipeBloc);
    recipeBloc.add(AddRecipeDescription(description: recipeDescription));
    print(recipeBloc.parameters);
  }
}
