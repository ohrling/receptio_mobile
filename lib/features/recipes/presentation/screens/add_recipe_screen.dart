import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/bloc/addrecipe/bloc.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/addrecipe/add_input_widgets.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/displayrecipes/recipe_detail.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/message_display.dart';
import 'package:receptio_mobile/injection.dart';

enum RecipeInputs {
  name,
  description,
  cookingTime,
  servings,
  ingredients,
  instructions
}

class AddRecipeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ),
        textTheme: TextTheme(headline: TextStyle(color: Colors.white)),
      ),
      body: BlocProvider(
        create: (BuildContext context) => AddRecipeBloc(
          getIt.get(instanceName: 'PostRecipe'),
          getIt.get(instanceName: 'GetIngredients'),
          getIt.get(instanceName: 'GetMeasurements'),
        ),
        child: AddRecipeScreenChild(),
      ),
    );
  }
}

class AddRecipeScreenChild extends StatelessWidget {
  const AddRecipeScreenChild({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: BlocListener(
        bloc: BlocProvider.of<AddRecipeBloc>(context),
        listener: (BuildContext context, AddRecipeState state) {
          if (state is AddRecipeInitial) {
            print('AddRecipeInitial loaded');
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<AddRecipeBloc>(context),
          builder: (BuildContext context, AddRecipeState state) {
            // TODO: Should I make this a switch?
            print(state.toString());
            if (state is AddRecipeInitial) {
              return buildInput(RecipeInputs.name);
            } else if (state is AddDescription) {
              return buildInput(RecipeInputs.description);
            } else if (state is AddCookingTime) {
              return buildInput(RecipeInputs.cookingTime);
            } else if (state is AddServings) {
              return buildInput(RecipeInputs.servings);
            } else if (state is Loading) {
              return CircularProgressIndicator();
            } else if (state is AddIngredients) {
              return buildInput(RecipeInputs.ingredients);
            } else if (state is AddInstructions) {
              return buildInput(RecipeInputs.instructions);
            } else if (state is AddRecipeDone) {
              return RecipeDetail(recipe: state.result);
            } else if (state is PostingRecipe) {
              return CircularProgressIndicator();
            } else if (state is AddRecipeDone) {
              Navigator.pushNamed(context, '/recipeDetail', arguments: state);
            }
            return MessageDisplay(
              message: (state as Error).errorMessage,
            );
          },
        ),
      ),
    );
  }

  Widget buildInput(RecipeInputs inputs) {
    switch (inputs) {
      case RecipeInputs.name:
        return Center(child: NameInputField());
      case RecipeInputs.description:
        return Center(child: DescriptionInputField());
      case RecipeInputs.cookingTime:
        return Center(child: CookingTimeInputField());
      case RecipeInputs.servings:
        return Center(child: ServingsInputField());
      case RecipeInputs.ingredients:
        return Center(child: IngredientsInputField());
      case RecipeInputs.instructions:
        return Center(child: InstructionsInputField());
    }
    return Center(child: NameInputField());
  }
}
