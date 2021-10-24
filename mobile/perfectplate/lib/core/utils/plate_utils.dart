import 'package:perfectplate/data/models/plates/plates.dart';

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
}
