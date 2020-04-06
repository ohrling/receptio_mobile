import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/getrecipe/presentation/bloc/bloc.dart';
import 'package:receptio_mobile/features/getrecipe/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.keyboard_arrow_left),
            Row(
              children: <Widget>[
                Icon(
                  Icons.restaurant_menu,
                ),
                Text(
                  'Receptio',
                ),
              ],
            ),
            Icon(Icons.menu),
          ],
        ),
        textTheme: TextTheme(title: TextStyle(color: Colors.white)),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<RecipeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<RecipeBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              // Top half
              BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Hämta recept!',
                    );
                  } else if (state is Loading) {
                    return LoadingDisplay();
                  } else if (state is Loaded) {
                    return RecipeDisplay(
                      recipe: state.recipe,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.errorMessage,
                    );
                  } else {
                    return MessageDisplay(
                      message: '',
                    );
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              // Bottom half
              RecipeControlsWidget()
            ],
          ),
        ),
      ),
    );
  }
}
