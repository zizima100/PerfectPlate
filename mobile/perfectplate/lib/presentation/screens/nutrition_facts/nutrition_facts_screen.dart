import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    String _formatValue(double value) {
      return value.toStringAsFixed(2);
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
          Container(
            padding: EdgeInsets.all(5.w),
            child: Text(
              plate.name,
              style: TextStyle(
                fontSize: 17.5.sp,
                fontWeight: FontWeight.w700,
                color: Colors.green.shade800,
                shadows: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 2.0,
                    blurRadius: 8.0,
                    offset: Offset(2, 4),
                  ),
                ],
              )
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Data de registro do prato:',
                  style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 1.8.w),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green.shade700,
                    width: 0.35.w,
                  ),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 2.5.w,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 1.5.w,
                  vertical: 1.5.w
                ),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(plate.date),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.5.w
            ),
            child: Divider(
              height: 3.5.h,
              color: Colors.grey.shade500,
            ),
          ),
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
                  value: _formatValue(energeticValue),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2.w),
                    topRight: Radius.circular(2.w),
                  ),
                ),
                _InfoRow(
                  title: 'Carboidratos',
                  value: _formatValue(carbohydrate),
                ),
                _InfoRow(
                  title: 'Proteínas',
                  value: _formatValue(protein),
                ),
                _InfoRow(
                  title: 'Gorduras Totais',
                  value: _formatValue(totalFat),
                ),
                _InfoRow(
                  title: 'Gorduras Saturadas',
                  value: _formatValue(saturatedFat),
                ),
                _InfoRow(
                  title: 'Gorduras Trans',
                  value: _formatValue(transFat),
                ),
                _InfoRow(
                  title: 'Fibra Alimentar',
                  value: _formatValue(fibre),
                ),
                _InfoRow(
                  title: 'Sódio',
                  value: _formatValue(sodium),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2.w),
                    bottomRight: Radius.circular(2.w),
                  ),
                ),
              ],
            )
          ),
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