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
      onePortionWeight: raw.onePortionWeight * numberOfPortions,
      classification: raw.classification * numberOfPortions,
      energeticValue: raw.energeticValue * numberOfPortions,
      carbohydrate: raw.carbohydrate * numberOfPortions,
      protein: raw.protein * numberOfPortions,
      saturatedFat: raw.saturatedFat * numberOfPortions,
      totalFat: raw.totalFat * numberOfPortions,
      transFat: raw.transFat * numberOfPortions,
      fibre: raw.fibre * numberOfPortions,
      sodium: raw.sodium * numberOfPortions,
      numberOfPortions: numberOfPortions,
    );
  }

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, onePortionWeight: $onePortionWeight, classification: $classification, energeticValue: $energeticValue, carbohydrate: $carbohydrate, protein: $protein, saturatedFat: $saturatedFat, totalFat: $totalFat, transFat: $transFat, fibre: $fibre, sodium: $sodium, numberOfPortions: $numberOfPortions)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'onePortionWeight': onePortionWeight,
      'classification': classification,
      'energeticValue': energeticValue,
      'carbohydrate': carbohydrate,
      'protein': protein,
      'saturatedFat': saturatedFat,
      'totalFat': totalFat,
      'transFat': transFat,
      'fibre': fibre,
      'sodium': sodium,
      'numberOfPortions': numberOfPortions,
    };
  }

  factory Ingredient.fromMap(Map map) {
    return Ingredient(
      id: int.parse(map['ingredient_id']),
      name: map['name'].toString(),
      onePortionWeight: double.parse(map['one_portion_weight']),
      classification: map['classification'].toString(),
      energeticValue: double.parse(map['energetic_value']),
      carbohydrate: double.parse(map['carbohydrate']),
      protein: double.parse(map['protein']),
      saturatedFat: double.parse(map['saturated_fat']),
      totalFat: double.parse(map['total_fat']),
      transFat: double.parse(map['trans_fat']),
      fibre: double.parse(map['fibre']),
      sodium: double.parse(map['sodium']),
      numberOfPortions: int.parse(map['number_of_portions']),
    );
  }
}

enum IngredientClassification {
  carbohydrate,
  vegetable,
  protein,
}
