import 'package:http/http.dart' as http;
import 'package:perfectplate/core/constants/apis_constants.dart';

class PlatesApiProvider {
  final http.Client _client = http.Client();
  String _route = '';

  Future<String> insertPlate(String plate) async {
    _route = '/plates/plate/insert';
    return await _insert(plate);
  }

  Future<String> insertPlateIngredient(String plateIngredient) async {
    _route = '/plates/ingredient/insert';
    return await _insert(plateIngredient);
  }

  Future<String> _insert(String plate) async {
    final response = await _client.post(
      Uri.parse(ApisHosts.meals + _route),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: plate,
    );

    print('response = ${response.body}');

    return response.body;
  }
}
