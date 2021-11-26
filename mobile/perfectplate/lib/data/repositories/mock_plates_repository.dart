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
        energeticValue: 0,
        carbohydrate: 0,
        protein: 0,
        saturatedFat: 0,
        totalFat: 0,
        transFat: 0,
        fibre: 0,
        sodium: 0,
      ),
      RawIngredient(
        id: 2,
        name: 'Feijão',
        onePortionWeight: 200,
        classification: PlateUtils.parseEnumToString(
            IngredientClassification.carbohydrate),
        energeticValue: 0,
        carbohydrate: 0,
        protein: 0,
        saturatedFat: 0,
        totalFat: 0,
        transFat: 0,
        fibre: 0,
        sodium: 0,
      ),
      RawIngredient(
        id: 3,
        name: 'Frango',
        onePortionWeight: 200,
        classification: PlateUtils.parseEnumToString(
            IngredientClassification.protein),
        energeticValue: 0,
        carbohydrate: 0,
        protein: 0,
        saturatedFat: 0,
        totalFat: 0,
        transFat: 0,
        fibre: 0,
        sodium: 0,
      ),
    ];
  }
}
