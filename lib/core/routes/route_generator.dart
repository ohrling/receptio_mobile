import 'package:flutter/material.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_ingredients_search_screen.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_list.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_name_search_screen.dart';
import 'package:receptio/features/api/presentation/widgets/message_display.dart';
import 'package:receptio/features/auth/presentation/screens/login_screen.dart';
import 'package:receptio/features/api/domain/entities/recipe.dart';
import 'package:receptio/features/api/presentation/screens/add_recipe_screen.dart';
import 'package:receptio/features/api/presentation/screens/recipe_screen.dart';
import 'package:receptio/features/api/presentation/widgets/displayrecipes/recipe_detail.dart';
import 'package:receptio/user_screen.dart';

import '../../welcome_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        );
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/addRecipe':
        return MaterialPageRoute(
            builder: (context) => AddRecipeScreen(accessToken: args));
      case '/recipeSearch':
        return MaterialPageRoute(
            builder: (context) => RecipeScreen(
                  accessToken: args,
                ));
      case '/recipeList':
        return MaterialPageRoute(
            builder: (context) => RecipeList(recipes: args));
      case '/recipeDetail':
        if (args is Recipe) {
          return MaterialPageRoute(
              builder: (_) => RecipeDetail(
                    recipe: args,
                  ));
        }
        return _errorRoute();
      case '/authScreen':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/userScreen':
        return MaterialPageRoute(
          builder: (_) => UserScreen(
            authBloc: args,
          ),
        );
      case '/message':
        return MaterialPageRoute(
          builder: (context) => MessageDisplay(
            message: args,
          ),
        );
      case '/recipeNameSearch':
        return MaterialPageRoute(
          builder: (context) => RecipeNameSearchScreen(),
        );
      case '/recipeIngredientsSearch':
        return MaterialPageRoute(
          builder: (context) => RecipeIngredientsSearchScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text('Sorry, couldn\'t provide what you wished for.'),
        ),
      );
    });
  }
}
