import 'package:http/http.dart' as http;
import 'package:perfectplate/core/constants/apis_constants.dart';

class MealsApiProvider {
  final http.Client _client = http.Client();

  Future<String> insertPlate(String plate) async {
    final response = await _client.post(
      Uri.parse(ApisHosts.meals + '/plates/plate/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: plate,
    );

    print('response = ${response.body}');

    return response.body;
  }
}
