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
  String email;
  String password;
  String name;
  String age;
  String sex;
  String weight;
  String height;
  String userType;

  SingUpUser({
    this.email = '',
    this.password = '',
    this.name = '',
    this.age = '',
    this.sex = '',
    this.weight = '',
    this.height = '',
    this.userType = '',
  });

  SingUpUser copyWith({
    String? email,
    String? password,
    String? name,
    String? age,
    String? sex,
    String? weight,
    String? height,
    String? userType,
  }) {
    return SingUpUser(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'age': age,
      'sex': sex,
      'weight': weight,
      'height': height,
      'userType': userType,
    };
  }

  factory SingUpUser.fromMap(Map<String, dynamic> map) {
    return SingUpUser(
      email: map['email'],
      password: map['password'],
      name: map['name'],
      age: map['age'],
      sex: map['sex'],
      weight: map['weight'],
      height: map['height'],
      userType: map['userType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SingUpUser.fromJson(String source) => SingUpUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SingUpUser(email: $email, password: $password, name: $name, age: $age, sex: $sex, weight: $weight, height: $height, userType: $userType)';
  }
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

enum UserType {
  bodybuilder,
  nutritionist,
  defaultUser,
}
