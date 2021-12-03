import 'dart:math';

import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/data/models/ingredients/ingredients.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/data/repositories/plates_repository_interface.dart';

class MockPlatesRepository implements IPlatesRepository {
  @override
  Future<int?> insertPlate(RawPlate plate) async {
    return Random().nextInt(10);
  }

  @override
  Future<void> insertPlateIngredient(RawPlateIngredient plate) async {
    // ignore: avoid_print
    print('plate = $plate');
  }

  @override
  Future<List<RawIngredient>?> retrieveAllIngredients() async {
    return [
      RawIngredient(
        id: 1,
        name: 'Arroz Mockado',
        onePortionWeight: 200,
        classification: PlateUtils.parseEnumToString(
            IngredientClassification.carbohydrate),
        energeticValue: 1,
        carbohydrate: 1,
        protein: 1,
        saturatedFat: 1,
        totalFat: 1,
        transFat: 1,
        fibre: 1,
        sodium: 1,
      ),
      RawIngredient(
        id: 2,
        name: 'Feijão',
        onePortionWeight: 200,
        classification: PlateUtils.parseEnumToString(
            IngredientClassification.carbohydrate),
        energeticValue: 4,
        carbohydrate: 4,
        protein: 4,
        saturatedFat: 4,
        totalFat: 4,
        transFat: 4,
        fibre: 4,
        sodium: 4,
      ),
      RawIngredient(
        id: 3,
        name: 'Frango',
        onePortionWeight: 200,
        classification: PlateUtils.parseEnumToString(
            IngredientClassification.protein),
        energeticValue: 2,
        carbohydrate: 2,
        protein: 2,
        saturatedFat: 2,
        totalFat: 2,
        transFat: 2,
        fibre: 2,
        sodium: 2,
      ),
    ];
  }
}
