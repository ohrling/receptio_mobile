import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/displayrecipe/bloc.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:receptio/injection.dart';

class RecipeNameSearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  RecipeNameSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisplayRecipeBloc>(
      create: (BuildContext context) =>
          getIt.get(instanceName: 'DisplayRecipeBloc'),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: <Widget>[
            Text(
              'Recipe Name',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: TextStyle(fontSize: 20, color: Colors.black),
                controller: controller,
                onSubmitted: (_) => submitRecipeSearch(context),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search for a recipe by name',
                  contentPadding: EdgeInsets.only(left: 10),
                  filled: true,
                  fillColor: Colors.white70,
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
      ),
    );
  }

  void submitRecipeSearch(context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    BlocProvider.of<DisplayRecipeBloc>(context).add(
      GetRecipesByString(
          searchString: controller.text, accessToken: authBloc.accessToken),
    );
  }
}
