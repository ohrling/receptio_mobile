import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/displayrecipe/bloc.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:receptio/injection.dart';

class RecipeIngredientsSearchScreen extends StatefulWidget {
  @override
  _RecipeIngredientsSearchScreenState createState() =>
      _RecipeIngredientsSearchScreenState();
}

class _RecipeIngredientsSearchScreenState
    extends State<RecipeIngredientsSearchScreen> {
  List<String> chosenIngredients = [];
  TextEditingController _ingredient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisplayRecipeBloc>(
      create: (BuildContext context) =>
          getIt.get(instanceName: 'DisplayRecipeBloc'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text(
              'Search by ingredients',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
              child: _displayChosenIngredients(),
            ),
            _addIngredients(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              child: RaisedButton(
                onPressed: () => search(),
                elevation: 10,
                color: Colors.green.shade500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  search() {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    context.bloc<DisplayRecipeBloc>().add(GetRecipesByIngredients(
        searchValues: chosenIngredients, accessToken: authBloc.accessToken));
  }

  TextField _addIngredients() {
    return TextField(
      onSubmitted: (_) => addIngredient(),
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.text,
      controller: _ingredient,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Type ingredient',
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
    );
  }

  void addIngredient() {
    chosenIngredients.add(_ingredient.text);
    _ingredient.clear();
    setState(() {});
  }

  GridView _displayChosenIngredients() {
    return GridView.builder(
      padding: EdgeInsets.only(top: 10),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            chosenIngredients.removeAt(index);
            setState(() {});
          },
          child: Text(
            chosenIngredients[index],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        );
      },
      itemCount: chosenIngredients.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
        childAspectRatio: 2,
      ),
    );
  }
}
