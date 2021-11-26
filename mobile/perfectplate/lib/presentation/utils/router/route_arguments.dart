import 'package:flutter/foundation.dart';
import 'package:perfectplate/data/models/ingredients/ingredients.dart';

@immutable
abstract class RouteArguments {}

class IngredientArgument extends RouteArguments {
  final Function(IngredientDAO) onIngredinetTap;
  final IngredientClassification type;
  
  IngredientArgument({
    required this.onIngredinetTap,
    required this.type,
  });
}
