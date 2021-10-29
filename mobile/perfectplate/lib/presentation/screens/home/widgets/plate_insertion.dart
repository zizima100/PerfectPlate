import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/presentation/utils/widgets/snackbar_utils.dart';
import 'package:sizer/sizer.dart';

import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/screens/home/widgets/ingredients_modal.dart';

class PlateInsertionWidget extends StatefulWidget {
  final List<Ingredient> ingredients;

  const PlateInsertionWidget({
    Key? key,
    required this.ingredients,
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
                    var ingredientKey = ValueKey('plate');
                    setState(() {
                      _ingredientsWidgets.add(
                        IngredientWidget(
                          key: ingredientKey,
                          type: _ingredientType,
                          ingredients: widget.ingredients,
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

class IngredientWidget extends StatefulWidget {
  final Function onDeleteTap;
  final void Function(String) onNumberOfPortionsChanged;
  final void Function(int) onIngredientChanged;
  final IngredientClassification type;
  final List<Ingredient> ingredients;

  const IngredientWidget({
    Key? key,
    required this.onDeleteTap,
    required this.onNumberOfPortionsChanged,
    required this.onIngredientChanged,
    required this.type,
    required this.ingredients,
  }) : super(key: key);

  @override
  _IngredientWidgetState createState() => _IngredientWidgetState();
}

class _IngredientWidgetState extends State<IngredientWidget> {
  String? _nameSelected;
  double? onePortionQuantitySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 9,
                child: Column(
                  children: [
                    Text(
                        PlateUtils.parseClassificationEnumToTitle(widget.type)),
                    GestureDetector(
                      child: _SquareContainer(
                          child: _nameSelected == null
                              ? SizedBox(
                                  width: 4.h,
                                  height: 2.h,
                                )
                              : Text(_nameSelected!)),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return IngredientsModal(
                              ingredients: widget.ingredients,
                              type: widget.type,
                              onIngredinetTap: (int id) {
                                widget.onIngredientChanged(id);
                                var selected = widget.ingredients.firstWhere(
                                    (i) => i.id == id,
                                    orElse: () => Ingredient());

                                print('selected = $selected');
                                setState(() {
                                  _nameSelected = selected.name;
                                  onePortionQuantitySelected =
                                      selected.onePortionQuantity;
                                });
                              },
                            );
                          },
                          useSafeArea: true,
                          barrierDismissible: true,
                        );
                      },
                    ),
                    SizedBox(height: 0.8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Column(
                            children: [
                              Text('Uma porção'),
                              _SquareContainer(
                                  child: Text(
                                      onePortionQuantitySelected?.toString() ??
                                          '')),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Quantidade de porções',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 0.5.h),
                              TextField(
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                                maxLength: 3,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: 3.5.h,
                                    maxWidth: 14.w,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (value) =>
                                    widget.onNumberOfPortionsChanged(value),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade300,
                  ),
                  onPressed: () => widget.onDeleteTap(),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

class _SquareContainer extends StatelessWidget {
  final Widget child;
  const _SquareContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 2.h,
        vertical: 1.w,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.h,
          vertical: 1.4.w,
        ),
        child: child,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
    );
  }
}
