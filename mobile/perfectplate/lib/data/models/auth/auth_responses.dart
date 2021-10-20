import 'dart:convert';

class AuthUserResponse {
  final String message;
  final String date;
  final int userId;

  AuthUserResponse({
    required this.message,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'date': date,
      'userId': userId,
    };
  }

  factory AuthUserResponse.fromMap(Map map) {
    return AuthUserResponse(
      message: map['message'],
      date: map['date'],
      userId: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUserResponse.fromJson(String source) => AuthUserResponse.fromMap(json.decode(source));
}
