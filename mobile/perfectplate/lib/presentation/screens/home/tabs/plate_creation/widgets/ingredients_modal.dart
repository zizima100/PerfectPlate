import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/data/models/ingredients/ingredients.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:perfectplate/data/models/plates/plates.dart';

class IngredientsModal extends StatelessWidget {
  final Function(IngredientDAO) onIngredinetTap;
  final IngredientClassification type;

  const IngredientsModal({
    Key? key,
    required this.onIngredinetTap,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder<List<IngredientDAO>>(
          future: BlocProvider.of<PlatesBloc>(context).retrieveAllIngredients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text('Ocorreu um erro :('));
            }
            List<IngredientDAO> ingredientsFiltered =
                snapshot.data!.where((i) => i.classification == type).toList();
            return Column(
              mainAxisSize: MainAxisSize.min,
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
                          onIngredinetTap(ingredientsFiltered[index]);
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
            );
          },
        ),
      ),
    );
  }
}
