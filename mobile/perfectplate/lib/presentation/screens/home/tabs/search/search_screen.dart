import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/data/models/plates/plates_list.dart';
import 'package:perfectplate/presentation/screens/home/tabs/widgets/text_field.dart';
import 'package:perfectplate/presentation/utils/router/route_arguments.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Plate> platesResult;
  late TextEditingController controller;
  late bool mostRecent;
  late bool older;

  void _onSearch(String keyword) {
    print('keyword = $keyword');
    keyword = _formatKeywordSearched(keyword);
    if (keyword.isEmpty) {
      return;
    }
    List<Plate> plates = GetIt.I<PlatesList>().plates.where((plate) {
      String name = plate.name.toLowerCase();
      return name.contains(keyword);
    }).toList();

    if (plates.isNotEmpty) {
      plates = _sortPlatesAsc(plates);
      setState(() {
        platesResult = plates;
      });
    } else {
      setState(() {
        platesResult.clear();
      });
    }
  }

  String _formatKeywordSearched(String keyword) {
    keyword = keyword.trim();
    keyword = keyword.toLowerCase();
    return keyword;
  }

  List<Plate> _sortPlatesAsc(List<Plate> plates) {
    plates.sort((b, a) => a.date.compareTo(b.date));
    return plates;
  }

  List<Plate> _sortPlatesDesc(List<Plate> plates) {
    plates.sort((a, b) => a.date.compareTo(b.date));
    return plates;
  }

  @override
  void initState() {
    controller = TextEditingController();
    platesResult = [];
    mostRecent = true;
    older = false;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(2.h),
          child: PerfectPlateTextField(
            autofocus: false,
            hintText: 'Pesquise um prato pelo nome',
            onSubmitted: _onSearch,
            inputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: () => _onSearch(controller.text),
              icon: Icon(Icons.search),
            ),
            controller: controller,
          ),
        ),
        if (platesResult.length > 1)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      mostRecent = !mostRecent;
                      older = !older;
                    });
                    _sortPlatesAsc(platesResult);
                  },
                  child: _OrderButton(
                    text: 'Mais recentes',
                    isSelected: mostRecent,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      mostRecent = !mostRecent;
                      older = !older;
                    });
                    _sortPlatesDesc(platesResult);
                  },
                  child: _OrderButton(
                    text: 'Mais antigos',
                    isSelected: older,
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: platesResult.length,
            itemBuilder: (context, index) {
              return _PlateItem(plate: platesResult[index]);
            },
          ),
        )
      ],
    );
  }
}

class _OrderButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _OrderButton({
    Key? key,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: isSelected ? Colors.green.shade200 : Colors.grey.shade200,
          border: Border.all(
            color: isSelected ? Colors.green.shade200 : Colors.grey.shade600,
          )),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class _PlateItem extends StatelessWidget {
  final Plate plate;

  const _PlateItem({
    Key? key,
    required this.plate,
  }) : super(key: key);

  String _formatDate() {
    DateTime dateTime = plate.date;
    String dateStr = DateFormat('dd/MM/yyyy').format(dateTime);
    return dateStr;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.nutritionFacts,
            arguments: NutritionFactsArgument(plate),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 2.w,
            horizontal: 1.5.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plate.name.toString(),
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                _formatDate(),
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ));
  }
}
