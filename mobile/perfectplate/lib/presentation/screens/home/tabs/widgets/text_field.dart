import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PerfectPlateTextField extends StatelessWidget {
  final String hintText;
  final bool autofocus;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final Widget? suffixIcon;

  const PerfectPlateTextField({
    Key? key,
    required this.hintText, 
    required this.autofocus,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.inputAction,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      style: TextStyle(
        fontSize: 13.sp,
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
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
        suffixIcon: suffixIcon,
      ),
      textInputAction: inputAction,
      onChanged: (value) {
        if(onChanged != null) {
          onChanged!(value);
        }
      },
      onSubmitted: (value) {
        if(onSubmitted != null) {
          onSubmitted!(value);
        }
      },
    );
  }
}
