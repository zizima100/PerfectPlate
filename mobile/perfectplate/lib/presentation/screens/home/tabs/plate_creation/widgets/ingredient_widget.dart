import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/presentation/utils/router/route_arguments.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
import 'package:sizer/sizer.dart';

class IngredientWidget extends StatefulWidget {
  final Function onDeleteTap;
  final void Function(String) onNumberOfPortionsChanged;
  final void Function(int) onIngredientChanged;
  final IngredientClassification type;

  const IngredientWidget({
    Key? key,
    required this.onDeleteTap,
    required this.onNumberOfPortionsChanged,
    required this.onIngredientChanged,
    required this.type,
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
                        await Navigator.of(context).pushNamed(
                          Routes.chooseIngredient,
                          arguments: IngredientArgument(
                            onIngredinetTap: (Ingredient selected) {
                              print('selected = $selected');
                              setState(() {
                                _nameSelected = selected.name;
                                onePortionQuantitySelected =
                                    selected.onePortionQuantity;
                              });
                              widget.onIngredientChanged(selected.id!);
                            }, 
                            type: widget.type,
                          ),
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