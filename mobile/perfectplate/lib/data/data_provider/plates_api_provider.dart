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

  Future<String> retrieveAllIngredients() async {
    final response = await _client.get(
      Uri.parse(ApisHosts.meals + '/ingredients/query_all'),
    );

    print('response = ${response.body}');

    return response.body;
  }

  Future<String> retrieveAllUserPlates(int userId) async {
    print('retrieveAllUserPlates');
    final response = await _client.get(
      Uri.parse(ApisHosts.meals + '/plates/query_all?user_id=$userId'),
    );

    print('response = ${response.body}');

    return response.body;
  }
}
