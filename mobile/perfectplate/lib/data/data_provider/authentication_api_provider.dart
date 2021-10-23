import 'package:http/http.dart' as http;
import 'package:perfectplate/core/constants/apis_constants.dart';

class AuthenticationApiProvider {
  final http.Client _client = http.Client();
  late String _user;

  Future<String> signup(String user) async {
    _user = user;
    return await _authenticateUser('/users/signup');
  }

  Future<String> login(String user) async {
    _user = user;
    return await _authenticateUser('/users/login');
  }

  Future<String> _authenticateUser(String route) async {
    final response = await _client.post(
      Uri.parse(ApisHosts.meals + route),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _user,
    );

    return response.body;
  }
}
