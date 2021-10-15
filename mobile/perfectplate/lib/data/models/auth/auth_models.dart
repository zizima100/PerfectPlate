import 'dart:convert';

class AuthMode {
  final Mode _mode;

  AuthMode(this._mode);

  bool isLogin() {
    return _mode == Mode.login;
  }

  bool isSignup() {
    return _mode == Mode.signup;
  }

  AuthMode switchMode() {
    return isLogin() ? AuthMode(Mode.signup) : AuthMode(Mode.login);
  }
}

enum Mode { login, signup }

class SingUpUser {
  final String username;
  final String email;
  final String password;

  SingUpUser(this.username, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory SingUpUser.fromMap(Map<String, dynamic> map) {
    return SingUpUser(
      map['username'],
      map['email'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SingUpUser.fromJson(String source) => SingUpUser.fromMap(json.decode(source));
}

class LoginUser {
  final String email;
  final String password;

  LoginUser(this.email, this.password);

  Map<String, String> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginUser.fromMap(Map<String, dynamic> map) {
    return LoginUser(
      map['email'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUser.fromJson(String source) => LoginUser.fromMap(json.decode(source));
}
