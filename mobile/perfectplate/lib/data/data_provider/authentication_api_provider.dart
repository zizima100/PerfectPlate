import 'package:http/http.dart' as http;
import 'package:perfectplate/data/models/auth/auth_models.dart';

class AuthenticationApiProvider {
  final http.Client _client = http.Client();

  Future<String> signup(SingUpUser user) async {
    // TODO: -> Converter result de String para AuthResponse
    final response = await _client.post(
      Uri.parse(''),
      body: user.toJson(),
    );

    return response.body;
  }

  Future<String> login(LoginUser user) async {
    final response = await _client.post(
      Uri.parse(''),
      body: user.toJson(),
    );

    return response.body;
  }
}
