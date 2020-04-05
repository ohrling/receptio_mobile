import 'package:better_uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/getrecipe/domain/entities/recipe.dart';
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
                    // This is what should be displayed:
                    /*return MessageDisplay(
                      message: 'Hämta recept!',
                    );*/
                    return RecipeDisplay(
                      recipe: Recipe(
                        id: Uuid('d290f1ee-6c54-4b01-90e6-d701748f0851'),
                        name: 'Chicago Deep-dish Pizza',
                        description:
                            'Classic chicago deep dish pizza with lots of pepperoni!',
                        cookingTime: 90,
                        servings: 4,
                        instructions:
                            'Buy dough, roll out, add (in order) cheese, pepperoni, tomato sauce. Top with parmesan cheese and cook in 200C for 30 minutes. Let cool down and eat before anyone asks for a taste.',
                        ingredients: [
                          {
                            "id": "766c510a-4218-4686-86d2-259b8e172ebb",
                            "name": "Cheese",
                            "measurementType": "grams",
                            "image": "/",
                            "amount": 200
                          },
                          {
                            "id": "766c510a-4218-4686-86d2-259b8e172eba",
                            "name": "Ham",
                            "measurementType": "grams",
                            "image": "/",
                            "amount": 100
                          }
                        ],
                        image: '/images/pizza.jpg',
                        source: 'John Doe',
                      ),
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
