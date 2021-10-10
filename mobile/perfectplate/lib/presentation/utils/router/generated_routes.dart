import 'package:flutter/material.dart';
import 'package:perfectplate/presentation/router/routes.dart';
import 'package:perfectplate/presentation/screens/auth/auth_page.dart';
import 'package:perfectplate/presentation/screens/home/home_page.dart';

class PerfectPlateRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
