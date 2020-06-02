import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:receptio/features/api/presentation/bloc/addrecipe/bloc.dart';
import 'package:receptio/features/api/presentation/widgets/addrecipe/add_input_widgets.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_detail.dart';
import 'package:receptio/features/api/presentation/widgets/message_display.dart';
import 'package:receptio/injection.dart';

enum RecipeInputs {
  name,
  description,
  cookingTime,
  servings,
  ingredients,
  instructions
}

class AddRecipeScreen extends StatefulWidget {
  final accessToken;

  const AddRecipeScreen({Key key, @required this.accessToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/food-background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xffedfdf0).withOpacity(0.4), BlendMode.exclusion),
          ),
        ),
        child: BlocProvider(
          create: (BuildContext context) => AddRecipeBloc(
            context.bloc<AuthBloc>(),
            getIt.get(instanceName: 'PostRecipe'),
          ),
          child: AddRecipeScreenChild(),
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: BlocListener(
        bloc: BlocProvider.of<AddRecipeBloc>(context),
        listener: (BuildContext context, AddRecipeState state) {},
        child: BlocBuilder(
          bloc: BlocProvider.of<AddRecipeBloc>(context),
          builder: (BuildContext context, AddRecipeState state) {
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
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is AddRecipeDone) {
              Navigator.pop(context);
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
