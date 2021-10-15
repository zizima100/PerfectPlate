import 'dart:convert';

import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/data/data_provider/authentication_api_provider.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';

class AuthenticationRespository {
  final AuthenticationApiProvider _provider = AuthenticationApiProvider();

  Future<void> singupUser(SingUpUser user) async {
    String responseBody = await _provider.signup(user.toJson());
  }

  Future<void> loginUser(LoginUser user) async {
    String responseBody = await _provider.login(user.toJson());
    var decodedResponse = json.decode(responseBody);

    if (decodedResponse['status'] == '401') {
      throw UserNotFoundException();
    }
  }
}
