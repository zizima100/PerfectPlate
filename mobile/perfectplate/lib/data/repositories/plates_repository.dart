import 'dart:convert';
import 'package:perfectplate/data/data_provider/plates_api_provider.dart';
import 'package:perfectplate/data/models/plates/plates.dart';

class PlatesRepository {
  final PlatesApiProvider _provider = PlatesApiProvider();

  Future<int?> insertPlate(RawPlate plate) async {
    String body = await _provider.insertPlate(plate.toJson());
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if (bodyDecoded['ok']) {
      return bodyDecoded['data'];
    }
  }

  Future<void> insertPlateIngredient(RawPlateIngredient plate) async {
    String body = await _provider.insertPlateIngredient(plate.toJson());
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if (bodyDecoded['ok']) {
      return bodyDecoded['data'];
    }
  }

  Future<List<RawIngredient>?> retrieveAllIngredients() async {
    String body = await _provider.retrieveAllIngredients();
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if (bodyDecoded['ok']) {
      var data = bodyDecoded['data'];
      List<RawIngredient> ingredients = [];
      for (var i in data) {
        ingredients.add(RawIngredient.fromMap(i));
      }
      print('ingredients= $ingredients');
      return ingredients;
    }
  }
}
