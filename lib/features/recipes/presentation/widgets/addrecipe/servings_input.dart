import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/bloc.dart';

class ServingsInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServingsInputField();
}

class _ServingsInputField extends State<ServingsInputField> {
  @override
  Widget build(BuildContext context) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
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
          ),
          TextField(
            autofocus: true,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Servings',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
            onSubmitted: nextInput,
          ),
        ],
      ),
    );
  }

  // TODO: Do some realtime validation
  void nextInput(String servings) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    print(servings);
    addRecipeBloc.add(AddRecipeServings(servings: int.parse(servings)));
  }
}
// TODO: if there will be more inputs in the same widget

/*
Row(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: TextField(
                  controller: _cookingTime,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _cookingTimeFocus,
                  decoration: InputDecoration(
                    hintText: 'Cooking time',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onSubmitted: (term) {
                    _fieldFocusChange(context, _cookingTimeFocus, _servingsFocus);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 9,
                child: TextField(
                  controller: _servings,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _servingsFocus,
                  decoration: InputDecoration(
                    hintText: 'Servings',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onSubmitted: (term) {
                    _fieldFocusChange(context, _servingsFocus, _next);
                  },
                ),
              ),
            ],
          ),
*/
