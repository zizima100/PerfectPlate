import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IngredientsModal extends StatelessWidget {
  final Function(int) onIngredinetTap;

  const IngredientsModal({
    Key? key,
    required this.onIngredinetTap,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 8,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      onIngredinetTap(1);
                      Navigator.of(context).pop();
                    },
                    title: Text('Arroz'),
                  );
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
