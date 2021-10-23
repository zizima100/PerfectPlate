import 'dart:convert';
import 'package:perfectplate/data/data_provider/meals_api_provider.dart';
import 'package:perfectplate/data/models/meals/plates.dart';

class MealsRepository {
  final MealsApiProvider _provider = MealsApiProvider();

  Future<int?> insertPlate(Plate plate) async {
    String body = await _provider.insertPlate(plate.toJson());
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if(bodyDecoded['ok']) {
      return bodyDecoded['data'];
    }
  }
}
