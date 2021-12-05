import 'dart:convert';

import 'package:perfectplate/data/models/ingredients/ingredients.dart';

class RawPlate {
  final int userId;
  final String name;
  final DateTime date;

  RawPlate({
    required this.userId,
    required this.name,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  factory RawPlate.fromMap(Map<String, dynamic> map) {
    return RawPlate(
      userId: map['user_id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RawPlate.fromJson(String source) =>
      RawPlate.fromMap(json.decode(source));
}

class RawPlateIngredient {
  final int ingredientId;
  final int plateId;
  final int numberOfPortions;

  const RawPlateIngredient({
    required this.ingredientId,
    required this.plateId,
    required this.numberOfPortions,
  });

  Map<String, dynamic> toMap() {
    return {
      'ingredient_id': ingredientId,
      'plate_id': plateId,
      'number_of_portions': numberOfPortions,
    };
  }

  factory RawPlateIngredient.fromMap(Map<String, dynamic> map) {
    return RawPlateIngredient(
      ingredientId: map['ingredient_id'],
      plateId: map['plate_id'],
      numberOfPortions: map['number_of_portions'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RawPlateIngredient.fromJson(String source) =>
      RawPlateIngredient.fromMap(json.decode(source));
}

class PlateDAO {
  final String name;
  final DateTime date;
  final List<PlateIngredientDAO> plateIngredients;

  PlateDAO({
    required this.name,
    required this.date,
    required this.plateIngredients,
  });
}

class PlateIngredientDAO {
  int? ingredientId;
  int? numberOfPortions;

  PlateIngredientDAO({
    this.ingredientId,
    this.numberOfPortions,
  });

  @override
  String toString() =>
      'PlateIngredient(ingredientId: $ingredientId, numberOfPortions: $numberOfPortions)';
}

class Plate {
  final String name;
  final DateTime date;
  final List<Ingredient> ingredients;

  Plate({
    required this.name, 
    required this.date, 
    required this.ingredients
  }); 

  @override
  String toString() => 'Plate(name: $name, date: $date, ingredients: $ingredients)';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
    };
  }

  factory Plate.fromMap(Map<String, dynamic> map) {
    print("DateTime.parse(map['date']) = ${DateTime.parse(map['date'])}");
    return Plate(
      name: map['name'],
      date: DateTime.parse(map['date']),
      ingredients: List<Ingredient>.from(map['ingredients']?.map(
        (x) => Ingredient.fromMap(x, map['number_of_portions'])
      )),
    );
  }
}
