import 'package:flutter/material.dart';
import 'package:perfectplate/data/models/ingredients/ingredients.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:sizer/sizer.dart';

class NutritionFactsScreen extends StatelessWidget {
  final Plate plate;

  const NutritionFactsScreen({ 
    Key? key,
    required this.plate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Ingredient> ingredients = plate.ingredients;
    double energeticValue = 0;
    for(var i in ingredients) {
      energeticValue += i.energeticValue;
    }
    double carbohydrate = 0;
    for(var i in ingredients) {
      carbohydrate += i.carbohydrate;
    }
    double fibre = 0;
    for(var i in ingredients) {
      fibre += i.fibre;
    }
    double protein = 0;
    for(var i in ingredients) {
      protein += i.protein;
    }
    double saturatedFat = 0;
    for(var i in ingredients) {
      saturatedFat += i.saturatedFat;
    }
    double sodium = 0;
    for(var i in ingredients) {
      sodium += i.sodium;
    }
    double totalFat = 0;
    for(var i in ingredients) {
      totalFat += i.totalFat;
    }
    double transFat = 0;
    for(var i in ingredients) {
      transFat += i.transFat;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela Nutricional do Prato'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Text(plate.name)
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(2.5.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Quantidade por Porção (g)',
                  ),
                ),
                SizedBox(height: 1.5.w),
                _InfoRow(
                  title: 'Valor Energético',
                  value: energeticValue.toString(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2.w),
                    topRight: Radius.circular(2.w),
                  ),
                ),
                _InfoRow(
                  title: 'Carboidratos',
                  value: carbohydrate.toString(),
                ),
                _InfoRow(
                  title: 'Proteínas',
                  value: protein.toString(),
                ),
                _InfoRow(
                  title: 'Gorduras Totais',
                  value: totalFat.toString(),
                ),
                _InfoRow(
                  title: 'Gorduras Saturadas',
                  value: saturatedFat.toString(),
                ),
                _InfoRow(
                  title: 'Gorduras Trans',
                  value: transFat.toString(),
                ),
                _InfoRow(
                  title: 'Fibra Alimentar',
                  value: fibre.toString(),
                ),
                _InfoRow(
                  title: 'Sódio',
                  value: sodium.toString(),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2.w),
                    bottomRight: Radius.circular(2.w),
                  ),
                ),
              ],
            )
          )
        ],
      )
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final BorderRadiusGeometry? borderRadius;

  const _InfoRow({ 
    Key? key,
    required this.title,
    required this.value,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: borderRadius,
      ),
      child: Container(
        padding: EdgeInsets.all(1.5.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
            ),
            Text(
              value,
            )
          ],
        ),
      ),
    );
  }
}