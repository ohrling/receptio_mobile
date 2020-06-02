import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/bloc.dart';

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
                Icon(
                  Icons.access_time,
                  size: 15,
                  color: Colors.white,
                ),
                Text(
                  addRecipeBloc.parameters['cookingTime'].toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                filled: true,
                fillColor: Colors.white70,
                hintText: 'Servings',
                hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green.shade500,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSubmitted: nextInput,
            ),
          ),
        ],
      ),
    );
  }

  void nextInput(String servings) {
    final addRecipeBloc = BlocProvider.of<AddRecipeBloc>(context);
    addRecipeBloc.add(AddRecipeServings(servings: int.parse(servings)));
  }
}
