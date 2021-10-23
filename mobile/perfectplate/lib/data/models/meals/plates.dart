import 'dart:convert';

class Plate {
  final int userId;
  final String name;
  final DateTime date;

  Plate(this.userId, this.name, this.date);

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  factory Plate.fromMap(Map<String, dynamic> map) {
    return Plate(
      map['user_id'],
      map['name'],
      DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Plate.fromJson(String source) => Plate.fromMap(json.decode(source));
}
