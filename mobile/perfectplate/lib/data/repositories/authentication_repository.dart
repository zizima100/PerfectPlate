import 'dart:convert';

import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/data/data_provider/authentication_api_provider.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/data/models/auth/auth_responses.dart';
import 'package:perfectplate/data/models/auth/user_response.dart';

class AuthenticationRespository {
  final AuthenticationApiProvider _provider = AuthenticationApiProvider();

  Future<int> singupUser(SingUpUser user) async {
    UserReponse response = await _provider.signup(user.toJson());
    if (response.statusCode == 401) {
      throw EmailAlreadyExists();
    }
    return AuthUserResponse.fromJson(response.body).userId;
  }

  Future<int> loginUser(LoginUser user) async {
    UserReponse response = await _provider.login(user.toJson());
    if (response.statusCode == 401) {
      throw UserNotFoundException();
    }
    return AuthUserResponse.fromJson(response.body).userId;
  }
}
