import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:perfectplate/data/models/plates/plates.dart';

class IngredientsModal extends StatelessWidget {
  final Function(int) onIngredinetTap;
  final List<Ingredient> ingredients;
  final IngredientClassification type;

  const IngredientsModal({
    Key? key,
    required this.onIngredinetTap,
    required this.ingredients,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingredientsFiltered =
        ingredients.where((i) => i.classification == type).toList();

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.h,
          vertical: 9.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 8,
              child: ListView.builder(
                itemCount: ingredientsFiltered.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ingredientsFiltered[index].name!),
                    onTap: () {
                      onIngredinetTap(ingredientsFiltered[index].id!);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(1.5.h),
                child: ElevatedButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
