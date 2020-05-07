import 'package:flutter/material.dart';
import 'package:receptio_mobile/features/recipes/domain/entities/recipe.dart';
import 'package:receptio_mobile/features/recipes/presentation/screens/add_recipe_screen.dart';
import 'package:receptio_mobile/features/recipes/presentation/screens/recipe_screen.dart';
import 'package:receptio_mobile/welcome_screen.dart';
import 'package:receptio_mobile/features/recipes/presentation/widgets/displayrecipes/recipe_detail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/addRecipe':
        return MaterialPageRoute(
            builder: (_) =>
                AddRecipeScreen()); //TODO: Can I pass the parameters from the BLoC through the routingsystem so that history is made possible?
      case '/recipeSearch':
        return MaterialPageRoute(builder: (_) => RecipeScreen());
      case '/recipeDetail':
        if (args is Recipe) {
          return MaterialPageRoute(
              builder: (_) => RecipeDetail(
                    recipe: args,
                  ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
