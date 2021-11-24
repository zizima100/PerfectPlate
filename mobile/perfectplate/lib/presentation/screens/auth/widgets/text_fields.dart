import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  final String textFieldKey;
  final String hintText;
  final Function(String) onChanged;
  final int maxLenght;

  const NumberTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.maxLenght,
    required this.textFieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        key: ValueKey(textFieldKey),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          counterText: '',
        ),
        maxLength: 5,
        keyboardType: TextInputType.number,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
