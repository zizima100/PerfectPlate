import 'dart:convert';

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

class Plate {
  final String name;
  final DateTime date;
  final List<PlateIngredient> plateIngredients;

  Plate({
    required this.name,
    required this.date,
    required this.plateIngredients,
  });
}

class PlateIngredient {
  int? ingredientId;
  int? numberOfPortions;

  PlateIngredient({
    this.ingredientId,
    this.numberOfPortions,
  });

  @override
  String toString() =>
      'PlateIngredient(ingredientId: $ingredientId, numberOfPortions: $numberOfPortions)';
}

class RawIngredient {
  final int id;
  final String name;
  final double onePortionWeight;
  final String classification;
  final double energeticValue;
  final double carbohydrate;
  final double protein;
  final double saturatedFat;
  final double totalFat;
  final double transFat;
  final double fibre;
  final double sodium;

  RawIngredient({
    required this.id,
    required this.name,
    required this.onePortionWeight,
    required this.classification,
    required this.energeticValue,
    required this.carbohydrate,
    required this.protein,
    required this.saturatedFat,
    required this.totalFat,
    required this.transFat,
    required this.fibre,
    required this.sodium,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'one_portion_weight': onePortionWeight,
      'classification': classification,
      'energetic_value': energeticValue,
      'carbohydrate': carbohydrate,
      'protein': protein,
      'saturated_fat': saturatedFat,
      'total_fat': totalFat,
      'trans_fat': transFat,
      'fibre': fibre,
      'sodium': sodium,
    };
  }

  factory RawIngredient.fromMap(dynamic map) {
    print('map = $map');
    return RawIngredient(
      id: map['id'],
      name: map['name'].toString(),
      onePortionWeight: double.tryParse(map['one_portion_weight']) ?? 0,
      classification: map['classification'].toString(),
      energeticValue: double.tryParse(map['energetic_value']) ?? 0,
      carbohydrate: double.tryParse(map['carbohydrate']) ?? 0,
      protein: double.tryParse(map['protein']) ?? 0,
      saturatedFat: double.tryParse(map['saturated_fat']) ?? 0,
      totalFat: double.tryParse(map['total_fat']) ?? 0,
      transFat: double.tryParse(map['trans_fat']) ?? 0,
      fibre: double.tryParse(map['fibre']) ?? 0,
      sodium: double.tryParse(map['sodium']) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RawIngredient.fromJson(String source) =>
      RawIngredient.fromMap(json.decode(source));
}

class Ingredient {
  int? id;
  String? name;
  final IngredientClassification? classification;

  Ingredient({
    this.classification,
    this.id,
    this.name,
  });

  @override
  String toString() =>
      'Ingredient(id: $id, name: $name, classification: $classification)';
}

enum IngredientClassification {
  carbohydrate,
  vegetable,
  protein,
}
