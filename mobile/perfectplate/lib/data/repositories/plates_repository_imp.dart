import 'dart:convert';
import 'package:perfectplate/data/data_provider/plates_api_provider.dart';
import 'package:perfectplate/data/models/ingredients/ingredients.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/data/repositories/plates_repository_interface.dart';

class PlatesRepository implements IPlatesRepository {
  final PlatesApiProvider _provider = PlatesApiProvider();

  @override
  Future<int?> insertPlate(RawPlate plate) async {
    String body = await _provider.insertPlate(plate.toJson());
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if (bodyDecoded['ok']) {
      return bodyDecoded['data'];
    }
  }

  @override
  Future<void> insertPlateIngredient(RawPlateIngredient plate) async {
    String body = await _provider.insertPlateIngredient(plate.toJson());
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if (bodyDecoded['ok']) {
      return bodyDecoded['data'];
    }
  }

  @override
  Future<List<RawIngredient>?> retrieveAllIngredients() async {
    String body = await _provider.retrieveAllIngredients();
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if (bodyDecoded['ok']) {
      var data = bodyDecoded['data'];
      List<RawIngredient> ingredients = [];
      for (var i in data) {
        ingredients.add(RawIngredient.fromMap(i));
      }
      return ingredients;
    }
  }

  @override
  Future<List<Plate>?> retrieveAllUserPlates(int userId) async {
    print('retrieveAllUserPlates repository');
    String body = await _provider.retrieveAllUserPlates(userId);
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if (bodyDecoded['ok']) {
      var platesData = bodyDecoded['data'];
      List<Plate> plates = [];
      for (var plate in platesData) {
        print('plate = $plate');
        plates.add(Plate.fromMap(plate));
      }
      print('plates in retrieveAllUserPlates = $plates');
      return plates;
    }
  }
}
