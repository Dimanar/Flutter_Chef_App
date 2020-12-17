import 'package:flutter/material.dart';
import 'package:master_chef/model/item_recipe.dart';
import 'package:master_chef/ui/screens/description_screen.dart';
import 'package:master_chef/ui/screens/recipes_screen.dart';
import 'package:master_chef/ui/screens/splash_creen.dart';
import 'package:master_chef/ui/screens/home_screen.dart';
import 'package:master_chef/ui/components/appbar.dart';
import 'package:master_chef/resources/constants.dart';


class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/description':
        if (args is ItemRecipe) {
          return MaterialPageRoute(
              builder: (_) => RecipesScreen(dishes: args)
          );
        }
        return _errorRoute();
      case '/recipes':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => RecipesByTypeScreen(type: args)
          );
        }
        return _errorRoute();
      // default:
      //   return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: buildAppBar(title: AppErrors.simpleError),
        body: Center(
          child: Text(
            AppErrors.simpleError
          ),
        ),
      );
    }
    );
  }

}