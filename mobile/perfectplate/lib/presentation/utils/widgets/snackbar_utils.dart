import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SnackBarUtils {
  late BuildContext _context;
  late Color _backgroundColor;
  late Color _textColor;
  late String _message;
  late double _verticalPadding;
  late double _horizontalPadding;
  late int _milliseconds;
  PerfectPlateSnackBarAction? _action;

  SnackBarUtils._();

  SnackBarUtils.auth(this._context) {
    _verticalPadding = 3.h;
    _horizontalPadding = 2.w;
  }
  SnackBarUtils.home(this._context) {
    _verticalPadding = 11.h;
    _horizontalPadding = 4.5;
  }

  void showSnackBarError(String message) {
    _backgroundColor = Colors.red.shade100;
    _textColor = Colors.red.shade900;
    _message = message;
    _showSnackBar();
  }

  void showSnackBarSuccess(
    String message, {
      PerfectPlateSnackBarAction? action
    }
  ) {
    _backgroundColor = Colors.green.shade100;
    _textColor = Colors.green.shade900;
    _message = message;
    _action = action;
    _showSnackBar();
  }

  void _showSnackBar() {
    _action == null ? _milliseconds = 1500 : _milliseconds = 3500;
    
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(milliseconds: _milliseconds),
        padding: EdgeInsets.symmetric(
          vertical: _verticalPadding, 
          horizontal: _horizontalPadding,
        ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _message,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: _textColor,
                  ),
                ),
                if(_action != null)
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(_context).hideCurrentSnackBar();
                      _action!.onTap();
                    },
                    child: Text(
                      _action!.message,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            )
          ),
        ),
      ),
    );
  }
}

class PerfectPlateSnackBarAction {
  final VoidCallback onTap;
  final String message;

  PerfectPlateSnackBarAction({
    required this.onTap, 
    required this.message
  });
}