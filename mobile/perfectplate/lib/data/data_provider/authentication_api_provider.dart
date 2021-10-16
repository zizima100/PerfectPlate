import 'package:http/http.dart' as http;
import 'package:perfectplate/data/models/auth/user_response.dart';

class AuthenticationApiProvider {
  final http.Client _client = http.Client();
  late String _user;

  static const String host = 'https://perfect-plate.herokuapp.com';

  Future<UserReponse> signup(String user) async {
    _user = user;
    return await _authenticateUser('/users/signup');
  }

  Future<UserReponse> login(String user) async {
    _user = user;
    return await _authenticateUser('/users/login');
  }

  Future<UserReponse> _authenticateUser(String route) async {
    final response = await _client.post(
      Uri.parse(host + route),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _user,
    );

    return UserReponse(response.statusCode, response.body);
  }
}
