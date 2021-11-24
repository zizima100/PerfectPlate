import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:sizer/sizer.dart';

class ChooseIngredientScreen extends StatelessWidget {
  final Function(Ingredient) onIngredinetTap;
  final IngredientClassification type;

  const ChooseIngredientScreen({
    Key? key,
    required this.onIngredinetTap,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PlateUtils.parseClassificationEnumToTitle(type)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Ingredient>>(
        future: BlocProvider.of<PlatesBloc>(context).retrieveAllIngredients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Ocorreu um erro :('));
          }
          List<Ingredient> ingredientsFiltered =
              snapshot.data!.where((i) => i.classification == type).toList();
          print('ingredientsFiltered = $ingredientsFiltered');
          return ListView.builder(
            itemCount: ingredientsFiltered.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onIngredinetTap(ingredientsFiltered[index]);
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).highlightColor,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white38,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(1.2.h),
                  child: Padding(
                    padding: EdgeInsets.all(1.5.h),
                    child: Text(
                      ingredientsFiltered[index].name!,
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    )
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}