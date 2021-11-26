import 'dart:convert';

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

  @override
  String toString() {
    return 'RawIngredient(id: $id, name: $name, onePortionWeight: $onePortionWeight, classification: $classification, energeticValue: $energeticValue, carbohydrate: $carbohydrate, protein: $protein, saturatedFat: $saturatedFat, totalFat: $totalFat, transFat: $transFat, fibre: $fibre, sodium: $sodium)';
  }
}

class IngredientDAO {
  int? id;
  String? name;
  final IngredientClassification? classification;
  final double? onePortionQuantity;

  IngredientDAO({
    this.classification,
    this.id,
    this.name,
    this.onePortionQuantity,
  });

  @override
  String toString() =>
      'Ingredient(id: $id, name: $name, classification: $classification)';
}

class Ingredient {
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
  final int numberOfPortions;

  Ingredient({
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
    required this.numberOfPortions,
  });

  factory Ingredient.fromRaw(RawIngredient raw, int numberOfPortions) {
    return Ingredient(
      id: raw.id,
      name: raw.name,
      onePortionWeight: raw.onePortionWeight,
      classification: raw.classification,
      energeticValue: raw.energeticValue,
      carbohydrate: raw.carbohydrate,
      protein: raw.protein,
      saturatedFat: raw.saturatedFat,
      totalFat: raw.totalFat,
      transFat: raw.transFat,
      fibre: raw.fibre,
      sodium: raw.sodium,
      numberOfPortions: numberOfPortions,
    );
  }

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, onePortionWeight: $onePortionWeight, classification: $classification, energeticValue: $energeticValue, carbohydrate: $carbohydrate, protein: $protein, saturatedFat: $saturatedFat, totalFat: $totalFat, transFat: $transFat, fibre: $fibre, sodium: $sodium, numberOfPortions: $numberOfPortions)';
  }
}

enum IngredientClassification {
  carbohydrate,
  vegetable,
  protein,
}
