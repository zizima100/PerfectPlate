import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/data/models/ingredients/ingredients.dart';
import 'package:perfectplate/data/models/plates/plates_list.dart';
import 'package:perfectplate/presentation/screens/home/tabs/plate_creation/widgets/ingredient_widget.dart';
import 'package:perfectplate/presentation/screens/home/tabs/widgets/text_field.dart';
import 'package:perfectplate/presentation/utils/router/route_arguments.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
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
  late List<PlateIngredientDAO> _plateIngredients;
  late IngredientClassification _ingredientType;
  late DateTime _date;

  @override
  void initState() {
    _placeNameController = TextEditingController();
    _scrollController = ScrollController();
    _plateName = '';
    _ingredientsWidgets = [];
    _platesCount = 0;
    _plateIngredients = [];
    _ingredientType = IngredientClassification.carbohydrate;
    _date = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _placeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oneYear = Duration(days: 365);
    final now = DateTime.now();

    return BlocListener<PlatesBloc, PlatesState>(
      listener: (context, state) {
        if (state is PlatesInserted) {
          FocusScope.of(context).unfocus();
          SnackBarUtils.home(context).showSnackBarSuccess(
            SuccessMessagesConstants.plateInserted,
            action: PerfectPlateSnackBarAction(
              onTap: () => Navigator.of(context).pushNamed(
                Routes.nutritionFacts,
                arguments: NutritionFactsArgument(GetIt.I<PlatesList>().last),
              ), 
              message: 'Ver Tabela Nutricional'
            ),
          );
          _placeNameController.clear();
          setState(() {
            _ingredientsWidgets.clear();
            _plateIngredients.clear();
            _plateName = '';
            _platesCount = 0;
            _date = DateTime.now(); 
          });
        }
        if (state is PlatesInsertionFail) {
          SnackBarUtils.home(context)
              .showSnackBarError(ErrorMessagesConstants.plateInsertionFail);
        }
        if (state is PlatesNameEmpty) {
          SnackBarUtils.home(context)
              .showSnackBarError(ErrorMessagesConstants.plateNameIsEmpty);
        }
        if (state is PlateIngredientsEmpty) {
          SnackBarUtils.home(context).showSnackBarError(
              ErrorMessagesConstants.plateIngredientsIsEmpty);
        }
        if (state is NumberOfPortionsEmpty) {
          SnackBarUtils.home(context)
              .showSnackBarError(ErrorMessagesConstants.numberOfPortionsEmpty);
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.h),
              child: PerfectPlateTextField(
                autofocus: false,
                controller: _placeNameController,
                hintText: 'Digite o nome do seu prato',
                onChanged: (value) {
                  _plateName = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.h,
                vertical: 1.5.h,
              ),
              child: Row(
                children: [
                  Text(
                    'Data de consumo',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(width: 1.5.w),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context, 
                        initialDate: _date,
                        firstDate: now.subtract(oneYear), 
                        lastDate: now.add(oneYear),
                      );
                      if(picked != null && picked != _date) {
                        setState(() {
                          _date = picked;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5.w),
                        border: Border.all(
                          color: Colors.green,
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.5.w),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_date),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
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
                    var ingredient = PlateIngredientDAO();
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
                        PlateDAO(
                          date: _date,
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
