import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/bloc.dart';

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
                Text(
                  recipeBloc.parameters['name'],
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  recipeBloc.parameters['description'],
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ),
          TextField(
            autofocus: true,
            onSubmitted: nextInput,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Cooking time',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Do some realtime validation
  void nextInput(String cookingTime) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    addRecipeBloc
        .add(AddRecipeCookingTime(cookingTime: int.parse(cookingTime)));
  }
}
