import 'package:flutter/foundation.dart';

import 'package:perfectplate/data/models/plates/plates.dart';

@immutable
abstract class RouteArguments {}

class IngredientArgument extends RouteArguments {
  final Function(Ingredient) onIngredinetTap;
  final IngredientClassification type;
  
  IngredientArgument({
    required this.onIngredinetTap,
    required this.type,
  });
}
