import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/presentation/screens/home/tabs/plate_creation/widgets/ingredient_widget.dart';
import 'package:perfectplate/presentation/utils/widgets/snackbar_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';

class PlateInsertionWidget extends StatefulWidget {
  const PlateInsertionWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PlateInsertionWidgetState createState() => _PlateInsertionWidgetState();
}

class _PlateInsertionWidgetState extends State<PlateInsertionWidget> {
  late TextEditingController _placeNameController;
  late ScrollController _scrollController;
  late String _plateName;
  late List<Widget> _ingredientsWidgets;
  late int _platesCount;
  late List<PlateIngredient> _plateIngredients;
  late IngredientClassification _ingredientType;

  @override
  void initState() {
    _placeNameController = TextEditingController();
    _scrollController = ScrollController();
    _plateName = '';
    _ingredientsWidgets = [];
    _platesCount = 0;
    _plateIngredients = [];
    _ingredientType = IngredientClassification.carbohydrate;
    super.initState();
  }

  @override
  void dispose() {
    _placeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlatesBloc, PlatesState>(
      listener: (context, state) {
        if (state is PlatesInserted) {
          SnackBarUtils(context)
              .showSnackBarSuccess(SuccessMessagesConstants.plateInserted);
          _placeNameController.clear();
          setState(() {
            _ingredientsWidgets.clear();
            _plateIngredients.clear();
            _plateName = '';
            _platesCount = 0;
          });
        }
        if (state is PlatesInsertionFail) {
          SnackBarUtils(context)
              .showSnackBarError(ErrorMessagesConstants.plateInsertionFail);
        }
        if (state is PlatesNameEmpty) {
          SnackBarUtils(context)
              .showSnackBarError(ErrorMessagesConstants.plateNameIsEmpty);
        }
        if (state is PlateIngredientsEmpty) {
          SnackBarUtils(context).showSnackBarError(
              ErrorMessagesConstants.plateIngredientsIsEmpty);
        }
        if (state is NumberOfPortionsEmpty) {
          SnackBarUtils(context)
              .showSnackBarError(ErrorMessagesConstants.numberOfPortionsEmpty);
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.h),
              child: TextField(
                autofocus: false,
                style: TextStyle(
                  fontSize: 13.sp,
                ),
                controller: _placeNameController,
                decoration: InputDecoration(
                  hintText: 'Digite o nome do seu prato',
                  border: InputBorder.none,
                  counterText: '',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                onChanged: (value) {
                  _plateName = value;
                },
              ),
            ),
            Column(
              children: [
                ..._ingredientsWidgets,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<IngredientClassification>(
                  value: _ingredientType,
                  onChanged: (value) {
                    setState(() {
                      _ingredientType =
                          value ?? IngredientClassification.carbohydrate;
                    });
                  },
                  items: IngredientClassification.values.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                          PlateUtils.parseClassificationEnumToTitle(value)),
                    );
                  }).toList(),
                ),
                IconButton(
                  onPressed: () async {
                    await _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      _platesCount++;
                    });
                    var ingredient = PlateIngredient();
                    _plateIngredients.add(ingredient);
                    var ingredientKey = ValueKey('plate_$_platesCount');
                    setState(() {
                      _ingredientsWidgets.add(
                        IngredientWidget(
                          key: ingredientKey,
                          type: _ingredientType,
                          onDeleteTap: () {
                            setState(
                              () => _ingredientsWidgets.removeWhere(
                                (i) {
                                  return i.key == ingredientKey;
                                },
                              ),
                            );
                            _plateIngredients.remove(ingredient);
                          },
                          onNumberOfPortionsChanged: (value) {
                            ingredient.numberOfPortions =
                                int.tryParse(value) ?? 0;
                          },
                          onIngredientChanged: (int id) {
                            ingredient.ingredientId = id;
                          },
                        ),
                      );
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            BlocBuilder<PlatesBloc, PlatesState>(
              builder: (context, state) {
                return ElevatedButton(
                  child: state is PlateInsertionLoading 
                    ? SizedBox(
                      height: 2.5.h,
                      width: 2.5.h,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    )
                    : Text('Registrar'),
                  onPressed: () async {
                    BlocProvider.of<PlatesBloc>(context).add(
                      PlateInsertedEvent(
                        Plate(
                          date: DateTime.now(),
                          name: _plateName,
                          plateIngredients: _plateIngredients,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
