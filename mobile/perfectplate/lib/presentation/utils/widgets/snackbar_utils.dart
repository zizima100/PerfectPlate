import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SnackBarUtils {
  final BuildContext _context;
  late Color _backgroundColor;
  late Color _textColor;
  late String _message;

  SnackBarUtils(this._context);

  void showSnackBarError(String message) {
    _backgroundColor = Colors.red.shade100;
    _textColor = Colors.red.shade900;
    _message = message;
    _showSnackBar();
  }

  void showSnackBarSuccess(String message) {
    _backgroundColor = Colors.green.shade100;
    _textColor = Colors.green.shade900;
    _message = message;
    _showSnackBar();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(milliseconds: 1500),
        padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 4.5.w),
        content: Container(
          decoration: BoxDecoration(
            color: _backgroundColor,
            boxShadow: const [
              BoxShadow(
                color: Color(0x19000000),
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: Offset(2, 4),
              )
            ],
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          child: Padding(
            padding: EdgeInsets.all(1.5.h),
            child: Text(
              _message,
              style: TextStyle(
                color: _textColor,
              ),
            )
          )
        ),
      )
    );
  }
}