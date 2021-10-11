import 'package:perfectplate/data/data_provider/authentication_api_provider.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';

class AuthenticationRespository {
  final AuthenticationApiProvider _provider = AuthenticationApiProvider();

  Future<void> singupUser(SingUpUser user) async {
    String responseBody = await _provider.signup(user);
  }

  Future<void> loginUser(LoginUser user) async {
    String responseBody = await _provider.login(user);
  }
}
