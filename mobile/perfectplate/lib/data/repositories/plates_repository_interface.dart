import 'package:perfectplate/data/models/ingredients/ingredients.dart';
import 'package:perfectplate/data/models/plates/plates.dart';

abstract class IPlatesRepository {
  Future<int?> insertPlate(RawPlate plate);

  Future<void> insertPlateIngredient(RawPlateIngredient plate);

  Future<List<RawIngredient>?> retrieveAllIngredients();

  Future<List<Plate>?> retrieveAllUserPlates(int userId);
}
