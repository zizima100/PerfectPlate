import 'package:flutter/material.dart';

class SnackBarUtils {
  final BuildContext _context;
  const SnackBarUtils(this._context);

  void showSnackBarError(String message) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade100,
        duration: Duration(milliseconds: 1500),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.red.shade900,
          ),
        ),
      ),
    );
  }

  void showSnackBarSuccess(String message) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade100,
        duration: Duration(milliseconds: 1500),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.green.shade900,
          ),
        ),
      ),
    );
  }
}
