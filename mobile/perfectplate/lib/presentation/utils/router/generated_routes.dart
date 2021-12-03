import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:perfectplate/data/models/plates/plates_list.dart';
import 'package:perfectplate/presentation/screens/home/plates_home_screen.dart';
import 'package:perfectplate/presentation/screens/ingredient/choose_ingredient.dart';
import 'package:perfectplate/presentation/screens/nutrition_facts/nutrition_facts_screen.dart';
import 'package:perfectplate/presentation/utils/router/route_arguments.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
import 'package:perfectplate/presentation/screens/auth/auth_page.dart';
import 'package:perfectplate/presentation/screens/home_or_auth/home_or_auth_page.dart';

class PerfectPlateRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const PlatesMainScreen(),
        );
      case Routes.homeOrAuth:
        return MaterialPageRoute(
          builder: (_) => const HomeOrAuth(),
        );
      case Routes.chooseIngredient:
        final args = settings.arguments as IngredientArgument;
        return MaterialPageRoute(
          builder: (_) => ChooseIngredientScreen(
            onIngredinetTap: args.onIngredinetTap, 
            type: args.type, 
          ),
        );
      case Routes.nutritionFacts:
        final args = settings.arguments as NutritionFactsArgument;
        return MaterialPageRoute(
          builder: (_) => NutritionFactsScreen(
            key: ValueKey('nutrition_facts_screen'),
            plate: args.plate,
          )
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
