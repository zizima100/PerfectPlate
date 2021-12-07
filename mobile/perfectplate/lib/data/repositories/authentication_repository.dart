import 'dart:convert';
import 'package:perfectplate/core/constants/apis_constants.dart';
import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/data/data_provider/authentication_api_provider.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';

class AuthenticationRepository {
  final AuthenticationApiProvider _provider = AuthenticationApiProvider();

  Future<int?> singupUser(SingUpUser user) async {
    String body = await _provider.signup(user.toJson());
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if(bodyDecoded['ok']) {
      return bodyDecoded['data'];
    }
    if (bodyDecoded['message'] == ApiResponseMessages.emailAlreadyExists) {
      throw EmailAlreadyExists();
    }
  }

  Future<Map?> loginUser(LoginUser user) async {
    String body = await _provider.login(user.toJson());
    Map<String, dynamic> bodyDecoded = json.decode(body);
    if(bodyDecoded['ok']) {
      return bodyDecoded['data'];
    }
    if (bodyDecoded['message'] == ApiResponseMessages.userUnfound) {
      throw UserNotFoundException();
    }
  }
}
