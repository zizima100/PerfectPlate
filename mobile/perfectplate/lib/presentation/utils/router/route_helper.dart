import 'package:flutter/cupertino.dart';

class RouteHelper {
  static Future<void> removeAllAndPushTo(BuildContext context, String route) async {
    await Navigator.of(context).pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
    );
  }
}
