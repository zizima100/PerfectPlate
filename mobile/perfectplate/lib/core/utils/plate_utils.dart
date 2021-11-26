import 'package:perfectplate/data/models/ingredients/ingredients.dart';

class PlateUtils {
  PlateUtils._();

  static String parseClassificationEnumToTitle(IngredientClassification e) {
    switch (e) {
      case IngredientClassification.carbohydrate:
        return 'Carboidrato';
      case IngredientClassification.vegetable:
        return 'Vegetal';
      case IngredientClassification.protein:
        return 'Proteína';
      default:
        return '';
    }
  }

  static IngredientClassification parseStringEnumToEnum(String e) {
    if (e == IngredientClassification.carbohydrate.toString().split('.')[1]) {
      return IngredientClassification.carbohydrate;
    } else if (e ==
        IngredientClassification.vegetable.toString().split('.')[1]) {
      return IngredientClassification.vegetable;
    } else {
      return IngredientClassification.protein;
    }
  }

  static String parseEnumToString(IngredientClassification e) {
    if (e == IngredientClassification.carbohydrate) {
      return IngredientClassification.carbohydrate.toString().split('.')[1];
    } else if (e == IngredientClassification.vegetable) {
      return IngredientClassification.vegetable.toString().split('.')[1];
    } else {
      return IngredientClassification.protein.toString().split('.')[1];
    }
  }
}
