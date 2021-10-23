import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';

class PlateInsertionWidget extends StatefulWidget {
  const PlateInsertionWidget({Key? key}) : super(key: key);

  @override
  _PlateInsertionWidgetState createState() => _PlateInsertionWidgetState();
}

class _PlateInsertionWidgetState extends State<PlateInsertionWidget> {
  late TextEditingController _placeNameController;
  late ScrollController _scrollController;
  late String _plateName;
  late List<Widget> _ingredientsWidgets;

  @override
  void initState() {
    _placeNameController = TextEditingController();
    _scrollController = ScrollController();
    _plateName = '';
    _ingredientsWidgets = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          TextField(
            controller: _placeNameController,
            decoration: InputDecoration(hintText: 'Digite aqui o que comeu'),
            onChanged: (value) {
              _plateName = value;
            },
          ),
          Column(
            children: [
              ..._ingredientsWidgets,
            ],
          ),
          Row(
            children: [
              DropdownButton(
                items: const <DropdownMenuItem<dynamic>>[
                  DropdownMenuItem(child: Text('Carboidrato'),),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _ingredientsWidgets.add(
                      IngredientWidget(
                        type: 'Carboidratos',
                        name: 'Arroz',
                        onePortionQuantity: 200,
                      ),
                    );
                  });
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          ElevatedButton(
            child: Text('Inserir'),
            onPressed: () {
              print('plateName = $_plateName');
              // BlocProvider.of<PlatesBloc>(context)
              //     .add(PlateInsertionStartedEvent(name: _plateName));
            },
          )
        ],
      ),
    );
  }
}

class IngredientWidget extends StatefulWidget {
  final String type;
  final String name;
  final double onePortionQuantity;

  const IngredientWidget({
    Key? key,
    required this.type,
    required this.name,
    required this.onePortionQuantity,
  }) : super(key: key);

  @override
  _IngredientWidgetState createState() => _IngredientWidgetState();
}

class _IngredientWidgetState extends State<IngredientWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          Text(widget.type),
          _SquareContainer(child: Text(widget.name)),
          SizedBox(height: 0.8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 6,
                child: Column(
                  children: [
                    Text('Uma porção'),
                    _SquareContainer(child: Text(widget.onePortionQuantity.toString())),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Quantidade de porções'),
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
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        constraints: BoxConstraints(
                          maxHeight: 3.5.h,
                          maxWidth: 14.w,
                        )
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ],
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
