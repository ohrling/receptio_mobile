import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/displayrecipe/bloc.dart';

import '../../../../../injection.dart';

class RecipeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisplayRecipeBloc>(
      create: (BuildContext context) =>
          getIt.get(instanceName: 'DisplayRecipeBloc'),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Select method:',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  color: Colors.green.shade500,
                  textColor: Colors.white,
                  elevation: 7,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Search recipes by name',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () => context
                      .bloc<DisplayRecipeBloc>()
                      .add(DisplayNameSearch()),
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  color: Colors.green.shade500,
                  textColor: Colors.white,
                  elevation: 7,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Search recipes by ingredients',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () => context
                      .bloc<DisplayRecipeBloc>()
                      .add(DisplayIngredientsSearch()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
